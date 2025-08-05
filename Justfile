# Workspace Tools Justfile
# Coordinates the variety of useful scripts for
# managing a Workspace of projects.

# Standard Module
mod std 'home/std.just'
# Tools Module
mod tools 'home/tools.just'
# GIT Module
mod git 'home/git.just'
# PKL Module
mod pkl 'home/pkl.just'
# Boot Module
mod boot 'home/boot.just'

# About Constellation Tools
_default:
    @echo '{{ style("warning") }}Workspace Project Tool Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} --list

set unstable

bosh := which("bosh")
[private]
@test:
    echo "bosh: '{{bosh}}'"
    echo "just: '{{which("just")}}'"
    echo "brew: '{{which("brew")}}'"
