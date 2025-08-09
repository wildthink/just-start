# pkl: Module

dir := justfile_directory()
config := justfile_directory()/"config"

_default:
    @echo '{{ style("warning") }}PKL Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} -l

foo:
  echo {{config}}

# Edit this file
edit:
	@just -e -f {{source_file()}}

# PKL eval pkls
workspace: (pickle "workspace")
alias ws := workspace

# PKL Documentation
man:
  @open "https://pkl-lang.org/main/current/index.html"

# Pickle - PKL eval
pickle file='main':
    pkl eval -f json -o  '{{config}}/space.json' '{{config}}/pkls/workspace.pkl'

# pkl-gen-swift pkl files
swift file='workspace':
    pkl-gen-swift  -o '{{dir}}/Generated' '{{config}}/pkls/workspace.pkl'
