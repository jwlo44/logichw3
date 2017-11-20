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

(defunc how-many-t (e l acc)
  :input-contract (and (listp l) (natp acc))
  :output-contract (natp (how-many-t e l acc))
  (cond ((endp l) acc)
        ((equal e (first l))  (how-many-t e (rest l) (+ acc 1)))
        (t                    (how-many-t e (rest l) acc))))

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

Prove: (listp l) => (how-many* e l) = (how-many e l)

c1. (listp l)

{ Def how many* }
(equal (how-many-t e l 0) (how-many e l))
{ phi_1, algebra, PL }

QED

(a) Formulate a lemma that relates how-many-t to how-many, by filling in the ... below:

phi_1 : (listp l) /\ (natp acc) => (how-many-t e l acc) =  (+ (how-many e l) acc)


(b) Prove phi_1. Use the induction scheme how-many-t gives rise to. Note
that how-many-t has an if nested inside other functions. You can rewrite
it, using cond, before extracting an induction scheme if you want to use
the I.S. generating pattern from the the notes (it may help).

how-many-t induction scheme:
(not (and (listp l) (natp acc))) => phi
(and (listp l) (natp acc) (endp l)) => phi
(and (listp l) (natp acc) (not (endp l)) (not (equal e (first l)) (phi[((l (rest l))]) => phi
(and (listp l) (natp acc) (not (endp l)) (equal e (first l)) (phi[((l (rest l) (acc (+ acc 1)]) => phi

Obligation 1:
(not (and (listp l) (natp acc))) => phi

c1. (not (and (listp l) (natp acc)))
c2. (listp l) /\ (natp acc) => (how-many-t e l acc) = (+ (how-many e l) acc)

{ c1, c2, PL }

QED


Obligation 2:
(and (listp l) (natp acc) (endp l)) => phi

c1. (listp l)
c2. (natp acc)
c3. (endp l)

Prove
(equal (how-many-t e l acc) (+ (how-many e l) acc))

{ Def how-many-t, c3, PL }
(equal acc (+ (how-many e l) acc))
{ Def how-many, c3, PL }
(equal acc (+ 0 acc))
{ Algebra }

QED

Obligation 3:
(and (listp l) (natp acc) (not (endp l)) (not (equal e (first l)) (phi[((l (rest l))]) => phi

c1. (listp l)
c2. (natp acc)
c3. (not (endp l))
c4. (not (equal e (first l)))
c5. (and (listp (rest l)) (natp acc)) => (equal (how-many-t e (rest l) acc) (+ (how-many e (rest l)) acc)

Prove
(equal (how-many-t e l acc) (+ (how-many e l) acc))

{ Def how-many-t, c3, c4, PL }
(equal (how-many-t e (rest l) acc)) (+ (how-many e l) acc))
{ Def how-many, c3, PL, c4, PL }
(equal (how-many-t e (rest l) acc)) (+ (+ 0 (how-many e (rest l))) acc))
{ Algebra }
(equal (how-many-t e (rest l) acc)) (+ (how-many e (rest l)) acc))
{ c5, c3, rest non-empty list axiom, c2, MP }

QED

Obligation 4:
(and (listp l) (natp acc) (not (endp l)) (equal e (first l)) (phi[((l (rest l) (acc (+ acc 1)]) => phi

c1. (listp l)
c2. (natp acc)
c3. (not (endp l))
c4. (equal e (first l))
c5. (and (listp (rest l)) (natp (+ acc 1)) => (equal (how-many-t e (rest l) (+ acc 1)) (+ (how-many e (rest l)) (+ acc 1))

Prove
(equal (how-many-t e l acc) (+ (how-many e l) acc))

{ Def how-many-t, c3, c4, PL }
(equal (how-many-t e (rest l) (+ acc 1)) (+ (how-many e l) acc))
{ Def how-many, c3, PL, c4, PL }
(equal (how-many-t e (rest l) (+ acc 1))) (+ (+ 1 (how-many e (rest l))) acc))
{ Algebra }
(equal (how-many-t e (rest l) (+ acc 1))) (+ (how-many e (rest l)) (+ acc 1))
{ c5, c3, Def listp, Def natp, c2, MP }

QED

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
  :input-contract (and (listp l) (integerlistp acc))
  :output-contract (integerlistp (get-integers-t (l acc)))
  (cond ((endp l)         acc)
        ((integerp (first l)) (get-integers-t (rest l) (cons (first l) acc)))
        (t                    (get-integers-t (rest l) acc))))

acc = (1 2)


(check= (get-integers-t '(b "23" lk ())) ())
(check= (get-integers-t '(h "ter" -1 aw 9)) '(-1 9))
(check= (get-integers-t '("qw" "brc" aw (1 2 3) 89 rt -1)) '(89 -1))

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

phi_2 : (listp l) /\ ( => (get-integers-t l acc) = (rev (app acc (get-integers l)))

(d) Assuming that lemma in (c) is true and using ONLY equational reasoning,
prove the main theorem:

 (listp l) => (get-integers* l) = (get-integers l)

If you need any "lemmas", note them down as "debt", to be proved later. This should
include any theorems that we've already proven (you won't need to prove these but you
still need to list them)

Prove
(listp l) => (get-integers* l) = (get-integers l)

Case 1
c1. (not (listp l))

{ c1, MT }
QED

Case 2
c1. (listp  l)

Prove
(equal (get-integers* l) (get-integers l))

{ Def get-integers* }
(equal (rev (get-integers-t l ())) (get-integers l))
{ apply rev to both side, debt_1 }
(equal (get-integers-t l ()) (rev (get-integers l)))
{ phi_2, debt_2 }

QED

debt_1: (rev (rev l) = l
debt_2: (app () l) = l

(e) Prove the lemma in (c). Use the induction scheme of get-integers-t. In
doing so, you can use the following lemma for free (i.e., you don't need to
prove it).

L3: (integerp e) /\ (integerlistp l) => (integerlistp (cons e l))

Again, if you need another lemma, note it as "dept"

get-integers-t induction scheme:
(not (and (listp l) (integerlistp acc))) => phi
(and (listp l) (integerlistp acc) (endp l)) => phi
(and (listp l) (integerlistp acc) (not (endp l)) (integerp (first l))
        (phi[((l (rest l)) (acc (cons (first l) acc))])) => phi)
(and (listp l) (integerlistp acc) (not (endp l)) (not (integerp (first l)))
        (phi[((l (rest l))])) => phi)

Obligation 1

Obligation 2

Obligation 3

Obligation 4

(defunc get-integers-t (l acc)
  :input-contract (and (listp l) (integerlistp acc))
  :output-contract (integerlistp (get-integers-t (l acc)))
  (cond ((endp l)         acc)
        ((integerp (first l)) (get-integers-t (rest l) (cons (first l) acc)))
        (t                    (get-integers-t (rest l) acc))))

(f) List here any lemmas that you used in d or e. If any of them are "new", you need
to prove them. (Hint: all lemmas in my solution have appeared in class/notes
before but your proof my differ)

debt_1: (rev (rev l) = l
debt_2: (app () l) = l

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

(defunc add-digits-t (x acc)
 :input-contract (and (natp x) (natp acc))
 :output-contract (natp (add-digits-t x acc))
 (if (< x 10)
   (+ x acc)
   (let ((rem10 (rem x 10)))
      (add-digits (/ (- x rem10) 10) (+ rem10 acc)))))

(defunc add-digits* (x)
  :input-contract (natp x)
  :output-contract (natp (add-digits* x))
  (add-digits-t x 0))


:logic
#|
(b) Consider this conjecture:

 (natp x) /\ (natp acc) => (add-digits-t x acc) = (add-digits x) + acc

Using the induction scheme add-digits-t gives rise to, prove this conjecture.
Notice that we don't have to worry about order.  Why is that?

You may use rem10 as an abbreviation for (rem x 10), as done in the
function definition. You can use any lemmas or theorems from
the lectures/homework/notes or from basic arithmetic that you may be using,
but clearly identify them. You may also use the following fact without
proof:

 div-rem :: (natp x) /\ (posp d) => (natp (/ (- x (rem x d)) d))

add-digits-t induction scheme
(not (and (natp x) (natp acc))) => phi
(and (natp x) (natp acc) (< x 10)) => phi
(and (natp x) (natp acc) (not (< x 10)) phi[((x (/ (- x rem10) 10)) (acc (+ rem10 acc))]) => phi

Obligation 1

Obligation 2

Obligation 3
c1. (natp x)
c2. (natp acc)
c3. (not (< x 10))
c4. (natp (/ (- x rem10) 10)) /\ (natp (+ rem10 acc))) =>
        (add-digits-t (/ (- x rem10) 10)) (+ rem10 acc))) = (add-digits (/ (- x rem10) 10))) + (+ rem10 acc))

Prove
(natp x) /\ (natp acc) => (add-digits-t x acc) = (add-digits x) + acc





(defunc add-digits-t (x acc)
 :input-contract (and (natp x) (natp acc))
 :output-contract (natp (add-digits-t x acc))
 (if (< x 10)
   x
   (let ((rem10 (rem x 10)))
      (add-digits (/ (- x rem10) 10) (+ rem10 acc)))))


(c) Prove:

 (natp x) => (add-digits* x) = (add-digits x)

Use pure equational reasoning. You can use any lemmas or
theorems from the lectures/homework/notes but clearly identify
them if you use them.
..........

|#
#|
d) Wait.  What about rem??  That's not tail recursive and could lead
to problems. Write function rem* and rem-t such that rem* = rem.
Prove the two functions are equivalent.
Feel free to move the definitions of rem-t and rem* to before add-digits-t
and modify add-digits-t to use them (once you prove rem* = rem of course)
|#
.................


#| EXTRA PRACTICE ???
If you want additional practice problems, try writing tail recursive functions
for the following functions and then prove they are equivalent to the original
  - min-l
  - delete
  - merge
In fact, for many functions that aren't already tail recursive, you can write a tail
recursive version and then prove the equivalence. You can generate your own problems.

|#
