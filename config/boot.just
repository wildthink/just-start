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
list:
  @echo Projects
  @for row in `jq '.Projects[].name' config/space.json`; do \
        echo " -" $row; \
  done
  @echo Tools
  @for row in `jq '.Tools[].name' config/space.json`; do \
        echo " -" $row; \
  done
  @echo Packages
  @for row in `jq '.Packages[].name' config/space.json`; do \
        echo " -" $row; \
  done

# Install Just files
[group("Installs")]
[no-cd]
install-config:
  cp config/dot.Justfile.config ~/.justfile
  mkdir -pv ~/.config/just
  cp config/*.just ~/.config/just/

# Setup Workspace
[group("Installs")]
[no-cd]
install-space:
  cp Justfile.space ../Justfile
  mkdir -pv ../config
  cp -r config/*.just ../config/
  cp -r pkls ../
  just -f ../Justfile pkl workspace

# Install the Tools
[group("Installs")]
[no-cd]
install-tools:
  #!/usr/bin/env bash  
  jq -r '.Tools[].install' config/space.json | while IFS= read -r row; do bash -c "$row"; done
