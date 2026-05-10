---
name: jj
description: jj (Jujutsu) command reference, best practices and workflow guide.
---

# jj (Jujutsu)

## Core Concepts

jj automatically commits working copy changes, unlike Git. Changes are recorded when running commands like `jj status`.

- New files are tracked automatically (unless in `.gitignore`)
- No concept of "current branch"
- Bookmarks (equivalent to Git branches) are created only when needed

## Basic Workflow

```bash
# Check status
jj status
jj log

# Add commit message (changes are auto-committed)
jj describe -m "message"

# Start new change (finalize current and move on)
jj new

# Edit previous commit
jj new @-          # Move to parent
# ... edit ...
jj squash          # Merge into child
```

## GitHub PR Workflow

### Create bookmark and push

```bash
# Option 1: Auto-generated name (push-xxxx)
jj git push -c @-

# Option 2: Explicit naming
jj bookmark create feature-name -r @-
jj git push
```

### Update PR (address review comments)

```bash
# Option 1: Add commits (preserve history)
# Add new commits and push

# Option 2: Amend commits (rewrite history)
jj new @-              # Move to child of target commit
# ... fix ...
jj squash              # Merge into parent
jj git push --bookmark feature-name  # force push
```

### Sync with remote

```bash
jj git fetch
jj rebase -d main      # Rebase onto latest main
```

## Command Reference

| Purpose                       | Command                                | What it does                                                      |
| ----------------------------- | -------------------------------------- | ----------------------------------------------------------------- |
| **See changes**               | `jj status`                            | Show working-copy commit and staged/unstaged file modifications   |
| **Browse history**            | `jj log`                               | One-line graph of commits; add `-r : --git` to include Git hashes |
| **Diff current work**         | `jj diff`                              | Compare working-copy commit to its parent (like `git diff`)       |
| **Start a new change**        | `jj new`                               | Fork a fresh change from `@` (no checkout dance)                  |
| **Write/update message**      | `jj describe -m "msg"`                 | Sets commit message of the working change                         |
| **Split hunks interactively** | `jj split`                             | Launches diff-editor to carve current change into smaller ones    |
| **Squash into parent**        | `jj squash`                            | Merge current changes into parent commit                          |
| **Discard commit**            | `jj abandon`                           | Abandon the current change                                        |
| **Undo last (or any) op**     | `jj undo`                              | Reverts the specified operation in the op-log                     |
| **List operations**           | `jj op log`                            | Shows numbered operation history for quick undo/restore           |
| **Show all commits**          | `jj log -r 'all()'`                    | Include all revisions in log                                      |
| **Push**                      | `jj git push`                          | Push bookmarks to remote                                          |
| **Pull / rebase**             | `jj git fetch`                         | Fetch from remote                                                 |
| **List bookmarks**            | `jj bookmark list`                     | Display bookmarks pointing at changes                             |
| **Create bookmark**           | `jj bookmark create feature`           | Label current change as *feature*                                 |
| **Move bookmark**             | `jj bookmark set feature REV`          | Point bookmark *feature* at another revision                      |
| **Delete bookmark**           | `jj bookmark delete feature`           | Remove bookmark label                                             |

## Conflict Resolution

Conflicts are embedded as markers in files. No need to resolve all at once.

```bash
# Create new commit with conflicts
jj new
# ... resolve ...
jj squash   # Merge resolution into original commit
```

## Safety Net

- `jj op restore <op-id>` — time-travel repo back to any previous operation
- Everything is undoable; when in doubt, run `jj op log` followed by `jj undo`

## Automation Tips

- Pass `--no-editor` on `describe`, `split`, etc., in headless scripts
- Prefer `--template '{id} {description|escape_json}\n'` for JSON-friendly output

## Notes

- `jj git push --all` pushes bookmarks only (not all revisions)
- Exclude `.jj/**` from watch in Vite/Vitest
- Resolve bookmark conflicts with `jj bookmark move <name> --to <commit>`
