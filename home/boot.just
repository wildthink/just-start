# boot: Module
_default:
    @echo '{{ style("warning") }}Boot Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} --list


# for x in $(jq '.bag[]' conf.json); do echo $x; done

# Edit this file
edit:
	@just -e -f {{source_file()}}

# List the Bootstrap Manifest
[no-cd]
setup:
  @echo Tools
  @for row in `jq '.Tools[].name' config/space.json`; do \
        echo " -" $row; \
  done
  @echo Packages
  @for row in `jq '.Packages[].name' config/space.json`; do \
        echo " -" $row; \
  done

# Install the Tools
[no-cd]
install-tools:
  #!/usr/bin/env bash  
  jq -r '.Tools[].install' config/space.json | while IFS= read -r row; do bash -c "$row"; done

# Install the Packages
[no-cd]
install-packages:
  @echo Packages
  @for row in `jq -r '.Packages[].repo' config/space.json`; do \
        echo " -" $row; \
  done
