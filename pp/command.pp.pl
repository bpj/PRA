!def(perl)(
!sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#!/usr/bin/env perl

use 5.014;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

use List::AllUtils qw[:all];
use String::Util qw[:all];

!1

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
)

!def(fence)(
  !ifne(!1)()(!1)(
------------------------------------------------------------
))

!def(perlarg)(
<<'!fence(!2)'
!1
!fence(!2)
)

