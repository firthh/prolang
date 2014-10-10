open Int;

fun is_older(date1: int*int*int, date2: int*int*int) =
    #3 date1 < #3 date2 orelse
    #2 date1 < #2 date2 orelse
    #1 date1 < #1 date2;

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
