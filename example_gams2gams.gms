$call copy gams2gams.gms  %gams.sysdir%\inclib\gams2gams.gms

OPTION PROFILE=3;
OPTION PROFILETOL=1;

SETS i /i1*i5/,j /j1*j10/,k /k1*k20/,l /l2*l14/,e /ttt/,r /5/;
PARAMETERS a(i,j,k,l) text description, b(i,j,k) b bla bla, c(*,j,k), d(r,i);
a(i,j,k,l) = uniform(0,1);
b(i,j,k) = uniform(0,2);
c(j,j,k) = uniform(2,3);
d(r,i) = uniform(1,4);

Variables x(i,j,k,l);
x.L(i,j,k,l) = uniform(-3,2);
Equation equ1(j,k,l,i);
equ1.m(j,k,l,i) = uniform(1,2);


* data file modifiers
*$setglobal gams2gams_nd   4
*$setglobal gams2gams_nw   8
*$setglobal gams2gams_lw   0
*$setglobal gams2gams_tw   0
*$setglobal gams2gams_nj   1
*$setglobal gams2gams_lj   2
*$setglobal gams2gams_tj   1

*$setglobal gams2gams_startcolumlabel      25
*$setglobal gams2gams_advancecolumlabel    20
*$setglobal gams2gams_movecollabeltoright   2
*$setglobal gams2gams_quotes yes
$setglobal gams2gams_rowdim  1
*$libinclude gams2gams a x.l x.up x.scale c equ1.m b

*$libinclude gams2gams x.l
$libinclude gams2gams a x.l x.up x.scale c equ1.m b
*$libinclude gams2gams d


display "aa%gams2gams___quotes%aa";











