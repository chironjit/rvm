prune() {
  runtime=$1
  version=$2

  # Check if the runtime and version are provided
  if [ -z "$runtime" ] || [ -z "$version" ]; then
    echo "Usage: prune <runtime> <version>"
    return 1
  fi

  # Extract major, minor, and patch versions
  IFS='.' read -r major minor patch <<EOF
$version
EOF
  minor=${minor:-0}
  patch=${patch:-0}

  # Remove the leading 'v' if present
  major=${major#v}

  # Construct the runtime directory path
  runtime_dir=".$runtime"

  # Check if the runtime directory exists
  if [ ! -d "$runtime_dir" ]; then
    echo "Runtime directory '$runtime_dir' not found."
    return 1
  fi

  # Iterate over the version folders and delete older versions
  for folder in "$runtime_dir"/v*; do
    if [ -d "$folder" ]; then
      folder_version=${folder#$runtime_dir/v}
      IFS='.' read -r folder_major folder_minor folder_patch <<EOF
$folder_version
EOF
      folder_minor=${folder_minor:-0}
      folder_patch=${folder_patch:-0}

      if [ "$folder_major" -lt "$major" ] || \
         ([ "$folder_major" -eq "$major" ] && [ "$folder_minor" -lt "$minor" ]) || \
         ([ "$folder_major" -eq "$major" ] && [ "$folder_minor" -eq "$minor" ] && [ "$folder_patch" -lt "$patch" ]); then
        echo "Deleting folder: $folder"
        rm -rf "$folder"
      fi
    fi
  done
}