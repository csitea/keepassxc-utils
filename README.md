# keepassxc-utils
Utility scripts for automating keepassxc-cli and keepassxc

## CHECK USAGE

```bash
./run --help
```

## SIMPLE INSTALL 
Let's say that you want to create a new tool called `"my-app"`

```bash
# use the /tmp dir as starting point, get the current version:
cd /tmp/ ; test -f current.zip && rm -v current.zip
wget https://github.com/csitea/keepassxc-utils/archive/refs/tags/current.zip

# rename it into "my-app" ( rm any older my-app first ) 
test -d /tmp/my-app && rm -r /tmp/my-app ; unzip -o current.zip -d . && mv -v keepassxc-utils-current my-app

# check the usage: 
cd /tmp/my-app ; ./run --help
```
## USAGE
to export a keepassxc db into an xml file
```bash
 KEY_FILE=~/secret-file.key KBDX_FILE='/opt/org/org-creds/org.kdbx' ./run -a do_export_keepassxc_db
``` 

## FEATURES & FUNCTIONALITIES 
The `keepassxc-utils` has the following function
 
 - minimalistic multi-os support 
 - etrexemely versatile logging function
 - capability to generically run any bash functions in the `lib/bash/funcs/` and `src/bash/run` dirs
 - json configuration file parsing function
 - package zipping function
 - variables provisioning requiring function
 - cmd args parsing functionality to start building on top of ...
 - directories resolution functionality - use always absolute paths in your functions for stability ...
 - use the `exit_code=$?` to fail early in your functions on errors ...

 
