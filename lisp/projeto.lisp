"ficheiro que carrega os outros ficheiros de codigo, escreve e le ficheiros, e trata da interacao com o utilizador"

(load "procura.lisp")
(load "puzzle.lisp")

;----------------------------------------------------------------------------- MESSAGES FOR INTERFACE

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
(defun algorithmMessage()
  (progn
    (format t"~%~% -------------------------------------------------------------")
    (format t "~%|    Escolha o argoritmo de procura que pretende utilizar     |")
    (format t "~%|                                                             |")
    (format t "~%|                1   Breadth first search                     |")
    (format t "~%|                2    Depth first search                      |")
    (format t "~%|                3            A*                              |")
    (format t "~%|                0          Voltar                            |")
    (format t "~%|                                                             |")
    (format t"~% -------------------------------------------------------------~%~%> ")
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
    (format t "~%|     inserindo o numero do problema     |")
    (format t "~%|             0   Voltar                 |")
    (format t "~%|                                        |")
    (format t "~% ----------------------------------------   ~%~%> ")
 )
)

;; <solution>::= (<start-time> <solution-path> <end-time> <numero-board> <algorithm>)
; (start)
(defun start()
  (progn
    (startMessage)
      (let ((opt (read)))
           (if (or (not (numberp opt)) (> opt 2) (< opt 0)) (progn (format t "Por favor escolha uma opcao possivel!~%") (start))
           (ecase opt
              ('1 (progn (printProblems) (start)))
              ('2 (chooseProblem))
              ('0 (quit))
           )
           )
    )
  )
)

;(chooseProblem)
(defun chooseProblem()
 (progn (chooseProblemMessage)
      (let ((opt (read)))
           (cond ((eq opt '0) (start))
                 ((not (numberp opt)) 
                  (progn (format t "Insira uma opcao valida") (chooseProblem))) 
                 (T
                  (let ((problem-list (getproblems)))
                  (if (or (< opt 0) (> opt (length problem-list))) (progn (format t "Insira uma opcao valida") (chooseProblem))
                                 (nth(1- opt) problem-list)
                  )))
           )
       )
    )
)





;; (print-board (tabuleiroTeste)))
(defun print-board(board &optional (stream t))
  "Mostra um tabuleiro bem formatado"
  (not (null (mapcar #'(lambda(l) (format stream "~%~t~t ~a" l)) board)))
  (format t "~%-------------------------------------------------------------------------------------------------------------------------------------------~%")
)

;; (printProblems)
(defun printProblems (&optional (i 1) (problems (getProblems)))
    (cond
     ((null problems) 
        
     )
     (T (let ((problem (car problems)))
        (format T "   ~d- Tabuleiro ~d (~d caixas):~%" i (car problem) (cadr problem))
        (print-board (caddr problem)))


        (printproblems (+ i 1) (cdr problems))
     ) 
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

 