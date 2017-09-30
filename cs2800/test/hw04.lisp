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
CS 2800 Homework 4 - Fall 2017

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

Note: There will be a 10 pt penalty if your names do not follow 
this format.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw04.lisp

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

- when done, save your file and submit it as hw04.lisp

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Propositional Logic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

We use the following ascii character combinations to represent the Boolean
connectives:

  NOT     ~

  AND     /\ .....^ in the programming section
  OR      \/ .....v in the programming section

  IMPLIES =>

  EQUIV   =
  XOR     <>

The binding powers of these functions are listed from highest to lowest
in the above table. Within one group (no blank line), the binding powers
are equal. This is the same as in class.

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Section 1: Truth Tables

Construct the truth table for the following Boolean formulas. Use
alphabetical order for the variables in the formula, and create columns for
all variables occurring in the formula AND for all intermediate
subexpressions. (with one exception: you can omit negations of a single
variable such as ~p or ~r).

For example, if your formula is

(p => q) \/ r

your table should have 5 columns: for p, q, r, p => q, and (p => q) \/ r .

Then decide whether the formula is satisfiable, unsatisfiable, valid, or
falsifiable (more than one of these predicates will hold!). 

a) (~p /\ q) = (q => p)



b) (~p => q) /\ (~r <> q) = (~p => r)  

Hint: your table should have 8 or 11 columns (depending if you write
the not columns including columns for p,q,r).



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Section 2. Logic Rules
Simplify the following expressions using propositional logic rules (give 
either the rule name or the formula. You will get no credit for using
a truth table.
Transformations should take the form:
   expression 1
   = {Justification}
   expression 2
   = {Justification}
   expression 3
   ......

(a) ~p = (q \/ p) /\ p 
...

(b) (p \/ r => ((q /\ ~r) => (r => ~r)))
...

(c) (p \/ q) /\ ((~p \/ q) /\ ~q))

...


(d) (p = q) => ~(~p <> q)
Note: (p = q) = ~(~p = q) can be considered a theorem if that's useful.

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Section 3: Characterization of formulas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

For each of the following formulas, determine if they are valid,
satisfiable, unsatisfiable, or falsifiable. These labels can
overlap (e.g. formulas can be both satisfiable and valid), so
keep that in mind and indicate all characterizations that
apply. In fact, exactly two characterizations always
apply. (Think about why that is the case.) Provide proofs of your
characterizations, using a truth table or simplification
argument (for valid or unsatisfiable formulas) or by exhibiting
assignments that show satisfiability or falsifiability.

(A) ~p =  (p => (q => q))

....

(B) (p => q) = ~(q  \/ ~p)

....

(C) (false /\ p) \/ ~p => (p<>~p)

....

(D) [(~(p /\ q) \/ r) /\ (~p \/ ~q \/ ~r)] <> (p /\ q)

....

(E) ~(p => ~q \/ q)
....

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION 4: Validity

In previous terms we've looked at satisfiability in this assignment.  It's a known
Non-deterministic Polynomial Time problem (AKA bad bad bad) that is a real costraint 
in a variety of CS domains. In fact, if you can solve this issue in polynomial time
you can earn a million dollars and go down in history as one of the all time great 
computer scientists.....so pretty simple for a weekly assignment.

This term we'll try and prove whether a function is valid or not. We're even going
to give you the code for satisfiability to make your life easier.  Please use the
pxSatp function provided. Your job will be to determine if an arbitrary expression
is valid or not. How hard can that be given that you only need a single scenario
when an expression is false to show it is not valid? You need to fill in some of 
the provided functions but you will also need to write your own helper functions 
(without help) to determine validity.

For this exercise, some pre-generated code and definitions are provided.  
This code should *not* be modified unless you check with me first.  
You will use these functions in the  functions you write. The constants 
used in testing can be modified or added to.

NOTE: If your functions do not get automatically admitted in ACL2s, 
refer to section 2.17 of the lecture notes and use the
(set-defunc-...) forms described there. If your code is correct,
you will get full credit, even if you need to admit the code in program mode.  
Don't spend time trying to get ACL2s to admit your functions. 
Right now, you don't know how to do that effectively.

If you define a recursive function based on a recursive data
definition, use the template that the data definition gives rise
to. Read Section 2.15 of the lecture notes and make sure to at
least read up to the bottom of page 25.  Notice that in the
definition of foo in the lecture notes, you have TWO recursive
calls in a single cond branch, due to the PropEx data definition. 
Even if you don't use program mode, I've turned off the strict 
error checking (it will check but then time out in some cases) to
hopefully make your life easier. Just the same, please be patient 
regarding the existing code being admitted into ACL2s.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

;; Let's define the operators for any propositional expression
(defdata UnaryOp '~)
; BinaryOp: '^ means "and", 'v means "or", '<> means "xor"
; and '=> means "implies" 
(defdata BinaryOp (enum '(^ v <> =>)))

; PXVar are the set of possible variables in an expression.
(defdata PXVar symbol)

; PropEx: A Propositional Expression (PropEx) can be a boolean (t
; or nil), a PXVar denoting a variable (e.g. 'p or 'q), or a
; list denoting a unary or binary operation. 
; Note: A variable can be any symbol by this data definition. 
; You can write an expression 
; like '(^ ^ ^) where the second and third symbols are a
; variable......please don't. 

(defdata PropEx 
  (oneof boolean 
         PXVar 
         (list UnaryOp PropEx) 
         (list  BinaryOp PropEx PropEx)))

; IGNORE THESE THEOREMS. USED TO HELP ACL2S REASON

(defthm propex-expand1
  (implies (and (propexp x)
                (not (symbolp x)))
           (equal (second x)
                  (acl2::second x))))

(defthm propex-expand2
  (implies (and (propexp x)
                (not (symbolp x))
                (not (equal (first (acl2::double-rewrite x)) '~)))
           (equal (third (acl2::double-rewrite x))
                  (acl2::third (acl2::double-rewrite x)))))

(defthm propex-expand3
  (implies (and (propexp px)
                (consp px)
                (not (unaryopp (first px))))
           (and (equal (third px)
                       (acl2::third px))
                (equal (second px)
                       (acl2::second px))
                (equal (first px)
                       (acl2::first px)))))

(defthm propex-expand2a
  (implies (and (propexp x)
                (not (symbolp x))
                (not (unaryopp (first (acl2::double-rewrite x)))))
           (equal (third (acl2::double-rewrite x))
                  (acl2::third (acl2::double-rewrite x)))))

(defthm propex-lemma2
  (implies (and (propexp x)
                (not (symbolp x))
                (not (equal (first (acl2::double-rewrite x)) '~)))
           (and (propexp (second x))
                (propexp (acl2::second x))
                (propexp (third x))
                (propexp (acl2::third x)))))

(defthm propex-lemma1
  (implies (and (propexp x)
                (not (symbolp x))
                (equal (first (acl2::double-rewrite x)) '~))
           (and (propexp (second x))
                (propexp (acl2::second x)))))


(defthm first-rest-listp
  (implies (and l (listp l))
           (and (equal (first l)
                       (acl2::first l))
                (equal (rest l)
                       (acl2::rest l)))))


(set-defunc-termination-strictp nil)
;(set-defunc-function-contract-strictp nil)
;(set-defunc-body-contracts-strictp nil)
(set-defunc-timeout 80)
(acl2s-defaults :set cgen-timeout 2)

; END IGNORE


; A list of prop-vars (PXVar))
(defdata Lopv (listof PXVar))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; add: PXVar x lopv -> lopv
;; (add a X) conses PXVar a to list of PXVars
;; X if and only if a is not in X
;; You can use the function in.
(defunc add (a X)
  :input-contract (and (PXVarp a) (Lopvp X))
  :output-contract (Lopvp (add a X))
  (if (in a X)
    X
    (cons a X)))

  
(check= (add 'x '(x y)) '(x y))
(check= (add 'x '(z y)) '(x z y))
(check= (add 'x '()) '(x))
(test? (implies (and (PXVarp a) (Lopvp X) (in a X)) (equal (add a X) X)))


;; DEFINE
;; BinExp: All -> Boolean
;; A recognizer of binary propositional expressions.    
(defunc BinExp (px)
  :input-contract t
  :output-contract (booleanp (BinExp px))
  (if (and (consp px) (consp (rest px)) (consp (rest (rest px))))
    (and (BinaryOpp (first px)) 
         (PropExp (second px)) 
         (PropExp (third px)) 
         (endp (rest (rest (rest px)))))
    nil))

(check= (BinExp 'x) nil)
(check= (BinExp '(x x x)) nil)
(check= (BinExp '(^ x x)) t)
(check= (BinExp '(^ x (^ x x))) t)
(test? (implies (and (BinaryOpp a) (PropExp b) (PropExp c)) (BinExp (list a b c))))#|ACL2s-ToDo-Line|#


  #|
  
;; DEFINE
;; UnaryExp: All -> Boolean
;; A recognizer of unary propositional expressions
;; For our example this is just lists '(~ PropEx)
(defunc UnaryExp (px)
  ..............)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IMPROVE (Modify the input and ouput contracts to use different
;;          recognizers. The function signature can change. 
;;          Do not change the function body)
;; get-vars: PropEx x list -> list 
;; get-vars returns a list of variables appearing in px OR
;;   in the provided accumulator acc. If acc has
;;   no duplicates in it, then the returned list should not have
;;   any duplicates either. See the check='s below.
;; NOTICE: the way you traverse px for get-vars will be how you traverse
;; expressions in later functions you will write.
(defunc get-vars (px acc)
  :input-contract (and (PropExp px)(listp acc))
  :output-contract (listp (get-vars px acc))
  (cond ((booleanp px) acc)
        ((PXVarp px) (add px acc))
        ((UnaryExp px)(get-vars (second px) acc))
        (t (get-vars (third px)
                     (get-vars (second px) acc)))))

(check= (PropExp '(v t (=> s q))) t)
(check= (get-vars '(v r (=> s q)) nil) '(q s r))
(check= (get-vars '(v t nil) nil) nil)
(check= (get-vars '(v s (^ s b)) nil) '(b s))
(check= (get-vars '(v s (~ b)) '(c)) '(b s c))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; del: Any x list -> list
;; Del removes the first instance of an element e in list l
(defunc del (e l)
  :input-contract (listp l)
  :output-contract (listp (del e l))
  (cond ((endp l) l)
        ((equal e (first l)) (rest l))
        (t (cons (first l) (del e (rest l))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; perm: list x list -> boolean
;; We define perm (permutation) to make the tests more robust. 
;; Otherwise, some of the tests below may fail because the order 
;; in which variables appear does not matter. Recall lab 2 for 
;; potentially useful built-in functions
(defunc perm (a b)
  :input-contract (and (listp a) (listp b))
  :output-contract (booleanp (perm a b))
  (cond ((endp a) (endp b))
        ((endp b) nil)
        (t (and (in (first a) b)
                (perm (rest a) (del (first a) b))))))

(check= (perm (get-vars 'A '()) '(A)) t)
(check= (perm (get-vars 'A '(B C)) '(A B C)) t)
(check= (perm (get-vars '(^ A B) '()) '(B A)) t)
(check= (perm (get-vars '(^ B A) '()) '(B A)) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; update: PropEx x PXVar x Boolean -> PropEx
;; The update function "updates a variable" by replacing all instances
;; of the variable with the boolean val in the expression px.
;; Use the template propex gives rise to, as per the lecture notes.
;; Look at get-vars (above).
(defunc update (px name val)
  :input-contract (and (PropExp px) (PXVarp name) (booleanp val))
  :output-contract (Propexp (update px name val))
.............)

(check= (update T 'A NIL) T)
(check= (update NIL 'A T) NIL)
(check= (update 'A 'B T) 'A)
(check= (update '(^ (v NIL A) (~ B)) 'A T) '(^ (v NIL T) (~ B)))
;;Add additional tests

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; ConstBoolExp: All -> Boolean
;; (ConstBoolExp px) determines if px is a PropEx 
;; with NO symbols / free variables.
(defunc ConstBoolExp (px)
  :input-contract t
  :output-contract (booleanp (ConstBoolExp px))
  (and (PropExp px) (equal (get-vars px nil) nil)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; beval: PropEx -> Booleanp
;; beval evaluates a constant boolean expression and return its value.  
;; A constant boolean expression is a PropEx with no variables, 
;; just booleans and operators. If this expression has variables, then
;; return nil. You may have to define helper functions to evaluate
;; your expressions.
(defunc beval (bx)
  :input-contract (PropExp bx)
  :output-contract (Booleanp (beval bx))
  

(check= (ConstBoolExp '(v (~ nil) (^ nil t))) t)
(check= (ConstBoolExp '(v (~ a) (^ nil t))) nil)


;; Tests that may help you later (you can also write your own)
(defconst *test_px1* '(v (~ a) (^ a c))) ;; Sat/Falsifiable
(defconst *test_px2* '(v (~ a) (^ b c))) ;; Sat/Falsifiable
(defconst *test_px3* '(=> t (^ b (~ b)))) ;; Unsatisfiable/Falsifiable
(defconst *test_px4* '(<> (~ a) a)) ;; Valid/Satisfiable
(defconst *test_px5* t)
(defconst *test_px6* nil)
(defconst *test_px7* '(=> a (^ a (v a b)))) ;; Valid/Satisfiable


(defconst *test_px2assign1* '((a 0) (b 0) (c 0)))
(defconst *test_px2assign2* '((a 1) (b 0) (c 0)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
 Evaluating Satisfiability:
 1) Find all the variables in the expression
 2) Methodically replace each variable in the expression 
 with a boolean and do this for all possible t/nil replacement combinations
 3) Evaluate each constant boolean expression you generate
    (using beval) until you find an expression that returns t.
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; updateFirstVar: PropEx x booleanp-> PropEx
;; (updateFirstVar px val) takes an expression px
;; plus a value to substitute in and replaces
;; all instances of the FIRST variable found in px 
;; with val
(defunc updateFirstVar (px val)
  :input-contract (and (PropExp px)(booleanp val))
  :output-contract (PropExp (updateFirstVar px val))
  (if (ConstBoolExp px)
    px
    (update px (first (get-vars px nil)) val)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; pxSatp: PropEx -> boolean
;; (pxSatp px) takes an expression px
;; and returns true iff there is a set
;; of variable assignments that lead
;; to the expression being true.
(defunc pxSatp (px)
  :input-contract (PropExp px)
  :output-contract (booleanp (pxSatp px))
  (if (not (ConstBoolExp px))
    (or (pxSatp (updateFirstVar px t))
        (pxSatp (updateFirstVar px nil)))
    (beval px)))
                    

(check= (pxSatp *test_px1*) t)
(check= (pxSatp *test_px2*) t)
(check= (pxSatp *test_px3*) nil)
(check= (pxSatp *test_px4*) t)
(check= (pxSatp *test_px5*) t)
(check= (pxSatp *test_px6*) nil)
(check= (pxSatp *test_px7*) t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; pxValidp: PropEx -> boolean
;; (pxValidp px) returns true iff
;; px is a propositional expression that
;; always returns true. You must use pxSatp
;; to get credit.
(defunc pxValidp (px)
  .........)


(check= (pxValidp *test_px1*) nil)
(check= (pxValidp *test_px2*) nil)
(check= (pxValidp *test_px3*) nil)
(check= (pxValidp *test_px4*) t)


;; Add any additions tests you want here.
.............


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SECTION 5: SPECIFICATIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

This section deals with specifications using the functions
defined in the lecture notes. Claims below may not satisfy contract 
checking, which means you should perform contract completion before
answering the question.

For each claim, formalize it using ACL2s syntax (remember this requires
that you perform contract completion).

After that, indicate whether the formalized claim is valid.  You
do not need proofs here. If it is invalid, provide a
counterexample. Also, if it is invalid, propose the simplest
modification you can think of that is valid and formalize your
new claim. For this part, there may be many possible answers, in
which case any reasonable answer is fine.  If you discover
anything interesting, indicate it.

Example: len2 is equivalent to len where len2 is defined as

(defunc len2 (l)
  :input-contract (listp l)
  :output-contract (natp (len2 l))
  (if (endp l)
    0
    (+ 1 (len2 (rest l)))))

Answer.
The formalization is:

(implies (listp l)
         (equal (len2 l) (len l)))


This conjuncture is valid.

Note: that if you were to say that the claim is false because it
only holds for lists, that is not a correct answer because you
have to perform contract completion first!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

5a. The length of the list obtained by consing x and y is 
    equal to the length of x plus the length of y.

.........

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
5b. Appending the reverse of x and the reverse of y is equivalent to 
reversing the list generated by appending x to y.
...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
5c. For any propositional expression (defined above), if the expression
is not a PXVar or a list, then it is a boolean.

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
5d. For any list of rationals lr that has been sorted (assume sortedp exists),
the first element of the list is smaller than any other elements in the list.

...............

|#
  |#