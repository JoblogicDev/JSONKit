#!/bin/bash

# Install XcodeGen if not installed
if ! command -v xcodegen &> /dev/null; then
    brew install xcodegen
fi

# Check and install required dependencies
echo "Checking required dependencies..."
if ! command -v yq &> /dev/null; then
    echo "Installing yq..."
    brew install yq
fi

# Configuration
SCHEME="JSONKit"
FRAMEWORK_NAME="JSONKit"
CONFIGURATION="Release"
OUTPUT_DIR="build"

# Clean build directory
rm -rf "${OUTPUT_DIR}"
mkdir -p "${OUTPUT_DIR}"

# Generate Xcode project
xcodegen generate

# Build for iOS devices
xcodebuild archive \
    -scheme "${SCHEME}" \
    -configuration "${CONFIGURATION}" \
    -destination "generic/platform=iOS" \
    -archivePath "${OUTPUT_DIR}/${FRAMEWORK_NAME}-iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Build for iOS Simulator
xcodebuild archive \
    -scheme "${SCHEME}" \
    -configuration "${CONFIGURATION}" \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "${OUTPUT_DIR}/${FRAMEWORK_NAME}-iOS-Simulator" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Create XCFramework
xcodebuild -create-xcframework \
    -framework "${OUTPUT_DIR}/${FRAMEWORK_NAME}-iOS.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
    -framework "${OUTPUT_DIR}/${FRAMEWORK_NAME}-iOS-Simulator.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
    -output "${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework"

# Copy headers to both frameworks
echo "Copying headers to frameworks..."
mkdir -p "./build/${FRAMEWORK_NAME}.xcframework/ios-arm64/${FRAMEWORK_NAME}.framework/Headers"
mkdir -p "./build/${FRAMEWORK_NAME}.xcframework/ios-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework/Headers"
cp -R "Sources/JSONKit/include/"* "./build/${FRAMEWORK_NAME}.xcframework/ios-arm64/${FRAMEWORK_NAME}.framework/Headers/"
cp -R "Sources/JSONKit/include/"* "./build/${FRAMEWORK_NAME}.xcframework/ios-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework/Headers/"

# Verify headers
echo "Verifying headers..."
ls -la "./build/${FRAMEWORK_NAME}.xcframework/ios-arm64/${FRAMEWORK_NAME}.framework/Headers/"
ls -la "./build/${FRAMEWORK_NAME}.xcframework/ios-arm64_x86_64-simulator/${FRAMEWORK_NAME}.framework/Headers/"

echo "Build completed successfully!" 

# Configuration
XC_FRAMEWORK_PATH="./build/${FRAMEWORK_NAME}.xcframework"
# Get version from version.yml
VERSION=$(yq e '.version' version.yml)
echo "Version: $VERSION"
# Define zip file name with version
ZIP_FILE="${VERSION}-${FRAMEWORK_NAME}.xcframework.zip"
echo "Creating zip file..."
cd ./build
zip -r "../${ZIP_FILE}" "${FRAMEWORK_NAME}.xcframework"
cd ..
