#!/usr/bin/env python3

import argparse
import subprocess
import os
import sys
import tempfile

# ANSI escape codes for colors
COL_YELLOW = '\033[93m'
COL_RED = '\033[91m'
COL_GREEN = '\033[92m'
COL_RESET = '\033[0m'

# Text styling using ANSI escape sequences
BOLD = '\033[1m'
NORMAL = '\033[0m'

# set-me-up paths
smu_home_dir = os.getenv("SMU_HOME_DIR", os.path.join(os.path.expanduser("~"), "set-me-up"))
module_path = os.path.join(smu_home_dir, ".dotfiles/modules")

# 'set-me-up' installer scripts
installer_path = os.path.join(smu_home_dir, "set-me-up-installer")
installer_scripts_path = os.path.join(installer_path, "scripts")

# rcm configuration file path
rcrc = os.path.join(smu_home_dir, ".dotfiles/rcrc")

# Determine if OS is MacOS
macOS = sys.platform == "darwin"

# Determine if OS is Linux
linux = sys.platform.startswith("linux")

# Determine if OS is debian-based
debian = linux and os.path.exists("/etc/debian_version")

def warn(message):
    print(f"{COL_YELLOW}[warning]{COL_RESET} {message}")

def success(message):
    print(f"{COL_GREEN}[success]{COL_RESET} {message}")

def action(message):
    print(f"{COL_YELLOW}[action]{COL_RESET} ⇒ {message}")

def die(message, exit_code=1):
    print(f"{COL_RED}[error]{COL_RESET} {message}", file=sys.stderr)
    sys.exit(exit_code)

def list_symlinks():
    os.environ["RCRC"] = rcrc

    subprocess.run(f"lsrc -v -d {os.path.join(smu_home_dir, '.dotfiles')}", shell=True)

def symlink():
    os.environ["RCRC"] = rcrc

    subprocess.run(f"rcup -v -f -d {os.path.join(smu_home_dir, '.dotfiles')}", shell=True)

def remove_symlinks():
    os.environ["RCRC"] = rcrc

    subprocess.run(f"rcdn -v -d {os.path.join(smu_home_dir, '.dotfiles')}", shell=True)

def create_boot_disk():
    # Execute create boot disk script
    script_path = os.path.join(installer_scripts_path, "create_boot_disk/create_boot_disk.sh")
    subprocess.run(f"bash {script_path}", shell=True)

def update():
    """
    Update the given OS.
    """

    if debian:
        script_path = os.path.join(installer_scripts_path, "update/debian.sh")
    elif macOS:
        script_path = os.path.join(installer_scripts_path, "update/macos.sh")

    subprocess.run(f"bash {script_path}", shell=True)

def provision_module(module_name):
    script_path = ""

    # Determine the script path based on the module name
    if '/' in module_name:
        # If the module name contains a subdirectory
        dir_name, script_name = module_name.split('/', 1)
        script_path = os.path.join(module_path, dir_name, script_name, f"{script_name}.sh")
    elif module_name == "base":
        script_path = os.path.join(smu_home_dir, ".dotfiles/base", f"{module_name}.sh")
    else:
        script_path = os.path.join(module_path, f"{module_name}.sh")

    # Check if the script exists
    if not os.path.exists(script_path):
        warn(f"'{script_path}' does not seem to exist, skipping.")
        return

    # Check that bash is installed
    if subprocess.call("command -v bash &> /dev/null", shell=True) != 0:
        warn("'bash' is not installed, skipping.")
        return

    action(f"Running {script_path} module\n")

    script_dir = os.path.dirname(script_path)
    os.chdir(script_dir)

    # Execute before.sh if exists
    before_script = os.path.join(script_dir, "before.sh")
    if os.path.exists(before_script):
        subprocess.run(f"bash -c 'source {before_script}'", shell=True)

    # Execute main script
    subprocess.run(f"bash -c 'source {script_path}'", shell=True)

    # Execute after.sh if exists
    after_script = os.path.join(script_dir, "after.sh")
    if os.path.exists(after_script):
        subprocess.run(f"bash -c 'source {after_script}'", shell=True)

def self_update():
    """
    Update the 'set-me-up' scripts from the remote Git repository.
    This function assumes that the 'set-me-up' directory is a Git repository.
    """
    
    # Check that module_path/install.sh exists
    if not os.path.exists(f"{installer_path}/install.sh"):
        warn(f"{module_path}/install.sh does not seem to exist.\nPlease run the '{BOLD}base{NORMAL}' module prior to executing '{BOLD}selfupdate{NORMAL}'.")
        return

    try:
        # Update the 'set-me-up' repository
        
        def run_install_script():
            """
            Run the install.sh script from the 'set-me-up-installer' directory.
            """

            subprocess.run(f"{installer_path}/install.sh --no-header", shell=True)

        run_install_script()

        action("Updating 'set-me-up' submodules\n")

        # Iterate over each submodule,
        # determine the default branch,
        # and pull updates from the default branch
        export_smu_home_dir = f"export SMU_HOME_DIR={smu_home_dir};"
        update_submodules_cmd = export_smu_home_dir + r"""
        git -C $SMU_HOME_DIR submodule foreach --recursive '(
            # Get the URL of the remote repository
            remote_url=$(git config --get remote.origin.url)

            # Get the default branch of the remote repository
            default_branch=$(git ls-remote --symref "$remote_url" HEAD | awk "/^ref:/ {sub(/refs\/heads\//, \"\", \$2); print \$2}")

            # Checkout the default branch
            git checkout "$default_branch"

            # Pull updates from the default branch
            git pull origin "$default_branch"
        )'
        """
        subprocess.check_call(update_submodules_cmd, shell=True)

        # Clean up old symlinks
        remove_symlinks()

        # Symlink new files
        symlink()

        print()
        success("Successfully updated 'set-me-up'.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to update 'set-me-up': {e}", file=sys.stderr)

def main():
    parser = argparse.ArgumentParser(description="set-me-up installer")
    parser.add_argument("--version", action="version", version="set-me-up 1.0.0")
    parser.add_argument("--debianupdate", action="store_true", help="Update Debian-based system")
    parser.add_argument("--macosupdate", action="store_true", help="Update MacOS system")
    parser.add_argument("-b", "--base", action="store_true", help="Run base module")
    parser.add_argument("--no-base", action="store_true", help="Do not run base module")
    parser.add_argument("--selfupdate", action="store_true", help="Update set-me-up")
    parser.add_argument("-p", "--provision", action="store_true", help="Provision given modules")
    parser.add_argument("-m", "--modules", nargs='*', default=[], help="Modules to provision")
    parser.add_argument("--lsrc", action="store_true", help="List files that will be symlinked via 'rcm' into your home directory")
    parser.add_argument("--rcup", action="store_true", help="Symlink files via 'rcm' into your home directory")
    parser.add_argument("--rcdn", action="store_true", help="Remove files that were symlinked via 'rcup")
    parser.add_argument("--create_boot_disk", action="store_true", help="Creates a MacOS boot disk")

    args = parser.parse_args()

    # --------------------------------------------------------------------------------------

    # Check if 'rcm' is installed, because it is required for this script to work.
    # 'rcm' is a dotfile management tool that is used to symlink files into the home directory.
    # see: https://github.com/thoughtbot/rcm
    rcm = subprocess.call("command -v rcup &> /dev/null", shell=True) == 0

    command = ""

    if args.lsrc:
        command = "lsrc"
    elif args.rcup:
        command = "rcup"
    elif args.rcdn:
        command = "rcdn"

    # If 'rcm' is not installed, and the user is trying to run 'rcup', 'rcdn', or 'lsrc',
    if not rcm and (args.lsrc or args.rcup or args.rcdn):
        die(f"'rcm' is not installed. Please run the '{BOLD}base{NORMAL}' module prior to executing '{command}'.")

    # --------------------------------------------------------------------------------------

    if args.lsrc:
        list_symlinks()
    elif args.rcup:
        symlink()
    elif args.rcdn:
        remove_symlinks()
    elif args.debianupdate:
        if not debian:
            die("This module is only supported on Debian-based systems.")

        update()
    elif args.macosupdate:
        if not macOS:
            die("This module is only supported on MacOS.")

        update()
    elif args.create_boot_disk:
        if not macOS:
            die("This module is only supported on MacOS.")

        create_boot_disk()
    elif args.selfupdate:
        self_update()
    elif args.provision:
        def set_modules(args):
            """
            Set the modules based on the command line arguments.
            """
            modules = args.modules

            return modules

        modules = set_modules(args)

        # If the 'base' module is not in the module list, add it to the beginning.
        if args.base and "base" not in modules:
            modules.insert(0, "base")

        # If 'no-base' is specified, remove the 'base' module from the module list.
        if args.no_base and "base" in modules:
            modules.remove("base")

        warn("This script will execute the following modules:")
        for module in modules:
            print(f"  - '{BOLD}{module}{NORMAL}'\n")

        warn(f"'{BOLD}set-me-up{NORMAL}' may overwrite existing files in your home directory.")

        # Showcase a summary of the modules that were provisioned

        provisioned = set()
        errored = set()

        # Execute each module
        for module in modules:
            try:
                provision_module(module)

                # Add the module to the 'provisioned' set
                provisioned.add(module)
            except subprocess.CalledProcessError as e:
                # Add the module to the 'errored' set
                errored.add(module)

                # Print the error message
                print(f"Failed to provision '{module}': {e}", file=sys.stderr)

        # Check if we completed all modules without any errors
        if provisioned:   
            print("Modules that were successfully provisioned:") 

            for module in provisioned:
                success(f"  - '{BOLD}{module}{NORMAL}'\n")

        if errored:
            print("Modules that failed to provision:")

            for module in errored:
                warn(f"  - '{BOLD}{module}{NORMAL}'\n")


        warn("It is recommended to restart your computer to ensure all updates take effect.")
        success(f"Completed running '{BOLD}set-me-up{NORMAL}'.")
    elif args.modules:
        # Handle the case where modules are specified without --provision
        print("Modules specified, but --provision flag is not set.", file=sys.stderr)
    else:
        # If no modules are specified, show help
        parser.print_help()


if __name__ == "__main__":
    main()
