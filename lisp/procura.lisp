"Deve conter a implementacao de:
1. Algoritmo de Procura de Largura Primeiro (BFS)
2. Algoritmo de Procura do Profundidade Primeiro (DFS)
3. Algoritmo de Procura do Melhor Primeiro (A*)
4. Os algoritmos SMA*, IDA* e/ou RBFS (caso optem por implementar o bonus)"


(defun createNode (board parent boxes &optional (d 0) (h 0))
 "Cria um nó para a resolução e utilização nos algoritmos de pesquisa"
  (list board parent boxes d h)
)

(defun getBoard (node)
  (car node)
)

(defun getParentNode (node)
  (nth 1 node)
)

(defun getBoxes (node)
  (nth 2 node)
)

(defun getDepthNode (node)
  (nth 3 node)
)

(defun getHeuristicNode (node)
  (nth 4 node)
)

(defun noTeste ()
  (createNode (tabuleiroTesteSimples) nil 1)
)

;; (newsucessor (noTeste) 'horizontalArc 1 1)
(defun newSucessor (node fun x y)
"Cria um novo sucessor do no atribuido"
(setq newList (copy-list (getBoard node)))
  (createNode
    (funcall fun x y newList) 
    node (+ (getdepthnode node) 1) (getheuristicnode node) (getBoxes node)
  )
)

;; (sucessores (noTeste))
(defun sucessores (board &optional (row 1) (col 1))
  (cond
    ((>= col (length (gethorizontalarcs board))) (sucessores board (1+ row)))
    ((>= row (length (getVerticalarcs board))))  
    (T
      (list
        (newSucessor board row col 'horizontalArcs)
        (newSucessor board row col 'verticalArcs)
      )
      (sucessores board row (1+ col))
    ) 
  )
)

(defun generateSuccessorList (node)
  (append
    (generatesuccessorshorizontal node)
    (generatesuccessorsvertical node)
  )
)

(defun generateSuccessorsHorizontal (node &optional (x 1) (y 1) (solucao))
  (cond 
    ( (> y (length (car (getHorizontalArcs(getBoard node))))) 
      (generateSuccessorsHorizontal node (1+ x))
    )
    ( (> x (length (getHorizontalArcs(getBoard node))))  '())
    ( (not (listp (horizontalArc x y(getBoard node))))  (generateSuccessorsHorizontal node x (1+ y)))

    (T
      (cons 
        (createnode 
          (horizontalArc x y (getBoard node)) 
          node 
          (getboxes node) 
          (1+ (getdepthnode node))
        ) 
        
        (generateSuccessorsHorizontal node x (1+ y))
      )   
    )
  )
)

(defun generateSuccessorsVertical (node &optional (x 1) (y 1) (solucao))
  (cond 
    ( (> y (length (car (getVerticalArcs(getBoard node))))) 
      (generateSuccessorsVertical node (1+ x))
    )
    ( (> x (length (getVerticalArcs(getBoard node))))  '())
    ( (not (listp (VerticalArc y x (getBoard node))))  (generateSuccessorsVertical node x (1+ y)))

    (T
      (cons 
        (createnode 
          (VerticalArc x y (getBoard node)) 
          node 
          (getboxes node) 
          (1+ (getdepthnode node))
        ) 
        
        (generateSuccessorsVertical node x (1+ y))
      )   
    )
  )
)


