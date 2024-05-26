TARGET_COPY_PATH="$HOME/Library/Screen Savers"                                                                                            
                                                                                                                                          
if [ -f "$TARGET_COPY_PATH/$WRAPPER_NAME" ]                                                                                               
  echo "$TARGET_COPY_PATH/$WRAPPER_NAME has already been installed, should be deleted first"                                              
  rm -rf "$TARGET_COPY_PATH/$WRAPPER_NAME"                                                                                                
  killall WallpaperAgent                                                                                                                  
fi                                                                                                                                        
                                                                                                                                          
cp -R "$TARGET_BUILD_DIR/$WRAPPER_NAME" "$TARGET_COPY_PATH"                                                                               
killall WallpaperAgent                                                                                                                    
echo "$TARGET_COPY_PATH/$WRAPPER_NAME has been installed"     
