#!/bin/bash


# Convert the archive of the Flutter app to a Flatpak.


# Exit if any command fails
set -e

# Echo all commands for debug purposes
set -x


# No spaces in project name.
projectName=sitemarker
projectId=io.github.aerocyber.sitemarker
executableName=sitemarker
projectVersion=2.1.1

# ------------------------------- Build Flatpak ----------------------------- #

# Extract portable Flutter build.
mkdir -p $projectName
tar -xf $projectName-$projectVersion-amd64-linux.tar.xz

# Copy the portable app to the Flatpak-based location.
cp -r $projectName-$projectVersion-amd64-linux/ /app/
chmod +x /app/$projectName-$projectVersion-amd64-linux/$executableName
mkdir -p /app/bin
ln -s /app/$projectName-$projectVersion-amd64-linux/$executableName /app/bin/$executableName

# Install the icon.
iconDirA=/app/share/icons/hicolor/scalable/apps
iconDirB=/app/share/icons/hicolor/symbolic/apps
mkdir -p $iconDirA $iconDirB
cp -r flatpak/icons/hicolor/scalable/apps/$projectId.svg $iconDirA/
cp -r flatpak/icons/hicolor/symbolic/apps/$projectId.svg $iconDirB/

# Install the desktop file.
desktopFileDir=/app/share/applications
mkdir -p $desktopFileDir
cp -r flatpak/$projectId.desktop $desktopFileDir/

# Install the AppStream metadata file.
metadataDir=/app/share/metainfo
mkdir -p $metadataDir
cp -r flatpak/$projectId.metainfo.xml $metadataDir/
