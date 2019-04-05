#lang at-exp racket

;;A representation of & functions for Apertium's (bilingual) dictionaries

(require scribble/srcdoc
         (for-doc racket/base scribble/manual))

(module+ test
  (require rackunit))


;;;;;;;;;;;;
;; Constants


(define LR "LR")
(define RL "RL")
(define STANDARD "standard")
(define PREBLANK "preblank")
(define POSTBLANK "postblank")
(define INCONDITIONAL "inconditional")


;;;;;;;;;;;;;;;;;;;
;; Data definitions


(struct dictionary (lang alphabet sdefs pardefs sections attrs))

(provide
 (struct*-doc
  dictionary ([lang symbol?]
              [alphabet string?]
              [sdefs (listof sdef?)]
              [pardefs (listof pardef?)]
              [sections (listof section?)]
              [attrs (hash/c symbol? string?)])
  ("interpretation: an Apertium dictionary (read: contents of a .dix file)."
   @itemlist[@item{@(racket dictionary-lang) : ISO 639-3 code(s) of the
              language(s)}
             @item{@(racket dictionary-alphabet) : relevant for a monolingual
              dictionary only}
             @item{@(racket dictionary-sdefs) : grammatical symbols used in
              dictionary entries}
             @item{@(racket dictionary-pardefs) : paradigm definitions}
             @item{@(racket dictionary-sections) : lists of dictionary entries}
             @item{@(racket dictionary-attrs) : user-defined attributes
              with name and value}])))

(define D-0
  (dictionary
   'eng
   "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
   '() '() '() (hash)))

(provide
 (thing-doc
  D-0 dictionary?
  ("An example of an empty English dictionary:"
   @(racketblock
     (define D-0
       (dictionary
        'eng
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        '() '() '() (hash)))))))

(define D-B-0
  (dictionary
   'eng-tat
   ""
   '() '() '() (hash)))

(provide
 (thing-doc
  D-B-0 dictionary?
  ("An empty English-Tatar bilingual dictionary:"
   @(racketblock
     (define D-B-0
       (dictionary
        'eng-tat
        "" '() '() '() (hash)))))))


(struct sdef (n))

(provide
 (struct*-doc
  sdef ([n string?])
  ("interpretation: a symbol definition."
   @itemlist[@item{@(racket sdef-n) : grammatical symbol used in dictionary
              pardefs or entries.}])))

(define SDEF-0 (sdef "n"))

(provide
 (thing-doc
  SDEF-0 sdef?
  ("A noun symbol."
   @(racketblock
     (define SDEF-0 (sdef "n"))))))


(struct pardef (n con))

(provide
 (struct*-doc
  pardef ([n string?] [con (listof e?)])
  ("interpretation: a paradigm definition."
   @itemlist[@item{@(racket pardef-n) : the name of the paradigm}
             @item{@(racket pardef-con) : its content}])))


(struct section (n type con))

(provide
 (struct*-doc
  section ([n string?]
           [type (or/c STANDARD PREBLANK POSTBLANK INCONDITIONAL)]
           [con (listof e?)])
  ("interpretation: a section of a dictionary with entries"
   @itemlist[@item{@(racket section-n) : name/id of the section}
             @item{@(racket section-type) :
              A quote from the @hyperlink{https://taruen.github.io/organisation/index/modules-spec.html}{official
               documentation}:The value of the attribute type is used to
              express the kind of string tokenization applied in each
              dictionary section: the possible values of this attribute are:
              \"standard\", for almost all the forms of the dictionary
              (conditional mode), \"preblank\" and \"postblank\", for the forms
              that require an unconditional tokenisation and the placing of a
              blank (before and after, respectively), and \"inconditional\" for
              the rest of forms that require unconditional tokenization."}
             @item{@(racket section-con) : content (entries)}])))


(struct e (o re lm l r par))

(provide
 (struct*-doc
  e ([o (or/c #f LR RL)]
     [re (or/c #f string?)]
     [lm (or/c #f string?)]
     [l string?]
     [r string?]
     [par (or/c #f string?)])
  ("interpretation: an entry in a dictionary paradigm or section."
   @itemlist[@item{@(racket e-o) : usage restriction, either LR (only analyse
              this form) or RL (only generate this form) or #f (not set.}
             @item{@(racket e-re) : regular expression or #f (not set)}
             @item{@(racket e-lm) : lemma or #f (not set)}
             @item{@(racket e-l) : left/lower/surface string}
             @item{@(racket e-r) : right/upper/lexical string}
             @item{@(racket e-par) : name of the (inflection) paradigm or #f
              (not set)}])))

(require sxml)
 (ssax:xml->sxml (open-input-file
                   "/tmp/apertium-kaz-tat.kaz-tat.dix")
                    '())