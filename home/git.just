# git: Module
_default:
    @echo '{{ style("warning") }}Git Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} --list

# "git pull" foreach git repo in ./dir
[no-cd]
pull:
  @for dir in `ls -d */.git`; do \
        repo=`dirname $dir`; \
        echo "git pull" $repo; \
    git -C $repo pull; \
  done

# "git add" foreach git repo in ./dir
[no-cd]
add src=".":
  @for dir in `ls -d */.git`; do \
        repo=`dirname $dir`; \
        echo "git add" $repo; \
    git -C $repo add {{src}}; \
  done
