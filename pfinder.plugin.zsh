# pfinder.plugin.zsh, Mark Vlach 2020.11.15
# Some handy oh-my-zsh commandline tools for Mac Path Finder
# https://github.com/mark-ingenosity

# Returns the absolute path of the plugin dir. Need this in
# order to call other scripts located in the plugin folder
plugindir=$(dirname "$0")

# Return the path of the current Path Finder window
function ppd() {
  osascript 2>/dev/null <<APPLESCRIPT
    tell application "Path Finder"
			return POSIX path of the target of the front finder window
    end tell
APPLESCRIPT
}

# Return a list of the current Path Finder selections
function psl() {
  osascript 2>/dev/null <<APPLESCRIPT
		set output to ""
		tell application "Path Finder"
			set theSelection to (get selection)
	    set itemCount to count theSelection
	    repeat with itemIndex from 1 to count theSelection
	      if itemIndex is less than itemCount then set theDelimiter to "\n"
	      if itemIndex is itemCount then set theDelimiter to ""
	      set output to output & the POSIX path of (item itemIndex of theSelection) & theDelimiter
	    end repeat
		end tell
		return output
APPLESCRIPT
}

# Copy a single line list of quoted Path Finder selections to the clipboard.
function psc() {
  osascript 2>/dev/null <<APPLESCRIPT
		set output to ""
		tell application "Path Finder"
			set theSelection to (get selection)
	    set itemCount to count theSelection
	    repeat with itemIndex from 1 to count theSelection
	      if itemIndex is less than itemCount then set theDelimiter to " "
	      if itemIndex is itemCount then set theDelimiter to ""
				set curSel to the POSIX path of (item itemIndex of theSelection)
	      set output to output & the quoted form of curSel & theDelimiter
	    end repeat
		end tell
		set the clipboard to output
APPLESCRIPT
}

# Change the Path Finder directory to the current terminal working directory
function pcd() {
	osascript - "$PWD" 2>/dev/null <<-APPLESCRIPT
		on run argv
			set targetDir to POSIX path of (item 1 of argv)
			tell application "Path Finder" to PFopen the POSIX file (targetDir) as alias
		end run
APPLESCRIPT
}

# Change the terminal working directory to the current Path Finder window or selected folder
function cdp() {
  cd "$(osascript 2>/dev/null "${plugindir}/pfGetPath.sh")"
}

# Push the terminal working directory to the current Path Finder window or selected folder
function pushdp() {
  pushd "$(osascript 2>/dev/null "${plugindir}/pfGetPath.sh")"
}

# Create symbolic links in Path Finder from files/folders specified on the command line
# Usage: lnpf <file1> <file2>...
function lnpt() {
  # expand any relative commmand line args to absolute paths needed
  # for running 'ln -s' in the applescript pfsymlinkToPF.sh
	args=""
	for arg in $@; do
		# convert relative arg to absolute path
		arg=$(print -r -- $arg:P)
		# recombine the args to a comma delimited list for handoff to the applescript
		args="${args}${args:+,}$arg"
	done
	"${plugindir}/pfsymlinkToPF.sh" $args
}

# Create symbolic links from Path Finder selections at the directory specified on the
# terminal command line.
# Usage: lnpf <dir>
function lnpf() {
	"${plugindir}/pfsymlinkFromPF.sh" $@
}

# toggle view of hidden files in Path Finder
function thp() {
  osascript 2>/dev/null <<APPLESCRIPT
	tell application "System Events"
			tell process "Path Finder"
				set frontmost to true
				click menu item "Show Invisible Files" of menu "View" of menu bar 1
			end tell
		end tell
APPLESCRIPT
}

