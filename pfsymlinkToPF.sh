#!/usr/bin/osascript

# pfsymlinkToPF.sh, v0.2 2020.11.15 Mark Vlach
# shell script to create symlinks from a terminal command line
# at the currently active Path Finder window pane
# https://github.com/mark-ingenosity
#
#
use AppleScript version "2.4" # Yosemite (10.10) or later
use scripting additions

on run argv
	# debug: simulate passing args in argv #
	# set argv to "/Users/mavlach/Cache/1/test-files-folders/1.rtf,/Users/mavlach/Cache/1/test-files-folders/3"

	# SymLink Extension: customize this to your liking
	set symlink_extension to ""

	tell application "Path Finder"
		# get the path of the active Path Finder window pane
		set destPath to the POSIX path of the target of the front finder window

		# get the arguments as a single comma delimeted string and split it to a list
		set argv to my splitString(argv as rich text, ",")

		# iterate over the args list and create the symlinks
		repeat with srcFilePath in argv
			try
				# if an ending slash exists, strip it from the path
				if srcFilePath ends with "/" then set srcPath to rich text 1 thru -2 of srcFilePath

				# extract the file/folder name from the item's path
				set srcName to name of (info for srcFilePath)

				# generate the POSIX path of the desired symbolic link
				set destSymlink to destPath & "/" & srcName & symlink_extension
				if my fileExists(destSymlink) then
					error "File exists: " & destSymlink
				else
					# Create the symlink or throw an ln error if there's a problem
					do shell script "ln -s " & quoted form of srcFilePath & " " & quoted form of (destSymlink & symlink_extension)
				end if
			on error errMsg number errorNumber
				# if there was an unexpected error, log msg to stderr and continue
				log errMsg & " (" & errorNumber & ")" as rich text
			end try

		end repeat

	end tell
end run

on splitString(theString, delimiter)
	set AppleScript's text item delimiters to delimiter
	set theString to theString's text items
	set AppleScript's text item delimiters to {""} #> restore delimiters to default value
	return theString
end splitString

on fileExists(theFile)
	try
		POSIX file (POSIX path of theFile) as alias
		return true
	on error
		return false
	end try
end fileExists
