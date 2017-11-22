From: "Jim Carroll" <jim@...2322...>
References: <00bb01d363a1$2428e260$6c7aa720$@carroll.com>
 <20171122164212.GD631@...1296...>
In-Reply-To: <20171122164212.GD631@...1296...>
Date: Wed, 22 Nov 2017 13:53:50 -0500
Message-ID: <016a01d363c3$3cc3bdf0$b64b39d0$@carroll.com>
Content-Language: en-us
Subject: Re: [Openvpn-devel] OpenVPN + OpenSSL FIPS Object Module v2.0
 causes OpenVPN to SIGSEGV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 'Gert Doering' <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Gert,

You're tip lead me to the "secret" switch that allows MD5 in FIPS mode. And
your completely right -- MD5 for non-HASH is a legal use in FIPS mode.  I
can't thank you enough.

Question -- We'd like to submit a patch. Is the correct procedure still to
submit patches via email as described
https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Dailydevel
opment. Or is appropriate for us to just fork on github and push patches
there?

Conceptually, I believe supporting FIPS in OpenVPN will require four broad
changes:

	1) A change to configure.ac to help build process find 
		OpenSSL FIPS Object Module
	2) A new option to OpenVPN, eg: --fips-mode
	3) Code change to enable FIPS & Allow MD5 for PRF
	4) Build process documentation to build, eg: where to 
		get OpenSSL pieces and how to build

Do we need to run this by anyone, or do we just start patching?


> -----Original Message-----
> From: Gert Doering [mailto:gert@...1296...]
> Sent: Wednesday, November 22, 2017 11:42 AM
> To: Jim Carroll
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] OpenVPN + OpenSSL FIPS Object Module v2.0
> causes OpenVPN to SIGSEGV
> 
> Hi,
> 
> On Wed, Nov 22, 2017 at 09:49:47AM -0500, Jim Carroll wrote:
> > I'm not sure how to resolve this issue. tls1_PRF() is building data
> channel
> > keys exchanged between the client and server. It would appear to me
> that MD5
> > is "baked into" the OpenVPN key negotiation in away that cannot be
> simply
> > omitted/skip/replaced, without a coordinated code change to all
> downstream
> > client code as well (including IOS). Is that correct?
> 
> This is correct.  MD5 for the PRF is essential for the wire protocol,
> and changing this will be incompatible with all unchanged clients.
> 
> OTOH, MD5 is perfectly fine in FIPS code *iff* it's not used as a hash
> but for other purposes.  I seem to remember that there is a magic call
> you need to do to tell the FIPS side of things "hey, this invocation of
> MD5 is good".
> 
> We had the discussion on the openvpn-devel list some time ago (two
> years
> maybe?) so google might find something more authoritative here.
> 
> gert
> --
> now what should I write here...
> 
> Gert Doering - Munich, Germany
> gert@...1296...


begin 666 smime.p7s
M,( &"2J&2(;W#0$'`J" ,( "`0$Q"S )!@4K#@,"&@4`,( &"2J&2(;W#0$'
M`0``H((.$3""!#8P@@,>H ,"`0("`0$P#08)*H9(AO<-`0$%!0`P;S$+, D&
M`U4$!A,"4T4Q%# 2!@-5! H3"T%D9%1R=7-T($%",28P) 8#500+$QU!9&14
M<G5S="!%>'1E<FYA;"!45% @3F5T=V]R:S$B," &`U4$`Q,9061D5')U<W0@
M17AT97)N86P@...2323...$@4F]O=# >%PTP,# U,S Q,#0X,SA:%PTR,# U,S Q,#0X
M,SA:,&\Q"S )!@-5! 83`E-%,10P$@8#500*$PM!9&14<G5S="!!0C$F,"0&
M`U4$"Q,=061D5')U<W0@...2324...)N86P@...1481...%10($YE='=O<FLQ(C @!@-5! ,3
M&4%D9%1R=7-T($5X=&5R;F%L($-!(%)O;W0P@@$B, T&"2J&2(;W#0$!`04`
M`X(!#P`P@@$*`H(!`0"W]QHSYO(`!"TYX$Y;[1^\; _-M?HCML[>FQ$SEZ0I
M3'V3G[U*O)/M`QKCC\_E;5!:UI<IE%J L$EZVRZ5_;C*OS<X+1X^D4&M<%;'
M\$\_Z#*>=,K(D%3IQE\/>)V:0#P.K&&J7A2/GH>A:E#<UYI.KP6SIG&4G'&S
M4& *QQ.=. >&`JCIJ&DF&)"K3+!/(ZLZ3X38W\Z?X6EON]="UVM$Y,>M[FU!
M7W):<0@...2325...%F@...1652...#?W`"\-PI)RVM X<ML4J$7$72I]M[36Q.ZLS1-$M\DK
MW4,`)?IAN6EJ6",1MZ<SCU9U6?7-*==&MPHK9;;30F\5LKA[^^_I75/5-%HG
M`@,!``&C@=PP@=DP'08#51T.!!8$%*V]F'HTM";W^L0F5.\#O> DRU0:, L&
M`U4=#P0$`P(!!C /!@-5'1,!`?\$!3 #`0'_,(&9!@-5'2,$@9$P@...2326... %*V]
MF'HTM";W^L0F5.\#O> DRU0:H7.D<3!O,0LP"08#500&$P)313$4,!(&`U4$
M"A,+061D5')U<W0@...2327...(Q)C D!@-5! L3'4%D9%1R=7-T($5X=&5R;F%L(%14
M4"!.971W;W)K,2(P( 8#500#$QE!9&14<G5S="!%>'1E<FYA;"!#02!2;V]T
M@@$!, T&"2J&2(;W#0$!!04``X(!`0"PF^"%)<+6(^(/E@:2G4&8G-F$>8'9
M'EL4!R,V98^PV'>[K$%L1V"#4;#Y,CWG_/8F$\> %J6_6OR'SWAYB2&:XDP'
M"H8UO/+>4<32EK?<?D[N</T<.>L,`E$4+8Z]%N#!WT9UYR2M[/1"M(63<!!G
MNIT&-4H8TRMZS%%"H7ICT>:[H<4KPC:^$PWFO6-^>7NG"0U JVK=CXK#]O:,
M&D(%4=1%]9^G8B%H%2!#/)GG?+TDV*F1%W.(/U8;,3@...2328...'$/FLW(#IZ.+AOA
MC)B#RQ\Q\41,Q@...2329...@#\?XO1> :R[IS$P.6IIY#R *+M6>8R8>59*4V((7
M6GO0O,>/3H8$,(($KS""`Y>@`P(!`@(1`. CRQ42@...2330...)K6%N>E1G:R$P#08)
M*H9(AO<-`0$+!0`P;S$+, D&`U4$!A,"4T4Q%# 2!@-5! H3"T%D9%1R=7-T
M($%",28P) 8#500+$QU!9&14<G5S="!%>'1E<FYA;"!45% @3F5T=V]R:S$B
M," &`U4$`Q,9061D5')U<W0@...2324...)N86P@...2323...$@4F]O=# >%PTQ-#$R,C(P
M,# P,#!:%PTR,# U,S Q,#0X,SA:,(&;,0LP"08#500&$P)'0C$;,!D&`U4$
M"!,21W)E871E<B!-86YC:&5S=&5R,1 P#@8#500'$P=386QF;W)D,1HP& 8#
M500*$Q%#3TU/1$\@0T$@3&EM:71E9#%!,#\&`U4$`Q,X0T]-3T1/(%-(02TR
M-38@...2331...($%U=&AE;G1I8V%T:6]N(&%N9"!396-U<F4@...2332...:6P@...2323...$P
M@@$B, T&"2J&2(;W#0$!`04``X(!#P`P@@$*`H(!`0")L0W:>E,93G!2';Q6
MI@...2333...[A)X);G4:OQ\%H3216CM(P;8+QZ44*G>8RD(M\784Z1U78C"A332@)_
MMAT)@&ZE!#W9NKL6_J&'J2Y#4D,6?*\R4,BF3UKI"-C/DR6<>XCH,&3FI/A6
M@/TJ)!0S%YFL1.5IBZ-&!DO",]3I0)\&L+&LDT"YM0B3.IPJ4Z,0VST@...2334...
M`X[93G8E`B$I^J-\<79/[N%?@>G[5(#;PWLU4K>$WB(]+# M,7]9O5(WL#-I
M+4/K^M:E\9=W9U&,V>XGZ[RE!SAVC*2I./_?C/4#K$F^RO=SF3H/,JN<E3H3
M/0Y&.E=T85"^QD _R^3BGZ(A`@,!``&C@@$7,((!$S ?!@-5'2,$&# 6@!2M
MO9AZ-+0F]_K$)E3O`[W@),M4&C =!@-5'0X$%@04DF%K@...1630...&BH*I/[&?QPJ/W
MM( `P>PP#@8#51T/`0'_! 0#`@&&,!(&`U4=$P$!_P0(, 8!`?\"`0`P'08#
M51TE!!8P% 8(*P8!!04'`P(&""L&`04%!P,$,!$&`U4=( 0*, @P!@8$51T@
M`#!$!@-5'1\$/3 [,#F@...2335... UAC-H='1P.B\O8W)L+G5S97)T<G5S="YC;VTO
M061D5')U<W1%>'1E<FYA;$-!4F]O="YC<FPP-08(*P8!!04'`0$$*3 G,"4&
M""L&`04%!S !AAEH='1P.B\O;V-S<"YU<V5R=')U<W0N8V]M, T&"2J&2(;W
M#0$!"P4``X(!`0`;*FZL5<$ZJXC%V.W-5?.J:V$KP D0(YD/Q69J;['UM+5W
M7@\"80#??07^$K.D@( `_/L=6VIR`@I!O 6ZP5C5)L+JU4V$^_Z"F,]8&^,B
M8YQ2^+L%-JM]6*7>JSMCY=K5<^_LX/M[XJ/_\$(CG,JVC4T^Y$L8`[*H+=38
MNT)+D&F%$-NF-S3H>^ !$*6<RCK'GT^(-&Z*9= :BKNIW,K*-M'T_,)D*36O
MUK&G<1'2`T.QCSZ:[)XR4_1VDLJ&- >Y+,KF'$K8F0W!AN*0DOM:0FHC(1#I
M9<?UU;M^ZHR%( )BZM$Z!RQ9Q9DS\CB)Y;;I%GH?>13V2A :)OI\BON;,((%
M(#""! B@`P(!`@(1`(+-2':;XZ#&U!G>^P&7OJPP#08)*H9(AO<-`0$+!0`P
M@...2336..."S )!@-5! 83`D=",1LP&08#500($Q)'<F5A=&5R($UA;F-H97-T97(Q
M$# .!@-5! <3!U-A;&9O<F0Q&C 8!@-5! H3$4-/34]$3R!#02!,:6UI=&5D
M,4$P/P8#500#$SA#3TU/1$\@4TA!+3(U-B!#;&EE;G0@...2337...:&5N=&EC871I
M;VX@...2338...(%-E8W5R92!%;6%I;"!#03 >%PTQ-S Q,3@...1595...,# P,#!:%PTR,# Q
M,3@...1561...,S4Y-3E:," Q'C <!@DJADB&]PT!"0$6#VII;4!C87)R;VQL+F-O;3""
M`2(P#08)*H9(AO<-`0$!!0`#@@$/`#""`0H"@@$!`+>;EY]ERMD$,P;8"I7X
M?^ /F69VS8/L_HEV(J#N= $S];)Z)NSNCEKQQL*V\)X*[3:U#K&RT"]7`^(9
M/]<<)D]QC$]^CQB)W6&GH=]!S)"#BX#@1Q)ZRNK%`>L!^4T4%*7SH4#L9W*4
MT$5<*UR%\T_56N':G<DYHV-9.='BNEU"'%TY+[]LYZ=B>CA]ND5XQ(/B6G)$
M+.45284OBU4BNP&F^_G1,%^"$.,_`")HQ!K_IW :.=0"J38^R&!!*H#$V>"H
M\A*[L =HF*&;G2L'<8*^T%BY+7S.3D[>P=G4O*#;+C4>,]Q8'MX2A9@...2339...$#LC
M'5]WL4$YZ?=VZ+H"B_33;&T"`P$``:."`=<P@@'3,!\&`U4=(P08,!: %))A
M:X+AHJ"J3^QG\<*C][2 `,'L,!T&`U4=#@06!!2S>P/T;X" O18ML(68VK@...2340...
M(7<123 .!@-5'0\!`?\$! ,"!: P# 8#51T3`0'_! (P`# =!@-5'24$%C 4
M!@@K!@$%!0<#! 8(*P8!!04'`P(P1@...1499...#51T@!#\P/3 [!@PK!@$$`;(Q`0(!
M`P4P*S I!@@K!@$%!0<"`18=:'1T<',Z+R]S96-U<F4N8V]M;V1O+FYE="]#
M4%,P708#51T?!%8P5#!2H%"@3H9,:'1T<#HO+V-R;"YC;VUO9&]C82YC;VTO
M0T]-3T1/4TA!,C4V0VQI96YT075T:&5N=&EC871I;VYA;F1396-U<F5%;6%I
M;$-!+F-R;#"!D 8(*P8!!04'`0$$@8,P@...1499... P6 8(*P8!!04', *&3&AT=' Z
M+R]C<G0N8V]M;V1O8V$N8V]M+T-/34]$3U-(03(U-D-L:65N=$%U=&AE;G1I
M8V%T:6]N86YD4V5C=7)E16UA:6Q#02YC<G0P) 8(*P8!!04', &&&&AT=' Z
M+R]O8W-P+F-O;6]D;V-A+F-O;3 :!@-5'1$$$S 1@...150...]J:6U 8V%R<F]L;"YC
M;VTP#08)*H9(AO<-`0$+!0`#@@$!`'W33 4"-'Y3RQ+/>:PFSC@...2341... 1V
MH"=?*@"]NZ7+1X&;TMD)/=KS<3BZN1X<*%FAF5TT8@\9&Y)W7&M28.,GF/5,
MV'!"E<-"(+ZQU&<SFY>52)<8(H0D6.RB<5"5L#EHH-[8IB]:W7W0)9<VHV>A
M3OF,X]<-(XS5!1:<VY>/Q-+\ZA; \X:\/*#59:$JD)8S.TZ20:Q(!CUZ+E[A
M!-V6+Y9+9_#2CX G4C7LD,*>D_T?J?X.7^&M(*ZE=+5X$_)7^:4-5GJCO[GY
MC*7/4G($(0<G(B/8FO<=,%\M\-V**+[KKM<%HL@...2342...,=HU Y_GU3PBE![J;
MWYTVZ97^?=PQ@@0C,(($'P(!`3"!L3"!FS$+, D&`U4$!A,"1T(Q&S 9!@-5
M! @3$D=R96%T97(@36%N8VAE<W1E<C$0, X&`U4$!Q,'4V%L9F]R9#$:,!@&
M`U4$"A,10T]-3T1/($-!($QI;6ET960Q03 _!@-5! ,3.$-/34]$3R!32$$M
M,C4V($-L:65N="!!=71H96YT:6-A=&EO;B!A;F0@...2343...=7)E($5M86EL($-!
M`A$`@LU(=IOCH,;4&=[[`9>^K# )!@4K#@,"&@4`H(("1C 8!@DJADB&]PT!
M"0,Q"P8)*H9(AO<-`0<!,!P&"2J&2(;W#0$)!3$/%PTQ-S$Q,C(Q.#4S-3!:
M,",&"2J&2(;W#0$)!#$6!!1^'@&0D?!!7NL<Q18N)VMU4Q!;MC!;!@DJADB&
M]PT!"0\Q3C!,, H&""J&2(;W#0,', X&""J&2(;W#0,"`@(`@# -!@@JADB&
M]PT#`@(!0# '!@4K#@,"!S -!@@JADB&]PT#`@(!*# '!@4K#@,"&C"!P@...1499...)
M*P8!! &"-Q $,8&T,(&Q,(&;,0LP"08#500&$P)'0C$;,!D&`U4$"!,21W)E
M871E<B!-86YC:&5S=&5R,1 P#@8#500'$P=386QF;W)D,1HP& 8#500*$Q%#
M3TU/1$\@0T$@3&EM:71E9#%!,#\&`U4$`Q,X0T]-3T1/(%-(02TR-38@...2344...
M96YT($%U=&AE;G1I8V%T:6]N(&%N9"!396-U<F4@...2332...:6P@...2323...$"$0""S4AV
MF^.@...2345...!E[ZL,('$!@LJADB&]PT!"1 ""S&!M*"!L3"!FS$+, D&`U4$
M!A,"1T(Q&S 9!@-5! @3$D=R96%T97(@36%N8VAE<W1E<C$0, X&`U4$!Q,'
M4V%L9F]R9#$:,!@&`U4$"A,10T]-3T1/($-!($QI;6ET960Q03 _!@-5! ,3
M.$-/34]$3R!32$$M,C4V($-L:65N="!!=71H96YT:6-A=&EO;B!A;F0@...2343...
M=7)E($5M86EL($-!`A$`@LU(=IOCH,;4&=[[`9>^K# -!@DJADB&]PT!`0$%
M``2"`0!O`+KWZO-SO:N8M Z91\4O.&8YH5*3$7[C@...2348...=R73(68YKKQZ
MJZTF9$;V(&#C(BU:!6'6)*-8SF^0Z6-RY2J$A&:GW.X\[<YUK\#.9#R %]Y^
M4F^[T-Y]&5RI6^0$;0H2*#6NQMRZ_>$O)[.8N"[BF<T4](BZ08,9;0Y5)B^N
M1M+G3 //2CX:X=2XH?6$R,QOOAW+RA78Z0'H>:%+Z(\-Z1G]7?./SM)"H_E-
MZ3C30"<QX!8I8^JV$RE:]^G#(37=!.T(8F8$@)S(9 3VM&%0NLM)`9'T6%G?
JA0RV"*3M$ZY<4(RJF7;TU$QI3SY"_>Q9Z#Y>0]Z7?/.?(XM[````````
`
end


