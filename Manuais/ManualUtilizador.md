# Manual de Utilizador   
## Dots and Boxes Game  
***
### Índice

- [Introdução](#introdução)
- [Instalação e preparação do programa](#instalação-e-preparação-do-programa)
- [Iniciar o programa](#iniciar-o-programa)
- [Ecrãs de interface e objetivos dos mesmos](#ecrãs-de-interface-e-objetivos-dos-mesmos)
- [Resultados Finais](#resultados-finais)
  - [Resultados no programa](#resultados-no-programa)
  - [Resultados exportados como ficheiro](#resultados-exportados-como-ficheiro)


### Introdução
 Este documento tem a finalidade de dar a entender ao utilizador do programa como operar o mesmo demaneira correta e mais eficiente possivel
 - Descrição base do jogo e o seu conceito:
   - **Dots and Boxes** é um jogo de 2 jogadores,
é um jogo constituído por um tabuleiro de caixas. Cada caixa é
delimitada por 4 pontos entre os quais é possível desenhar um arco. Quando os quatro pontos à volta de
uma caixa tiverem conectados por 4 arcos, a caixa é considerada fechada.
   - O jogo inicia com um tabuleiro vazio em que os jogadores alternadamente vão colocando um arco     horizontal
ou vertical. Quando o arco colocado por um jogador fecha uma caixa, essa caixa conta como 1 ponto para o
jogador que colocou o arco e esse jogador deve jogar novamente.
   - O jogo termina quando todas as caixas tiverem fechadas, ou seja, não existirem mais arcos para colocar,
ganhando o jogador que fechou mais caixas.


 - Descrição da aplicação 
   - A aplicação é uma versão simplificada do jogo tradicional, desta maneira, o objetivo do **puzzle** é fechar um determinado número de caixas a partir de uma configuração inicial do tabuleiro. Para atingir este objetivo, é possível desenhar um arco entre dois pontos adjacentes, na
horizontal ou na vertical. Quando o número de caixas a fechar é atingido, o puzzle está resolvido.
***

### Instalação e preparação do programa
Para conseguir fazer a execução do programa deve instalar o ficheiro e todos os seus procedentes estes sendo os ficheiros com todo o código e execução. Além dos ficheiros principais deve ter o ficheiro **"problemas.dat"** devidamente organizado para ser intrepertado pelo programa.
![problemas.dat](..\imagens\problemas.png)
 > Desta maneira o utilizador pode criar novos problemas se utilizar o formato certo este sendo (seguindo a imagem):
 > - "a" - O identificador do problema
 > - "3" - O objetivo de caixas a fechar
 > - *problema* - Tabela de arcos que representa o problema
 >   - 1º linha- Arcos Horizontais
 >   - 2º linha- Arcos Verticais
***
### Iniciar o programa

Após abrir o projeto o utilizador deve executar a funcão *start* esta que é a função inicial e que deverá permitir toda a execução do programa sem mais inputs raiz do utilizador.

Deverá ser apresentado com a seguinte interface:

![start](..\imagens\start.png)

Este menu apresenta ao utilizador 3 opções, estas sendo:
- 1 Visualizar Problemas - Mostrará ao utilizador toda a lista de problemas de maneira organizada e legivel (problemas importados do ficheiro *problemas.dat*).
- 2 Escolher problema - Esta opção permite ao utilizador avançar no programa para novos ecrãs com novos objetivos
- 0 Sair - Dará apenas uma mensagem de despedida e terminará o programa.

> Todos os ecrãs e opções do programa tem como objetivo serem simples e diretos, é pedido maior parte das vezes input do utilizador mas é um input basico e objetivo para chegar ao resultado final.
>
>  Para proseguir nos menus deve apenas introduzir o valor desejado e clicar no *Enter*, caso o valor introduzido esteja errado ou fora dos limites do pretendido uma mensagem de erro irá aparecer e pedirá de novo um input válido
>
>Em todos os ecrãs temos a opção 0, este funciona como voltar ou sair do programa
***
### Ecrãs de interface e objetivos dos mesmos

Durante a navegação dentro do programa o utilizador vai encontrar um número variado de ecrãs com diferentes objetivos, estes sendo:

- Escolher problema para resolver

![escolher-problema](..\imagens\escolher.png)

O ecrã acima é o segundo ecrã a ser mostrado ao utilizador este pede ao utilizador para introduzir o problema que pertende resolver, este deve ser o número atribuido no ecrã de visualização de problemas. 

- Escolher algoritmo 

![escolher-algoritmo](..\imagens\selecionar-algoritmos.png)

Este ecrã vai pedir ao utilizador que selecione entre 3 algoritmos de procura estes sendo:

- DFS (Depth First Search)
- BFS (Breath First Search)
- A* 

> Cada uma destes algoritmos tem formas de funcionamento diferentes e aspetos determinantes que permitem ser mais rapidos ou lentos que o outro.

---

### **Resultados Finais**

#### **Resultados no programa**

Os resultados do problema serão apresentados em forma de print para o utilizador, será listado uma serie de estatisticas e informações importantes para como foi a resolução, estes sendo:
  
![final](..\imagens\final.png)

  >- Objetivo de caixas Fechadas - Retorna o número caixas fechadas na solução final
  >- Algoritmo - Apresenta o acrónimo do algoritmo escolhido
  >- Inicio - Hora Minuto e Segundos em que o algoritmo começou 
  >- Fim - Hora Minuto e Segundos em que o algoritmo encontrou solução 
  >- Número de nós gerados - Soma dos nós abertos e nós fechados logo, nós gerados pelo programa
  >- Numeros de nós expandidos - Nós fechados durante o procedimento do algoritmo
  >- Penetrância - Valor de medida para avaliação de qualidade da solução do algoritmo
  >- Fator de ramificação media - Valor de medida para avaliação de qualidade da solução do algoritmo 
  >- Profundidade Maxima(Informação particular ao DFS) - Input de profundidade maxima introduzida pelo utilizador 
  >- Comprimento da solução - Produndidade da solução encontrada no final do programa
  >- Estado Inicial - Estado do tabuleiro dado para iniciar o algoritmo 
  >- Estado Final - Estado do tabuleiro retornado no final do algoritmo como solução


#### **Resultados exportados como ficheiro**

Os dados resultantes da execução do programa além de apresentadas ao utilizador no programa serão tambem exportadas para o utilizador puder visualizar depois de fechar o programa, terá exatamente o mesmo formato que no terminal só que será exportado no ficheiro ***resultados.dat***, este será criado automaticamente após o utilizador concluir o problema, caso o utilizador realize mais resultados o ficheiro irá ser atualizado com os novos resultados de forma automática de forma a guardar todas utilizações.

---
