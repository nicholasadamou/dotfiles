import os
import subprocess

# macOS versions and their corresponding Mac App Store IDs
macos_versions = {
    "Sonoma": "id6450717509" # MacOS 14.x.x
}

# Function to open the Mac App Store for a specific macOS version
def open_mac_app_store(app_store_id):
    os.system(f"open macappstores://itunes.apple.com/app/{app_store_id}")

def main():
    print("Select the macOS version for which you want to create a bootable disk:")
    for idx, version in enumerate(macos_versions.keys(), start=1):
        print(f"{idx}. {version}")

    choice = int(input("Enter your choice (number): "))
    selected_version = list(macos_versions.keys())[choice - 1]
    mac_app_store_id = macos_versions[selected_version]

    install_app_path = f"/Applications/Install macOS {selected_version}.app"
    print(f"\nSelected macOS version: {selected_version}")
    volume_path = input("Enter the '/Volumes' path to where we should make a bootable disk: ")

    if os.path.exists(f"{install_app_path}/Contents/SharedSupport/InstallESD.dmg"):
        print("Found the install app, creating an install disk...")

        if not os.path.exists(volume_path):
            disk_image_name = os.path.basename(volume_path)
            disk_image_size = "10G"

            print(f"Creating a disk image '{disk_image_name}' ({disk_image_size})")
            subprocess.run(["hdiutil", "create", "-o", f"{disk_image_name}.dmg",
                            "-volname", disk_image_name, "-size", disk_image_size,
                            "-layout", "SPUD", "-fs", "HFS+J"])
            subprocess.run(["hdiutil", "attach", f"{disk_image_name}.dmg"])

        # Create an install disk
        subprocess.run(["sudo", f"{install_app_path}/Contents/Resources/createinstallmedia",
                        "--volume", volume_path, "--downloadassets", "--noninteractive"])
    else:
        # Open Mac App Store to download the macOS installer app
        open_mac_app_store(mac_app_store_id)
        print(f"Please download the macOS {selected_version} installer from the Mac App Store, then run this script again.")

if __name__ == "__main__":
    main()
