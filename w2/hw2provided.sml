(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* put your solutions for problem 2 here *)

fun map(coll, f) =
    case coll of
        [] => []
     | x::xs' => [(f(x))]@(map(xs', f))

fun reduce (coll, f, acc) =
    case coll of
        [] => acc
      | x::xs' => reduce(xs', f, f(x, acc))

fun filter ([], f) = []
  | filter (x::xs', f) = if f(x)
                         then [x]@(filter(xs', f))
                         else filter(xs', f)

fun is_in (word: string, coll: string list) =
    length (filter (coll, (fn w => same_string(w, word)))) > 0


fun all_except_option (s1: string, xs: string list) =
    if is_in(s1, xs)
    then SOME (filter (xs, (fn w => not( same_string( w, s1 )))))
    else NONE

fun get_substitutions1 (subs: string list list, word: string) =
    case subs of
        [] => []
      | x::xs' => if is_in(word, x)
                  then case all_except_option(word, x) of
                           NONE => get_substitutions1(xs', word)
                         | SOME y => y@get_substitutions1(xs', word)
                  else get_substitutions1(xs', word)

fun get_subs (word: string, subs: string list) =
    if is_in(word, subs)
    then case all_except_option(word, subs) of
             NONE => []
           | SOME y => y
    else []

fun get_substitutions2 (subs: string list list, word: string) =
    let fun f (subs: string list list, word: string, acc: string list)  =
            case subs of
                [] => acc
              | x::xs' => f(xs', word, acc@(get_subs(word, x)))
    in
        f(subs, word, [])
    end

fun replace_similar_first_names (similar_first_names: string list, name: {first:string, last:string, middle:string}) =
    case similar_first_names of
    [] => []
  | x::xs' => [{first=x, last= #last name, middle = #middle name}]@replace_similar_first_names(xs', name)

fun similar_names (subs: string list list, name: {first:string, last:string, middle:string}) =
    let val similar_names = get_substitutions2(subs, #first name)
    in
        [name]@replace_similar_first_names(similar_names, name)
    end

fun card_color (c: card) =
    case #1 c of
        Clubs => Black
     | Diamonds => Red
     | Hearts => Red
     | Spades => Black

fun card_value (c: card) =
    case #2 c of
        Num x => x
     | Ace => 11
     | King => 10
     | Queen => 10
     | Jack => 10

fun remove_card (cs: card list, c: card, e: exn) =
    case cs of
        [] => raise e
     | x::xs' => if c = x
                 then xs'
                 else [x]@(remove_card(xs', c, e))

fun card_is_color(c: card, col: color option) =
    case col of
        NONE => NONE
      | SOME y =>  if card_color(c) = y
                   then col
                   else NONE

fun all_same_color (cards: card list) =
    case cards of
        [] => true
     | x::xs' => case reduce(cards, card_is_color, SOME(card_color(x))) of
                     NONE => false
                   | SOME y => true
