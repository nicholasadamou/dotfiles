#!/bin/bash

# shellcheck disable=SC2001

source /dev/stdin <<<"$(curl -s "https://raw.githubusercontent.com/nicholasadamou/utilities/master/utilities.sh")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# GitHub user/repo & branch value of your set-me-up blueprint (e.g.: nicholasadamou/set-me-up-blueprint/master).
# Set this value when the installer should additionally obtain your blueprint.
readonly SMU_BLUEPRINT=${SMU_BLUEPRINT:-""}
readonly SMU_BLUEPRINT_BRANCH=${SMU_BLUEPRINT_BRANCH:-""}

# The set-me-up version to download
# Available versions:
# 1. 'master' (MacOS)
# 2. 'debian'
# By default the installer will assume you are running MacOS.
# However, if you are running Debian, it will automatically
# download the 'debian' version.
# If neither of these versions are available, the installer
# will determine if it was invoked via SMU Blueprint.
SMU_VERSION=${SMU_VERSION:-"master"}

# A set of ignored paths that 'git' will ignore
# syntax: '<path>|<path>'
# Note: <path> is relative to '$HOME/set-me-up'
readonly SMU_IGNORED_PATHS="${SMU_IGNORED_PATHS:-""}"

# Where to install set-me-up
readonly SMU_HOME_DIR=${SMU_HOME_DIR:-"${HOME}/set-me-up"}

readonly smu_download="https://github.com/nicholasadamou/set-me-up/tarball/${SMU_VERSION}"
readonly smu_blueprint_download="https://github.com/${SMU_BLUEPRINT}/tarball/${SMU_BLUEPRINT_BRANCH}"

# Get the absolute path of the 'utilities' directory.
readonly installer_utilities_path="${SMU_HOME_DIR}/set-me-up-installer/utilities"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Determine if we're on MacOS or Debian
if [[ "$OSTYPE" == "darwin"* ]]; then
	readonly SMU_OS="MacOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	readonly SMU_OS="debian"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check if '--no-header' flag is set
if [[ "$1" = "--no-header" ]]; then
	readonly show_header=false
else
	readonly show_header=true
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function mkcd() {
	local -r dir="${1}"

	if [[ ! -d "${dir}" ]]; then
		mkdir "${dir}"
	fi

	cd "${dir}" || return
}

function is_git_repo() {
	[[ -d "${SMU_HOME_DIR}/.git" ]] || [[ $(git -C "${SMU_HOME_DIR}" rev-parse --is-inside-work-tree 2>/dev/null) ]]
}

function has_remote_origin() {
	git -C "${SMU_HOME_DIR}" config --list | grep -qE 'remote.origin.url' 2>/dev/null
}

function has_submodules() {
	[[ -f "${SMU_HOME_DIR}"/.gitmodules ]]
}

function has_active_submodules() {
	git -C "${SMU_HOME_DIR}" config --list | grep -qE '^submodule' 2>/dev/null
}

function has_untracked_changes() {
	[[ $(git -C "${SMU_HOME_DIR}" diff-index HEAD -- 2>/dev/null) ]]
}

function does_repo_contain() {
	git -C "${SMU_HOME_DIR}" ls-files | grep -qE "$1" &>/dev/null
}

function is_git_repo_out_of_date() {
	UPSTREAM=${1:-'@{u}'}
	LOCAL=$(git -C "${SMU_HOME_DIR}" rev-parse @)
	REMOTE=$(git -C "${SMU_HOME_DIR}" rev-parse "$UPSTREAM")
	BASE=$(git -C "${SMU_HOME_DIR}" merge-base @ "$UPSTREAM")

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	[[ "$LOCAL" = "$BASE" ]] && [[ "$LOCAL" != "$REMOTE" ]]
}

function is_dir_empty() {
	ls -A "${SMU_HOME_DIR:?}/$1" &>/dev/null
}

function install_submodules() {
	git -C "${SMU_HOME_DIR}" config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
		while read -r KEY MODULE_PATH; do
			if [[ -d "${SMU_HOME_DIR:?}/${MODULE_PATH}" ]] && ! is_dir_empty "${MODULE_PATH}" && does_repo_contain "${MODULE_PATH}"; then
				continue
			else
				[[ -d "${SMU_HOME_DIR:?}/${MODULE_PATH}" ]] && is_dir_empty "${MODULE_PATH}" && {
					rm -rf "${SMU_HOME_DIR:?}/${MODULE_PATH}"
				}

				NAME="$(echo "$KEY" | sed -e 's/submodule.//g' | sed -e 's/.path//g')"

				URL_KEY="$(echo "${KEY}" | sed 's/\.path$/.url/')"
				URL="$(git -C "${SMU_HOME_DIR}" config -f .gitmodules --get "${URL_KEY}")"

				# Attempt to get the branch from the submodule URL
				BRANCH=$(git ls-remote --symref "${URL}" HEAD | awk '/^ref:/ {sub(/refs\/heads\//, "", $2); print $2}')

				git -C "${SMU_HOME_DIR}" submodule add --force -b "${BRANCH}" --name "${NAME}" "${URL}" "${MODULE_PATH}" || continue
			fi
		done

	git -C "${SMU_HOME_DIR}" submodule update --init --recursive
}

function are_xcode_command_line_tools_installed() {
	xcode-select --print-path &>/dev/null
}

function install_xcode_command_line_tools() {
	# If necessary, prompt user to install
	# the `Xcode Command Line Tools`.

	action "Installing '${bold}Xcode Command Line Tools${normal}'"

	xcode-select --install &>/dev/null

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# Wait until the `Xcode Command Line Tools` are installed.

	until are_xcode_command_line_tools_installed; do
		sleep 5
	done

	are_xcode_command_line_tools_installed &&
		success "'${bold}Xcode Command Line Tools${normal}' has been successfully installed\n"
}

function can_install_rosetta() {
	# Determine OS version
	# Save current IFS state
	OLDIFS=$IFS

	IFS='.' read osvers_major osvers_minor osvers_dot_version <<<"$(/usr/bin/sw_vers -productVersion)"

	# restore IFS to previous state
	IFS=$OLDIFS

	# Check to see if the Mac is reporting itself as running macOS 11
	if [[ ${osvers_major} -ge 11 ]]; then
		# Check to see if the Mac needs Rosetta installed by testing the processor
		processor=$(/usr/sbin/sysctl -n machdep.cpu.brand_string | grep -o "Apple")

		if [[ -n $processor ]]; then
			return 0
		else
			return 1
		fi
	else
		return 1
	fi
}

function is_rosetta_installed() {
	/usr/bin/pgrep oahd >/dev/null 2>&1
}

function install_rosetta() {
	action "Installing '${bold}Rosetta${normal}'"

	/usr/sbin/softwareupdate --install-rosetta --agree-to-license

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# Wait until the `Rosetta` is installed.

	until is_rosetta_installed; do
		sleep 5
	done

	is_rosetta_installed &&
		success "'${bold}Rosetta${normal}' was successfully installed\n"
}

function confirm() {
	if [[ -n "$SMU_BLUEPRINT" ]] && [[ -n "$SMU_BLUEPRINT_BRANCH" ]]; then
		warn "This script will download '${bold}$SMU_BLUEPRINT${normal}' on branch '${bold}$SMU_BLUEPRINT_BRANCH${normal}' to ${bold}${SMU_HOME_DIR}${normal}"
	else
		warn "This script will download '${bold}set-me-up${normal}' for '${bold}${SMU_OS}${normal}' to ${bold}${SMU_HOME_DIR}${normal}"
	fi

	printf "\n"
	read -r -p "Would you like '${bold}set-me-up${normal}' to continue? (y/n) " -n 1
	echo ""

	[[ ! $REPLY =~ ^[Yy]$ ]] && exit 0
}

function obtain() {
	local -r DOWNLOAD_URL="${1}"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	curl --progress-bar -L "${DOWNLOAD_URL}" |
		tar -xmz --strip-components 1 \
			--exclude={README.md,LICENSE,.gitignore}
}

function setup() {
	confirm
	mkcd "${SMU_HOME_DIR}"

	printf "\n"
	action "Obtaining '${bold}set-me-up${normal}'."
	obtain "${smu_download}"
	printf "\n"

	if ! is_git_repo; then
		git -C "${SMU_HOME_DIR}" init &>/dev/null

		# If (nicholasadamou/set-me-up) has submodules
		# make sure to install them prior to installing
		# set-me-up-blueprint submodules.

		if has_submodules; then
			# Store contents of (nicholasadamou/set-me-up) '.gitmodules' in variable
			# to later append to 'set-me-up-blueprint .gitmodules' if it exists.

			submodules="$(cat "${SMU_HOME_DIR}/.gitmodules")"

			# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

			action "Installing '${bold}set-me-up${normal}' submodules."

			install_submodules

			printf "\n"
		fi
	fi

	# Handle (nicholasadamou/set-me-up-blueprint) installation
	if [[ "${SMU_BLUEPRINT}" != "" ]]; then
		if is_git_repo && has_remote_origin; then
			if has_untracked_changes; then
				# Make sure '$SMU_IGNORED_PATHS' is set prior to
				# obtaining list of modified files

				if [[ -n "$SMU_IGNORED_PATHS" ]]; then
					IGNORED_PATHS=".gitmodules|.dotfiles/modules/install.sh|${SMU_IGNORED_PATHS}"
				else
					IGNORED_PATHS=".gitmodules|.dotfiles/modules/install.sh"
				fi

				# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

				# Obtain list of modified files

				files="$(git -C "${SMU_HOME_DIR}" status -s |
					grep -v '?' |
					sed 's/[AMCDRTUX]//g' |
					xargs printf -- "${SMU_HOME_DIR}/%s\n" |
					grep -vE "${IGNORED_PATHS}" |
					xargs)"

				# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

				# Make sure that '$files' is not empty.
				# If it is not empty then, commit changes
				# to the (nicholasadamou/set-me-up-blueprint) repo.

				if [[ -n "$files" ]]; then
					git -C "${SMU_HOME_DIR}" \
						add -f "$files" &>/dev/null

					git -C "${SMU_HOME_DIR}" \
						-c user.name="set-me-up" \
						-c user.email="set-me-up@gmail.com" \
						commit -m "✅ UPDATED: '$files'" &>/dev/null

					if [[ "$?" -eq 0 ]]; then
						success "UPDATED: '$files'\n"
					fi
				fi

				# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

				git -C "${SMU_HOME_DIR}" reset --hard HEAD &>/dev/null
			fi

			if is_git_repo_out_of_date "$SMU_BLUEPRINT_BRANCH"; then
				action "Updating your '${bold}set-me-up${normal}' blueprint."

				git -C "${SMU_HOME_DIR}" pull --ff
			else
				success "Already up-to-date"
			fi

			if has_submodules; then
				printf "\n"
				action "Updating your '${bold}set-me-up${normal}' blueprint submodules."

				install_submodules

				git -C "${SMU_HOME_DIR}" submodule foreach git pull
			fi
		else
			action "Cloning your '${bold}set-me-up${normal}' blueprint."

			git -C "${SMU_HOME_DIR}" remote add origin "https://github.com/${SMU_BLUEPRINT}.git"
			git -C "${SMU_HOME_DIR}" fetch
			git -C "${SMU_HOME_DIR}" checkout -f "${SMU_BLUEPRINT_BRANCH}"

			# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

			if has_submodules; then
				printf "\n"
				action "Installing your '${bold}set-me-up${normal}' blueprint submodules."

				# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

				# If '$submodules' is not empty, meaning,
				# (nicholasadamou/set-me-up) has submodules
				# append its contents to the set-me-up-blueprint
				#'.gitmodules' file.

				if [[ -n "$submodules" ]]; then
					if ! grep -q "$(tr <<<"$submodules" '\n' '\01')" < <(less "${SMU_HOME_DIR}/.gitmodules" | tr '\n' '\01'); then
						echo "$submodules" >>"${SMU_HOME_DIR}"/.gitmodules
						git -C "${SMU_HOME_DIR}" \
							-c user.name="set-me-up" \
							-c user.email="set-me-up@gmail.com" \
							commit -a -m "✅ UPDATED: '.gitmodules'" &>/dev/null
					fi
				fi

				# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

				install_submodules
			fi
		fi
	fi

	printf "\n"

	success "'${bold}set-me-up${normal}' has been successfully installed on your system."

	if [[ -n "$SMU_BLUEPRINT" ]] && [[ -n "$SMU_BLUEPRINT_BRANCH" ]]; then
		echo -e "\nFor more information concerning how to install various modules, please see: [https://github.com/$SMU_BLUEPRINT/tree/$SMU_BLUEPRINT_BRANCH]\n"
	else
		echo -e "\nFor more information concerning how to install various modules, please see: [https://github.com/nicholasadamou/set-me-up/tree/$SMU_VERSION]\n"
	fi
}

function install_rosetta_if_needed() {
	# Installing Rosetta 2 on Apple Silicon Macs
	# See https://derflounder.wordpress.com/2020/11/17/installing-rosetta-2-on-apple-silicon-macs/
	if can_install_rosetta && ! is_rosetta_installed; then
		install_rosetta
	elif is_rosetta_installed; then
		success "'${bold}Rosetta${normal}' is already installed\n"
	fi
}

function install_xcode_command_line_tools_if_needed() {
	if ! are_xcode_command_line_tools_installed; then
		install_xcode_command_line_tools
	else
		success "'${bold}Xcode Command Line Tools${normal}' are already installed\n"
	fi
}

function invoked_via_smu_blueprint() {
	# Check if both SMU_BLUEPRINT and SMU_BLUEPRINT_BRANCH are set
	if [[ -n "$SMU_BLUEPRINT" ]] && [[ -n "$SMU_BLUEPRINT_BRANCH" ]]; then
		# Both variables are set, so we can assume that the installer was invoked via SMU Blueprint.
		return 0
	fi

	return 1
}

function check_os_support() {
	# Check if both SMU_BLUEPRINT and SMU_BLUEPRINT_BRANCH are set
	if invoked_via_smu_blueprint; then
		# If invoked via SMU Blueprint, then we can assume that the OS is supported.
		# This is because the SMU Blueprint is responsible for determining if the OS is supported.
		# By default, 'nicholasadamou/set-me-up' (non-blueprint) supports MacOS and Debian.
		return 0
	fi

	# Check if OS is supported (MacOS or Debian)
	if [[ "$SMU_OS" != "MacOS" ]] && [[ "$SMU_OS" != "debian" ]]; then
		error -e "Sorry, '${bold}set-me-up${normal}' is not supported on your OS.\n"
		exit 1
	fi
}

function main() {
	if [[ "$show_header" = true ]]; then
		bash "${installer_utilities_path}"/header.sh
	fi

	# Determine if the operating system is supported
	# by the base 'set-me-up' configuration.
	check_os_support

	# Check if we are running on MacOS, if so, install
	# 'Xcode Command Line Tools' and 'Rosetta' if needed.
	if [[ "$SMU_OS" = "MacOS" ]]; then
		install_xcode_command_line_tools_if_needed

		install_rosetta_if_needed
	fi

	# Check if 'git' is installed
	# 'git' is required to install 'set-me-up'
	# given that 'set-me-up' is a git repository and requires submodules.
	if ! command -v git &>/dev/null; then
		error "'${bold}git${normal}' is not installed.\n"
		exit 1
	fi

	# Preemptively check if installer was invoked via SMU Blueprint.
	if ! invoked_via_smu_blueprint; then

		# Assuming the installer was not invoked via SMU Blueprint,
		# check if the user is running Debian.
		# This is accomplished by determining if the SMU OS is 'debian',
		# then set SMU_VERSION to 'debian'.
		if [[ "$SMU_OS" = "debian" ]]; then
			SMU_VERSION="debian"
		fi
	fi

	# If SMU_BLUEPRINT and SMU_BLUEPRINT_BRANCH are set,
	# Then the installer was invoked via SMU Blueprint.

	setup
}

main "$@"
