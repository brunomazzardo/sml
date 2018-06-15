(*  Referencias

https://learnxinyminutes.com/docs/standard-ml/
http://sml-family.org/Basis/list.html
https://stackoverflow.com/questions/42148055/sml-how-to-append-an-element-to-a-list-in-sml
https://stackoverflow.com/questions/19805544/sml-difference-between-type-and-datatype
https://en.wikibooks.org/wiki/Standard_ML_Programming/Types
http://sml-family.org/Basis/string.html
https://www.chegg.com/homework-help/questions-and-answers/write-program-sml-reads-inputtxt-file-outputs-outputtxt-file-whether-line-pangram--put-exa-q10645053

Repositorio : https://github.com/brunomazzardo/sml
 *)


fun hw1(inPut : string) =
let
   val inStream = TextIO.openIn inPut
in
   TextIO.inputAll inStream
end


type block = {hash :int , prevHash:int};

fun createHash(prevHash:int) = prevHash * prevHash


fun createBlock(block:block) = ({hash=createHash(#hash block),prevHash=(#hash block)}:block)


val blockTest =  {hash = 3,prevHash = 1} : block;


val newBlock = createBlock(blockTest)

val a = hw1("input.txt");


val aString = String.implode (String.explode a)

val aStringWithoutn =  String.substring (aString,0,((String.size aString)-1))

val list  = String.tokens  (fn c=>c = #";") aStringWithoutn


val listlist = List.map (fn x => (String.tokens (fn c=>c = #",") x )) list




fun intFromString s default_i =
    Option.getOpt (Int.fromString s, default_i)

fun parse [] = []
 |  parse (x::xs) = ({hash=(valOf(Int.fromString(List.nth(x,0)))),prevHash=(valOf(Int.fromString(List.nth(x,1))))} : block)  :: parse xs

val vamogremio = parse listlist


val hash = List.nth (vamogremio,0)


fun valida (x : block ,y : block) =  (#hash y) = createHash(#hash x) andalso (#prevHash y) = (#hash x)


fun validaArray f [] = true
  | validaArray f [x] = true
  | validaArray f (x::y::xs) = f (x,y) andalso validaArray f xs


val passou =  validaArray valida vamogremio

fun addToChain (blockList : block list) = let
    val lastBlock = List.nth (blockList,((List.length blockList)-1))
    val block = createBlock(lastBlock)
    val listReverse = List.rev blockList
  in
   List.rev (block :: listReverse)
  end



val newBlockList = addToChain(vamogremio)
