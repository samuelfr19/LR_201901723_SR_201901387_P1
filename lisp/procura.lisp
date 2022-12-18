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

;; (newsucessor (noTeste) 'horizontalArc)
(defun newSucessor (no fun)
 (if (funcall fun 3 1 (getStateNode no))
    (list 
      (funcall fun 3 1 (getStateNode no)) 
      no (+ (getdepthnode no) 1) (getheuristicnode no) (getpieces no)
    )
    nil
 )
)

(defun newSucessors (no fun)
  (funcall fun 3 1 (getStateNode no)) 
)
