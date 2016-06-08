#! /usr/local/bin/tcsh   -f

set report_file = $1
set data_file = $2
set min_time = 0
set passenger = 0
set line = ($<)
if (${#line} != 0) then
	set last_company = $line[2]
	set line_number = $line[1]
	set result = `source validate_input $report_file $data_file | grep $line_number | source help_winner1.csh`
	@ min_time = 10000
	@ passenger = 0
	set line = ($<)
	while (${#line} != 0)
	set company = $line[2]
	set check = `source validate_input $report_file $data_file | grep $line[1] | wc -l`
	if ($check != 0) then 
		set result = `source validate_input $report_file $data_file | grep $line[1] | source help_winner1.csh $line[1]`
		if ($company == $last_company) then
			if ($min_time > $result[1]) then
				@ min_time = $result[1]
				@ passenger = $result[2]
				@ line_number = $line[1]
			endif
			if ($min_time == $result[1]) then
				if ($passenger > $result[2] && $line_number > $line[1]) then
					@ min_time = $result[1]
					@ passenger = $result[2]
					@ line_number = $line[1]
				endif
			endif
		else
			set check = `source validate_input $report_file $data_file | grep $line_number | wc -l`
			if ($check != 0) echo $line_number $min_time $passenger $last_company
			@ line_number = $line[1]
			@ min_time = $result[1]
			@ passenger = $result[2]
		endif
	else
		if ($company != $last_company) then
			set check = `source validate_input $report_file $data_file | grep $line_number | wc -l`
			if ($check != 0) echo $line_number $min_time $passenger $last_company
			@ line_number = $line[1]
			@ min_time = 10000
			@ passenger = 0
		endif
	endif
	set last_company = $line[2]
	set line = ($<)
	end
	set check = `source validate_input $report_file $data_file | grep $line_number | wc -l`
	if ($check != 0) echo $line_number $min_time $passenger $company
endif
	
