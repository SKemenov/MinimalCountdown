#!/bin/sh

# There's a post-action build script to update screen saver binary file.
# Please note to select MinimalCountDown target and past new line as a link to this file
# path to the script: "$SRCROOT/Scripts/post_build_install.sh"

TARGET_COPY_PATH="$HOME/Library/Screen Savers"

# Check if it's a cleaning
if [ ! -d "$TARGET_BUILD_DIR/$WRAPPER_NAME" ]; then 
  echo "It's a 'Clean Build Folder', do nothing"
  exit 0
fi

# Ok, it's build post-action
# Delete the old version
if [ -d "$TARGET_COPY_PATH/$WRAPPER_NAME" ]; then 
  echo "$TARGET_COPY_PATH/$WRAPPER_NAME has already been installed, should be deleted first"
  rm -rf "$TARGET_COPY_PATH/$WRAPPER_NAME"
  if [ $? -ne 0 ]; then
    echo "Failed to delete old version"
    exit 1
  fi
  echo "Old version has been deleted, restart screenSaver.engine"
  killall WallpaperAgent 
fi

# Install a new version
cp -R "$TARGET_BUILD_DIR/$WRAPPER_NAME" "$TARGET_COPY_PATH"
if [ $? -ne 0 ]; then   # if cp failed
  echo "Failed to copy new version"
  exit 1
fi
echo "$TARGET_COPY_PATH/$WRAPPER_NAME has been installed successfully"

# Clear macOS screen saver thumbnail and metadata caches
find /private/var/folders -maxdepth 6 \( \
  -path "*/C/com.apple.wallpaper.caches" \
  -o -path "*/C/com.apple.wallpaper.extension.legacy" \
\) 2>/dev/null | xargs rm -rf
echo "Screen saver caches cleared"
