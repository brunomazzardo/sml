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

(*
Leitura de Arquivo
*)
fun hw1(inPut : string) =
let
   val inStream = TextIO.openIn inPut
in
   TextIO.inputAll inStream
end

(*
Definicao do tipo block
*)
type block = {hash :int , prevHash:int};


(*
funcao que cria a hash baseada na hash antiga, pode ser mudada para levar data em conta
*)
fun createHash(prevHash:int) = prevHash * prevHash

(*
funcao que cria a um block baseado no bloco anterior da cadeia
*)
fun createBlock(block:block) = ({hash=createHash(#hash block),prevHash=(#hash block)}:block)


val blockTest =  {hash = 3,prevHash = 1} : block;


val newBlock = createBlock(blockTest)

val a = hw1("input.txt");



(*
Proximas linhas envolvem transformar do input de texto para uma lista de block, talvez existam passos que possam ser removidos
*)
val aString = String.implode (String.explode a)

val aStringWithoutn =  String.substring (aString,0,((String.size aString)-1))

val list  = String.tokens  (fn c=>c = #";") aStringWithoutn


val listlist = List.map (fn x => (String.tokens (fn c=>c = #",") x )) list




fun intFromString s default_i =
    Option.getOpt (Int.fromString s, default_i)

fun parse [] = []
 |  parse (x::xs) = ({hash=(valOf(Int.fromString(List.nth(x,0)))),prevHash=(valOf(Int.fromString(List.nth(x,1))))} : block)  :: parse xs


val vamogremio = parse listlist


(*
Teste de acesso a lista, retorna um bloco
*)
val hash = List.nth (vamogremio,0)



(*
Funcao que valida o bloco
*)
fun valida (prevBlock : block ,currentBlock : block) =  (#hash currentBlock) = createHash(#hash prevBlock) andalso (#prevHash currentBlock) = (#hash prevBlock)


(*
Parecido com o List.all, mas precisava passar dois elementos para a funcao,
entao e uma reimplementacao, ele tambem nao para quando o primeiro da false,
 possivel otimizacao a ser feita
*)
fun validaArray f [] = true
  | validaArray f [x] = true
  | validaArray f (x::y::xs) = f (x,y) andalso validaArray f xs


val passou =  validaArray valida vamogremio



(*
Funcao que adiciona um bloco novo na cadeia, utilizei de um recurso de reversao da lista para poder adicionar no final
*)
fun addToChain (blockList : block list) = let
    val lastBlock = List.nth (blockList,((List.length blockList)-1))
    val block = createBlock(lastBlock)
    val listReverse = List.rev blockList
  in
   List.rev (block :: listReverse)
  end



val newBlockList = addToChain(vamogremio)
val newBlockList = addToChain(newBlockList)
val newBlockList = addToChain(newBlockList)
val passouNovo =  validaArray valida newBlockList



fun saveToFile(blockList: block list, path :string) =
let
  val outStream = TextIO.openOut path
  fun helper ([]:block list) = ""
    | helper ((x::xs):block list) = Int.toString(#hash x) ^ "," ^ Int.toString(#prevHash x) ^ ";" ^ helper(xs)
  val list =  helper(blockList)
  val _ = TextIO.output (outStream,list)
  val _ = TextIO.closeOut outStream

in
 ()
end


val _ = saveToFile(newBlockList,"veeeeeeeeeeem")
