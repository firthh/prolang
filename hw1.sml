fun is_older(date1: int*int*int, date2: int*int*int) =
    #3 date1 < #3 date2 orelse
    #2 date1 < #2 date2 orelse
    #1 date1 < #1 date2;

fun month_is_date(date: (int * int * int), month: int) =
    #2 date = month;

fun private_number_in_month(dates: (int * int * int) list, month: int, total: int) =
    if null dates then total
    else
        if month_is_date(hd(dates), month) then private_number_in_month(tl(dates), month, total + 1)
        else private_number_in_month(tl(dates), month, total);

fun number_in_month(dates: (int * int * int) list, month: int) =
    if null dates then 0
    else
        if month_is_date(hd(dates), month) then 1 + number_in_month(tl(dates), month)
        else number_in_month(tl(dates),month);
(*    private_number_in_month(dates, month, 0);*)
