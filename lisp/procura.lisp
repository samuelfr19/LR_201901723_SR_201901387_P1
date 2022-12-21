"Deve conter a implementacao de:
1. Algoritmo de Procura de Largura Primeiro (BFS)
2. Algoritmo de Procura do Profundidade Primeiro (DFS)
3. Algoritmo de Procura do Melhor Primeiro (A*)
4. Os algoritmos SMA*, IDA* e/ou RBFS (caso optem por implementar o bonus)"

;==========================================    NOS    ==========================================

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


(defun nodeGetF (node)
  (+ (nodegetdepth node) (nodegetheuristic node)) ;@todo verificar se de facto e' este o valor de f para o nosso projeto
)

(defun replacePosition (l pos val)
"returns the list 'l' with the value 'val' at the position 'pos'"
  (if (= pos 0)
    (cons val (cdr l))
    (replaceposition (cdr l) (1- pos) (val))
  )
)

(defun nodeSetHeuristic(node hFunc)
"sets the heuristic of a node"
  (replacePosition node 4 (funcall hfunc node)) 
)


; (getsolutionnode '(((((0) (0)) ((0) (1))) (((1) (0)) ((0) (1))) (((1) (1)) ((0) (1))) (((1) (1)) ((1) (1)))) 6 10))
(defun getSolutionNode (node)
  (car (last (car node)))
)

(defun getSolutionLenght (node)
 (length (car node))
)

(defun numberGeneratedNodes (solution)
    (+ (second solution) (third solution))
)

(defun noTeste ()
  (createNode 
  '(
    ((0) (0))
    ((0) (1))
  )
   nil 1)
)

(defun notestea()
  (createnode 
    '(
      ((0 0 0) (0 0 1) (0 1 1) (0 0 1))
      ((0 0 0) (0 1 0) (0 0 1) (0 1 1))
    ) nil 3
  ) 
)

;==========================================    ALGORITMOS    ==========================================

(defun generateChildrenList (node)
"Gera uma lista de sucessores de um no pai"
  (append
    (generateChildrenhorizontal node)
    (generateChildrenvertical node)
  )
)

(defun generateChildrenHorizontal (node &optional (x 1) (y 1))
"Gera os sucessores com alteracoes horizontais de um no pai"
  (cond 
    ( (> y (length (car (getHorizontalArcs(nodeGetBoard node))))) 
      (generateChildrenHorizontal node (1+ x))
    )
    ( (> x (length (getHorizontalArcs(nodeGetBoard node))))  '())
    ( (not (listp (horizontalArc x y(nodeGetBoard node))))  (generateChildrenHorizontal node x (1+ y)))

    (T
      (cons 
        (createnode 
          (horizontalArc x y (nodeGetBoard node)) 
          node 
          (nodegetboxes node) 
          (1+ (nodeGetDepth node))
        )
        (generateChildrenHorizontal node x (1+ y))
      )   
    )
  )
)
#| 
(
  ((0 0 0) (0 0 1) (0 1 1) (0 0 1)) 
  ((0 0 0) (0 1 0) (0 0 1) (0 1 1))
)

(trace )
(trace generatechildrenvertical)
(trace bfs)
(bfs(list(notestea)))

 |#

 
(defun generateChildrenVertical (node &optional (x 1) (y 1))
"Gera os sucessores com alteracoes verticais de um no pai"
  (cond 
    ( (> y (length (car (getVerticalArcs(nodeGetBoard node))))) 
      (generateChildrenVertical node (1+ x))
    )
    ( (> x (length (getVerticalArcs(nodeGetBoard node))))  '())
    ( (not (listp (VerticalArc y x (nodeGetBoard node))))  (generateChildrenVertical node x (1+ y)))

    (T
      (cons 
        (createnode 
          (VerticalArc x y (nodeGetBoard node)) 
          node 
          (nodegetboxes node) 
          (1+ (nodeGetDepth node))
        ) 
        
        (generateChildrenVertical node x (1+ y))
      )   
    )
  )
)

(defun generateChildrenListA* (node hfunc)
  (mapcar 
    (lambda (n))
      (nodesetheuristic n hfunc)
    (generatechildrenlist node)
  )
)

(defun pathToRoot (node)
  (if(nodegetparent node) 
    (append (pathtoRoot (nodegetparent node)) (list (nodegetboard node)))
    (list (nodegetboard node))
  )
)

(defun nodeRemoveDuplicates(lista opened closed)
  (removeDuplicates (removeDuplicates (removenil lista) (removenil opened)) (removenil closed))
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

(defun firstSolution (listNodes)
  (progn
    (print listnodes)
    (format t "~%count closed boxes = ~a   nodegetboxes = ~a~%" (countclosedboxes (nodegetboard (car listnodes))) (nodegetboxes (car listnodes)))
    (if (car listnodes)
      (let (current (car listnodes))
        (if (< (countclosedboxes (nodegetboard current)) (nodegetboxes current))
          (firstsolution (cdr listnodes))
          current
        )
      )
      nil
    )
  )
)

;;(bfs (list(noTeste)))
(defun bfs(opened &optional (closed '()))
  (progn
    (format t "~%o = ~a  c = ~a~%" (length opened) (length closed))
    (if(car opened)
        (if (< (countclosedboxes (nodegetboard (car opened))) (nodegetboxes (car opened)))
          (let*
            (
              (currNode (car opened))
              (children (generatechildrenlist currnode))
            )
            (if (car children)
              (bfs (append (cdr opened) children) (append closed (list currnode)))
              (list (pathtoroot currnode) (length opened) (length closed))
            )
          )
          (list (pathtoroot (car opened)) (length opened) (length closed))
        )
    
      #| (let* 
        (
          (currNode (car opened))
          (children (generatechildrenlist currnode))
          (childSolution (firstsolution children))
        )
        (if childsolution
          (list(pathtoroot childsolution) (length opened) (length closed))
          (bfs (append (cdr opened) children) (append closed (list currnode)))
        )
        ;por n em closed e children em opened
      ) |#
    )
  )
)



;;(dfs (list(noTeste)) 100)
(defun dfs(opened maxDepth &optional (closed '()))
  (cond
    ((not (car opened)) (print (car opened)))
    ((> (nodegetdepth (car opened)) maxDepth)
      (dfs (cdr opened) maxDepth (append closed (list (car opened))))
    )
    (T
      (let*
        (
          (chosenNode (car opened))
          (children (generateChildrenlist chosennode))
        )
        (if (car children)
          (dfs (append (nodeRemoveDuplicates children opened closed) (list (cdr opened))) maxdepth (append closed (list chosennode)))
          (list (pathtoroot chosennode) (length opened) (length closed))
        )
      )
    )
  )
)

(defun cheapestNode (nodeList)
"returns the node with the lowest f in nodeList"
  (if (cdr nodeList)
    (let (currentnode (cheapestnode(cdr nodeList)))
      (if (< (nodegetf (car nodeList)) (nodegetf currentnode))
        (car nodeList)
        currentnode
      )
    )
    (car nodeList)
  )
)

(defun A* (heuristicFunction opened &optional (closed '()) (expandedChildren 0))
  (if (car opened)
    (let*
      (
        (currentNode (cheapestnode opened))
        (children (generatechildrenlistA* currentnode heuristicfunction))
      )
    )
  )
)

;==========================================    PENATRANCE    ==========================================

(defun penetrance (solution)
 "Funcao para calcular e definir a penetrancia da solucao final"
    (coerce (/ (getsolutionlenght solution) (+ (second solution)(third solution))) 'float)
) 


;==========================================    HEURISTIC    ==========================================


(defun baseHeuristic (node)
  (- (nodegetboxes node) (countClosedBoxes (nodegetboard node)))
)

;;  ((0 0 0) (0 0 1) (0 1 1) (0 0 1)) ((0 0 0) (0 1 0) (0 0 1) (0 1 1)) 
(defun personalizedHeuristic (node)
  ()
)


;==========================================    AVERAGE BRANCHING FACTOR    ==========================================

(defun averageBranchingFator (solution &optional (depth (getsolutionlenght solution)) (generatedNodes (numbergeneratednodes solution))
  (tolerance 0.1) (min 0) (max (numbergeneratednodes solution)))
  (let ((average (/ ( + min max) 2)))
       (cond 
        ((< (- max min) tolerance) (/ (+ max min) 2))
        ((< (auxiliarbranching average depth generatednodes) 0) 
                (averagebranchingfator solution depth generatednodes tolerance average max))
          (t (averagebranchingfator solution depth generatednodes tolerance min average))
       )
  )
)

(defun auxiliarBranching (average depth generatedNodes)
 (cond
   ((= 1 depth) (- average generatednodes))
   (T (+  (expt average depth) 
          (auxiliarBranching average (- depth 1) generatednodes)))
  )
)
