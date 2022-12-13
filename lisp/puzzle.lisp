"C�digo relacionado com o problema."


(defun criar-tabuleiro (n m)

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

(defun replace(a list &optional (b 1))
	"Função que recebe um índice, uma lista e valor x e deverá substituir o elemento nessa
	posição pelo valor x, que deve ser definido com o valor de default a 1"
    (cond 
		((= (1- a) 0) (cons b (cdr list)))
		(T (cons (car list) (replace (1- a) (cdr list) b)))
	)
)

(defun arc-on-position (a b list)
	"Insere um arco (representado pelo valor 1) numa lista que representa o conjunto de
	arcos horizontais ou verticais de um tabuleiro."
	(replace b (nth (- a 1) list))
	list
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
        (and (<= x (length (get-vertical-arcs board)))
            (<= y (length (car (get-vertical-arcs board)))))
        (if (/= (get-arc-on-position x y (get-vertical-arcs board)) 1)
            (and
                (arc-on-position x y (get-vertical-arcs board))
                board
            ) 
        nil
        )
        nil
    )
)