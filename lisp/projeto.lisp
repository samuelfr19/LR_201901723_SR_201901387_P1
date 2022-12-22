"ficheiro que carrega os outros ficheiros de codigo, escreve e le ficheiros, e trata da interacao com o utilizador"

(load "procura.lisp")
(load "puzzle.lisp")

;;==========================================    INTERFACE MESSAGES FOR INTERFACE    ==========================================

(defun startMessage()
"Mostra as opções iniciais"
  (progn
    (format t "~%~% ------------------------------")
    (format t "~%|          Dots and            |")
    (format t "~%|            Boxes             |")
    (format t "~%|                              |")
    (format t "~%|   1 Visualizar Problemas     |")
    (format t "~%|   2  Escolher problema       |")
    (format t "~%|   0        Sair              |")
    (format t "~%|                              |")
    (format t "~% ------------------------------   ~%~%> ")
 )
)

; (algorithmMessage)
(defun chooseAlgorithmMessage()
"Mostra as opções de algoritmos de procura para aplicar no problema/tabuleiro"
  (progn
    (format t"~%~% -------------------------------------------------------------")
    (format t "~%|    Escolha o algoritmo de procura que pretende utilizar     |")
    (format t "~%|                                                             |")
    (format t "~%|                1     Depth first search                     |")
    (format t "~%|                2    Breadth first search                    |")
    (format t "~%|                3            A*                              |")
    (format t "~%|                0          Voltar                            |")
    (format t "~%|                                                             |")
    (format t "~% -------------------------------------------------------------~%~%> ")
  )
)

;; (chooseProblemMessage)
(defun chooseProblemMessage()
"Mostra as opções iniciais"
  (progn
    (format t "~%~% ----------------------------------------")
    (format t "~%|           Escolher Problema            |")
    (format t "~%|                                        |")
    (format t "~%|    Escolha o problema introduzindo     |")
    (format t "~%|         o numero do problema           |")
    (format t "~%|             0   Voltar                 |")
    (format t "~%|                                        |")
    (format t "~% ----------------------------------------   ~%~%> ")
 )
)

;; (chooseDepthMessage)
(defun chooseDepthMessage()
"Mostra a caixa para o utilizador escolher a profundidade maxima desejada"
  (progn
    (format t "~%~% -----------------------------------------")
    (format t "~%|      Escolha a profundidade maxima      |")
    (format t "~%|       desejada para executar o DFS      |")
    (format t "~%|              0    voltar                |")
    (format t "~%|                                         |")
    (format t "~% -----------------------------------------~%~%> ")
 )
)


;; (chooseHeuristicMessage)
(defun chooseHeuristicMessage()
"Mostra a caixa para o utilizador escolher a heuristica desejada"
  (progn
    (format t "~%~% -----------------------------------------")
    (format t "~%|      Escolha a Heuristica desejada      |")
    (format t "~%|        para executar o algoritmo        |")
    (format t "~%|     1   Heuristica Personalizada        |")
    (format t "~%|     2        Heuristica Base            |")
    (format t "~%|     0             voltar                |")
    (format t "~%|                                         |")
    (format t "~% -----------------------------------------~%~%> ")
 )
)

;;==========================================    CONTROL FUNCTIONS     ==========================================



(defun start()
  "Funcao que inicia todo o processo do programa, apresenta as opcoes iniciais e pede ao utilizador para escolher 
  a opcao para avancar para o proximo passo"
  (progn
    (startMessage)
      (let ((opt (read)))
           (if (or (not (numberp opt)) (> opt 2) (< opt 0)) (progn (format t "Por favor escolha uma opcao possivel!~%") (start))
           (ecase opt
              ('1 (progn (printProblems) (start)))
              ('2  (chooseProblem))
              ('0 (progn (format t "  Obrigado!")(quit)))
           )
           )
    )
  )
)


; (chooseHeuristic)
(defun chooseHeuristic(board)
  (if (not (chooseHeuristicMessage))
      (let ((opt (read)))
         (cond ((eq opt '0) (chooseAlgorithm board))
                (if (or (not (numberp opt)) (> opt 2) (< opt 0)) (progn (format t "Insira uma opcao valida!!~%") (chooseHeuristic))
               (T opt))))
)
)


; (chooseDepth)
(defun chooseDepth(board)
  (if (not (chooseDepthMessage))
      (let ((opt (read)))
         (cond ((eq opt '0) (chooseAlgorithm board))
               ((or (not (numberp opt)) (< opt 0)) (progn (format t "Insira uma opcao valida!!")) (chooseDepth))
               (T opt))))
)




;(chooseProblem)
(defun chooseProblem()
 (progn (chooseProblemMessage)
      (let ((opt (read)))
           (cond ((eq opt '0) (start))
                 ((not (numberp opt)) 
                  (progn (format t "Insira uma opcao valida!!") (chooseProblem))) 
                 (T
                  (let ((problem-list (getproblems)))
                  (if (or (< opt 0) (> opt (length problem-list))) (progn (format t "Insira uma opcao valida!!") (chooseProblem))
                                 (chooseAlgorithm(nth(1- opt) problem-list))
                  )))
           )
       )
    )
)


(defun chooseAlgorithm(board)
"Executa um algoritmo, dependendo da opcao escolhida"
  (progn (chooseAlgorithmMessage)
    (let ((opt (read)))
      (cond ((not (numberp opt)) (progn (format t "Insira uma opcaoo valida!!") (chooseAlgorithm)))
        ((or (> opt 3) (< opt 0)) (progn (format t "Insira uma opcao valida!!") (chooseAlgorithm)))
        ((eq opt 0) (chooseProblem))         
        (T (let* (
          (boxes (second board))
          (board (third board)))
            (ecase opt
              (1    
                (let* ((maxDepth (chooseDepth board))
                  (solution (list (getTime) (dfs (list (createNode board NIL boxes)) maxDepth)
                  (getTime) 'DFS maxDepth)))
                  (progn (writeFinalResultsFile solution) solution)  
                )
              )
              (2  
                (let
                  (
                    (
                      solution (list (getTime) (bfs (list (createNode board NIL boxes))) (getTime) 'BFS)
                      
                    )
                  )
                  (progn
                  (writeFinalResultsFile solution) solution)
                )
              )
              (3  
                (let* ((heuristic (chooseHeuristic board))
                  (solution (list (getTime) (dfs (list (createNode board NIL boxes)) maxDepth)
                  (getTime) 'A* heuristic)))
                  (progn (writeFinalResultsFile solution) solution)  
                )
              )
            )
          )
        )
      )
    )
  )
)



;; <solution>::= (<startTime> <solutionNode> <endTime> <algorithm> <depth>)
(defun writeFinalResultsFile (solution)
"Escreve, no ficheiro de resultados, a solucao e medidas de desempenho de um determinado problema"
  (let* (
      (startTime (first solution))
      (solutionNode (second solution))
      (endTime (third solution))
      (search (fourth solution))
    ) 
    (with-open-file (str "../lisp/resultados.dat" :direction :output :if-exists :append :if-does-not-exist :create)
      (writeFinalResults str solutionNode startTime endTime search (last solution)) 
    )
  )
)


;----------------------------------------------------------------------------- TERMINAL PRINTS
;; (print-board (tabuleiroTeste)))
(defun printBoard(board &optional (stream t))
  "Mostra um tabuleiro bem formatado"
  (not (null (mapcar #'(lambda(l) (format stream "~%~t~t ~a" l)) board)))
  (format t "~%~%-------------------------------------------------------------------------------------------------------------------------------------------~%")
)

(defun printFinalBoard(board &optional (stream t))
  "Mostra um tabuleiro bem formatado"
  (not (null (mapcar #'(lambda(l) (format stream "~%~t~t ~a" l)) board)))
  (format t "~%")
)

;; (printProblems)
(defun printProblems (&optional (i 1) (problems (getProblems)))
    (cond
     ((null problems))
     (T (let ((problem (car problems)))
        (format T "~%   ~d- Tabuleiro ~d (~d caixas):~%" i (car problem) (cadr problem))
        (printBoard (caddr problem)))
        (printproblems (+ i 1) (cdr problems))
     ) 
)
)

(defun writeFinalResults (stream solutionNode startTime endTime search &optional depth)
  (progn 
    (format stream "~%~tRESULTADOS FINAIS DA RESOLUCAO DO TABULEIRO:~%")
    (format stream "~%~t -- Objetivo caixas fechadas: ~a " (countClosedBoxes(getSolutionNode solutionNode)))
    (format stream "~%~t -- Algoritmo: ~a " search)
    (format stream "~%~t -- Inicio: ~a:~a:~a" (first startTime) (second startTime) (third startTime))
    (format stream "~%~t -- Fim: ~a:~a:~a" (first endTime) (second endTime) (third endTime))
    (format stream "~%~t -- Numero de nos gerados: ~a" (+ (second solutionNode)(third solutionNode)))
    (format stream "~%~t -- Numero de nos expandidos: ~a" (second solutionNode))
    (format stream "~%~t -- Penetrancia: ~F" (penetrance solutionNode))
    (format stream "~%~t -- Fator de ramificacao media: ~F" (averageBranchingFator solutionNode))
    (if (eq search 'DFS)
        (format stream "~%~t -- Profundidade maxima: ~a" (car depth)))
    (format stream "~%~t -- Comprimento da solucao: ~a" (length (car solutionNode)))
    (format stream "~%~t -- Estado Inicial")
    (printFinalBoard (first (first solutionNode)) stream)
    (format stream "~%~t -- Estado Final")
    (printFinalBoard (getSolutionNode solutionNode) stream)
    (format stream "~%~%~%")


    (format T "~%~tRESULTADOS FINAIS DA RESOLUCAO DO TABULEIRO:~%")
    (format t "~%~t -- Objetivo caixas fechadas: ~a " (countClosedBoxes(getSolutionNode solutionNode)))
    (format t "~%~t -- Algoritmo: ~a " search)
    (format T "~%~t -- Inicio: ~a:~a:~a" (first startTime) (second startTime) (third startTime))
    (format t "~%~t -- Fim: ~a:~a:~a" (first endTime) (second endTime) (third endTime))
    (format t "~%~t -- Numero de nos gerados: ~a" (+ (second solutionNode)(third solutionNode)))
    (format t "~%~t -- Numero de nos expandidos: ~a" (second solutionNode))
    (format t "~%~t -- Penetrancia: ~F" (penetrance solutionNode))
    (format T "~%~t -- Fator de ramificacao media: ~F" (averageBranchingFator solutionNode))
    (if (eq search 'DFS)
        (format t "~%~t -- Profundidade maxima: ~a" (car depth)))
    (format t "~%~t -- Comprimento da solucao: ~a" (length (car solutionNode)))
    (format t "~%~%~t -- Estado Inicial~%")
    (printFinalBoard (first (first solutionNode)))
    (format t "~%~t -- Estado Final~%")
    (printFinalBoard (getSolutionNode solutionNode))
    (format t "~%~%")
    (format t "Obrigado por jogar!~%")
    (format t "Com os melhores cumprimentos, Luis Rocha e Samuel Ribeiro ~%~%")
    (quit)
  )
)

;----------------------------------------------------------------------------- LOADING FROM FILES

;; (getProblems)
(defun getProblems ()
  "Metodo para ir buscar os problemas a partir do ficheiro 'problemas.dat'"
  (with-open-file (stream "../problemas.dat" :if-does-not-exist :error)
    (do 
      (
        (result nil (cons next result))
        (next (read stream nil 'eof) (read stream nil 'eof))
      )
      ((equal next 'eof) (reverse result))
    )
  )
)

;; (getProblem "e")
(defun getProblem (n &optional (probs (getProblems)))
  "Procurar recursivamente na lista de problemas o que estamos a procurar (todos em letra minuscula e nao passar lista) (P.E. '(getproblema \"a\")'"
  (if (car probs)
    (if (equal (first (car probs)) n)
        (car probs)
      (getProblem n (cdr probs))
    )
  )
)


(defun getTime()
  "Retorna o tempo atual em forma de lista"
  (multiple-value-bind (s m h) (get-decoded-time)
    (list h m s)
   )
)
 