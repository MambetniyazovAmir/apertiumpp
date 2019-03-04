#lang scribble/manual

@title[#:version ""]{Apertium++!, or Apertium 4.0, or making Apertium DSLs internal/embedded}

This is a project with an aim of:

@itemlist[

 @item{making a free/libre morphological transducer for
  every language of the world;}

 @item{making free/libre machine translators for translating
  between @bold{all} related languages of a particular
  language group (e.g. Turkic, Slavic, Indo-Iranian etc);}

 @item{updating Apertium 3.0's official documentation so
  that it reflects changes which have happened since the time
  of its publication, especially as the result of Google
  Summer of Code projects;}

 @item{reducing the code which developers have to maintain
  in a typical Apertium 3.0 monolingual or bilingual package.}]

@margin-note{Hence two pluses in the name of the project...}

The project, in its spirit and aims is similar to the
@hyperlink["https://www.apertium.org"]{Apertium project}, and can be
considered its spinoff, with two additions:

@itemlist[

 @item{for each language, we will maintain a corpus of
  sharable texts, parallel or comparable to corpora for other
  languges}

 @item{machine translators will have a speech recognition &
  speech synthesis front-ends (based on Mozilla's
  @hyperlink["https://voice.mozilla.org"]{Common Voice} and
  @hyperlink["https://github.com/mozilla/DeepSpeech"]{
   DeepSpeech} projects).}]

@margin-note{To be frank, if we come up with some useful
 technology, we hope to see it merged to the Apertium's code
 base (maybe in the form of different campaigns, such as
 "Help us to create a mophological transducer for every human
 language!").}

Since one of the declared goals of ours is being able to
handle speech (not just the written word), and, since we
want to re-evaluate some of the design decisions made in the
Apertium project (and yet are not sure at all whether such
re-evaluations will turn out to be wise decisions), we
decided to make a separate project out of this effort.

@section{What could be improved in Apertium 3.0?}

Apertium is a great project, with quite a few contributors,
but here is a list of things deemed as less-than-optimal in
the current Apertium setup:

@itemlist[

 @item{transfer rules are unidirectional, and currently
  there is no way of marking a transfer rule as
  `bidirectional' and get a transfer rule for the opposite
  direction for free,}

 @item{there can be and usually there are several entries in
  a .lexc or .dix files with the same left-hand side (and
  there is no compile-time checks against mistakenly adding
  the same word twice, possibly with a right and a wrong
  category}

 @item{rather long compile cycles, translators are not
  extensible programmatically}

 @item{not possible to re-use components in a programmatic
  way (i.e. without having to copy-paste manually, which
  sooner or later will lead to out-of-date chunks). Want we
  want instead is having a way to say, e.g. something like
  this: @code{from apertium-tat-rus import transfer-rule-x},
  @code{from apertium-symbols import n, v, adj, np}, @code{
   parameterize(transfer-rule-x, lemma="foo")} etc.}

 @item{?}]

We suppose that most of the problems listed will be due the
fact that the domain-specific languages used in Apertium
(and there a handful of them -- one seen in monolingual and
bilingual @code{.dix} files, one seen in @code{chunking},
@code{ interchunk} and @code{postchunk} transfer rules,
@code{ lexc}, @code{twol} and others are so-called external
DSLs. They are parsed and compiled. When writing in these
DSLs, you don't have access to a full-fledged programming
language which would allow you to extend the DSL in question
easily and simplify&automate things. You also don't have
access to useful features of a full-fledged programming
language like a proper module system, which would allow you
to re-use code across monolingual and bilingual packages
reliably.

@section{Desiderata}

@itemlist[

 @item{Every Apertium 3.0. program is a valid
  Apertium 4.0 program.}]

@section{Apertiumpp library}

At the core of this project is a Racket library called
@italic{apertiumpp}. The documentation of the library can be
found at @hyperlink["./apertiumpp/"]{
 https://taruen.github.io/apertiumpp/apertiumpp/}.

@section{Tests/data for Apertium 3.0. packages}

The @filepath{apertium-tests} directory contains tests for
Apertium's monolingual and bilingual packages. These tests
are written in the
@(link "https://racket-lang.org" "Racket") programming
language using its dialect called
@(link "https://docs.racket-lang.org/rash/index.html" "Rash").

You can open the @filepath{.rkt} files in
@filepath{apertium-tests} in DrRacket (and IDE for the
Racket language), and run each clicking on the "Run" button
in DrRacket or pressing F5.

Tests do not compile the monolingual or bilingual packages
automatically, so you'll need to do that beforehand.

In test files, you also might need to change the path to the
monolingual or bilingual packages you're testing. Tests
assume that both
@hyperlink["https://github.com/apertium/apertium-all"]{
 apertium-all} and @filepath{ apertium-tests} are in the same
directory.

@section{Background reading}

@url{http://www.greghendershott.com/fear-of-macros/}
