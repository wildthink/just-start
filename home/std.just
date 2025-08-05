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
