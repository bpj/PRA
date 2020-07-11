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
!def(char)(!sc(!1))

!def(ltx)(raw inline LaTeX)(`!1`{=latex})
!def(ltc)(A LaTeX command)(!ltx(\!1{)!2!ltx(}))
!def(sc)(small caps)(
[!1]{.smallcaps}
)
!def(pra)(PRA text)(
  !ifdef(praem)(
    !ltc(textit)(!1)
  )(
    !ltc(NoCaseChange)(⟪!1⟫)
  )
)
!def(gr)(grapheme(s))(
  !ifdef(praem)(
    !ltc(textbf)(!ltc(textit)(!1))
  )(
    !ltc(NoCaseChange)(⟨!1⟩)
  )
)

!def(em)(
  !ifdef(praem)(
    !ifdef(scem)(
        !sc(!1)
    )(
        !ltc(uline)(!1)
    )
  )(
    *!1*
  )
)

!def(em2)(
  !ifdef(praem)(
    !ifdef(scem)(
        **!sc(!1)**
    )(
        !ltc(uuline)(!1)
    )
  )(
    **!1**
  )
)

!def(bticks)(A sequence of backticks)(
    !lua{ print(string.rep('`',!1)) }
)

!def(code)(Inline source code)(
  !ifdef(3)(
    !bticks(!3) !1 !bticks(!3)
  )(
    `!1`
  )!ifne(!2)()({!2})
)

!def(ipt)(IPA phonetic transcription)(
    !ltc(NoCaseChange)(\[!1\])
)
!def(ipm)(IPA phonemic transcription)(
    !ltc(NoCaseChange)(/!1/)
)
!def(usc)(uppercase small caps)(
    !ltc(textusc)(!1)
)
!def(cpoint)(a Unicode
codepoint)(!ltc(textsmaller[1])(!1))
)

!def(s)(!ltc(textsmaller[1])(!1))
!def(xs)(!ltc(textsmaller[2])(!1))
!def(xxs)(!ltc(textsmaller[3])(!1))

!def(l)(!ltc(textlarger[1])(!1))
!def(xl)(!ltc(textlarger[2])(!1))
!def(xxl)(!ltc(textlarger[3])(!1))

