#!/bin/bash

# Configuration
FRAMEWORK_NAME="JSONKit"
OUTPUT_DIR="build"
XCFRAMEWORK_PATH="${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework"

# Check if XCFramework exists
if [ ! -d "${XCFRAMEWORK_PATH}" ]; then
    echo "Error: XCFramework not found at ${XCFRAMEWORK_PATH}"
    exit 1
fi

# Verify architectures
echo "Verifying architectures..."
lipo -info "${XCFRAMEWORK_PATH}/ios-arm64/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"
lipo -info "${XCFRAMEWORK_PATH}/ios-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"

# Verify module map
echo "Verifying module map..."
if [ ! -f "${XCFRAMEWORK_PATH}/ios-arm64/${FRAMEWORK_NAME}.framework/Modules/module.modulemap" ]; then
    echo "Error: Module map not found in iOS device framework"
    exit 1
fi

if [ ! -f "${XCFRAMEWORK_PATH}/ios-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework/Modules/module.modulemap" ]; then
    echo "Error: Module map not found in iOS simulator framework"
    exit 1
fi

# Verify headers
echo "Verifying headers..."
if [ ! -f "${XCFRAMEWORK_PATH}/ios-arm64/${FRAMEWORK_NAME}.framework/Headers/JSONKit.h" ]; then
    echo "Error: JSONKit.h not found in iOS device framework headers"
    exit 1
fi

if [ ! -f "${XCFRAMEWORK_PATH}/ios-arm64/${FRAMEWORK_NAME}.framework/Headers/NSString+JSONKit.h" ]; then
    echo "Error: NSString+JSONKit.h not found in iOS device framework headers"
    exit 1
fi

if [ ! -f "${XCFRAMEWORK_PATH}/ios-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework/Headers/JSONKit.h" ]; then
    echo "Error: JSONKit.h not found in iOS simulator framework headers"
    exit 1
fi

if [ ! -f "${XCFRAMEWORK_PATH}/ios-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework/Headers/NSString+JSONKit.h" ]; then
    echo "Error: NSString+JSONKit.h not found in iOS simulator framework headers"
    exit 1
fi

echo "Verification completed successfully!" 