#!/bin/bash

download_and_extract () {
  DATASET_DIR="$1"
  ZIP_FILE="$2"
  URL="$3"

  if [ ! -d "$DATASET_DIR" ]; then
    echo "Dataset '$DATASET_DIR' not found. Downloading..."

    curl -L -o "$ZIP_FILE" "$URL" && \
    unzip "$ZIP_FILE" -d "$DATASET_DIR" && \
    rm "$ZIP_FILE"

    echo "Dataset '$DATASET_DIR' downloaded and extracted."
  else
    echo "Dataset '$DATASET_DIR' already exists. Skipping download."
  fi
}

# 1. Garbage Classification v2
download_and_extract \
  "resources/garbage-classification-v2" \
  "resources/garbage-classification-v2.zip" \
  "https://www.kaggle.com/api/v1/datasets/download/sumn2u/garbage-classification-v2"

# 2. Garbage Dataset Classification
download_and_extract \
  "resources/garbage-dataset-classification" \
  "resources/garbage-dataset-classification.zip" \
  "https://www.kaggle.com/api/v1/datasets/download/zlatan599/garbage-dataset-classification"

# 3. Garbage Detection
download_and_extract \
  "resources/garbage-detection" \
  "resources/garbage-detection.zip" \
  "https://www.kaggle.com/api/v1/datasets/download/viswaprakash1990/garbage-detection"

# 4. Textures dataset and processing
download_and_extract \
  "resources/textures" \
  "resources/textures.zip" \
  https://www.kaggle.com/api/v1/datasets/download/roustoumabdelmoula/textures-dataset  

convert_textures_to_png() {
  local root="./resources/textures"

  find "$root" -type f -iname "*.jpg" -print0 |
  while IFS= read -r -d '' file; do
    out="${file%.jpg}.png"

    convert "$file" "$out" && rm "$file"
  done
}

convert_textures_to_png

find ./resources/textures -mindepth 2 -type f -name "*.png" -exec mv -t ./resources/textures {} +

find ./resources/textures -type d -empty -delete
