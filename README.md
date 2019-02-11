# Apertium++, or Apertium 4.0

This is a project with an aim of:

* making a free/libre morphological transducer for every language of the
  world;

* making free/libre machine translators for translating between **all**
  related languages of a particular language group \(e.g. Turkic,
  Slavic, Indo-Iranian etc;\)

* updating Apertium 3.0’s official documentation so that it reflects
  changes which have happened since the time of its publication;

* reducing the code which developers have to maintain in a typical
  Apertium 3.0 monolingual or bilingual package.

> Hence two pluses in the name of the project...

The project, in its spirit and aims is similar to the [Apertium
project](https://www.apertium.org), and can be considered its spinoff,
with two additions:

* for each language, we will maintain a corpus of sharable texts,
  parallel or comparable to corpora for other languges

* machine translators will have a speech recognition & speech synthesis
  front-ends \(based on Mozilla’s Common Voice and DeepSpeech
  projects\).

> To be frank, if we come up with some useful technology, we hope to see
> it merged to the Apertium’s code base.

Since one of the declared goals of ours is being able to handle speech
\(not just the written word\), and, since we want to re-evaluate some of
the design decisions made in the Apertium project \(and yet are not sure
at all whether such re-evaluations will turn out to be wise desicions\),
we decided to make a separate project out of this effort.

## 1. What could be improved in Apertium 3.0?

Apertium is a great project, with quite a few contributors, but here is
a list of things deemed as less-than-optimal in the current Apertium
setup:

* transfer rules are unidirectional, and currently there is no way of
  marking a transfer rule as ‘bidirectional’ and get a transfer rule for
  the opposite direction for free,

* there can be and usually there are several entries in a .lexc or .dix
  files with the same left-hand side \(and there is no compile-time
  checks against mistakenly adding the same word twice, possibly with a
  right and a wrong category

* rather long compile cycles, translators are not extensible
  programmatically

* ?

## Documentation

For up-to-date documentation, browse the doc/apertium++.html file.