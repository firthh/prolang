fun is_older(date1: int*int*int, date2: int*int*int) =
    #3 date1 < #3 date2 orelse
    #2 date1 < #2 date2 orelse
    #1 date1 < #1 date2;

fun month_in_dates(date: (int * int * int), months: int list) =
    if null months then false
    else
        if #2 date = hd(months) then true
        else month_in_dates(date, tl(months));

fun number_in_months(dates: (int * int * int) list, months: int list) =
    if null dates then 0
    else
        if month_in_dates(hd(dates), months) then 1 + number_in_months(tl(dates), months)
        else number_in_months(tl(dates),months);

fun number_in_month(dates: (int * int * int) list, month: int) =
    number_in_months(dates, [month]);
