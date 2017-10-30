#| CS 2800 Homework 8 - Fall 2017


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will NOT need to use ACL2s, though you can use it as
a text editor to typeset your solution.

Technical instructions:

- open this file as hw08.lisp

- insert your solutions into this file where indicated (usually as "...")

- when done, save your file and submit it as hw08.lisp

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I. ADMISSIBILITY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
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

Assume that these functions are being given to ACL2s in sequence. If a
function is not admitted by ACL2s, you delete that function and begin to
write the next one.
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
1.
(defunc f1 (a b)
  :input-contract  (and (posp a) (posp b))
  :output-contract (posp (f1 a b))
  (cond ((or (equal a 1) (equal b 1)) 1)
        ((< a b)                       (f1 (- a 1) b))
        (t                             (f1 b a))))

; inadmissable, non-termination, example ((a 2) (b 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
2.
(defunc f2 (x n)
  :input-contract (and (listp x) (posp n))
  :output-contract (listp (f2 x n))
  (if (equal n 0)
    (list n)
    (f2 (cons (list (first x)) (rest x)) (- n 1))))

; inadmissable, body contract violation
; (x nil) will throw error on (first x) call
; recursive call  for (n 1) will be with 0 which is not a posp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
3.
(defunc f3 (x)
  :input-contract (natp x)
  :output-contract (integerp (f3 x))
  (if (equal x 1)
    0
    (+ 2 (f3 (- x 1)))))

; inadmissable, body contract violation
; (x 0) will call (f -1) which violates the input contract

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
4.
(defunc f4 (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (listp (f4 x y))
  (if (equal y 1)
    nil
    (f4 (list (first x)) (- y 1))))

; inadmissable, body contract violation
; (nil 5) will call (first nil) which violates the input contract

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
5.
(defunc f5 (l)
  :input-contract (listp l)
  :output-contract (listp (f5 l))
  (if (endp l)
    nil
    (f5 (rest f))))

; inadmissable, free occurance of variable f. Fuction body not a legal statement

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
6.
(defunc f6 (z y z)
  :input-contract (and (posp z) (listp y) (posp z))
  :output-contract (posp (f6 z y z))
  (if (endp y)
    0
    (f6 z (rest y) z)))

; inadmissable, arguments are not distinct symbols. z appears twice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
7.
(defunc f7 (x y)
  :input-contract (and (integerp x) (integerp y))
  :output-contract (integerp (f7 x y))
  (if (equal x 0)
    0
    (+ (* 2 y) (f7 (- x 1) y))))

; inadmissable, non-termination if x is less than zero. Ex. (x -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
8.
(defunc f8 (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (posp (f8 x y))
  (if (endp x)
    (len y)
    (f8 (rest x) y)))

; inadmissable, funtion contract violation. ((x nil) (y nil)) => 0 which is not a posp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
9.
(defunc f9 (x)
  :input-contract (posp x)
  :output-contract (integerp (f9 x))
  (if (equal x 1)
    1
    (- 10 (f9 (- x 2)))))

; inadmissable, body contract violation. (f9 2) will call itselg with (f9 0) which violates the input contact

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
10.
(defunc f10 (x)
  :input-contract (posp x)
  :output-contract (integerp (f10 x))
  (if (equal x 1)
    4
    (- (f10 (- x 1) 1) 2)))

; inadmissable, body contract violation. f10 is called with two inputs, but only expects one.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
11.
(defunc f11 (x)
  :input-contract (posp x)
  :output-contract (natp (f11 x))
  (if (equal x 1)
      1
    (f11 (+ 1 (f11 (- x 1))))))

; inadmissable, non-termination. (f11 2) will not terminate, because the outer call to f11 keeps growing

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
12.
(defunc f12 (x)
  :input-contract (listp x)
  :output-contract (natp (f12 x))
  (cond ((endp z)  0)
        (t         (f12 (rev x)))))

; inadmissable, free occurance of variable z. Fuction body not a legal statement

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
13.
(defunc f13 (x)
  :input-contract (listp x)
  :output-contract (listp (f13 x))
  (cond ((endp x)  x)
        (t         (cons x (f12 (rev x))))))

; inadmissable, undefined function f12. Body is not a legal expression.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; II. GUESSING A MEASURE
;; For each of the following functions, determine if the function terminates.
;; If it does not, give an input on which it doesn't terminate. If it does
;; terminate, write THE SIMPLEST measure function you can - you DO NOT need
;; to prove that it is a measure - just write one that satisfies all
;; requirements of a measure function.
;; Simplest will mean the measure function body with the fewest function calls.
;; Also, please ignore the fact all the functions are named f.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

1.
(defunc f (x y)
  :input-contract (and (posp x) (posp y))
  :output-contract (integerp (f x y))
  (cond (((equal x 1) 10)
        (< x 1)     (f x y))
        (t           (+ 2 (f (- x 1) y)))))


(defunc m (x y)
  :input-contract (and (posp x) (posp y))
  :output-contract (natp (m x y))
  x)

; also parens are messed up

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
2.
(defunc f (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (posp (f x y))
  (if (endp x)
    y
    (+ 1 (f (rest x) y))))

(defunc m (x y)
  :input-contract (and (posp x) (posp y))
  :output-contract (natp (m x y))
  (len x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
3.
(defunc f (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (listp (f x y))
  (cond ((endp x)    (list y))
        ((equal y 1) nil)
        (t           (f (cons (+ y 1) x) (- y 1)))))

(defunc m (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (natp (m x y))
  y)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
4.
(defunc f (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (natp (f x y))
  (if (equal y (len x))
    y
    (if (< (len x) y)
      (f x (- y (len x)))
      (f (rest x) y))))

(defunc m (x y)
  :input-contract (and (listp x) (posp y))
  :output-contract (natp (m x y))
  (abs (- (len x) y))
;; assumed that abs is defined

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
5.
(defunc f (x)
  :input-contract (lonp x)
  :output-contract (natp (f x))
  (if (endp x)
    (f (cons 10 x))
    (if (equal (first x) 0)
      0
      (f (cons (- (first x) 1) x)))))

(defunc m (x)
  :input-contract (lonp x)
  :output-contract (natp (m x y))
  (if (endp x)
      11
      (first x)))
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; III. PROVING A MEASURE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


For the following problems, whenever you are asked to prove termination of
some function f, provide a measure function m such that

Condition 1. m has the same arguments and the same input contract as f.
Condition 2. m's output contract is (natp (m ...))
Condition 3. m is admissible.
Condition 4. On every recursive call of f, given the input contract and
   the conditions that lead to that call, m applied to the arguments in
   the call is less than m applied to the original inputs.

You should do this proof as shown in class (which is also the way we will
expect you to prove termination in exams):

- Write down the formalization of condition 4 (above).
- Simplify the formula (if possible).
- Use equational reasoning to conclude the formula is valid.

Unless clearly stated otherwise, you need to follow these steps for EACH
recursive call separately.

Here is an example.

(defunc f (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (natp (f x y))
  (if (endp x)
    (cond ((equal y 0) 0)
          (t           (+ 1 (f x (- y 1)))))
    (+ 1 (f (rest x) y))))

The measure is

(defunc m (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (natp (m x y))
  (+ (len x) y))

Formalization of condition 4 (above) for the first recursive call:
(implies (and (listp x) (natp y) (endp x) (> y 0)) (< (m x (y-1)) (m x y)))
Proof of Condition 4 for the first recursive call:
Context:
C1. (listp x)
C2. (natp y)
C3. (endp x)
C4. y > 0

(m x y-1)
= { Def m, C3, Arithmetic }
y-1
< { Arithmetic }
y
= { Def m, C3, Arithmetic }
(m x y)

QED

Formalization of condition 4 (above) for the second recursive call:
(implies (and (listp x) (natp y) (not (endp x))) (< (m (rest x) y) (m x y)))
Proof of Condition 4 for the second recursive call:
Context:
C1. (listp x)
C2. (natp y)
C3. (not (endp x))

(m (rest x) y)
= { Def m, C3, len theorem for rest }
(len x) - 1 + y
< { Arithmetic }
(len x) + y
= { Def m }
(m x y)

QED

(defdata lor (listof rational))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1. Prove termination for the following function:

(defunc foo1 (l2 l1)
  :input-contract (and (lorp l2) (lorp l1))
  :output-contract (lorp (foo1 l2 l1))
  (cond ((endp l1)   l2)
        ((endp l2)   (foo1 (rest l1) nil))
        (t           (foo1 (cons (first l1) l2) (rest l1)))))

Provide a measure function

(defunc m (l2 l1)
  :input-contract  (and (lorp l2) (lorp l1))
  :output-contract (natp (m x y))
  (len l1))

And then prove that it is indeed a measure function.

Two recursive calls so two proof obligations:

(implies (and (lorp l2) (lorp l1) (not (endp l1))) (< (m (rest l1) nil) (m l2 l1)))

C1. (lorp l2)
C2. (lorp l1)
C3. (not (endp l1))

Prove
(< (m (rest l1) nil) (m l2 l1))
= { Def m }
(< (len nil)) (len l1))
= { C3, Definition of len, Decreasing len axiom  }

QED


(implies (and (lorp l2) (lorp l1) (not (endp l1)) (not (endp l2))) (< (m (cons (first l1) l2) (rest l1)) (m l2 l1)))

C1. (lorp l2)
C2. (lorp l1)
C3. (not (endp l1))
C3. (not (endp l2))

Prove
(< (m (cons (first l1) l2) (rest l1)) (m l2 l1))
= { Def m }
(< (len (rest l1))) (len l1))
= { Decreasing len axiom }

QED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2. Prove termination for the following function.

(defunc foo2 (p v)
  :input-contract (and (posp p) (posp v))
  :output-contract (posp (foo2 p v))
  (cond ((< p v)     (foo2 p (- v p)))
        ((> p v)     (foo2 (- p v) v))
        (t           (+ (* p 2) (+ 3 v)))))

Define a measure function m for foo2 and prove using equation reasoning that
It is indeed a measure.

(defunc m (p v)
  :input-contract (and (posp p) (posp v))
  :output-contract (natp (m p v))
  (+ p v))

The formalization for Condition 4 (above).

For the first recursive call, we have:
(implies (and (posp p) (posp v) (< p v))
         (< (m p (- v p)) (m p v)))

which is the same as:
(implies (and (posp p) (posp v) (< p v))
         (< (+ p (- v p)) (+ p v)))


For the second recursive call, we have:
(implies (and (posp p) (posp v) (not (< p v)) (> p v))
         (< (m (- p v) v) (m p v)))

which is the same as:
(implies (and (posp p) (posp v) (not (< p v)) (> p v))
         (< (+ (- p v) v) (+ p v)))

Now prove the above two using equational reasoning

C1. (posp p)
C2. (posp v)
C3. (< p v)

Prove
(< (m p (- v p)) (m p v))
= { Def m }
(< (+ p (- v p)) (+ p v))
= { Arithmetic }
(< v (+ p v))
= { C1, Arithmetic }

QED


C1. (posp p)
C2. (posp v)
C3. (not (< p v))
C3. (> p v)

Prove
(< (m (- p v) v) (m p v))
= { Def m }
(< (+ (- p v) v) (+ p v))
= { Arithmetic }
(< p (+ p v))
= { C2, Arithmetic }

QED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;3. Prove termination for the following function:
#
(defunc foo3 (x1 x2)
  :input-contract (and (listp x1) (integerp x2))
  :output-contract (natp (foo3 x1 x2))
  (cond ((and (endp x1) (equal x2 0)) (+ 1 (len x1)))
        ((and (endp x1) (> x2 0))     (+ 1 (foo3 x1 (- x2 1))))
        ((endp x1)                    (+ 1 (foo3 x1 (+ 1 x2))))
        (t                            (+ 1 (foo3 (rest x1) (- 0 x2))))))


; Define a measure function m for foo3.
#|Hint: Note that you can start by writing candidate measures for each branch
above that has a recursive call. However, you might be finally able to
combine some/all of these measures to come up with one that works in all
the 3 relevant cases above.

Also, feel free to use any (terminating) function  we've defined in the past
in your measure function.
|#
;Then prove that the above defined function m is indeed a measure for foo3.

(defunc m (x1 x2)
  :input-contract (and (listp x1) (integerp x2))
  :output-contract (natp (m x1 x2))
  (+ (len x1) (abs x2)))

; Assuming we have abs defined

Three recursive calls so two proof obligations:

(implies (and (listp x1) (integerp x2) (not (and (endp x1) (equal x2 0))) (endp x1) (> x2 0))) (< (m x1 (- x2 1)) (m x1 x2))

C1. (listp x1)
C2. (integerp x2)
C3. (not (and (endp x1) (equal x2 0)))
C4. (and (endp x1) (> x2 0))
...
C5. (not equal x2 0) { C3, C4, PL }
C6. (> x2 0) { C4, PL }

Prove
(< (m x1 (- x2 1)) (m x1 x2))
= { Def m }
(< (+ (len x1) (abs (- x2 1))) (+ (len x1) (abs x2)))
= { Arithmetic }
(< (abs (- x2 1)) (abs x2))
= { definiton of abs, C6 }
(< (- x2 1) x2)
= { Arithmetic }

QED


(implies (and (listp x1) (integerp x2) (not (and (endp x1) (equal x2 0))) (not (endp x1) (> x2 0)) (endp x1)) (< (m x1 (+ 1 x2)) (m x1 x2)))

C1. (listp x1)
C2. (integerp x2)
C3. (not (and (endp x1) (equal x2 0)))
C4. (not (and (endp x1) (> x2 0)))
C5. (endp x1)
...
C6. (< x2 0) { C3, C4, C5, PL, Arithmetic }

Prove
((< (m x1 (+ 1 x2)) (m x1 x2)))
= { Def m }
(< (+ (len x1) (abs (+ 1 x2))) (+ (len x1) (abs x2)))
= { Arithmetic }
(< (abs (+ 1 x2)) (abs x2))
= { definiton of abs, C6, Arithmetic }

QED


(implies (and (listp x1) (integerp x2) (not (and (endp x1) (equal x2 0))) (not (endp x1) (> x2 0)) (not (endp x1))) (< (m (rest x1) (- 0 x2)) (m x1 m2)))

C1. (listp x1)
C2. (integerp x2)
C3. (not (and (endp x1) (equal x2 0)))
C4. (not (and (endp x1) (> x2 0)))
C5. (not (endp x1))

Prove
(< (m (rest x1) (- 0 x2)) (m x1 m2))
= { Def m }
(< (+ (len (rest x1)) (abs (- 0 x2))) (+ (len x1) (abs x2)))
= { Arithmetic, Def abs }
(< (len (rest x1)) (len x1))
= { Decreasing len axiom }

QED

|#
