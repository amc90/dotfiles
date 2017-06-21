Basically, "setup.sh <homedir> -a" will:
  * Back up every file in <homedir> that has an entry in link_targets or link_targets.local
  * Replace the file in <homedir> with a link to link_targets.local (if it exists - put special case overrides here), or link_targets

Use "setup.sh <homedir>" to do a dry run.
