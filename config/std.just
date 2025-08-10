# std: Module
_default:
    @echo '{{ style("warning") }}Standard Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} --list

# Edit this file
edit:
	@just -e -f {{source_file()}}

# Opens Just Online Reference
man page='introduction':
    @open https://just.systems/man/en/{{page}}.html

ws := source_directory()/'../workspace.json'

# Open Tools & Package Docs
[no-cd]
docs subject:
  #!/bin/bash
  jq -r '.Tools[]|select(.name=="{{subject}}")|.docs' {{ws}} | while IFS= read -r row; do \
    open "$row";  done

# Open Tools & Package Docs
[no-cd]
info subject:
  #!/bin/bash
  echo Searching for ".*{{subject}}.*"
  echo Projects...
  jq -r '.Projects[]|select(.name|test(".*{{subject}}.*"; "i"))' {{ws}} | while IFS= read -r row; do \
    echo "$row";  done
  echo Packages...
  jq -r '.Packages[]|select(.name|test(".*{{subject}}.*"; "i"))' {{ws}} | while IFS= read -r row; do \
    echo "$row";  done
  echo Tools...
  jq -r '.Tools[]|select(.name|test(".*{{subject}}.*"; "i"))' {{ws}} | while IFS= read -r row; do \
    echo "$row";  done

# Workspace Manifest
[no-cd]
[group("Help")]
list:
  @echo Projects
  @for row in `jq '.Projects[].name' {{ws}}`; do \
        echo " -" $row; \
  done
  @echo Tools
  @for row in `jq '.Tools[].name' {{ws}}`; do \
        echo " -" $row; \
  done
  @echo Packages
  @for row in `jq '.Packages[].name' {{ws}}`; do \
        echo " -" $row; \
  done
