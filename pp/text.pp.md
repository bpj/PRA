!quiet(
!macroargs((){}[]‹›«»)
!import(command.pp.pl)
!def(uni)(A Unicode [character,] codepoint and character name)(
  !ifdef(3)(
    !gr(!1) !cpoint(!2) !usc(!3)
  )(
    !cpoint(!1) !usc(!2)
  )
)
!def(prauni)(A PRA character, a Unicode codepoint and character name)(!pra(!1) !uni(!2)(!3))
!def(char)(\{!1\})

!def(sc)(small caps)(
!perl
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print uc trim !perlarg(!1)(!2);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
)

!def(em)(\_!1\_)
!def(em2)(\*!1\*)

!def(bs_punct)(Escape punctuation with backslashes)(
    !lua{
        esc = string.gsub([==========[!1]==========],'%p','\\%0')
        print(esc)
    }
)

!def(bticks)(A sequence of backticks)(
    !lua{ print(string.rep('`',!1)) }
)

!def(code)(Inline source code)(
  !ifdef(3)(
    !bs_punct(!bticks(!3)) !1 !bs_punct(!bticks(!3))
  )(
    \`!1\`
  )
)

!def(pra)(PRA text)(«!1»)
!def(gr)(grapheme(s))(‹!1›)
!def(ipt)(IPA phonetic transcription)(\[!1\])
!def(ipm)(IPA phonemic transcription)(/!1/)
!def(usc)(uppercase small caps)(!1)
!def(cpoint)(a Unicode codepoint)(!1)

!def(s)(!1)
!def(xs)(!1)
!def(xxs)(!1)

!def(l)(!1)
!def(xl)(!1)
!def(xxl)(!1)
)
