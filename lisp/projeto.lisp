"ficheiro que carrega os outros ficheiros de codigo, escreve e le ficheiros, e trata da interacao com o utilizador"

(load "procura.lisp")
(load "puzzle.lisp")
;(require "asdf")

(defun startMessage()
"Mostra as opções iniciais"
  (progn
    (format t "~%--------------------------------")
    (format t "~%|          Dots and            |")
    (format t "~%|            Boxes             |")
    (format t "~%|                              |")
    (format t "~%|   1 Visualizar Problemas     |")
    (format t "~%|   2  Escolher problema       |")
    (format t "~%|   3        Exit              |")
    (format t "~%|                              |")
    (format t "~% -------------------------------   ~%~%>")
 )
)

;; <solution>::= (<start-time> <solution-path> <end-time> <numero-board> <algorithm>)
(defun start()
  (progn
    (startMessage)
      (let ((opt (read)))
           (if (or (not (numberp opt)) (> opt 3) (< opt 1)) (progn (format t "Por favor escolha uma opcao possivel!~%") (start))
           (ecase opt
              ('1 (format t "OPCAO 1"))
              ('2 (format t "OPCAO 2"))
              ('3 (format t "OPCAO 3"))
           )
           )
    )
  )
)

(defun algorithmMessage()
  (progn
    (format t "~%Escolha o argoritmo de procura que pretende utilizar~% ")
    (format t "~%         1   Breadth first search")
    (format t "~%         2    Depth first search")
    (format t "~%         3            A*~%~%")
  )
)

;----------------------------------------------------------------------------- LOADING FROM FILES

(defun getProblemas ()
  (mapcar #'
    (lambda (line)
      (string-to-list line)
    )
    ;(uiop:read-file-lines "../problemas.dat")
  )
)

(defun printProblemas ()
  (mapcar #'
    (lambda (s) 
      (format t s) (format t "~%")
    )
    (getProblemas)
  )
  nil
)

(defun string-to-list (str)
  (if (not (streamp str))
    (string-to-list (make-string-input-stream str))
    
    (if (listen str)
      (cons (read str) (string-to-list str))
      nil
    )
  )
)
