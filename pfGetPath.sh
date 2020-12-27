#!/usr/bin/osascript

# pfgetpath.sh, v0.2 2020.11.15 Mark Vlach
# returns the current Path Finder window path or folder selection path
# https://github.com/mark-ingenosity
#

use AppleScript version "2.4" # Yosemite (10.10) or later
use scripting additions

set thePath to ""

tell application "Path Finder"
	set theSelection to (get selection)

	# If there are one or more items selected, begin by narrowing things down to the
	# first item in the selection.
	if ((count of selection) is not 0) then
		set sourceCandidate to first item of theSelection

		# If the user has selected a folder or disk icon, then make that the target folder
		if (class of sourceCandidate) is disk or (class of sourceCandidate) is fsFolder then
			set thePath to POSIX path of (sourceCandidate)
		else
			# If the user has selected anything else, then make the containing folder the selection
			set thePath to POSIX path of (container of sourceCandidate)
		end if
	end if

	# Otherwise, resort to the folder corresponding to the front-most window
	if (thePath is equal to "") then
		try
			set thePath to the POSIX path of the target of the front finder window
		on error
			set thePath to ""
		end try
	end if
end tell

return thePath
