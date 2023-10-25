#!/bin/env bash

do_export_keepassxc_db(){


   # Check if keepassxc-cli is installed
   if ! command -v keepassxc-cli &> /dev/null; then
       echo "KeePassXC-CLI is not installed on this system."
       echo "Please install it before running this script."
       exit 1  # Exit with an error code
   fi


   # Check if KBDX_FILE variable is set, if not, prompt for its value
   KBDX_FILE=${KBDX_FILE:?PROVIDE THE ABSOLUTE KBDX FILE PATH TO EXPORT}

   # Check if KEY_FILE variable is set, if not, prompt for its value
   KEY_FILE=${KEY_FILE:?PROVIDE THE ABSOLUTE KEY FILE OPENING THE KBDX FILE}

   export XML_EXPORT_DIR=~/var/$PRODUCT/dat/xml
   export XML_EXPORT_FILE=$XML_EXPORT_DIR/$(basename $KBDX_FILE).$(date "+%Y%m%d_%H%M%S").xml

   mkdir -p $XML_EXPORT_DIR

   # Export the database to an XML file before pulling changes
   do_log DEBUG running: 
   do_log DEBUG keepassxc-cli export --no-password --format=xml --key-file $KEY_FILE "${KBDX_FILE}" \> "${XML_EXPORT_FILE}"
   keepassxc-cli export --no-password --format=xml --key-file $KEY_FILE "${KBDX_FILE}" > "${XML_EXPORT_FILE}"

   do_log INFO produced the following export xml file: $XML_EXPORT_FILE

   export exit_code="$?"

}
