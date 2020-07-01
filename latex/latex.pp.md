!quiet(
!macroargs((){}[]‹›«»)
!import(command.pp.pl)
!def(uni)(A Unicode codepoint and character name)(!cpoint(!1) !usc(!2))
!def(prauni)(A PRA character, a Unicode codepoint and character name)(!pra(!1) !uni(!2)(!3))
!def(gruni)(A character, a Unicode codepoint and character name)(!gr(!1) !uni(!2)(!3))
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
    !ltc(uline)(!1)
  )(
    *!1*
  )
)

!def(em2)(
  !ifdef(praem)(
    !ltc(uuline)(!1)
  )(
    **!1**
  )
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

!def(small)(!ltc(textsmaller[1])(!1))
!def(xsmall)(!ltc(textsmaller[2])(!1))
!def(xxsmall)(!ltc(textsmaller[3])(!1))

!def(large)(!ltc(textlarger[1])(!1))
!def(xlarge)(!ltc(textlarger[2])(!1))
!def(xxlarge)(!ltc(textlarger[3])(!1))

