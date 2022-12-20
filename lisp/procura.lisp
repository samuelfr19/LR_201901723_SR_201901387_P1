"Deve conter a implementacao de:
1. Algoritmo de Procura de Largura Primeiro (BFS)
2. Algoritmo de Procura do Profundidade Primeiro (DFS)
3. Algoritmo de Procura do Melhor Primeiro (A*)
4. Os algoritmos SMA*, IDA* e/ou RBFS (caso optem por implementar o bonus)"


(defun createNode (board parent boxes &optional (d 0) (h 0))
 "Cria um nó para a resolução e utilização nos algoritmos de pesquisa"
  (list board parent boxes d h)
)

(defun nodeGetBoard (node)
  (car node)
)

(defun nodeGetParent (node)
  (nth 1 node)
)

(defun nodeGetBoxes (node)
  (nth 2 node)
)

(defun nodeGetDepth (node)
  (nth 3 node)
)

(defun nodeGetHeuristic (node)
  (nth 4 node)
)

(defun noTeste ()
  (createNode (tabuleiroTesteSimples) nil 1)
)

(defun generateSuccessorList (node)
"Gera uma lista de sucessores de um no pai"
  (append
    (generatesuccessorshorizontal node)
    (generatesuccessorsvertical node)
  )
)

(defun generateSuccessorsHorizontal (node &optional (x 1) (y 1) (solucao))
"Gera os sucessores com alteracoes horizontais de um no pai"
  (cond 
    ( (> y (length (car (getHorizontalArcs(nodeGetBoard node))))) 
      (generateSuccessorsHorizontal node (1+ x))
    )
    ( (> x (length (getHorizontalArcs(nodeGetBoard node))))  '())
    ( (not (listp (horizontalArc x y(nodeGetBoard node))))  (generateSuccessorsHorizontal node x (1+ y)))

    (T
      (cons 
        (createnode 
          (horizontalArc x y (nodeGetBoard node)) 
          node 
          (nodegetboxes node) 
          (1+ (nodeGetDepth node))
        ) 
        
        (generateSuccessorsHorizontal node x (1+ y))
      )   
    )
  )
)

(defun generateSuccessorsVertical (node &optional (x 1) (y 1) (solucao))
"Gera os sucessores com alteracoes verticais de um no pai"
  (cond 
    ( (> y (length (car (getVerticalArcs(nodeGetBoard node))))) 
      (generateSuccessorsVertical node (1+ x))
    )
    ( (> x (length (getVerticalArcs(nodeGetBoard node))))  '())
    ( (not (listp (VerticalArc y x (nodeGetBoard node))))  (generateSuccessorsVertical node x (1+ y)))

    (T
      (cons 
        (createnode 
          (VerticalArc x y (nodeGetBoard node)) 
          node 
          (nodegetboxes node) 
          (1+ (nodeGetDepth node))
        ) 
        
        (generateSuccessorsVertical node x (1+ y))
      )   
    )
  )
)

(defun pathToRoot (node)
  (if(nodegetparent node) 
    (append (pathtoRoot (nodegetparent node)) (list (nodegetboard node)))
    (list (nodegetboard node))
  )
)

(defun nodeRemoveDuplicates(lista opened closed)
  (removeDuplicates (removeDuplicates lista opened) closed)
)

(defun removeDuplicates (list1 list2)
  (if (or list1 list2)
    list1
    (mapcar 
      #'(lambda(x) 
        (if(member x list2) 
          nil 
          x
        )
      ) 
      list1
    )
  )
)

(defun removeNil (lista)
  (if (car lista)
    (cons (car lista) (removenil (cdr lista)))
    (if (cdr lista)
      (removenil (cdr lista))
    )
  )
)


(defun bfs(opened &optional (closed '()))
  (if (/= (length opened) 0)
    (let* 
      (
        (chosenNode (car opened))
        (expanded (generatesuccessorlist chosenNode))
      )
      (if (= (length expanded) 0)
        (list (pathtoroot chosennode) (length opened) (length closed))
        (bfs (append (cdr opened) (nodeRemoveDuplicates expanded opened closed) ) (append closed (list chosennode)))
      )
    )
  )
)

;;(dfs (list(noTeste)) 100)
(defun dfs(opened maxDepth &optional (closed '()))
  (cond
    ((not (car opened)) (print (car opened)))
    ((> (nodegetdepth (car opened)) maxDepth)
      (dfs (cdr opened) maxDepth (append closed (car opened)))
    )
    (T
      (let*
        (
          (chosenNode (car opened))
          (children (generatesuccessorlist chosennode))
        )
        (if (car children)
          (dfs (append children (cdr opened)) maxdepth (append closed chosennode))
          (list (pathtoroot chosennode) (length opened) (length closed))
        )
      )
    )
  )
)

