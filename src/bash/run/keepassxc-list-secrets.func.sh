# !/bin/bash
# File: keepassxc-list-secrets.func.sh
# purpose: recursively list all entries in a KeePassXC database group
# usage: DATABASE_PATH=... KEYFILE_PATH=... KEEPASSXC_GROUP=/Root ./run -a do_keepassxc_list_secrets

do_keepassxc_list_secrets() {
    local group_path=${1:-$KEEPASSXC_GROUP}
    keepassxc-cli ls --no-password ${DATABASE_PATH} "${group_path}" --key-file=${KEYFILE_PATH} | while read line; do
        if [[ $line == */ ]]; then
            new_group_path="${group_path}/${line}"
            do_keepassxc_list_secrets "${new_group_path%/}"
        else
            echo "Entry: ${group_path}/${line}"
            username=$(keepassxc-cli show --no-password --quiet ${DATABASE_PATH} "${group_path}/${line}" --key-file=${KEYFILE_PATH} --attributes=UserName)
            echo keepassxc-cli show --no-password --quiet ${DATABASE_PATH} "${group_path}/${line}" --key-file=${KEYFILE_PATH} --attributes=Password \| xclip -selection clipboard
            echo "Username: $username"
            echo ""
        fi
    done

    export EXIT_CODE="0"
}
