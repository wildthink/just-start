# pkl: Module
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

#  pkl eval -f json -o foo pkls/workspace.pkl

dir := justfile_directory()

# PKL Documentation
man:
  @open "https://pkl-lang.org/main/current/index.html"

# Pickle - PKL eval
pickle file='main':
    @pkl eval -f json -o  {{dir}}/config/space.json {{dir}}/pkls/workspace.pkl

# pkl-gen-swift pkl files
swift file='workspace':
    @pkl-gen-swift  -o {{dir}}/Generated {{dir}}/pkls/workspace.pkl
