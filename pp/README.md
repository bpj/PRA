
Although I use [Pandoc](http://pandoc.org) to convert my Markdown sources to either LaTeX/PDF or HTML I also use the [preprocessor pp](https://github.com/CDSoft/pp) so as to be able to effect "special" differences between LaTeX and HTML or (more often) to hold off some typographical decisions or even to use different typographical conventions in different media.

This directory contains pp macro definitions for use in different media --- generally versions of "the same" set of macros for different media.  There is even one for converting plaintext with pp macros into "regular" plain text with the macros replaced with various brackets or typographical changes.

Below is a (non-exhaustive) list of preprocessor commands I'm using. It should contain most of those I use at the "top" level.

Note that pp allows to use several different (and customizable) pairs of argument delimiters. In fact you can use any standard — `() {} []` — or custom — `‹› «»` in these files — delimiter pair with any macro but I try to follow (partly my own, PRA-specific) conventions as shown below, except that I may use curly brackets instead of parentheses rather freely.

-   `!uni[(CHAR)](CODE)(NAME)`

    A Unicode character, potentially typeset with the char in angle brackets and/or the name in small caps.

-   `!char(DESCRIPTION)`

    An "abbreviated" "name" for a character, potentially eventually in small caps or some distinctive brackets.

-   `!pra«TEXT»`

    PRA text/characters. May be realized as double angle quotes, double angle brackets or italics (possibly bold italics) depending on the medium and what I eventually decide.

-   `!gr‹CHAR(S)›`

    (Non-PRA) graphemes. May be realized as single angle quotes, angle brackets or italics depending on the medium and what I eventually decide.

-   `!em(TEXT)`

    Emphasis. May be realized as underline or small caps if I want to reserve italics for PRA.

-   `!em2(TEXT)`

    Strong emphasis. May be realized as double underline or bold small caps depending on what I decide for ordinary emphasis.

-   `!sc(TEXT)`

    Small caps.

-   `!usc(TEXT)`

    "Upper small caps", i.e. what is uppercase in the plaintext source becomes (regular) small caps in the typeset version (yes XeTeX can do that!)

-   `!feat[FEATURE]`

    A phone{m,t}ic feature, generally as modified by some PRA diacritic. These will probably eventually show up between square brackets but special measures may be needed to get Pandoc and/or LaTeX to actually produce literal square brackets.
    
    Between the opening bracket and the actual feature name there will be one of the following punctuation characters which specifies the state/modification of the feature.
    
    -   `+` Add the feature. ("Turn it on".)
    -   `-` Remove the feature. ("Turn it off".)
    -   `!` Reverse the state of the feature. ("Turn it on if it is off and turn it off if it is on".)  This is non-standard and currently only used in \[!back\] as the "value" of the umlaut «◌̈» which makes back vowels front and front vowels back, with preservation of other features like \[?rounded\].
    -   `?` The feature in either state. ("Either on or off".) This is non-standard.

-   `!ipt[TEXT]`

    **I**PA **p**hone**t**ic — will of course show up in square brackets eventually but needs special treatment in LaTeX so as to not get "styled" uppercased in some contexts.

-   `!ipm(TEXT)`

    **I**PA **P**hone**m**ic — will of course show up between slashes but needs special measures just like `!ipt`. The macro argument is (usually) in parentheses because pp requires argument delimiters to be a pair of different/balanced characters and I can't be bothered to use something dumb like ⩗⩘ just to get a superficial resemblance to slashes.

