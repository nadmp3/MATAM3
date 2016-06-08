#! /usr/local/bin/tcsh -f

set line = ($<)
if (${#line} != 0) then
set sum = 0
set data_file = $1
set count = 0
set line_number = $line[2]
while (${#line} != 0)
	if($line[2] == $line_number) then
		@ sum= $sum + $line[4]
		@ count = $count + 1
		@ line_number = $line[2]
	else 
		@ sum=$sum / $count
		if ($2 < 6) then
			set company = `grep $line_number $data_file`
			echo $line_number $sum $company[2]
		else echo $line_number $sum
		endif
		@ sum=$line[4]
		@ count = 1
		@ line_number = $line[2]
	endif
	
	set line = ($<)
end
@ sum=$sum / $count
if ($2 < 6) then
	set company = `grep $line_number $data_file`
	echo $line_number $sum $company[2]
else echo $line_number $sum
endif
endif
