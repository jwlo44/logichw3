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
CS 2800 Homework 6 - Fall 2017


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
Names of ALL group members: Julia Wlochowski, Dylan Wight
Note: There will be a 10 pt penalty if your names do not follow 
this format.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
QUESTION 1: Re-arrange the propositional structure

For each of the expressions below, perform contract checking
and contract completion then re-arrange the propositional 
structure to create one or more conjectures in a format 
that allows you to prove the initial conjecture. In other words, break
up the conjecture into an A /\ B /\ C => D style format so you could 
theoretically do the proof.

* Your final conjectures should only have a series of and statements
  on the LHS and a single thing to prove on the RHS.
* Make sure you identify the approaches you are using (if you don't have
  a name for the technique, just describe it). 
* You do NOT have to prove the conjectures.
* For each expression, think about how certain "and" and
  "or" statements can give multiple proof obligations (cases). Each expression
  will end up being two or more simpler conjectures.

Example: (implies (and (listp l1)(listp l2)
                       (or (endp l1)
                           (and (not (endp l1))
                                (implies (and (listp (rest l1))(listp l2)) 
                                         (equal (len (app (rest l1) l2))
                                                (+ (len (rest l1))(len l2)))))))
                  (equal (len (app l1 l2))
                         (+ (len l1)(len l2))))
= {"or" in the antecedent forms 2 proof obligations}
(implies (and (listp l1)(listp l2)(endp l1))
         (equal (len (app l1 l2))
                (+ (len l1)(len l2))))
and
(implies (and (listp l1)(listp l2)(not (endp l1))
              (implies (and (listp (rest l1)(listp l2))) 
                       (equal (len (app (rest l1) l2))
                              (+ (len (rest l1))(len l2)))))
         (equal (len (app l1 l2))
                (+ (len l1)(len l2))))

                
1a. (implies (and (natp n)(posp p))
             (implies (> n p)
                      (and (< (foo n p) p)
                           (>= (foo p n) n))))

= {exportation}
(implies (and (natp n)(posp p) (> n p))
         (and (< (foo n p) p)
              (>= (foo p n) n)))

= {and in rhs gives 2 proof obligations}
(implies (and (natp n)(posp p) (> n p))
         (< (foo n p) p))
and
(implies (and (natp n)(posp p) (> n p))
              (>= (foo p n) n))
              
              
1b. (implies (integerp i)
             (implies (or (< i 0)
                          (and (not (< i 0))(equal i 0))
                          (and (not (< i 0)(not (equal i 0)))))
                      (natp (abs i))))
Based on arithmetic, make sure you simplify the conditions

= {arithmetic and or short-circuiting}
(implies (integerp i)
         (implies (or (< i 0)
                      (equal i 0)
                      (and (not (< i 0))(not (equal i 0))))
                  (natp (abs i))))

= {or,  t => b == b} ;; the inner implies is always true
(implies (integerp i) (natp (abs i))))

1c. (implies (listp l)
             (iff (equal (len l) 0)(endp l)))
Please convert the iff to implies rather than equality

= {convert iff to implies}
(implies (listp l)
         (and (implies (equal (len l) 0)(endp l))
              (implies (endp l)(equal (len l) 0)))

= {and in rhs gives two proof cases}
(implies (listp l)
         (implies (equal (len l) 0)(endp l)))
and        
(implies (listp l)
              (implies (endp l)(equal (len l) 0)))
              
= {exportation}
(implies (and (listp l)(equal (len l) 0))
         (endp l))
and        
(implies (and (listp l)(endp l))
         (equal (len l) 0))
|#




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Equational Reasoning Rules:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Questions 2 to 6 ask for equational proofs about ACL2
programs. Below you are given a set of function definitions you can use.
The definitional axioms and contract theorems for
these functions can be used in the proof. You can use ACL2s to check
the conjectures you are proving but you are not required to do
so. 

Here are some notes about equational proofs:

1. The context: Remember to use propositional logic to rewrite
the context so that it has as many hypotheses as possible.  See
the lecture notes for details. Label the facts in your
context with C1, C2, ... as in the lecture notes.

2. The derived context: Draw a dashed line (----) after the context 
and add anything interesting that can be derived from the context.  
Use the same labeling scheme as was used in the context. Each derived
fact needs a justification. Again, look at the lecture notes for
more information.

3. Use the proof format shown in class and in the lecture notes,
which requires that you justify each step.  Explicitly name each
axiom, theorem or lemma you use, although we are starting to "cut 
corners" with the if axiom and the instantiations we are using. You
can take any "shortcuts" discussed in class.

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
reasoning", "Prop logic", or "PL", except you should use "MP" 
to explicitly identify when you use modus ponens and MT for Modus Tollens.

9. For any given propositional expression, feel free to re-write it
in infix notation (ex a =>(B/\C)).

10. For this homework, you can only use theorems we explicitly
tell you you can use or we have covered in class / lab. 
You can, of course, use the definitional axiom and contract 
theorem for any function used or defined in this homework. You
may also use theorems you've proven earlier in the homework.
Here are the definitions used for the remainder of the questions.

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

(defunc app (x y)
  :input-contract (and (listp x)(listp y))
  :output-contract (listp (app x y))
  (if (endp x)
    y
    (cons (first x)(app (rest x) y))))

(defunc in (a l)
  :input-contract (listp l)
  :output-contract (booleanp (in a l))
  (if (endp l)
    nil
    (or (equal a (first l)) (in a (rest l)))))


;; delete : All x List -> List
;; removes all instances of the element a from the list
(defunc delete (a l)
  :input-contract (listp l)
  :output-contract (listp (delete a l))
  (cond ((endp l) nil)
        ((equal a (first l)) (delete a (rest l)))
        (t (cons (first l) (delete a (rest l))))))

;; duplicate: List -> List
;; repeats each element in the given list once
(defunc duplicate (l)
  :input-contract (listp l)
  :output-contract (listp (duplicate l))
  (if (endp l)
    nil
    (cons (first l) (cons (first l) (duplicate (rest l))))))
    
;; no-dupesp: list -> boolean
;; (no-dupesp l) returns true iff the list l has no duplicates within it.
(defunc no-dupesp (l)
  :input-contract (listp l)
  :output-contract (booleanp (no-dupesp l))
  (cond ((endp l)      t)
        ((in (first l) (rest l)) nil)
        (t             (no-dupesp (rest l)))))
|#
#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Annoying Teachers
Your CS 2800 Professor really must not be much of a programmer.  He
keeps asking you to write obviously slow code to match the "data
definition" despite the fact there is obviously a more efficient approach.
Worse yet, he won't accept this fact when you tell him.


For each of the conjectures in questions 2-5:
- Either prove your (hopefully more efficient) function is equivalent to
  the one proposed by Dr. Sprague OR for other questions, prove the
  provided conjecture to show you are correct.

- Perform conjecture contract checking, and add hypotheses if necessary
  (contract completion). This is to make all functions in the conjecture 
  pass all input contracts.
  
- Run some tests to make an educated guess as to whether the conjecture is
  true or false. In the latter case, give a counterexample to the
  conjecture, and show that it evaluates to false. Else, give a proof 
  using equational reasoning, following instructions 1 to 10 above. These tests
  are not necessary but if there is a counter-example you definitely want to
  find it rather than waste your time on a proof that won't work. We also reserve
  the right to put falsifiable "proofs" on the exam so this is good practice.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
QUESTION 2: Abs Fast 
Here is what your instructor claims the absolute function of integers
needs to be:
|#

(defunc abs (i)
  :input-contract (integerp i)
  :output-contract (natp (abs i))
  (cond ((equal i 0) 0)
        ((< i 0) (+ 1 (abs (+ i 1))))
        (t       (+ 1 (abs (- i 1))))))

;; a) Write a function abs2 based on the following purpose statement

;; abs2: integer -> nat
;; (abs2 i) takes an integer i and returns its absolute value (or the
;; distance from i to 0). abs2 must be non-recursive or you will
;; receive no marks for question 2.
(defunc abs2 (i)
  :input-contract (integerp i)
  :output-contract (natp (abs2 i))
  (if (< i 0) (* -1 i) i))
(test? (implies (integerp i) (equal (abs i) (abs2 i))))
(check= (abs2 0) 0)
(check= (abs2 -4) 4)
(check= (abs2 77) 77)

#|
Now that you've written a faster absolute value function, show that
your faster version is functionally equivalent to the original (given
the same input they return the same outputs). To simplify your lives,
the proof obligations (what you need to prove) have been provided (b-d)

b) (implies (equal i 0) (equal (abs i)(abs2 i)))

;; contract checking 
(in contexts)

;; contexts
c1. i = 0
---------
c2. integerp i {c1, def. integerp}

;; tests
(above, with definition of abs)

;; proof
(equal (abs i)(abs2 i))

= {def. abs}
(equal  (cond ((equal 0 0) 0)
              ((< 0 0) (+ 1 (abs (+ 0 1))))
              (t       (+ 1 (abs (- 0 1)))))
        (abs2 i))
        
= {cond, c1}
(equal 0 (abs2 i))

= {def. abs2}
(if (< 0 0) (* -1 0) 0))

= {if, <}
(equal 0  0)
t

c) (implies (and (< i 0)(implies (and (integerp (+ i 1))(<= (+ i 1) 0))
                                    (equal (abs (+ i 1))(abs2 (+ i 1)))))
               (equal (abs i)(abs2 i)))

;; contract checking
(implies (and (integerp i)
              (< i 0)
              (implies (and (integerp (+ i 1))(<= (+ i 1) 0))
                       (equal (abs (+ i 1))(abs2 (+ i 1)))))
               (equal (abs i)(abs2 i)))

;; contexts
c1. integerp i
c2. i < 0
c3. (implies (and (integerp (+ i 1))(<= (+ i 1) 0))
                       (equal (abs (+ i 1))(abs2 (+ i 1))))
..............................................................
c4. (integerp (+ i 1)) {integerp, c1}
c5. (<= (+ i 1) 0) {integerp, c1, c2, arithmetic}
c6. (equal (abs (+ i 1))(abs2 (+ i 1))) {MP, c4, c5, c3}

;; tests
(see def abs2)

;; proof
(equal (abs i)(abs2 i))

= {def abs}
(equal  (cond ((equal i 0) 0)
              ((< i 0) (+ 1 (abs (+ i 1))))
              (t       (+ 1 (abs (- i 1)))))
        (abs2 i))

= {cond, c2}
(equal (+1 (abs (+ i 1)))
       (abs2 i))

= {def abs2}
(equal (+1 (abs (+ i 1)))
       (if (< i 0) (* -1 i) i))

={c2, if}
(equal (+1 (abs (+ i 1)))
       (* -1 i))

={c6}
(equal (+1 (abs2 (+ i 1)))
       (* -1 i))  

={def. abs2}
(equal (+ 1 (if (< ( + i 1) 0) (* -1 (+ i 1)) (+ i 1)))
       (* -1 i))

={case 1: i + 1 < 0, ifs}
(equal (+ 1 (* -1 (+ i 1)))
       (* -1 i))

= {arithmetic}
(equal (* -1 i)
       (* -1 i))
t

={case 2: i + 1 == 0, ifs, c2, arithmetic}
(equal (+ 1 0)
       (* -1 i))
       
={i == -1, arithmetic}
(equal (+ 1 0)
       (* -1 -1))
= {arithmetic}
(equal 1 1)
t

d) (implies (and (> i 0)(implies (integerp (- i 1))
                                 (equal (abs (- i 1))(abs2 (- i 1)))))
            (equal (abs i)(abs2 i)))

;; contract checking
(implies (and (integerp i)
              (> i 0)
              (implies (integerp (- i 1))
                       (equal (abs (- i 1))(abs2 (- i 1)))))
         (equal (abs i)(abs2 i)))

;; contexts
c1. integerp i
c2. i > 0
c3. (implies (integerp (- i 1)) (equal (abs (- i 1))(abs2 (- i 1)))))
.....................................................................
c4. (integerp (- i 1)) {integerp, c1}
c5. (equal (abs (- i 1))(abs2 (- i 1))) {MP, c3, c4}

;; tests
(see above)

;; proof
(equal (abs i)(abs2 i))

={def abs}
(equal
  (cond ((equal i 0) 0)
        ((< i 0) (+ 1 (abs (+ i 1))))
        (t       (+ 1 (abs (- i 1)))))
  (abs2 i))

= {cond, c2}
(equal (+ 1 (abs (- i 1)))
       (abs2 i))

= {c5}
(equal (+ 1 (abs2 (- i 1)))
       (abs2 i))
 
= {def. abs2}
(equal (+ 1 (abs2 (- i 1)))
       (if (< i 0) (* -1 i) i))

= {c2, ifs}
(equal (+ 1 (abs2 (- i 1)))
       i)

= {def abs2}
(equal (+ 1 (if (< (- i 1) 0) (* -1 (- i 1)) (- i 1))
        i)

= {ifs}
(equal (+ 1 (- i 1)) i)

= {arithmetic}
(equal i i)
t
       
|#

#|
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Question 3: Flatten list

Here are three functions "you" wrote for flattening a list
Ex. (fatten-list '((1 2) '(3 '(4)))) returns '(1 2 3 4)

;; nelistp: All -> Boolean
;; nelistp returns true iff l is a non-empty list
;; Useful for simplifying the code below
(defunc nelistp (l)
  :input-contract t
  :output-contract (booleanp (nelistp l))
  (and (listp l)(consp l)))

 ;; flat-listp: All -> Boolean
 ;; (flat-listp l) recognizes whether an input
 ;; is a flat list (a list with no non-empty sub-lists)
 ;; NOTE: Don't worry about conses that are not lists.
 ;; In this case, the cons is considered like an atom
 ;; (makes the code easier to write)
(defunc flat-listp (l)
  :input-contract t
  :output-contract (booleanp (flat-listp l))
  (cond ((not (listp l)) nil)
        ((endp l)        t)
        ((nelistp (first l)) nil)
        (t               (flat-listp (rest l)))))

;; flatten-list: List -> List
;; (flatten-list l) takes a list and puts all atoms
;; in the list at the top level. Thus the generated list
;; will not have a list of lists inside it. Ignore
;; situations with non-list conses.
(defunc flatten-list (l)
  :input-contract (listp l)
  :output-contract (flat-listp l)
  (cond ((endp l)  l)
        ((not (nelistp (first l))) 
         (cons (first l) (flatten-list (rest l))))
        (t         (app (flatten-list (first l)) 
                        (flatten-list (rest l))))))


Well neither ACL2s nor your professor can prove that flatten-list must
produce a flat list (by definition of flat-listp).  Prove it to show
you are right.
                        
Prove
(implies (and (listp l)
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
              (or (endp l)(and (nelistp l)(nelistp (first l)))
                  (and (nelistp l)(not (nelistp (first l))))))
         (flat-listp (flatten-list l)))
         
a) Notice the massive expression? Rewrite it into THREE proof obligations
which are the three propositional expressions that, if proven, will prove
the main conjecture. The proof obligations will also be pretty large. This
is similar to what you did in section 1.

Also note the two implies within the giant AND statement (lines 2 to 4 
of the conjecture above). How can you use these?  In what circumstances?
You can the implies within the and statement when their lhs are true, using Modus Ponens. 

{breaking up OR in rhs into 3 different proof obligations}
obligation 1:
(implies (and (listp l)
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
              (endp l))
         (flat-listp (flatten-list l)))

obligation 2:
(implies (and (listp l)
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
              (and (nelistp l)(nelistp (first l))))
         (flat-listp (flatten-list l)))       

obligation 3:
(implies (and (listp l)
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
              (and (nelistp l)(not (nelistp (first l)))))
         (flat-listp (flatten-list l)))

b) Now prove your three proof obligations. You can assume the following
theorems:
phi_flatten_app: (implies (and (flat-listp l1)(flat-listp l2))
                          (flat-listp (app l1 l2)))
phi_flatten_cons: (implies (and (flat-listp l)(not (nelistp e)))
                          (flat-listp (cons e l)))


obligation 1:
(implies (and (listp l)
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
              (endp l))
         (flat-listp (flatten-list l)))

;; contract checking -- ok
;; context
c1. listp l
c2. (implies (nelistp l)(flat-listp (flatten-list (rest l))))
c3. (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
c4. endp l
................................................................
c5. c2 and c3 are useless {c2, c3, c4, implies}

;; proof                        
(flat-listp (flatten-list l))

= {flatten-list def}
(flat-listp
  (cond ((endp l)  l)
        ((not (nelistp (first l))) 
         (cons (first l) (flatten-list (rest l))))
        (t         (app (flatten-list (first l)) 
                        (flatten-list (rest l)))))))
= {ifs, c4}
(flat-listp l)

= {flat-listp def, c4, ifs}
t
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; obligation 2
(implies (and (listp l)
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
              (and (nelistp l)(nelistp (first l))))
         (flat-listp (flatten-list l))) 
         
simplify this a little         
= {PL(associativity, commutativity)}
(implies (and (listp l)
              (nelistp l)
              (nelistp (first l))
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l)))))
         (flat-listp (flatten-list l)))
         
;; contract checking -- ok
;; contexts
c1. listp l
c2. nelistp l
c3. nelistp (first l)
c4. (implies (nelistp l)(flat-listp (flatten-list (rest l))))
c5. (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l)))))
...............................................................
c6. (flat-listp (flatten-list (rest l))) {MP, c4, c2}
c7. (flat-listp (flatten-list (first l))) {MP, c3, c5}

;; test?
;; proof
(flat-listp (flatten-list l))

={def flatten-list}
(flat-listp
  (cond ((endp l)  l)
        ((not (nelistp (first l))) 
         (cons (first l) (flatten-list (rest l))))
        (t         (app (flatten-list (first l)) 
                        (flatten-list (rest l))))))
={cond, c2, c3}
(flat-listp (app (flatten-list (first l)) 
                 (flatten-list (rest l))))

={phi_flatten_app, c6, c7}
t

obligation 3:
(implies (and (listp l)
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
              (and (nelistp l)(not (nelistp (first l)))))
         (flat-listp (flatten-list l)))
         
;; simplify
={associativity, commutativity}
(implies (and (listp l)
              (nelistp l)
              (not (nelistp (first l)))
              (implies (nelistp l)(flat-listp (flatten-list (rest l))))
              (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
         (flat-listp (flatten-list l)))

;; contract checking check
;; contexts
c1. listp l
c2. nelistp l
c3. (not (nelistp (first l)))
c4. (implies (nelistp l)(flat-listp (flatten-list (rest l))))
c5. (implies (and (nelistp l)(nelistp (first l)))
                       (flat-listp (flatten-list (first l))))
................................................................
c6. (flat-listp (flatten-list (rest l))) {MP, c4, c2}
c7. c5 is useless {implies, c3, c5}

;; proof
(flat-listp (flatten-list l))

={def. flatten-list}
(flat-listp
  (cond ((endp l)  l)
        ((not (nelistp (first l))) 
         (cons (first l) (flatten-list (rest l))))
        (t         (app (flatten-list (first l)) 
                        (flatten-list (rest l))))))

= {cond, c2, endp, c3}
(flat-listp
  (cons (first l) (flatten-list (rest l))))

= {phi_flatten_cons, c6}
t

c) OK.  You have higher standards than that.  You don't want to 
just assume the given theorems. Prove phi_flatten_cons. You can
assume that (flat-listp l) => (listp l)

phi_flatten_cons
(implies (and (flat-listp l)(not (nelistp e)))
         (flat-listp (cons e l)))

;; contract checking good
;; contexts
c1. flat-listp l
c2. (not (nelistp e))
.......................
c3. listp l {per above}

;; proof
(flat-listp (cons e l))

={def. flat-listp}
  (cond ((not (listp (cons e l))) nil)
        ((endp (cons e l))        t)
        ((nelistp (first (cons e l))) nil)
        (t               (flat-listp (rest (cons e l))))))

={listp, c3, cons, PL}
  (cond (nil nil)
        ((endp (cons e l))        t)
        ((nelistp (first (cons e l))) nil)
        (t               (flat-listp (rest (cons e l))))))

={endp, c3, cons}
  (cond (nil nil)
        (nil        t)
        ((nelistp (first (cons e l))) nil)
        (t               (flat-listp (rest (cons e l))))))

={first-rest, cons}
  (cond (nil nil)
        (nil        t)
        ((nelistp e) nil)
        (t               (flat-listp (rest (cons e l))))))
={c2, cond}
(flat-listp (rest (cons e l)))

={first-rest, cons}
(flat-listp l)

={c1}
t

=========================
Question 4: Primes

Professor Sprague is being a pain, making you recall CS 1800 for
some reason.  This time he's looking at primes, greatest common divisors 
(GCD) and co-prime numbers.  Recall that identifying whether two numbers are
co-prime is critical to RSA.  We can say that two numbers are co-prime if
they share no common factors or the GCD is 1.

Here's the given prime method.

(defdata lop (listof pos))

;; factors1: pos x pos -> lop
;; (factors1 n v) finds the factors of n
;; Since primes will never be even, increase
;; v by 2 each iteration.
(defunc factors1 (n v)
  :input-contract (and (posp n)(posp v))
  :output-contract (lopp (factors1 n v))
  (if (> v n)
    nil
    (if (natp (/ n v))
      (cons v (factors1 n (+ v 2)))
      (factors1 n (+ v 2)))))

a) Is there something wrong with this approach if we assume v starts at 1?  
If yes, give an input that will cause a problem. If no then give Professor Sprague 
$5 for the awesome algorithm.

This appprach is wrong. factors1 will never return 2 or n even when n is a even number. 
If we call (factors1 6 1) we will get '(1 3) instead of  '(1 2 3 6) the actual factors of 6.
This appraoch also will not return multiple of the same number (factors1 9 1) will return '(1 3 9) 
instead of '(1 3 3 9).

|#


#|


b) Define a new factors function according to its purpose statement. 
You may need a helper function. Also, don't worry too much about efficiency.

|#

(defdata factor (range integer (2 <= _)))
;; Ignore
(defthm phi_shrink_factor (implies (and (posp n)(factorp f)(posp (/ n f)))
                                   (< (/ n f) n)))
(defdata lop (listof pos))

;; I don't want you spending time getting this admitted into ACL2s.
:program


(defunc factors-helper (n v)
    :input-contract (and (posp n) (posp v))
    :output-contract (lopp (factors-helper n v))
      (if (> v n)
        nil
        (if (posp (/ n v))
          (cons v (factors-helper (/ n v) 2))
          (factors-helper n (+ v 1)))))

;; DEFINE
;; factors : Pos -> Lop
;; returns a list containing all PRIME factors of n including (possibly) 
;; n and 1. 
(defunc factors (n)
    :input-contract (posp n)
    :output-contract (lopp (factors n))
    (if (equal n 1)
      (list 1)
      (factors-helper n 2)))

    

;; Note the factors for 12 *could* be listed as 1 2 3 4 6 12 but
;; really 12 is uniquely represented as the product of non-decreasing 
;; prime numbers: 2*2*3.  Thus factors will return '(2 2 3)  
;; 13 is prime so it isn't decomposed into other
;; primes and '(13) is returned. 
;; If you get the same values but in a different order, feel free to 
;; change the tests.
:logic
(check= (factors 1)'(1))
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
;; coprimep: pos x pos -> boolean
;; determines whether two positive integers a and b are coprime
(defunc coprimep (a b)
    :input-contract (and (posp a) (posp b))
    :output-contract (booleanp (coprimep a b))
    (endp (intersect (factors a) (factors b))))

;; this line is for ACL2s
(sig intersect ((listof :b) (listof :b)) => (listof :b))


(defunc mult-primes (l) 
    :input-contract (lopp l)
    :output-contract (natp (mult-primes l))
    (if (endp l) 
      1 
      (* (first l) (mult-primes (rest l)))))

(check= (mult-primes (list 7 2 5)) 70)
(check= (mult-primes  nil) 1)


;; DEFINE
;; gcd: pos x pos -> pos
;; (gcd a b) determines the greatest common divisor for a and b.
;; Do you remember how to calculate that with prime factors?
(defunc gcd (a b)
    :input-contract (and (posp a) (posp b))
    :output-contract (posp (gcd a b))
    (mult-primes (intersect (factors a) (factors b))))

(check= (gcd 7 6) 1)
(check= (gcd 8 6) 2)
(check= (gcd 12 6) 6)
(check= (gcd 30 12) 6)
(check= (gcd 30 28) 2)
(check= (gcd 35 28) 7)
(test? (implies (and (posp a)(posp b))
                (equal (gcd a b)(gcd b a))))#|ACL2s-ToDo-Line|#

#|

c) Perform contract completion on the following:

A1: (iff (in b (factors a)) (integerp (/ a b)))

* iff is "if and only if" in case you forgot
What is this equivalent to (there are multiple things).
(iff a b) is equivalent to (and (implies a b) (implies b a))


(and (implies (in b (factors a)) (integerp (/ a b)))
     (implies (integerp (/ a b)) (in b (factors a))))
     
Need to ensure a and b are posp on both sides.

**YOU MAY ASSUME A1 (after contract completion) IS A THEOREM**
(iff (and (posp b) (posp a) (in b (factors a))) (and (posp b) (posp a) (integerp (/ a b))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Prove each of the following conjectures with equational reasoning or provide a 
;counterexample. You may assume that your contract-completed lemma above holds.

d) (implies (and (posp a) (posp b) (posp c)
                 (coprime a b)
                 (not (coprime a c)))
            (coprime b c))

 counter example: a = 2, b = 9, c = 6

e)  (implies (and (posp a)(posp b))
             (iff (equal (gcd a b) 1)
                  (coprime a b)))
 You may also assume that (prod-list l) = 1 
 means that l is empty......at least when l is a list
 of prime factors
 
(implies (and (posp a)(posp b))
             (iff (equal (gcd a b) 1)
                  (coprimep a b)))
                  
 substitution of (coprimep a b)
 
 (implies (and (posp a)(posp b))
             (iff (equal (gcd a b) 1)
                  (endp (intersect (factors a) (factors b)))))
                  
 substitution of (gcd a b)
 
 (implies (and (posp a)(posp b))
             (iff (equal (mult-primes (intersect (factors a) (factors b)) 1))
                  (endp (intersect (factors a) (factors b))))
 
 replace (intersect (factors a) (factors b)) with lop l
 
  (implies (and (lopp l))
             (iff (equal (mult-primes l 1))
                  (endp l)))
                  
 break apart iff
 
   (implies (and (lopp l))
             (and (implies (mult-primes l 1) (endp l)))
                  (implies (endp l) (mult-primes l 1)))
             
 
(implies (mult-primes l 1) (endp l)) is valid because we assume that (prod-list l) = 1 
 means that l is empty
 
(implies (endp l) (mult-primes l 1)) is valid because the first line of mult-primes returns 1 if (endp l)
 
                  
f) (implies (and (posp a) (posp b) (posp c)
                 (in b (factors a)))
            (in b (factors (* a c))))

            
            
          
(equals (factors (* a c)) (append (factors a) factors c))

(factors a) is a subset of (factors (* a c)), so if b is in (factors a) it must be in (factors (* a c))

      (if (> v n)
        nil
        (if (posp (/ n v))
          (cons v (factors-helper (/ n v) 2))
          (factors-helper n (+ v 1)))))
          
g) (implies (and (posp n) (natp (/ n 6))
            (>= (len (factors n)) 2)))


The factor list of any number divisable by 6 will contain 2 and 3. THerefor this factor list must be contain 
at least two numbers
            
|#
#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Question 5
  
  Now let's look back at HW04.  Here is a (modified) version of the add
  function and related functions and data definitions, all of which
  you can assume have been admitted into ACL2s:

(defdata PXVar symbol)
(defdata UnaryOp '~)
(defdata BinOp (enum '(^ v => <> =)))
(defdata PropEx (oneof boolean 
                       PXVar 
                       (list UnaryOp PropEx)
                       (list PropEx BinOp PropEx)))

; A list of prop-vars (PXVar))
(defdata Lopv (listof PXVar))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add: PXVar x lopv -> lopv
;; (add a X) conses PXVar a to list of PXVars
;; X if and only if a is not in X
;; You can use the function in.
(defunc add (a X)
  :input-contract (and (PXVarp a)(lopvp X))
  :output-contract (lopvp (add a X))
  (if (in a X)
    X
    (cons a X)))

a) Professor Sprague thinks your get-vars function won't work because
the accumulator can have duplicate values. Prove that your add function prevents
this by proving the following conjecture:
(implies (not (no-dupes (add a X))) (not (no-dupesp X)))

(defunc add (a X)
  :input-contract (and (PXVarp a)(lopvp X))
  :output-contract (lopvp (add a X))
  (if (in a X)
    X
    (cons a X)))
    
 If a is in X then this can be subsituted to an identify 
 (implies (not (no-dupes X)) (not (no-dupesp X)))

If a is not in X then, we know adding a didn't make there be a dup.
    
Think about cases you might encounter or need to handle to prove this?
Is there a better way to write this conjecture?

This conjuncture says that is the result of adding a to X has dups then X already had a dupe. This is true
because add a checks if a is in X and only adds X if it is not in X.

This is a better way to write it:
(implies (no-dupesp X) (no-dupes (add a X)))
If there are no dupes in X, adding a will not result in any dupes.

This does not mean our get-vars function will work, because we X could have dupes befoer we add anything.


b) Now prove that get-vars doesn't have duplicate propositional variables.
The conjecture is below.


;; BinExp: All -> Boolean
;; A recognizer of binary propositional expressions.
(defunc BinExp (px)
  :input-contract t
  :output-contract (booleanp (BinExp px))
  (and (PropExp px)(listp px)(equal (len px) 3)))

;; UnaryExp: All -> Boolean
;; A recognizer of unary propositional expressions
;; For our example this is just lists '(~ PropEx)
(defunc UnaryExp (px)
  :input-contract t
  :output-contract (booleanp (BinExp px))
  (and (PropExp px)(listp px)(equal (len px) 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; get-vars: PropEx x LOPV -> LOPV 
;; get-vars returns a list of variables appearing in px OR
;;   in the provided accumulator acc. If acc has
;;   no duplicates in it, then the returned list should not have
;;   any duplicates either. See the check='s below.
(defunc get-vars (px acc)
  :input-contract (and (PropExp px) (Lopvp acc))
  :output-contract (Lopvp (get-vars px acc))
  (cond ((booleanp px) acc)
        ((PXVarp px) (add px acc))
        ((UnaryExp px)(get-vars (second px) acc))
        (t (get-vars (third px)
                     (get-vars (second px) acc)))))

;PROVE The following conjecture
(implies (and (PropExp px)(lopvp acc)(no-dupesp acc)
              (implies (UnaryExp px) (no-dupesp (get-vars (second px) acc)))
              (implies (BinExp px) (no-dupesp (get-vars (third px) (get-vars (second px) acc)))))
         (no-dupesp (get-vars px acc)))
;You may need to use a proof by cases approach.


(defdata PropEx
  (oneof boolean
         PXVar
         (list UnaryOp PropEx)
         (list  BinaryOp PropEx PropEx)))
         
 four cases:
 1. 
(implies (and (booleanp px)(lopvp acc)(no-dupesp acc))
         (no-dupesp (get-vars px acc)))
         
 boolean branch of get-vars: (implies (booleanp px) (and (get-var px acc)) acc)
 subsitute this for (get-vars px acc):
 
 (implies (and (booleanp px)(lopvp acc)(no-dupesp acc))
         (no-dupesp acc))
         
(implies (no-dupesp acc) (no-dupesp acc)) 

2.         
(implies (and (PXVar px)(lopvp acc)(no-dupesp acc))
         (no-dupesp (get-vars px acc)))
         
 PXVar branch of get-vars: (implies (PXVar px) (and (get-var px acc)) (add px acc))
 (implies (and (PXVar px)(lopvp acc)(no-dupesp acc))
         (no-dupesp (add px acc)))
 
Already proved this in 5a)

3.
(implies (and (UnaryExp px)(lopvp acc)(no-dupesp acc)(no-dupesp (get-vars (second px) acc)))
         (no-dupesp (get-vars px acc)))
         
Unary branch: ((UnaryExp px)(get-vars (second px) acc))

(implies (and (UnaryExp px)(lopvp acc)(no-dupesp acc)(no-dupesp (get-vars (second px) acc)))
         (no-dupesp (get-vars (second px) acc)))
(get-vars (second px) acc)) implies (get-vars (second px) acc))
(implies (and a b c) c)

4.
(implies (and (BinExp px)(lopvp acc)(no-dupesp acc)(no-dupesp (get-vars (third px) (get-vars (second px) acc))))
         (no-dupesp (get-vars px acc)))
         
BinExp branch: (get-vars (third px) (get-vars (second px) acc)) 

(implies (and (BinExp px)(lopvp acc)(no-dupesp acc)(no-dupesp (get-vars (third px) (get-vars (second px) acc))))
         (no-dupesp (get-vars (third px) (get-vars (second px) acc))) 
 
 (implies (and a b c) c)
                   
|#
#|
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;; Question 6: Duplicate Length (not graded)

You've already done a lot of work this homework but some of you might want additional practice
before the exam.  Hence this question is optional.  We won't grade it but we will give you
feedback if you do it.

;; GIVEN:
;; evenp : Nat -> Boolean
;; evenp is a predicate that takes a natural number and decides 
;; whether it is even.
(defunc evenp (x)
    :input-contract (natp x)
    :output-contract (booleanp (evenp x))
    (cond ((equal x 0) t)
          ((equal x 1) nil)
          (t (evenp (- x 2)))))

Consider the following true conjecture:  
dup_even_len: (implies (listp l) (evenp (len (duplicate l))))

If you try to prove this using just equational reasoning, it's not
going to go well. If you're not sure why, feel free to try it. To make this
problem a bit easier, we're going to break it down into cases and give you a
little extra help.

a) Let's start with a simple case. What about when l is not a list? Prove the
following using equational reasoning:

(implies (not (listp l))
    (implies (listp l) (evenp (len (duplicate l)))))

...........


b) Next we have the base case where l is the empty list. Prove the following
using equational reasoning:

(implies (and (listp l) (endp l))
         (implies (listp l) (evenp (len (duplicate l)))))

.................


c) Those cases weren't so bad. Here comes the trickiest one, the case for 
non-empty lists. This one is hard, so we're going to give you an extra premise 
to help out. Prove the following using equational reasoning:

(implies (and (listp l) 
              (not (endp l))
              (implies (listp (rest l)) 
                       (evenp (len (duplicate (rest l))))))
         (implies (listp l) (evenp (len (duplicate l)))))

................
|#

