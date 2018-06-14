# sml
Trabalho T4 - Paradigma Funcional - Enunciado (Arquivo: 2018/1)
Enunciado
Escrever um conjunto de funções em ML que permita processar blocos encadeados (blockchains) em um arquivo de entrada e a realização de operações com a geração de um arquivo de saída com os blocos atualizados a partir de uma única aplicação de função sobre o nome do arquivo de entrada. Os dados devem ser corretos em comparação com o formato da implementação de referência em Java.

Blocos Encadeados

O encadeamento de blocos ou blocos encadeados (blockchain) é uma técnica que permite manter registros de forma pública porém com difícil adulteração. Cada bloco é anotado com a chave criptografada do bloco anterior, o que dificulta a alteração de dados nos blocos. A tecnologia é empregada em moedas eletrônicas como o BitCoin.

Três operações principais fazem parte da estrutura: inclusão, verificação e mineração.

O sistema desenvolvido deve apresentar as mesmas funções da implementação de referência em Java. As duas principais dificuldades técnicas são o uso da notação JSON e a criptografia SHA256, que devem ser obtidas por meio de biblioteca de terceiros ou aproximadas com implementação simplificada.

Avaliação
Os itens abaixo serão avaliados:

a. [1 pt] ler blocos de arquivo em formato JSON, compatível com a implementação em Java
Ler o arquivo indicado e armazenar o conteúdo em memória (texto, lista, tupla ou registro).

b. [1 pt] gravar blocos no arquivo
Escrever a cadeia de blocos em arquivo.

c. [1 pt] incluir bloco no encadeamento
Realizar um operação de inclusão e atualizar o encadeamento.

d. [2 pt] confirmar a validade do encadeamento
Processar o encadeamento e localizar falhas no encadeamento.

e. [2 pt] minerar o bloco do final da cadeia

Realizar a mineração do bloco, considerando o uso de um ocasionalismo (nonce).

e. [1 pt] manter repositório privado com tarefas

Um commit por tarefa, [OPCIONAL: um branch e um merge por tarefa,] uma pessoa por tarefa, uma tarefa por pessoa de cada vez.

f. [1 pt] listar ao menos cinco referências consultadas 
Indicadas no código fonte em comentário (livros, vídeos, manuais, StackOverflow etc)

g. [1 pt] utilizar funções de alta ordem (filter, map, fold etc)
Processar blocos utilizando corretamente funções de alta ordem.

h. [1 pt] utilizar tipos de dados (datatype) 
Criar tipos de dados para representar blocos.

i. [1 pt] comprovar otimização por uso de paralelismo
Demonstrar aceleração com testes de desempenho (tempo de processamento, uso de processador).

j. [1 pt] implementar cinco casos de teste automatizados (usando exemplos em Java como referência)
Comprovar dados corretos com comparação de resultados com Java, em comentário no código.

Pontuação disponível: 13 pontos
Pontuação máxima: Dez pontos
Serão executados cinco testes automáticos, em caso de falha na geração do arquivo de saída correto, a pontuação é dividida por 2.

Arquivos que não forem entregues via Moodle, no prazo, recebem nota ZERO.
Trabalhos iguais ou similares recebem nota ZERO.
Trabalhos de grupos que não sabem explicar o código ou com código disponível na Internet recebem nota ZERO.
Trabalho com referências consultadas omitidas, tem pontuação dividida por 2.
