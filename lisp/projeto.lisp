"ficheiro que carrega os outros ficheiros de codigo, escreve e le ficheiros, e trata da interacao com o utilizador"

(load "./lisp/procura.lisp")
(load "./lisp/puzzle.lisp")

(defun startMessage()
"Mostra as opções iniciais)"
  (progn
    (format t "~% ''''''''''''''''''''''''''''''")
    (format t "~%'          Dots and            '")
    (format t "~%'            Boxes             '")
    (format t "~%'                              '")
    (format t "~%'   1 Visualizar Problemas     '")
    (format t "~%'   2  Escolher problema       '")
    (format t "~%'   3        Exit              '")
    (format t "~%'                              '")
    (format t "~% ''''''''''''''''''''''''''''''    ~%~%>")
 )
)

;; <solution>::= (<start-time> <solution-path> <end-time> <numero-board> <algorithm>)
(defun start()
  (progn
    (start-message)
      (let ((opt (read)))
           (if (or (not (numberp opt)) (> opt 3) (< opt 1)) (progn (format t "") (start))
           (ecase opt
              ('1 (format t "OPÇÃO 1"))
              ('2 (format t "OPÇÃO 2"))
              ('3 (format t "OPÇÃO 3"))
           )
           )
      )
  )
)