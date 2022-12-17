"Codigo relacionado com o problema."


(defun tabuleiroTeste ()
  "Retorna um tabuleiro 3x3 (3 arcos na vertical por 3 arcos na horizontal)"
  '(
    ((0 1 0) (0 1 1) (0 1 1) (0 1 1))
    ((0 0 0) (1 1 1) (1 1 1) (0 1 1))
  )
)



(defun getHorizontalArcs (board)
	"Retorna a lista dos arcos horizontais de um tabuleiro."
	(car board)
)

(defun getVerticalArcs (board)
	"Retorna a lista dos arcos verticiais de um tabuleiro."
	(car (cdr board))
)



(defun getArcOnPosition (a b list)
	"Função que retorna o arco que se encontra numa posicao da lista de arcos
	horizontais ou verticais"
	(if (or (= a 0) (= b 0))
    NIL	
    (nth (- b 1) (nth (- a 1) list))
	)
)


(defun replaceElem(a list &optional (b 1))
	"Função que recebe um índice, uma lista e valor b e deverá substituir o elemento nessa
	posição pelo valor b, que deve ser definido com o valor de default a 1"
    (setf (nth (- a 1) list) b)
    list
)

(defun arcOnPosition (a b list)
	"Insere um arco (representado pelo valor 1) numa lista que representa o conjunto de
	arcos horizontais ou verticais de um tabuleiro."
	(replaceElem (nth (- a 1) list))
	list
)

;;; (checkClosedBox 1 2 (tabuleiroTeste))
(defun checkClosedBox (a b board)
  (and
    "A"(= (getArcOnPosition a b (getHorizontalArcs board)) 1)
    "B"(= (getArcOnPosition b a (getVerticalArcs board)) 1)
    "C"(= (getArcOnPosition (+ b 1) a (getVerticalArcs board)) 1)
    "D"(= (getArcOnPosition (+ a 1) b (getHorizontalArcs board)) 1)
  ) 
)



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
      (and
        (arcOnPosition x y (getHorizontalArcs board)) 
        board
      )
    nil
    )
    nil
  )
)
 

(defun verticalArc (x y board)
  ": Função que recebe dois índices e o tabuleiro e coloca um arco vertical nessa posição.
  A função deverá retornar NIL caso já exista um arco colocado nessa posição ou caso a posição indicada
  seja fora dos limites do tabuleiro"
  (if 
    (and 
      (<= y (length (getVerticalArcs board)))
      (<= x (length (car (getVerticalArcs board))))
    )
    
    (if (/= (getArcOnPosition y x (getVerticalArcs board)) 1)
      (and
        (arcOnPosition y x (getVerticalArcs board))
        board
      ) 
    nil
    )
    nil
  )
)
