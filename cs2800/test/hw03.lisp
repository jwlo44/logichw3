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

CS 2800 Homework 3 Solution - Fall 2017

This homework is done in groups. More elaborate instructions are 
posted on the course website:

 * One group member will create a group in BlackBoard.
 
 * Other group members then join the group.
 
 * Homework is submitted once. Therefore make sure the person
   submitting actually does so. In previous terms when everyone needed
   to submit we regularly had one person forget but the other submissions
   meant the team did not get a zero. Now if you forget, your team gets 0.
   - It wouldn't be a bad idea for groups to email confirmation messages
     to each other to reduce anxiety.

 * Submit the homework file (this file) on Blackboard.  Do not rename 
   this file.  There will be a 10 point penalty for this.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm group membership with the BB groups.
   If you fail to follow these instructions, it costs us time and
   it will cost you points, so please read carefully.

The format should be: FirstName1 LastName1, FirstName2 LastName2, ...
For example:
Names of ALL group members: David Sprague, Jaideep Ramachandran

There will be a 10 pt penalty if your names do not follow this format.
Names of ALL group members: Julia Wlochowski, Dylan Wight

* Later in the term if you want to change groups, the person who created
  the group should stay in the group. Other people can leave and create 
  other groups or change memberships (the Axel Rose membership clause). 
  We will post additional instructions about this later.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw03.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. Do not remove or comment out anything pre-existing unless
  we tell you to.

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. Comments should also be used for any English
  text that you may add. This file already contains many comments, so you
  can see what the syntax is.

- when done, save your file and submit it as hw03.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

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

We also learned about test? in class.  This generally takes the form:
(test? (implies <Data expected> <True statement based on expected data>))

For example, one might write:
(test? (implies (and (listp x)(listp y))(equal (+ (len x)(len y))(len (app x y)))))

|#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Contract Fulfillment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

The following are functions that may or may not be correct. For each function,
list all of the calls that this function makes. For each call decide whether
the contract is satisfied or not. If it is satisfied, then explain why. If it
is not satisfied then explain why not. In other words, show all of the body
contracts. Do the same for the overall function contract.

---------
EXAMPLE
(defunc foo (x)
  :input-contract (listp x)
  :output-contract (natp (foo x))
  (if (endp x)
     0
     (+ 1 (foo (rest x)))))
Body Contract:
(rest x) the input-contract is satisfied because x needs to be a non-empty list
and this is ensured by the if statement and the input contract for foo.

(foo (rest x)) the input-contract is satisfied because (rest x) outputs a list.

(+ 1 (foo (rest x))) the input contract is two natural numbers. 1 is a natural by definition.
The output-contract for foo is natp and thus + has appropriate input.

(endp x) the input-contract requires x to be a list. This is ensured by the input contract
of foo.

(if (endp x)....) the input-contract requires (endp x) to be a boolean.  endp returns a boolean
based on its output contract.

Function Contract:

(+ 1 (foo (rest x))) If the recursive call obeys the contract, then the returned value must be a nat
since the inputs are naturals.

0 Since 0 is an natural number, the output-contract holds.

Thus the overal function contract is satisfied.
----------
|#

;; since the following functions may have errors in their contracts, we turn ACL2s's
;; checking off temporarily
:program
(acl2s-defaults :set testing-enabled nil)

;; 1. The following function supposedly computes the modulo of an integer by a nat.
(defunc mod (x y)
  :input-contract (and (integerp x) (natp y) (not (equal y 0)))
  :output-contract (natp (mod x y))
  (cond ((>= x y) (mod (- x y) y))
        ((>= x 0) x)
        (t (mod (+ x y) y))))

#|
Body Contract:
(>= x y) the input contract requires two rational numbers. Here it is satisfied because x and y are an integer and a natural number, which are subsets of rational numbers.
(- x y) same as above, "-" requires two numbers, and mod's input contract ensures that x and y are natural numbers.
(mod (- x y) y) mod takes in an integer and a natural number. the difference of an int and a nat is still an int, and y has not been modified so it should still be a good non-zero natural number.
(>= x 0) >= takes in two rational numbers. We already know x is an integer, and 0 is a rational number by definition.
(+ x y) same as -, "+" takes in two rational numbers and x and y are such thanks to mod's input contract
(mod (+ x y) y) mod takes in an integer and a non-zero nat. y is still a non-zero nat from the original call, and (+ x y) should yield an integer given an int and a nat.
(cond (...)) cond takes in several statements in the form (boolean any). the two >= and t all evaluate to booleans, so cond's input-contract is satisfied here.

Function Contract:

The cond gives us three possible return values, two of which are recursive calls that should be correct as long as the base case is correct.
The base case is correct, because the only way to get to the second cond case is for integer x to be greater than 0, making it a natural number and thus satisfying the output-contract.
Also, the cond has a default case, t, so we know that the cond cannot spill over and return nil.

2. The following function supposedly computes the magnitude of a rational for
scientific notation.
|#


(defunc mag (x)
  :input-contract (and (rationalp x) (>= x 0))
  :output-contract (natp (mag x))
  (cond ((equal x 0) 0)
        ((>= x 10) (+ (mag (/ x 10)) 1))
        ((< x 1) (- (mag (* x 10)) 1))
        (t 0)))
#|
Body Contracts:
(equal x 0) equal takes in two anys, so we can't go wrong here
(>= x 10) >= takes in two rational numbers. mag's input-contract ensures x is rational and 10 is rational by definition
(/ x 10) / takes in a rational and a nonzero rational. 10 is non-zero, and both are rational as above
(mag (/ x 10)) mag needs a non-negative rational number. / returns a rational.
 and, the only way / could give a negative is if x or 10 is negative. 
 10 is not negative by definition and mag's input contract from the original call ensures that x isn't negative either.
 
(+ (mag (/ x 10)) 1) + takes in two rational numbers. 1 is rational by definition. mag's output contract claims to return a nat, which is a subset of rational numbers.
(< x 1) < just needs two rationals. x is rational per mag's input contract, and 1 is rational by definition.
(* x 10) same as <, * just wants two rationals and x an 1 are both good.
(mag (* x 10)) mag needs a non-negative rational. * can only give a negative rational if x or 10 is negative. 10 is not negative, and the input contract for mag's original call ensure that x isn't either.
(- (mag (* x 10)) 1) - just wants two rationals. mag should output a nat, which is a rational number, and 1 is rational by definition.
(cond (...)) cond takes in a group of statements (boolean any). equal, >=, <, and t are all booleans, and each statement only has one other argument, so cond is good here.

Function Contract:
The output contract is false when 0 < x < 1. If you call mag on a fraction, it returns -1, which is not a natural number.

3. The following function does something mysterious.
|#

(defunc ack (m n)
  :input-contract (and (natp m) (natp n))
  :output-contract (natp (ack m n))
  (cond ((equal m 0) (+ n 1))
        ((equal n 0) (ack (- m 1) 1))
        (t           (ack (- m 1) (ack m (- n 1))))))


#|
Body Contracts:
(equal m 0) equal takes in two anys, so this is always satisfied
(+ n 1) + takes in two rational numbers. n is rational because our input contract said it was a nat. and 1 is rational by definition.
(equal n 0) equal takes in two anys, so this is always satisfied
(- m 1) + takes in two rational numbers. m is rational because our input contract said it was a nat. and 1 is rational by definition.
(ack (- m 1) 1) ack takes in two nats. because of the above cond case, we know m > 0, so (- m 1) will still give a nat, and 1 is a nat by definition.
(- n 1) - takes in two rational numbers. n is rational because our input contract said it was a nat. and 1 is rational by definition.
(ack m (- n 1) ack takes in two nats. because of the above cond case, we know n > 0, so (- n 1) will still give a nat, and 1 is a nat by definition.
(ack (- m 1) (ack m (- n 1))) ack takes in two nats. as above, (- m 1) has to be a nat since m > 0 in this cond case. ack's output contract should yield a nat so we're good.
(cond (...) the cond is correct because each case has a boolean and an any.

Function Contract:

Ack doesn't terminate. For example, (ack 4 1) keeps calling itself; (ack 1 n+1) and n never stops increasing, so we never reach the base case where m is 0 and we return n+1. 

|#

:logic
(acl2s-defaults :set testing-enabled t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Testing Sorting Programs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

The purpose of a sorting algorithm is to rearrange a list of elements
in order. To test whether a sorting algorithm is correct, one must show
not only that the algorithm produces a list that is in order, one must
also show that the algorithm rearranges the elements of the list,
including making sure that any elements that occur more than once in the
original list will occur the same number of times in the result list.

DEFINE the following functions.  
 For each function with "..." in it, replace the dots with the appropriate definition.
 Make sure to write appropriate tests for each function that you define.
 
|#

;; GIVEN (From HW02)
;; delete : All x List -> List
;; remove the first occurence of an element from a list
(defunc delete (e l)
  :input-contract (listp l)
  :output-contract (listp (delete e l))
  (cond ((endp l) (list))
        ((equal e (first l)) (rest l))
        (t (cons (first l) (delete e (rest l))))))

(check= (delete 1 (list)) (list))
(check= (delete 2 (list 1)) (list 1))
(check= (delete 3 (list 3)) (list))
(check= (delete 2 (list 1 2 3 2 4)) (list 1 3 2 4))
(check= (delete 4 (list 4 5)) (list 5))
(check= (delete 'q (list 'b 'a 'r 'q 't)) (list 'b 'a 'r 't))
(check= (delete 5 (list 6 5)) (list 6))
(check= (delete "foo" (list 1 "foo" 2 "bar" 3 "foo" "foobar"))
        (list 1 2 "bar" 3 "foo" "foobar"))

;; 1. DEFINE the following function using delete.
;; permutation : List x List -> Boolean
;; (permutation l1 l2) returns t iff the lists have the same number of occurences
;; of all of the same elements.
(defunc permutation (l1 l2)
  :input-contract (and (listp l1) (listp l2))
  :output-contract (booleanp (permutation l1 l2))
  ;; delete every element in l1 from l2 and check if l2 is the same length
  (if (endp l1)
    (equal l1 l2) 
    (let ((deleted-list (delete (first l1) l2)))
     (and 
      (not (equal (len deleted-list) (len l2)))
      (permutation (rest l1) deleted-list)))))

; Write sufficient tests
(check= (permutation nil nil) t)
(check= (permutation nil '(1)) nil)
(check= (permutation '(1 2) nil) nil)
(check= (permutation '(1 2 4) '(4 1 2)) t)
(check= (permutation '(1 2 4) '(4 1 2 5)) nil)
(check= (permutation '(1 2 4) '(4 4 2)) nil)
(check= (permutation '(1 2 4 5) '(4 1 2)) nil)
(test? (implies (and (listp x) (listp y) (not (equal (len x) (len y)))) (equal (permutation x y) nil)))

;; GIVEN
;; listlistp : All -> Boolean
;; a predicate that checks whether an input is a list of lists
(defunc listlistp (ls)
  :input-contract t
  :output-contract (booleanp (listlistp ls))
  (and (listp ls)
       (or (endp ls)
           (and (listp (first ls))
                (listlistp (rest ls))))))
#|
;; 2. DEFINE the following function using permutation
;; permutation-list : ListList -> Boolean
;; Takes a list of lists and determines whether all the lists 
;; are permutations of each other. Passing in the empty list should return true.
(defunc permutation-list (ls)
  :input-contract (listlistp ls)
  :output-contract (booleanp (permutation-list ls))
  (if (< (len ls) 2)
    t
    (and (permutation (first ls) (second ls)) 
         (permutation-list (rest ls)))))

;; Write sufficient tests including use of a test? (not just check=)
(check= (listlistp '('(1 2 3)(3 2 1) (2 1 3))) t)
(check= (permutation-list '((1 2 3)(3 2 1) (2 1 3))) t)
(check= (permutation-list '('(1 2 3)(3 2 1) (3 2 1 3))) nil)

|#
#|
Programmers frequently need to switch between multiple implementations of the same 
function. This can be for a variety of reasons, from performance to readability.
Later on in this class, you will be proving that two different implementations of the
same function behave the same way. For now, write a new implementation of permutation-list
and sufficient tests to show that it behaves similarly to the old one. Define
permutation-list2, a version of permutation-list that does NOT use permutation in
its definition and processes all of the lists at once. Start with map-delete below.
You may need additional helper functions. If you write helper functions, make sure to test
them.

|#

;; 3. DEFINE
;; map-delete : All x ListList -> ListList
;; Returns a new list whose element lists are the result of calling delete 
;; on the old list's elements.
(defunc map-delete (e ls)
  :input-contract (listlistp ls)
  :output-contract (listlistp (map-delete e ls))
   ;; call delete on all elements of listlist
  (if (endp ls)
    nil
    (cons (delete e (first ls)) (map-delete e (rest ls)))))


;; Write sufficient tests
(test? (implies (endp x) (equal (map-delete e x) nil)))
(check= (map-delete 1 '((1) (1) (1))) '(()()()))
(check= (map-delete 1 '((1 2 3) (2 3))) '((2 3)(2 3)))
(check= (map-delete nil '(()()())) '(()()()))
(check= (map-delete nil '((())(())(()))) '(()()()))
(test? (implies (listlistp x) (equal (len x) (len (map-delete y x)))))


;; checks all lists in ls have length nat
(defunc check-all-lengths (nat ls)
  :input-contract (and (natp nat) (listlistp ls))
  :output-contract (booleanp (check-all-lengths nat ls))
(if (endp ls)
  t
  (and (equal (len (first ls)) nat)
       (check-all-lengths nat (rest ls)))))

(test? (implies (and (natp nat) (> 0 nat) (listlistp ls)) (equal nil (check-all-lengths nat ls))))
(test? (implies (and (listlistp ls) (endp ls) (natp x)) (equal t (check-all-lengths x ls))))
(test? (implies (and (listlistp ls) (natp x) ( > (len ls) 2) (not (equal (len (first ls)) (len (second ls))))) (equal nil (check-all-lengths x ls))))
(check= (check-all-lengths 1 (list '(1) '(1 2))) nil)
(check= (check-all-lengths 1 (list '(1) '(1 2))) nil)
(check= (check-all-lengths 2 (list '(1 2) '(1 2))) t)
(check= (check-all-lengths 3 (list '(1 2) '(1 2))) nil)

;; 4. DEFINE (use map-delete and NOT permutation)
;; permutation-list-help : List x ListList -> Boolean
;; Takes an initial list fst and a list of lists (ls) to compare against it.
;; Returns t iff each list in the list of lists is a permutation of the first.
;; You can (and should) write your own helper functions for this helper function.
;; PLEASE USE A COND IN YOUR FUNCTION
(defunc permutation-list-help (fst ls)
  :input-contract (and (listp fst) (listlistp ls))
  :output-contract (booleanp (permutation-list-help fst ls))
  (cond
   ((endp ls) t)
   ((endp fst) (check-all-lengths 0 ls))
   (t
    (let ((deleted-lists (map-delete (first fst) ls)))
    (and 
       (check-all-lengths (- (len fst) 1)
                          deleted-lists)
      (permutation-list-help (rest fst) deleted-lists))))))


;; Write some tests to check that it behaves correctly
(check= (permutation-list-help nil nil) t)
(check= (permutation-list-help nil '((1) (2))) nil)
(check= (permutation-list-help nil '(() ())) t)
(check= (permutation-list-help '((1) (2)) nil) t)
(test? (implies (and (listp fst) (listlistp ls) (endp ls)) (equal t (permutation-list-help fst ls))))
(check= (permutation-list-help '(1) '((1) (2 3))) nil)
(check= (permutation-list-help '(1 2 3) '((1 2 3) (3 2 1) (2 1 3))) t)

;; 5. DEFINE
;; permutation-list2 : Listlist -> Boolean
;; Takes a list of lists (ls) and determines whether all the sub-lists 
;; are permutations of each other. Passing in the empty list should return true.
(defunc permutation-list2 (ls)
   :input-contract (listlistp ls)
   :output-contract (booleanp (permutation-list2 ls))
   (if (endp ls) t
     (permutation-list-help (first ls) (rest ls))))


;; Write tests to check that it behaves the same way as permutation-list
;; Is there a way to get ACL2s to do most of the testing for you?
(test? (implies (and (listp ls) (consp ls) (permutation-list-help (first ls) (rest ls))) (equal (permutation-list2 ls) t)))
(test? (implies (and (listp ls) (endp ls)) (equal (permutation-list2 ls) t)))
(test? (implies (and (listp ls) (consp ls) (permutation-list2 ls)) (check-all-lengths (len (first ls)) ls)))
(check= (permutation-list2 nil) t)
(check= (permutation-list2 '(()()())) t)
(check= (permutation-list2 '(()()(1))) nil)
(check= (permutation-list2 '((1 1)(1)(1))) nil)
(check= (permutation-list2 '((1 2 3)(2 3 1)(1 3 2))) t)



(defdata lor (listof rational))

;; GIVEN (from HW2)
;; orderedp : Lor -> Boolean
;; returns t iff the input list is ordered from least to greatest
(defunc orderedp (lr)
  :input-contract (lorp lr)
  :output-contract (booleanp (orderedp lr))
  (or (or (endp lr) (endp (rest lr)))
      (and (<= (first lr)(second lr))
           (orderedp (rest lr)))))

(check= (orderedp '(1 2 3 4 5 6)) t)
(check= (orderedp '(1 2 3 4 4 6)) t)
(check= (orderedp '(1 2 3 5 4)) nil)
(check= (orderedp '()) t)
(check= (orderedp '(8/4)) t)
(check= (orderedp '(1/3 2 3 4 9/2 6)) t)
(test? (implies (and (lorp l) (consp l) (orderedp l))
                (orderedp (cons (first l) l))))
  

;; GIVEN
;; move-smallest-ne : Non-Empty Lor -> Non-Empty Lor
;; move-smallest-ne looks at each pair of elements and swaps them if they are in 
;; the wrong order. This moves the smallest element of the list all the way to 
;; the front and moves large elements one step to the right.
;; DO NOT make the recursive call to move-smallest-ne multiple times. Use a technique
;; from class that lets you call it just once and then reuse the value.
(defunc move-smallest-ne (l)
  :input-contract (and (lorp l) (consp l))
  :output-contract (and (lorp (move-smallest-ne l)) (consp (move-smallest-ne l)))
  (if (endp (rest l))                       ; The base case
    l
    (let* ( (f (first l))                   ; First element of the pair
            (b (move-smallest-ne (rest l))) ; Recursively apply move-smallest to the rest
            (s (first b)) )                 ; Second element of the pair
      (if (> f s)                           ; Should we swap?
        (cons s (cons f (rest b)))          ; Yes, swap the pair
        (cons f (cons s (rest b)))))))#|ACL2s-ToDo-Line|#
      ; No, leave them alone    


#|
6. SHORT ANSWER:
 ACL2s doesn't accept the function above unless both the input contract and 
 output contract specify that the list is non-empty. Try to remove each consp clause
 and see what errors ACL2s produces.
 
a. Why must the output contract specify that the list is non-empty?

The output contract must specify the list is non-empty so that the input contract can be satisfied when calling (rest b).


b. Why must the input contract specify that the list is non-empty?

The input contract must specify the list is non empty so that we can call (rest l) in the first line.
The input contract also follows the given signature for the function prompt in the comment.


|#

;; 7. DEFINE
;; move-smallest : Lor -> Lor
;; move-smallest looks at each pair of elements and swaps them if they are in 
;; the wrong order. This moves the smallest element of the list all the way to 
;; the front and moves large elements one step to the right
(defunc move-smallest (l)
  :input-contract (lorp l)
  :output-contract (lorp (move-smallest l))
   ...)

#|
;; 8. DEFINE
;; checksort : Lor -> Lor
;; checksort sorts the list by applying move-smallest until the list is sorted, checking
;; each time. We move to program mode for a second since proving that this function
;; terminates is highly non-trivial and far beyond ACL2s without guidance.
:program
(defunc checksort (l)
   ...)


;; Write some tests
............

:logic

#|
Checksort works, but it is really slow because it checks whether the list is
ordered on each iteration. Additionally, we can't prove that it terminates.
If we could figure out how many iterations to do beforehand, that would 
make this sorting algorithm much faster and ACL2s could prove that it terminates.
|#

;; 9. DEFINE
;; move-n-smallest : Lor x Nat -> Lor
;; move-n-smallest applies move-smallest to the list n times
(defunc move-n-smallest (l n)
   ...)

  

;; Tests
............

;; 10. DEFINE
;; repeatsort : Lor -> Lor
;; repeatsort sorts the input list from least to greatest 
;; by calling move-n-smallest with the appropriate inputs.
;; What is the minimum number of calls to move-n-smallest necessary
;; to ensure a sorted list.
(defunc repeatsort (l)
  .........)

;; Write some tests
.........

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Calculating Your Grade
;;
;; Soon I will be asking you to write a program which determines
;; your mark in the course (given that BB stinks for handling
;; dropped grades). Note, this also means that at the end of term, if
;; you ask us what your grade is or why blackboard is saying X, we will
;; point you to this assignment.
;; However, first I want to define how we can store these data 
;; (FYI: Yes THESE data. Data is the plural of datum)
;;
;; We will split grades up by category (exam, assignment, or quiz)
;; Each category has a name, its weight (percentage of total grade),
;; number of grades counted (to exclude dropped grades). the max score for 
;; each assignment, and a list of the grades in that category. A full gradebook
;; is composed of all three grade categories.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; 1. DEFINE an enumerated datatype for category names
;; (exam, assignment or quiz).
 (defdata category-name ...)

(check= (category-namep 'assignments) t)
(check= (category-namep 'tv) nil)

;; 2. DEFINE the possible weights as the range of rationals from 0 to 1, inclusive
 (defdata category-weight ...)


(check= (category-weightp 2/3) t)
(check= (category-weightp 5) nil)
(check= (category-weightp -2/3) nil)

;; 3. DEFINE a grade category as a record containing a name, weight, num-counted,
;; max-score, and grades. Num-counted and max-score shoud be positive naturals, 
;; and grades should be a list of rationals (to account for partial credit). 
;; More concretely, the tests below should pass.
(defdata grade-category ...)


(test? (implies (grade-categoryp c) (category-namep (grade-category-name c))))
(test? (implies (grade-categoryp c) (category-weightp (grade-category-weight c))))
(test? (implies (grade-categoryp c) (posp (grade-category-num-counted c))))
(test? (implies (grade-categoryp c) (posp (grade-category-max-score c))))
(test? (implies (grade-categoryp c) (lorp (grade-category-grades c))))

;; 4. DEFINE a gradebook as a record containing three grade categories: assignments,
;; quizes, and tests.
(defdata gradebook ...)

(test? (implies (gradebookp gb) (grade-categoryp (gradebook-assignments gb))))


;; 5. DEFINE a datatype for letter grades (A, A-, B+, B,.... F)
(defdata lettergrade ...)


(check= (lettergradep 'A) t)
(check= (lettergradep 'F) t)
(check= (lettergradep 'E) nil)
(check= (lettergradep 'A+) nil)
(check= (lettergradep 'D+) t)

;; Note: These constants will be useful later in the program
(defconst *num-assignments* 10)
(defconst *num-exams* 2)
(defconst *num-quizzes* 20)

(defconst *pct-assignments* 20/100)
(defconst *pct-quizzes* 20/100)
(defconst *pct-exams* 60/100)

(defconst *assignments-max* 100)
(defconst *exams-max* 100)
(defconst *quizzes-max* 24)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; To avoid having to keep typing a long list of grade records, it is handy
; to define a global constant which can then be used for many check= tests.
; You should put all of the grades of your team in a spreadsheet. Use your
; group name for the name of this spreadsheet. Your spreadsheet should
; contain your actual grades. Your check= tests should use your own 
; spreadsheet. Here is a modifiable example
(defconst *cs2800* 
  (gradebook (grade-category 'assignments 
                             *pct-assignments* *num-assignments* *assignments-max*
                             '(90 80 78 82 91 85 71 64 83 85 81))
             (grade-category 'quizzes 
                             *pct-quizzes* *num-quizzes* *quizzes-max*
                             '(18 18 18 18 24 24 24 18 18 18 24
                               0  0  18 0  24 6  18 0  24 18 12))
             (grade-category 'exams 
                             *pct-exams* *num-exams* *exams-max*
                             '(74 78))))

;; GIVEN (From HW2)
;; sum-l: lor -> rational
;; (sum-l lr) takes a list of rationals (lr) and returns the sum of all
;; elements in the list.  If lr is empty, then return 0.
(defunc sum-l (lr)
  :input-contract (lorp lr)
  :output-contract (rationalp (sum-l lr))
  (if (endp lr)
    0
    (+ (first lr)(sum-l (rest lr)))))


;; GIVEN (From HW2)
;; min-l: lor (non-empty) -> rational
;; (min-l lr) takes a non-empty list of rationals (lr) and finds
;; the smallest value in that list.
(defunc min-l (lr)
  :input-contract (and (lorp lr)(consp lr))
  :output-contract (rationalp (min-l lr))
  (if (endp (rest lr))
    (first lr)
    (if (<= (first lr) (min-l (rest lr)))
      (first lr)
      (min-l (rest lr)))))

;; this line is for ACL2s
(sig delete (all (listof :b)) => (listof :b))

;; 6. DEFINE
;; drop-n-lowest : Lor x Nat -> Lor
;; removes the n lowest rationals from the list, up to the length of the list
(defunc drop-n-lowest (l n)
  ...)


;; Write sufficient tests
............

;; 7. DEFINE
;; get-counted-grades : grade-category -> lorp
;; returns a list containing all of the grades that should be counted from this
;; category
(defunc get-counted-grades (c)
    ...)
  
;; Write sufficient tests
..............


;; 8. DEFINE
;; get-category-grade : grade-category -> rational
;; returns the overall grade in the given category as a rational 
;; in the range 0 <= r <= 1
(defunc get-category-grade (c)
    ...)

;; Write sufficient tests
.............


;; don't ask why this is necessary here; it's complicated
:program

;; 9. DEFINE
;; get-category-grade : gradebook -> lettergrade
;; returns the overall grade in class as a letter grade. For the purposes of this
;; assignment, assume that grades are assigned to the following ranges:
;; F: 0 <= _ < 50
;; D-: 50 <= _ < 60
;; D: 60 <= _ < 65
;; D+: 65 <= _ < 70
;; C-: 70 <= _ < 74
;; C: 74 <= _ < 77
;; C+: 77 <= _ < 80
;; B-: 80 <= _ < 84
;; B: 84 <= _ < 87
;; B+: 87 <= _ < 90
;; A-: 90 <= _ < 94
;; A: 94 <= _ <= 100
;; Please define constansts for the letter grade ranges
(defunc get-grade (gb)
    ...)


;; Write sufficient tests
...........|#