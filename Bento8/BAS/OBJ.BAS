10 CLEAR,,90
20 DEFGR$(0)=0,127,63,15,0,0,0,0
30 DEFGR$(1)=2,254,254,254,47,15,15,31
40 DEFGR$(2)=60,60,24,24,24,60,126,255
50 DEFGR$(3)=255,7,7,7,7,255,255,255
60 DEFGR$(4)=0,60,24,24,24,24,60,126
70 DEFGR$(5)=255,255,255,255,255,126,60,24
80 DEFGR$(6)=8,7,3,1,0,1,7,15
90 DEFGR$(7)=28,240,224,192,128,192,224,248
100 DEFGR$(8)=31,63,127,127,127,63,31,15
110 DEFGR$(9)=252,252,254,254,254,252,248,240
120 DEFGR$(10)=7,7,7,12,24,48,96,192
130 DEFGR$(11)=224,224,224,48,24,12,6,3
140 DEFGR$(12)=255,254,252,248,240,224,192,128
150 DEFGR$(13)=63,47,55,56,59,59,27,11
160 DEFGR$(14)=0,0,0,63,21,15,7,3
170 DEFGR$(15)=0,0,0,254,84,248,240,224
180 DEFGR$(16)=2,3,7,15,26,53,42,63
190 DEFGR$(17)=160,224,240,248,172,86,170,254
200 DEFGR$(18)=63,63,42,63,21,15,7,31
210 DEFGR$(19)=254,254,170,254,84,248,240,252
220 DEFGR$(20)=0,0,3,253,195,0,0,0
230 DEFGR$(21)=0,64,48,31,13,31,48,64
240 DEFGR$(22)=0,0,0,255,85,255,0,0
250 DEFGR$(23)=0,0,0,240,124,240,0,0
260 DEFGR$(24)=0,56,8,15,25,63,79,2
270 DEFGR$(25)=0,28,16,240,152,252,242,64
280 DEFGR$(26)=224,240,248,4,252,252,252,252
290 DEFGR$(27)=0,225,97,19,29,153,113,127
300 DEFGR$(28)=0,135,142,200,184,153,142,254
310 DEFGR$(29)=131,136,144,145,145,144,136,131
320 DEFGR$(30)=192,32,16,144,144,16,32,192
330 DEFGR$(31)=28,226,1,28,34,193,0,0
340 DEFGR$(32)=0,24,60,126,126,60,24,0
350 DEFGR$(33)=0,0,56,124,254,254,0,0
360 DEFGR$(34)=0,126,126,0,0,126,126,0
370 DEFGR$(35)=0,102,102,0,0,102,102,0
380 DEFGR$(36)=0,4,6,3,6,0,0,0
390 DEFGR$(37)=62,127,255,255,255,127,62,0
400 DEFGR$(38)=0,0,192,224,192,128,0,0
410 N0$=CHR$(8)
420 N$=N0$+N0$+CHR$(10)
430 R0$=GR$(0)+GR$(1)
440 F0$=GR$(21)+GR$(22)+GR$(23)
450 O0$=GR$(24)+GR$(25)
460 K$=CHR$(127)
470 M1$(0)=GR$(11)+" "
480 M1$(1)=" "+GR$(10)
490 E$=CHR$(27)
500 B0$=E$+"C"+GR$(2)+N0$+CHR$(10)+E$+"y"+GR$(3)
510 S$=GR$(6)+GR$(7)+N$+GR$(8)+GR$(9)
520 V0$=E$+"R"+GR$(14)+GR$(15)+N$+GR$(16)+GR$(17)
530 V1$=E$+"x"+GR$(18)+GR$(19)
540 N3$=GR$(27)+GR$(28)
550 B1$=E$+"q"+GR$(2)+N0$+CHR$(10)+E$+"V"+GR$(3)
560 B2$=GR$(4)+N0$+CHR$(10)+GR$(5)
570 DEFGR$(39)=255,254,252,248,240,224,192,128
580 DEFGR$(40)=255,127,63,31,15,7,3,1
590 DEFGR$(41)=0,0,102,0,102,0,86,0
600 DEFGR$(42)=0,0,0,0,3,15,63,255
610 DEFGR$(43)=3,15,63,255,255,255,255,255
620 DEFGR$(44)=192,240,252,255,255,255,255,255
630 DEFGR$(45)=0,0,0,0,192,240,252,255
640 DEFGR$(46)=0,0,90,0,106,0,90,0
650 DEFGR$(47)=0,0,60,126,126,62,0,0
660 DEFGR$(50)=255,191,95,47,23,11,4,3
670 DEFGR$(51)=192,224,240,248,252,254,0,254
680 T1$=GR$(42)+GR$(43)
690 T0$=GR$(44)+GR$(45)
700 DEFGR$(54)=127,15,0,0,0,0,0,0
710 DEFGR$(55)=255,255,255,15,0,0,0,0
720 DEFGR$(56)=255,255,255,255,255,15,0,0
730 DEFGR$(57)=255,255,255,255,255,224,0,0
740 DEFGR$(58)=255,255,255,240,0,0,0,0
750 DEFGR$(59)=254,240,0,0,0,0,0,0
760 DEFGR$(60)=0,60,66,66,66,66,66,0
770 DEFGR$(61)=66,66,66,66,66,60,0,0
780 DEFGR$(62)=2,2,2,2,66,60,0,0
790 DEFGR$(63)=0,60,64,64,64,64,64,60
800 DEFGR$(64)=0,60,66,66,66,66,66,60
810 DEFGR$(65)=0,60,66,2,2,2,2,60
820 DEFGR$(66)=2,2,2,2,2,2,0,0
830 DEFGR$(67)=0,60,66,2,2,2,2,0
840 DEFGR$(68)=0,8,8,8,8,8,8,0
850 DEFGR$(69)=8,8,8,8,8,8,0,0
860 DEFGR$(70)=0,64,64,64,64,66,66,60
870 DEFGR$(71)=64,64,64,64,64,60,0,0
880 Q$(0)=GR$(61)+N0$+CHR$(11)+GR$(60)+CHR$(10)
890 Q$(1)=GR$(69)+N0$+CHR$(11)+GR$(68)+CHR$(10)
900 Q$(2)=GR$(71)+N0$+CHR$(11)+GR$(65)+CHR$(10)
910 Q$(3)=GR$(62)+N0$+CHR$(11)+GR$(65)+CHR$(10)
920 Q$(4)=GR$(66)+N0$+CHR$(11)+GR$(70)+CHR$(10)
930 Q$(5)=GR$(62)+N0$+CHR$(11)+GR$(63)+CHR$(10)
940 Q$(6)=GR$(61)+N0$+CHR$(11)+GR$(63)+CHR$(10)
950 Q$(7)=GR$(66)+N0$+CHR$(11)+GR$(67)+CHR$(10)
960 Q$(8)=GR$(61)+N0$+CHR$(11)+GR$(64)+CHR$(10)
970 Q$(9)=GR$(62)+N0$+CHR$(11)+GR$(64)+CHR$(10)
980 DEFGR$(72)=8,10,28,93,127,63,62,28
990 DEFGR$(73)=255,85,255,90,60,60,24,60
1000 DEFGR$(74)=0,0,0,0,0,0,7,31
1010 DEFGR$(75)=0,0,0,0,0,0,224,240
1020 DEFGR$(76)=63,60,60,23,25,13,5,1
1030 DEFGR$(77)=200,204,252,156,152,104,136,127
1040 DEFGR$(78)=1,3,2,14,26,101,201,178
1050 DEFGR$(79)=0,0,192,96,24,7,65,96
1060 DEFGR$(80)=0,0,0,0,1,6,220,96
1070 DEFGR$(81)=7,7,29,113,193,0,0,0
1080 DEFGR$(82)=196,249,122,188,79,151,37,202
1090 DEFGR$(83)=176,52,84,140,40,212,45,127
1100 DEFGR$(84)=0,0,0,0,56,60,246,227
1110 DEFGR$(85)=0,0,0,0,3,14,56,240
1120 DEFGR$(86)=3,14,56,224,128,0,0,0
1130 DEFGR$(87)=208,56,14,3,0,0,0,0
1140 DEFGR$(88)=0,0,0,0,192,112,28,7
1150 DEFGR$(89)=31,13,49,230,0,0,0,0
1152 PRINT N0$:PRINT "   "
1153 PRINT N$:PRINT "   "
1154 PRINT R0$:PRINT "   "
1155 PRINT F0$:PRINT "   "
1156 PRINT O0$:PRINT "   "
1157 PRINT K$:PRINT "   "
1158 PRINT M1$(0):PRINT "   "
1159 PRINT M1$(1):PRINT "   "
1160 PRINT E$:PRINT "   "
1161 PRINT B0$:PRINT "   "
1162 PRINT S$:PRINT "   "
1163 PRINT V0$:PRINT "   "
1164 PRINT V1$:PRINT "   "
1165 PRINT N3$:PRINT "   "
1166 PRINT B1$:PRINT "   "
1167 PRINT B2$:PRINT "   "
1169 PRINT T0$:PRINT "   "
1170 PRINT T1$:PRINT "   "
1172 FOR I=0 TO 9
1173 PRINT Q$(I):PRINT "   "
1190 NEXT I
