fun hw1(inPut : string) =
let
   val inStream = TextIO.openIn inPut
in
   TextIO.inputAll inStream
end


type block = {hash :string , prevHash:string};




val blockTest =  {hash = "1",prevHash = "2"} : block;


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

fun saveChainToFile(outPut:string) = let
    val list  = String.concat (List.map (fn x => (Int.toString x) ^ ";" ) newList)
    val outStream = TextIO.openOut outPut
    val _ = TextIO.output (outStream,list)
    val _ = TextIO.closeOut outStream
in
 ()
end





val t = saveChainToFile("vem.txt");
