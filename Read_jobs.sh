#!/bin/bash
directory_today="$(date +%Y-%m-%d_%H-%M-%S)"
sed -i -e 's/[0-9]*\-[0-9]*\-[0-9]*_[0-9]*\-[0-9]*\-[0-9]*/'"${directory_today}"'/' history.xml
while IFS='' read -r line || [[ -n "$line" ]]; do
 if [[ !  -z  "$line" ]]; then
  file_name=$(echo "$line" | sed 's/^\.\///')
  backup_directory_base=$(echo "$file_name" | sed 's/config.xml/config-history/')
  backup_directory_base="$backup_directory_base/$directory_today/"
  mkdir -p "$backup_directory_base"
  cp "$file_name" "$backup_directory_base"
  cp "history.xml" "$backup_directory_base"
  echo "$file_name"
  sed --in-place=-${directory_today}.bak -e 's@{GIT_HOST}:@{GITLAB_HOST}:babylon/@' "$file_name"
fi
    done < "$1"
