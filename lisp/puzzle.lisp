"Codigo relacionado com o problema."


(defun tabuleiro-teste ()
  "Retorna um tabuleiro 3x3 (3 arcos na vertical por 3 arcos na horizontal)"
	'(
        ((0 1 0) (0 1 1) (0 1 1) (0 1 1))
        ((0 0 0) (1 1 1) (1 1 1) (0 1 1))
     )
)



(defun get-horizontal-arcs (board)
	"Retorna a lista dos arcos horizontais de um tabuleiro."
	(car board)
)

(defun get-vertical-arcs (board)
	"Retorna a lista dos arcos verticiais de um tabuleiro."
	(car (cdr board))
)



(defun get-arc-on-position (a b list)
	"Função que retorna o arco que se encontra numa posicao da lista de arcos
	horizontais ou verticais"
	(if (or (= a 0) (= b 0))
	    NIL	
	    (nth (- b 1) (nth (- a 1) list))
	)
)


(defun replace-elem(a list &optional (b 1))
	"Função que recebe um índice, uma lista e valor b e deverá substituir o elemento nessa
	posição pelo valor b, que deve ser definido com o valor de default a 1"
    (setf (nth (- a 1) list) b)
    list
)

(defun arc-on-position (a b list)
	"Insere um arco (representado pelo valor 1) numa lista que representa o conjunto de
	arcos horizontais ou verticais de um tabuleiro."
	(replace-elem (nth (- a 1) list))
	list
)

;;;(check-closed-box 1 2 (tabuleiro-teste))
(defun check-closed-box (a b board)
    (and
        "A"(= (get-arc-on-position a b (get-horizontal-arcs board)) 1)
        "B"(= (get-arc-on-position b a (get-vertical-arcs board)) 1)
        "C"(= (get-arc-on-position (+ b 1) a (get-vertical-arcs board)) 1)
        "D"(= (get-arc-on-position (+ a 1) b (get-horizontal-arcs board)) 1)
    )
)



(defun horizontal-arc (x y board)
    "Função que recebe dois índices e o tabuleiro e coloca um arco horizontal nessa
    posição. A função deverá retornar NIL caso já exista um arco colocado nessa posição ou caso a posição
    indicada seja fora dos limites do tabuleiro."
    (if 
        (and (<= x (length (get-horizontal-arcs board)))
            (<= y (length (car (get-horizontal-arcs board)))))
        (if (/= (get-arc-on-position x y (get-horizontal-arcs board)) 1)
            (and
                (arc-on-position x y (get-horizontal-arcs board)) 
                board
            )
        nil
        )
        nil
    )
)
 

(defun vertical-arc (x y board)
    ": Função que recebe dois índices e o tabuleiro e coloca um arco vertical nessa posição.
    A função deverá retornar NIL caso já exista um arco colocado nessa posição ou caso a posição indicada
    seja fora dos limites do tabuleiro"
    (if 
        (and (<= y (length (get-vertical-arcs board)))
             (<= x (length (car (get-vertical-arcs board)))))
        (if (/= (get-arc-on-position y x (get-vertical-arcs board)) 1)
            (and
                (arc-on-position y x (get-vertical-arcs board))
                board
            ) 
        nil
        )
        nil
    )
)
