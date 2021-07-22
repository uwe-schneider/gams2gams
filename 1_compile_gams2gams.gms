* search for uuuuuu

* Remaining Tasks
* include one or more sets
* include warning messages
* add custom description
* customize listing / credits
* enter VB user interface script
* add message if dimensions exceed capability of script
* automate prevention of very column long formats

* New
* use .tf=4 to produce quotes



* Set scope of interface
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *
SCALAR maxcolcount   maximum number of colum dimensions needed /4/;
SCALAR listingexit   minimum size to insert on-off listing /100/;
SET    dimensions    maximum dimensions of item /1*12/;
SET    arguments     maximum simultaneous requests with one libinclude statement /1*8/;
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *


* !!! Non-US persons should not change after this line !!!

ALIAS(dimensions,row_dimension,column_dimension,rowalias_dimension);

* Declare interface file
FILE gams2gams_interface /gams2gams.gms/;
* Field format of interface file
gams2gams_interface.lw=0;
gams2gams_interface.nw=0;
gams2gams_interface.nd=0;
gams2gams_interface.pw=32767;
* Open interface file
PUT  gams2gams_interface;

* Write interface
$onput
* (Skip) declaration of helping scalars
$if declared gams2gams_startdatacol                            $goto after_gams2gams_declaration
$offput
PUT "SET gams2gams_dimensions /g2gd_1*g2gd_",card(dimensions),"/;" /;
$onput
SCALAR gams2gams_startdatacol;
SCALAR gams2gams_advancecolumn;
SCALAR gams2gams_quotespace /0/;
SCALAR gams2gams_currentcolumn /0/,gams2gams_startlabelcol;
SCALAR gams2gams__data__count;
SCALAR gams2gams__data__limit;
PARAMETER gams2gams__length(gams2gams_dimensions);
$label after_gams2gams_declaration

$offput

* Loop over elements in set arguments
Loop(arguments,

PUT / '**++++++++++++**' / '* Parameter %',ord(arguments) / '**++++++++++++**' / /;
PUT '$if  "%',ord(arguments),'"==""'  @60 '$goto gams2gamslabel_alldone' /;
PUT '$setcomps %',ord(arguments),' g2g__arg',ord(arguments),' g2g__suffix',ord(arguments) /;
PUT '$setglobal gams2gams__arg',ord(arguments),' %g2g__arg',ord(arguments),'%'  /;
PUT '$setglobal gams2gams__suffix',ord(arguments),' %g2g__suffix',ord(arguments),'%'  /;
PUT '$if not "%gams2gams__suffix',ord(arguments),'%" == ""' @60 '$setglobal gams2gams__suffix',ord(arguments),' "%gams2gams__suffix',ord(arguments),'%_"'  /;
PUT '$log Gams2Gams full argument ',ord(arguments),' = %',ord(arguments) /;
PUT '$log Gams2Gams reduced argument %gams2gams__arg',ord(arguments),'%' /;

PUT '* File declarations' /;
PUT '$if "%gams2gams_filename%" == "no"' @60 '$goto gams2gamslabel_defaultname',ord(arguments) /;
PUT '$if setglobal gams2gams_filename'   @60 '$goto gams2gamslabel_filedeclared',ord(arguments) /;

PUT '$label gams2gamslabel_defaultname',ord(arguments) /;
PUT 'FILE gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'% /%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%data.gms/;' /;
*PUT 'FILE gams2gams_datafile_%',ord(arguments),' /%',ord(arguments),'_data.gms/;' /;
PUT '$goto gams2gamslabel_afterfiledeclaration',ord(arguments) /;

PUT '$label gams2gamslabel_filedeclared',ord(arguments) /;
IF(ord(arguments) gt 1.5, PUT '$setglobal gams2gams_ap 1' /; );
PUT 'FILE gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'% /%gams2gams_filename%.gms/;' /;
PUT '$goto gams2gamslabel_afterfiledeclaration',ord(arguments) /;

PUT '$label gams2gamslabel_afterfiledeclaration',ord(arguments) /;


$onput
* Field settings
$if not setglobal gams2gams_quotes               $setglobal gams2gams___quotes   ""
$if     setglobal gams2gams_quotes               $setglobal gams2gams___quotes   "'"
$if     "%gams2gams_quotes%"=="no"               $setglobal gams2gams___quotes   ""
$if     "%gams2gams_quotes%"==""                 gams2gams_quotespace=0;
$if not "%gams2gams_quotes%"==""                 gams2gams_quotespace=2;
$log quotes = "%gams2gams___quotes%"

$if not setglobal gams2gams_tf                   $setglobal gams2gams_tf        3
$if     setglobal gams2gams_quotes               $setglobal gams2gams_tf        4
$if     "%gams2gams_quotes%"=="no"               $setglobal gams2gams_tf        3

$if not setglobal gams2gams_nd                   $setglobal gams2gams_nd        2
$if not setglobal gams2gams_nw                   $setglobal gams2gams_nw       12
$if not setglobal gams2gams_lw                   $setglobal gams2gams_lw        0
$if not setglobal gams2gams_tw                   $setglobal gams2gams_tw        0

$if not setglobal gams2gams_nj                   $setglobal gams2gams_nj        1
$if not setglobal gams2gams_lj                   $setglobal gams2gams_lj        2
$if not setglobal gams2gams_tj                   $setglobal gams2gams_tj        1

$if not setglobal gams2gams_ap                   $setglobal gams2gams_ap        0



$offput

PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.pw=32767;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.nd=%gams2gams_nd%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.nw=%gams2gams_nw%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.lw=%gams2gams_lw%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.tw=%gams2gams_tw%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.nj=%gams2gams_nj%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.lj=%gams2gams_lj%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.tj=%gams2gams_tj%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.tf=%gams2gams_tf%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.ap=%gams2gams_ap%;'/;

PUT '$if not setglobal gams2gams_description                        $setglobal gams2gams_description %gams2gams__arg',ord(arguments),'%.ts' /;

PUT '$libinclude getdomains %',ord(arguments) /;
PUT '$include gpxyz_domaininfo.gms' /;

* Start writing data file
PUT 'PUT gams2gams_datafile_%gams2gams__arg',ord(arguments)'%_%gams2gams__suffix',ord(arguments),'%;' /;

Loop(dimensions,

* Insert code here to adjust column position and length
* this code should be produced in the getdomaininfo file

PUT / '*' / '* Parameter has ',dimensions.TL,' dimension';
IF(ord(dimensions) gt 1, put 's';); PUT / '*' /;
PUT '$if  not dimension ',dimensions.TL,' %',ord(arguments)  @60 '$goto gams2gamslabel_afterdim_',dimensions.TL,'_',ord(arguments) /;

PUT '$if not setglobal gams2gams_startcolumlabel'     @60 '$setglobal gams2gams_startcolumlabel ',(ord(dimensions)*12) /;
PUT '$if "%gams2gams_startcolumlabel%"=="no"'         @60 '$setglobal gams2gams_startcolumlabel ',(ord(dimensions)*12) /;
PUT 'gams2gams_startdatacol=%gams2gams_startcolumlabel%;' /;

PUT '$if not setglobal gams2gams_advancecolumlabel'   @60 '$setglobal gams2gams_advancecolumlabel 12' /;
PUT '$if "%gams2gams_advancecolumlabel%"=="no"'       @60 '$setglobal gams2gams_advancecolumlabel 12' /;
PUT 'gams2gams_advancecolumn=%gams2gams_advancecolumlabel%;' /;

PUT 'gams2gams_startlabelcol = gams2gams_startdatacol; ' /;
PUT '$if not setglobal gams2gams_movecollabeltoright' @60 '$setglobal gams2gams_movecollabeltoright 0' /;
PUT '$if "%gams2gams_nj%"=="1"'                       @60 'gams2gams_startlabelcol = gams2gams_startdatacol+%gams2gams_movecollabeltoright%;' /;

PUT '$if  "%gams2gams_rowdim%"=="no"'                 @60 '$dropglobal gams2gams_rowdim' /;
PUT '$if  not setglobal gams2gams_rowdim'             @60 '$setglobal gams2gams_rowdim ', dimensions.TL /;

* Define alias sets to avoid domain problems
LOOP(row_dimension $(ord(row_dimension) le ord(dimensions)),
PUT 'ALIAS(%d___',row_dimension.tl,'%,ddd___',row_dimension.tl,'__%gams2gams__arg',ord(arguments),'%,d_',row_dimension.tl,'__%gams2gams__arg',ord(arguments),'%);' /;  );

* Count number of cases
* gams2gams__data__limit = sum((
PUT 'gams2gams__data__limit = sum((';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(row_dimension $(ord(row_dimension) le ord(dimensions)),
   PUT 'd_',row_dimension.TL,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(row_dimension) lt ord(dimensions),PUT ',';); );
* ) $ %1(
  PUT ') $ %',ord(arguments),'(';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(row_dimension $(ord(row_dimension) le ord(dimensions)),
   PUT "d_",row_dimension.TL,"__%gams2gams__arg",ord(arguments),"%";
   IF(ord(row_dimension) lt ord(dimensions),PUT ',';); );
* ),1);
  PUT '),1);'/;


* +++++++++++ *
* List format *
* +++++++++++ *

 PUT / '* List format with ',dimensions.TL,' row dimensions'/;
 PUT '$ife %gams2gams_rowdim%>=',dimensions.TL @60 '$log "list format requested"' /;
 PUT '$ife %gams2gams_rowdim%<',dimensions.TL  @60 '$log "table format requested"' /;
 PUT '$ife %gams2gams_rowdim%<',dimensions.TL  @60 '$goto gams2gamslabel_after_rd_',dimensions.TL,'_',ord(arguments),'_listformat' /;

 PUT 'gams2gams__data__count = 0;' /;
 PUT 'PUT "Parameter %gams2gams__arg',ord(arguments),'%(';
 LOOP(column_dimension $(ord(column_dimension) le ord(dimensions)),
  PUT '%d___'column_dimension.tl'%';
  IF(ord(column_dimension) lt ord(dimensions),PUT ',';); );
 PUT ') ",%gams2gams_description% / "/" /;' /;

*
* Row labels for list format
*

* LOOP((
  PUT 'LOOP((';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(row_dimension $(ord(row_dimension) le ord(dimensions)),
   PUT 'd_',row_dimension.TL,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(row_dimension) lt ord(dimensions),PUT ',';); );
* ) $ %1(
  PUT ') $ %',ord(arguments),'(';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(row_dimension $(ord(row_dimension) le ord(dimensions)),
   PUT "d_",row_dimension.TL,"__%gams2gams__arg",ord(arguments),"%";
   IF(ord(row_dimension) lt ord(dimensions),PUT ',';); );
* ),
  PUT '),'/;
* Insert count based listing
  PUT 'gams2gams__data__count = gams2gams__data__count + 1;' /;
  PUT 'IF(gams2gams__data__count eq 10 and gams2gams__data__limit gt ',listingexit,',PUT "$offlisting" /; );' /;
  PUT 'IF(gams2gams__data__count eq gams2gams__data__limit-10 and gams2gams__data__limit gt ',listingexit,',PUT "$onlisting" /; );' /;
* PUT d_1__%1.TL,".",d_2__%1.TL,".",d_3__%1.TL,".",d_4__%1.TL;
  PUT ' PUT ';
  LOOP(row_dimension $(ord(row_dimension) le ord(dimensions)),
   PUT '"%gams2gams___quotes%",';
   PUT 'd_',row_dimension.tl,'__%gams2gams__arg',ord(arguments),'%.TL';
   PUT ',"%gams2gams___quotes%"';
   IF(ord(row_dimension) lt ord(dimensions),PUT ',".",';);
  );
  PUT ' @gams2gams_startdatacol;' /;

*
* Data
*

* PUT %1(
  PUT ' PUT %',ord(arguments),'(';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(row_dimension $(ord(row_dimension) le ord(dimensions)),
   PUT 'd_'row_dimension.tl,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(row_dimension) lt ord(dimensions),PUT ',';); );
* );
 PUT ') /;';
 PUT ' );' /;

 PUT '$goto gams2gamslabel_endof_list',ord(arguments) /;
 PUT '$label gams2gamslabel_after_rd_',dimensions.TL,'_',ord(arguments),'_listformat' /;



* ++++++++++++ *
* Table format *
* ++++++++++++ *

 LOOP(row_dimension $(ord(row_dimension) lt ord(dimensions)),
  PUT / '* Table format with ',row_dimension.TL,' row and ',(ord(dimensions)-ord(row_dimension)),' column dimensions'/;
  PUT '$ife %gams2gams_rowdim%<>',row_dimension.TL @60 '$goto gams2gamslabel_after_rd_',dimensions.TL,'_',ord(arguments),'_',row_dimension.TL /;

 PUT 'PUT "TABLE %gams2gams__arg',ord(arguments),'%(';
 LOOP(column_dimension $(ord(column_dimension) le ord(dimensions)),
  PUT '%d___'column_dimension.tl'%';
  IF(ord(column_dimension) lt ord(dimensions),PUT ',';); );
 PUT ') ",%gams2gams_description% /;' /;


*
* Column labels for table format
* Use all columns for which data are nonzero in at least one row
*
  PUT ' gams2gams_currentcolumn = gams2gams_startlabelcol;' /;
* Temporarily set justification to right  uuuu
  PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.tw=%gams2gams_nw%;'/;
  PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.tj=1;'/;
* LOOP((
  PUT 'LOOP((';
* d_3__%1,d_4__%1
  LOOP(column_dimension $(ord(column_dimension) gt ord(row_dimension) and ord(column_dimension) le ord(dimensions)),
   PUT 'd_'column_dimension.tl,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) gt ord(row_dimension) and ord(column_dimension) lt ord(dimensions),PUT ',';); );
* )
  PUT ') ';
* $ SUM((
  PUT ' $ SUM((';
* d_1__%1,d_2__%1
  LOOP(column_dimension $(ord(column_dimension) le ord(row_dimension)),
   PUT 'd_',column_dimension.TL,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) lt ord(row_dimension),PUT ',';); );
* ), %1(
  PUT '), %',ord(arguments),'(';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(column_dimension $(ord(column_dimension) le ord(dimensions)),
   PUT 'd_',column_dimension.TL,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) lt ord(dimensions),PUT ',';); );
* )),
  PUT ')),'/;
* PUT @gams2gams_advancecolumn
  PUT ' PUT @gams2gams_currentcolumn ';
* PUT d_3__%1.TL,".",d_4__%1.TL;
  LOOP(column_dimension $(ord(column_dimension) gt ord(row_dimension) and ord(column_dimension) le ord(dimensions)),
* The line below has become obsolete because of the use of .tf = 4
*   PUT '"%gams2gams___quotes%",';
   PUT 'd_'column_dimension.tl'__%gams2gams__arg',ord(arguments),'%.TE(d_'column_dimension.tl'__%gams2gams__arg',ord(arguments)'%)'
*   PUT ',"%gams2gams___quotes%"';
   IF(ord(column_dimension) gt ord(row_dimension) and ord(column_dimension) lt ord(dimensions),PUT ',".",';); );
  PUT ';  ' /;
*
  PUT / '  gams2gams_currentcolumn = gams2gams_currentcolumn + gams2gams_advancecolumn;' /;
  PUT '); PUT /;' /;
* Reset label justification
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.tw=%gams2gams_tw%;'/;
PUT 'gams2gams_datafile_%gams2gams__arg',ord(arguments),'%_%gams2gams__suffix',ord(arguments),'%.tj=%gams2gams_tj%;'/;


*
* Row labels for table format
* Use all rows for which some data are nonzero
*

* LOOP((
  PUT 'LOOP((';
* d_1__%1,d_2__%1
  LOOP(column_dimension $(ord(column_dimension) le ord(row_dimension)),
   PUT 'd_',column_dimension.TL,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) lt ord(row_dimension),PUT ',';); );
* ) $ SUM((
  PUT ') $ SUM((';
* d_3__%1,d_4__%1
  LOOP(column_dimension $(ord(column_dimension) gt ord(row_dimension) and ord(column_dimension) le ord(dimensions)),
   PUT 'd_'column_dimension.tl,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) gt ord(row_dimension) and ord(column_dimension) lt ord(dimensions),PUT ',';); );
* ), %1(
  PUT '), %',ord(arguments)'(';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(column_dimension $(ord(column_dimension) le ord(dimensions)),
   PUT 'd_',column_dimension.TL,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) lt ord(dimensions),PUT ',';); );
* )),
  PUT ')),'/;
* PUT d_1__%1.TL,".",d_2__%1.TL;
  PUT ' PUT ';
  LOOP(column_dimension $(ord(column_dimension) le ord(row_dimension)),
*   PUT '"%gams2gams___quotes%",';
   PUT 'd_'column_dimension.tl'__%gams2gams__arg',ord(arguments),'%.TE(d_'column_dimension.tl'__%gams2gams__arg',ord(arguments),'%)';
*   PUT ',"%gams2gams___quotes%"';
   IF(ord(column_dimension) lt ord(row_dimension),PUT ',".",';); );
  PUT ' @gams2gams_startdatacol;' /;

*
* Data for table format
*
  PUT 'gams2gams_currentcolumn = gams2gams_startdatacol;' /;
* LOOP((
  PUT ' LOOP((';
* d_3__%1,d_4__%1
  LOOP(column_dimension $(ord(column_dimension) gt ord(row_dimension) and ord(column_dimension) le ord(dimensions)),
   PUT 'd_'column_dimension.tl,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) gt ord(row_dimension) and ord(column_dimension) lt ord(dimensions),PUT ',';); );
* Below, I have to be careful to make sure missing data don't screw up the table entry
* the condition should say: Put data whenever across all rows (not just the current row)
* at least one row has non-zero data in a column
* ) $ SUM((
  PUT ') $ SUM((';
* d_1alias__%1,d_2alias__%1
  LOOP(column_dimension $(ord(column_dimension) le ord(row_dimension)),
   PUT 'ddd___',column_dimension.TL,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) lt ord(row_dimension),PUT ',';); );
* ),%1(
  PUT '),%',ord(arguments),'(';
* d_1alias__%1,d_2alias__%1,d_3__%1,d_4__%1
  LOOP(column_dimension $(ord(column_dimension) le ord(dimensions)),
   IF(ord(column_dimension) le ord(row_dimension),PUT 'ddd___',column_dimension.TL,'__%gams2gams__arg',ord(arguments),'%'; );
   IF(ord(column_dimension) gt ord(row_dimension),PUT 'd_',column_dimension.TL,'__%gams2gams__arg',ord(arguments),'%'; );
   IF(ord(column_dimension) lt ord(dimensions),PUT ',';); );
* )),
  PUT ')),'/;
  PUT 'PUT @gams2gams_currentcolumn' /;
* If data are non-zero put data
  PUT '  IF(%',ord(arguments),'(';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(column_dimension $(ord(column_dimension) le ord(dimensions)),
   PUT 'd_'column_dimension.tl,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) lt ord(dimensions),PUT ',';); );
  PUT '),  ' /;
* PUT @gams2gams_currentcolumn %1(
  PUT '  PUT %',ord(arguments),'(';
* d_1__%1,d_2__%1,d_3__%1,d_4__%1
  LOOP(column_dimension $(ord(column_dimension) le ord(dimensions)),
   PUT 'd_'column_dimension.tl,'__%gams2gams__arg',ord(arguments),'%';
   IF(ord(column_dimension) lt ord(dimensions),PUT ',';); );
  PUT '));  ';
  PUT / '  gams2gams_currentcolumn = gams2gams_currentcolumn + gams2gams_advancecolumn;  ' /;
 PUT '); PUT /;';
* );
 PUT ' );' /;

 PUT '$goto gams2gamslabel_endof_table',ord(arguments) /;
 PUT '$label gams2gamslabel_after_rd_',dimensions.TL,'_',ord(arguments),'_',row_dimension.TL /;

 );

PUT / "$label gams2gamslabel_afterdim_",dimensions.TL,'_',ord(arguments) / /;

    );

PUT '$label gams2gamslabel_endof_table',ord(arguments) /;
PUT 'PUT ";" /;' /;
PUT '$goto gams2gams_endofall',ord(arguments) / /;

PUT '$label gams2gamslabel_endof_list',ord(arguments) /;
PUT 'PUT "/" / ";" /;' /;
PUT '$goto gams2gams_endofall',ord(arguments) / /;

PUT '$label gams2gams_endofall',ord(arguments) / /;

PUT '$label gams2gamslabel_afterargument_',ord(arguments) /;

$onput
PUTCLOSE;
$offput

  );


$onput
$label gams2gamslabel_alldone
PUT "* +++++++++++++++++++" /;
PUT "* GAMS to GAMS Export" /;
PUT "* Uwe A. Schneider" /;
PUT "* Parameter compiled on %system.date%" /;
PUT "* from file %system.incparent%" /;
PUT "* with interface %system.fp%%system.fn%%system.fe%" /;
PUT "* +++++++++++++++++++" /;
$offput
PUTCLOSE;

* Delete old interface in inclib directory and copy new interface in
$if not exist "%gams.sysdir%inclib\gams2gams.gms"    $goto after_gams2gamsinterface
execute 'del "%gams.sysdir%inclib\gams2gams.gms"';
$label after_gams2gamsinterface
execute 'copy gams2gams.gms "%gams.sysdir%inclib\gams2gams.gms"';

* Write domain extraction interface to inclib directory if it does not exist
* This interface is separate because it is also needed for other interfaces
$if exist "%gams.sysdir%inclib\getdomains.gms"   $goto after_domaininfointerface
FILE domainextractioninterface /"%gams.sysdir%inclib\getdomains.gms"/;
PUT domainextractioninterface;
$onput
* ++++++++++++++++++++++++++++++++++++++++ *
* Extract domain names to global variables *
*            Uwe A. Schneider              *
*            October 27 2013               *
* ++++++++++++++++++++++++++++++++++++++++ *

*
$gdxout u__a__s__1.gdx
$unload %1 %2 %3 %4 %5 %6 %7 %8 %9
$gdxout
$call gdxdump u__a__s__1 DomainInfo > u__a__s__1.txt

* Prepare awk script to extract domain info from gams file with all symbols
$onecho >u__a__s__1.awk
{
 if(tolower($2) == "par") {split($0,uashelparray1,"(");split(uashelparray1[2],uashelparray2,")");
   split(uashelparray1[1],uashelpsymname," ");
   split(uashelparray2[1],uashelparray3,",");print "* Parameter " uashelpsymname[4];
   for(i=1;i<=16;i++) {if(uashelparray3[i] != "") print "$setglobal gpxyz_" uashelpsymname[4] "_d" i "  " uashelparray3[i]; }}
 if(tolower($2) == "var") {split($0,uashelparray1,"(");split(uashelparray1[2],uashelparray2,")");
   split(uashelparray1[1],uashelpsymname," ");
   split(uashelparray2[1],uashelparray3,",");print "* Variable " uashelpsymname[4];
   for(i=1;i<=16;i++) {if(uashelparray3[i] != "") print "$setglobal gpxyz_" uashelpsymname[4] "_d" i "  " uashelparray3[i]; }}
 if(tolower($2) == "equ") {split($0,uashelparray1,"(");split(uashelparray1[2],uashelparray2,")");
   split(uashelparray1[1],uashelpsymname," ");
   split(uashelparray2[1],uashelparray3,",");print "* Equation " uashelpsymname[4];
   for(i=1;i<=16;i++) {if(uashelparray3[i] != "") print "$setglobal gpxyz_" uashelpsymname[4] "_d" i "  " uashelparray3[i]; }}


 if(tolower($2) == "par") {split($0,uashelparray1,"(");split(uashelparray1[2],uashelparray2,")");
   split(uashelparray1[1],uashelpsymname," ");
   split(uashelparray2[1],uashelparray3,",");print "* Parameter " uashelpsymname[4];
   for(i=1;i<=16;i++) {if(uashelparray3[i] != "") print "$setglobal d___" i "  " uashelparray3[i]; }}
 if(tolower($2) == "var") {split($0,uashelparray1,"(");split(uashelparray1[2],uashelparray2,")");
   split(uashelparray1[1],uashelpsymname," ");
   split(uashelparray2[1],uashelparray3,",");print "* Variable " uashelpsymname[4];
   for(i=1;i<=16;i++) {if(uashelparray3[i] != "") print "$setglobal d___" i "  " uashelparray3[i]; }}
 if(tolower($2) == "equ") {split($0,uashelparray1,"(");split(uashelparray1[2],uashelparray2,")");
   split(uashelparray1[1],uashelpsymname," ");
   split(uashelparray2[1],uashelparray3,",");print "* Equation " uashelpsymname[4];
   for(i=1;i<=16;i++) {if(uashelparray3[i] != "") print "$setglobal d___" i "  " uashelparray3[i]; }}

}
$offecho
* Make gams file with $setglobal assignments
$call awk -f u__a__s__1.awk u__a__s__1.txt > gpxyz_domaininfo.gms
* Show domain info
$call cat gpxyz_domaininfo.gms
* Delete helping files
*$call del u__a__s__1.awk
*$call del u__a__s__1.txt
*$call del u__a__s__1.gdx
$offput
PUTCLOSE;

$label after_domaininfointerface











