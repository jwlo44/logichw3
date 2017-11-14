#|
CS 2800 Homework 10 - Fall 2017


This homework is to be done in a group of 2-3 students. 

If your group does not already exist:

 * One group member will create a group in BlackBoard
 
 * Other group members then join the group
 
 Submitting:
 
 * Homework is submitted by one group member. Therefore make sure the person
   submitting actually does so. In previous terms when everyone needed
   to submit we regularly had one person forget but the other submissions
   meant the team did not get a zero. Now if you forget, your team gets 0.
   - It wouldn't be a bad idea for group members to send confirmation 
     emails to each other to reduce anxiety.

 * Submit the homework file (this file) on Blackboard. Do not rename 
   this file. There will be a 10 point penalty for this.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm group membership with the BB groups.
   If you fail to follow these instructions, it costs us time and
   it will cost you points, so please read carefully.


Names of ALL group members: Julia Wlochowski, Dylan Wight

Note: There will be a 10 pt penalty if your names do not follow 
this format.
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
 Inductive Proofs:
 - For all proofs below, solutions must be in the format described in class and
   in the notes. This includes:
     * Explicitly identifying an induction scheme and the function that gives
       rise to it.
     * Labeling general context (C1, C2....) and derived context.
     * Providing justifications for each piece of derived context.
     * Explicitly identifying axioms and theorems used
     * The if axioms and theorem substitutions are not required. You can use
       any other shortcuts previously identified.
     * PL can be given as justification for any propositional logic rules with the
      exceptions of Modus Ponens (MP) and Modus Tollens (MT)
     * Hocus Pocus (HP) is not permissible justification.
     * All arithmetic rules can be justified by writing "Arithmetic".
     
Previous homeworks (such as HW05) identify these requirements in more detail.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
For this homework you may want to use ACL2s to help you.

Technical instructions:

- open this file in ACL2s as hw10.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. Do not remove or comment out anything pre-existing
  unless asked to.

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. Comments should also be used for any English
  text that you may add. This file already contains many comments, so you
  can see what the syntax is.

- when done, save your file and submit it as hw10.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file!

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
Instructions for programming problems:

For each function definition, you must provide both contracts and a body.

You must also ALWAYS supply your own tests (unless otherwise noted). This is in 
addition to the tests sometimes provided. Make sure you produce sufficiently 
many new test cases. This means: cover at least the possible scenarios 
according to the data definitions of the involved types. For example, 
a function taking two lists should have at least 4 tests: all combinations 
of each list being empty and non-empty.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number of inputs.

Use good judgment. For unreasonably few test cases we will deduct points.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PART I: Warm up Proof 
;; 

#|
We start with some familiar definitions just in case they
are useful. You will be asked to
define functions later on. Make sure to use defunc.

(defunc listp (x)
  :input-contract t
  :output-contract (booleanp (listp x))
  (if (consp x)
      (listp (rest x))
    (equal x nil)))

(defunc app (a b) 
  :input-contract (and (listp a) (listp b))
  :output-contract (listp (app a b))
  (if (endp a)
      b
    (cons (first a) (app (rest a) b))))

(defunc in (a X) 
  :input-contract (listp X)
  :output-contract (booleanp (in a X))
  (cond ((endp X) nil)
        ((equal a (first X)) t)
        (t (in a (rest X)))))

|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; del: Any x List -> List
;; (del e l) takes an element e and a list l
;; and removes the FIRST occurance of e from l
;; If e is not in l then l is returned.
(defunc del (e l)
  :input-contract (listp l)
  :output-contract (listp (del e l))
  (if (endp l)
    l
    (if (equal e (first l))
      (rest l)
      (cons (first l) (del e (rest l))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; perm: List x List -> Boolean
;; (perm l1 l2) takes two lists (l1 and l2) and
;; returns true if and only if l1 and l2 have
;; the same elements (and the same number of each)
;; Essentially, is l2 a reordering of l1.
(defunc perm (l1 l2)
  :input-contract (and (listp l1)(listp l2))
  :output-contract (booleanp (perm l1 l2))
  (if (equal l1 l2)
    t
    (if (endp l1)
      nil
      (and (in (first l1) l2)
           (perm (rest l1) (del (first l1) l2))))))



;; Assume by "Def of lor" that each element is a rational
;; and a lor is (cons rational lor) | nil
;; A similar claim can be made about a lon
(defdata lor (listof rational))
(defdata lon (listof nat))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; orderedp: lor -> boolean
;; (orderedp l) takes a list of rationals
;; and returns true if and only if the elements 
;; are in non-decreasing order (ie they are sorted)
(defunc orderedp (l)
  :input-contract (lorp l)
  :output-contract (booleanp (orderedp l))
  (if (or (endp l)(endp (rest l)))
    t
    (and (<= (first l) (second l)) (orderedp (rest l)))))

(check= (orderedp '(-1 -1/2 0 4 9/2)) t)
(check= (orderedp '(-1 -1/2 0 4 7/2)) nil)
(check= (orderedp nil) t)


(defthm phi_applen (implies (and (listp l1) (listp l2))
                            (equal (len (app l1 l2))
                                   (+ (len l1)(len l2)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; merge: lor x lor -> lor
;; (merge l1 l2) takes two lists of rationals l1 and l2
;; that are PRESUMED to be already in sorted order and 
;; generates a new list with all elements from l1 and l2 
;; still in order. We do this by comparing the first of 
;; l1 and l2 and cons-ing the smallest of the two
;; onto the results of a recursive call with the 
;; rest of one list and the other list.
;; Thus the lists can be merged in O(n) time.
(defunc merge (l1 l2)
  :input-contract (and (lorp l1)(lorp l2))
  :output-contract (lorp (merge l1 l2))
  (cond ((endp l1)   l2)
        ((endp l2)   l1)
        ((< (first l1)(first l2))  
         (cons (first l1)(merge (rest l1) l2)))
        (t                          
         (cons (first l2)(merge l1 (rest l2))))))

(test? (implies (and (lorp l1)(lorp l2)(sortedp l1)(sortedp l2))
                (sortedp (merge l1 l2))))

(test? (implies (and (lorp l1)(lorp l2))
                (equal (+ (len l1)(len l2))
                       (len (merge l1 l2)))))

(check= (merge '(1 3 5 7) '(2 4 6 8)) '(1 2 3 4 5 6 7 8))
(check= (merge '(1 2 3 4) '(5 6 7 8)) '(1 2 3 4 5 6 7 8))

#|
Prove the following conjecture -                  
phi_mergeordered: (implies (and (lorp l1)(lorp l2)(orderedp l1)(orderedp l2))
                        (orderedp (merge l1 l2)))

What Induction Scheme should you use? Provide the proof obligations

IS for merge
1. (not (and (lorp l1) (lorp l2))) => phi
2. (and (lorp l1) (lorp l2) (endp l1)) => phi
3. (and (lorp l1) (lorp l2) (not (endp l1)) (endp l2)) => phi
4. (and (lorp l1) (lorp l2) (not (endp l1)) (not (endp l2)) (< (first l1)(first l2)) (phi|(l1 (rest l1))) => phi
5. (and (lorp l1) (lorp l2) (not (endp l1)) (not (endp l2)) (not (< (first l1)(first l2))) (phi|(l2 (rest l2))) => phi

1. (and (not (and (lorp l1) (lorp l2)) (lorp l1) (lorp l2) ... ) => ...
true, PL
the LHS of the implies after exportation is always false

written out:
(implies (and ((not (and (lorp l1) (lorp l2))) (lorp l1)(lorp l2)(orderedp l1)(orderedp l2))
                        (orderedp (merge l1 l2)))
						
c1. (not (and (lorp l1) (lorp l2)))
c2. (and (lorp l1) (lorp l2))
..............................
contradiction
c3. nil {c1, c2}


2. (implies (and (lorp l1) (lorp l2) (endp l1)(orderedp l1)(orderedp l2))
            (orderedp (merge l1 l2)))
            
contexts
c1. lorp l1
c2. lorp l2
c3. orderedp l1
c4. orderedp l2
c5. endp l1

prove 
(orderedp (merge l1 l2)))

def. merge, c5
(orderedp (l2))

c4
QED

3. (implies (and (lorp l1) (lorp l2) (not (endp l1))(endp l2)(orderedp l1)(orderedp l2))
            (orderedp (merge l1 l2)))
contexts
c1. lorp l1
c2. lorp l2
c3. orderedp l1
c4. orderedp l2
c5. not endp l1
c6. endp l2

prove 
(orderedp (merge l1 l2)))

def. merge, c5, c6
(orderedp (l1))

c3
QED

4. (implies (and (lorp l1) 
                 (lorp l2)
				 (not (endp l1))
				 (not (endp l2))
				 (< (first l1)(first l2)) 
				 (implies (and (lorp (rest l1))(lorp l2)(orderedp (rest l1))(orderedp l2))
                        (orderedp (merge (rest l1) l2))))
			(orderedp (merge l1 l2)))
contexts
c1. lorp l1
c2. lorp l2
c3. orderedp l1
c4. orderedp l2
c5. not endp l1
c6. not endp l2
c7. (< (first l1)(first l2)) 
c8. (implies (and (lorp (rest l1))(lorp l2)(orderedp (rest l1))(orderedp l2))
                        (orderedp (merge (rest l1) l2))))
................................................................................
c9. lorp rest l1 {def. lorp, c1, c5}
c10. (orderedp (rest l1)) {def. orderedp, c3, c5}
c11. (orderedp (merge (rest l1) l2)))) {c10, c9, c8, c2, c4, MP}

prove
(orderedp (merge l1 l2)))

def. merge, c5, c6, c7
(orderedp (cons (first l1)(merge (rest l1) l2)))

def. orderedp, first-rest cons
(and (<= (first l1) (second (cons (first l1)(merge (rest l1) l2)))
     (orderedp (merge (rest l1) l2)))))
	
c11, PL
(<= (first l1) (second (cons (first l1)(merge (rest l1) l2)))

def. second
(<= (first l1) (first (merge (rest l1) l2)))

def. merge, c6
(<= (first l1) (first
     (cond ((endp (rest l1))   l2)
        ((< (first (rest l1))(first l2))  
         (cons (first (rest l1))(merge (rest (rest l1)) l2)))
        (t                          
         (cons (first l2)(merge (rest l1) (rest l2))))))
3 return cases:
   (<= (first l1)(first l2)
   (<= (first l1)(first (cons (first (rest l1))(merge (rest (rest l1)) l2))))
   (<= (first l1)(first (cons (first l2)(merge (rest l1) (rest l2))))))
Those cases simplified: (by first-rest, cons, and def. second)
   (<= (first l1)(first l2))
   (<= (first l1)(second l1))
so just 2 cases to prove
case 1.
(<= (first l1) (first l2))
c7
true
case 2.
(<= (first l1) (second l1))
c3, def. orderedp, PL
QED
   

5. same as 4 but with l2



(implies (and (lorp l1) 
                 (lorp l2)
				 (not (endp l1))
				 (not (endp l2))
				 (not (< (first l1)(first l2)) )
				 (implies (and (lorp l1)(lorp (rest l2))(orderedp l1))(orderedp (rest l2)))
                        (orderedp (merge l1 (rest l2))))
			(orderedp (merge l1 l2)))
contexts
c1. lorp l1
c2. lorp l2
c3. orderedp l1
c4. orderedp l2
c5. not endp l1
c6. not endp l2
c7. (not (< (first l1)(first l2)) )
c8. (implies (and (lorp (rest l1))(lorp l2)(orderedp (rest l1))(orderedp l2))
                        (orderedp (merge (rest l1) l2))))
................................................................................
c9. lorp rest l2 {def. lorp, c2, c6}
c10. (orderedp (rest l2)) {def. orderedp, c4, c6}
c11. (orderedp (merge l1 (rest l2))) {c10, c9, c8, c1, c3, MP}

prove
(orderedp (merge l1 l2)))

def. merge, c5, c6, c7
(orderedp (cons (first l2)(merge l1 (rest l2))))

def. orderedp, first-rest cons
(and (<= (first l2) (second (cons (first l2)(merge l1 (rest l2))))
     (orderedp (merge l1 (rest l2)))))
	
c11, PL
(<= (first l2) (second (cons (first l2)(merge l1 (rest l2))))

def. second
(<= (first l2) (first (merge l1 (rest l2))))

def. merge, c5
(<= (first l3) (first
     (cond ((endp (rest l2))   l1)
        ((< (first l1)(first (rest l2)))  
         (cons (first l1)(merge (rest l1) l2)))
        (t                          
         (cons (first (rest l2))(merge l1 (rest (rest l2)))))))
3 return cases:
   (<= (first l2)(first l1)
   (<= (first l2)(first (cons (first l1)(merge (rest l1) l2)))
   (<= (first l2)(first (cons (first (rest l2))(merge l1 (rest (rest l2)))))))
Those cases simplified: (by first-rest, cons, and def. second)
   (<= (first l2)(first l1))
   (<= (first l2)(second l2))
so just 2 cases to prove
case 1.
(<= (first l2)(first l1))
c7
true
case 2.
(<= (first l2)(second l2))
c4, def. orderedp, PL
QED




|#
;; A quick demonstration that ACL2s can do the proof above.
(defthm phi_merge_isort (implies (and (lorp l1)(lorp l2)
                                      (orderedp l1)(orderedp l2))
                                 (orderedp (merge l1 l2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Section 2: isort II: The Revenge 
;; Last week we started work on the merge sort algorithm
;; proving that it not only terminates but it's equivalent
;; to isort.....by giving you a HUGE assumption about 
;; merging isort.
;; We will prove this conjecture
;;
;; Once again, this is going to be deceptively complex 
;;
;; You will need to use induction and some induction schemes are also 
;; easier to use than others.  
;; My stategy for choosing an I.S. is:
;; 1) Choose the simplest I.S. that changes variables like your functions will
;;    -> As a first pass, I always look at nind and listp in case they work.
;; 2) Make sure there are no variables in the I.S. that are not in the conjecture
;; 3) Choose an I.S. that provides useful context in your proof.
;; 4) Try to have your base cases in the I.S. match the recursive base cases.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(merge '(0 1 2) '(0 2 3))
(merge '(0 1 2) '(0 2 3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; sortedp: LOR x LOR -> Boolean
;; (sortedp origL sortL) takes the original list
;; and the theoretically sorted list (sortL)
;; and determines if sortL is a sorting
;; of the original list.
(defunc sortedp (origL sortL )
  :input-contract (and (lorp origL)(lorp sortL))
  :output-contract (booleanp (sortedp origL sortL))
  (and (perm origL sortL)(orderedp sortL)))



;;============================================
;; TEMPORARY DETOUR:  the proofs regarding isort
;; yet again.  you can use these theorems in your proof
;;============================================

(defunc insert (e l)
  :input-contract (and (rationalp e) (lorp l))
  :output-contract (lorp (insert e l))
  (cond ((endp l) (list e))
        ((<= e (first l)) (cons e l))
        (t (cons (first l) (insert e (rest l))))))

(defunc isort (l) 
  :input-contract (lorp l)
  :output-contract (lorp (isort l))
  (if (endp l)
    l
    (insert (first l) (isort (rest l)))))

(defthm insert-orderedp
  (implies (and (lorp l)
                (orderedp l)
                (rationalp e))
           (orderedp (insert e l))))

(defthm orderedp-isort
  (implies (and (lorp l) (orderedp l))
           (equal (isort l) 
                  l)))

(defthm phi_isort-orderedp
  (implies (lorp l)
           (orderedp (isort l))))

(defthm phi_insert_del
  (implies (and (lorp l)(rationalp r))
           (equal (del r (insert r l)) l)))

(defthm phi_insert_in
  (implies (and (lorp l)(rationalp r))
           (in r (insert r l))))

(defthm phi_insert_perm
  (implies (and (lorp l1)(lorp l2)(rationalp r)
                (perm l1 l2))
           (perm (cons r l1) (insert r l2))))
                

(defthm phi_isort-perm
  (implies (lorp l)
           (perm l (isort l))))

;; Now that we know (isort l) is a permutation
;; of l AND is ordered, we can make the following claim
;; (you do not have to prove any of the above)
(defthm phi_isort_sorted
  (implies (lorp l)
           (sortedp l (isort l))))



#|
Prove phi_merge_isort:
  (implies (and (lorp x)(lorp y))
           (equal (isort (merge x y)) 
                  (merge (isort x) (isort y)))))
......we are going to pretend the original conjecture
we assumed last week involved (isort (merge x y)) rather than
the original (isort (app x y)). You can prove
(isort (merge x y)) = (isort (app x y)) for extra
practice (but this isn't as simple as it seems)

So before you go diving into your proof, think about
things that should be true about merge:

- If lists x and y are ordered, what happens if you switch
from (merge x y) to (merge y x) ?

nothing, merge is commutative
(implies (and (lorp x) (lorp y) (orderedp x) (orderedp y))
         (equal (merge x y) (merge y x))

- What happens when you insert an element into a ordered 
merged list?

the resulting list is ordered
(implies (and (lorp x) (lorp y) (orderedp x) (orderedp y))
         (orderedp (insert e (merge x y))))

also, the result equals the merge of that element into the list
(implies (lorp x) (equal (insert e x)
                         (merge (list e) x)))
						 
inserting into an orderd merged list is a specific example of the line above:
	(implies (and (lorp x) (lorp y) (orderedp x) (orderedp y))
         (equal (insert e (merge x y))
		        (merge (list e) (merge x y))))					 
		 
- What happens if you insert the element
in x (which is ordered) and then merge? 

the resulting list is still ordered. also the list equivalent to the list from above.
(implies (and (lorp x) (lorp y) (orderedp x) (orderedp y))
         (orderedp (merge (insert e x) y)))
(implies (and (lorp x) (lorp y) (orderedp x) (orderedp y))
         (equal (merge (insert e x) y)
		        (insert e (merge x y))))		 

  * Let's assume that  (first x) < (first y) provided 
    lists x and y are non-empty just to make your lives easier 
    You can just add it to your lemma's context rather than 
    the conjecture itself.  If you really want to show off 
    your math skills, you can do the proof without this assumption.
    By the way, why can I order these lists any way I want and make
    that assumption?
	
	merge is commutative
	
Feedback from Dustin: Do NOT try to prove the associativity of merge.
The proof is horrible.  The above questions should guide you to a 
reasonable solution that you can finish before you graduate.

You can also assume the following is true (and can prove it
for extra practice):
L3:
(rationalp e) /\ (lorp l2)
    => (merge (list e) l2) = (insert e l2)
......................

phi:
  (implies (and (lorp x)(lorp y))
           (equal (isort (merge x y)) 
                  (merge (isort x) (isort y))))
"the sorted version of two merged lists is the same as the merge of the two lists each sorted"
this is true because merge puts every pair of elements in order
also: (orderedp (merge (orderedp x) (orderedp y)))
also: (orderedp (isort x))
so: (orderedp (merge (isort x) (isort y)))


IS for merge
1. (not (and (lorp l1) (lorp l2))) => phi
2. (and (lorp l1) (lorp l2) (endp l1)) => phi
3. (and (lorp l1) (lorp l2) (not (endp l1)) (endp l2)) => phi
4. (and (lorp l1) (lorp l2) (not (endp l1)) (not (endp l2)) (< (first l1)(first l2)) (phi|(l1 (rest l1))) => phi
5. (and (lorp l1) (lorp l2) (not (endp l1)) (not (endp l2)) (not (< (first l1)(first l2))) (phi|(l2 (rest l2))) => phi
				  
>> proving like a PRO *sunglasses emoji*
cmagic: first x < first y  {given as hint}
	
lemma 1: we probably need this	{taken from hints above}	
(implies (and (lorp x) (lorp y))
         (equal (merge (insert e x) y)
		        (insert e (merge x y))))					
prove:
(equal (isort (merge x y)) 
       (merge (isort x) (isort y))))
	  
def. isort 
(equal (insert (first (merge x y)) (isort (rest (merge x y))))
       (merge (isort x) (isort y)))
	   
def. isort
(equal (insert (first (merge x y)) (isort (rest (merge x y))))
       (merge (insert (first x) (isort (rest x))) (isort y)))

cmagic, def. merge, first-rest, cons
(equal (insert (first x) (isort (rest (merge x y))))
       (merge (insert (first x) (isort (rest x))) (insert (first y) (isort (rest y)))))
	   
inductive step: assume (isort (rest (merge x y))) == (merge (isort (rest x) (isort y)))
(equal (insert (first x) (merge (isort (rest x) (isort y))))
       (merge (insert (first x) (isort (rest x))) (insert (first y) (isort (rest y)))))
				
lemma 1|((e (first x)) (x (isort (rest x))) (y (isort y)))
(equal (merge (insert (first x) (isort (rest x))) (isort y))
       (merge (insert (first x) (isort (rest x))) (isort y)))
QED 

this is wrong because I need to explain where I got (merge (isort (rest x)) (isort y)) from
ok back up where did that inductive hypothesis come from?
IS for Isort
1. not lorp l => phi
2. (lorp l) /\ (endp l) => phi
3. (lorp l) /\ (not endp l) /\ phi|(rest l) => phi

we're using this induction scheme where l is (merge x y)
here's the proof obligation #3 written out
(implies (and (lorp x)
              (lorp y) 
              (not (endp (merge x y)))
			  (implies (and (lorp x) (lorp y)
			                (lorp (merge x y))
			                (not (endp (merge x y))))
					   (equal (isort (rest (merge x y)))
					          (merge (isort (rest x) (isort y)))
c1. lorp x
c2. lorp y
c3. (not (endp (merge x y)))
c4. the inner implies
.......................
c5. (equal (isort (rest (merge x y)))
		   (merge (isort (rest x) (isort y))) {c1, c2, c3, c4, MP}

							  


now to prove the base cases
proof obligation 1:
contradiction in LHS of implies thanks to induction scheme + phi having (not (and (lorp x) (lorp y))) and (and (lorp x) (lorp y))

proof obligation 2:
x is empty
c1. lorp x
c2. lorp y
c3. endp x
prove
(equal (isort (merge x y)) 
       (merge (isort x) (isort y))
def. merge, c3
(equal (isort y)
       (merge (isort x) (isort y)))

def. isort, c3
(equal (isort y)
       (merge nil (isort y)))
	   
def. merge when l1 is nil	   
(equal (isort y)
       (isort y))

	
proof obligation 3:
y is empty
c1. lorp x
c2. lorp y
c3. not endp x
c4. endp y

prove
(equal (isort (merge x y)) 
       (merge (isort x) (isort y))
	   
def. merge, c3, c4
(equal (isort x)
       (merge (isort x) (isort y)))

def. isort, c4
(equal (isort x)
       (merge (isort x) nil))
	   
def. merge when l2 is nil	   
(equal (isort x)
       (isort x))
	   
qed for proof obligation 2
	
proof for lemma 1:
(implies (and (lorp x) (lorp y))
         (equal (merge (insert e x) y)
		        (insert e (merge x y))))   

IS for Insert
1. (not lorp l) => phi
2. (lorp l) /\ (endp l) => phi
3. (lorp l) /\ (not (endp l)) /\ phi|(l (rest l))
using IS for merge


proof obligation 1
c1. (not (and (lorp x) (lorp y)))
c2. (and (lorp x) (lorp y))
contradiction, LHS of implies is false so this is true by PL
qed for lemma 1 obligation 1

proof obligation 2
c1. (lorp x)
c2. (lorp y)
c3. (endp x)
				  
prove 
(equal (merge (insert e x) y)
		        (insert e (merge x y)))) 

def. insert, c3,
(equal (merge (list e) y)
       (insert e (merge x y)))

def. merge, c3 
(equal (merge (list e) y)
       (insert e y))
{Lemma 2}
QED for Lemma 1 proof obligation 2
	   


==========================================================================================
Lemma 2
(implies (lorp x) (equal (insert e x)
                         (merge (list e) x)))
==============================================
what's that induction scheme?
IS for listp
1. (endp x) => phi
2. (not (enpd x)) /\ phi|(x (rest x)) => phi						 
						 
==============================================						 
Lemma 2 proof obligation 1:
(implies (and (lorp x)
			  (endp x))
		 (equal (insert e x)
		        (merge (list e) (rest x))))
				
c1. lorp x
c2. endp x
(equal (insert e x)
	   (merge (list e) x))
	   
def. insert, c2
(equal (list e)
       (merge (list e) x))
	  
def. merge, c2
(equal (list e)
       (list e))						 
						 
==============================================						 
 Lemma 2 proof obligation 2
(implies (and (lorp x)
			  (not (endp x))
			  (implies (lorp (rest x))
			           (equal (insert e (rest x))
					          (merge (list e) (rest x)))))
		 (equal (insert e x)
		        (merge (list e) x)))
c1. lorp x
c2. not endp x
c3. (implies (lorp (rest x))
		     (equal (insert e (rest x))
		            (merge (list e) (rest x)))))
..................................................
c4. lorp rest x {c1, c2, first-rest, listp, endp}
c5. (equal (insert e (rest x))
		   (merge (list e) (rest x)))))
				
(equal (insert e x)
	   (merge (list e) x))
				
def. merge, def. list, first-rest	 
(equal
  (cond ((endp y)   (list e))
        ((< e (first y))  
         (cons e (merge nil y)))
        (t                          
         (cons (first y)(merge (list e) (rest y))))))	
  (insert e y))		 
	
def. merge when l1 is nil
(equal
  (cond ((endp y)         (list e))
        ((< e (first y))  (cons e y))
        (t                (cons (first y)(merge (list e) (rest y)))))	
  (insert e y))
	
def. insert
(equal
  (cond ((endp y)         (list e))
        ((< e (first y))  (cons e y))
        (t                (cons (first y)(merge (list e) (rest y)))))
  (cond ((endp y)         (list e))
        ((<= e (first y)) (cons e y))
        (t (cons (first y) (insert e (rest y))))))

arithmetic, PL, def. insert
(equal
  (cond ((endp y)         (list e))
        ((< e (first y))  (cons e y))
        (t                (cons (first y)(merge (list e) (rest y)))))
  (cond ((endp y)         (list e))
        ((< e (first y))  (cons e y))
        (t                (cons (first y) (insert e (rest y))))))
		
PL, cond-axioms -> the only case we care about is the t case, clearly the other two are equal
(equal (cons (first y)(merge (list e) (rest y)))))
       (cons (first y) (insert e (rest y))))

{c4} 
(equal (cons (first y)(merge (list e) (rest y)))))
       (cons (first y)(merge (list e) (rest y))))
	   
qed for lemma 1 proof obligation 2


lemma 1 proof obligation 4


|#



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SECTION III: Revisiting Mistakes
;; So if you couldn't tell, I don't actually
;; enjoy making mistakes but they're extremely useful
;; to help us learn.  In a previous homework, I asked
;; you to prove a conjecture but since there was a
;; counter example, many of you were able to get points
;; without a proof.  Well I can't let that happen.
;; I've improved my factoring functions so you can
;; see what the function could have looked like 
;; if I made a different design decision.....and while
;; we're at it, let's do an inductive proof using
;; these new function (the actual reason we are revisiting
;; the function)

 ;; gpos for potential positive integers greater than 1. 
(defdata gpos (range integer (2 <= _)))
;; Ignore
(defthm phi_shrink_factor (implies (and (gposp n)(gposp f)(posp (/ n f)))
                                   (< (/ n f) n)))
(defdata log (listof gpos))


(defunc factors-help (n f)
  :input-contract (and (gposp n)(gposp f))
  :output-contract (logp (factors-help n f))
  (if (<= n f)
    (list n)
    (if (gposp (/ n f)) 
      (cons f (factors-help (/ n f) f))
      (factors-help n (+ f 1)))))
  

;; factors : Factor -> log
;; returns a list containing all PRIME factors of n including (possibly) 
;; n and 1. 
(defunc factors (n)
    :input-contract (gposp n)
    :output-contract (logp (factors n))
    (factors-help n 2))

;; Note the factors for 12 *could* be listed as 1 2 3 4 6 12 but
;; really 12 is uniquely represented as the product of non-decreasing 
;; prime numbers: 2*2*3.  Thus factors will return '(2 2 3)  
;; 13 is prime so it isn't decomposed into other
;; primes and '(13) is returned. 
;; If you get the same values but in a different order, feel free to 
;; change the tests.
(check= (factors 2)'(2))
(check= (factors 4)'(2 2))
(check= (factors 6)'(2 3))
(check= (factors 12)'(2 2 3))
(check= (factors 13)'(13))

;; GIVEN
;; Defined in previous functions. Removes
;; the first instance of an element in a list
(defunc delete (e l)
  :input-contract (listp l)
  :output-contract (listp (delete e l))
  (if (endp l)
    l
    (if (equal e (first l))
      (rest l)
      (cons (first l)(delete e (rest l))))))

;; Ignore
(sig delete (all (listof :b)) => (listof :b))

;; GIVEN
;; intersect: list x list -> list
;; (intersect l1 l2) returns a list containing every element 
;; that is in both lists l1 and l2.
(defunc intersect (l1 l2)
    :input-contract (and (listp l1) (listp l2))
    :output-contract (listp (intersect l1 l2))
    (cond ((endp l1) l1)
          ((in (first l1) l2) 
           (cons (first l1)
                 (intersect (rest l1) 
                            (delete (first l1) l2))))
          (t (intersect (rest l1) l2))))

;; GIVEN
;; coprime: pos x pos -> boolean
;; determines whether two positive integers a and b are coprime
(defunc coprime (a b)
    :input-contract (and (gposp a) (gposp b))
    :output-contract (booleanp (coprime a b))
    (endp (intersect (factors a) (factors b))))

;; this line is for ACL2s
(sig intersect ((listof :b) (listof :b)) => (listof :b))


(defunc mult-l (l)
  :input-contract (logp l)
  :output-contract (posp (mult-l l))
  (if (endp l)
    1
    (* (first l)(mult-l (rest l)))))

;; GIVEN
;; gcd: pos x pos -> pos
;; (gcd a b) determines the greatest common divisor for a and b.
;; Do you remember how to calculate that with prime factors?
(defunc gcd (a b)
    :input-contract (and (gposp a) (gposp b))
    :output-contract (posp (gcd a b))
    (mult-l (intersect (factors a)(factors b))))

(check= (gcd 7 6) 1)
(check= (gcd 8 6) 2)
(check= (gcd 12 6) 6)
(check= (gcd 30 12) 6)
(check= (gcd 30 28) 2)
(check= (gcd 35 28) 7)
(test? (implies (and (posp a)(posp b))
                (equal (gcd a b)(gcd b a))))

;; Just a theorem in case you want ACL2s to do the proof
;; (you cna ignore this)
(defthm phi_cp_intersect 
  (implies (and (gposp a)(gposp b))
           (equal (coprime a b) 
                  (endp (intersect (factors a) 
                                   (factors b))))))

#|
PROVE (optional....you still need to prove phi_prime_factorize)
Once more with feeling: prove phi_gcd_cp.  
This ONE CONJECTURE is not graded
It doesn't require induction. This is just for those
of you that like finishing what you start.

phi_gcd_cp: (implies (and (gposp a)(gposp b))
                     (equal (coprime a b)(equal (gcd a b) 1)))
                     
However, you can't take your mult-l for granted and assume
"arithmetic" explains why non-empty lists of factors must return a value
> 1.

......................

|#

#|
PROVE
Prove phi_prime_factorize:  
(implies (gposp a)(equal a (mult-l (factors a))))

;; "a number is equal to the product of all its prime factors"
				
IS for factors-help
1. (and (not (gposp a)) (gposp f)) => phi
2. (gposp a) /\ (gposp f) /\ (<= a f) => phi
3. (gposp a) /\ gposp f) /\ (not(<= a f)) /\ (gposp (/ a f)) /\ phi|(a (a/f)) => phi
4. (gposp a) /\ (gposp f)/\ (not(<= a f)) /\ (not(gposp (/ a f))) /\ phi|(f (f + 1)) => phi


Lemma: (implies (and (gposp a) (gposp f))
                (equal a (mult-l (factors-help a f))))


proof obligation 1. not the input contract
(and (not (gposp a)) (gposp a) => anything
true by PL

proof obligation 2. base case
(implies (and (gposp a)(gposp f) (<= a f))(equal a (mult-l (factors-help a f))))

contexts
c1. (gposp a)
c2. (gposp f)
c3. (<= a f)

Prove
a = (mult-l (factors-help a f))

def. factors-help, c3
a = (mult-l  (list a))

def. mult-l
a = (* (first (list a))(mult-l (rest (list a))))))

def. mult-l, list, endp, first-rest
a = a * 1

artihmetic
QED for Lemma Proof Obligation 2.


proof obligation 3: recursive case 1


(implies (and (gposp a) 
              (gposp f)
			  (not(<= a f)) 
			  (gposp (/ a f))
			  (implies (and (gposp a/f) (gposp f))
			           (equal a/f (mult-l (factors-help a/f f)))))
		(equal a (mult-l (factors-help a f))))

contexts
c1. (gposp a) 
c2. (gposp f)
c3. (not(<= a f)) 
c4. (gposp (/ a f))
c5. (implies (and (gposp a/f) (gposp f))
	         (equal a/f (mult-l (factors-help a/f f)))))
..........................................................
c6. (equal a/f (mult-l (factors-help a/f f))) {MP, c5, c4, c2}

prove 
(equal a (mult-l (factors-help a f))))

def. factors-help, c3, c4
 (equal a  (mult-l (cons f (factors-help (/ a f) f)))
 
def. mult-l, cons, endp
(equal a  (* (first (cons f (factors-help (/ a f) f))))(mult-l (rest (cons f (factors-help (/ a f) f))))))))

first-rest
(equal a (* f (mult-l (factors-help (/ a f) f))))

c6
(equal a (* f (/ a f)))

arithmetic
(equal a a )
QED for Lemma Proof Obligation 3
 

proof obligation 4: recursive case 2
(implies (and (gposp a) 
              (gposp f)
			  (not(<= a f)) 
			  (not (gposp (/ a f)))
			  (implies (and (gposp a) (gposp (f + 1)))
			           (equal a (mult-l (factors-help a (+ 1 f)))))))
		(equal a (mult-l (factors-help a f))))

contexts
c1. (gposp a) 
c2. (gposp f)
c3. (not(<= a f)) 
c4. (not (gposp (/ a f)))
c5. (implies (and (gposp a) (gposp (f + 1)))
			           (equal a (mult-l (factors-help a (+ 1 f)))))))
..........................................................
c6. (gposp (+ 1 f)) {arithmetic, def. gposp, c2} 
c7. (equal a (mult-l (factors-help a (+ 1 f)))) {c1, c6, c5, MP} 

prove 
(equal a (mult-l (factors-help a f))))

def. factors-help, c3, c4
 (equal a  (mult-l (factors-help a (+ f 1)))))
 
c7.
(equal a a)
qed for lemma proof obligation 4



going back to original conjecture
(implies (gposp a)(equal a (mult-l (factors a))))

contexts
c1. gposp a

prove 
(equal a (mult-l (factors a)))

def. factors
(equal a (mult-l (factors-help a 2)))

Lemma | (f 2)
(equal a a)
QED

|#            
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Feedback (5 points)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

I would like to get more feedback from you. Here are a couple questions 
to monitor how the course is progressing.  This should be brief. 

Please fill out the following form.

https://goo.gl/forms/Dhd69pk19amvQCcj2

As before, feedback is anonymous and each team member should fill out
the form (only once per person).

After you fill out the form, write your name below in this file, not
on the questionnaire. We have no way of checking if you submitted the
file, but by writing your name below you are claiming that you did,
and we'll take your word for it.  

5 points will be awarded to each team member for filling out the 
questionnaire.

The following team members filled out the feedback survey provided by 
the link above:
---------------------------------------------
<firstname> <LastName>
<firstname> <LastName>

|#