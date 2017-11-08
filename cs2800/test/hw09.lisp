; **************** BEGIN INITIALIZATION FOR ACL2s B MODE ****************** ;
; (Nothing to see here!  Your actual file is after this initialization code);

#|
Pete Manolios
Fri Jan 27 09:39:00 EST 2012
----------------------------

Made changes for spring 2012.


Pete Manolios
Thu Jan 27 18:53:33 EST 2011
----------------------------

The Beginner level is the next level after Bare Bones level.

|#

; Put CCG book first in order, since it seems this results in faster loading of this mode.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading the CCG book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "ccg/ccg" :uncertified-okp nil :dir :acl2s-modes :ttags ((:ccg)) :load-compiled-file nil);v4.0 change

;Common base theory for all modes.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s base theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "base-theory" :dir :acl2s-modes)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "custom" :dir :acl2s-modes :uncertified-okp nil :ttags :all)

;Settings common to all ACL2s modes
(acl2s-common-settings)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading trace-star and evalable-ld-printing books.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "trace-star" :uncertified-okp nil :dir :acl2s-modes :ttags ((:acl2s-interaction)) :load-compiled-file nil)
(include-book "hacking/evalable-ld-printing" :uncertified-okp nil :dir :system :ttags ((:evalable-ld-printing)) :load-compiled-file nil)

;theory for beginner mode
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s beginner theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "beginner-theory" :dir :acl2s-modes :ttags :all)


#+acl2s-startup (er-progn (assign fmt-error-msg "Problem setting up ACL2s Beginner mode.") (value :invisible))
;Settings specific to ACL2s Beginner mode.
(acl2s-beginner-settings)

; why why why why 
(acl2::xdoc acl2s::defunc) ; almost 3 seconds

(cw "~@0Beginner mode loaded.~%~@1"
    #+acl2s-startup "${NoMoReSnIp}$~%" #-acl2s-startup ""
    #+acl2s-startup "${SnIpMeHeRe}$~%" #-acl2s-startup "")


(acl2::in-package "ACL2S B")

; ***************** END INITIALIZATION FOR ACL2s B MODE ******************* ;
;$ACL2s-SMode$;Beginner
#|
CS 2800 Homework 9 - Fall 2017


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

 * Submit the homework file (this file) on Blackboard.  Do not rename
   this file.  There will be a 10 point penalty for this.

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
For this homework you may want to use ACL2s to help you.

Technical instructions:

- open this file in ACL2s as hw09.lisp

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

- when done, save your file and submit it as hw09.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file!

|#
#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Measure Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
A measure function m for function f satisfies the
following conditions (as discussed in class and in lectures):
1. m has the same arguments and the same input contract as f.
2. m's output contract is (natp (m ...))
3. m is admissible.
4. On every recursive call of f, given the input contract and
   the conditions that lead to that call, m applied to the arguments in
   the call is less than m applied to the original inputs.

Thus when you are asked to prove termination using a measure function, you
need to
a) Write the function (if not provided) which satisfies points 1-3
b) Write proof obligations corresponding to recursive calls in f
c) Prove the proof obligations using equational reasoning or using an approach
   we specify
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Induction Proofs

We will be looking at inductive proofs (in various forms) for the remainder
of the term. If you want an example of an inductive proof, look at our proof
for Gauss' Trick.
phi_sumn: (implies (natp n) (equal (sumn n)(fsumn n))
where sumn is the slow way to sum numbers from 0 to n while fsumn is
n * (n+1) / 2.

We broke that proof into 3 parts

phi_sumn1: ~(natp n) => phi_sumn
phi_sumn2: (natp n) /\ (equal n 0) => phi_sumn
phi_sumn3: (natp n) /\ (not (equal n 0)) /\ phi_sumn|((n (- n 1))) => phi_sumn

Notice that phi_sumn1 is the "bad data" or ~IC case which we ignored when doing
equational reasoning.

You'll also notice that since the parts imply phi_sumn
you should swap in the ENTIRE phi_sumn conjecture and use
exportation to get your context. Exportation means we just get
a sequence of ands which imply (sumn n) = (fsumn n) for each of the
conjectures. For example, phi_sumn2 is
(natp n) /\ (equal n 0) => ((natp n) => (equal (sumn n)(fsumn n)))
or
(natp n) /\ (equal n 0) /\ (natp n) => (equal (sumn n)(fsumn n)))

I will use the term proof obligations to refer to conjectures used to prove a
particular conjecture (eg "=> phi_sumn") while the induction scheme can be applied
to any inductive proof (eg "=> phi" where phi is not specified).

For each induction scheme conjecture we add the conditions that
lead to a particular branch. We also assume that the
conjecture holds for the next recursive call when a recursive call (or calls) occurs.
Thus we substitutethe arguments of the recursive call into the original conjecture.

For inductive proofs you will always be expected to write proof obligations
or induction schemes, clearly label where these came from, and then prove
the various parts.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

;;==========================================
; Section 1: Induction schemes
;;==========================================


#|

Below you are given the proof obligations generated by
induction schemes. Your job is to define functions, using defunc,
that give rise to these induction schemes. phi|(...) denotes phi
under substitution ... . Make sure that ACL2s accepts your
function definitions.

For these functions (f1-f5) you do not need to provide
tests (i.e., no check= forms are required). It is also
a good idea to make these functions as simple as possible.

|#

#|
f1)
1. (not (integerp x)) => phi
2. (and (integerp x) (equal x 0)) => phi
3. (and (integerp x) (not (equal x 0))(> x 0))) phi|((x (- x 1))))  => phi
4. (and (integerp x) (not (equal x 0))(not (> x 0)) phi|((x (+ x 1))))  => phi

|#

(defunc f1  (x)
  :input-contract (integerp x)
  :output-contract (booleanp (f1 x))
  (cond ((equal x 0) t)
        ((> x 0) (f1 (- x 1)))
        (t (f1 (+ x 1)))))

#|
NOTE: The induction scheme below has been slightly simplified to avoid
the expression being too unruly (eg for obligation 3 you would see
(not (equal x 1)))
f2)
1. (not (posp x)) => phi
2. (and (posp x) (equal x 1)) => phi
3. (and (posp x) (equal x 2)) => phi
4. (and (posp x) (equal x 3)) => phi
5. (and (posp x) (not (equal x 1)) (not (equal x 2))
(not (equal x 3)) phi|((x (- x 3))))  => phi

|#

(defunc f2 (x)
  :input-contract (posp x)
  :output-contract (booleanp (f2 x))
  (cond
   ((equal x 1) t)
   ((equal x 2) nil)
   ((equal x 3) nil)
   (t (f2 (- x 3)))))

#|
f3)
1. (not (and (listp x)(natp y))) => phi
2. (and (listp x)(natp y)(endp x)(equal y 0)) => phi
3. (and (listp x)(natp y)(not (and (endp x)(equal y 0)))
        (endp x) phi|((y (- y 1)))) => phi
4. (and (listp x)(natp y)(not (and (endp x)(equal y 0)))(not (endp x))
        (equal y 0) phi|((x (rest x)))) => phi
5. (and (listp x)(natp y)(not (and (endp x)(equal y 0)))(not (endp x))
        (not (equal y 0))  phi|((x (rest x))(y (- y 1))) )
    => phi

|#

(defunc f3 (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (booleanp (f3 x y))
  (cond
   ((and (endp x) (equal y 0)) t)
   ((endp x) (f3 x (- y 1)))
   ((equal y 0) (f3 (rest x) y))
   (t (f3 (rest x) (- y 1)))))

;; The following functions are not trivial to admit into ACL2s in logic
;; mode.  For f4 and f5, just convince yourself that the terminate and IC=>OC
:program


#|
f4)
1. (not (integerp x)) => phi
2. (and (integerp x) (< x -1)) => phi
4. (and (integerp x) (not (< x -1))
        phi|((x (- x 1))) phi|((x (- x 2)))  => phi

|#
(defunc f4 (x)
  :input-contract (integerp x)
  :output-contract (booleanp (f4 x))
  (if (< x -1) t
    (and (f4 (- x 1)) (f4 (- x 2)))))

#|
f5)
1. (not (and (listp x) (integerp y))) => phi
2. (and (listp x) (integerp y) (endp x) (equal y -1)) => phi
3. (and (listp x) (integerp y) (not (and (endp x) (equal y -1)))
        (endp x)(< y -1) phi|((y (+ y 1)))) => phi
4. (and (listp x) (integerp y) (not (and (endp x) (equal y -1)))
        (not (and (endp x)(< y -1)))
        (endp x) (phi|((x (cons 1 x)) (y (- y 1))))) => phi
5. (and (listp x) (integerp y) (not (and (endp x) (equal y -1)))
        (not (and (endp x)(< y -1)))
        (not (endp x)) (phi|((x (rest x))))) => phi

Hint: phi|((a (rest a)) (b b)) is the same as
      phi|((a (rest a))).  You can leave off variable parameters
      that don't change.
|#

(defunc f5 (x y)
  :input-contract (and (listp x) (integerp y))
  :output-contract (booleanp (f5 x y))
  (cond
   ((and (endp x) (equal y -1)) t)
   ((and (endp x) (< y -1)) (f5 x (+ y 1)))
   ((endp x) (f5 (cons 1 x) (- y 1)))
   (t (f5 (rest x) y))))
#|
==========================================
SECTION 2: Pre-defined Functions and Warm Up

We start with some familiar definitions just in case they
are useful. You will be asked to
define functions later on. Make sure to use defunc.
==========================================
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

(defunc rev (a)
  :input-contract (listp a)
  :output-contract (listp (rev a))
  (if (endp a)
      nil
    (app (rev (rest a)) (list (first a)))))

(defunc len (a)
  :input-contract t
  :output-contract (natp (len a))
  (if (atom a)
      0
    (+ 1 (len (rest a)))))

(defunc in (a X)
  :input-contract (listp x)
  :output-contract (booleanp (in a X))
  (if (endp x)
      nil
    (or (equal a (first X))
        (in a (rest X)))))

|#

:logic
;; Assume by "Def of lor" that each element is a rational
;; and a lor is (cons rational lor) | nil
(defdata lor (listof rational))

(defthm phi_applen (implies (and (listp l1) (listp l2))
                            (equal (len (app l1 l2))
                                   (+ (len l1)(len l2)))))
#|
PROVE
Let's do a warm-up proof

Prove phi_applen: (implies (and (listp l1) (listp l2))
                           (equal (len (app l1 l2))
                                  (+ (len l1)(len l2))))
Make sure you clearly identify the induction scheme you are
using and what function the IS is from.

phi:
(implies (and (listp l1) (listp l2))
         (equal (len (app l1 l2))
                (+ (len l1)(len l2))))

induction scheme for app:
1. (not (and (listp l1) (listp l2))) => phi
2. (and (listp l1) (listp l2) (endp l1)) => phi
3. (and (listp l1) (listp l2) (not (endp l1)) (phi|(l1 (rest l1)))) => phi

proof obligation 1: (by Induction Scheme + Exportation)
(implies (and (not (and (listp l1) (listp l2)))
              (and (listp l1) (listp l2)))
         (equal (len (app l1 l2)) (+ (len l1)(len l2))))
{PL} ;; the antecedent is false because contract checking cancels out, and when LHS of implies is false then it's true
t
qed

proof obligation 2: (by Induction Scheme + Exportation)
(implies (and (listp l1) (listp l2) (endp l1))
         (equal (len (app l1 l2))
                (+ (len l1)(len l2))))

contexts:
c1. listp l1
c2. listp l2
c3. endp l1

prove:
(equal (len (app l1 l2))
       (+ (len l1)(len l2)))

{def. app, c3, if-axioms}
(equal (len l2))
       (+ (len l1)(len l2)))

{def. len, c3, if-axioms}
(equal (len l2))
       (+ 0 (len l2)))

{arithmetic}
(equal (len l2) (len l2))
qed

proof obligation 3: (by Induction Scheme + Exportation)
(implies (and (listp l1)
              (listp l2)
              (not (endp l1))
              (implies (and (listp l1) (listp l2) (not (endp l1)))
                       (equal (len (app (rest l1) l2))
                              (+ (len (rest l1)) (len l2)))))
         (equal (len (app l1 l2))
                (+ (len l1)(len l2))))

contexts:
c1. listp l1
c2. listp l2
c3. not endp l1
c4. (implies (and (listp l1) (listp l2) (not (endp l1)))
                       (equal (len (app (rest l1) l2))
                              (+ (len (rest l1)) (len l2)))))
.....................
c5. (equal (len (app (rest l1) l2))
           (+ (len (rest l1)) (len l2))))) {c1, c2, c3, c4, MP}

prove:
(equal (len (app l1 l2))
       (+ (len l1)(len l2)))

{def. app, c3, if-axioms}
(equal (len (cons (first l1) (app (rest l1) l2))))
       (+ (len l1)(len l2)))

{def. len, cons axioms, first-rest, def. endp} ;; plug in function body for len on a non-empty list to get rid of (first l1)
(equal (+ 1 (len (app (rest l1) l2)))
       (+ (len l1)(len l2)))

{c5} ;; now that (first l1) is gone we can use our inductive hypothesis
(equal (+ 1 (+ (len (rest l1)) (len l2)))
       (+ (len l1)(len l2)))

{def. len, c1} ;; make RHS look like LHS using function body of len for a non-empty list
(equal (+ 1 (+ (len (rest l1)) (len l2)))
       (+ 1 (+ (len (rest l1)) (len l2)))
qed


|#

;; Useful for half-idx
(defthm phi_div2odd (implies (and (natp n)(not (natp (/ n 2))))
                             (natp (/ (- n 1) 2))))
#|

|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; orderedp: lor -> boolean
;; (orderedp l) takes a list of rationals
;; and returns true if and only if the elements
;; are in non-decreasing order (ie they are ordered)
(defunc orderedp (l)
  :input-contract (lorp l)
  :output-contract (booleanp (orderedp l))
  (or (endp l)
      (endp (rest l))
      (and (<= (first l) (second l))
           (orderedp (rest l)))))

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
;; perm: List x List -> List
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
      (endp l2)
      (and (in (first l1) l2)
           (perm (rest l1) (del (first l1) l2))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; sortedp: LOR x LOR -> Boolean
;; (sortedp origL sortL) takes the original list
;; and the theoretically sorted list (sortL)
;; and determines if sortL is a sorteding
;; of the original list.
(defunc sortedp (origL sortL )
  :input-contract (and (lorp origL)(lorp sortL))
  :output-contract (booleanp (sortedp origL sortL))
  (and (perm origL sortL)(orderedp sortL)))



;;============================================
;; SECTION 3: TEMPORARY DETOUR
;; Below is the function isort which is
;; the insertion sort algorithm. This
;; works by removing the first element from
;; the original list and inserting it in the
;; correct position in the destination (sorted)
;; list. This is useful because  you will show
;; isort = msort in this assignment
;; You are not proving anything here BUT you
;; should still understand what we are proving
;; and how this could be useful for msort later.
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

;; Now a bunch of useful theorems to help ACL2s reason
;; about the functions

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


;;==========================================
;; SECTION 4: Merge Sort
;; You will now write various functions involved
;; in the merge sort algorithm.
;; You will also have to prove  several conjectures along the way.
;; PROVE the indicated conjectures (induction will
;; probably be needed somewhere). The conjecture  will be provided
;; in the comment. We will also have ACL2s prove most of these
;; conjectures and you can't let yourself be outsmarted by a
;; machine can you?  That's how Skynet got started in 1997.
;;
;; Make sure you clearly identify your induction scheme and what
;; function it comes from.
;;
;; Please also note that since you are writing the functions before
;; you do the proofs, your implementation may change the proof. Some
;; implementations are easier to prove than others.  Some induction schemes
;; are also easier to use than others. Thus don't worry as much about code
;; efficiency as code cleanliness.
;; You will probably need a lemma (helper theorem) along the way so don't
;; be afraid if you think you need to do another proof first. In fact, my
;; solutions have far more than one.
;;==========================================

#|

*** If you get stuck with your proofs, consider revising your code
If everyone is getting stuck, I'm willing to provide function bodies,
but I would like to wait and see if problems arise ***

*** I am also providing a lot less "hand holding" compared
to previous terms but instead I will be hinting
at how you can do the final proof using previous proofs and
theorems accepted by ACL2s. Please keep in mind that previous work
may be helpful later.***
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; split-front-hlp: lor x nat -> lor
;; (split-front-hlp l idx) takes a list of rationals
;; and an idx and returns
;; elements of l from 0 to idx (excluding idx).
;; See the check= tests below for examples
;; This function is exclusively called by split-list-front
(defunc split-front-hlp (l idx)
  :input-contract (and (lorp l)(natp idx))
  :output-contract (lorp (split-front-hlp l idx))
  (if (or (endp l)(equal idx 0))
    nil
    (cons (first l)(split-front-hlp (rest l) (- idx 1)))))

;; PROOF:
;; Measure Function for split-front-help
;; Let's start with an easy proof. Write
;; a measure function (m-split) for split-front-help and
;; prove split-front-hlp terminates using the "short hand"
;; proof format A => (m x) = B > C = (m x') discussed in class
(defunc m-split (l idx)
  :input-contract (and (lorp l)(natp idx))
  :output-contract (natp (m-split l idx))
  (if (< (len l) idx) 
    (len l)
    idx)) ;; the smaller of the two
#|
.................. (proof goes here)
(and (lorp l) (natp idx)) => (m-split l idx) = B > C = (m-split (rest l) (- idx 1))

B =   (if (< (len l) idx) 
    (len l)
    idx))
C =   (if (< (len (rest l)) (- idx 1)) 
    (len (rest l))
    ( - idx 1)))

Case 1: the list is smaller than the index
contexts:
c1. (< (len l) idx)
c2. lorp l
c3. natp idx

prove:
(>
  (if (< (len l) idx) 
      (len l)
      idx))
  (if (< (len (rest l)) (- idx 1)) 
    (len (rest l))
    ( - idx 1))))

{c1, if-axioms}
(>
      (len l)
  (if (< (len (rest l)) (- idx 1)) 
    (len (rest l))
    ( - idx 1))))

{decreasing len axiom, arithmetic, c1} ;; we're decreasing the length and the idx by 1 each, so < is preserved
(> (len l) (len (rest l)))

{decreasing len axiom}
qed

Case 2: the list is not smaller
contexts:
c1. (not ((< (len l) idx))
c2. lorp l
c3. natp idx

prove:
(>
  (if (< (len l) idx) 
      (len l)
      idx))
  (if (< (len (rest l)) (- idx 1)) 
    (len (rest l))
    ( - idx 1))))
    
{c1, if-axioms}
(> (idx) 
 (if (< (len (rest l)) (- idx 1)) 
    (len (rest l))
    ( - idx 1))))

{decreasing len, artihmetic, c1}
(> (idx) (- idx 1))

{arithmetic}
qed


|#



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; split-back-hlp: lor x nat -> lor
;; (split-back-hlp l idx) takes a list of rationals
;; and an index idx and returns
;; elements of l from idx to the
;; last element of l.
;; See the check= tests below for examples
;; This function is exclusively called by split-list-back
(defunc split-back-hlp (l idx)
  :input-contract (and (lorp l)(natp idx))
  :output-contract (lorp (split-back-hlp l idx))
  (if (or (endp l)(equal idx 0))
    l
    (split-back-hlp (rest l) (- idx 1))))

(defthm phi_split_app (implies (and (lorp l)(natp idx))
                               (equal (app (split-front-hlp l idx)(split-back-hlp l idx)) l)))


(defthm phi_sfh_len (implies (and (lorp l)(consp l)(posp n))
                             (> (len (split-front-hlp l n)) 0)))
(test? (implies (lorp l) (equal (split-back-hlp l 0) l)))
(test? (implies (lorp l) (equal (split-front-hlp l 0) nil)))
(test? (implies (lorp l) (equal (split-front-hlp l (len l)) l)))
(test? (implies (lorp l) (equal (split-back-hlp l (len l)) nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; half-idx: nat -> nat
;; (half-idx n) takes a natural number n
;; and calculates the ceiling (round up) of n/2.
;; If breaking apart a list of length 5,
;; n of 5 should return 3 since elements 0, 1, 2 should be
;; in the first half and 3, 4 should be the second half
;; For n = 6, 3 should be returned.
(defunc half-idx (n)
  :input-contract (natp n)
  :output-contract (natp (half-idx n))
  (if (natp (/ n 2))
            (/ n 2)
            (/ (+ n 1) 2)))
  
(check= (half-idx 5) 3)
(check= (half-idx 6) 3)
(check= (half-idx 17) 9)
(check= (half-idx 0) 0)
(check= (half-idx 1) 1)
(check= (half-idx 2) 1)
(check= (half-idx 3) 2)


;; GIVEN THEOREMS: useful for ACL2s to prove things
;; You can use these in your proofs if you want.
;; If the theorems don't go through, try tweaking your half-idx solution.
(defthm phi_halfidx (implies (and (natp n)(> n 1))
                             (< (half-idx n) n)))

(defthm phi_splitlen (implies (and (lorp l)(consp l)(consp (rest l)))
                              (< (half-idx (len l)) (len l))))
(defthm phi_splitlen2 (implies (and (lorp l)(consp l)(consp (rest l)))
                              (> (half-idx (len l)) 0)))
(defthm phi_halfidx2 (implies (and (natp n)(> n 1))
                              (> (half-idx n) 0)))

(defthm phi_splitSize (implies (and (lorp l)(consp l)(consp (rest l))
                                    (natp idx)(> idx 0)(< idx (len l)))
                               (< (len (split-front-hlp l idx)) (len l))))

;; NOTE: our tests are below in the "more tests" and "most tests sections"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; split-list-front: LOR (non-empty) -> LOR
;; (split-list-front l) takes a list
;; of rationals l and returns the first half
;; of the elements.  For odd length lists,
;; include the middle element.
(defunc split-list-front (l)
  :input-contract (and (lorp l) (not (endp l)))
  :output-contract (lorp (split-list-front l))
  (split-front-hlp l (half-idx (len l))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; split-list-back: LOR (non-empty) -> LOR
;; (split-list-back l) takes a list
;; of rationals l and returns the last half
;; of the elements.  For odd length lists do
;; NOT include the middle element.
(defunc split-list-back (l)
  :input-contract (and (lorp l) (not (endp l)))
  :output-contract (lorp (split-list-back l))
  (split-back-hlp l (half-idx (len l))))

;; You will prove this soon enough. Let's show ACL2s can do it.
(defthm phi_split_app2 (implies (and (lorp l)(consp l))
                                (equal (app (split-list-front l)(split-list-back l)) l)))

;; Basic tests for split-list-front and split-list-back
;; Add additional tests
(test? (implies (and (lorp l)(consp l))
                (equal (app (split-list-front l)
                            (split-list-back l))
                       l)))#|ACL2s-ToDo-Line|#


#|
PROVE phi_app-split:
(lorp l)/\(consp l) => ((app (split-list-front l)
                       (split-list-back l)) = l)
You will need a LEMMA since you need to examine split-front-hlp and split-back-hlp.
Start the proof and see if you can create a lemma.  You should generalize the approach
and thus have a second variable.
Please do NOT use any of the given theorems above unless you prove them first
....otherwise you could simply prove this by saying "phi_split_app2".

induction scheme for listp:
1. (not (consp l) => phi
2. (and (consp l) (phi|(l (rest l)))) => phi


proof obligation 1.
(implies (and (not (consp l)) (lorp l) (consp l) ............
antecedent is false because of (and (not consp) (consp)
qed

proof obligation 2.
using induction scheme + exportation:

(implies (and (consp l)
              (lorp l)
              (implies (and (lorp (rest l))(consp (rest l)))
                       (equal (app (split-list-front (rest l)) (split-list-back (rest l)))
                              (rest l)))
         (equal (app (split-list-front l)
                     (split-list-back l))
                 l)
                       
                       
c1. (lorp l)
c2. (consp l)
c3. ((lorp (rest l)) /\ (consp (rest l)) => ((app (split-list-front (rest l)) (split-list-back (rest l))) = (rest l)))

well we can't use c3 yet because we don't know (consp (rest l)). 
so...
can we prove phi when rest l is endp and when rest l is consp?

c4. (consp (rest l))
..........................
c5. ((app (split-list-front (rest l)) (split-list-back (rest l))) = (rest l)))


|#


(check= (split-list-front (list 0 1)) '(0))
(check= (split-list-front (list 0 1 2 3 4)) '(0 1 2))
;; More Tests
(check= (split-list-front (list 1 1)) (list 1))
(check= (split-list-front (list 1)) (list 1))
(check= (split-list-front (list 1 2 3 4)) (list 1 2))
(check= (split-list-front (list 1 2 3 4 5)) (list 1 2 3))

(check= (split-list-back (list 0 1)) '(1))
(check= (split-list-back (list 0 1 2 3 4)) '(3 4))
;; Most Tests
(check= (split-list-back (list 1 1)) (list 1))
(check= (split-list-back (list 1)) (list))
(check= (split-list-back (list 1 2 3 4)) (list 3 4))
(check= (split-list-back (list 1 2 3 4 5)) (list 4 5))


#|
PROVE the following conjecture:
phi_split-len: (implies (and (lorp l)(consp l))
                        (equal (+ (len (split-list-front l))
                                  (len (split-list-back l)))
                               (len l)))

Do you need induction?


the length of the first half plus the length of the second half of a non-empty list equals the length of the list

contexts:
c1. lorp l
c2. consp l

prove:
(equal (+ (len (split-list-front l))
          (len (split-list-back l)))
       (len l)))
       
{def. split-list-front, def. split-list-back}
(equal (+ (len (split-front-hlp l (half-idx (len l))))
          (len (split-back-hlp l (half-idx (len l)))))
        (len l))
        
{def. split-front-hlp}
(equal (+ (len (if (or (endp l)(equal (half-idx (len l)) 0))
                   nil
                   (cons (first l)(split-front-hlp (rest l) (- (half-idx (len l)) 1)))))
          (len (split-back-hlp l (half-idx (len l)))))
        (len l))     
        
{c1, phi_splitlen2, MP, if-axioms}
(equal (+ (len (cons (first l)(split-front-hlp (rest l) (- (half-idx (len l)) 1)))))
          (len (split-back-hlp l (half-idx (len l)))))
        (len l))   
               
{def. split-back-hlp}
(equal (+ (len (cons (first l)(split-front-hlp (rest l) (- (half-idx (len l)) 1)))))
          (len (if (or (endp l)(equal (half-idx (len l)) 0))
                    l
                  (split-back-hlp (rest l) (- (half-idx (len l)) 1))))
        (len l))   
       
{c1, phi_splitlen2, MP, if-axioms}
(equal (+ (len (cons (first l)(split-front-hlp (rest l) (- (half-idx (len l)) 1)))))
          (len (split-back-hlp (rest l) (- (half-idx (len l)) 1))))
        (len l))   
        
looks like a job for induction
        
induction scheme for listp
1. (not (consp l)) => phi
2. (and (consp l) (phi | (l (rest l)))) => phi 


proof obligation 1: (after Exportation)
(implies (and (not (consp l)) (consp l) ...
{pl}
qed
;; antecedent is false because phi has consp l
        

proof obligation 2: the real deal
(implies 
       (and (lorp l) 
            (consp l)
            (implies (and (lorp (rest l))(consp (rest l)))
                        (equal (+ (len (cons (first (rest l))(split-front-hlp (rest (rest l)) (- (half-idx (len (rest l))) 1)))))
                                  (len (split-back-hlp (rest (rest l)) (- (half-idx (len (rest l))) 1))))
                               (len (rest l))))
       (equal (+ (len (cons (first l)(split-front-hlp (rest l) (- (half-idx (len l)) 1)))))
                 (len (split-back-hlp (rest l) (- (half-idx (len l)) 1))))
              (len l))
contexts:
c1. lorp l
c2. consp l
c3. (implies (and (lorp (rest l))(consp (rest l)))
                        (equal (+ (len (cons (first (rest l))(split-front-hlp (rest (rest l)) (- (half-idx (len (rest l))) 1)))))
                                  (len (split-back-hlp (rest (rest l)) (- (half-idx (len (rest l))) 1))))
                               (len (rest l))))
..........................
c4. (equal (+ (len (cons (first (rest l))(split-front-hlp (rest (rest l)) (- (half-idx (len (rest l))) 1)))))
              (len (split-back-hlp (rest (rest l)) (- (half-idx (len (rest l))) 1))))
           (len (rest l)))) {MP, c1, c2, c3}

prove:

(equal (+ (len (cons (first l)(split-front-hlp (rest l) (- (half-idx (len l)) 1)))))
          (len (split-back-hlp (rest l) (- (half-idx (len l)) 1))))
       (len l))
       
{c4, def. len, cons axioms}
(equal (1 + (len (rest l))
       (len l))
qed

       
|#

;; In the interest of time and your own sanity, you can use program mode for msort
;; and merge.  However, let's prove that merge and msort actually terminate.
;; You can assume IC=>OC in both cases and  you can treat them as admissible functions
;; in logic mode (with all that this entails) for your proofs.

:program

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TO DEFINE:
;; merge: lor x lor -> lor
;; (merge l1 l2) takes two lists of rationals l1 and l2
;; that are PRESUMED to be already in sorted order and
;; generates a new list with all elements from l1 and l2
;; still in order.  We do this by comparing the first of
;; l1 and l2 and cons-ing the smallest of the two
;; onto the results of a recursive call with the
;; rest of one list and the other list.
;; Thus the lists can be merged in O(n) time.
(defunc merge (l1 l2)
  :input-contract (and (lorp l1) (lorp l2))
  :output-contract (lorp (merge l1 l2))
  (cond ((endp l1) l2)
        ((endp l2) l1)
        ((< (first l1) (first l2)) (cons (first l1) (merge (rest l1) l2)))
        (t (cons (first l2) (merge l1 (rest l2))))))


;; Add  your own tests.
(check= (merge (list 0 1) (list 0 1)) (list 0 0 1 1))
(check= (merge (list) (list)) (list))
(check= (merge (list 1) (list)) (list 1))
(check= (merge (list) (list 2)) (list 2))
(check= (merge (list -1 5 10 ) (list 2 4 100)) (list -1 2 4 5 10 100))
(check= (merge (list -1 5 10 ) (list 100)) (list -1 5 10 100))


;; Prove merge terminates by giving a measure function m-merge and proving
;; that m-merge decreases with each recursive call to merge.
(defunc m-merge (l1 l2)
   :input-contract (and (lorp l1) (lorp l2))
   :output-contract (natp (m-merge l1 l2))
   (+ (len l1) (len l2)))


#|
..................
merge terminates if the recursive call is less than the original call for the measure function
for each recursive call
proof obligation 1:
(and (lorp l1) (lorp l2) (not endp l1) (not (endp l2)) (< (first l1) (first l2))) => (m-merge l1 l2) > (m-merge (rest l1) l2)

c1. (lorp l1)
c2. (lorp l2)
c3. (not (endp l1))
c4. (< (first l1) (first l2))
....

Prove
(m-merge l1 l2) > (m-merge (rest l1) l2)
{def m-merge} 
(> (+ (len l1) (len l2))) (+ (len (rest l1)) (len l2)))
{Arithmetic}
(> (len l1) (len (rest l1)))
{Decreasing len axiom}

QED


proof obligation 2: 
(and (lorp l1) (lorp l2) (not endp l1) (not endp l2) (not (< (first l1) (first l2)))) => (m-merge l1 l2) = A > B (m-merge l1 (rest l2))

c1. (lorp l1)
c2. (lorp l2)
c3. (not (endp l1))
c4. (not (< (first l1) (first l2)))
....

Prove
(m-merge l1 l2) > (m-merge l1 (rest l2))
{def m-merge} 
(> (+ (len l1) (len l2))) (+ (len l1) (len (rest l2))))
{Arithmetic}
(> (len l2) (len (rest l2)))
{Decreasing len axiom}

QED

|#

;; ADD TESTS BELOW
(check= (m-merge (list 0 1) (list 0 1)) 4)
(check= (m-merge (list) (list)) 0)
(check= (m-merge (list 1) (list)) 1)
(check= (m-merge (list) (list 2)) 1)
(check= (m-merge (list -1 5 10 ) (list 2 4 100)) 6)
(check= (m-merge (list -1 5 10 ) (list 100)) 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; msort: lor -> lor
;; (msort l) takes any list of rationals and sorts
;; it using merge sort. A sorted list is returned
;; Merge sort works by splitting l in (approximately) half
;; calling msort on each half and merging the sorted
;; lists.
(defunc msort (l)
  :input-contract (lorp l)
  :output-contract (lorp (msort l))
  (if (or (endp l)(endp (rest l)))
    l
    (merge (msort (split-list-front l))
           (msort (split-list-back l)))))

;; ADD TESTS BELOW
(check= (msort (list)) (list))
(check= (msort (list -1 5 -100 10)) (list -100 -1 5 10))
(test? (implies (and (rationalp x) (rationalp y) (> x y))
                (equal (msort (list x y))
                            (list y x))))

;; measure function for msort
(defuc m-msort (l)
    :input-contract (lorp l)
    :output-contract (natp (m-msort l))
    (len l))

(check= (m-msort (list)) 0)
(check= (m-msort (list 2 1 4)) 3)


;; Prove msort terminates. ACL2s can't easily do this so
;; now's your chance to show you're smarter than a laptop!
;; (Don't worry; you are, whether you can solve the problem or not)
;; Write a measure function for msort and prove that it terminates
;; You will need a lemma (helper proof)......in fact you may need several
;; but they will not always require induction.

;; What are the proof
;; obligations? Why did we look at proofs involving split-list-front (such as phi_splitlen)?
;;.......These are rhetorical questions. You do not have to provide an answer.
#|


msort terminates if the recursive call is less than the original call for the measure function
for each recursive call
proof obligation 1:
(and (lorp l) (not (or (endp l)(endp (rest l))))) => (m-msort l) > (m-msort (split-list-front l))

c1. (lorp l1)
c2. (not (or (endp l)(endp (rest l)))))
....

Prove
(m-msort l) > (m-msort (split-list-front l)
{def m-msort} 

(> (len l) (len (split-list-front l)))
{def split-list-front} 
(> (len l) (len (split-front-hlp l (half-idx (len l)))))
{phi_splitSize, phi_splitlen2, phi_halfidx, phi_splitlen, c2, MP}
qed



proof obligation 2:
(and (lorp l) (not (or (endp l)(endp (rest l))))) => (m-msort l) > (m-msort (split-list-back l))

c1. (lorp l1)
c2. (not (or (endp l)(endp (rest l)))))
....

Prove
(m-msort l) > (m-msort (split-list-back l)
{def m-msort} 

(> (len l) (len (split-list-back l)))
{def split-list-back} 
(> (len l) (len (split-back-hlp l (half-idx (len l)))))
{phi_splitSize, phi_splitlen2, phi_halfidx, phi_splitlen, c2, MP}
qed

|#
#|
IMPORTANT Free theorem you can use in the next part
(I hope to prove this in HW10)
phi_merge_isort :
       (implies (and (lorp l1)(lorp l2))
                (equal (merge (isort l1)(isort l2))
                       (isort (app l1 l2)))))
|#

(test? (implies (lorp l)(sortedp l (msort l))))
;; NOW: prove the conjecture tested by the line above
;; but let's hopefully make things easier.  Notice that if msort is sorted
;; then it should be equivalent to isort (which we already proved was sorted
;; in part 2). Thus prove the following conjecture:
;; phi_msort_isort: (lorp l) => ((msort l) = (isort l))
;;
;; Think about how the msort recurses.  What kind of induction scheme
;; will  you need? Remember, that induction doesn't just work on (rest l)
;; or (- n 1). Any (theoretically) admissible function generates an induction scheme
;;
;; You may use any already proven theorems in  your proof.
;;
;; 5 pt BONUS: Get ALC2s to prove this for you as well (don't spend time doing
;; this for the points.  It may cost you lots of time and you'll only earn
;; a couple points).  This will require getting msort to be admitted in logic mode
;;
#|
..............
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Section 5: Comparing Sorting Algorithms
;; Now let's do something familiar. Let's race the two
;; sorting algorithms to see which one is faster.
;; ACL2s does not necessarily scale well with large lists
;; or access list elements as efficiently as one can access
;; an array.  Thus I didn't expect massive savings like we see
;; with an imperative language but let's see the difference just
;; the same.  There was a huge improvement between selection sort
;; and merge sort in previous terms.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:logic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; gen-lor: nat x nat x pos x lor -> lor
;; (gen-lor n i denom acc) takes a list size
;; n, an increment value i, a divisor value denom and
;; returns a "random" list of n rationals. The
;; variable acc is an accumulator to speed up the
;; function.
;; gen-lor can be used to test your sorting algorithm
;; speed for non-trivial lengths
(defunc gen-lor (n i denom acc)
  :input-contract (and (natp n)(integerp i)(lorp acc)
                       (posp denom)(< i denom))
  :output-contract (lorp (gen-lor n i denom acc))
  (if (equal n 0)
    (cons i acc)
    (gen-lor (- n 1) i denom
             (cons (/ (+ n i) denom) acc))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; gen-lor*: nat -> lor
;; (gen-lor n) generates a list of rationals length
;; n with "semi-random" values inside.
;; This is a wrapper function for gen-lor to extract
;; away complexity for generating a list. Modify
;; the numbers all you want.
(defunc gen-lor* (n)
  :input-contract (natp n)
  :output-contract (lorp (gen-lor* n))
  (gen-lor n -4 8 nil))

(check= (msort (gen-lor* 40))(isort (gen-lor* 40)))
(check= (msort (gen-lor* 10))(isort (gen-lor* 10)))
(check= (msort (gen-lor* 400))(isort (gen-lor* 400)))
(test? (implies (lorp l) (equal (msort l)(isort l))))

;; Now let's see the speed differences:
(defconst *med-list* (gen-lor* 10000))
(defconst *large-list* (gen-lor* 40000))

(acl2::er-progn
   (acl2::time$ (acl2::value-triple (msort *med-list*)))
   (acl2::value-triple nil))
;; How long does this take?
;; The time is written in the REPL
;; as "X.XX seconds runtime"
;; Don't worry if your times match what we have.
;; Just say what YOUR REPL spits out.
;; 1.42 seconds realtime, 1.41 seconds runtime


(acl2::er-progn
   (acl2::time$ (acl2::value-triple (isort *med-list*)))
   (acl2::value-triple nil))
;; How long does this take?
;; 0.00 seconds realtime, 0.00 seconds runtime


(acl2::er-progn
   (acl2::time$ (acl2::value-triple (msort *large-list*)))
   (acl2::value-triple nil))
;; How long does this take?
;; 23.64 seconds realtime, 22.76 seconds runtime


(acl2::er-progn
   (acl2::time$ (acl2::value-triple (isort *large-list*)))
   (acl2::value-triple nil))
;; How long does this take?
;;took 0.00 seconds realtime, 0.00 seconds runtime


;; Wait.  What happened here?  Shouldn't msort be much
;; faster than isort?  If we wrote selection sort, it would
;; certainly have been slower than msort. Explain in your
;; own words why you THINK the speed times look the way they do.
;; (you don't need to be correct. I just want people to think
;; about what happened).

#|
Finding the size of the list in ACL2s is O(n) instead of O(1), I think checking the size every time is 
slowing msort down.
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|  Section 6: MORE MEASURE FUNCTIONS (not graded)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
For each of the following terminating functions, write a measure function. You
DO NOT need to prove that the function is a measure, just write the measure
function in ACL2s syntax. These exercises are intended you to give additional
practice coming up with measure functions. You are encouraged to do the proofs
for additional practice, but you are NOT required to submit anything for this
assignment.  This is  for your own practice.

7.
(defunc do-nothing (x y z)
 :input-contract (and (listp x)(listp y)(natp z))
 :output-contract (listp (do-nothing x y z))
 (cond ((and (endp x)(> z 0)) y)
       ((endp y)              (app x y))
       ((> z 0)               (do-nothing (rest x) (rest y) (+ z 1)))
       (t                     (do-nothing (cons (first y) x) (rest y) (+ z 1)))))

.................



8.
(defunc do-something (x y)
  :input-contract (and (natp x) (lorp y))
  :output-contract (booleanp (do-something x y))
  (cond ((equal x (len y))   t)
        ((> x (len y))      (do-something (- x 1) y))
        (t                  (do-something (len y) (list x x x)))))

...............

|#

