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

1.  PRA does as far as possible build on existing
    scholarly, bibliographic and similar romanization
    precedents and precedents in existing orthographies,
    striving for as common a base as possible.

1.  PRA is meant to complement rather than compete with
    phonetic transcription systems, in particular the
    [IPA](-).

    While this does not mean that PRA cannot be used for
    phonetic transcription that is not its primary goal.

1.  PRA extends the Basic Latin alphabet primarily with
    diacritical marks. Digraphs should only be used
    where their meanings can be reasonably deduced from
    their components, and modifier letters should only
    be used when they are effectively alternatives to
    diacritics or no other obvious candidates are in wide common use.

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

    1.  PRA avoids, when reasonably possible,
        notations which may be ambiguous because of
        significant differences between existing
        orthographies, at least in the
        core.

        As a consequence of this the Basic Latin letters
        !gr‹c, j, q, x› are not used in the PRA core,
        since different languages use these letters
        for widely differing sounds.

        An obvious exception is made in that the very
        divergent pronunciation of the Basic Latin vowel
        letters is not allowed to stand in the way of the
        use of those letters. Everyone whose native language
        is written with the Latin alphabet and who has
        learnt English as a foreign language is well aware
        of how singularly divergent English is, so that only
        some who know no other language written in the Latin
        alphabet than English (some monolingual English
        speakers included) are unaware of the fact. It seems
        altogether reasonable to use the letters !gr‹a, e,
        i, o, u› with the "classical" values which they have
        in Spanish and many other languages.

    1.  Beside the core PRA permits some alternative
        letters and diacritics, currently only
        from these Unicode blocks:

        -   Basic Latin
        -   Latin-1 Supplement
        -   Latin Extended-A
        -   Latin Extended-B
        -   IPA Extensions
        -   Spacing Modifier Letters
        -   Combining Diacritical Marks

        Alternative letters, except modifier letters must
        have an uppercase—lowercase pair in
        Unicode.

        Currently recognised alternative letters include:

        
        -   !prauni(c)(U+0063)(LATIN SMALL LETTER C), usable for either
           !pra«ts, s͇» or !pra«ʿ».

        -   !prauni(ʒ)(U+0292)(LATIN SMALL LETTER EZH), usable for
            !pra«dz, z͇».

        -   !prauni(ŋ)(U+014B)(LATIN SMALL LETTER ENG) (ng), usable
            for !pra«n̮, g̃» or !pra«Ṽ».






