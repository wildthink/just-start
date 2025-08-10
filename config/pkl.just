# pkl: Module

dir := justfile_directory()
config := source_directory() + '/../'
pkl_dir := config + "pkls"


_default:
    @echo '{{ style("warning") }}PKL Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} -l

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
pickle file='workspace':
    pkl eval -f json -o '{{config}}/{{file}}.json' '{{pkl_dir}}/{{file}}.pkl'

# pkl-gen-swift pkl files
swift file='workspace':
    pkl-gen-swift  -o '{{dir}}/Generated' '{{pkl_dir}}/{{file}}.pkl'
