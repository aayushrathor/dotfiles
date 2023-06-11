#!/usr/bin/env bash

##
# 0. (A must) Leave a star on this GIST :P
# 1. Clone/download/copy-paste the this script
# 2. Give it rights to execute: `chmod +x d.sh`
# 3. Move it somewhere on your PATH and (optionally) rename it on the fly: `mv d.sh /usr/local/bin/d`
# 4. Now run it from anywhere: `d` or `d.sh` (if you didn't rename your file)
# 5. ???
# 6. Hooray! You're inside the container! Enjoy your stay & mess around as much as you want!
##

##
# Exit on errors
##

set -o nounset -o pipefail -o errexit

##
# Change these to your preference
##

# base DockerHub image:tag
_base_image_name="ubuntu"
_base_image_tag="20.04"  # or latest

# preferred shell and it's location
_shell="fish"
_shell_location="/usr/bin/fish"
_shell_change_cmd="chsh -s"

# package manager, it's update/install cmds and list of packages to install
_package_manager="apt"
_update_cmd="update"
_install_cmd="install -y"
_list_of_packages="vim wget curl jq fzf git nmap net-tools tree htop"

##
# DON'T CHANGE THESE
##

_stripped_base_image="${_base_image_name}-$(echo "$_base_image_tag" | tr -d ' :' | tr '.' '_')"
_image_name="${_stripped_base_image}-test-image"
_container_name="${_stripped_base_image}-$(uuidgen)"
_cxt_folder="/tmp/${_stripped_base_image}-empty-context-folder"

_dockerfile="
FROM $_base_image_name:$_base_image_tag
RUN $_package_manager $_update_cmd && \
    $_package_manager $_install_cmd $_shell $_list_of_packages && \
    $_shell_change_cmd $_shell_location
CMD [\"$_shell\"]"

##
# Making the empty context folder and build the image (if needed)
##

if [ "$(docker images -q "$_image_name" | wc -l)" -eq 0 ]; then
    mkdir -p "$_cxt_folder"

    echo -en "$_dockerfile" \
    | docker build --tag "$_image_name" -f - "$_cxt_folder"

    rmdir --ignore-fail-on-non-empty "$_cxt_folder"
fi

##
# Running the container from the built image
##

docker run \
    -it \
    --rm \
    --network host \
    --hostname "$_container_name" \
    --name "$_container_name" \
    "$_image_name" "$_shell"
