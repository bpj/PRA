# PRA — The Practical Romanization Alphabet

PRA aims to become a set of practical recommendations and suggestions for the [romanization][] of [natural language][]s and naturalistic [constructed languages][] (primarily [artistic languages][] — because that is where my interest in the field lies — but in principle usable also for any [engineered language][] or [auxiliary language][] which has a more or less conventional [phonetic-medium][] [phonology][]). Programming languages, which do not have a [phonology][] as commonly understood in linguistics are thus not concerned. Also out of scope are such natural and naturalistic languages which do not use the [phonetic][phonetic-medium] channel, such as [signed language][]s, not because they are any less languages or any less natural(istic) but because romanization as commonly understood makes little sense for them, since the [Latin/Roman][] [alphabet][] is usually used to encode [spoken language][]. (Feel free to make a case to the contrary, but I rather believe that a system different from PRA would be more appropriate to encode such languages using “alphabetic” signs!)

## Principles

The principles of PRA are described in the [PRA design principles][] (very much WIP!) Some highlights:

-   A valid romanization according to PRA can be made using only letters from the [Unicode][] [Basic Latin][] block and characters from the [Spacing Modifier Letters][] and [Combining Diacritical Marks][] blocks.

    This does not mean that a valid PRA romanization cannot use Unicode characters from other blocks, but these are then always alternatives to “core” notations using characters from these three blocks. Nor are *all* characters from these three blocks part of the PRA “core”, not even all the Basic Latin letters!

-   PRA does as far as possible build on existing scholarly, bibliographic and similar romanization precedents and precedents in existing orthographies, striving for as common a base as possible.

    Major sources of inspiration are the [Uralic Phonetic Alphabet][] ([text][]) and the [Standard Alphabet by Lepsius][] ([text][1]), mainly because they largely *are* codifications of existing usage along the lines which PRA is (beside its practical aim) meant to be.

-   PRA is meant to complement rather than compete with phonetic transcription systems, in particular the [IPA][].

    In particular the intention is that texts using PRA shall, or at least can, use normal conventions of [capitalization][] and [punctuation][], as adapted to the language being romanized and/or adopted from some language known to the intended audience.

    While this does not mean that PRA cannot be used for phonetic transcription that is not its primary goal.

-   PRA extends the Basic Latin alphabet primarily with [diacritical marks][]. [Digraph][]s should only be used where their meanings can be reasonably deduced from their components, and modifier letters should only be used when they are effectively alternatives to diacritics or no other obvious candidate letterss are in wide common use.

-   PRA avoids, when reasonably possible, notations which may be ambiguous because of significant differences between existing orthographies and scholarly or bibliographic traditions, at least in the core.

    As a consequence of this the Basic Latin letters *c, j, q, x* are not used in the PRA core, since different languages use these letters for widely differing sounds.

    An obvious exception is made in that the very divergent pronunciation of the Basic Latin vowel letters in English is not allowed to stand in the way of the use of those letters with values like those upon which most other languages written in the Latin alphabet agree. It seems altogether reasonable to use the letters *a, e, i, o, u* with the “classical” values which they have in Spanish and many other languages.

## The project

The PRA project has two principal parts:

1.  The description and documentation of the system itself and for its secondary goal of collecting information on existing scholarly and bibliographic romanization practices. Eventually a separate website for this purpose will be set up.

2.  Software to assist the documentation and management of the system itself as well as to aid in the creation and use of romanizations using the system.

Currently this [GitHub repository][] serves both purposes as it contains both the data and software for use in the codification and documentation of PRA.

In particular the file [pra.yaml][] is central, as it serves both as the (unfinished) main database and currently as the codification of PRA. Eventually there will be a schema so that the structure of this file can be kept predictable.

In terms of versioning PRA is still in what programmers would call zero alpha. At the moment things can and will change without notice.

The section on letters is mostly done, the section on marks just begun and the section on modifiers still to be done. The contents of the `marks` and `modifiers` sections as they stand are mostly automatically generated lists of all the characters in the *Combining Diacritical Marks* and *Spacing Modifier Letters* blocks meant to aid the work on the actual data. In particular the presence of an entry for a character in those sections should not be taken as an indication that that character is (going to be) part of PRA, be it as core or as alternative.

Needless to say PRA is a work in progress and probably always will be. That a particular use of a character is recommended or discouraged now or at any given time does not mean that they always will be, but once version 0.1 is reached all such changes will be documented. That is what the `in_use` fields in the data file are for, and perhaps a more elaborate structure for keeping track of changes will need to be put in place.

  [romanization]: https://en.wikipedia.org/wiki/Romanization
  [natural language]: https://en.wikipedia.org/wiki/Natural_language
  [constructed languages]: https://en.wikipedia.org/wiki/Constructed_language
  [artistic languages]: https://en.wikipedia.org/wiki/Artistic_language
  [engineered language]: https://en.wikipedia.org/wiki/Engineered_language
  [auxiliary language]: https://en.wikipedia.org/wiki/International_auxiliary_language
  [phonetic-medium]: https://en.wikipedia.org/wiki/Phonetics
  [phonology]: https://en.wikipedia.org/wiki/Phonology
  [signed language]: https://en.wikipedia.org/wiki/Sign_language
  [Latin/Roman]: https://en.wikipedia.org/wiki/Latin-script_alphabet
  [alphabet]: https://en.wikipedia.org/wiki/Alphabet
  [spoken language]: https://en.wikipedia.org/wiki/Spoken_language
  [PRA design principles]: documentation/pra-design-principles.md
  [Unicode]: https://en.wikipedia.org/wiki/Unicode
  [Basic Latin]: https://en.wikipedia.org/wiki/Basic_Latin_(Unicode_block)
  [Spacing Modifier Letters]: https://en.wikipedia.org/wiki/Spacing_Modifier_Letters
  [Combining Diacritical Marks]: https://en.wikipedia.org/wiki/Combining_Diacritical_Marks
  [Uralic Phonetic Alphabet]: https://en.wikipedia.org/wiki/Uralic_Phonetic_Alphabet
  [text]: https://archive.org/details/finnischugrische01helsuoft/page/n23
  [Standard Alphabet by Lepsius]: https://en.wikipedia.org/wiki/Standard_Alphabet_by_Lepsius
  [1]: https://archive.org/details/cu31924026453708
  [IPA]: https://en.wikipedia.org/wiki/International_Phonetic_Alphabet
  [capitalization]: https://en.wikipedia.org/wiki/Capitalization
  [punctuation]: https://en.wikipedia.org/wiki/Punctuation
  [diacritical marks]: https://en.wikipedia.org/wiki/Diacritic
  [Digraph]: https://en.wikipedia.org/wiki/Digraph_(orthography)
  [GitHub repository]: https://github.com/bpj/PRA
  [pra.yaml]: pra.yaml
