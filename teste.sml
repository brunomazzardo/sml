fun hw1(inPut : string) =
let
   val inStream = TextIO.openIn inPut
in
   TextIO.inputAll inStream
end

val a = hw1("input.txt");

val list  = String.explode a;

val element = #"t"

val anotheranotherList = element::list;


fun valida x  = if x <> 19 then true else false;

fun toInteger  x =  (Char.ord x) - 48;

val newList = List.map toInteger anotheranotherList;

fun aplicaHash  x = x + 4567;

val newList = List.map aplicaHash newList;

val passou = List.all valida newList;
