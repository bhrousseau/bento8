REM *** ***
0	CLS
	CLEAR4450,&HCE80,90
	LOADM"CDP"
	LOCATE0,0,0
	DEFINTA-P
	P0!=&HD2BC
	P1!=&HCE96
	P2!=&HD5A8
	P3!=&HD33E
	P4!=&HD359
	P5!=&HD381
	P6!=&HD3A9
	P7!=&HD3F1
	DIM C(23),D(23),M$(117),V$(17),N$(27)	REM C=ObjetsD�tenus D=EtapesFranchies M=Messages V=Verbes N=Complements
	RESTORE 236
	SCREEN7,0,0
	GOSUB234
	GOTO18

REM *** ***
1 GOSUB20
	IFK0=1THEN211
	ELSEL=0
	CONSOLE20,24
	ATTRB0,0
	COLOR7,4
	LOCATE0,20,0
	PRINT"QUE FAITES-VOUS?"
	LOCATE0,21

REM *** Ajout d'un s�parateur entre verbe et compl�ment ***
2 R$=INPUT$(1)
	IFR$>"@"ANDR$<="Z"THENIFPOS<7THENPRINTR$;
	L=L+1
	IFPOS=3THENPRINT" ";
	L=L+1

REM *** ***
3 R=ASC(R$)
	IFR=8ANDL>0ANDPOS>0THENPRINTN0$+" "+N0$;
	L=L-1
	GOTO2

REM *** ***
4 IFR<>13ANDR<>47ANDR<>42AND(R<8ORR>11)ANDR<>30THEN2
	ELSEIFR=30THEN214

REM *** ***
5 IFR=47THEN232
	ELSEIFR=13THENV$=CHR$(SCREEN(0,21))+CHR$(SCREEN(1,21))+CHR$(SCREEN(2,21))
	W$=CHR$(SCREEN(4,21))+CHR$(SCREEN(5,21))+CHR$(SCREEN(6,21))
	GOTO6
	ELSEIFL>0THEN2
	ELSE8

REM *** ***
6 CLS
	GOSUB102
	IFA0=5THENPLAY"T8L96P"
	CLS
	M=67
	GOSUB7
	PLAY"P"
	GOTO211
	ELSEIFK0=0THENIFD(3)=0ANDP=18THENN1=N1+1
	GOSUB198
	GOTO1
	ELSE1
	ELSE211

REM *** ***
7 CONSOLE20,24
	COLOR6,4
	CLS
	LOCATE0,23,0
	IFM<>16ANDM<>45ANDM<>67ANDM<>75THENPRINTM$(M)
	PLAY"T8L72P"
	RETURN
	ELSEGOSUB204
	PLAY"T8L72P"
	RETURN

REM *** ***
8 P8=P9
	D=0
	GOSUB80
	CLS
	IFD=1THEN1
	ELSEIFD=2THEN18

REM *** ***
9 IF(P9=1ANDR=8)OR(P9=2ANDR=10)OR(P9=3ANDR=9)OR(P9=4ANDR=11)THENPA=2
	P9=4
	GOTO13

REM *** ***
10 IF(P9=1ANDR=9)OR(P9=2ANDR=11)OR(P9=3ANDR=8)OR(P9=4ANDR=10)THENPA=4
	P9=2
	GOTO13

REM *** ***
11 IF(P9=1ANDR=11)OR(P9=2ANDR=8)OR(P9=3ANDR=10)OR(P9=4ANDR=9)THENPA=3
	P9=1
	GOTO13

REM *** ***
12 IF(P9=1ANDR=10)OR(P9=2ANDR=9)OR(P9=3ANDR=11)OR(P9=4ANDR=8)THENPA=1
	P9=3

REM *** ***
13 PB=PEEK(40868+P@2+&H4000)
	IFPMOD2=0THENPB=PB@16
	ELSEPB=PBMOD16

REM *** ***
14 IF(PBAND(2^(4-PA)))=0THENPLAY"O3T8L48DO"
	LOCATE0,23,0
	COLOR6,1
	PRINT"ERREUR DE DIRECTION"
	P9=P8
	GOTO1

REM *** ***
15 IFD(5)=1THENN2=N2+1

REM *** ***
16 IFN2=2THEND(5)=0
	N2=0

REM *** ***
17 P=P+((PA=2)-(PA=4))+8*((PA=3)-(PA=1))

REM *** ***
18 I=PMOD4+P@8+4*(P@8>4)
	I=I+4*(I>3)
	POKE&HCE8C,G(I)
	POKE&HCE8A,P9
	POKE&HCE8B,P
	POKE&HCE90,C(5)
	POKE&HCE91,C(9)
	IFP=36THENPOKE&HCE95,D(1)
	ELSEPOKE&HCE95,D(20)

REM *** ***
19 GOSUB23
	GOTO1

REM *** ***
20 CONSOLE0,24
	H0=H0+1
	IFH0>59THENH0=0
	H1=H1+1

REM *** ***
21 IFH1=6THENK0=1
	M=39
	GOSUB7
	RETURN

REM *** ***
22 COLOR1,0
	LOCATE31,19
	PRINTQ$(1);Q$(H1)
	LOCATE33,18
	PRINT" "
	LOCATE33,19
	PRINT"."
	LOCATE34,19
	PRINTQ$(H0@10);Q$(H0 MOD10)
	BOX(247,143)-(288,159),7
	RETURN

REM *** ***
23 CONSOLE0,24
	EXECP0!
	EXECP1!
	C=PEEK(&HCE8E)
	IFP=37THENIFC(1)=0THENPRINTCHR$(27);CHR$(&H70);
	GOSUB241
	LOCATE14,15
	PRINTR0$
	RETURN

REM *** ***
24 IFP<>46THEN26
	ELSEBOXF(96,120)-(127,135),-6
	BOXF(113,129)-(133,134),7
	COLORC,5
	LOCATE12,16
	PRINTT0$
	LINE(96,120)-(112,128),2
	LINE(108,126)-(108,134),2
	LINE(100,122)-(100,130),2
	COLOR5
	GOSUB241
	LINE(128,135)-(135,135)

REM *** ***
25 LINE(128,128)-(135,128)
	LOCATE15,15
	PRINTT0$
	RETURN

REM *** ***
26 IFP=30THENIFC(2)=0THENLOCATE14,15
	GOSUB241
	PRINTB0$
	RETURN

REM *** ***
27 IFP=31THENIFC(3)=0THENLOCATE14,15
	GOSUB241
	PRINTB1$
	RETURN

REM *** ***
28 IFP=63THENIFC(4)=0THENCOLOR5
	GOSUB241
	LOCATE14,15
	PRINTS$
	RETURN

REM *** ***
29 IFP=58THENIFD(5)=0THENCOLOR1
	FORI=1TO23
	LINE(8*I+8,87)-(8*I+16,87)
	PLAYM0$
	NEXTI
	M=45
	GOSUB7
	K0=1
	RETURN

REM *** ***
30 IFP=49THENIFD(22)=0THENLOCATE7,19
	PRINTCHR$(27)+"B"+CHR$(27)+"x"+GR$(36)+CHR$(27)+"C"+GR$(37)+GR$(38)

REM *** ***
31 IFP=49THENIFC(6)=0THENLOCATE14,15
	PRINTCHR$(27);CHR$(&H75);
	GOSUB241
	PRINTGR$(31)
	RETURN

REM *** ***
32 IFP=9THENIFC(7)=0THENPRINTCHR$(27);CHR$(&H74);
	GOSUB241
	LOCATE13,15
	PRINTF0$	REM *** Seringue ? ***
	RETURN

REM *** ***
33 IFP=32THENIFC(8)=0THENCOLOR4
	GOSUB241
	LOCATE14,15
	PRINTO0$
	RETURN

REM *** ***
34 IFP=3THENCOLOR,1
	G0=C
	C=2+3*C(9)
	GOSUB242
	C=G0
	LOCATE9,7
	PRINTM1$(C(9))
	RETURN

REM *** ***
35 IFP=17THENIFP9=4THENCOLOR,6
	G0=C
	C=2-C(10)
	GOSUB242
	C=G0
	LOCATE9,7
	PRINTM1$(C(10))
	RETURN
	ELSEBOXF(104,32)-(127,47),-5
	BOX(103,31)-(128,48),1
	RETURN

REM *** ***
36 IFP=34THENIFC(11)=0THENCOLOR2
	GOSUB241
	LOCATE14,15
	PRINTB2$
	RETURN

REM *** ***
37 IFP=0THENPRINTCHR$(27);CHR$(&H74);
	A=9-9*(P9=4)
	LOCATEA,10
	PRINTV0$
	LOCATEA,12
	PRINTV1$
	RETURN

REM *** ***
38 IFP=6ORP=15THENATTRB0,1
	COLOR7,4
	LOCATE11,7
	PRINT"COUCOU!"
	BOX(87,47)-(144,64),1
	ATTRB0,0
	RETURN

REM *** ***
39 IFP=7THENCOLOR7,4
	ATTRB0,1
	LOCATE11,6
	PRINT"3X-47=O"
	LOCATE11,8
	PRINT"  ???  "
	BOX(87,39)-(144,72),1
	ATTRB0,0
	RETURN

REM *** ***
40 IFP=4THENIFC(14)=0THENCOLOR1
	GOSUB241
	LOCATE14,15
	PRINTN3$
	RETURN

REM *** ***
41 IFP=48ANDC(15)=0THENIFD(5)=0THENM=35
	GOSUB7
	K0=1
	RETURN
	ELSEM=93
	GOSUB7
	RETURN

REM *** ***
42 IFP=18THENC(18)=1
	RETURN

REM *** ***
43 IFP=28THENIFD(21)=0THENLOCATE14,15
	PRINTCHR$(27);CHR$(&H75);
	GOSUB241
	PRINTGR$(31)
	RETURN

REM *** ***
44 RETURN

REM *** ***
45 B=0
	IFP=32THENM2$="SCHMILBLIC"
	ELSEM2$="NEUTRALISATEUR"
	DIML$(14)

REM *** ***
46 LOCATE0,0,0
	CLS
	PRINT"Vous devez remettre les lettres � leur"
	PRINT"place en permutant deux lettres � cha-"
	PRINT"-que fois"
	F=LEN(M2$)
	PRINT
	PRINTM$(58);
	R$=INPUT$(1)
	CLS
	FORI=1TOF
	L$(I)=MID$(M2$,I,1)
	NEXT
	K=INT(RND*4)+3
	H=K
	FORI=1TOF
	K=K+3
	IFK>FTHENK=K-F

REM *** ***
47 M3$=M3$+L$(K)
	NEXT
	B=1
	A=0

REM *** ***
48 COLOR3,4
	LOCATE0,21,0
	PRINTM3$;
	S=0
	COLOR1,0
	LOCATE0,24
	PRINT"Essai No";B;
	IFB>26THEN59
	ELSEIFB>1THEN56

REM *** ***
49 R$=INKEY$
	IFR$=""THENCOLOR1,4
	LOCATEA,22,0
	PRINTCHR$(126);
	PLAY"T8L6P"
	LOCATEA,22,0
	PRINT" ";
	GOTO49

REM *** ***
50 R=ASC(R$)
	IFR=13THEN53
	ELSEIFR<>8ANDR<>9THEN49
	ELSEA=A+(R=8)-(R=9)

REM *** ***
51 IFA<0THENA=0
	GOTO49
	ELSEIFA>F-1THENA=F-1
	GOTO49

REM *** ***
52 GOTO49

REM *** ***
53 S=S+1
	K(S)=A+1
	IFS=1THEN49
	ELSEIFK(1)=K(2)THENS=0
	GOTO49

REM *** ***
54 IFK(1)>K(2)THENK=K(2)
	K(2)=K(1)
	K(1)=K

REM *** ***
55 M3$=LEFT$(M3$,K(1)-1)+MID$(M3$,K(2),1)+MID$(M3$,K(1)+1,K(2)-K(1)-1)+MID$(M3$,K(1),1)+RIGHT$(M3$,F-K(2))
	B=B+1
	GOTO48

REM *** ***
56 T=0
	FORI=1TOF
	IFL$(I)=MID$(M3$,I,1)THENT=T+1

REM *** ***
57 NEXT
	IFT<>FTHEN49

REM *** ***
58 COLOR2,0
	LOCATE17,24,0
	PRINT"BRAVO!";
	PLAYM4$
	COLOR,4
	CLS
	RETURN

REM *** ***
59 COLOR0,4
	LOCATE0,24,0
	PRINTM$(39);
	K0=1
	RETURN

REM *** ***
60 K=0
	COLOR1
	LOCATE0,0,0
	CLS
	PRINT"Vous devez trouver la combinaison selon"
	PRINT"le principe du Mastermind."
	COLOR0
	PRINT"Chiffre noir
	Nbre de bien plac�s"
	COLOR7
	PRINT"Chiffre blanc
	Nbre de mal plac�s"
	COLOR3
	PRINTM$(58);

REM *** ***
61 R$=INKEY$
	IFR$=""THENZ=RND
	GOTO61
	ELSE
	F=INT(RND*2)+4
	Q=F+3
	N4=6-3*(F=5)
	FORI=1TOF
	H(I)=INT(RND*Q)
	NEXT
	CLS

REM *** ***
62 COLOR7
	PRINT
	PRINT
	PRINT"La combinaison a";F;"chiffres de 0 �";Q-1
	CONSOLE0,24
	COLOR0,2
	LOCATE29,0,0
	PRINT"Combinaison"

REM *** ***
63 K=K+1
	A=31
	B=K+2
	IFK>N4THEN71

REM *** ***
64 COLOR1,4
	LOCATEA-2,B,0
	PRINTMID$(STR$(K),2);"
	";
	COLOR3
	GOSUB98
	IFVAL(E$)>10^FTHENPLAY"O3T8L48DO"
	LOCATEA,B
	PRINTSPC(5)
	GOTO64

REM *** ***
65 FORI=1TOF
	E(I)=VAL(MID$(E$,I,1))
	F(I)=0
	G(I)=0
	NEXT
	G=0
	H=0
	FORI=1TOF
	IFE(I)=H(I)THENG(I)=1
	F(I)=1
	G=G+1

REM *** ***
66 NEXTI
	FORI=1TOF
	IFF(I)=1THEN69

REM *** ***
67 FORJ=1TOF
	IFG(J)=1THEN68
	ELSEIFE(I)=H(J)THENH=H+1
	G(J)=1
	J=F

REM *** ***
68 NEXTJ

REM *** ***
69 NEXTI
	IFG<>FTHENCOLOR0
	LOCATE36,B
	PRINTG;N0$;
	COLOR7
	PRINTLEFT$(STR$(H),2);N0$
	GOTO63

REM *** ***
70 LOCATE0,23,0
	COLOR3
	PRINT"BRAVO!";
	PLAYM4$+"T8L96P"
	BOXF(232,0)-(319,135),-5
	RETURN

REM *** ***
71 COLOR0
	LOCATE0,23,0
	PRINTM$(39)
	PLAY"T8L96P"
	K0=1
	RETURN

REM *** ***
72 COLOR1
	LOCATE0,0,0
	CLS
	PRINT"Vous devez trouver le code secret.Ce"
	PRINT"code est compris entre 1000 et 9999."
	COLOR3
	PRINT
	PRINT
	PRINTM$(58);
	R$=INPUT$(1)
	CLS
	COLOR1
	PRINT"L'ordinateur vous donne la somme des"
	PRINT"chiffres de la diff�rence entre le "
	PRINT"code et votre essai."
	COLOR3
	PRINT
	PRINTM$(58);

REM *** ***
73 R$=INKEY$
	IFR$=""THENZ=RND
	GOTO73

REM *** ***
74 C0=INT(RND*9000)+1000
	K=1
	A=32
	B=1
	F=4
	CLS
	CONSOLE0,24
	COLOR0,2
	LOCATE29,0,0
	PRINT"Code secret"

REM *** ***
75 COLOR1,4
	LOCATEA-3,B,0
	IFK<10THENPRINTK;N0$;"
	";
	ELSEPRINTMID$(STR$(K),2);"
	";

REM *** ***
76 COLOR3
	GOSUB98
	IFVAL(E$)<1000THENPLAY"O3T8L48DO"
	LOCATEA,B
	PRINTSPC(4)
	GOTO75

REM *** ***
77 D=ABS(C0-VAL(E$))
	IFD=0THEN70

REM *** ***
78 D$=STR$(D)
	FORI=1TOLEN(D$)
	S=S+VAL(MID$(D$,I,1))
	NEXT
	COLOR7
	LOCATE37,B
	PRINTMID$(STR$(S),2)+N0$
	S=0
	K=K+1
	B=B+1
	IFB=17THENB=B-16
	BOXF(232,8)-(319,135),-5

REM *** ***
79 IFK>50THEN70
	ELSE75

REM *** ***
80 IFP=36ANDD(1)=1THENIFR=11THENP=20
	P9=1
	D=2
	RETURN

REM *** ***
81 IF(P=55)AND((P9=3ANDR=11)OR(P9=2ANDR=9))THENIFD(2)=0THENM=33
	GOSUB7
	D=1
	PLAY"T8L96P"
	RETURN
	ELSEIFD(8)=0THENM=53
	GOSUB7
	D=1
	PLAY"T8L96P"
	RETURN

REM *** ***
82 IFP=18THENIF(R=11ANDD(4)=1)THENP=17
	P9=4
	D=2
	RETURN
	ELSEIF(D(3)=1ANDN1=4)THENM=40
	GOSUB7
	D=1
	RETURN
	ELSEIFD(3)=0THENM=14
	GOSUB7
	N1=N1+1
	GOSUB198
	D=1
	RETURN

REM *** ***
83 IFP=35ANDC(5)=0ANDR=11THENM=52
	GOSUB7
	D=1
	RETURN

REM *** ***
84 IFP=60ANDD(20)=1THENIFR=11THENP=62
	P9=2
	D=2
	RETURN

REM *** ***
85 IFP=7THENIFR=42THENM=55
	GOSUB7
	P=23
	P9=3
	D=2
	RETURN
	ELSEIFR=10THENM=18
	GOSUB7
	D=1
	RETURN

REM *** ***
86 IFP=21ANDP9=3ANDR=8THENIFC(16)=0THENM=78
	GOSUB7
	PLAY"T8L96P"
	GOSUB72
	C(16)=1
	M=9
	GOSUB7
	D=1
	RETURN
	ELSEIFD(9)=0THENM=52
	GOSUB7
	D=1
	RETURN

REM *** ***
87 IFP=62ANDR=11THENIFC(12)=0THENM=40
	GOSUB7
	D=1
	RETURN
	ELSEP=8
	P9=1
	D=2
	RETURN

REM *** ***
88 IFP=12ANDR=11ANDC(9)=0THENFORI=1TO10
	PLAYM5$+M5$+M0$
	NEXT
	M=50
	GOSUB7
	K0=1
	D=1
	RETURN

REM *** ***
89 IFP=58AND((R=8ANDP9=2)OR(R=9ANDP9=4))THENM=44
	GOSUB7
	D=1
	RETURN

REM *** ***
90 IFP=17ANDC(10)=0ANDR=11THENM=21
	GOSUB7
	RETURN

REM *** ***
91 IFP=13ANDP9=2ANDR=10THENM=18
	D=1
	GOSUB7
	RETURN

REM *** ***
92 IFP=10ANDP9=3AND(R=8ORR=9)THENIFD(23)=0THENM=77
	GOSUB7
	GOSUB208
	D(23)=1
	M=9
	GOSUB7
	D=1
	RETURN
	ELSEIFC(23)=0THENM=53
	GOSUB7
	D=1
	RETURN

REM *** ***
93 RETURN

REM *** ***
94 COLOR7
	LOCATE0,0,0
	CLS
	PRINT"TLDF LDIFVF OC TJYYJKC YCEFCP ILDY"
	PRINT"UCICN PJTCF OC XLP YDVIJZP"
	PRINT"JHFJEJUJHFJ"
	COLOR3
	PRINT
	PRINTM$(58);
	R$=INPUT$(1)
	CLS
	RETURN

REM *** ***
95 COLOR7
	PLAYM6$+"T8L96P"
	CLS
	PRINT"MESSAGE=XCYYJKC"
	A=0
	B=22
	F=11

REM *** ***
96 COLOR3
	GOSUB98
	IFE$=C1$THENPLAYM4$
	CLS
	GOSUB190	REM *** Animation : Fait apparaitre une porte secr�te ***
	D(20)=1
	RETURN

REM *** ***
97 PLAY"O3T8L48DO"
	LOCATE0,22
	PRINTSPC(11)
	GOTO96

REM *** ***
98 LOCATEA,B,0

REM *** ***
99 R$=INPUT$(1)
	R=ASC(R$)
	IF(R<58ANDR>47)OR(R<91ANDR>64)THENIFPOS<F+ATHENPRINTR$;

REM *** ***
100 IFR=8ANDPOS>ATHENPRINTN0$;" ";N0$;
	GOTO99
	ELSEIFR<>13THEN99

REM *** ***
101 E$=""
	FORI=0TOF-1
	E$=E$+CHR$(SCREEN(I+A,B))
	NEXT
	RETURN

REM *** ***
102 V=0
	FORI=1TO17
	IFV$=V$(I)THENV=I
	I=17

REM *** ***
103 NEXTI
	IFV=0THENIFP<>18THENM=113
	GOSUB7
	RETURN
	ELSEM=14
	GOSUB7
	RETURN

REM *** ***
104 N=0
	FORI=1TO27
	IFW$=N$(I)THENN=I
	I=27

REM *** ***
105 NEXTI
	IFN=0THENIFP<>18THENM=114
	GOSUB7
	RETURN
	ELSEM=14
	GOSUB7
	RETURN

REM *** Branchement en fonction du verbe ***
106 ONVGOTO 107,123,140,142,146,157,161,164,166,170,171,174,176,179,183,185,187

REM *** Verbe PRE : Prendre ***
107 IFC(2)=1THENA0=A0+1						REM *** 
	ELSEIF(P=46ANDN=4)OR(P=0ANDN=12)THENM=4	REM *** Il est fix� au sol (Pi�ce 46 Prendre Livre), (Pi�ce 0 Prendre Vase) ***
	GOSUB7
	RETURN

REM *** ***
108 IFP=37THENIFN<>5THENM=57
	GOSUB7
	RETURN
	ELSEIFC(1)=1THENM=68
	GOSUB7
	RETURN
	ELSEM=INT(RND*4)+6
	C(1)=1
	GOTO122

REM *** ***
109 IFP=30THENIFN<>2THENM=57
	GOSUB7
	RETURN
	ELSEIFC(2)=1THENM=68
	GOSUB7
	RETURN
	ELSEM=INT(RND*4)+6
	C(2)=1
	GOTO122

REM *** ***
110 IFP=31THENIFN<>3THENM=57
	GOSUB7
	RETURN
	ELSEIFC(3)=1THENM=68
	GOSUB7
	RETURN
	ELSEM=INT(RND*4)+6
	C(3)=1
	GOTO122

REM *** ***
111 IFP=63THENIFN<>16THENM=57
	GOSUB7
	RETURN
	ELSEIFC(4)=1THENM=68
	GOSUB7
	RETURN
	ELSEM=INT(RND*4)+6
	C(4)=1
	GOTO122

REM *** ***
112 IFP=49THENIFN=6THENIFC(6)=1THENM=68
	GOSUB7
	RETURN
	ELSEIFC(21)=1THENC(21)=0
	C(6)=1
	M=INT(RND*4)+6
	GOTO122
	ELSEM=88
	GOSUB7
	RETURN
	ELSE119

REM *** ***
113 IFP=9THENIFN<>18THENM=57
	GOSUB7
	RETURN
	ELSEIFC(7)=1THENM=68
	GOSUB7
	RETURN
	ELSEM=INT(RND*4)+6
	C(7)=1
	GOTO122

REM *** ***
114 IFP=32THENIFN<>1THENM=57
	GOSUB7
	RETURN
	ELSEIFC(8)=1THENM=68
	GOSUB7
	RETURN
	ELSEM=61
	GOSUB7
	PLAY"T8L96P"
	GOSUB45
	C(8)=1
	M=9
	GOTO122

REM *** ***
115 IFP=4THENIFN<>1ANDN<>27THENM=57
	GOSUB7
	RETURN
	ELSEIFC(14)=1THENM=68
	GOSUB7
	RETURN
	ELSEIFN=1THENM=61
	GOSUB7
	PLAY"T8L96P"
	GOSUB45
	C(14)=1
	M=9
	GOTO122
	ELSEM=INT(RND*3)+6
	C(14)=1
	GOTO122

REM *** ***
116 IFP=0THENIFN<>21THENM=57
	GOSUB7
	RETURN
	ELSEIFC(13)=1THENM=68
	GOSUB7
	RETURN
	ELSEIFD(13)=0THENM=62
	GOSUB7
	RETURN
	ELSEM=INT(RND*4)+6
	C(13)=1
	RETURN

REM *** ***
117 IFP=23THENIFN<>2THENM=57
	GOSUB7
	RETURN
	ELSEIFD(16)=0THENM=63
	GOSUB7
	RETURN
	ELSEIFD(14)=0THENM=94
	GOSUB7
	FORI=1TO10
	PLAYM6$+M0$
	NEXTI
	K0=1
	RETURN
	ELSEM=64
	GOSUB7
	GOTO230

REM *** ***
118 IFP=34THENIFN<>20THENM=57
	GOSUB7
	RETURN
	ELSEIFC(11)=1THENM=68
	GOSUB7
	RETURN
	ELSEM=INT(RND*4)+6
	C(11)=1
	GOTO122

REM *** ***
119 IFP=49THENIFN<>25THENM=57
	GOSUB7
	RETURN
	ELSEPRINTCHR$(27);CHR$(&H78);
	LOCATE7,19,0
	PRINT"   "
	M=INT(4*RND)+6
	D(22)=1
	GOSUB7
	RETURN

REM *** ***
120 IFP=28THENIFN<>24THENM=57
	GOSUB7
	RETURN
	ELSEIFD(21)=1THENM=68
	GOSUB7
	RETURN
	ELSEIFC(21)=1THENC(21)=0
	D(21)=1
	M=INT(RND*4)+6
	GOTO122
	ELSEM=88
	GOSUB7
	RETURN

REM *** ***
121 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** ***
122 C=PEEK(&HCE8E)
	C=CMOD8
	BOXF(96,120)-(127,135),-C-1
	GOSUB7
	RETURN

REM *** ***
123 IFN=5THENIFC(1)=0THENM=3
	GOSUB7
	RETURN
	ELSEIFD(6)=1THENM=66
	GOSUB7
	RETURN
	ELSEM=27
	GOSUB7
	RETURN

REM *** ***
124 IFN=2THENIFC(2)=1THENM=24
	GOSUB7
	RETURN
	ELSEIF(P=23ANDD(11)=1)THENM=70
	GOSUB7
	RETURN
	ELSEM=3
	GOSUB7
	RETURN

REM *** ***
125 IFN=3THENIFC(3)=0THENM=3
	GOSUB7
	RETURN
	ELSEM=16
	GOSUB7
	RETURN

REM *** ***
126 IFP=46THENIFN=4THENM=69
	GOSUB7
	RETURN
	ELSEIFN=19THENM=92
	GOSUB7
	PLAY"T8L48P"
	GOSUB197
	RETURN
	ELSEM=96
	GOSUB7
	RETURN

REM *** ***
127 IFN=13THENIF((P=35ANDC(5)=0)ORP=7)THENM=32
	GOSUB7
	RETURN
	ELSEIFP=61THENM=111
	GOSUB7
	RETURN
	ELSEIFP=62THENM=112
	GOSUB7
	RETURN
	ELSEIF(P=60ORP=36)THENM=104
	GOSUB7
	RETURN
	ELSEIFP=23THENM=117
	GOSUB7
	RETURN
	ELSE139

REM *** ***
128 IFN=6THENIFC(6)=0THENM=3
	GOSUB7
	RETURN
	ELSEM=30
	GOSUB7
	RETURN

REM *** ***
129 IFN=16THENIFC(4)=0THENM=3
	GOSUB7
	RETURN
	ELSEM=31
	GOSUB7
	RETURN

REM *** ***
130 IFN=18THENIFC(7)=0THENM=3
	GOSUB7
	RETURN
	ELSEM=71
	GOSUB7
	RETURN

REM *** ***
131 IFN=20THENIFC(11)=0THENM=3
	GOSUB7
	RETURN
	ELSEM=19
	GOSUB7
	RETURN

REM *** ***
132 IFN=12ANDP=0THENM=59
	GOSUB7
	RETURN

REM *** ***
133 IFN=14ANDD(15)=1THENM=38
	GOSUB7
	D(18)=1
	RETURN

REM *** ***
134 IFN=1THENIF(P=32ORP=4)THENM=60
	GOSUB7
	RETURN
	ELSEM=3
	GOSUB7
	RETURN

REM *** ***
135 IFN=8THENIFP=23THENM=73
	GOSUB7
	RETURN
	ELSEM=72
	GOSUB7
	RETURN

REM *** ***
136 IFC(2)=1THENA0=A0+1

REM *** ***
137 IFN=21THENIFC(13)=1THENM=95
	GOSUB7
	RETURN
	ELSEM=62
	GOSUB7
	RETURN

REM *** ***
138 IFN=23THENIFP=49ORP=28THENM=104
	GOSUB7
	RETURN
	ELSEM=102
	GOSUB7
	RETURN

REM *** ***
139 M=23
	GOSUB7
	RETURN

REM *** ***
140 IFN=9ANDP=36THENIFD(1)=1THENM=83	REM *** Pi�ce 36 PRO FOR Prononcer formule ***
	GOSUB7
	RETURN
	ELSEGOSUB190	REM *** Pi�ce 36 Animation : Fait apparaitre une porte secr�te ***
	D(1)=1
	M=20
	GOSUB7
	RETURN

REM *** ***
141 M=74
	GOSUB7
	RETURN

REM *** ***
142 IFN=4ANDP=46THENM=5
	GOSUB7
	RETURN

REM *** ***
143 IFN=22THENIFP=60THENIFD(19)=1THENM=48
	GOSUB7
	RETURN
	ELSED(19)=1
	GOSUB94
	M=9
	GOSUB7
	RETURN
	ELSEIFN=22THENIFP=36THENM=98	REM *** Pi�ce 36 LIR MES Lire Message ***
	GOSUB7
	RETURN
	ELSEM=91
	GOSUB7
	RETURN

REM *** ***
144 IFN=24THENIFD(21)=0THENM=51
	GOSUB7
	RETURN
	ELSEIFC(22)=0THENM=105
	GOSUB7
	RETURN
	ELSEM=106
	GOSUB7
	RETURN

REM *** ***
145 M=108
	GOSUB7
	RETURN

REM *** ***
146 IFN=7ANDP=10THENIFC(23)=0THENIFD(23)=1THENC(23)=1
	M=INT(RND*4)+6
	GOSUB7
	RETURN
	ELSEM=18
	GOSUB7
	RETURN

REM *** ***
147 IFN=2ANDC(2)=1THENM=75
	K0=1
	GOSUB7
	RETURN

REM *** ***
148 IF(N=3ANDC(3)=1)OR(N=20ANDC(11)=1)OR(N=6ANDC(6)=1)THENM=INT(RND*4)+6
	GOSUB7
	RETURN

REM *** ***
149 IFN=7ANDP=55THENIFD(8)=0THENIFD(2)=1THEND(8)=1
	M=INT(RND*4)+6
	PLAYM7$+M5$
	GOSUB7
	RETURN
	ELSEM=18
	GOSUB7
	RETURN

REM *** ***
150 IFN=7ANDP=21THENIFD(9)=0THENIFC(16)=1THEND(9)=1
	M=INT(RND*4)+6
	GOSUB7
	RETURN
	ELSEM=78
	GOSUB7
	PLAY"T8L96P"
	GOSUB72
	C(16)=1
	RETURN

REM *** ***
151 IFN=7THENIFPB=0THENM=76
	GOSUB7
	RETURN
	ELSEM=10
	GOSUB7
	RETURN

REM *** ***
152 IFN=4ANDP=46THENM=5
	GOSUB7
	RETURN

REM *** ***
153 IFN=8THENIFP<>23THENM=72
	GOSUB7
	RETURN
	ELSEIFC(13)=0THENM=13
	GOSUB7
	RETURN
	ELSEIFD(10)=0THENM=78
	GOSUB7
	PLAY"T8L96P"
	GOSUB60
	D(10)=1
	M=9
	GOSUB7
	RETURN
	ELSEIFD(11)=0THENM=40
	GOSUB7
	RETURN
	ELSED(16)=1
	M=9
	GOSUB195
	GOSUB7
	RETURN

REM *** ***
154 IFN=14THENIF(P<>61ANDP<>62)THENM=26
	GOSUB7
	RETURN
	ELSEIFP=62THEND(15)=1
	GOSUB193
	M=9
	GOSUB7
	RETURN
	ELSEK0=1
	GOSUB193
	RETURN

REM *** ***
155 IFN=12ANDP=18THENIFD(3)=1ANDN1=4THEND(4)=1
	M=9
	GOSUB7
	RETURN
	ELSEIFD(3)=1THENM=18
	GOSUB7
	RETURN
	ELSEM=14
	GOSUB7
	RETURN

REM *** ***
156 M=INT(RND*3+1)
	GOSUB7
	IFC(2)=1THENA0=A0+1
	RETURN
	ELSERETURN

REM *** ***
157 IFN=2THENIFC(2)=0THENM=79
	GOSUB7
	RETURN
	ELSEK0=1
	M=47
	GOSUB7
	RETURN

REM *** ***
158 IFN=3THENIFC(3)=0THENM=79
	GOSUB7
	RETURN
	ELSEM=80
	K0=1
	GOSUB7
	RETURN

REM *** ***
159 IFN=20THENIFC(11)=0THENM=79
	GOSUB7
	RETURN
	ELSEIFD0=0THENM=25
	GOSUB7
	RETURN
	ELSEM=15
	D0=D0-1
	D(5)=1
	GOSUB7
	RETURN

REM *** ***
160 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** ***
161 IFN=10ANDP=17THENIFC(10)=1THENM=48
	GOSUB7
	RETURN
	ELSEC(10)=1
	COLOR1,6
	LOCATE9,7
	PRINTM1$(1)
	PLAYM6$
	M=34
	GOSUB7
	FORI=1TO50
	PLAYM0$
	NEXT
	RETURN

REM *** ***
162 IFN=10ANDP=3THENIFC(9)=1THENM=48
	GOSUB7
	RETURN
	ELSEC(9)=1
	COLOR5,0
	LOCATE9,7
	PRINTM1$(1)
	PLAYM6$
	M=42
	GOSUB7
	FORI=1TO50
	PLAYM0$
	NEXT
	RETURN

REM *** ***
163 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** Verbe BOU : Boucher ***
164 IFN=11ANDP=18THENIFC(4)=0THENM=13	REM *** P=18 Pi�ce numero 18 *** Avec Quoi ? C(4)=0 pas de Mastic *** 
	GOSUB7
	RETURN
	ELSEM=81	REM *** L'eau s'arr�te de monter ***
	D(3)=1		REM *** D(3)=1 ***
	GOSUB7
	RETURN

REM *** ***
165 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** ***
166 IFN=5THENIF(C(1)=0ORD(6)=0)THENM=12
	GOSUB7
	RETURN
	ELSEIF(P<>55ANDP<>48ANDP<>21)THENM=82
	GOSUB7
	RETURN
	ELSEIFP=55THENPLAYM7$
	PLAYM7$
	M=54
	D(2)=1
	GOSUB7
	RETURN
	ELSEIFP=48THENPLAYM7$
	PLAYM7$
	M=36
	C(15)=1
	GOSUB7
	RETURN
	ELSEM=41
	GOSUB7
	RETURN

REM *** ***
167 IFN=21THENIFC(13)=0THENM=62
	GOSUB7
	RETURN
	ELSEIFP<>23THENM=83
	GOSUB7
	RETURN
	ELSEIFD(16)=1THENM=22
	GOSUB7
	RETURN
	ELSEIFD(10)=0THENM=78
	GOSUB7
	PLAY"T8L96P"
	GOSUB60
	D(1O)=1
	RETURN
	ELSED(11)=1
	PLAYM5$+M0$
	M=INT(RND*4)+6
	GOSUB7
	RETURN

REM *** ***
168 IFC(2)=1THENA0=A0+1

REM *** ***
169 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** ***
170 IFN=17THENM=65
	ELSEM=84
	GOSUB7
	RETURN

REM *** ***
171 IFN=2THENIFC(2)=1THENM=75
	K0=1
	GOSUB7
	RETURN

REM *** ***
172 IFN=3THENIFC(3)=0THENM=51
	GOSUB7
	RETURN
	ELSEIFD(17)=1THENM=85
	GOSUB7
	RETURN
	ELSEIFP<>35THEND(17)=1
	M=80
	GOSUB7
	RETURN
	ELSEC(5)=1
	C(3)=0
	D(17)=1
	GOSUB189
	M=9
	GOSUB7
	RETURN

REM *** ***
173 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** ***
174 IFN=12THENIFP<>0THENM=86
	GOSUB7
	RETURN
	ELSEIFD(13)=1THENM=48
	GOSUB7
	RETURN
	ELSEIFD(12)=0THENM=49
	GOSUB7
	K0=1
	RETURN
	ELSEM=56
	D(13)=1
	GOSUB7
	RETURN

REM *** ***
175 M=87
	GOSUB7
	RETURN

REM *** ***
176 IFN=5THENIFC(1)=0THENM=51
	GOSUB7
	RETURN
	ELSEIFC(6)=0THENM=13
	GOSUB7
	RETURN
	ELSEIFD(6)=1THENM=48
	GOSUB7
	RETURN
	ELSEM=INT(RND*4)+6
	GOSUB7
	D(6)=1
	RETURN

REM *** ***
177 IFN=17THENIFP<>0THENM=88
	GOSUB7
	RETURN
	ELSEIFC(7)=0THENM=13
	GOSUB7
	RETURN
	ELSEPLAYM8$
	D(12)=1
	M=9
	GOSUB7
	RETURN

REM *** ***
178 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** ***
179 IFN=15THENIFP<>62THENM=89
	GOSUB7
	RETURN
	ELSEIF(D(15)=0ORD(18)=0)THENM=88
	GOSUB7
	RETURN
	ELSEC(12)=1
	M=9
	GOSUB7
	RETURN

REM *** ***
180 IFN=22THENIF(P<>60ORD(19)=0)THENM=91
	GOSUB7
	RETURN
	ELSEIFD(20)=1THENM=48
	GOSUB7
	RETURN
	ELSEM=90
	GOSUB7
	GOSUB95
	M=9
	GOSUB7
	RETURN

REM *** ***
181 IFN=13THENM=97
	GOSUB7
	RETURN

REM *** ***
182 M=INT(RND*3)+1
	GOSUB7
	RETURN

REM *** ***
183 IFN=27THENIFC(14)=0THENM=51
	GOSUB7
	RETURN
	ELSEIF(P<>23ORD(16)=0)THENM=88
	GOSUB7
	RETURN
	ELSED(14)=1
	GOSUB196
	RETURN

REM *** ***
184 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** ***
185 IFN=23THENIFP=49ANDC(6)=0THENM=99
	C(21)=1
	GOSUB7
	RETURN
	ELSEIFP=28ANDD(21)=0THENM=100
	C(21)=1
	GOSUB7
	RETURN
	ELSEM=101
	GOSUB7
	RETURN

REM *** ***
186 M=INT(RND*3+1)
	GOSUB7
	RETURN

REM *** ***
187 IFN=26THENIFD(22)=0THENM=13
	GOSUB7
	RETURN
	ELSEIFD(21)=0THENM=51
	GOSUB7
	RETURN
	ELSEC(22)=1
	M=107
	GOSUB7
	RETURN

REM *** ***
188 M=103
	GOSUB7
	RETURN

REM *** ***
189 M=115
	GOSUB7
	FORT=1TO50
	PLAYM5$
	NEXT
	BOXF(104,40)-(127,95),-1
	PSET(12,6)K$,0
	PSET(16,6)K$,0
	PSET(12,8)K$,0
	PSET(16,8)K$,0
	PSET(12,10)K$,0
	PSET(16,10)K$,0
	RETURN

REM *** Animation : Fait apparaitre une porte secr�te ***
190 PLAYM6$
	COLOR0
	RESTORE191
191 DATA 106,126,106,126,107,125,108,124,108,124,110,122,111,121,113,119,115,117
192 FORI=1TO32
	LINE(105,96-I)-(127,96-I)
	PLAYM5$
	NEXT
	FORI=1TO9
	READA,B
	LINE(A,64-I)-(B,64-I)
	PLAYM5$
	NEXT
	RETURN

REM *** ***
193 PLAY"T8L48O2A0DODO#RERE#MIO1SILALAbL96SO"
	EXECP2!
	IFK0=1THENM=43
	GOSUB7
	PLAY"L96P"

REM *** ***
194 RETURN

REM *** ***
195 PLAYM5$+M7$+M0$
	BOXF(90,58)-(117,109),0
	BOXF(120,56)-(151,111),2
	LINE(91,80)-(116,80),2
	LINE(91,81)-(116,81),2
	PRINTCHR$(27);CHR$(&H77);
	COLOR,0
	LOCATE12,8,0
	PRINTS$
	RETURN

REM *** ***
196 COLOR1,0
	LOCATE12,12,0
	PRINTN3$
	C(14)=0
	PLAYM7$+M5$
	CONSOLE20,24
	COLOR,4
	CLS
	PRINT"FELICITATIONS!"
	COLOR6
	PRINT"Votre mission est r�ussie.Gr�ce � vous"
	PRINT"la terre continuera de tourner!..."
	PLAYM4$+"T8L96P"
	M=116
	GOSUB7
	PLAY"T8L96P"
	RETURN

REM *** ***
197 CONSOLE0,24
	LOCATE29,0
	COLOR3,1
	PRINT"COMPLEMENTS"
	COLOR6,4
	FORI=1TO25STEP2
	LOCATE30,(I+3)/2
	PRINTN$(I);"   ";N$(I+1)
	NEXT
	LOCATE33,15
	PRINT"???";
	PLAY"T8L96PP"
	M=58
	GOSUB7
	R$=INPUT$(1)
	BOXF(232,0)-(319,135),-5
	CLS
	RETURN

REM *** ***
198 ONN1-1GOTO199,200,201,202,203

REM *** ***
199 EXECP3!
	RETURN

REM *** ***
200 EXECP4!
	RETURN

REM *** ***
201 EXECP5!
	RETURN

REM *** ***
202 EXECP6!
	RETURN

REM *** ***
203 EXECP7!
	RETURN

REM *** ***
204 IFM=16THENLOCATE0,23,0
	PRINTLEFT$(M$(M),43)
	PRINTRIGHT$(M$(M),14);
	RETURN

REM *** ***
205 IFM=45THENLOCATE0,23,0
	PRINTLEFT$(M$(M),40)
	PRINTRIGHT$(M$(M),15);
	RETURN

REM *** ***
206 IFM=67THENLOCATE0,23,0
	PRINTLEFT$(M$(M),44)
	PRINTRIGHT$(M$(M),39);
	RETURN

REM *** ***
207 IFM=75THENLOCATE0,23,0
	PRINTLEFT$(M$(M),41)
	PRINTRIGHT$(M$(M),19);
	RETURN

REM *** ***
208 COLOR1
	PLAYM6$+"T8L96P"
	CLS
	PRINT"Mot de passe?"
	A=0
	B=22
	F=4

REM *** ***
209 COLOR3
	GOSUB98
	IFE$=C0$THENPRINT
	COLOR6
	PRINTM$(6)
	PLAYM4$+"PPP"
	RETURN

REM *** ***
210 PLAY"O3T8L48DO"
	LOCATE0,22
	PRINTSPC(4)
	GOTO209

REM *** ***
211 PLAY"T8L96P"
	M=109
	GOSUB7
	PLAY"O3A0L24SOP"+"O2L36MIP"+"O1L48DOP"+"L72PP"
	M=110
	GOSUB7
	R$=""

REM *** ***
212 R$=INKEY$
	IFR$<>"O"ANDR$<>"N"THEN212
	ELSEIFR$="N"THENEND

REM *** ***
213 CONSOLE0,24
	CLS
	RUN

REM *** ***
214 CONSOLE0,24
	LOCATE30,0,0
	COLOR1
	PRINTCHR$(27);CHR$(&H7E);
	PRINT"INVENTAIRE"
	BOXF(240,8)-(319,135),-1
	COLOR,0
	IFC(1)=1THENPRINTCHR$(27);CHR$(&H70);
	LOCATE30,2
	PRINTR0$

REM *** ***
215 IFC(2)=1THENLOCATE34,2
	PRINTGR$(2)
	LOCATE34,3
	PRINTGR$(3)
	COLOR,0

REM *** ***
216 IFC(3)=1ANDD1=0THENLOCATE37,3
	PRINTGR$(2)
	LOCATE37,4
	PRINTGR$(3)
	COLOR,0

REM *** ***
217 IFC(4)=1THENCOLOR5
	LOCATE37,8
	PRINTGR$(6)+GR$(7)
	LOCATE37,9
	PRINTGR$(8)+GR$(9)

REM *** ***
218 IFC(6)=1THENCOLOR2
	LOCATE34,9
	PRINTGR$(13);GR$(26)

REM *** ***
219 IFC(7)=1THENPRINTCHR$(27);CHR$(114);
	LOCATE34,6
	PRINTF0$	REM *** Seringue ? ***

REM *** ***
220 IFC(8)=1THENCOLOR4
	LOCATE33,12
	PRINTO0$

REM *** ***
221 IFC(11)=1ANDD0=2THENCOLOR2
	LOCATE31,4
	PRINTB2$

REM *** ***
222 IFC(11)=1ANDD0=0THENCOLOR6
	LOCATE31,4
	PRINTB2$

REM *** ***
223 IFC(11)=1ANDD0=1THENPSET(31,4)GR$(4),6
	PSET(31,5)GR$(5),2
	BOXF(248,40)-(255,42),6

REM *** ***
224 IFC(13)=1THENCOLOR6
	LOCATE31,10
	PRINTGR$(20)

REM *** ***
225 IFC(14)=1THENCOLOR1
	LOCATE35,14
	PRINTN3$

REM *** ***
226 IFD(22)=1THENLOCATE30,8
	PRINTCHR$(27)+"B"+CHR$(27)+"P"+GR$(36)+CHR$(27)+"C"+GR$(37)+GR$(38)

REM *** ***
227 IFD(21)=1THENCOLOR7
	LOCATE37,11
	PRINTGR$(50);GR$(51)

REM *** ***
228 IFA=255THENPRINTCHR$(27);CHR$(&H77);
	LOCATE30,14
	PRINTS$

REM *** ***
229 M=58
	GOSUB7
	R$=INPUT$(1)
	IFA=255THEN231
	ELSEBOXF(240,0)-(319,135),-5
	CLS
	GOTO1

REM *** ***
230 BOXF(96,64)-(111,79),-1
	A=255
	GOTO214

REM *** ***
231 PLAYM8$
	M=17
	GOSUB7
	COLOR4
	END

REM *** ***
232 CLS
	COLOR1
	LOCATE0,20
	PRINT"SAUVEGARDE?(O/N)"
	R$=INPUT$(1)
	IFR$="O"THEN233
	ELSEGOTO1

REM *** ***
233 FORI=1TO23
	POKE40899+I+&H4000,C(I)
	POKE40919+I+&H4000,D(I)
	NEXT
	POKE40943+&H4000,P
	POKE40944+&H4000,D0
	POKE40945+&H4000,P9
	POKE40946+&H4000,N1
	POKE40947+&H4000,A0
	POKE40948+&H4000,N2
	POKE40949+&H4000,PB
	POKE40950+&H4000,H0
	POKE40951+&H4000,H1
	CLS
	LOCATE0,20
	PRINT"Mettez la cassette ou la disquette"
	PRINT"dans le lecteur";
	PLAY"T8L96PP"
	CLS
	PRINT"Appuyer sur les touches lecture et en-"
	PRINT"-registrement."
	PLAY"PP"
	CLS
	PRINT"Appuyer sur une touche du clavier."
	R$=INPUT$(1)
	SAVEM"SITUAT",40900+&H4000,40959+&H4000,40900+&H4000
	COLOR7
	CLS
	PRINT"OK.SAUVEGARDE";
	PLAY"L96PP"
	CLS
	GOTO1

REM *** ***
234 CLS
	PLAY"T8L36P"
	R$=INKEY$
	IFR$=""THENZ=RND
	LOCATE9,12,0
	PRINT"Appuyer sur une touche"
	PLAY"P"
	GOTO234

REM *** ***
235 CONSOLE0,18
	COLOR,4
	CLS
	COLOR0,7
	PRINT"11h57";
	LOCATE15,0,0
	PRINT"Agent WO5."
	LOCATE1,3
	PRINT"Vous �tes charg� par le CSSE.STOP.de"
	PRINT
	PRINT"neutraliser la machine infernale.STOP."
	LOCATE2,7
	PRINT"que le Professeur Antirot.STOP.exclu"
	LOCATE1,9
	PRINT"de la communaut� des savants sains"
	LOCATE3,11
	PRINT"d'esprit.STOP.a mise au point pour"
	LOCATE0,13
	PRINT"emp�cher la Terre de tourner.STOP."
	LOCATE2,15
	PRINT"D�p�chez-vous!et...Bonne chance.STOP."

REM *** ***
236 DATA 9,5,12,8,1,12,9,4,2,1,7,7,5,14,11,4,9,4,1,12,8,3,6,0,10,9,12,10,3,12,9,12,11,6,2,10,8,3,7,14,10,9,13,14,3,5,4,10,10,2,10,3,5,13,5,14,3,5,7,5,4,2,0,2,PRE,EXA,PRO,LIR,OUV,BOI,ACT,BOU,UTI,CRO,LAN,FOU,CHA,TRA,POS,SOU,FRO,OBJ,BOU,FLA,LIV,REV,BOI,POR,COF,FOR,MAN,TRO,VAS,MUR,CER,SOU,MAS,SER,FLU,COU,FIO,CLE,MES,TAP,CAR,CIT,PAG,NEU

REM *** ***
237 M$(100)="Vous d�couvrez un petit carnet"
	M$(101)="Il y a pas mal de poussiere"
	M$(102)="C'est un tapis tr�s persan"
	M$(103)="Ne frottez pas trop fort!"
	M$(104)="Regardez bien!"
	M$(105)="Toutes les pages sont blanches"
	M$(106)="Vous lisez VITE"
	M$(107)="Le citron se r�v�le sympa..."
	M$(108)="Que voulez-vous lire?"
	M$(109)="Votre mission s'arr�te ici!..."
	M$(110)="Voulez-vous repartir?(O/N)!"
	M$(111)="Sur la plaque:	Ici repose WO4..."
	M$(112)="Sur la plaque:	Votre place est r�serv�e"
	M$(113)="Verbe inexistant"
	M$(114)="Compl�ment inexistant"
	M$(115)="La nitro ouvre une br�che"
	M$(116)="Vous pouvez prendre la bourse!.."
	M$(117)="Ne touchez � rien!!"
	M$(1)="Je ne comprends pas"
	M$(2)="Exprimez-vous plus clairement!"
	M$(3)="Pardon?"
	M$(4)="Il est fix� au sol"
	M$(5)="Les pages sont coll�es"
	M$(6)="D'accord"
	M$(7)="Comme vous voulez"
	M$(8)="Voila qui est fait"
	M$(9)="Et maintenant?"
	M$(10)="Elle est ouverte"
	M$(11)="Il n'y a rien � prendre ici!"
	M$(12)="Vous voulez rire!"
	M$(13)="Avec quoi?"
	M$(14)="Gloub;gloub;gloub..."
	M$(15)="Tiens!O� �tes-vous pass�?"
	M$(16)="L'�tiquette est effac�e.On ne voit que:	....o..y....n."
	M$(17)="Bien jou�!"
	M$(18)="Impossible!"
	M$(19)="Je ne vois vraiment rien!"
	M$(20)="Tiens!Un passage secret"
	M$(21)="Vous chopez une bonne grippe!"
	M$(22)="Il est d�ja ouvert"
	M$(23)="Il n'y a rien de sp�cial"
	M$(24)="On dirait du champagne"
	M$(25)="La fiole est vide"
	M$(26)="Quel cercueil?"
	M$(27)="Le r�volver n'est pas charg�"
	M$(28)="Attention aux ricochets!"
	M$(29)="C'est trop tard!Tout va sauter!!"
	M$(30)="Ce sont des cartouches"
	M$(31)="C'est du mastic �tanche"
	M$(32)="Amusez-vous bien!"
	M$(33)="La porte est verrouill�e"
	M$(34)="Un puissant s�choir se met en marche"
	M$(35)="Le gardien vous a vu le premier,h�las!"
	M$(36)="Vous avez �limin� le gardien"
	M$(37)="Comment avancer?"
	M$(38)="Il y a un souterrain tout noir"
	M$(39)="C'est trop tard!..."
	M$(40)="Et comment?"
	M$(41)="La serrure est blind�e"
	M$(42)="Du bruit � cot�"
	M$(43)="Bienvenu!Je vous ai gard� une place..."
	M$(44)="La porte est bloqu�e"
	M$(45)="Une cellule photo-�lectrique actionne un laser mortel"
	M$(46)="Vous continuez sans l'objet"
	M$(47)="C'�tait de l'acide fluorhydrique!"
	M$(48)="C'est d�ja fait"
	M$(49)="Un serpent � lunettes ne vous rate pas"
	M$(50)="2546 volts vous foudroient"
	M$(51)="Vous ne l'avez pas"
	M$(52)="Vous allez vous cogner!"
	M$(53)="La porte est encore ferm�e"
	M$(54)="La serrure a saut�"
	M$(55)="Voici le coffre!!!"
	M$(56)="Tiens!Une cl�"
	M$(57)="Prendre quoi?"
	M$(58)="Appuyer une touche"
	M$(59)="C'est un vase d'�poque Ming"
	M$(60)="Bizarre,vraiment bizarre"
	M$(61)="Il faut d'abord trouver son nom"
	M$(62)="Quelle cl�?"
	M$(63)="Le coffre est ferm�"
	M$(64)="Vous l'avez bien m�rit�e!"
	M$(65)="Vous croyez aux sermons,vous?"
	M$(66)="Attention!il est charg�"
	M$(67)="La bouteille d'acide fluorhydrique s'est ouverte et vous �touffez"
	M$(68)="Vous l'avez d�ja!"
	M$(69)="C'est une Bible reli�e"
	M$(70)="Vous �tes bien m�fiant tout � coup!"
	M$(71)="C'est une fl�te indienne"
	M$(72)="Quel coffre?"
	M$(73)="C'est un vrai coffre-fort"
	M$(74)="Vous dites n'importe quoi!"
	M$(75)="Vous �tes terrass� par les vapeurs d'acide fluorhydrique"
	M$(76)="Quelle porte?"
	M$(77)="Avez vous le mot de passe?"
	M$(78)="La serrure est cod�e"
	M$(79)="Que voulez-vous boire?"
	M$(80)="L�,vous d�tonnez!"
	M$(81)="L'eau s'arr�te de monter"
	M$(82)="Vous vous suicidez d�ja?"
	M$(83)="Pour quoi faire?"
	M$(84)="Vraiment,vous croyez?"
	M$(85)="Vous ne l'avez plus"
	M$(86)="Quel vase?"
	M$(87)="Sacr� fouilleur va!"
	M$(88)="O� ��?"
	M$(89)="Vous transformer en souris?!"
	M$(90)="Voici la cl� du codage"
	M$(91)="Quel message?"
	M$(92)="Voici une indication"
	M$(93)="Le gardien ne vous voit pas"
	M$(94)="La machine infernale se met en marche.."
	M$(95)="C'est une cl� de coffre-fort"
	M$(96)="Que voulez-vous examiner?"
	M$(97)="Vous vous prenez pour Fantomas?!"
	M$(98)="Heureux qui comme ALI BABA..."
	M$(99)="Vous d�couvrez une petite boite"
	FORI=0TO31
	READA,B
	POKE40868+I+&H4000,16*A+B
	NEXTI
	FORI=1TO17
	READV$(I)	REM *** Chargement des Verbes dans V$ ***
	NEXTI
	FORI=1TO27
	READN$(I)	REM *** Chargement des Compl�ments dans N$ ***
	NEXTI
	
	REM *** Objets ***
	DEFGR$(0)=0,127,63,15,0,0,0,0
	DEFGR$(1)=2,254,254,254,47,15,15,31
	DEFGR$(2)=60,60,24,24,24,60,126,255
	DEFGR$(3)=255,7,7,7,7,255,255,255
	DEFGR$(4)=0,60,24,24,24,24,60,126
	DEFGR$(5)=255,255,255,255,255,126,60,24
	DEFGR$(6)=8,7,3,1,0,1,7,15
	DEFGR$(7)=28,240,224,192,128,192,224,248
	
	REM *** ? Mise en page ***
	DEFGR$(8)=31,63,127,127,127,63,31,15
	
	DEFGR$(9)=252,252,254,254,254,252,248,240
	
	REM *** ? Mise en page ***
	DEFGR$(10)=7,7,7,12,24,48,96,192
	DEFGR$(11)=224,224,224,48,24,12,6,3
	
	DEFGR$(12)=255,254,252,248,240,224,192,128
	DEFGR$(13)=63,47,55,56,59,59,27,11
	DEFGR$(14)=0,0,0,63,21,15,7,3
	DEFGR$(15)=0,0,0,254,84,248,240,224
	DEFGR$(16)=2,3,7,15,26,53,42,63
	DEFGR$(17)=160,224,240,248,172,86,170,254
	DEFGR$(18)=63,63,42,63,21,15,7,31
	DEFGR$(19)=254,254,170,254,84,248,240,252
	DEFGR$(20)=0,0,3,253,195,0,0,0
	DEFGR$(21)=0,64,48,31,13,31,48,64	REM *** Seringue 1/3 ? ***
	DEFGR$(22)=0,0,0,255,85,255,0,0		REM *** Seringue 2/3 ? ***
	DEFGR$(23)=0,0,0,240,124,240,0,0	REM *** Seringue 3/3 ? ***
	DEFGR$(24)=0,56,8,15,25,63,79,2
	DEFGR$(25)=0,28,16,240,152,252,242,64
	DEFGR$(26)=224,240,248,4,252,252,252,252
	DEFGR$(27)=0,225,97,19,29,153,113,127
	DEFGR$(28)=0,135,142,200,184,153,142,254
	DEFGR$(29)=131,136,144,145,145,144,136,131
	DEFGR$(30)=192,32,16,144,144,16,32,192
	DEFGR$(31)=28,226,1,28,34,193,0,0
	DEFGR$(32)=0,24,60,126,126,60,24,0
	DEFGR$(33)=0,0,56,124,254,254,0,0
	DEFGR$(34)=0,126,126,0,0,126,126,0
	DEFGR$(35)=0,102,102,0,0,102,102,0
	DEFGR$(36)=0,4,6,3,6,0,0,0
	DEFGR$(37)=62,127,255,255,255,127,62,0
	DEFGR$(38)=0,0,192,224,192,128,0,0
	N0$=CHR$(8)										REM *** Graphisme : ? ***
	N$=N0$+N0$+CHR$(10)								REM *** Graphisme : ? ***
	R0$=GR$(0)+GR$(1)								REM *** Graphisme : Revolver ? ***
	F0$=GR$(21)+GR$(22)+GR$(23)						REM *** Graphisme : Seringue ? ***
	O0$=GR$(24)+GR$(25)								REM *** Graphisme : Extra-Terrestre ***
	K$=CHR$(127)									REM *** Graphisme : Carr� plein ***
	M1$(0)=GR$(11)+" "								REM *** Graphisme : fl�che vers haut gauche ***
	M1$(1)=" "+GR$(10)								REM *** Graphisme : fl�che vers haut droite ***
	E$=CHR$(27)										REM *** Graphisme : vide ***
	B0$=E$+"C"+GR$(2)+N0$+CHR$(10)+E$+"y"+GR$(3)	REM *** Graphisme : Fiole ou Bouteille Jaune ? ***
	S$=GR$(6)+GR$(7)+N$+GR$(8)+GR$(9)				REM *** Graphisme : Mastic ***
	V0$=E$+"R"+GR$(14)+GR$(15)+N$+GR$(16)+GR$(17)	REM *** Graphisme : Coupe yoyo Vase ? ***
	V1$=E$+"x"+GR$(18)+GR$(19)						REM *** Graphisme : Bol Coupe ? ***
	N3$=GR$(27)+GR$(28)								REM *** Graphisme : Couronne ? ***
	B1$=E$+"q"+GR$(2)+N0$+CHR$(10)+E$+"V"+GR$(3)	REM *** Graphisme : Fiole ou Bouteille ? ***
	B2$=GR$(4)+N0$+CHR$(10)+GR$(5)					REM *** Graphisme : Vase ***
	
	REM *** Musiques ***
	M8$="T6A0L24O4DODOREMIDOSODOL48LAL24LALASIO5DODOO4SILAL48SODOL24DODOREL48MISOL24DODOREL48MISOL24DODOREL48MISOL24DODOMIL48SOL24SOMIL48DOREL96DO"
	M4$="A0O4T5L48DOL24DO#L48SIL24LA#L48LAL24FA#FAMIREL48DOL96DO"
	M7$="A85O1T2L2DOREPSODOPPREPPSOREFAO5SIDOFAPO2DORELAMILAO1L1DORESOFAO3DOPLAO5SISOA0"
	M6$="A5L2O4T4DOSILASOO3RESOFA#O4L4SIDOREL6DOSILASOL2O3SOFA#FAMIMIREL4O2DO"
	M5$="A4T1L1O2DOPREPMIPPO5SIPSIPSIPPP"
	M0$="A4T2L2O5SIPSIPSIPSIPP"
	
	REM *** Indices ***
	C1$="ABRACADABRA"
	C0$="VITE"
	
	REM *** Objets ***
	DEFGR$(39)=255,254,252,248,240,224,192,128
	DEFGR$(40)=255,127,63,31,15,7,3,1
	DEFGR$(41)=0,0,102,0,102,0,86,0
	
	DEFGR$(42)=0,0,0,0,3,15,63,255					REM *** Graphisme : pente descente ? ***
	DEFGR$(43)=3,15,63,255,255,255,255,255
	DEFGR$(44)=192,240,252,255,255,255,255,255		REM *** Graphisme : pente mont�e ? ***
	DEFGR$(45)=0,0,0,0,192,240,252,255
	
	DEFGR$(46)=0,0,90,0,106,0,90,0
	DEFGR$(47)=0,0,60,126,126,62,0,0
	DEFGR$(50)=255,191,95,47,23,11,4,3
	DEFGR$(51)=192,224,240,248,252,254,0,254
	
	T1$=GR$(42)+GR$(43)								REM *** Graphisme : pente descente ? ***
	T0$=GR$(44)+GR$(45)								REM *** Graphisme : pente mont�e ? ***
	
	DEFGR$(54)=127,15,0,0,0,0,0,0
	DEFGR$(55)=255,255,255,15,0,0,0,0
	DEFGR$(56)=255,255,255,255,255,15,0,0
	DEFGR$(57)=255,255,255,255,255,224,0,0
	DEFGR$(58)=255,255,255,240,0,0,0,0
	DEFGR$(59)=254,240,0,0,0,0,0,0
	
	REM *** Graphismes : Chiffres 0-9 ***
	DEFGR$(60)=0,60,66,66,66,66,66,0
	DEFGR$(61)=66,66,66,66,66,60,0,0
	DEFGR$(62)=2,2,2,2,66,60,0,0
	DEFGR$(63)=0,60,64,64,64,64,64,60
	DEFGR$(64)=0,60,66,66,66,66,66,60
	DEFGR$(65)=0,60,66,2,2,2,2,60
	DEFGR$(66)=2,2,2,2,2,2,0,0
	DEFGR$(67)=0,60,66,2,2,2,2,0
	DEFGR$(68)=0,8,8,8,8,8,8,0
	DEFGR$(69)=8,8,8,8,8,8,0,0
	DEFGR$(70)=0,64,64,64,64,66,66,60
	DEFGR$(71)=64,64,64,64,64,60,0,0
	Q$(0)=GR$(61)+N0$+CHR$(11)+GR$(60)+CHR$(10)
	Q$(1)=GR$(69)+N0$+CHR$(11)+GR$(68)+CHR$(10)
	Q$(2)=GR$(71)+N0$+CHR$(11)+GR$(65)+CHR$(10)
	Q$(3)=GR$(62)+N0$+CHR$(11)+GR$(65)+CHR$(10)
	Q$(4)=GR$(66)+N0$+CHR$(11)+GR$(70)+CHR$(10)
	Q$(5)=GR$(62)+N0$+CHR$(11)+GR$(63)+CHR$(10)
	Q$(6)=GR$(61)+N0$+CHR$(11)+GR$(63)+CHR$(10)
	Q$(7)=GR$(66)+N0$+CHR$(11)+GR$(67)+CHR$(10)
	Q$(8)=GR$(61)+N0$+CHR$(11)+GR$(64)+CHR$(10)
	Q$(9)=GR$(62)+N0$+CHR$(11)+GR$(64)+CHR$(10)
	
	DEFGR$(72)=8,10,28,93,127,63,62,28
	DEFGR$(73)=255,85,255,90,60,60,24,60
	DEFGR$(74)=0,0,0,0,0,0,7,31
	DEFGR$(75)=0,0,0,0,0,0,224,240
	DEFGR$(76)=63,60,60,23,25,13,5,1
	DEFGR$(77)=200,204,252,156,152,104,136,127
	DEFGR$(78)=1,3,2,14,26,101,201,178
	DEFGR$(79)=0,0,192,96,24,7,65,96
	DEFGR$(80)=0,0,0,0,1,6,220,96
	DEFGR$(81)=7,7,29,113,193,0,0,0
	DEFGR$(82)=196,249,122,188,79,151,37,202
	DEFGR$(83)=176,52,84,140,40,212,45,127
	DEFGR$(84)=0,0,0,0,56,60,246,227
	DEFGR$(85)=0,0,0,0,3,14,56,240
	DEFGR$(86)=3,14,56,224,128,0,0,0
	DEFGR$(87)=208,56,14,3,0,0,0,0
	DEFGR$(88)=0,0,0,0,192,112,28,7
	DEFGR$(89)=31,13,49,230,0,0,0,0
	CONSOLE0,24
	COLOR1,0
	LOCATE3,22
	PRINT"Avez-vous sauvegard� la situation"
	LOCATE12,23
	PRINT"pr�c�dente?(O/N)"
	R$=INPUT$(1)
	IFR$="N"THEN239

REM *** Chargement d'une sauvegarde ***
238 CLS
	LOCATE0,8,0
	PRINT"Mettez la cassette ou la disquette dans ";
	PRINT"le lecteur."
	PRINT
	PRINT"Appuyez sur une touche quelconque du    clavier"
	R$=INPUT$(1)
	LOADM"SITUAT"
	FORI=1TO23
	C(I)=PEEK(40899+I+&H4000)
	D(I)=PEEK(40919+I+&H4000)
	NEXT
	P=PEEK(40943+&H4000)
	D0=PEEK(40944+&H4000)
	P9=PEEK(40945+&H4000)
	N1=PEEK(40946+&H4000)
	A0=PEEK(40947+&H4000)
	N2=PEEK(40948+&H4000)
	PB=PEEK(40949+&H4000)
	H0=PEEK(40950+&H4000)
	H1=PEEK(40951+&H4000)
	GOTO240

REM *** D�but du jeu ***
239 CLS
	P=44	REM *** Pi�ce 44 ***
	D0=2
	PB=3
	P9=1
	N1=1
	H0=-1
	H1=2

REM *** ***
240 FORI=0TO43
	POKE40824+I+&H4000,INT(256*RND)
	NEXT
	G(0)=2
	G(1)=9
	G(2)=5
	G(3)=6
	H0=-1
	H1=2
	LOCATE0,0,0
	SCREEN4,4,0
	FORI=0TO23
	LINE(0,I)-(2.7*I,I)
	LINE(231-2.7*I,I)-(231,I)
	NEXT
	RETURN

REM *** ***
241 IFC<8THENCOLOR,C
	RETURN
	ELSEPRINTCHR$(27);CHR$(&H70+C);
	RETURN

REM *** ***
242 IFC<8THENCOLORC
	RETURN
	ELSEPRINTCHR$(27);CHR$(&H68+C);
	RETURN