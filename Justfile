# Workspace Justfile
# Coordinates the variety of useful scripts for
# managing a Workspace of projects.

import 'config/modules.just'

# Boot Module
mod boot "config/boot.just"

# About Constellation Tools
_default:
    @echo '{{ style("warning") }}Workspace Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} --list

# Workspace tree -L 2
[no-cd]
tree:
   @echo '{{ style("warning") }}Workspace Commands{{ NORMAL }}'
   tree -L 2

my_dir_name := file_name(justfile_directory())
my_config := file_name(justfile_directory())


# Setup Workspace
[group("Installs")]
[no-cd]
install-space: install-pkl
  sed 's/__CONFIG__/{{my_dir_name}}/g' templates/Justfile.space > ../Justfile
  pkl eval -f json -o  workspace.json pkls/workspace.pkl

# Install pkl if missing
[group("Installs")]
install-pkl: (installer::brew "pkl")

# Install the Tools
[group("Installs")]
[no-cd]
install-tools:
  #!/usr/bin/env bash 
  jq -r '.Tools[].install' config/space.json | while IFS= read -r row; do bash -c "$row"; done

set unstable

bosh := which("bosh")
[private]
@test:
    echo "bosh: '{{bosh}}'"
    echo "just: '{{which("just")}}'"
    echo "brew: '{{which("brew")}}'"

