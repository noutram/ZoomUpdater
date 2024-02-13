#!/bin/bash
# zoom_update_sangha.sh


# Change to the directory where Zoom is installed (adjust the path if needed)
cd /opt/zoom

# Check the installed version
installed_version=$(cat /opt/zoom/version.txt)

# Get the latest available version from the Zoom website
available_version=$(wget --spider https://zoom.us/client/latest/zoom_amd64.deb 2>&1 | grep Location | sed -e 's/.*prod\/\(.*\)\/.*/\1/')

echo "Installed version: $installed_version"
echo "Available version: $available_version"

# Compare versions and update if necessary
if [ "$installed_version" != "$available_version" ]; then
    echo "Downloading and installing the latest version..."
    wget -c https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install ./zoom_amd64.deb -y
    rm zoom_amd64.deb
else
    echo "Zoom is already up to date."
fi
