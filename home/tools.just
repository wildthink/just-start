# tools: Module
_default:
    @echo '{{ style("warning") }}Available Tools{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo "*Install with" '{{ style("warning") }}"just tools::install"{{ NORMAL }}'
    @echo ""
    @just -n tools::install


# Install Tools

# FIXME: pre-check, pkl list

# Install all the tools
install:
    brew install dasel
    brew install pkl
    brew install fzf
