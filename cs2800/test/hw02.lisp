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

CS 2800 Homework 2 - Fall 2017

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
Names of ALL group members: Dylan Wight, Julia Wlochowski

* Later in the term if you want to change groups, the person who created
  the group should stay in the group. Other people can leave and create 
  other groups or change memberships (the Axel Rose membership clause). 
  We will post additional instructions about this later.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw02.lisp

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

- when done, save your file and submit it as hw02.lisp

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

|#

#|

Since this is our first programming exercise, we will simplify the
interaction with ACL2s somewhat: instead of asking it to formally *prove*
the various conditions for admitting a function, we will just require that
they be *tested* on a reasonable number of inputs. This is achieved using
the following directive (do not remove it!):

|#
:program

#|

Notes:

1. Testing is cheaper but less powerful than proving. So, by turning off
proving and doing only testing, it is possible that the functions we are
defining cause runtime errors even if called on valid inputs. In the future
we will require functions complete with admission proofs, i.e. without the
above directive. For this first homework, the functions are simple enough
that there is a good chance ACL2s's testing will catch any contract or
termination errors you may have.

2. The tests ACL2s runs test only the conditions for admitting the
function. They do not test for "functional correctness", i.e. does the
function do what it is supposed to do? ACL2s has no way of telling what
your function is supposed to do. That is what your own tests are for.

3. For now, testing is written using check= expressions.  These take the following
format (and should be familiar to those of you that took Fundies I)
(check= <expression> <thing it should be equal to>)
EX: (check= (- 4/3 1) 1/3)

|#

#|
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Part I:
 The functions below should warm you up for the rest of the 
 assignment.
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 But first, let me get ahead of myself.  Typically we would ask
 these sorts of questions for HW03 or 4 but we need a special kind
 of list: a list of rationals (lor).  The data definition below
 creates a data type called a list of rationals which is a list that
 can ONLY have rational numbers in it (no need to test if a list
 element is a rational, just need to check if the list is empty or not).
 This list also has a built in recognizer "lorp" which tests if 
 a variable is a list of rationals.  We will write a series of functions
 that calculate the mean, median and mode of a list of rational numbers.
 I've also created a list of natural numbers that can be recognized
 by calling "lonp"
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#
;; Lists of rational numbers
(defdata lor (listof rational))
;; Lists of natural numbers
(defdata lon (listof nat))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; how-many: All x List -> Nat
;;
;; (how-many e l) returns the number of occurrences of element e 
;; in list l.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc how-many (e l)
  :input-contract (listp l)
  :output-contract (natp(how-many e l))
  (if (endp l) 0 
    ;; did we find e?
    (+ (if (equal e (first l)) 1 0) 
       (how-many e (rest l)))))

(check= (how-many  1 ())     0)
(check= (how-many  1 '(1 1)) 2)
;; Remember to add additional tests
(check= (how-many nil ()) 0)
(check= (how-many nil '(1 2)) 0)
(check= (how-many 'a '('b 'c 1)) 0)
(check= (how-many 1 '(1 2 3 1)) 2)  
(check= (how-many nil '(nil)) 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; tser: List (non-empty) -> List
;; TSER is just rest backwards. Thus (tser l) removes the last
;; element in list l and returns all other elements in the list
;; in their original order.
(defunc tser (l)
  :input-contract (and (listp l)(consp l))
  :output-contract (listp (tser l))
  (if (endp l) nil
    ;; second-to-last
    (if (endp (rest l)) nil
      ;; recurse
      (cons (first l) (tser (rest l))))))

(check= (tser '(a b c)) '(a b))
;; Add tests
(check= (tser '(1)) nil)
(check= (tser '(1 2 3)) '(1 2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; sum-l: lor -> rational
;; (sum-l lr) takes a list of rationals (lr) and returns the sum of all
;; elements in the list.  If lr is empty, then return 0.
(defunc sum-l (lr)
  :input-contract (lorp lr)
  :output-contract (rationalp (sum-l lr))
  (if (endp lr) 0
    (+ (first lr) (sum-l (rest lr)))))

(check= (sum-l nil) 0)
(check= (sum-l '(1)) 1)
(check= (sum-l '(1 -1 0)) 0)
(check= (sum-l '(3/4 1/4 1/2)) 3/2)
        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; flat-listp
;; flat-listp: Any -> Boolean
;;
;; (flat-list l) takes an input l and returns true if and only if
;; l is a list AND each element in l is not a list. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc flat-listp (l)
  :input-contract (listp l)
  :output-contract (booleanp (flat-listp l))
  (if (endp l) t
    (and (not (listp (first l))) (flat-listp (rest l)))))

(check= (flat-listp '(1 2 (3))) nil)
(check= (flat-listp '(1 2 3)) t)
;; Make sure you add additional tests
(check= (flat-listp nil) t)
(check= (flat-listp '(())) nil)
(check= (flat-listp '(t t nil)) nil)
(check= (flat-listp '(t t)) t)
(check= (flat-listp '('(1) 1)) nil)


#|
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Part II: List manipulation
 This following section deals with functions involving lists in general.
 Some functions you write may be useful in subsequent functions.
 In all cases, you can define your own helper functions if that simplifies
 your code
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#


 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; DEFINE
 ;; find-in: Atom x List -> Boolean
 ;; find-in takes an singleton element (e) (which is NOT a list) 
 ;; plus a list to search (l) and returns true if e is anywhere in
 ;; l, including in a sublist. See the checks below for examples.
 ;; When do you stop? When will you need to search a sub-list?
 ;; HOW do you search that sub-list?
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (defunc find-in (e l)
   :input-contract (and (atom e)(listp l))
   :output-contract (booleanp (find-in e l))
   (if (endp l) nil
     (or 
      (if (consp (first l))
        (find-in e (first l))
        (equal (first l) e))
      (find-in e (rest l)))))

(check= (find-in 4 '(a (2 4) 3)) t)
(check= (find-in 4 '(a (2 3) 4)) t)
(check= (find-in 4 '(a (2 5) 3)) nil)
(check= (find-in 4 '(a (2 (3 (2 1) (3 4)) 3))) t)
(check= (find-in 'a nil) nil)
(check= (find-in 'a '(a (2 a) 3)) t)
(check= (find-in nil '(a () 3)) t) ;; What's going on here? There is an empty list inside l, which is nil
(check= (find-in nil nil) nil)
(check= (find-in nil '(1 2 3)) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; orderedp: lor -> boolean
;; (orderedp lr) takes a list of rationals and returns true if
;; the elements are in non-descending order (thus element i is <= 
;; element i+1.
;; NOTE: This function would be written as a cond in subequent assignments
;; but nested if statements are OK for HW02.
(defunc orderedp (lr)
  :input-contract (lorp lr)
  :output-contract (booleanp (orderedp lr))
  (cond
   ((endp lr) t)
   ((endp (rest lr)) t)
   ((and 
     (<= (first lr) (first (rest lr)))
     (orderedp (rest lr))))))
  

(check= (orderedp '(1 2 2 3)) t)
(check= (orderedp '(1 2 2 1)) nil)
(check= (orderedp nil) t)
(check= (orderedp '(1/2 2/3 3/4 1 57/3)) t)
(check= (orderedp '(1)) t)
(check= (orderedp '(2 -2)) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; min-l: lor (non-empty) -> rational
;; (min-l lr) takes a non-empty list of rationals (lr) and finds
;; the smallest value in that list.
(defunc min-l (lr)
  :input-contract (and (lorp lr)(consp lr))
  :output-contract (rationalp (min-l lr))
  (if (endp (rest lr)) 
    (first lr)
    (if (< (first lr) (min-l (rest lr)))
           (first lr)
           (min-l (rest lr)))))

;;Add Tests
(check= (min-l '(1)) 1)
(check= (min-l '(3 2)) 2)
(check= (min-l '(3 3 3)) 3)
(check= (min-l '(3 2 1)) 1)
(check= (min-l '(3 -3 1)) -3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; delete: All x List -> List
;; (delete e l) removes the FIRST instance of element e from list l
;; and returns the modified list.
(defunc delete (e l)
  :input-contract (listp l)
  :output-contract (listp (delete e l))
  (if (endp l)
    l
    (if (equal e (first l))
      (rest l)
      (cons (first l)(delete e (rest l))))))

;; Please ignore this line. It lets ssort work
;; If in program mode, then you can leave this commented out.
;(sig delete (all (listof :b)) => (listof :b))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; ssort: lor -> lor
;; (ssort lr): ssort or selection sort takes a list of rationals
;; and sorts it by selecting the minimum value in the list,
;; removing / deleting it from it's position in the list and 
;; putting it at the front of the sorted list.
;; Thus for '(4 3 1 2) you would cons 1 on the front of (ssort '(4 3 2)) or
;; '(1 2 3 4)
(defunc ssort (lr)
  :input-contract (lorp lr)
  :output-contract (lorp lr)
   (if (endp lr) 
     lr
     (cons (min-l lr) (ssort (delete (min-l lr) lr)))))

(check= (ssort '(4 3 1 2 4 5)) '(1 2 3 4 4 5))
;; Add additional tests
(check= (ssort nil) nil)
(check= (ssort '(1)) '(1))
(check= (ssort '(1 2 3 4)) '(1 2 3 4))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Part III: Descriptive Statistics
;; Finally, let's consider the differences between mean, median,
;; and mode. Remember, you can use any of the previously defined 
;; functions.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; Mean: lor (non-empty) -> rational
;; (mean lr) takes a list of rationals lr and calculates the mean
;; or "average" of the list (sum all elements then divide by number
;; of elements).
(defunc mean (lr)
  :input-contract (and (consp lr) (lorp lr))
  :output-contract (rationalp (mean lr))
  (/ (sum-l lr)(len lr)))

;; Tests
(check= (mean '(1)) 1)
(check= (mean '(2 3)) 5/2)
(check= (mean '(-1/2 3/2)) 1/2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; get-ith: Nat x List -> All
;; (get-ith i l) returns the ith element (counting from 0) in
;; l.  We guarantee that i < (len l) otherwise the returned value
;; may not make sense.
(defunc get-ith (i l)
  :input-contract (and (natp i)(lorp l)(< i (len l)))
  :output-contract (rationalp (get-ith i l))
  (if (equal i 0) (first l)(get-ith (- i 1) (rest l))))

(check= (get-ith 0 '(1 2 3/2)) 1)
(check= (get-ith 1 '(1 2 3/2)) 2)
(check= (get-ith 2 '(1 2 3/2)) 3/2)
(check= (get-ith 3 '(1 2 3/2 -17)) -17)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; nat-half: Nat -> Nat
;; (nat-half n) takes a natural number n and divides
;; it by 2.  If n is odd, then round down. Otherwise
;; return n/2
(defunc nat-half (n)
  :input-contract (natp n)
  :output-contract (natp (nat-half n))
  (if (natp (/ n 2))
    (/ n 2)
    (/ (- n 1) 2)))

(check= (nat-half 17) 8)
(check= (nat-half 18) 9)
(check= (nat-half 3) 1)
(check= (nat-half 4) 2)
(check= (nat-half 0) 0)
(check= (nat-half 1) 0)


;; Please ignore this
(defthm gi_thm (implies (and (listp l)(consp l))
                        (< (nat-half (len l))(len l))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; mid-element: List (not empty) -> All
;; (mid-element l) takes a non-empty list l and
;; returns the middle element so (mid-element '(1 2 3))
;; returns 2. (mid-element '(1 2)) returns 1.
(defunc mid-element (l)
  :input-contract (and (lorp l)(consp l))
  :output-contract (rationalp (mid-element l))
  (get-ith (nat-half (- (len l) 1)) l))

(check= (mid-element '(1 2 3/2)) 2)
(check= (mid-element '(1 2 3/2 -4)) 2)
(check= (mid-element '(1 2 3/2 -4 5)) 3/2)
(check= (mid-element '(1)) 1)
(check= (mid-element '(1 2)) 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; median: lor (non-empty) -> rational
;; (median lr) takes a list of rationals (lr) and returns the
;; element in the "middle" of the list.  Middle meaning half
;; the elements of the list are smaller or equal and half are 
;; greater or equal.
;; You will probably need to use previously defined functions 
;; and helper functions
;; NOTE: later in the term we will prove that sorting doesn't
;; change the list size but for the time being, return 0 if it 
;; is empty (this should be dead code)
;; NOTE 2: The median for odd length lists should be the average
;; of the two middle elements.  We're ignoring this.  Just return
;; the element in the middle.  Thus (median '(1 2 3 4)) returns 2,
;; not 5/2.
(defunc median (lr)
  :input-contract (and (lorp lr)(consp lr))
  :output-contract (rationalp (median lr))
    (mid-element (ssort lr)))

(check= (median '(1)) 1)
(check= (median '(1 2 3 4)) 2)
(check= (median '(1 7 1 7 1 7 5)) 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; hm-list: lor -> lon
;; (hm-list lr) or takes a list of rationals lr and finds the number
;; of occurances of each element for each position, and returns
;; a list of the frequencies (natural numbers)
;; REMEMBER: you can use functions defined above. Also, notice
;; the example below. The first 4 was found 3 times in the list
;; but the second 4 is found twice (in list '(4 2 1 4 2 2 1))
;; This is OK because we are looking for the highest frequency occurance.
(defunc hm-list (lr)
  :input-contract (lorp lr)
  :output-contract (lonp (hm-list lr))
  (if (endp lr) nil
    (cons
     (how-many (first lr) lr)
     (hm-list (rest lr)))))
                      


(check= (hm-list '(4 3 4 2 1 4 2 2 1)) '(3 1 2 3 2 1 2 1 1))
(check= (hm-list '(4 4 4 4)) '(4 3 2 1))
(check= (hm-list nil) nil)
(check= (hm-list '(4 3 2 1)) '(1 1 1 1))
(check= (hm-list '(0)) '(1))
(check= (hm-list '(4/2 4/2 4/2 4/2 -42)) '(4 3 2 1 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE (look at your definition of min-l to help)
;; max-l: lor (non-empty) -> rational
;; (max-l lr) takes a non-empty list of rationals (lr) and finds
;; the largest value in that list.
(defunc max-l (lr)
  :input-contract (and (lorp lr)(consp lr))
  :output-contract (rationalp (max-l lr))
  (if (endp (rest lr)) 
    (first lr)
    (if (> (first lr) (max-l (rest lr)))
           (first lr)
           (max-l (rest lr)))))

;;Write more tests.
(check= (max-l '(4 -7 3 0)) 4)
(check= (max-l '(1)) 1)
(check= (max-l '(3 2)) 3)
(check= (max-l '(3 3 3)) 3)
(check= (max-l '(3 2 1)) 3)
(check= (max-l '(3 -3 1)) 3)
(check= (max-l '(1/2 1/20 1/200)) 1/2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; get-idx: All x List -> Nat
;; (get-idx e l) return the 0 based index of element e in list l
;; provided it exists or it returns the length of l if no
;; match is found.
(defunc get-idx (e l)
  :input-contract (listp l)
  :output-contract (natp (get-idx e l))
  (cond ((endp l)  0)
        ((equal e (first l))  0)
        (t                   (+ 1 (get-idx e (rest l))))))
  

(check= (get-idx 2 '(1 5 3 2)) 3)
(check= (get-idx 7 '(1 5 3 2)) 4) ;; no match found
(check= (get-idx 7 '(7 5 3 2)) 0)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; Mode: lor (non-empty) -> rational
;; (mode lr) take a list of rationals lr and finds the most common
;; element in the list (the mode). If there are multiple different
;; solutions, you can return any of these values.
;; Remember: you can call previously defined functions
(defunc mode (lr)
  :input-contract (and (lorp lr) (consp lr))
  :output-contract (rationalp (mode lr))
  (get-ith (get-idx (max-l (hm-list lr)) (hm-list lr)) lr))

(check= (mode '(1 2 3 4 1 2 1)) 1)
(check= (mode '(1 2 2 2 4 -1 0)) 2)
;; Write additonal tests
(check= (mode '(1 1 1 2 2 2 3)) 1)
(check= (mode '(1)) 1)
(check= (mode '(1/2 2/4 3/6 2 2)) 1/2)#|ACL2s-ToDo-Line|#

        


                             