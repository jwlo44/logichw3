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
CS 2800 Homework 7 - Fall 2017

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw07.lisp

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

- when done, save your file and submit it as hw07.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file!

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.

You must also ALWAYS supply your own tests. This is in addition to the
tests sometimes provided. Make sure you produce sufficiently many new test
cases. This means: cover at least the possible scenarios according to the
data definitions of the involved types. For example, a function taking two
lists should have at least 4 tests: all combinations of each list being
empty and non-empty.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number of inputs.

Use good judgment. For unreasonably few test cases we will deduct points.
The markers have been given permission to add any tests they want. Thus one
way to tell how many tests you need: are you positive the markers won't break
your code?

We will use ACL2s' check= function for tests. This is a two-argument
function that rejects two inputs that do not evaluate equal. You can think
of check= roughly as defined like this:

(defunc check= (x y)
  :input-contract (equal x y)
  :output-contract (equal (check= x y) t)
  t)

That is, check= only accepts two inputs with equal value. For such inputs, t
(or "pass") is returned. For other inputs, you get an error. If any check=
test in your file does not pass, your file will be rejected.

You should also use test? for your tests. See Section 2.13 of the
lecture notes. An example of test? is the following.

(test? (implies (and (listp l) (natp n))
                (<= (len (sublist-start n)) n)))

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;PART I. PROGRAMMING AND CONTRACTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Lists of lists

; A list can itself contain lists, and these lists can contain other lists
; to any number of levels.  The listp function only checks whether one has
; a list at the top level.  It does not check any of its elements.  Develop
; a recognizer that checks whether every element of a list l or any list
; contained in l (to any number of levels) contains only atoms or lists. A list of
; lists can not have a non-list cons at any level.

; 1. Define
; pure-listp: All -> Boolean
; (pure-listp l) is t iff l is a list of atoms or lists, each list that
; it contains is also a list of atoms or lists, and so on to any number
; of levels.

(defunc pure-listp (l)
  :input-contract t
  :output-contract (booleanp (pure-listp l))
  (if (listp l)
    (if (endp l) t
      (and (or (atom (first l))
               (pure-listp (first l)))
           (pure-listp (rest l))))
    nil))

(check= (pure-listp nil) t)
(check= (pure-listp (cons 1 2)) nil)
(check= (pure-listp 4) nil)
(check= (pure-listp (list 1 2 (list 3 (cons 4 3)))) nil)#|ACL2s-ToDo-Line|#

;; Add more tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Count the number of times that e occurs in a pure list
; to any number of levels.

; 2. Define
; count: All x Purelist -> Nat
; (count e l) is the number of times that e occurs in a pure list
; either in the list itself, or in an list in the list, to any
; number of levels.
(defunc count (e l)
  :input-contract (pure-listp l)
  :output-contract (natp (count e l))
  (cond ((endp l) 0)
        ((equal (first l) e) (+ 1 (count e (rest l))))
        ((atom (first l)) (count e (rest l)))
        (t (+ (count e (first l)) (count e (rest l))))))

(check= (count 2 (list 2 (list 1 2 (list 3 2)))) 3)
(check= (count 2 (list 2 (list (list 3 2) 1) 3)) 2)
;; Add more tests

:logic

; odd-even ratio
; define a list of naturals
(defdata natlist (listof Nat))

; 3.
; Define a function odd-even-ratio that takes in a natlist
; and returns the ratio of the sum of odd numbers in the list
; to the sum of even numbers in the list. If the sum of even
; numbers is 0, return 1

 
 :program ; DO NOT comment this!
 ; HINT: you may use helper function(s) and/or define your own
 ; datatype to make the code modular and readable
 
 
; odd-even-ratio: Natlist -> Rational
; takes in a natlist and returns the ratio of the sum of odd
; numbers in the list to the sum of even numbers in the list.
; If the sum of even numbers is 0, return 1
(defunc odd-even-ratio (l)
  :input-contract (natlistp l)
...........)

(check= (odd-even-ratio '(1 2 3 4 5 6)) (/ 9 12))
(check= (odd-even-ratio '(3 2 5 4 6 1)) (/ 3 4))
;; Add more tests

:logic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CONTRACTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Identify if there is a body contract or a function contract violation. If so,
;provide an input for which the violation occurs and point to the exact
;location of the error.

#|
4. (defunc f (x)
  :input-contract (posp x)
  :output-contract (integerp (f x))
  (if (equal x 1)
    9
    (- 10 (f (- x 2)))))
    
    body contract violation, if f is called with 2, will call itself with 0, which is not a posp.
|#



#|
5. (defunc f (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (listp (f x y))
  (if (equal y 1)
    nil
    (f (list (first x)) (- y 1))))
|#

#|
6. (defunc f (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (posp (f x y))
  (if (endp x)
    0
    (+ 1 (f (rest x) y))))
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;PART II. PROPOSITIONAL LOGIC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;A. Simplify using rules of propositional logic - DO NOT give a truth table as the solution
;; Your solutions should have the fewest number of propositional operators that you can give
;; thus ~(A \/ ~B) should be simplified to ~A /\ B.  Parentheses do not count as operators.

;1. ~(p=>q) \/ ~(q=>p)
;......................

;2. q => (((p \/ q) /\ p) /\ ((p /\ q) \/ q) )
;......................


;3. p => (~q \/ r \/ ((q => r) /\ p))
;......................


;4. ~(r => ~q) \/ ~(p => ~r)
;......................

;5. ~((p => q) /\ ~r)
;......................

;6.  p => p => p
;......................

;7. ((p <=> q) <=> (p <> q)) => ((p \/ q) => (q=>p))
;......................


;;----------------------------------------------
;; B.Checking if a formula is unsatisfiable
;; Suppose we want to build a procedure IS_UNSAT(f) that can check if the input
;; propositional logic formula f is unstaisfiable or not. However, suppose we only have
;; access to a procedure IS_VALID(f) that can check if the input propositional
;; formula f is valid. How do we build IS_UNSAT(F)? An explanation in English is fine.
;; Hint: we can use propositional logic connectives ...
;......................


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;PART III. EQUATIONAL REASONING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
(defunc foo (m n)
  :input-contract (and (natp m) (natp n))
  :output-contract (natp (foo m n))
  (cond ((equal m 0) (+ n 1))
        ((equal n 0) (foo (- m 1) 1))
        (t (foo (- m 1) (foo m (- n 1))))))

1. Prove the following using equational reasoning:

(not (or (not (implies (natp n)
                       (equal (foo 0 n) (+ 1 n))))
         (not (implies (and (natp n)
                             (equal n 0))
 
                       (equal (foo 1 n) (+ 2 n))))))
|#
;......................

#|
2. Prove the following using equational reasoning:

(implies (and (natp n)
              (not (equal n 0))
              (implies (natp (- n 1))
                       (equal (foo 1 (- n 1)) (+ 2 (- n 1)))))
         (equal (foo 1 n) (+ 2 n)))

;......................
|#

#|
3. Fill in the ...'s below so that the resulting formula is a
theorem.

The first ... is the what you get from contract completion. See
the lecture notes if you need a reminder of what contract
completion is. Contract completion should not include any
unnecessary terms.

For the second ..., you cannot use the function "a" in your
answer, e.g., you cannot simply replace ... by "(a 2 n)". The
... has to be replace by an arithmetic expression, i.e., an
expression involving arithmetic functions we have already
seen(such as +, -, *, and /).

***Note that you do not have to prove anything.***
|#
#|
(implies (natp n)
         (equal (foo 2 n) ...))
;......................
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The following equational reasoning problem (Question 4) is for extra practice, and
; will not be graded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
4. Consider the following definitions:

(defunc len (l)
  :input-contract (listp l)
  :output-contract (natp (len l))
  (if (endp l)
    0
    (+ 1 (len (rest l)))))

(defunc ziplists (x y)
  :input-contract (and (listp x) (listp y) (equal (len x) (len y)))
  :output-contract (listp (ziplists x y))
  (if (endp x)
    nil
    (cons (list (first x) (first y))
          (ziplists (rest x) (rest y)))))

Prove the following using equational reasoning:
phi:
(implies (and (listp x) (listp y) (equal (len x) (len y)))
         (and (implies (endp x)
                       (equal (len (ziplists x y))
                              (len x)))
              (implies (and (consp x)
                            (equal (len (ziplists (rest x) (rest y)))
                                   (len (rest x))))
                       (equal (len (ziplists x y))
                              (len x)))))
|#
#|
;......................
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;PART IV. ADMISSIBILITY
; THIS WILL NOT BE ON EXAM 1:
; so you may wait until exam1
; is over to attempt this!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
This problem set is about the "Definitional Principle".

For each of the definitions below, check whether it is admissible, i.e. it
satisfies all rules of the definitional principle. You can assume that Rule
1 is met: the symbol used in the defunc is a new function symbol in each
case.

If you claim admissibility,

1. Explain in English why the body contracts hold.
2. Explain in English why the contract theorem holds.
3. Suggest a measure function that can be used to show termination.
   (You DO NOT have to prove the measure function properties in this problem.)

Otherwise, identify a rule in the Definitional Principle that is violated.

If you blame one of the purely syntactic rules (variable names,
non-wellformed body etc), explain the violation in English.

If you blame one of the semantic rules (body contract, contract theorem or
termination), you must provide an input that satisfies the input contract, but
causes a violation in the body or violates the output contract or causes
non-termination.

Remember that the rules are not independent: if you claim the function does
not terminate, you must provide an input on which the function runs forever
*without* causing a body contract violation: a body contract violation is
not a counterexample to termination. Similarly, if you claim the function
fails the contract theorem, you must provide an input on which it
terminates and produces a value, which then violates the output contract.
Assume that each function symbol f is a new one (i.e., not already admitted
by ACL2s before).


1. (defunc f (x)
  :input-contract (posp x)
  :output-contract (posp (f x))
  (if (equal x 1)
      9
    (f (+ 10 (f (- x 1))))))
;......................

2. (defunc f (x)
  :input-contract (integerp x)
  :output-contract (natp (f x))
  (if (>= x 0)
     (- (* x x) x)
     (+ x (* x x))))
;......................

3. (defunc f (x l)
  :input-contract (and (integerp x) (listp l))
  :output-contract (natp (f x l))
  (if (equal x 0)
     0
     (if (> x 0)
       (f (- x 1) (cons x l))
       (f (+ x 1) (cons x l)))))
;......................

4. (defunc f (x)
  :input-contract (integerp x)
  :output-contract (integerp (f x))
  (if (equal x 1)
    9
    (- 10 (f (- x 1)))))
;......................
|#