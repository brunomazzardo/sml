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
