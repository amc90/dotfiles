Basically, "./setup.sh -a ~" will:
  * Back up every file in ~ that has an entry in link_targets or link_targets.local
  * Replace the file in ~ with a link to link_targets.local (if it exists - put special case overrides here), or link_targets

Use "setup.sh ~" to do a dry run.
