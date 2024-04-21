#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

declare -a INPUT_DIRS=("$SCRIPT_DIR/src/latte" "$SCRIPT_DIR/src/frappe" "$SCRIPT_DIR/src/macchiato" "$SCRIPT_DIR/src/mocha")
declare -a OUTPUT_DIRS=("$SCRIPT_DIR/dist/latte" "$SCRIPT_DIR/dist/frappe" "$SCRIPT_DIR/dist/macchiato" "$SCRIPT_DIR/dist/mocha")

if [ ${#INPUT_DIRS[@]} -ne ${#OUTPUT_DIRS[@]} ]; then
    echo "Error: The number of input and output directories must match."
    exit 1
fi

# loop through all directory pairs
for i in "${!INPUT_DIRS[@]}"; do
    SVG_DIR="${INPUT_DIRS[$i]}"
    OUTPUT_DIR="${OUTPUT_DIRS[$i]}"

    # ensure the output directory exists
    mkdir -p "$OUTPUT_DIR"

    # process each SVG file in the current input directory
    for svg_file in "$SVG_DIR"/*.svg; do
        # get the filename without the extension
        filename=$(basename -- "$svg_file" .svg)

        # convert SVG to PNG
        rsvg-convert "$svg_file" -o "$OUTPUT_DIR/${filename}.png"
    done

    echo "Conversion complete for ${SVG_DIR} to ${OUTPUT_DIR}."
done
