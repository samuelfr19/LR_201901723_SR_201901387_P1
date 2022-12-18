"Deve conter a implementacao de:
1. Algoritmo de Procura de Largura Primeiro (BFS)
2. Algoritmo de Procura do Profundidade Primeiro (DFS)
3. Algoritmo de Procura do Melhor Primeiro (A*)
4. Os algoritmos SMA*, IDA* e/ou RBFS (caso optem por implementar o bonus)"


(defun createNode (board parent &optional (d 0) (h 0) pieces)
 "Cria um nó para a resolução e utilização nos algoritmos de pesquisa"
  (list board parent d h pieces)
)

(defun getStateNode (node)
  (car node)
)

(defun getParentNode (node)
  (nth 1 node)
)

(defun getDepthNode (node)
  (nth 2 node)
)

(defun getHeuristicNode (node)
  (nth 3 node)
)

(defun getPieces (node)
  (nth 4 node)
)

(defun noTeste ()
  (createNode (tabuleiroTeste) nil 0 0 4)
)

(defun Changes()
  (list 'horizontalArc 'verticalArc)
)

;; (newsucessor (noTeste) 1 3 'horizontalArc)
(defun newSucessor (node a b fun)
"Cria um novo sucessor do no atribuido"
(setq newList (copy-list (getStateNode node)))
  (createNode
      (funcall fun a b newList) 
      node (+ (getdepthnode node) 1) (getheuristicnode node) (getpieces node)
    )
)

;; (sucessores (noTeste))
(defun sucessores (board &optional (row 0) (col 0))
 (cond
    ((>= col (length (gethorizontalarcs board))) (sucessores board (1+ row)))
    ((>= row (length (getVerticalarcs board))))  
    (T
      (progn
        (mapcar #'(lambda (operador) (newSucessor board row col operador)) operadores)
        (sucessores board row (1+ col))
         
      )
    )
  )
)
