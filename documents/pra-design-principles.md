---
title: PRA (Practical Romanization Alphabet) design
principles.
author: Benct Philip Jonsson (bpj)
date: 2020-06-18
---

**Note:** As it stands this document contains a lot of
explanations which probably should go elsewhere. Please
consider only the first paragraph under each point as
the actual design principle. The rest is, mostly,
explanations.

1.  PRA is a set of recommendations only. You are
    free to ignore any of these recommendations to any
    degree, although there is of course some cut-off point
    beyond which it is not meaningful to call the result
    PRA anymore.

    One way to think of it is to see PRA just as a set of
    recommendations, so that any actual romanization will
    be !em(based on pra) rather than be PRA.

    PRA is the result of just over three decades of using
    diacritics-based romanizations, so I (bpj)
    like to think that it is rather well thought out — at
    least I hope that someone who shares my tastes in
    romanization will think so. It is certainly as
    !em(carefully) thought out as I have been capable of.
    Constructive criticism and suggestions for improvement
    are always welcome. Don't bother to contact me just to
    say that it is all wrong or totally unnecessary;
    tastes differ and I fully expect that there are those
    who wholly disagree with me. If you don't like it
    don't use it and let it be at that.

    One area where I have made extensive use of diacritics
    to augment the set of available letters through the
    years is when writing shorthand. While that is not
    strictly speaking romanization I have mostly
    used the same set of diacritics in shorthand and
    longhand. One area where it shows is that PRA almost
    totally eschews digraphs.  That is however not only a
    result of the fact that in shorthand new digraphs are
    almost as awkward as new letters. I happen to think
    that digraphs easily become a source of ambiguity
    and inconsistency in romanization.

1.  A valid romanization according to PRA can be
    made using only letters from the Unicode Basic Latin
    block and characters from the Spacing Modifier Letters and
    Combining Diacritical Marks blocks.

    This is meant to ensure very wide font support while
    allowing extensive use of diacritical marks. It is of
    course never wrong to use precombined characters, in
    particular Unicode Normalization Form C if one is sure
    that the fonts used to display a text can handle them —
    an assumption which usually is safe for the Latin-1 Supplement,
    Latin Extended-A and Latin Extended-B blocks.

    This does not mean that a valid PRA romanization cannot
    use Unicode characters from other blocks, but these are
    then always alternatives to "core" notations using
    characters from these three blocks. Nor are *all*
    characters from these three blocks part of the PRA
    "core", not even all the Basic Latin letters!

1.  PRA does as far as possible build on existing
    scholarly, bibliographic and similar romanization
    precedents and precedents in existing orthographies,
    striving for as common a base as possible.

    Major sources of inspiration are the [Uralic Phonetic
    Alphabet](-UPA) ([text](-UPA-text)) and the [Standard Alphabet by
    Lepsius](-Lepsius-alphabet) ([text](-Lepsius-text)), mainly because they largely
    *are* codifications of existing usage along the lines
    which PRA is (beside its practical aim) meant to be.
    Another obvious source of inspiration is the so-called
    [Americanist or North American Phonetic Alphabet](-NAPA)
    which isn't an alphabet as much as an uncodified set of
    partly incoherent and conflicting practices based on
    both European philological traditions and the IPA. The
    Wikipedia article gives a good overview but to claim as
    it does that the various philological transcription
    practices are variants of the Americanist practice is to
    stand the facts on their head!
    From the perspective of
    PRA the main weaknesses of the Americanist tradition is
    that it can't make up its mind between diacritics and
    special letters, and that it uses diacritics
    inconsistently, so that the same diacritic can have
    different meanings not only in different works, but also
    within the same work depending on which letters they are
    attached to and which other diacritics are attached to
    the same letter.  To take the most blatant example ‹ṛ›
    may stand for either a retroflex flap or a uvular trill,
    apparently on the grounds that both are "retracted"
    compared to an alveolar rhotic. When disambiguation is
    needed the uvular trill is written either ‹ṛ̃›,  based on
    the notation ‹r̃› for the alveolar trill, or the IPA
    small capital ‹ʀ› is used. Such vagueness has no place
    in PRA, where each diacritic has one well-defined
    meaning, or possibly one meaning when used with
    consonant letters and another with vowel letters.
    Although in all fairness the Americanist tradition does
    not use the tilde for nasalization the commonality
    between the ‹ñ› for the palatal nasal and ‹r̃› for the
    alveolar trill seems to be that they are written ‹ñ› and
    ‹rr› in Spanish orthography and the tilde got copied to
    the ‹r› by analogy! (To be fair PRA recognises _ñ_ as an
    alternative notation for the palatal nasal — relatively
    harmless since nasalization can't be added to  _n_ — but
    it is not the main notation for this sound, let alone
    the only one!) As for small capitals as distinct signs
    they have no place in PRA: since the purpose of PRA is
    romanization rather than phonetic transcription PRA
    letters must normally allow normal capitalization.

1.  PRA is meant to complement rather than compete with
    phonetic transcription systems, in particular the
    [IPA](-).

    In particular the intention is that texts using PRA
    shall, or at least can, use normal conventions of
    capitalization and punctuation, as adapted to the
    language being romanized and/or adopted from some
    language known to the intended audience.

    While this does not mean that PRA cannot be used for
    phonetic transcription that is not its primary goal.

1.  PRA extends the Basic Latin alphabet primarily with
    diacritical marks. Digraphs should only be used where
    their meanings can be reasonably deduced from their
    components, and modifier letters should only be used
    when they are effectively alternatives to diacritics or
    no other obvious candidate letters are in wide common
    use.

    One important virtue of diacritics compared to novel
    letters is that someone unfamiliar with the system
    can still form *some* idea — however inaccurate — of a
    pronunciation by simply ignoring the diacritics,
    while a word or phrase containing many novel
    letters may appear as a jumble of unfamiliar shapes
    which can't even be described. If you know the
    IPA it may be obvious that ‹ʃ› is not a kind of ‹f›,
    that ‹ɣ› is not a kind of ‹v› and ‹ɹ› is not a kind of
    ‹u› but if you never learnt the IPA it is not at all
    obvious. In a long quote on the Wikipedia page on
    [Americanist phonetic notation](-NAPA) a famous
    British phonetician goes on at length berating American
    linguists for their "curious hostility" in face of the
    "obvious superiority" of IPA special letters like ‹ʃ›.
    In my (bpj) opinion this alleged superiority is far
    from certain; it may hold some truth for printed
    phonetic transcription, but in romanization novel
    letters have serious disadvantages: as already
    mentioned they are inscrutable to the
    uninitiated. They are also hard to write (as opposed
    to draw!) by hand, and they can't always be
    capitalized.

    Appropriate use of digraphs include

    -   The use of !pra«y» after a consonant to indicate palatal or
        palatalized sounds, the use of !pra«w» after a
        consonant to indicate labialization, and the use of
        !pra«r» before or after a consonant to indicate a
        retroflex articulation provided thst no clusters
        which may cause ambiguity exist in the
        language being romanized.

    -   The use of !pra«h» after a consonant to indicate
        aspiration. In fact this is the normal way to
        indicate aspiration in PRA as no cases where a
        hyphen cannot be appropriately used to
        distinguish consonant + [h] are expected
        to occur.

    -   Currently there are only two cases where a
        modifier letter is used as the core
        representation of a sound:

        +   !prauni(ʾ)(U+02BE)(MODIFIER LETTER RIGHT HALF RING)
            is used for the glottal stop [ʔ].
        +   !prauni(ʿ)(U+02BF)(MODIFIER LETTER LEFT HALF RING)
            is used for the voiced pharyngeal fricative.

1.  PRA avoids, when reasonably possible, notations which
    may be ambiguous because of significant differences
    between existing orthographies and scholarly or
    bibliographic traditions, at least in the core.

    As a consequence of this the Basic Latin letters !gr‹c,
    j, q, x› are not used in the PRA core, since different
    languages use these letters for widely differing sounds.

    An obvious exception is made in that the very divergent
    pronunciation of the Basic Latin vowel letters in
    English is not allowed to stand in the way of the use of
    those letters with values like those upon which most
    other languages written in the Latin alphabet agree.
    Everyone whose native language is written
    with the Latin alphabet and who has learnt English as
    a foreign language is well aware of how singularly
    divergent English is, so that only some who know no
    other language written in the Latin alphabet than
    English (some monolingual English speakers included) are
    unaware of the fact.
    It seems altogether reasonable to
    use the letters !gr‹a, e, i, o, u› with the "classical"
    values which they have in Spanish and many other
    languages.

1.  Beside the core PRA permits some alternative letters and
    diacritics, currently only from these Unicode blocks:

    -   Basic Latin
    -   Latin-1 Supplement
    -   Latin Extended-A
    -   Latin Extended-B
    -   IPA Extensions
    -   Spacing Modifier Letters
    -   Combining Diacritical Marks

    Alternative letters, except modifier letters must have
    an uppercase—lowercase pair in Unicode.

    Currently recognised alternative letters include:

    
    -   !prauni(c)(U+0063)(LATIN SMALL LETTER C), usable for
        either !pra«ts, s͇» or !pra«ʿ».

    -   !prauni(ʒ)(U+0292)(LATIN SMALL LETTER EZH), usable
        for !pra«dz, z͇».

    -   !prauni(ŋ)(U+014B)(LATIN SMALL LETTER ENG) (ng),
        usable for !pra«n̮, g̃» or !pra«Ṽ».






