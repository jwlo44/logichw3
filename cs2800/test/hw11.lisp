#|
CS 2800 Homework 11 - Fall 2017


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

- open this file in ACL2s as hw11.lisp

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

- when done, save your file and submit it as hw11.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file!

|#


#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
1.  Let's revisit a problem from the sample exam.  You've been given functions 
how-many-t and how-many* such that how-many = how-many*
|#
(defunc how-many (e l)
  :input-contract (listp l)
  :output-contract (natp (how-many e l))
  (if (endp l)
    0
    (+ (if (equal e (first l)) 1 0)
       (how-many e (rest l)))))

;; how-many-t: All x List x Nat -> Nat
;; The tail recursive helper function for how-many*
;; where acc keeps a tally of the number of instances of
;; found so far in the list l.
(defunc how-many-t (e l acc)
  :input-contract (and (listp l) (natp acc))
  :output-contract (natp (how-many-t e l acc))
  (if (endp l)
    acc
    (how-many-t e (rest l) (+ (if (equal e (first l)) 1 0) acc))))

;; how-many*: All x List -> Nat
(defunc how-many* (e l)
  :input-contract (listp l)
  :output-contract (natp (how-many* e l))
  (how-many-t e l 0))

#|
The goal is to prove the following conjecture:

phi : (listp l) => (how-many* e l) = (how-many e l)

That is, we want to show that the two functions compute the same result on
all inputs. We will prove this in several steps.

(a) Formulate a lemma that relates how-many-t to how-many, by filling in the ... below:

phi_1 : (listp l) /\ (natp acc) => (how-many-t e l acc) =  (+ (how-many e l) acc)
         

		 
check that this lemma is helpful by seeing if we can use it to prove phi
(implies (listp l)
         (equal (how-many* e l)
                (how-many e l)))

c1. listp l

prove
(equal (how-many* e l)
       (how-many e l))
	  
def. how-many*
(equal (how-many-t e l 0)
       (how-many e l))
	   
phi_1
(equal (+ (how-many e l) 0)
       (how-many e l))
	   
arithmetic
(equal (how-many e l)
       (how-many e l))
qed for phi
		 
(b) Prove phi_1. Use the induction scheme how-many-t gives rise to. Note
that how-many-t has an if nested inside other functions. You can rewrite
it, using cond, before extracting an induction scheme if you want to use
the I.S. generating pattern from the the notes (it may help).

IS for how-many-t 
1. (not (and (listp l) (natp acc))) => phi
2. (and (listp l) (natp acc) (endp l)) => phi
3. (and (listp l) (natp acc) (not (endp l)) (eqaul e (first l)) (phi | (acc (+ 1 acc)) (l (rest l)))) => phi
4. (and (listp l) (natp acc) (not (endp l)) (not (equal e (first l))) (phi | (l (rest l)))) => phi

phi_1
(implies (and (listp l) (natp acc))
         (equal (+ (how-many e l) acc)
                (how-many-t e l acc)))
============================================
phi_1 obligation 1
(implies (and (listp l) (natp acc) (not (and (listp l) (natp acc))))
         (equal (+ (how-many e l) acc)
                (how-many-t e l acc)))
																  
c1. (listp l)
c2. (natp acc)
c3. (not (and (listp l) (natp acc)))
.........................................
c4. nil {c1, c2, c3, PL}
nil => x == t
qed for phi_1 obligation 1
============================================
phi_1 obligation 2
(implies (and (listp l) (natp acc) (endp l))
         (equal (+ (how-many e l) acc)
                (how-many-t e l acc)))

c1. (listp l)
c2. (natp acc)
c3. (endp l)

prove
(equal (+ (how-many e l) acc)
       (how-many-t e l acc)))

def. how-many, c3 
(equal (+ 0 acc)
       (how-many-t e l acc))

arithmetic
(equal acc
      (how-many-t e l acc)) 
	   
def. how-many-t, c3
(eqaul acc acc)	 
 
qed for phi_1 obligation 2
============================================
phi_1 obligation 3
(implies (and (listp l) 
              (natp acc)
			  (not (endp l)) 
			  (eqaul e (first l))
			  (implies (and (listp (rest l)) (natp (+ 1 acc)))
			           (equal (+ (how-many e (rest l)) (+ 1 acc))
					          (how-many-t e (rest l) (+ 1 acc)))))
         (equal (+ (how-many e l) acc)
                (how-many-t e l acc)))
				
c1. listp 1
c2. natp acc
c3. not endp l
c4. e = first l
c5. implies...
.............................................
c6. listp rest l {c1, c3, listp, rest}
c7. (natp (+ 1 acc)) {c2, arithmetic, natp}
c8. (equal (+ (how-many e (rest l)) (+ 1 acc))
		   (how-many-t e (rest l) (+ 1 acc))) {c6, c7, c5, MP}
		
prove 
(equal (+ (how-many e l) acc)
       (how-many-t e l acc))

def. how-many, c4, c3 
(equal (+ (+ 1 (how-many e (rest l))) (+ 1 acc))
       (how-many-t e l acc))

arithmetic
(equal (+ 1 (+ (how-many e (rest l)) (+ 1 acc)))
       (how-many-t e l acc))

c8
(equal (how-many-t e (rest l) (+ 1 acc))
       (how-many-t e l acc))

def. how-many-t, c3, c4
	   
(equal (how-many-t e (rest l) (+ 1 acc))
       (how-many-t e (rest l) (+ 1 acc))
	   
qed for phi_1 proof obligation 3
============================================
phi_1 proof obligation 4
(implies (and (listp l) 
              (natp acc)
			  (not (endp l))
			  (not (equal e (first l)))
			  (implies (and (listp (rest l) (natp acc)))
			           (equal (+ (how-many e (rest l)) acc)
					          (how-many-t e (rest l) acc))))
         (equal (+ (how-many e l) acc)
                (how-many-t e l acc)))
				
c1. listp l
c2. natp acc
c3. not endp l
c4. e != first l
c5. implies...
.....................
c6. listp rest l {c1, c3, listp, rest}
c7. (equal (+ (how-many e (rest l)) acc)
					          (how-many-t e (rest l) acc)) {c6, c2, c5, MP}

prove
(equal (+ (how-many e l) acc)
       (how-many-t e l acc))

def. how-many, c3, c4
(equal (+ (+ 0 (how-many e (rest l))) acc)
       (how-many-t e l acc))

arithmetic
(equal (+ (how-many e (rest l)) acc)
       (how-many-t e l acc))

c7
(equal (how-many-t e (rest l) acc)
       (how-many-t e l acc))
	
def. how-many-t, c4, c3
(equal (how-many-t e (rest l) acc)
       (how-many-t e (rest l) acc)
	   
qed for phi_1 proof obligation 4
       
|#


#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
2. Filtering Data
Consider the following defdata and the function get-integers that uses it:
We're going to selectively filter out all elements in a list that aren't integers
|#
(defdata integerlist (listof integer))

(defunc get-integers (l)
  :input-contract (listp l)
  :output-contract (integerlistp (get-integers l))
  (cond ((endp l)         nil)
        ((integerp (first l)) (cons (first l) (get-integers (rest l))))
        (t                (get-integers (rest l)))))

(check= (get-integers '(b "23" lk ())) ())
(check= (get-integers '(h "ter" -1 aw 9)) '(-1 9))
(check= (get-integers '("qw" "brc" aw (1 2 3) 89 rt -1)) '(89 -1))

;(a) Write the function get-integers-t, which is a tail-recursive version of
;get-integers with an accumulator:

;; get-integers-t: listp x integerlist -> integerlist
;; get-integers-t takes a list and removes all elements
;; in the list that are not integers (this includes sub-lists of integers)
;; acc is an accumulator that collects integers to return.
(defunc get-integers-t (l acc)
  :input-contract (and (listp l) (listp acc))
  :output-contract (integerlistp (get-integers-t l acc))
  (cond ((endp l) acc)
        ((integerp (first l))  (get-integers-t (rest l) (cons (first l) acc))) 
		(t (get-integers-t (rest l) acc))))
  
;; write tests
(check= (get-integers-t '(b "23" lk ()) nil) ())
(check= (get-integers-t '(h "ter" -1 aw 9) nil) '(9 -1))
(check= (get-integers-t '("qw" "brc" aw (1 2 3) 89 rt -1) nil) '(-1 89))
(check= (get-integers-t '(rt -1) '(89)) '(-1 89))
(check= (get-integers-t nil '(-1 89)) '(-1 89))




;; Here is get-integers*, a non-recursive function that calls
;; get-integers-t and suitably initializes l and acc :
(defunc get-integers* (l)
  :input-contract (listp l)
  :output-contract (integerlistp (get-integers* l))
  (rev (get-integers-t l ())))

#|
(c) Identify a lemma that relates get-integers-t to get-integers. Remember
that this is a generalization step, i.e., all arguments to get-integers-t
are variables (no constants). The RHS should include acc.

(implies (and (list l) (listp acc))
         (equal (get-integers-t l acc)
		        (app (rev (get-integers l)) acc)))


(d) Assuming that lemma in (c) is true and using ONLY equational reasoning,
prove the main theorem:

  (listp l) => (get-integers* l) = (get-integers l)

If you need any "lemmas", note them down as "debt", to be proved later. This should
include any theorems that we've already proven (you won't need to prove these but you
still need to list them)

(implies (listp l) 
         (equal (get-integers* l)
		        (get-integers l)))
				
c1. listp l

prove
(equal (get-integers* l)
	   (get-integers l))
	   
def. get-integers*
(equal (rev (get-integers-t l ()))
       (get-integers l))
	   
lemma
(equal (rev (app (rev (get-integers l)) nil))
       (get-integers l))

phi_app_nil (from lecture)
(equal (rev (rev (get-integers l)))
       (get-integers l))
	   
phi_rev_rev (from lecture)
(equal (get-integers l)
       (get-integers l))
	 
qed for part d
	   
(e) Prove the lemma in (c). Use the induction scheme of get-integers-t. In
doing so, you can use the following lemma for free (i.e., you don't need to
prove it).

L3: (integerp e) /\ (integerlistp l) => (integerlistp (cons e l))

Again, if you need another lemma, note it as "dept"
....................

TODO


(f) List here any lemmas that you used in d or e. If any of them are "new", you need
to prove them. (Hint: all lemmas in my solution have appeared in class/notes
before but your proof my differ)
                                                                                                                                                                                

lemma from c
phi_app_nil
phi_rev_rev

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
3.
Consider the following functions, the purpose of which is to compute the
sum-of-digits of a decimal number.  We will do this in 3 parts:
1) Write the tail recursive functions add-digits-t and add-digits*
2) Prove add-digits* = add-digits
3) Write rem-t and rem* and prove rem*=rem

|#
(defthm zero-int-neg (implies (and (natp x) (posp y) (not (integerp (/ x y))))
                              (> x 0)))

(defunc rem (x y)
  :input-contract (and (natp x) (posp y))
  :output-contract (natp (rem x y))
  ;; ignore this line
  :body-contracts-hints (("Goal" :use zero-int-neg))
  (if (integerp (/ x y))
    0
    (+ 1 (rem (- x 1) y))))

(defthm phi_rem_shrink (implies (and (natp x)(posp y)(>= x y)) 
                                (< (rem x y) x)))
(defthm phi_rem_nat (implies (and (natp x)(posp y)(>= x y)) 
                                (natp (- x (rem x y)))))
(defthm phi_rem_div (implies (and (natp x)(posp y)(>= x y)) 
                                (natp (/ (- x (rem x y)) y))))
(defthm phi_rem_dec (implies (and (natp x)(posp y)(>= x y))
                             (< (/ (- x (rem x y)) 10) x)))

;; Don't ask why the add-digits needed program
;; mode. The above theorems should have made it work.
:program
(defunc add-digits (x)
  :input-contract (natp x)
  :output-contract (natp (add-digits x))
  (if (< x 10)
    x
    (let ((rem10 (rem x 10)))
      (+ rem10 (add-digits (/ (- x rem10) 10))))))

;; a)
;; DEFINE add-digits-t and add-digits* (with tests) such that
;; add-digits* calculates the same value for the same
;; inputs as add-digits.
;; For example, we have: (check= (add-digits 12345) 15)
;; (check= (add-digits* 12345) 15) should also pass.
:logic
(defunc add-digits-t (x acc)
  :input-contract (and (natp x) (natp acc))
  :output-contract (natp (add-digits-t x acc))
  (if (< x 10)
      (+ x acc)
	  (let ((rem10 (rem x 10)))
        (add-digits (/ (- x rem10) 10) (+ rem10 acc)))))
	
(check= (add-digits-t 12345 0) 15)
(check= (add-digits-t 1234 5) 15)
(check= (add-digits-t 123 9) 15)
(check= (add-digits-t 12 12) 15)
(check= (add-digits-t 1 14) 15)
(check= (add-digits-t 0 0) 0)
(check= (add-digits-t 4 0) 4)
(check= (add-digits-t 0 4) 4)
(check= (add-digits-t 100 0) 1)
(check= (add-digits-t 101 0) 2)	
	
(defunc add-digits* (x)
  :input-contract (natp x)
  :output-contract (natp (add-digits* x))
  (add-digits-t x 0))
  
(check= (add-digits* 12345) 15)
(check= (add-digits* 0) 0)
(check= (add-digits* 4) 4)
(check= (add-digits* 100) 1)
(check= (add-digits* 101) 2)

#|
(b) Consider this conjecture:

  (natp x) /\ (natp acc) => (add-digits-t x acc) = (add-digits x) + acc

Using the induction scheme add-digits-t gives rise to, prove this conjecture.
Notice that we don't have to worry about order.  Why is that?

arithmetic, addition is commutative

You may use rem10 as an abbreviation for (rem x 10), as done in the
function definition. You can use any lemmas or theorems from
the lectures/homework/notes or from basic arithmetic that you may be using,
but clearly identify them. You may also use the following fact without
proof:

  div-rem :: (natp x) /\ (posp d) => (natp (/ (- x (rem x d)) d))
  
........... 
  
 TODO 
  
  
(c) Prove:

  (natp x) => (add-digits* x) = (add-digits x)

Use pure equational reasoning. You can use any lemmas or
theorems from the lectures/homework/notes but clearly identify 
them if you use them.

c1. natp x

prove
(equal (add-digits* x)
       (add-digits x))
	   
def. add-digits*
(equal (add-digits-t x 0)
       (add-digits x))
	   
lemma from b
(equal (+ 0 (add-digits x))
       (add-digits x))
	  
arithmetic
(equal (add-digits x)
       (add-digits x))

qed for part c
|#
#|
d) Wait.  What about rem??  That's not tail recursive and could lead
to problems. Write function rem* and rem-t such that rem* = rem.
Prove the two functions are equivalent.
Feel free to move the definitions of rem-t and rem* to before add-digits-t
and modify add-digits-t to use them (once you prove rem* = rem of course)
|#

(defunc rem-t (x y acc)
  :input-contract (and (natp x) (posp y) (natp acc))
  :output-contract (natp (rem-t x y acc))
  (if (integerp (/ x y))
    acc
    (rem-t (- x 1) y (+ 1 acc)))

(defunc rem* (x y)
  :input-contract (and (natp x) (posp y))
  :output-contract (natp (rem* x y))
  (rem-t x y 0))
  
#|

lemma for rem-t to rem
(implies (and (natp x) (posp y) (natp acc))
         (equal (rem-t x y acc)
		        (+ (rem x y) acc)))
				
conjecture for rem* = rem
(implies (and (natp x) (posp y))
         (equal (rem* x y)
                (rem x y)))

check lemma useful by proving conjecture
c1. natp x
c2. posp y

prove
(equal (rem* x y)
       (rem x y))

def. rem*
(equal (rem-t x y 0)
       (rem x y))

lemma
(equal (+ (rem x y) 0)
       (rem x y))

arithmetic
(equal (rem x y)
       (rem x y))
qed for rem* = rem
	   
TODO
prove lemma
|#  
#| EXTRA PRACTICE ???
If you want additional practice problems, try writing tail recursive functions
for the following functions and then prove they are equivalent to the original
   - min-l
   - delete
   - merge
In fact, for many functions that aren't already tail recursive, you can write a tail
recursive version and then prove the equivalence. You can generate your own problems.
   
|#










