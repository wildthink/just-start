# Workspace Justfile
# Coordinates the variety of useful scripts for
# managing a Workspace of projects.

import 'config/modules.just'

# Bood Module
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

set unstable

bosh := which("bosh")
[private]
@test:
    echo "bosh: '{{bosh}}'"
    echo "just: '{{which("just")}}'"
    echo "brew: '{{which("brew")}}'"
