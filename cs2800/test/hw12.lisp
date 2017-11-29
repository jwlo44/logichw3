#|

CS 2800 Homework 12 - Fall 2017

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

#|
Induction, Programming, and Tail Recursion Proofs

This assignment is designed to serve as a review and prepare you
for exam 2. Thus, although this is done in groups, you should perhaps do
this by yourself and then merge with your group-mates.

How you approach a proof is not necessarily obvious and even your TAs and
instructors have to try a proof multiple ways. It's fine to try the wrong 
IS at first and then adjust. If you can figure out what inductive assumptions
and stopping conditions you need for a proof before starting, that's even better.
The point being: a false start to your proof doesn't imply (via MP) that you
don't understand the topic but practice reduces the number of false starts.
This assignment will hopefully give you that practice.

|#


#|
***************
THEME: I Love the End of Term
The end is fast approaching and although many of you might be concerned about 
the exam, I've regularly pointed out a key difference from the first half
of the semester: you can make your own problems.  The fact we can come up
with properties related to a function, we can write tail recursive versions of a function
and the fact we may need to prove a function is admissible (and thus terminates)
means that any single function can spawn a slew of questions touching on all aspects
of the course. Give it a try on your own......

....or let's do that now. Take the functions ssort (for selection sort) and weave.
We will keep revisiting these functions throughout the homework.  First, let's define
them and the functions necessary to use them.

Note that I'm denoting all questions with
##.............. so you don't accidentally overlook one (you can do a 
search).

Also note that many questions are "EXTRA" meaning they are worth no points and won't be 
graded.  These are for you to potentially get more practice.  The homework would be painfully
long if we required you to prove all the questions.  Hence keep an eye out for what is optional
and what is not.

***************
|#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; del: Any x List -> List
;; (del e l) takes an element e and a list l
;; and removes the FIRST occurence of e from l
;; If e is not in l then l is returned.
(defunc del (e l)
  :input-contract (listp l)
  :output-contract (listp (del e l))
  (if (endp l)
    l
    (if (equal e (first l))
      (rest l)
      (cons (first l) (del e (rest l))))))
;; Ignore
(sig del (all (listof :b)) => (listof :b))

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


(defdata lor (listof rational))
(defdata lon (listof nat))

;; min-l: LOR (non-empty -> Rational
;; (min-l l) returns the smallest element in l.
(defunc min-l (l)
  :input-contract (and (lorp l)(consp l))
  :output-contract (rationalp (min-l l))
  (if (endp (rest l))
    (first l)
    (let ((min (min-l (rest l))))
        (if (< min (first l)) min (first l)))))


;;Keep to help ssort go in AFTER you add your lemmata from part A.
;; This is purely optional.
(defthm phi_del_lorp (implies (lorp l)(lorp (del e l))))



;; ssort: LOR -> LOR
;; (ssort l) sorts list l using the selection sort algorithm
;; This involves repeatedly finding the smallest element in the list
;; and putting it at the front of the list (or sublist)
(defunc ssort (l)
  :input-contract (lorp l)
  :output-contract (lorp (ssort l))
  (if (endp l)
    l
    (let ((min (min-l l)))
      (cons min (ssort (del min l))))))

;; weave: list x List -> list
;; (weave x y) takes two lists and interweaves
;; them so the resultant list alternates between
;; an element from x and an element from y.
(defunc weave (x y)
  :input-contract (and (listp x)(listp y))
  :output-contract (listp (weave x y))
  (cond ((endp x) y)
        ((endp y) x)
        (t (cons (first x) 
                 (cons (first y)
                       (weave (rest x)(rest y)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Section A: Admissibility, Measure Functions and Induction Schemes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
First, let's review the conditions necessary for a function to be admitted in
ACL2s (I'm paraphrasing below):
1) The function f is a new function symbol
2) The input variables are distinct variable symbols
3) The body of the function is a well formed term, possibly using a recursive
call to f and mentioning no variables freely (ie only the input variables)
4) The function is terminating
5) IC=>OC is a theorem
6) The body contract holds under the assumption that the IC holds (ie there
isn't a body contract violation if the input contract is true)


OK.  Now onto the questions. 

For each function fn below (f1...f5), determine if the function fn is admissible:

If fn is admissible: 
   1) provide a measure function mn that can be used to prove it terminates
   2) Write the proof obligations for fn using mn that can show it terminates.
   3) Convince yourself that the function terminates (no need for a formal proof)
   4) Write the induction scheme that fn gives rise to.

If fn is NOT admissible, 
   1) Give your justification as to why (conditions 1-6 above).
      a) If the problem is syntactic (admissibility conditions 1-3) then tell us what
         part of the function has a problem.
      b) If the issue is with conditions 4-6, then give an input that will illustrate
         the violation.
   2) Give the (invalid) induction scheme that fn gives rise to.
   
A1.
|#
(defunc f1 (x y z)
  :input-contract (and (natp x) (natp y) (listp z))
  :output-contract (natp (f1 x y z))
  (cond ((< x 10) (* x y))
        ((<= (len z) y) (* (len z) y))
        ((> x (len z)) (+ x (f1 x y (rest z))))
        (t (f1 (- x 10) y z))))
#|

admissible,
(defunc m1 (x y z)
  :input-contract (and (natp x) (natp y) (listp z))
  :output-contract (natp (m1 x y z))
  (+ x (len z)))

m1 Obligations:
(and (natp x) (natp y) (listp z) (not (< x 10)) (not (<= (len z) y)) 
     (> x (len z))) => (> (m1 x y z) (m1 x y (rest z)))
 
(and (natp x) (natp y) (listp z) (not (< x 10)) (not (<= (len z) y)) 
     (not (> x (len z)))) => (> (m1 x y z) (m1 (- x 10) y z))

Induction Scheme:
(not (and (natp x) (natp y) (listp z))) => phi_1
(and (natp x) (natp y) (listp z) (< x 10)) => phi_1
(and (natp x) (natp y) (listp z) (not (< x 10)) (<= (len z) y)) => phi_1
(and (natp x) (natp y) (listp z) (not (< x 10)) (not (<= (len z) y)) 
     (> x (len z)) (phi [((z (rest z)))])) => phi_1
(and (natp x) (natp y) (listp z) (not (< x 10)) (not (<= (len z) y)) 
     (not (> x (len z))) (phi [((x (- x 10)))])) => phi_1


|#
(defunc f2 (x y)
  :input-contract (and (integerp x)(integerp y))
  :output-contract (integerp (f2 x y))
  (if (natp x)
    y
    (if (natp y)
      (if (<= (unary-- x) y)
        (f2 (+ x 1) y)
        (f2 x (- y 1)))
      x)))
;; rewrote using cond
(defunc f2* (x y)
     :input-contract (and (integerp x)(integerp y))
     :output-contract (integerp (f2* x y))
     (cond ((natp x) y)
           ((not (natp y)) x)
           ((<= (unary-- x) y) (f2 (+ x 1) y))
           (t (f2 x (- y 1)))))
#|
;; Remember, induction schemes rely on converting a function to an equivalent
;; cond statement (at least if you want to use the design pattern for creating an IS
;; given in the notes)

              
admissible,
(defunc m2 (x y)
  :input-contract (and (integerp x)(integerp y))
  :output-contract (natp (m2 x y))
  (if (<= (unary-- x) y) 
      (unary-- x) 
      y))

m2 obligations:
(and (integerp x)(integerp y)(not (natp x)) (natp y) (<= (unary-- x) y)) => (> (m2 x y) (m2 (+ x 1)) y) 
(and (integerp x)(integerp y)(not (natp x)) (natp y) (not (<= (unary-- x) y))) => (> (m2 x y) (m2 x (- y 1)))
 
Induction Scheme: 
(not (and (integerp x)(integerp y))) => phi_2
(and (integerp x)(integerp y)(natp x)) => phi_2
(and (integerp x)(integerp y)(not (natp x)) (not (natp y))) => phi_2
(and (integerp x)(integerp y)(not (natp x)) (natp y) (<= (unary-- x) y) (phi[((x (+ x 1)))])) => phi_2
(and (integerp x)(integerp y)(not (natp x)) (natp y) (not (<= (unary-- x) y)) (phi[((y (- y 1)))])) => phi_2


|#

;; No need to consider the admissibility of evenp.  Just f3
(defunc evenp (i)
  :input-contract (integerp i)
  :output-contract (booleanp (evenp i))
  (integerp (/ i 2)))

#|
A3.
(defunc f3 (x)
  :input-contract (lorp x)
  :output-contract (natp (f3 x))
  (cond ((< (len x) 5) (f3 (cons 10 (app x x))))
        ((evenp (len x))  (f3 (cons (* 2 (first x)) x)))
        (t (+ (len x) (first x)))))
 
admissable,
(defunc m3 (x)
  :input-contract (lorp x)
  :output-contract (natp (m3 x))
  (cond ((< (len x) 5) (- 6 (len x)))
        ((evenp (len x))  1)
        (t 0)))
          
m3 obligations:
(and (lorp x) (< (len x) 5)) => (> (m3 x) (m3 (cons 10 (app x x))))
(and (lorp x) (not (< (len x) 5)) (evenp (len x))) => (> (m3 x) (m3 (cons (* 2 (first x)) x)))

Induction Scheme:  
(not (lorp x)) => phi
(and (lorp x) (< (len x) 5)  (phi[((x (cons 10 (app x x))))])) => phi
(and (lorp x) (not (< (len x) 5)) (evenp (len x)) (phi[((x (cons (* 2 (first x)) x)))])) => phi
(and (lorp x) (not (< (len x) 5)) (not (evenp (len x)))) => phi


|#

#|
A4. 
(defunc weave (x y)
  :input-contract (and (listp x)(listp y))
  :output-contract (listp (weave x y))
  (cond ((endp x) y)
        ((endp y) x)
        (t (cons (first x) 
                 (cons (first y)
                       (weave (rest x)(rest y)))))))

(Yes, we realize that weave is admissible. Give a measure, measure obligations 
and induction scheme just the same)

admissable,
(defunc m4 (x y)
  :input-contract (and (listp x)(listp y))
  :output-contract (natp (m4 x y))
  (+ (len x) (len y)))
 
m4 obligation:
(and (listp x)(listp y)(not (endp x))(not (endp y))) => (> (m4 x y) (m4 (rest x) (rest y)))
  
Induction Scheme:  
(not (and (listp x)(listp y))) => phi
(and (listp x)(listp y)(endp x)) => phi
(and (listp x)(listp y)(not (endp x))(endp y)) => phi
(and (listp x)(listp y)(not (endp x))(not (endp y))(phi[((x (rest x)(y (rest y)))])) => phi

|#

#|
A5.
(defunc f5 (l1 l2)
  :input-contract (and (lorp l1) (lonp l2))
  :output-contract (listp (f5 l1 l2))
  (cond ((endp l1) (list 1 2))
        ((endp l2) (f5 (cons 5 l1) (list 5)))
        ((>= (len l2) (len l1)) (f5 l2 (list l1)))
        (t (f5 (rest l1) (rest l2)))))

not admissable,
body contract violation (f5 l2 (list l1)), (not (lorp (list l1)))
        
Invalid Induction Scheme:
(not (and (lorp l1) (lonp l2))) => phi
(and (lorp l1) (lonp l2) (endp l1)) => phi
(and (lorp l1) (lonp l2) (not endp l1) (endp l2) (phi [(l1 (cons 5 l1)) (l2 (list 5))]) => phi
(and (lorp l1) (lonp l2) (not (endp l1)) (not (endp l2)) (>= (len l2) (len l1)) (phi | (l1 (list l1))) => phi
(and (lorp l1) (lonp l2) (not (endp l1)) (not (endp l2)) (not (>= (len l2) (len l1))) (phi | (l1 (rest l1)) (l2 (rest l2)))) => phi


|#
#|
A6.  Finally, prove that ssort should be admissible
by proving it terminates....and make sure the other 
admissibility conditions pass

(defunc ssort (l)
  :input-contract (lorp l)
  :output-contract (lorp (ssort l))
  (if (endp l)
    l
    (let ((min (min-l l)))
      (cons min (ssort (del min l))))))


....and as you might imagine based on HW10, this will
require lemmata. 
1) Write the measure function and  termination 
proof obligations.  Find what you need to prove.
2) Generalize the lemma so you know what happens
when something IN a list is DELeted from a list. What
happens to the size of the list?
3) How do you know (min-l l) is IN the list?....wait.
That sounds like a lemma too. See L3.
4) Finally, pull it all together to prove that the 
value of the measure function decreases with each 
recursive call (thus ssort terminates).  Your lemma 
will have something involving (del (min-l l) l))
The proof doesn't require induction provided you use
L3 (below) and 2) above.

-----------------------------------
Hopefully Helpful Theorems
Let's make the proof easier....or less annoying at least.
You can use the following theorem without proving it:

L3: (lorp l) /\ (consp l) => (in (min-l l) l)

(This is hint 3) from the list above by the way)
-----------------------------------

ssort is admissible because it passes function and body contracts and has no syntactic errors.
also termination, which is what we're proving

measure function for ssort
(defunc m-ssort (l)
  :input-contract (lorp l)
  :output-contract (natp (m-ssort l))
  (len l))
===================================  
termination proof obligation
(and (lorp l) (not (endp l))) => (m-ssort l) > (m-ssort (del (min-l l) l))

contexts
c1. lorp l
c2. not endp l

prove
(m-ssort l) > (m-ssort (del (min-l l) l))

def. m-ssort
(len l) > (len (del (min-l l) l))

{L-del-decreases-len, L3, c1}
qed for ssort termination
=================================================
proof for L-del-decreases-len
(implies (and (rationalp e) (lorp l) (in e l))
         (>(len l)(len (del e l))))
                          
IS for in
0. (not (listp l)) => phi
1. (and (listp l) (endp l)) => phi
2. (and (listp l) (not (endp l)) (equal e (first l))) => phi
3. (and (listp l) (not (equal e (first l))) (phi|(l rest l)) => phi
===================================
proof obligation 0.
contradiction in lhs of implies after exportation
qed for obligation 0
===================================
proof obligation 1.
contexts
c1. rationalp e
c2. lorp l
c3. in e l
...............
c4. not endp l {c3, endp, def. in, PL} ;; l has to be non-empty for an element to be in it

contradiction in base case is ok here because we know we hit the other base case

qed for obligation 1.
===================================                         
proof obligation 2                 
contexts
c1. rationalp e
c2. lorp l
c3. in e l
c4. not endp l
c5. (equal e (first l))

prove
(> (len l) (len (del e l)))

looking at rhs
(len (del e l))

def. del, c4, c5
(len (rest l))

decreasing len axiom
(len l) > (len (rest l))

qed for obligation 2
===================================
proof obligation 3
contexts
c1. rationalp e
c2. lorp l
c3. in e l
c4. not endp l
c5. (not (equal e (first l)))
c6. (implies (and (lorp (rest l)) (rationalp e) (in e (rest l)))
             (> (len (rest l)) (len (del e (rest l)))))

...........................
c7. lorp rest l {def. lorp, rest, c4}
c8. in e rest l {c3, c5}
c9. (> (len (rest l)) (len (del e (rest l)))) {MP, c7, c8, c2, c6}

prove 
(> (len l) (len (del e l)))                 

(> (len l) (len (del e l)))

def. del, c4, c5
(> (len l)
   (len (cons (first l) (del e (rest l)))))

def. len, cons, first-rest
(> (len l) (+ 1 (len (del e (rest l)))))

def. len, consp, c4
(> (+ 1 (len (rest l))) (+ 1 (len (del e (rest l)))))

arithmetic
(len (rest l)) > (len (del e (rest l)))
c9
qed for proof obligation 3
===================================
qed for lemma-del-decreases-len
================================================                 
|#
#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Section B: IN
 Next, let's do some proofs involving the function in
 and weave.

---------------------------------------------
Hopefully Helpful Theorems
You may assume the following theorems (or prove them
if you want the practice):

Phi_permReflect: (listp l) => (perm l l)

Assumption A1. (listp x) /\ (listp y)/\(listp z) /\ (in e y) =>
               (perm (cons e z) (app x y) = (perm z (app x (del e y)))

....in other words, even if e exists in list x, you can delete e from y
(provided it's in y) to see if z is a permutation of x and y minus element e.

---------------------------------------------

B1. Prove (listp x)/\ (listp y) => 
           (in e (app x y)) = ((in e x) \/ (in e y))
               
in induction scheme
(not (listp l)) => phi
(and (listp l) (endp l)) => phi
(and (listp l) (not (endp l)) (equal e (first l))) => phi
(and (listp l) (not (endp l)) (not (equal e (first l))) (phi[(l (rest l))])) => phi


First Obligation
c1. (not (and (listp l1) (listp l2)))

Prove
(and (listp x) (listp y)) => (in e (app x y)) = (or (in e x) (in e y))
{ c1, nil-then axiom }

QED


Second Obligation
c1. (listp x)
c2. (listp y)
c3. (endp x)

Prove
(in e (app x y)) = (or (in e x) (in e y))
{ Def app, c3 }
(in e y) = (or (in e x) (in e y))
{ Def in, c3}
(in e y) = (or nil (in e y))
{ PL }
(in e y) = (in e y)

QED


Third Obligation 
c1. (listp x)
c2. (listp y)
c3. (not (endp x))
c4. (equal (first x) e))


Prove
(in e (app x y)) = (or (in e x) (in e y))

{ Def app, c3}
(in e (cons (first x) (app (rest x) y))) = (or (in e x) (in e y))

{Def. in, c4, first-rest, cons}
t = (or (in e x) (in e y))

{def. in, c4, c3}
t = (or t (in e y))

{PL}
t = t
QED


Fourth Obligation
c1. (listp x)
c2. (listp y)
c3. (not (endp x))
c4. (not (equal (first x) e))
c5. (and (listp (rest x)) (listp y)) => (in e (app (rest x) y)) = (or (in e (rest x)) (in e y))
.............................
c6. (listp (rest x)) {first-rest, listp, c3}
c7. (in e (app (rest x) y)) = (or (in e (rest x)) (in e y)) {MP, c2, c5, c4}


Prove
(in e (app x y)) = (or (in e x) (in e y))

{ Def app, c3}
(in e (cons (first x) (app (rest x) y))) = (or (in e x) (in e y))

{Def. in, c3, c4, first-rest, cons}
(in e (app (rest x) y)) = (or (in e x) (in e y))

{Def. in, c3, c4}
(in e (app (rest x) y)) = (or (in e (rest x)) (in e y))

c7
(in e (app (rest x) y)) = (in e (app (rest x) y))
QED

EXTRA QUESTION (no points and purely optional): B1 can be used to prove the following
B1b: (listp x)/\(listp y) => ((in e (app x y)) = (in e x) \/ (in e y))

How can you use B1 to prove this? and what other conjectures do you need 
to prove to get the equality (or iff)?  Prove B1b for extra practice.  
You can write B1b and the related theorems on your cheat sheet for 
the exam if you want.

##..............


B2. Prove (listp x)/\ (listp y) => 
           (in e (weave x y)) = ((in e x) \/ (in e y))

##

IS for weave
1. not (and (listp x) (listp y))) => phi
2. (and (listp x) (listp y) (endp x)) => phi
3. (and (listp x) (listp y) (not(endp x)) (endp y)) => phi
4. (and (listp x) (listp y) (not(endp x)) (not (endp y)) (phi | (x (rest x)) (y (rest y)) => phi

==========================================
proof obligation 1. 
c1. not (and listp x listp y)
c2. listp x
c3. listp y
....
c4 nil {c1, c2, c3, PL}
nil => any = t
qed for obligation 1
==========================================
proof obligation 2.
c1. listp x
c2. listp y
c3. endp x

prove 
(in e (weave x y)) = ((in e x) \/ (in e y))

c3, def. in
(in e (weave x y)) = (nil \/ (in e y))

PL
(in e (weave x y)) = (in e y)

def. weave, c3
(in e y) = (in e y)
qed for obligation 2
==========================================
proof obligation 3.
c1. listp x
c2. listp y
c3. not endp x
c4. endp y

prove 
(in e (weave x y)) = ((in e x) \/ (in e y))

c4, def. in
(in e (weave x y)) = (((in e x) \/ nil))

PL
(in e (weave x y)) = (in e x)

def. weave, c3, c4
(in e y) = (in e y)
qed for obligation 3
==========================================
obligation 4
c1. listp x
c2. listp y
c3. not endp x
c4. not endp y
c5. (implies (and (listp (rest x)) (listp (rest y)))
             (equal (in e (weave (rest x) (rest y)))
                                (or (in e (rest x)) (in e (rest y)))))
........................
c6. listp rest x {listp, rest, c1, c3}
c7. listp rest y {listp, rest, c2, c4}
c8. (equal (in e (weave (rest x) (rest y)))
                   (or (in e (rest x)) (in e (rest y))))) {c6, c7, c5, MP}


prove 
(in e (weave x y)) = ((in e x) \/ (in e y))

proof by cases
========================
case 1: first x = e

def. in, case 1, c3
(in e (weave x y)) = (t \/ (in e y))

pl
(in e (weave x y)) = t

def. weave, c3, c4
(in e (cons (first x) (cons (first y) (weave (rest x) (rest y))))) = t

first-rest, def. in, case 1
t = t
qed for case 1
========================
case 2: 
c8. (not (equal (first x) e))
c9. (equal (first y) e)

def. in, c9, PL
(in e (weave x y)) = t

def. weave, c3, c4
(in e (cons (first x) (cons (first y) (weave (rest x) (rest y))))) = t

def. in, c8, cons, first-rest
(in e (cons (first y) (weave (rest x) (rest y)))) = t

c9, def. in, consp
t = t
qed for case 2
========================
case 3:
c8. (not (equal (first x) e))
c9. (not (equal (first y) e))

def. in, c8, c9, c3, c4
(in e (weave x y)) = (or (in e (rest x)) (in e (rest y)))

def. weave, c3, c4
(in e (cons (first x) (cons (first y) (weave (rest x) (rest y))))) =
(or (in e (rest x)) (in e (rest y)))

c8, def. in, cons, first-rest
(in e (cons (first y) (weave (rest x) (rest y)))) =
(or (in e (rest x)) (in e (rest y)))

c9, def. in, cons, first-rest
(in e (weave (rest x) (rest y))) = 
(or (in e (rest x)) (in e (rest y)))

c7
(in e (weave (rest x) (rest y))) =
(in e (weave (rest x) (rest y)))

qed for case 3
========================
qed for obligation 4
==========================================
qed for b2
=============================================================

EXTRA (no points): prove 
Phi_permWA: (listp x)/\(listp y) =>(perm (weave x y)(app x y)) 
using the induction scheme for weave.

##..............

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Section C: Tail Recursion I
Let's revisit some functions from the sample exam.
|#

;; add-to-all: nat x LON -> LON
;; (add-to-all n l) takes a natural number n and
;; a list of natural numbers l and adds n to each element of l:
(defunc add-to-all (n l)
  :input-contract (and (natp n) (lonp l))
  :output-contract (lonp (add-to-all n l))
  (if (endp l)
    ()
    (cons (+ (first l) n) (add-to-all n (rest l)))))

(check= (add-to-all 1 '(1 2 3)) '(2 3 4))

;; find: All x List -> LON
;; (find x l) returns the indexes of each occurence of
;; x in list l.  Thus the returned value is a list of natural numbers
(defunc find (x l)
  :input-contract (listp l)
  :output-contract (lonp (find x l))
  (cond ((endp l) ())
        ((equal (first l) x) (cons 0 (add-to-all 1 (find x (rest l)))))
        (t                           (add-to-all 1 (find x (rest l))))))

(check= (find 1 '(1 2 3 2 1)) '(0 4)) ; find counting starts from 0


#|
a)  Now define a tail-recursive version find-t of find.

Hint: the tail-recursive function find-t walks through the input list
from left to right. Suppose you see an occurrence of x. In order to know
what its index is in the *original* list, you have to keep track of the
number of elements already processed. Function find-t should thus have
an extra argument, say c, for that purpose:
|#
(defunc find-t (x l acc c)
    :input-contract (and (listp l) (lonp acc) (natp c))
    :output-contract (lonp (find-t x l acc c))
    (cond ((endp l) acc)
          ((equal (first l) x) (find-t x (rest l) (cons c acc) (+ c 1)))
          (t                   (find-t x (rest l) acc (+ c 1)))))
#|
(c) We define below a non-recursive function find* that uses find-t to
compute the same value as find. Note that we need to initialize both c 
and acc properly.
|#
(defunc find* (x l)
    :input-contract (listp l)
    :output-contract (lonp (find* x l))
    (rev (find-t x l '() 0)))

;; lemma1 test
(test? (implies (and (listp l) (lonp acc) (natp c))
         (equal (find-t x l acc c) (app (rev (add-to-all c (find x l))) acc))))

(test? (implies (not (consp l)) (not (listp l))))
#|
(d) Write a lemma that relates find-t and find.

Hint: this requires some thought. Evaluate find-t on some examples to
figure out what it should be. The lemma will involve several functions other
than find-t and find. Remember add-to-all. There should be no
constants anywhere in your lemma.

HINT: Use test? to sanity-check your lemma.

l1: (and (listp l) (lonp acc) (natp c)) => (find-t x l acc c) = (app (rev (add-to-all c (find x l))) acc)

test? above

(e) Assuming the lemma is true, prove that find* and find compute
the same function:

(listp l) => (find* x l) = (find x l)
===============================================================================
proof for find* = find
contexts
c1. (listp l) 

Prove
(find* x l) = (find x l)
{ Def find*, PL }
(rev (find-t x l '() 0)) = (find x l)
{l1}
(rev (app (rev (add-to-all 0 (find x l))) nil) = (find x l)
{phi-app-nil}
(rev (rev (add-to-all 0 (find x l))) = (find x l)
{phi-rev-rev}
(add-to-all 0 (find x l)) = (find x l)
{lemma-add-0-to-all (see below)}
(find x l) = (find x l)

QED for find* = find
===============================================================================
lemma-add-0-to-all
(implies (lonp x) (equal (add-to-all 0 x) x))

IS for listp
1. (endp l)) => phi
2. (and (not (endp l)) (phi|(l (rest l))))) => phi
======================================================
proof obligation 1 for lemma-add-0-to-all
c1. lonp x 
c2. endp x

prove
(equal (add-to-all 0 x) x)

def. add-to-all, c2
(equal  nil x)

c2, def. endp
(equal nil nil)
qed for obligation 1 
======================================================
proof obligation 2 for lemma-add-0-to-all
c1. lonp x
c2. not endp x
c3. (implies (lonp (rest x)) (equal (add-to-all 0 (rest x)) (rest x)))
..............
c4. (lonp (rest x)) {c1, rest, c2, def. lonp}
c5. (equal (add-to-all 0 (rest x)) (rest x))) {MP, c4, c3}

prove
(equal (add-to-all 0 x) x)

def. add-to-all, c2
(equal (cons (+ (first x) 0) (add-to-all 0 (rest x))) x)

arithmetic
(equal (cons (first x) (add-to-all 0 (rest x))) x)

c6
(equal (cons (first x) (rest x)) x)

cons-first-rest
QED for lemma-add-0-to-all obligation 2
======================================================
QED for lemma-add-0-to-all
===============================================================================
(f) Prove the lemma in (d).

In proving the lemma, you can assume the following:

(natp a) /\ (lonp l) => (lonp (cons a l)) (we typically say "Def of lon" but
it's OK to be more specific like this from time to time)

In addition, during the proof you will need several lemmas that we have
proven before, and maybe some that are new.

(and (listp l) (lonp acc) (natp c)) => (find-t x l acc c) = (app (rev (add-to-all c (find x l))) acc)

find-t Induction Scheme:
1. (not (and (listp l) (lonp acc) (natp c))) => phi
2. (and (listp l) (lonp acc) (natp c) (endp l)) => phi
3. (and (listp l) (lonp acc) (natp c) (not (endp l)) (equal (first l) x) 
     phi[((l (rest l)) (acc (cons c acc)) (c (+ c 1)))]) => phi
4. (and (listp l) (lonp acc) (natp c) (not (endp l)) (not (equal (first l) x)) 
     phi[((l (rest l)) (c (+ c 1)))]) => phi
=============================
 First Obligation
 c1. (not (and (listp l) (lonp acc) (natp c)))
 c2. listp l
 c3. lonp acc
 c4. natp c
 ..............
 c5. nil {c1, c2, c3, c4, PL}
 
 nil => any == t
 qed for first obligation 
 
============================= 
 Second Obligation
 c1. (listp l)
 c2. (lonp acc)
 c3. (natp c)
 c4. (endp l)

 Prove 
 (find-t x l acc c) = (app (rev (add-to-all c (find x l))) acc)
 { Def find-t, c4 }
 acc = (app (rev (add-to-all c (find x l))) acc)
 { Def find, c4 }
 acc = (app (rev (add-to-all c '())) acc)
 { Def add-to-all }
 acc = (app (rev '()) acc)
 { Def rev }
  acc = (app '() acc)
 { app nil axiom }

 QED
 =============================
 Third Obligation
 c1. (listp l)
 c2. (lonp acc)
 c3. (natp c)
 c4. (not (endp l))
 c5. (equal (first l) x) 
 c6. (and (listp (rest l)) (lonp (cons c acc)) (natp (+ c 1)))
        => (find-t x (rest l) (cons c acc) (+ c 1))
           = (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc))
 ...................................
 c7. listp (rest l){c1, c4, rest, listp}
 c8. lonp (cons c acc) {c2, c3, hint from above akak def. lonp}
 c9. (natp (+ c 1)) {arithmetic, def. natp}
 c10. (find-t x (rest l) (cons c acc) (+ c 1)) = (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc))
 
 Prove
(find-t x l acc c) = (app (rev (add-to-all c (find x l))) acc)
 
def. find-t, c4, c5
(find-t x (rest l) (cons c acc) (+ c 1))) = (app (rev (add-to-all c (find x l))) acc)
 
 c10
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc)) = 
 (app (rev (add-to-all c (find x l))) acc)
 
 def. find, c4, c5
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc)) = 
 (app (rev (add-to-all c (cons 0 (add-to-all 1 (find x (rest l)))))) acc)
 
 def. add-to-all, arithmetic, cons
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc)) = 
 (app (rev (cons c (add-to-all c  (add-to-all 1 (find x (rest l)))))) acc)
 
 lemma-add-both-to-all
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc)) = 
 (app (rev (cons c (add-to-all (+ c 1) (find x (rest l))))) acc)
 
 def. rev, cons, endp, first-rest
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc)) = 
 (app (app (rev (add-to-all (+ c 1) (find x (rest l)))) (list c)) acc)
 
 assoc. app
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc)) = 
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (app (list c) acc))
 
 def. app, list, consp, endp
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc)) = 
 (app (rev (add-to-all (+ c 1) (find x (rest l)))) (cons c acc))
 
 qed

 
(g) Prove any new lemmas used in (f).
(if there are any)
##
new lemmata: 
add-0-to-all (proven in e)

proof for add-both-to-all                            
(implies (and (listp x) (natp n1) (natp n2))
         (equal (add-to-all n1 (add-to-all n2 x))
                        (add-to-all (+ n1 n2) x)))
                                
IS for listp
1. endp x => phi
2. not endp x /\ phi|x rest x => phi                                


proof obligation 1
c1. lonp x
c2. natp n1
c3. natp n2
c4. endp x

prove 
(equal (add-to-all n1 (add-to-all n2 x))
                        (add-to-all (+ n1 n2) x)))
                                
def. add-to-all, c4
(equal nil nil)
qed for obligation 1                                

proof obligation 2
c1. lonp x
c2. natp n1
c3. natp n2
c4. not endp x
c5. (implies (and (lonp (rest x)) (natp n1) (natp n2))
             (equal (add-to-all n1 (add-to-all n2 (rest x)))
                            (add-to-all (+ n1 n2) (rest x))))
..........
c6. lonp rest x {lonp, c4, rest}
c7. (equal (add-to-all n1 (add-to-all n2 (rest x)))
                   (add-to-all (+ n1 n2) (rest x))) {MP, c5, c6, c2, c3}

prove
(equal (add-to-all n1 (add-to-all n2 x))
           (add-to-all (+ n1 n2) x)))                   
           
def. add-to-all, c4
(equal (add-to-all n1 (cons (+ n2 (first x))(add-to-all n2 (rest x))))
           (add-to-all (+ n1 n2) x))                   

def. add-to-all, cons, endp, first-rest
(equal (cons (+ n1 (+ n2 (first x))) (add-to-all n1 (add-to-all n2 (rest x))))
           (add-to-all (+ n1 n2) x))                   
           
c7
(equal (cons (+ n1 (+ n2 (first x))) (add-to-all (+ n1 n2) (rest x)))
           (add-to-all (+ n1 n2) x))

def. add-to-all, c4
(equal (cons (+ n1 (+ n2 (first x))) (add-to-all (+ n1 n2) (rest x)))
           (cons (+ (+ n1 n2) (first x)) (add-to-all (+ n1 n2) (rest x)))
           
arithmethic           
(equal (cons (+ n1 (+ n2 (first x))) (add-to-all (+ n1 n2) (rest x)))           
       (cons (+ n1 (+ n2 (first x))) (add-to-all (+ n1 n2) (rest x)))
           
qed for obligation 2           
|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Section D: Tail Recursion II: Revenge of Weave
 
 a) Remember weave?  I told you we would keep using the same
 function for these proofs. Write a tail recursive
 version of weave (weave-t) and a wrapper function weave*
 Keep in mind the order that (first x) and (first y) are being
 added to acc.
 
 (defunc weave (x y)
  :input-contract (and (listp x)(listp y))
  :output-contract (listp (weave x y))
  (cond ((endp x) y)
        ((endp y) x)
        (t (cons (first x) 
                 (cons (first y)
                       (weave (rest x)(rest y)))))))
|#

 (list 0)
 (list 0)
 
 
 (defunc weave-t (x y acc)
  :input-contract (and (listp x) (listp y) (listp acc))
  :output-contract (listp (weave-t x y acc))
  (cond ((endp x) (app y acc))
        ((endp y) (app x acc))
        (t (weave-t (rest x) (rest y) (cons (first x) (cons (first y) acc))))))
 
 (defunc weave* (x y)
    :input-contract (and (listp x) (listp y))
    :output-contract (listp (weave* x y))
    (rev (weave-t x y '())))
 
 ; test L1
 (test? (implies (and (listp x) (listp y) (listp acc)) (equal (rev (weave-t x y nil)) (app (weave x y) nil))))


 #|
 b) Now prove that weave* = weave. You should do all the steps we outlined
 in our tail recursive proof recipe.
 ##..............

 |#
 
 #|
 Extra Practice: Write a tail recursive version of isort
 (don't get fancy by calling max-l instead of min-l.  Just reverse
 the sorted list at the end)
 The solution won't be provided but it's still a good exercise
 ##.......................

 |#
 
 
#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
E. A Heap of Work (no points BUT abstract data types
can potentially appear on the exam. This tests the concept
at a greater difficulty than the exam)

Consider the binary heap data definition above.

A heap is a semi-ordered tree-based data structure such that the "top" or root node of 
a heap is the smallest element in the structure.  This is considered a min heap.  A max heap 
(not discussed here) has the largest value as the root node. A binary heap is a binary tree 
such that the value of the two children of any given node must be larger than the parent's 
value.  Hence a heap may look like this.
    3
 5     6
7 8   7 9

Calling pop on this heap gives the following
    5 
 7     6
  8   7 9

Popping again gives:
    6
 7     7
  8     9
  
Inserting the value 5 results in the following structure:
    6
 7     7
5 8     9

And then a series of operations which bubble the 5 up to the appropriate point
    5
 6     7
7 8     9

For more information on heaps see: https://en.wikipedia.org/wiki/Heap_(data_structure)

We will consider the following functions:
Insert: adds a value to the heap. The position of the value within the heap will vary
depending on the implementation
emptyp: Returns a boolean whether a heap is empty or not.
Pop: Remove the root node of the heap and adjust the heap accordingly.

E1.
What other basic functions should a heap have if implemented in ACL2s? Only write functions 
that cannot be created by a series of other basic functions.  

For example, function "heap-size" which returns the number of values in the heap 
would not be acceptable because it can be written  as a series of pop operations until 
the heap is empty.

* Give at least 2 "independent functions" that cannot be defined in terms of insert, emptyp,
or pop.
* You do not need to write the functions and your answers should be relatively simple but 
you need to clearly identify what the function does (like the the functions listed above).
* Feel free to implement the functions if you want to. Your answer will be a lot more 
obvious in such a case.
......................

|#

(defdata BinHeap
  (oneof nil
         (list rational BinHeap BinHeap)))

;; These functions can be difficult to admit so we will not
;; admit them in logic mode.  Your properties in G2 also don't need
;; to be proven as theorems.
:program

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; new-node: Rational x BinHeap x BinHeap -> BinHeap
;; (newnode v c1 c2) is a helper function
;; that makes a heap node with v as the value
;; and c1 and c2 as child nodes.
(defunc new-node (v c1 c2)
  :input-contract (and (rationalp v)(BinHeapp c1)(BinHeapp c2))
  :output-contract (BinHeapp (new-node v c1 c2))
  (list v c1 c2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emptyp: BinHeap -> Boolean
;; (emptyp h) takse a heap h and returns
;; true if it is empty (has no values)
(defunc emptyp (h)
  :input-contract (BinHeapp h)
  :output-contract (booleanp (emptyp h))
  (equal h nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; heap-size: BinHeap -> Nat
;; (heap-size h) takes a heap h and returns
;; the number of values in it. An empty heap
;; returns 0.
(defunc heap-size (h)
  :input-contract (BinHeapp h)
  :output-contract (natp (heap-size h))
  (if (emptyp h)
    0
    (+ 1 (+ (heap-size (second h))
            (heap-size (third h))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; balance: BinHeap -> BinHeap
;; (balance par) takes a "parent" heap node par 
;; and swaps parent and child values if a child
;; node value is less than the parent's value
;; This works under the assumption that before 
;; insertion the heap is well formed. Thus at MOST 
;; one child can have a smaller value than the parent node.
(defunc balance (par)
  :input-contract (BinHeapp par)
  :output-contract (BinHeapp (balance par))
  (if (emptyp par)  
    par
    (let ((c1 (second par))
          (c2 (third par)))
      (cond ((and (not (emptyp c1))(< (first c1)(first par)))
             (new-node (first c1) 
                       (new-node (first par)(second c1)(third c1))
                       c2))
            ((and (not (emptyp c2))(< (first c2)(first par)))
             (new-node (first c2)  c1
                       (new-node (first par)(second c2)(third c2))))
            (t  par)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert: Rational x BinHeap -> BinHeap
;; (insert r h) inserts r at the shallowest
;; branch of the heap and then rebalances the heap
;; up to the root node to ensure the heap structure
;; maintained.
(defunc insert (r h)
  :input-contract (and (rationalp r)(BinHeapp h))
  :output-contract (BinHeapp (insert r h))
  (if (emptyp h)
    (list r nil nil)
    (let ((lDepth (heap-size (second h)))
          (rDepth (heap-size (third h))))
      (if (<= lDepth rDepth)
        (balance (new-node (first h) (insert r (second h)) (third h)))
        (balance (new-node (first h) (second h) (insert r (third h))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pop: BinHeap -> BinHeap
;; (pop h) removes the root element of the heap 
;; (the min value in the heap),  fixes the structure
;; and then returns the revised heap.
(defunc pop (h)
  :input-contract (BinHeapp h)
  :output-contract (BinHeapp (pop h))
  (cond ((emptyp h)  h)
        ((and (emptyp (second h))(emptyp (third h))) nil)
        ((emptyp (second h)) (third h))
        ((emptyp (third h)) (second h))
        ((< (first (second h))(first (third h))) 
         (list (first (second h)) (pop (second h))(third h)))
        (t  (list (first (third h)) (second h)(pop (third h))))))

;; Valid-heapp and valid-node are not strictly needed for heap definitions but it can help
;; with your testing.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; valid-nodep: BinHeap -> Boolean
;; (valid-nodep h) checks if the value of h is less than
;; or equal to the value of any child nodes.
(defunc valid-nodep (h)
  :input-contract (BinHeapp h)
  :output-contract (booleanp (valid-nodep h))
  (cond ((emptyp h) t)
        ((and (emptyp (second h))(emptyp (third h))) t)
        ((emptyp (second h)) (<= (first h)(first (third h))))
        ((emptyp (third h))  (<= (first h)(first (second h))))
        (t (and (<= (first h)(first (second h)))
                (<= (first h)(first (third h)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; valid-heapp: All -> Boolean
;; (valid-heapp h) traverses a heap h to confirm that
;; all child node values are strictly greater than the 
;; parent node values. If h is not a heap than return nil.
(defunc valid-heapp (h)
  :input-contract t
  :output-contract (booleanp (valid-heapp h))
  (if (not (BinHeapp h))
    nil    
    (if (emptyp h)
      t
      (if (valid-nodep h)
        (and (valid-heapp (second h))
             (valid-heapp (third h)))
        nil))))
  
  (defconst *test-heap* (insert 6 (insert 1 (insert 4 (insert 2 nil)))))
  (check= (valid-heapp *test-heap*) t)
  (check= (valid-heapp (pop *test-heap*)) t)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; E1.
##.............. ADD OTHER FUNCTIONS

#|
E2.
 Above you can see an implementation of insert, emptyp and pop. For anyone who has 
 implemented a heap before, you'll notice how inefficient this implementation is. 
 In a language like Java, an array can be used and the place to insert the next 
 value is relatively fast. This begs the question: what guarantees does any heap 
 implementation need?
 * Write at least 2 more properties of a min heap that all implementations
   MUST pass. You can include the functions you described in G1.
 * Properties should be independent. A way to show this is to change the implementation
   of the functions and observe only the one property is no longer satisfied. We did
   this for properties of stacks in the lecture.
 * Properties should be written as a ACL2s theorem definition OR as a test?. 
   -If you want to test your functions (if you implemented code for G1), you can write
   test? to test if your properties are likely correct.  
   - If you simply wrote a function description, write the theorem as a comment.
 * See Chapter 8 of the lecture notes for more information about abstract data types
   and independent properties.
   
|#

;; Here are a couple properties
(test? (implies (and (rationalp r)(BinHeapp h)(emptyp h)) 
                (emptyp (pop (insert r h)))))

##..............

#| Good luck on the exam everyone. |#
