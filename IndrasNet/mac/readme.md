# Indra's Net (mac)


## Randoms

Building outside of xcode 

```
% xcodebuild -scheme IndrasNet -configuration Debug build
% setenv BUILD_DIR `xcodebuild -scheme "IndrasNet" -configuration Debug -showBuildSettings | grep -m 1 "BUILT_PRODUCTS_DIR" | awk '{print $3}'`
% open $BUILD_DIR/IndrasNet.app
```

_(env var syntax is for csh variants - for bash variants, do `BUILD_DIR=$(...)`)_

# Progress

