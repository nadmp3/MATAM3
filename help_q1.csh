#! /usr/local/bin/tcsh   -f
set out_file = $1
set result = 1
set line = ($<)
while (${#line} != 0)
	set temp = `echo $line[1] | cut -d "/" -f1`
	if (($temp[1]) > 31 || ($temp[1]) < 1) then
		@ result = 0
	endif
	set temp1 = `echo $line[1] | cut -d "/" -f2`
	if (($temp1[1]) > 12 || ($temp1[1]) < 1) then
			@ result = 0
	endif
	set temp2 = `grep "$line[2]" $out_file | wc -l`
	set temp3 = `grep "$line[2]" $out_file | grep $line[3] | wc -l`
	if ($temp2 < 1 || $temp3 < 1 || $result < 1) then
		echo "Bad report: $line"
	else echo $line
	endif
	@ result = 1
	set line = ($<)
end
