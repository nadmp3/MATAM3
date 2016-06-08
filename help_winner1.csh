#! /usr/local/bin/tcsh   -f

set time = 0
set people = 0
set count = 0
set line_num = $1
set line = ($<)
while (${#line} != 0)
	if ($line[1] != "Bad" && $line[2] =~ $line_num) then
		@ time = $time + $line[4]
		@ count = $count + 1
		@ people = $people + $line[5]
	endif
	set line = ($<)
end
if ($count != 0) then
	@ time = $time / $count
endif
echo $time $people
