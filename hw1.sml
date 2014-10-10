open Int;

fun is_older(date1: int*int*int, date2: int*int*int) =
    #3 date1 < #3 date2 orelse
    #2 date1 < #2 date2 orelse
    #1 date1 < #1 date2

fun month_in_dates(date: (int * int * int), months: int list) =
    if null months then false
    else
        if #2 date = hd(months) then true
        else month_in_dates(date, tl(months));

fun dates_in_months(dates: (int * int * int) list, months: int list) =
    if null dates then []
    else
        if month_in_dates(hd(dates), months) then [hd(dates)]@dates_in_months(tl(dates), months)
        else dates_in_months(tl(dates), months);

fun dates_in_month(dates: (int * int * int) list, month: int) =
    dates_in_months(dates, [month]);


fun number_in_months(dates: (int * int * int) list, months: int list) =
    length(dates_in_months(dates, months));

fun number_in_month(dates: (int * int * int) list, month: int) =
    number_in_months(dates, [month]);

fun get_nth(coll: string list, nth: int) =
    if nth = 1
    then hd(coll)
    else get_nth(tl(coll), nth-1);

val months = ["January", "February", "March", "April", "May", "June",
              "July", "August", "September", "October", "November", "December"];

fun date_to_string(date: (int * int * int)) =
    get_nth(months, #2 date) ^ " "  ^ toString(#3 date) ^ ", " ^ toString(#1 date);

fun number_before_reaching_sum_index(sum: int, numbers: int list, index: int) =
    if sum - hd(numbers) < 1
    then index
    else number_before_reaching_sum_index(sum - hd(numbers), tl(numbers), index + 1);


fun number_before_reaching_sum(sum: int, numbers: int list) =
    number_before_reaching_sum_index(sum, numbers, 0);

val month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

fun what_month(days: int) =
    number_before_reaching_sum(days, month_days) + 1;

fun month_range(day1: int, day2: int) =
    if day1 > day2
    then []
    else [what_month(day1)]@month_range(day1 + 1, day2);

fun oldest_date(dates: (int * int * int) list, old: (int * int * int)) =
    if null dates orelse is_older(hd(dates), old)
    then oldest_date(tl(dates), old)
    else old;

fun oldest(dates: (int * int * int) list) =
    if null dates
    then NONE
    else SOME(oldest_date(tl(dates), hd(dates)));
