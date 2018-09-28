# Powershell

## CLI Works

	Get-ChildItem -Path .\ -Recurse -File -Name | Select-String -Pattern sql	# find all files according to pattern
	Test-NetConnection localhost -Port 80										# check port


## Strings

	Get-Command -? 			# == Get-Help Get-Command
	"Plura`bsight"			# `Plursight` - backspace
	"Plura`nsight"			# Newline
	"Plural`rSight"			# `PluralSight` doesn't show anything
	"Plural`tSight"			# `Plural	Sight` Tabs
	#heretext = @"
	some line1
	some line2"


	somelineN
	"@ 						# like ''' in python

	PS C:\Users> cd c:\
	PS C:\> $items = (Get-ChildItem).Count
	PS C:\> $loc = Get-Location
	PS C:\> "There are $items items are in the folder $loc"
		There are 6 items are in the folder C:\

	PS C:\> "There are `$items items are in the folder `$loc"	# Var works only with double quotes  	
		There are $items items are in the folder $loc

	PS C:\> 'There are $items items are in the folder $loc'
		There are $items items are in the folder $loc

	PS C:\> "There are $((Get-ChildItem).Count) items are in the folder $(Get-Location)"
		There are 6 items are in the folder C:\

	PS C:\> "The 15% tip of a 33.33 dollar bill is $(33.33 * 0.15) dollars"
		The 15% tip of a 33.33 dollar bill is 4.9995 dollars

	PS C:\> "The 15% tip of a 33.33 dollar bill is {0:0.000} dollars" -f (33.33 * 0.15) 			# Formating
		The 15% tip of a 33.33 dollar bill is 5,000 dollars

	PS C:\> "There are {0} items are in the folder {1}" -f $items, $loc
		There are 6 items are in the folder C:\

	PS C:\> "PluralSight" -like "Plural*"
		True
	
	PS C:\> "PluralSight" -like "Plural*[s-v]"					# ends in a char between s and v
		True

	PS C:\> "PluralSight" -like "Plural*[a-c]"					# ends in a char between a and c
		True

	"888-368-1240" -match "[0-9]{3}-[0-9]{3}-[0-9]{4}"			# regular expresion /from 0-9, and expect 3 times
		True


## Array
	PS C:\> $array = "item1", "item2"
	PS C:\> $array[0]
		item1
	PS C:\> $array[1]
		item2

## Branching
	 	switch (3,1,2,42)
	{
	    1 {"one"; break}
	    2 {"two"}
	    3 {"three"}
	    default {"def"}
	}
		three
		one

		for ($f = 0; $f -le 5; $f++)
		{
		    "`$f = $f"
		}
			$f = 0
			$f = 1
			$f = 2
			$f = 3
			$f = 4
			$f = 5