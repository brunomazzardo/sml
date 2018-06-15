(*  Referencias

https://learnxinyminutes.com/docs/standard-ml/
http://sml-family.org/Basis/list.html
https://stackoverflow.com/questions/42148055/sml-how-to-append-an-element-to-a-list-in-sml
https://stackoverflow.com/questions/19805544/sml-difference-between-type-and-datatype
https://en.wikibooks.org/wiki/Standard_ML_Programming/Types
http://sml-family.org/Basis/string.html
https://stackoverflow.com/questions/36527015/how-to-convert-string-to-intand-not-to-int-option-in-sml
https://www.chegg.com/homework-help/questions-and-answers/write-program-sml-reads-inputtxt-file-outputs-outputtxt-file-whether-line-pangram--put-exa-q10645053

Repositorio : https://github.com/brunomazzardo/sml
 *)

(*
Leitura de Arquivo, arquivo formatado em estutrura:
;hash:valor,prevHash:valor;
Exemplo : ;2,0;4,2;8,4;

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
fun createHash(prevHash:int) = prevHash * 2

(*
funcao que cria a um block baseado no bloco anterior da cadeia
*)
fun createBlock(block:block) = ({hash=createHash(#hash block),prevHash=(#hash block)}:block)

(*
Parse de cada elemnto da lista, que e uma tupla de strings, para um objeto block, e a criacao de uma lista de blocks
*)
fun parse [] = []
 |  parse (x::xs) = ({hash=(valOf(Int.fromString(List.nth(x,0)))),prevHash=(valOf(Int.fromString(List.nth(x,1))))} : block)  :: parse xs

(*
Funcao que valida o bloco
*)
fun valida (prevBlock : block ,currentBlock : block) =
 (#hash currentBlock) = createHash(#hash prevBlock) andalso (#prevHash currentBlock) = (#hash prevBlock)


(*
Parecido com o List.all, mas precisava passar dois elementos para a funcao,
entao e uma reimplementacao, ele tambem nao para quando o primeiro da false,
 possivel otimizacao a ser feita
*)
fun validaArray f [] = true
  | validaArray f [x] = true
  | validaArray f (x::y::xs) = f (x,y) andalso validaArray f(y::xs)


(*
Funcao que cria um bloco invalidado, para testar a validacao de chain
*)
fun createInvalidBlock(block:block) = ({hash=createHash((#hash block)-1),prevHash=(#hash block)}:block)

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



  (*
  Funcao que adiciona um bloco novo na cadeia, utilizei de um recurso de reversao da lista para poder adicionar no final
  Versão que adiciona valor invalidado

  *)
  fun addToChainInvalid (blockList : block list) = let
      val lastBlock = List.nth (blockList,((List.length blockList)-1))
      val block = createInvalidBlock(lastBlock)
      val listReverse = List.rev blockList
    in
     List.rev (block :: listReverse)
    end


(*
Funcao que salva a chain no arquivo
*)
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



fun rodaTestesPositivo () =
let
   val a = hw1("input.txt")
   (*
   Proximas linhas envolvem transformar do input de texto para uma lista de block, talvez existam passos que possam ser removidos
   *)
   val aString = String.implode (String.explode a)
   val aStringWithoutn =  String.substring (aString,0,((String.size aString)-1))
   val list  = String.tokens  (fn c=>c = #";") aStringWithoutn
   val listlist = List.map (fn x => (String.tokens (fn c=>c = #",") x )) list
   val parsedList = parse listlist

   val newList = addToChain(addToChain(addToChain(addToChain(addToChain(parsedList)))))
   val passouNovo = validaArray valida newList
   val _ = saveToFile(newList,"output.txt")


in
  validaArray valida newList
end


fun rodaTestesChainInvalida () =
let
   val a = hw1("input.txt")
   (*
   Proximas linhas envolvem transformar do input de texto para uma lista de block, talvez existam passos que possam ser removidos
   *)
   val aString = String.implode (String.explode a)
   val aStringWithoutn =  String.substring (aString,0,((String.size aString)-1))
   val list  = String.tokens  (fn c=>c = #";") aStringWithoutn
   val listlist = List.map (fn x => (String.tokens (fn c=>c = #",") x )) list
   val parsedList = parse listlist

   val newList = addToChainInvalid(parsedList)
   val _ = saveToFile(newList,"output.txt")


in
  validaArray valida newList
end


fun runTestWithOutputAsInput() =
let
    val a = hw1("output.txt")
    (*
    Proximas linhas envolvem transformar do input de texto para uma lista de block, talvez existam passos que possam ser removidos
    *)
    val aString = String.implode (String.explode a)
    val aStringWithoutn =  String.substring (aString,0,((String.size aString)-1))
    val list  = String.tokens  (fn c=>c = #";") aStringWithoutn
    val listlist = List.map (fn x => (String.tokens (fn c=>c = #",") x )) list
    val parsedList = parse listlist

    val newList = addToChain(addToChain(addToChain(addToChain(addToChain(parsedList)))))
    val passouNovo = validaArray valida newList
    val _ = saveToFile(newList,"output.txt")


in
 validaArray valida newList
end

(*Gera uma chain invalida no arquivo, e retorna dizendo que a validacao nao passou*)
val runInvalido = rodaTestesChainInvalida()
(*Gera uma chain valida no arquivo e retorna que a validacao passou*)
val run = rodaTestesPositivo()
(*Faz a leitura do arquivo que foi gerado no teste anterior e continua incrementando a chain*)
val runTestOutput = runTestWithOutputAsInput()
(*Roda a chain invalida novamente para estragar o input*)
val runInvalidoPrepare = rodaTestesChainInvalida()
(* Le o arquivo gerado pelo teste invalido  e tenta adicionar blocos novos *)
val runTestOutputInvalid = runTestWithOutputAsInput()
(*Finaliza o output com dados validos*)
val finaliza = rodaTestesPositivo()
