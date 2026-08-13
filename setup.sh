#!/bin/bash
#
# Setup script for CLIgen Zephyr module
# This script clones upstream CLIgen and prepares it for Zephyr
#

set -e

UPSTREAM_REPO="https://github.com/clicon/cligen.git"
UPSTREAM_BRANCH="master"
TEMP_DIR="cligen-upstream"

echo "Setting up CLIgen Zephyr module..."

# Clone upstream CLIgen if not already present
if [ ! -d "$TEMP_DIR" ]; then
    echo "Cloning upstream CLIgen..."
    git clone -b $UPSTREAM_BRANCH $UPSTREAM_REPO $TEMP_DIR
fi

echo "Copying source files..."

# Copy core source files
cp $TEMP_DIR/cligen_buf.c .
cp $TEMP_DIR/cligen_cv.c .
cp $TEMP_DIR/cligen_cvec.c .
cp $TEMP_DIR/cligen_handle.c .
cp $TEMP_DIR/cligen_io.c .
cp $TEMP_DIR/cligen_match.c .
cp $TEMP_DIR/cligen_object.c .
cp $TEMP_DIR/cligen_print.c .
cp $TEMP_DIR/cligen_read.c .
cp $TEMP_DIR/cligen_result.c .
cp $TEMP_DIR/cligen_syntax.c .
cp $TEMP_DIR/cligen_tab.c .
cp $TEMP_DIR/cligen_util.c .

# Copy header files
mkdir -p cligen
cp $TEMP_DIR/cligen_buf.h cligen/
cp $TEMP_DIR/cligen_cv.h cligen/
cp $TEMP_DIR/cligen_cvec.h cligen/
cp $TEMP_DIR/cligen_handle.h cligen/
cp $TEMP_DIR/cligen.h cligen/

# Note: Parser files need to be pre-generated with bison/flex
# This would be done on the host system before building for Zephyr

echo "CLIgen source files copied successfully!"
echo ""
echo "Next steps:"
echo "1. Generate parser files on host (if needed):"
echo "   cd $TEMP_DIR && make cligen_parse.c"
echo "2. Copy generated files to module root"
echo "3. Commit changes to zephyr-module branch"
echo "4. Update west.yml in your project"

# Cleanup option
read -p "Remove temporary upstream directory? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf $TEMP_DIR
    echo "Cleanup complete."
fi

echo "Setup complete!"
