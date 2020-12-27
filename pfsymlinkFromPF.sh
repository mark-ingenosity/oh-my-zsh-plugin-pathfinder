#!/usr/bin/osascript

# pfsymlinkFromPF.sh, v0.2 2020.11.15 Mark Vlach
# shell script to create symlinks from selected files/folders in
# Path Finder at the target directory specified on the command line
# https://github.com/mark-ingenosity
#
#
use AppleScript version "2.4" # Yosemite (10.10) or later
use scripting additions

on run argv

	# get the target directory from the command line
	# if empty, exit with log
	if (count of (argv)) = 0 then
		log "Target directory not specified."
		return
	end if
	set targetDir to quoted form of (item 1 of argv)

	tell application "Path Finder"

		# get the items selected in the current browser window
		set selFiles to (get selection)

		# quit if nothing is selected
		if (count of (selection)) = 0 then
			log "Nothing selected in Path Finder."
			return
		else
			repeat with selFile from 1 to count selFiles
				try
					# get the posix path of the selected item
					set selFile to POSIX path of (item selFile of selFiles)

					# if an ending slash exists, strip it from the path
					if selFile ends with "/" then set selFile to rich text 1 thru -2 of selFile

					# create the symbolic link at target or throw an error if there's a problem
					do shell script "ln -s " & quoted form of selFile & " " & targetDir

				on error errMsg number errorNumber
					# if there was an unexpected error, log msg to stderr and continue
					log errMsg & " (" & errorNumber & ")" as rich text
				end try
			end repeat
		end if

	end tell
end run
