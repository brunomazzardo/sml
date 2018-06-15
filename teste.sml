fun hw1(inPut : string) =
let
   val inStream = TextIO.openIn inPut
in
   TextIO.inputAll inStream
end


type block = {hash :int , prevHash:int};

val blockTest =  {hash = 1,prevHash = 1} : block;


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


fun valida (x : block ,y : block) = (#hash x) = (#prevHash y)


fun validaArray f [] = true
  | validaArray f [x] = true
  | validaArray f (x::y::xs) = f (x,y) andalso validaArray f xs


val passou =  validaArray valida vamogremio

fun addToChain (hashValue : int,blockList : block list) = let
    val lastBlock = List.nth (blockList,((List.length blockList)-1))
    val block = ({hash=hashValue,prevHash = #hash lastBlock} :block)
    val listReverse = List.rev blockList
  in
   List.rev (block :: listReverse)
  end



val newBlockList = addToChain(1,vamogremio)
