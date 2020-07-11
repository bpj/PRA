!quiet(
!macroargs((){}[]‹›«»)
!import(command.pp.pl)
!def(uni)(A Unicode codepoint and character name)(!cpoint(!1) !usc(!2))
!def(prauni)(A PRA character, a Unicode codepoint and character name)(!pra(!1) !uni(!2)(!3))
!def(gruni)(A character, a Unicode codepoint and character name)(!gr(!1) !uni(!2)(!3))
!def(sc)(small caps)(
!perl
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print uc trim !perlarg(!1)(!2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
)
!def(pra)(PRA text)(«!1»)
!def(gr)(grapheme(s))(‹!1›)
!def(ipt)(IPA phonetic transcription)(\[!1\])
!def(ipm)(IPA phonemic transcription)(/!1/)
!def(usc)(uppercase small caps)(!1)
!def(cpoint)(a Unicode codepoint)(!1)

!def{rh}{Rotated table header in LaTeX (noop)}{!1}

!def(s)(!1)
!def(xs)(!1)
!def(xxs)(!1)

!def(l)(!1)
!def(xl)(!1)
!def(xxl)(!1)
)

