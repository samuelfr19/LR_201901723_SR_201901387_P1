"Codigo relacionado com o problema."


(defun tabuleiroTeste ()
  "Retorna um tabuleiro 3x3 (3 arcos na vertical por 3 arcos na horizontal) do lab 7"
  '(
     ((0 0 0) (0 0 1) (0 1 1) (0 1 1))
     ((0 0 0) (0 1 1) (1 1 1) (0 1 1))
    ;((0 0 0) (0 0 1) (0 1 1) (0 0 1))
    ;((0 0 0) (0 1 1) (1 0 1) (0 1 1))
  )
)

(defun tabuleiroTesteSimples()
  '(
    ((0) (0))
    ((0) (1))
  )
)

(defun replace-nth (list n elem)
  (cond 
    ((null list) ())
    ((= n 0) (cons elem (cdr list)))
    (t (cons (car list) (replace-nth (cdr list) (1- n) elem)))
  )
  
)

;; (getHorizontalArcs (tabuleiroTeste))
(defun getHorizontalArcs (board)
	"Retorna a lista dos arcos horizontais de um tabuleiro."
	(car board)
)

;; (getVerticalArcs (tabuleiroTeste))
(defun getVerticalArcs (board)
	"Retorna a lista dos arcos verticiais de um tabuleiro."
	(car (cdr board))
)


;; (getArcOnPosition 1 3 (getHorizontalArcs (tabuleiroTeste)))
(defun getArcOnPosition (x y board)
	"Função que retorna o arco que se encontra numa posicao da lista de arcos
	horizontais ou verticais"
	(if (and (/= x 0) (/= y 0))
    (nth (- y 1) (nth (- x 1) board))
  )
)

;; (replaceElem 1 (car (gethorizontalarcs(tabuleiroteste))))
(defun replaceElem(list x &optional (y 1))
	"Função que recebe um índice, uma lista e valor y e deverá substituir o elemento nessa
	posição pelo valor y, que deve ser definido com o valor de default a 1"
    (cond
        ((= (- x 1) 0) (cons y (cdr list)))
        (T (cons (car list) (replaceElem (cdr list) (- x 1) y)))
    )
)

;; (arcOnPosition 1 3 (gethorizontalarcs (tabuleiroteste)))
;; (arcOnPosition 4 1 (getverticalarcs (tabuleiroteste)))
(defun arcOnPosition (x y list)
	"Insere um arco (representado pelo valor 1) numa lista que representa o conjunto de
	arcos horizontais ou verticais de um tabuleiro."
	(cond
    ((= x 1) 
      (cons (replaceElem (nth (- x 1) list) y ) (cdr list))
    )
    (T (cons (car list) (arconposition (- x 1) y (cdr list))))
  )
)

;;; (checkClosedBox 70 20 (tabuleiroTeste))
(defun checkClosedBox (x y board)
  (if (or (or (< x 1) (< y 1))(>= x (length (gethorizontalarcs board))))
    NIL
    (and
          "A"(= (getArcOnPosition x y (getHorizontalArcs board)) 1)
          "B"(= (getArcOnPosition y x (getVerticalArcs board)) 1)
          "C"(= (getArcOnPosition (+ y 1) x (getVerticalArcs board)) 1)
          "D"(= (getArcOnPosition (+ x 1) y (getHorizontalArcs board)) 1)
    )
  )
)



;;(countClosedBoxes (tabuleiroTeste))
(defun countClosedBoxes (board &optional (row 1) (col 1))
  "Devolve o numero de caixas fdechadas no tabuleiro inteiro"
  (cond
    ((>= col (length (gethorizontalarcs board))) (countClosedBoxes board (1+ row)))
    ((>= row (length (getVerticalarcs board))) 0)  
    (T
      (+
        (if (checkclosedbox row col board) 1 0)

        (countclosedboxes board row (1+ col))
      )
    )
  )
)


;;  (horizontalArc 1 3 (tabuleiroTeste))
(defun horizontalArc (x y board)
  "Função que recebe dois índices e o tabuleiro e coloca um arco horizontal nessa
  posição. A função deverá retornar NIL caso já exista um arco colocado nessa posição ou caso a posição
  indicada seja fora dos limites do tabuleiro."
  (if 
    (and 
      (<= x (length (getHorizontalArcs board)))
      (<= y (length (car (getHorizontalArcs board))))
    )
    (if (/= (getArcOnPosition x y (getHorizontalArcs board)) 1)
        (list (arcOnPosition x y (getHorizontalArcs board)) 
          (getverticalarcs board))
    0
    )
  )
)
 
;; (verticalArc 1 2 (tabuleiroTeste))
(defun verticalArc (x y board)
  ": Função que recebe dois índices e o tabuleiro e coloca um arco vertical nessa posição.
  A função deverá retornar NIL caso já exista um arco colocado nessa posição ou caso a posição indicada
  seja fora dos limites do tabuleiro"
  (if 
    (and 
      (<= y (length (getVerticalArcs board)))
      (<= x (1+ (length (car (getVerticalArcs board)))))
    )
    
    (if (/= (getArcOnPosition y x (getVerticalArcs board)) 1)
        (list (gethorizontalarcs board)
          (arcOnPosition y x (getVerticalArcs board)))
    0
    )
  )
)
