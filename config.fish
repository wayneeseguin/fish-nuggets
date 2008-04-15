set PATH $PATH ~/bin
set EDITOR "mate"

function parse_git_branch
	sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function parse_svn_revision
	sh -c 'svn info 2> /dev/null' | sed -n '/^Revision/p' | sed -e 's/^Revision: \(.*\)/\1/'
end

function fish_prompt -d "Write out the prompt"
	printf '%s%s@%s%s' (set_color brown) (whoami) (hostname|cut -d . -f 1) (set_color normal) 

	# Color writeable dirs green, read-only dirs red
	if test -w "."
		printf ' %s%s' (set_color green) (prompt_pwd)
	else
		printf ' %s%s' (set_color red) (prompt_pwd)
	end

	# Print subversion revision
	if test -d ".svn"
		printf ' %s%s@%s' (set_color normal) (set_color blue) (parse_svn_revision)
	end

	# Print git branch
	if test -d ".git"
		printf ' %s%s/%s' (set_color normal) (set_color blue) (parse_git_branch)
	end
	printf '%s> ' (set_color normal)
end

set BROWSER open

function cdt -d "Change to tinde directory"
  cd ~/tinde_git
end

bind \cr "rake"

function ss -d "Run the script/server"
	script/server
end

function sc -d "Run the Rails console"
	script/console
end