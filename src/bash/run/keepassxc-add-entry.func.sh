#\!/bin/bash
# File: keepassxc-add-entry.func.sh
# purpose: add a new entry to a KeePassXC database
# usage: DATABASE_PATH=... KEYFILE_PATH=... ENTRY_PATH=... ENTRY_USERNAME=... ENTRY_PASSWORD=... ENTRY_URL=... ENTRY_NOTES=... ./run -a do_keepassxc_add_entry
# globals:
#   DATABASE_PATH: path to the KeePassXC database
#   KEYFILE_PATH: path to the KeePassXC keyfile
#   ENTRY_PATH: full path of the entry (e.g. STRIPE-TEST/visa-test-card)
#   ENTRY_USERNAME: username for the entry
#   ENTRY_PASSWORD: password for the entry (piped via stdin)
#   ENTRY_URL: (optional) URL for the entry
#   ENTRY_NOTES: (optional) notes for the entry
#   ENTRY_GROUP: (optional) group to create before adding entry

do_keepassxc_add_entry() {

  do_require_var DATABASE_PATH ${DATABASE_PATH:-}
  do_require_var KEYFILE_PATH ${KEYFILE_PATH:-}
  do_require_var ENTRY_PATH ${ENTRY_PATH:-}
  do_require_var ENTRY_USERNAME ${ENTRY_USERNAME:-}
  do_require_var ENTRY_PASSWORD ${ENTRY_PASSWORD:-}

  # create group if specified and it does not exist yet
  if [[ -n "${ENTRY_GROUP:-}" ]]; then
    do_log "INFO" "creating group: ${ENTRY_GROUP}"
    keepassxc-cli mkdir --no-password --quiet \
      --key-file="${KEYFILE_PATH}" \
      "${DATABASE_PATH}" "${ENTRY_GROUP}" 2>/dev/null || true
  fi

  local -a cmd_args=()
  cmd_args+=(--no-password --quiet)
  cmd_args+=(--key-file="${KEYFILE_PATH}")
  cmd_args+=(--username "${ENTRY_USERNAME}")

  if [[ -n "${ENTRY_URL:-}" ]]; then
    cmd_args+=(--url "${ENTRY_URL}")
  fi

  if [[ -n "${ENTRY_NOTES:-}" ]]; then
    cmd_args+=(--notes "${ENTRY_NOTES}")
  fi

  cmd_args+=(-p "${DATABASE_PATH}" "${ENTRY_PATH}")

  do_log "INFO" "adding entry: ${ENTRY_PATH}"
  echo "${ENTRY_PASSWORD}" | keepassxc-cli add "${cmd_args[@]}"

  export EXIT_CODE=$?

  if [[ "${EXIT_CODE}" -eq 0 ]]; then
    do_log "INFO" "entry added successfully: ${ENTRY_PATH}"
  else
    do_log "ERROR" "failed to add entry: ${ENTRY_PATH}"
  fi
}
