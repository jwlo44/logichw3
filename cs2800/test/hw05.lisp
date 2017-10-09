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
CS 2800 Homework 5 - Fall 2017

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


Names of ALL group members: FirstName1 LastName1, FirstName2 LastName2, ...

Dylan Wight, Julia Wlochowski

Note: There will be a 10 pt penalty if your names do not follow 
this format.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw05.lisp

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
  can see what the syntax is. This isn't a big deal for this assignment.  Most
  work will be done in comments.

- when done, save your file and submit it as hw05.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file!
|#
#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Section 1: SUBSTITUTIONS

Below you are given a set of ACL2s terms and substitutions. Recall
that a substitution is a list of pairs, where the first
element of each pair is a variable and the second an
expression. Also, variables can appear only once as a left
element of a pair in any substitution. For example, the
substitution ((y (cons a b)) (x m)) maps y to (cons a b) and x to
m. 

For each term/substitution pair below, show what you get when
you apply the substitution to the term (i.e., when you
instantiate the term using the given substitution).  
If the substitution is syntactically invalid (not allowed), indicate why.
Note: you do not need to evaluate the returned expression.

Example.  (foo (bar x y) z)
          ((x (list 3))(y (cons 'l nil))(z (+ 1 2)))
          *(foo (bar (list 3) (cons 'l nil)) (+ 1 2))
(The * simply indicates the answer line)

In class we wrote this as 
(foo (bar x y) z)| ((x (list 3))(y (cons 'l nil))(z (+ 1 2))) but
the two line format will make it easier for you to read.
          
a. (rev2 (cons (app w y) z))|
   ((w (app b c)) (y (list a b)) (z (rev2 a)))
   *(rev2 (cons (app (app b c) (list a b)) (rev2 a)))
   
b. (cons 'c d)|
   ((c (cons a (list d))) (d (cons c nil)))
   *(cons 'c (cons c nil))
   
c. (* (+ x (/ y (len z))) (+ (len z) y))
   ((x (+ a b)) (y (/ a b)) (z '(3 4)))
   *(* (+ (+ a b) (/ (/ a b) (+ (len '(3 4)))) (/ a b)))

d. (or (endp u) (listp (app u w)))
   ((u w) (w (list (first x))) )
   *(or (endp w) (lisp (app w (list (first x)))))

e. (equal (+ (+ (len x) (len y)) (len z)) (len (cons 'z (app 'x y))))
   ((x '(5 6)) (y '(2 8)) (z '(17 3)))
   *(equal (+ (+ (len '(5 6)) (len (2 8))) (len '(17 3))) (len (cons 'z (app 'x (2 8)))))

f. (cons u (app u w))|
   ((u (app w w))(w (app b a)) (w (app c d)))
   *Invalid, not allowed to have two  w on hte lst side of subsitutions 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Section 2: Finding a substitution, if it exists.

For each pair of ACL2 terms, give a substitution that instantiates the 
first to the second. If no substitution exists write "None".
Example: (app l m)
         (app (cons 3 nil) nil)
        *((l (cons 3 nil))(m nil))
Again the * is just used to indicate the solution line.

a. (app (list a) (rev2 b))
   (app (list (cons (list (first x)) x)) (rev2 (cons z (len2 (rest x)))))
   *((a (cons (list (first x)) x)) (b (cons z (len2 (rest x)))))

b. (and (< (/ z w) (- x (+ x 2))) (> z x))
   (and (< (/ (unary-- (+ (- 5 6) 7)) x) (- (* x x) (+ (* x x) 2))) (> (unary-- (+ (- 5 6) 7)) (* x x)))
   *((z (unary-- (+ (- 5 6) 7))) (w x) (x (* x x)))

c. (app y z)
   (list 9 z)
   *None

d. (in x y)
   (in y (app x)) 
   *((x y) (y (app x)))
   
e. (app 'a (app b '(1 2 3)))
   (app x (app y '(1 2 3)))
   *None

f. (app (list a b) a)
   (app (list c d) (cons c nil)))
   *None
  
g. (app a (app (cons b c) b))
   (app '(1 2) (app (cons (cons b c) d) (cons b c)))
   *((a '(1 2)) (b (cons b c)) (c d))



#|=================================== 
Useful function definitions used later
=====================================
|#

;; listp is built in but for this assignment, assume it 
;; is defined this way
(defunc listp (l)
  :input-contract t
  :output-contract (booleanp (listp l))
  (if (consp l)
     (listp (rest l))
     (equal l nil)))
    
(defunc endp (l)
  :input-contract (listp l)
  :output-contract (booleanp (endp l))
  (if (consp l) nil t))
  
(defunc len (x)
  :input-contract (listp x)
  :output-contract (natp (len x))
  (if (endp x)
    0
    (+ 1 (len (rest x)))))

(defunc delete (e l)
  :input-contract (listp l)
  :output-contract (listp (delete e l))
  (if (endp l)
    nil
    (if (equal e (first l))
      (rest l)
      (cons (first l)(delete e (rest l))))))

(defunc in (a l)
  :input-contract (listp l)
  :output-contract (booleanp (in a l))
  (if (endp l)
    nil
    (or (equal a (first l)) (in a (rest l)))))

(defunc rev (x)
  :input-contract (listp x)
  :output-contract (listp (rev x))
  (if (endp x)
    x
    (app (rev (rest x))(list (first x)))))
     

(defdata lor (listof rational))

(defunc min-l (lr)
  :input-contract (and (lorp lr)(consp lr))
  :output-contract (rationalp (min-l lr))
  (if (endp (rest lr))
    (first lr)
    (if (< (first lr) (min-l (rest lr)))
        (first lr)
        (min-l (rest lr)))))
        
;; duplicate: List -> List
;; repeats each element in the given list once
(defunc duplicate (l)
  :input-contract (listp l)
  :output-contract (listp (duplicate l))
  (if (endp l)
    nil
    (cons (first l) (cons (first l) (duplicate (rest l))))))
 
NOTE: I'm removing the let in the definition of min-l to 
make using the body more obvious but a let would be equivalent.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SECTION 3: Theorem instantiation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
For each definitional axiom or provided theorem, write the theorem then write 
the substitution used to instante the theorem. Recall the substitution is symbol 
manipulation while instantiation is a proof technique showing that replacing 
variables in a theorem results in a theorem. You can assume the theorems provided
are actually theorems.

EX: For a call to (app nil l) substitute nil and l in the definitional axiom of app.
    (implies (and (listp x)(listp y))
             (equal (app x y)(if (endp x) y (cons (first x)(app (rest x) y)))))
    = {Def of app|((x nil)(y l))}
    (implies (and (listp nil)(listp l))
             (equal (app nil l) (if (endp nil) l (cons (first nil)(app (rest nil) l)))))
    
    Notice the above definitional axiom for app has the input contract for app as it's left hand side.
    This needs to be included in an instantiation.  Think about why that is.

3a. Theorem phi_rev-rev is (implies (listp x)(equal (rev (rev x)) x))
    Instantiate phi_rev-rev with (app x y).
    = {Theorem of phi_rev-rev|((x (app x y)))}
    (implies (list (app x y))(equal (rev (rev (app x y))) (app x y)))

3b. Theorem phi_rev-rev is (implies (listp x)(equal (rev (rev x)) x))
    Instantiate phi_rev-rev with 4 for x. Is this a theorem?  Why?
    (this is not a retorical question)
     = {Theorem of phi_rev-rev|((x 4))}
      (implies (listp 4)(equal (rev (rev 4)) 4))
      
      I would describe it as a corollary not a therem, because it is a statement that relies on the 
      theorem to be true.

3c. Theorem phi_min-newmin (discussed in class) is: 
    (implies (and (lorp lr)(consp lr))
             (equal (- (min-l lr) 1)(min-l (cons (- (min-l lr) 1) lr))))
    Instantiate phi_min-newmin with a list '(3 2 1)
    = {Theorem of phi_min-newmin|((lr '(3 2 1)))}
    (implies (and (lorp '(3 2 1))(consp '(3 2 1)))
             (equal (- (min-l '(3 2 1)) 1)(min-l (cons (- (min-l '(3 2 1)) 1) '(3 2 1)))))
    
3d. Instantiate the definitional axiom of delete with the element 'a being deleted from
    list '(1 3 a c):
    = {Def of delete|((e 'a)(l '(1 3 a c)))}
    (implies (listp '(1 3 a c))
             (if (endp '(1 3 a c))
               nil
               (if (equal 'a (first '(1 3 a c)))
                 (rest '(1 3 a c))
                 (cons (first '(1 3 a c))(delete 'a (rest '(1 3 a c)))))))
    
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SECTION 4: INTRODUCTION TO EQUATIONAL REASONING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

Questions in section 4 ask for equational proofs about ACL2s

The definitional axioms (input contract => (function call = function body))
and contract theorems (input contract => output contract) for defined 
functions can be used in the proof. 

You can use ACL2s to check the conjectures you come up with, but you are 
not required to do so. 

Here are some notes about equational proofs although additional information
can be found in the course notes 
(http://www.ccs.neu.edu/course/cs2800f17/rapeq.pdf). Remember the key
consideration when grading your proofs will be how well you communicate 
your ideas and justifications:

1. The context. Remember to use propositional logic to rewrite
the context so that it has as many hypotheses as possible.  See
the lecture notes for details. Label the facts in your
context with C1, C2, ... as in the lecture notes.

2. The derived context: Draw a dashed line (----) after the context 
and add anything interesting that can be derived from the context.  
Use the same labeling scheme as was used in the context. Each derived
fact needs a justification. Again, look at the lecture notes for
more information.

3. Use the proof format shown in class and in the lecture notes,
which requires that you justify each step.

4. When using an axiom, theorem or lemma, show the name of the
axiom, theorem or lemma and then *show the substitution* you are
using for any definitional axiom, or theorem IF a substitution 
actually occurs  (no need to write (n n) for example).  
Ex. Using the definitional axiom for app to conclude (app nil l) = l
you would write {Def. app|((x nil)(y l)), if axioms}

5. When using the definitional axiom of a function, the
justification should say "Def. <function-name>".  When using the
contract theorem of a function, the justification should say
"Contract <function-name>".

6. Arithmetic facts such as commutativity of addition can be
used. The name for such facts is "arithmetic".

7. You can refer to the axioms for cons, and consp as the "cons axioms", 
Axioms for first and rest can be referred to as "first-rest axioms".
The axioms for if are named "if axioms"

8. Any propositional reasoning used can be justified by "propositional
reasoning", "Prop logic", or "PL" except you should use "MP" 
to explicitly identify when you use modus ponens.

9. For this homework, you can only use theorems we explicitly
tell you you can use or we have covered in class / lab. 
You can, of course, use the definitional axiom and contract 
theorem for any function used or defined in this homework. You
may also use theorems you've proven earlier in the homework.
The definitions used for the remainder of the questions are listed
above.

10. For any given propositional expression, feel free to re-write it
in infix notation (ex a =>(B/\C)). You do not need to justify this.

11. To make your life easier, you can combine the use of if axioms, justifications
for taking a branch, and definitional axioms in one step.
     (app nil l) 
   = {Def. app|((x nil)(y l)), if axioms, Def. of endp}
     l
  This should make for far less typing.  The key point: IT SHOULD BE OBVIOUS WHAT
  YOU ARE DOING.  Combining too many steps makes it hard to follow your work and your
  grade will suffer as a result. Clear or "obvious" steps can be combined.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


For each of the conjectures in section 4:

- perform conjecture contract checking, and add hypotheses if necessary. 
  Contract completion is adding the minimal set of hypotheses to guarantee 
  input contracts for all functions used in the conjecture are satisfied 
  when the hypotheses are satisfied. Do not add anything else to the 
  conjecture.

- run some tests to make an educated guess as to whether the conjecture is
  true or false. 
    - Not all conjectures are valid.
    - For falsifiable expressions, give a counterexample and show that 
    it evaluates to false. 
    - For theorems, give a proof using equational reasoning, following 
    instructions 1 to 11 above. 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
4a. Phi_rev_del: (rev (delete e (rev x))) = (delete e x)
You can assume theorem phi_rev_rev: (implies (listp x)(equal x (rev (rev x))))
..................



4b. Phi_in_cons: (in e (cons e (delete e l)))

.............


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

4c. Phi_lendel: (len (delete e (cons e l)) = (len l)

.............


4d. Phi_del_min: (implies (and (lorp lr)(consp lr))(> (min-l (delete (min-l lr) lr)) (min-l lr)))
or in other words, if you remove the minimum element in the list, the new minimum is larger

...........

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
4e. (implies (equal (in a (rest l))
                    (in a (duplicate (rest l))))
             (equal (in a l)
                    (in a (duplicate l))))

 .............
|#



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Feedback (10 points)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

We want to gather feedback about how the course is going
so we can improve your learning experience. After all, if
we only get feedback in the TRACE evaluations this won't help
you; just subsequent classes.

Please fill out the following form.

https://goo.gl/forms/tHdzkGWjwblW5gvE3

We do not keep track of who submitted what, so please be honest. Each
individual student should fill out the form, e.g., if there are two
people on a team, then each of these people should fill out the form.
Only fill out the provided survey once since we can't identify multiple 
submissions from the same person and multiple responses skew the data.

After you fill out the form, write your name below in this file, not
on the questionnaire. We have no way of checking if you submitted the
file, but by writing your name below you are claiming that you did,
and we'll take your word for it.  

10 points will be awarded to each person who fills out the survey. 
If one member doesn't fill out the survey, indicate this. We'll 
give everyone else the points.

The following team members filled out the feedback survey provided in 
the link above:
---------------------------------------------
Dylan Wight
<firstname> <LastName>

|#