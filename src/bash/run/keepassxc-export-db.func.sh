#!/bin/env bash
# File: keepassxc-export-db.func.sh
# purpose: export a KeePassXC database to XML format
# usage: KBDX_FILE=... KEY_FILE=... ./run -a do_keepassxc_export_db

do_keepassxc_export_db(){

   if ! command -v keepassxc-cli &> /dev/null; then
       echo "KeePassXC-CLI is not installed on this system."
       echo "Please install it before running this script."
       exit 1
   fi

   KBDX_FILE=${KBDX_FILE:?PROVIDE THE ABSOLUTE KBDX FILE PATH TO EXPORT}
   KEY_FILE=${KEY_FILE:?PROVIDE THE ABSOLUTE KEY FILE OPENING THE KBDX FILE}

   export XML_EXPORT_DIR=~/var/$PRODUCT/dat/xml
   export XML_EXPORT_FILE=$XML_EXPORT_DIR/$(basename $KBDX_FILE).$(date "+%Y%m%d_%H%M%S").xml

   mkdir -p $XML_EXPORT_DIR

   do_log DEBUG running:
   do_log DEBUG keepassxc-cli export --no-password --format=xml --key-file $KEY_FILE "${KBDX_FILE}" \> "${XML_EXPORT_FILE}"
   keepassxc-cli export --no-password --format=xml --key-file $KEY_FILE "${KBDX_FILE}" > "${XML_EXPORT_FILE}"

   do_log INFO produced the following export xml file: $XML_EXPORT_FILE

   export EXIT_CODE="$?"
}
