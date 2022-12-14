;;  Deve conter a implementacao de:
;;  1. Algoritmo de Procura de Largura Primeiro (BFS)
;;  2. Algoritmo de Procura do Profundidade Primeiro (DFS)
;;  3. Algoritmo de Procura do Melhor Primeiro (A*)
;;  4. Os algoritmos SMA*, IDA* e/ou RBFS (caso optem por implementar o bonus)
;;  Autores: Luis Rocha e Samuel Ribeiro
;;  Ano letivo 22/23

;==========================================    NOS    ==========================================

(defun createNode (board parent boxes &optional (d 0) (h 0))
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
  (+ (nodegetdepth node) (nodegetheuristic node))
)

(defun nodeSetHeuristic(node hFunc)
"sets the heuristic of a node"
  (replaceElem node 4 (funcall hfunc node)) 
)

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

(defun notesteb()
  (createnode 
    '(
      ((0 0 1 0) (1 1 1 1) (0 0 1 1) (0 0 1 1) (0 0 1 1)) 
      ((0 0 1 1) (0 0 1 1) (1 1 1 1) (1 0 1 1) (0 1 1 1))
    ) nil 7
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
    ( (/= 0 (getarconposition x y (gethorizontalarcs(nodegetboard node))))  (generateChildrenHorizontal node x (1+ y)))

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

(defun generateChildrenVertical (node &optional (x 1) (y 1))
"Gera os sucessores com alteracoes verticais de um no pai"
  (cond 
    ( (> y (length (getVerticalArcs(nodeGetBoard node)))) 
      (generateChildrenVertical node (1+ x))
    )
    ( (> x (length (car (getVerticalArcs(nodeGetBoard node))))) '())
    ( (/= 0 (getarconposition y x (getverticalarcs(nodegetboard node))))  (generateChildrenVertical node x (1+ y)))

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
    #'(lambda (x) 
      (nodesetheuristic x 'baseheuristic)
    ) 
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
  (if (car listnodes)
    (if (<= (nodegetboxes (car listnodes)) (countclosedboxes(nodegetboard (car listnodes))))
      (car listnodes)
      (firstsolution (cdr listnodes))
    )
    nil
  )
)

(defun bfs(opened &optional (closed '()))
  (if(car opened)
      (if (< (countclosedboxes (nodegetboard (car opened))) (nodegetboxes (car opened)))
        (let*
          (
            (currNode (car opened))
            (children (removenil (generatechildrenlist currnode)))
            (solution (firstsolution children))
          )
          (if (null solution) 
            (if (car children)
              (bfs (append (cdr opened) children) (append closed (list currnode)))
              (list (pathtoroot currnode) (length opened) (length closed))
            )
            (list (pathtoroot solution) (length opened) (length closed))
          )
        )
        (list (pathtoroot (car opened)) (length opened) (length closed))
      )
  )
)

(defun dfs(opened maxDepth &optional (closed '()))
  (cond
    ((not (car opened)) nil)
    ((> (nodegetdepth (car opened)) maxDepth)
      (dfs (cdr opened) maxDepth (append closed (list (car opened))))
    )
    (T
      (let*
        (
          (chosenNode (car opened))
          (children (generateChildrenlist chosennode))
          (solution (firstsolution children))
        )
        (if (null solution)
          (if (car children)
            (dfs (append children (list (cdr opened))) maxdepth (append closed (list chosennode)) )
            (list (pathtoroot chosennode) (length opened) (length closed))
          )
          (list (pathtoroot solution) (length opened) (length closed))
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

(defun insertListIfNotMember (elem list1 list2)
  (if (and
      (not (member elem list1))
      (not (member elem list2))
    )
    (cons list1 (list elem))
  )
)

(defun orderChildrenByF (children)
  (if(car children)
    (if (> (nodegetF (car children)))

    )
  )
)

(defun A* (heuristicFunction opened &optional (closed '()) (expandedChildren 0))
  (if (car opened)
    (let*
      (
        (currentNode (cheapestnode opened))
        (children (generatechildrenlistA* currentnode heuristicfunction))
        (solution (firstsolution children))
      )
      (if(null solution)
        (a* heuristicfunction opened closed (+ expandedchildren (length children)))
        (list (pathtoroot solution) (length opened) (length closed))
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
