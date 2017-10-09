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

The Imitation Game (BEGINNER mode).

You may see some warnings here and there for some of the code.
You can ignore them. As long as the output is green, you are good to go.

The following directives relax the strictness of various checks and tests performed by ACL2s.

|#

(set-defunc-termination-strictp nil)
(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)
(set-defunc-timeout 3)
(acl2s-defaults :set cgen-timeout 1)

#|

This lab is about a simple encryption scheme, the kind we saw in class.

Your goal is to decrypt the following two secret messages.
Each message is a list of lists of 5 Booleans each.

Remember that defconst defines constants,
and that the *...* is a convention used to denote such constants.

|#

(defconst *code1*
  '((NIL NIL NIL NIL NIL)
    (T   NIL T   NIL NIL)
    (T   NIL T   T   T  )
    (NIL T   NIL NIL T  )
    (NIL NIL NIL T   T  )
    (NIL NIL T   T   T  )
    (T   T   NIL T   T  )
    (T   NIL NIL NIL T  )
    (T   T   NIL NIL T  )
    (NIL T   NIL NIL T  )
    (T   NIL NIL T   NIL)
    (NIL NIL NIL T   NIL)
    (T   T   T   NIL T  )
    (NIL NIL T   NIL T  )
    (T   T   T   T   NIL)
    (NIL T   NIL NIL T  )
    (T   NIL T   T   NIL)
    (T   T   T   NIL T  )
    (NIL NIL T   NIL NIL)
    (NIL T   NIL NIL T  )
    (T   T   NIL T   NIL)
    (NIL NIL T   T   T  )
    (T   T   T   T   T  )
    (T   T   T   NIL NIL)
    (T   NIL T   T   T  )
    (T   NIL NIL NIL NIL)
    (NIL T   NIL NIL T  )
    (T   T   T   NIL T  )
    (NIL NIL T   T   NIL)
    (T   NIL T   T   T  )
    (NIL NIL NIL T   NIL)
    (NIL T   NIL NIL T  )
    (NIL NIL NIL NIL NIL)
    (T   NIL T   NIL NIL)
    (T   NIL T   T   T  )
    (NIL T   NIL NIL T  )
    (T   T   NIL NIL NIL)
    (T   NIL NIL T   T  )
    (NIL T   NIL T   NIL)
    (NIL T   NIL T   T  )
    (NIL T   NIL NIL T  )
    (T   NIL NIL NIL NIL)
    (T   T   T   NIL T  )
    (T   NIL T   NIL T  )
    (NIL T   T   T   NIL)
    (NIL NIL NIL NIL T  )
    (NIL T   NIL NIL T  )
    (T   NIL NIL T   NIL)
    (T   NIL NIL T   T  )
    (T   NIL NIL NIL T  )
    (T   T   NIL NIL T  )))

(defconst *code2*
  '((T   NIL NIL T   NIL)
    (T   NIL NIL NIL T  )
    (NIL NIL T   NIL NIL)
    (T   NIL NIL NIL T  )
    (NIL T   NIL NIL NIL)
    (NIL NIL T   T   T  )
    (NIL T   T   T   T  )
    (NIL NIL T   T   NIL)
    (T   NIL NIL T   NIL)
    (T   NIL NIL NIL T  )
    (NIL T   T   T   T  )
    (T   NIL T   NIL T  )
    (T   T   NIL NIL NIL)
    (NIL NIL T   T   T  )
    (NIL NIL NIL T   T  )
    (T   NIL NIL NIL T  )
    (NIL NIL T   NIL NIL)
    (NIL T   T   T   T  )
    (NIL NIL T   T   NIL)
    (T   T   NIL T   T  )
    (NIL T   T   T   T  )
    (NIL NIL T   T   NIL)
    (T   NIL NIL T   NIL)
    (T   NIL NIL NIL T  )
    (NIL T   T   T   T  )
    (NIL NIL T   NIL T  )
    (NIL NIL NIL NIL T  )
    (T   T   T   NIL T  )
    (NIL T   T   NIL NIL)
    (NIL T   T   T   T  )
    (NIL NIL T   T   NIL)
    (T   T   NIL T   T  )
    (T   T   NIL NIL T  )
    (T   T   NIL T   T  )
    (NIL NIL T   NIL NIL)
    (NIL NIL T   NIL NIL)
    (T   T   NIL T   T  )
    (NIL NIL NIL T   T  )
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   NIL T   T   NIL)
    (T   NIL NIL NIL T  )
    (T   NIL NIL NIL NIL)
    (NIL NIL NIL NIL T  )
    (T   T   NIL NIL NIL)
    (T   NIL T   T   T  )
    (NIL T   T   T   T  )
    (T   NIL T   NIL T  )
    (T   T   NIL T   NIL)
    (T   T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (NIL NIL NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   T   NIL T  )
    (NIL T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   T   T   NIL)
    (T   T   T   NIL T  )
    (T   T   NIL NIL NIL)
    (T   T   NIL T   NIL)
    (NIL NIL NIL NIL T  )
    (NIL NIL T   T   NIL)
    (NIL T   NIL NIL T  )
    (T   NIL T   T   T  )
    (T   T   NIL T   T  )
    (T   T   NIL NIL NIL)
    (NIL NIL T   T   NIL)
    (NIL NIL T   NIL NIL)
    (T   NIL T   NIL T  )
    (T   NIL T   T   T  )
    (NIL NIL T   T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   NIL T   NIL T  )
    (T   T   NIL NIL NIL)
    (T   NIL T   T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   T   T   T   NIL)
    (T   T   T   NIL T  )
    (NIL NIL T   T   T  )
    (NIL NIL T   T   NIL)
    (T   T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL NIL NIL T   NIL)
    (NIL T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   T   T   T   NIL)
    (T   T   T   NIL T  )
    (NIL NIL T   T   T  )
    (NIL NIL T   T   NIL)
    (T   T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   T   NIL T  )
    (NIL T   NIL T   NIL)
    (NIL T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   T   T   NIL)
    (T   T   NIL T   T  )
    (NIL NIL NIL NIL T  )
    (NIL NIL T   T   NIL)
    (T   T   NIL T   NIL)
    (NIL NIL NIL NIL T  )
    (NIL NIL T   T   NIL)
    (NIL T   NIL NIL T  )
    (T   NIL T   T   T  )
    (T   T   NIL T   T  )
    (T   T   NIL NIL NIL)
    (NIL NIL T   T   NIL)
    (NIL NIL T   NIL NIL)
    (T   NIL T   NIL T  )
    (T   NIL T   T   T  )
    (NIL NIL T   T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   T   T   T   NIL)
    (T   T   T   NIL T  )
    (NIL NIL T   T   T  )
    (NIL NIL T   T   NIL)
    (T   T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   NIL T   NIL T  )
    (T   T   NIL T   NIL)
    (T   T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL NIL NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   T   NIL T  )
    (NIL T   NIL T   NIL)
    (NIL T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   T   T   NIL T  )
    (T   NIL NIL NIL NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   NIL NIL NIL T  )
    (T   T   NIL NIL NIL)
    (T   NIL T   T   NIL)
    (T   T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL NIL NIL T   NIL)
    (NIL T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   T   NIL T  )
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   NIL T   T   T  )
    (T   T   NIL T   T  )
    (T   T   NIL NIL NIL)
    (NIL NIL T   T   T  )
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   NIL NIL NIL NIL)
    (T   T   T   NIL T  )
    (NIL NIL T   NIL NIL)
    (NIL NIL T   T   T  )
    (NIL NIL T   T   NIL)
    (NIL T   T   T   T  )
    (NIL NIL NIL T   NIL)
    (NIL T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (T   NIL T   NIL T  )
    (T   T   NIL T   NIL)
    (T   T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   NIL T   T  )
    (NIL NIL T   NIL NIL)
    (T   NIL NIL NIL T  )
    (NIL NIL T   T   T  )
    (NIL NIL T   T   NIL)
    (NIL T   T   T   T  )
    (NIL NIL NIL T   NIL)
    (NIL T   NIL T   NIL)
    (NIL T   T   T   T  )
    (NIL T   T   NIL T  )
    (NIL T   NIL T   NIL)
    (NIL T   NIL T   NIL)
    (NIL T   NIL T   NIL)
    (NIL T   NIL T   NIL)))

; Let's begin with two data definitions.

; Here is a data definition for 32 characters.
(defdata char 
  (enum '(#\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M #\N 
          #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z #\Space 
          #\: #\- #\' #\( #\)))) 

; Here is a data definition for a list of exactly 5 Booleans.
; The name bv is an abbreviation of BitVector.
(defdata bv (list boolean boolean boolean boolean boolean))

; Each such list of 5 Booleans corresponds to a text character,
; via the following mapping between char and bv:

(defconst *bv-char-map*
  '((#\A (nil nil nil nil nil))
    (#\B (nil nil nil nil t))
    (#\C (nil nil nil t nil))
    (#\D (nil nil nil t t))
    (#\E (nil nil t nil nil))
    (#\F (nil nil t nil t))
    (#\G (nil nil t t nil))
    (#\H (nil nil t t t))
    (#\I (nil t nil nil nil))
    (#\J (nil t nil nil t))
    (#\K (nil t nil t nil))
    (#\L (nil t nil t t))
    (#\M (nil t t nil nil))
    (#\N (nil t t nil t))
    (#\O (nil t t t nil))
    (#\P (nil t t t t))
    (#\Q (t nil nil nil nil))
    (#\R (t nil nil nil t))
    (#\S (t nil nil t nil))
    (#\T (t nil nil t t))
    (#\U (t nil t nil nil))
    (#\V (t nil t nil t))
    (#\W (t nil t t nil))
    (#\X (t nil t t t))
    (#\Y (t t nil nil nil))
    (#\Z (t t nil nil t))
    (#\Space (t t nil t nil))
    (#\: (t t nil t t))
    (#\- (t t t nil nil))
    (#\' (t t t nil t))
    (#\( (t t t t nil))
    (#\) (t t t t t))))

; Here is a data definition for a list of two elements.
(defdata pair (list all all))

; Here is a data definition for a list of pairs.
(defdata plist (listof pair))

; Now define a function that, given a character c and a plist l,
; returns the first pair that has c as its first element,
; or nil if no such pair exists.

(defunc find (c l)
  :input-contract (plistp l)
  :output-contract (listp (find c l))
  (cond 
   ((endp l) nil)
   ((equal (first (first l)) c) (first l))
   (t (find c (rest l)))))

(check= (find #\W *bv-char-map*) '(#\W (t nil t t nil)))

; Now define a function that, given a bv b and a plist l,
; returns the first pair that has b as its second element,
; or nil if no such pair exists.

(defunc find2 (b l)
  :input-contract (and (bvp b) (plistp l))
  :output-contract (listp (find2 b l))
  (cond 
   ((endp l) nil)
   ((equal (second (first l)) b) (first l))
   (t (find2 b (rest l)))))

(check= (find2 '(t nil t t nil) *bv-char-map*) '(#\W (t nil t t nil)))

; Next define functions that, given a char c,
; return the corresponding bv and the other way around.
(defunc char2bv (c)
  :input-contract (charp c)
  :output-contract (bvp (char2bv c))
  (second (find c *bv-char-map*)))
  
(check= (char2bv #\W) '(t nil t t nil))

(defunc bv2char (b)
  :input-contract (bvp b)
  :output-contract (charp (bv2char b))
  (first (find2 b *bv-char-map*)))

(check= (bv2char '(t nil t t nil)) #\W)

; Here are data definitions for a listof bitvectors and characters.
; This allows us to construct messages out of characters or out of bit vectors.

(defdata lobv   (listof bv))
(defdata lochar (listof char))

; Remember the definition of xor (not predefined, so we define it):
(defunc xor (a b)
  :input-contract (and (booleanp a) (booleanp b))
  :output-contract (booleanp (xor a b))
  (if a (not b) b))

; Here is a definition for a list of booleans.
(defdata lob (listof boolean))

; Here is a function that xor's lists of bits.
; The contracts are a little more complicated than we usually write,
; but we really do want that lengths of the input lists to be equal.
(defunc xor-list (b1 b2)
  :input-contract  (and (lobp b1) (lobp b2)     (equal (len b1) (len b2)))
  :output-contract (and (lobp (xor-list b1 b2)) (equal (len (xor-list b1 b2)) (len b1)))
  :function-contract-hints (("goal" :induct (xor-list b1 b2))) ; ignore this line!
  (if (endp b1)
    nil
    (cons (xor (first b1) (first b2))
          (xor-list (rest b1) (rest b2)))))

; Next we have a test? for sanity checking that claims that if we
; apply xor-list on bv's then we get bv's back. 
(test? 
  (implies (and (bvp b1) (bvp b2))
           (bvp (xor-list b1 b2))))

; Ignore this
(acl2::in-theory (acl2::disable charp bvp xor-list-definition-rule
                                bv2char-definition-rule
                                char2bv-definition-rule))

; Now let's define a function to encrypt a character c,
; given a secret key k as a bitvector.
(defunc encrypt-char (c k)
  :input-contract (and (charp c) (bvp k))
  :output-contract (bvp (encrypt-char c k))
  ;; get the char bvp
  (xor-list (char2bv c) k))

(check= (encrypt-char #\B '(t nil t nil t)) '(t nil t nil nil))

; Ignore this
(acl2::in-theory (acl2::disable charp bvp encrypt-char-definition-rule))

; Now, let's define a function to encrypt a message against a key k,
; based on the lecture notes on one-time pads (the "power of xor")

(defunc encrypt (m k)
  :input-contract  (and (locharp m) (lobvp k) (equal (len m) (len k)))
  :output-contract (and (lobvp (encrypt m k)) (equal (len (encrypt m k)) (len m)))
  (if (endp m)
    nil
    (cons (encrypt-char (first m) (first k))
          (encrypt (rest m) (rest k)))))

; Here is a function that makes a list containing n copies of e.
(defunc copy (e n)
  :input-contract (natp n)
  :output-contract t
  (if (equal n 0)
    nil
    (cons e (copy e (- n 1)))))

; Here are our (really bad!) keys.
; They are really bad because they should be a random sequence of bit vectors!
(defconst *secret1* (copy '(t nil nil t t) (len *code1*)))
(defconst *secret2* (copy '(t nil t nil t) (len *code2*)))

; Here is how we write a function to decrypt a bv b using the secret key k.
(defunc decrypt-bv (b k)
  :input-contract (and (bvp b) (bvp k))
  :output-contract (charp (decrypt-bv b k))
  (bv2char (xor-list b k)))

; Write a function to decrypt a encrypted message ("cypher") c,
; using the secret key k.
(defunc decrypt (c k)
  :input-contract (and (lobvp c) (lobvp k)
                       (equal (len c) (len k)))
  :output-contract (locharp (decrypt c k))
  (if (endp c)
    nil
    (cons (decrypt-bv (first c) (first k))
          (decrypt (rest c) (rest k)))))

; Write a test? to make sure encrypt and decrypt work as expected
(test? (implies (and (locharp m) (lobvp s) 
                     (equal (len m) (len s))) (equal m (decrypt (encrypt m s)))))

; Now, let's see what those secret messages say.
; We're going to turn the list of characters into a string for
; better readability as follows.

(acl2::coerce (decrypt *code1* *secret1*) 'string)
; The above is an important message. Look up why.

(acl2::coerce (decrypt *code2* *secret2*) 'string)
(test? (implies (and (booleanp a) (booleanp b)) (equal (xor a (xor a b)) b)))
(test? (implies (booleanp a) (equal (xor a a) nil)))
(test? (implies (booleanp a) (equal (xor a nil) a)))#|ACL2s-ToDo-Line|#

|#