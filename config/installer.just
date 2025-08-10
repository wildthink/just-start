# installer: Module
_default:
    @echo '{{ style("warning") }}Install Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo "*Install with" '{{ style("warning") }}"just tools::install"{{ NORMAL }}'
    @echo ""
    @just -f {{source_file()}} -n install

# Edit this file
edit:
	@just -e -f {{source_file()}}

# Install Tools

# FIXME: pre-check, pkl list

# Install using brew if missing
brew TOOL:
	#!/bin/bash
	if which {{TOOL}} >/dev/null 2>&1; then
	    echo "{{TOOL}} is installed and in PATH."
	else
	    echo "{{TOOL}} is NOT installed or not in PATH."
	    brew install {{TOOL}}
	fi

# Install the Repos
[group("Installs")]
[no-cd]
repos dir:
  #!/usr/bin/env -S python3 -u
  import json, subprocess as sp
  from pathlib import Path

  JUST_DIR = Path("{{source_directory()}}").resolve()
  TARGET   = JUST_DIR / "{{dir}}"
  CONFIG   = JUST_DIR / "workspace.json"
  KEY      = "{{dir}}"  # JSON array key matches the dir param

  def run(*args, check=False, **kw):
    return sp.run(args, text=True, capture_output=True, check=check, **kw)

  def is_git_repo(path: Path) -> bool:
    return (path / ".git").exists()

  def has_head(path: Path) -> bool:
    r = run("git","-C",str(path),"rev-parse","--verify","HEAD")
    return r.returncode == 0

  def clean_worktree(path: Path) -> bool:
    # Safe even if s no HEAD
    if not has_head(path):
      return False
    r = run("git","-C",str(path),"diff","--quiet","--ignore-submodules","HEAD")
    return r.returncode == 0

  def ensure_submodules(path: Path):
    run("git","-C",str(path),"submodule","update","--init","--recursive")

  def repo_name(url: str) -> str:
    name = url.rstrip("/").split("/")[-1]
    return name[:-4] if name.endswith(".git") else name

  def main():
    print(TARGET.name)
    TARGET.mkdir(parents=True, exist_ok=True)

    try:
      data = json.loads(CONFIG.read_text())
    except Exception as e:
      print(f"Error: cannot read {CONFIG}: {e}")
      return

    entries = data.get(KEY, [])
    repos   = [p["repo"] for p in entries if isinstance(p, dict) and "repo" in p]

    for url in repos:
      name = repo_name(url)
      path = TARGET / name

      # Clone if missing
      if not path.exists():
        print(f"Cloning {name}")
        # NOTE: Shallow clone (depth=1) for efficiency
        r = run("git","-C",str(TARGET),"clone","--depth=1",url)
        if r.returncode != 0:
          print(f"  Clone failed for {name}: {r.stderr.strip() or r.stdout.strip()}")
          continue
        ensure_submodules(path)
        continue

      # If present but not a git repo, skip safely
      if not is_git_repo(path):
        print(f"Skipping {name}: exists but is not a git repo")
        continue

      # Update existing repo; handle errors gracefully
      print(f"Updating {name}")
      if not clean_worktree(path):
        print("  Working tree dirty or unborn  skipped")
        continue

      r = run("git","-C",str(path),"fetch","--all","--prune")
      if r.returncode != 0:
        print(f"  Fetch failed: {r.stderr.strip() or r.stdout.strip()}")
        continue

      r = run("git","-C",str(path),"pull","--ff-only")
      if r.returncode != 0:
        print(f"  Pull not fast-forward: {r.stderr.strip() or r.stdout.strip()}")
        continue

      ensure_submodules(path)

  if __name__ == "__main__":
    main()
