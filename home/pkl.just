# pkl: Module
_default:
    @echo '{{ style("warning") }}PKL Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} -l


# PKL eval pkls
workspace: (pickle "workspace")
alias ws := workspace

#  pkl eval -f json -o foo pkls/workspace.pkl

dir := justfile_directory()

# Pickle - PKL eval
pickle file='main':
    @pkl eval -f json -o  {{dir}}/config/space.json {{dir}}/pkls/workspace.pkl
