-- Open in AppleScript Editor and save as Application

tell application "Finder"
	set all_files to every item of (choose file with prompt "Choose the Panorma Files to rename:" with multiple selections allowed) as list
	set filecount to count of all_files
	
	log "Number of files = " & filecount
	
	if filecount is not equal to 42 then
		display alert "42 is a must"
		error number -128
	end if
	
	display dialog "Panorama file name:" default answer "Anafi_Pano"
	set postfix to text returned of result
	
	
	-- special handling for the first two files
	set this_file to item 1 of all_files
	set panofilename to "A" & "_" & postfix & ".jpg" as string
	set the name of this_file to panofilename
	
	set this_file to item 2 of all_files
	set panofilename to "B" & "_" & postfix & ".jpg" as string
	set the name of this_file to panofilename
	
	-- now loop over the remaining 40 files and renumber to a row scheme
	set filenumber to 0
	set fileindex to 3
	
	repeat with i from 1 to 10
		
		repeat with j from 0 to 3
			
			
			-- if odd column than sky is pic 0 and ground pic 3. On even columns order has to be inversed
			if (i mod 2 is 0) then
				set currentrow to 3 - j
			else -- (i mod 2 is 1)
				set currentrow to j
			end if
			
			set filenumber to i + (currentrow * 10) as string
			set panofilename to filenumber & "_" & postfix & ".jpg" as string
			set this_file to item fileindex of all_files
			set the name of this_file to panofilename
			set fileindex to fileindex + 1
			
		end repeat
		
	end repeat
	
	--we are done, display a message
	display alert "Perfect! Renamed all files with " & postfix & "' for you. Enjoy your panorama"
end tell