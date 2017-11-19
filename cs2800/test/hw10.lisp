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


Names of ALL group members: FirstName1 LastName1, FirstName2 LastName2, ...

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

Merge Induction Scheme:
(not (and (lorp l1) (lorp l2))) => phi
(and (lorp l1) (lorp l2) (endp l1)) => phi
(and (lorp l1) (lorp l2) (not (endp l1)) (endp l2)) => phi
(and (lorp l1) (lorp l2) (not (endp l1) (endp l2)) (< (first l1)(first l2)) phi[(l1 (rest l1))]) => phi
(and (lorp l1) (lorp l2) (not (endp l1) (endp l2) (< (first l1)(first l2))) phi[(l2 (rest l2))]) => phi


First Obligation:
(not (and (lorp l1) (lorp l2))) => (sortedp (merge l1 l2)
{Def merge }

not the lhs of implies makes the statement true

Second Obligation:
(and (lorp l1) (lorp l2) (orderedp l1)(orderedp l2) (endp l1)) => (orderedp (merge l1 l2))

c1. (lorp l1)
c2. (lorp l2)
c3. (orderedp l1)
c4. (orderedp l2)
c5. (endp l1)

Prove
(orderedp (merge l1 l2))
{Def merge, c5, PL, c4}

QED

Third Obligation:
(and (lorp l1) (lorp l2) (not (endp l1)) (endp l2)) => (orderedp (merge l1 l2))

c1. (lorp l1)
c2. (lorp l2)
c3. (orderedp l1)
c4. (orderedp l2)
c5. (not (endp l1))
c6. (endp l2)

Prove
(orderedp (merge l1 l2))
{Def merge, c6, PL, c3}

QED

Forth Obligation:
c1. (lorp l1)
c2. (lorp l2)
c3. (orderedp l1)
c4. (orderedp l2)
c5. (not (endp l1) (endp l2))
c6. (< (first l1)(first l2))
c7. (implies (and (lorp (rest l1))(lorp l2)(orderedp (rest l1))(orderedp l2))
                        (orderedp (merge (rest l1) l2)))
....
c8. (not (endp l1))
c9. (not (endp l2))

Prove
(orderedp (merge l1 l2))

{ Def merge, c4, PL }
(orderedp (cons (first l1) (merge (rest l1) l2)))

L1. (<= (first l1) (merge (rest l1) l2))
{ Def orderedp, not empty cons axiom, c8, axiom1, c7, PL }

QED


L1: (<= (first l1) (first (merge (rest l1) l2)))

Prove using listp induction scheme
(endp (rest l1)) => phi
(not (endp (rest l1))) => phi

c1. (lorp l1)
c2. (lorp l2)
c3. (orderedp l1)
c4. (orderedp l2)
c5. (not (endp l1) (endp l2))
c6. (< (first l1)(first l2))
c7. (orderedp (merge (rest l1) l2)) => (orderedp (merge l1 l2))
c8. (endp (rest l1))
....
c8. (not (endp l1))
c9. (not (endp l2))


proof obligation 1:
{ Def merge, c8, PL, c5 }

QED

proof obligation 2:

c1. (lorp l1)
c2. (lorp l2)
c3. (orderedp l1)
c4. (orderedp l2)
c5. (not (endp l1) (endp l2))
c6. (< (first l1)(first l2))
c7. (orderedp (merge (rest l1) l2)) => (orderedp (merge l1 l2))
c8. (not (endp (rest l1)))
c9. (<= (first l1) (first (merge (rest (rest l1) l2)))) => (<= (first l1) (first (merge (rest l1) l2)))
....
c10. (not (endp l1))
c11. (not (endp l2))

{ Def merge, c8, c9, c6 }
(<= (first l1) (cons (first l1) (first (merge (rest (rest l1)) l2))))
{ first cons axiom, c9, PL }

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

- What happens when you insert an element into a ordered
merged list? What happens if you insert the element
in x (which is ordered) and then merge?
  * Let's assume that  (first x) < (first y) provided
    lists x and y are non-empty just to make your lives easier
    You can just add it to your lemma's context rather than
    the conjecture itself.  If you really want to show off
    your math skills, you can do the proof without this assumption.
    By the way, why can I order these lists any way I want and make
    that assumption?

Feedback from Dustin: Do NOT try to prove the associativity of merge.
The proof is horrible.  The above questions should guide you to a
reasonable solution that you can finish before you graduate.

You can also assume the following is true (and can prove it
for extra practice):
L3:
(rationalp e) /\ (lorp l2)
    => (merge (list e) l2) = (insert e l2)


(implies (and (lorp x)(lorp y))
         (equal (isort (merge x y))
                (merge (isort x) (isort y)))))

Merge Induction Scheme:
(not (and (lorp l1) (lorp l2))) => phi
(and (lorp l1) (lorp l2) (endp l1)) => phi
(and (lorp l1) (lorp l2) (not (endp l1)) (endp l2)) => phi
(and (lorp l1) (lorp l2) (not (endp l1) (endp l2)) (< (first l1)(first l2)) phi[(l1 (rest l1))]) => phi
(and (lorp l1) (lorp l2) (not (endp l1) (endp l2) (< (first l1)(first l2))) phi[(l2 (rest l2))]) => phi

Obligation 4
(and (lorp l1) (lorp l2) (not (endp l1) (endp l2)) (< (first l1)(first l2)) phi[(l1 (rest l1))]) => phi

(implies (and (lorp x)(lorp y))
         (equal (isort (merge x y))
                (merge (isort x) (isort y)))))

c1. (lorp l1)
c2. (lorp l2)
c3. (not (endp l1))
c4. (not (endp l2))
c5. (< (first l1)(first l2))
c6. (implies (and (lorp (rest l1)))(lorp l2))
         (equal (isort (merge (rest l1) l2))
                (merge (isort (rest l1)) (isort l2)))))

Prove
(equal (isort (merge l1 l2))
       (merge (isort l1)) (isort l2)))
{ Def merge, c3, c4, c5, PL }
(equal (isort (cons (first l1) (merge (rest l1) l2))))
      (cons (first (isort l1))(merge (rest (isort l1)) (isort l2))))
{ Def isort, non empty cons axiom }
(equal (insert (first (cons (first l1) (merge (rest l1) l2))) (isort (rest (cons (first l1) (merge (rest l1) l2)))))))
    (cons (first (isort l1))(merge (rest (isort l1)) (isort l2)))))
{ first cons, rest cons }
(equal (insert (first l1) (isort (merge (rest l1) l2))))
    (cons (first (isort l1))(merge (rest (isort l1)) (isort l2)))))




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


(defunc merge (l1 l2)
  :input-contract (and (lorp l1)(lorp l2))
  :output-contract (lorp (merge l1 l2))
  (cond ((endp l1)   l2)
        ((endp l2)   l1)
        ((< (first l1)(first l2))
         (cons (first l1)(merge (rest l1) l2)))
        (t
         (cons (first l2)(merge l1 (rest l2))))))




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



|#

#|
PROVE
Prove phi_prime_factorize:
(implies (gposp a)(equal a (mult-l (factors a))))

c1. (gposp a)
Prove
(equal a (mult-l (factors a)))
{ Def factors }
(equal a (mult-l (factors-help n 2))

L1: (implies (gposp n) (gposp f) (equal n (mult-l (factors-help n f))))
{ L1, c1, Def gosp, MP }

QED


L1: (implies (gposp n) (gposp f) (equal n (mult-l (factors-help n f))))

factors-help induction scheme
(not (and (gposp n)(gposp f))) => phi
(and (gposp n)(gposp f) (<= n f)) => phi
(and (gposp n)(gposp f) (not (<= n f)) (gposp (/ n f) (phi|[n (/ n f))]) => phi
(and (gposp n)(gposp f) (not (<= n f)) (not (gposp (/ n f)) (phi|[f (+ f 1))]) => phi

First obligation
c1. (not (and (gposp n)(gposp f)))
c2. (and (gposp n)(gposp f))

Prove
(implies (gposp n) (gposp f) (equal n (mult-l (factors-help n f))))
{ c1, c2, PL, false lhs of implies equals true }

QED


Second obligation
c1. (gposp n)
c2. (gposp f)
c3. (<= n f)

Prove
(implies (gposp a) (gposp f) (equal a (mult-l (factors-help a f))))

{ Def factors-help, c3, PL }
(equal a (mult-l (list a))
{ Def mult-l }
(equal a
  (if (endp (list a))
    1
    (* (first (list a))(mult-l (rest (list a)))))))
{ Def list, Def endp, PL }
(equal a (* (first (list a))(mult-l (rest (list a)))))))
{ first of list, Def mult-l, rest of list is endp, PL }
(equal a (* a 1))
{ Def *, Arithmetic }

QED


Third obligation
(and (gposp n)(gposp f) (not (<= n f)) (gposp (/ n f) (phi|[n (/ n f))]) => phi
c1. (gposp n)
c2. (gposp f)
c3. (not (<= n f))
c4. (gposp (/ n f)
c5. (implies (gposp (/ n f)) (gposp f) (equal (/ n f) (mult-l (factors-help (/ n f) f))))

Prove
(equal n (mult-l (factors-help n f)))
{ Def factors-help, c3, c4, PL }
(equal n (mult-l (cons f (factors-help (/ n f) f))))
{ Def mult-l, non-empty cons axiom, PL }
(equal n (* (first (cons f (factors-help (/ n f) f)))(mult-l (rest (cons f (factors-help (/ n f) f)))))))
{ first cons axiom }
(equal n (* (factors-help (/ n f) f)) (mult-l (rest (cons f (factors-help (/ n f) f)))))
{ rest cons axiom }
(equal n (* f (mult-l (factors-help (/ n f) f))))
{ c4, c2, c5, MP, Arithmetic }
(equal n (* f (/ n f)))
{ Arithmetic }

QED


Forth obligation
(and (gposp n)(gposp f) (not (<= n f)) (not (gposp (/ n f)) (phi|[f (+ f 1))]) => phi
c1. (gposp n)
c2. (gposp f)
c3. (not (<= n f))
c4. (not (gposp (/ n f))
c5. (implies (gposp n) (gposp (+ f 1)) (equal n (mult-l (factors-help n (+ f 1)))))

prove
(equal n (mult-l (factors-help n f)))
{ Def factors-help, c3, c4, PL }
(equal n (mult-l (factors-help n (+ f 1)))))
{ c1, c2, Def gpos, c5, MP, Arithmetic, PL }

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
