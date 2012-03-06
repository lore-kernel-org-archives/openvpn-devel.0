Message-ID: <4F55ECDB.7020102@...515...>
Date: Tue, 06 Mar 2012 12:54:19 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-18-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-18-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 17/52] Remove install-win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

The "install-win32" directory is obsolete, and will be even more so with
this new buildsystem.

ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  Makefile.am                            |    5 +-
>  configure.ac                           |    3 -
>  images/.svnignore                      |    2 -
>  images/Makefile.am                     |   41 --
>  images/icon.ico                        |  Bin 22486 -> 0 bytes
>  images/install-whirl.bmp               |  Bin 25820 -> 0 bytes
>  install-win32/.svnignore               |    4 -
>  install-win32/GetWindowsVersion.nsi    |  109 ----
>  install-win32/Makefile.am              |   97 ----
>  install-win32/build-pkcs11-helper.sh   |   24 -
>  install-win32/buildinstaller           |   14 -
>  install-win32/ddk-common               |    2 -
>  install-win32/doclean                  |    6 -
>  install-win32/dosname.pl               |    9 -
>  install-win32/getgui                   |   19 -
>  install-win32/getopenssl               |   19 -
>  install-win32/getpkcs11helper          |   17 -
>  install-win32/getprebuilt              |   10 -
>  install-win32/getxgui                  |   28 -
>  install-win32/ifdef.pl                 |   53 --
>  install-win32/m4todef.pl               |   15 -
>  install-win32/macro.pl                 |   61 ---
>  install-win32/makeopenvpn              |   67 ---
>  install-win32/maketap                  |   17 -
>  install-win32/maketapinstall           |   15 -
>  install-win32/maketext                 |   59 ---
>  install-win32/openssl/README.txt       |   21 -
>  install-win32/openssl/openssl097.patch |   68 ---
>  install-win32/openssl/openssl098.patch |   56 --
>  install-win32/openvpn.nsi              |  886 --------------------------=
------
>  install-win32/setpath.nsi              |  231 ---------
>  install-win32/settings.in              |   71 ---
>  install-win32/trans.pl                 |   97 ----
>  install-win32/u2d.c                    |   20 -
>  install-win32/winconfig                |   18 -
>  35 files changed, 1 insertions(+), 2163 deletions(-)
>  delete mode 100644 images/.svnignore
>  delete mode 100644 images/Makefile.am
>  delete mode 100755 images/icon.ico
>  delete mode 100755 images/install-whirl.bmp
>  delete mode 100644 install-win32/.svnignore
>  delete mode 100644 install-win32/GetWindowsVersion.nsi
>  delete mode 100644 install-win32/Makefile.am
>  delete mode 100644 install-win32/build-pkcs11-helper.sh
>  delete mode 100644 install-win32/buildinstaller
>  delete mode 100644 install-win32/ddk-common
>  delete mode 100644 install-win32/doclean
>  delete mode 100644 install-win32/dosname.pl
>  delete mode 100644 install-win32/getgui
>  delete mode 100644 install-win32/getopenssl
>  delete mode 100644 install-win32/getpkcs11helper
>  delete mode 100644 install-win32/getprebuilt
>  delete mode 100644 install-win32/getxgui
>  delete mode 100644 install-win32/ifdef.pl
>  delete mode 100644 install-win32/m4todef.pl
>  delete mode 100644 install-win32/macro.pl
>  delete mode 100755 install-win32/makeopenvpn
>  delete mode 100644 install-win32/maketap
>  delete mode 100644 install-win32/maketapinstall
>  delete mode 100644 install-win32/maketext
>  delete mode 100644 install-win32/openssl/README.txt
>  delete mode 100644 install-win32/openssl/openssl097.patch
>  delete mode 100644 install-win32/openssl/openssl098.patch
>  delete mode 100755 install-win32/openvpn.nsi
>  delete mode 100755 install-win32/setpath.nsi
>  delete mode 100644 install-win32/settings.in
>  delete mode 100644 install-win32/trans.pl
>  delete mode 100755 install-win32/u2d.c
>  delete mode 100644 install-win32/winconfig
>
> diff --git a/Makefile.am b/Makefile.am
> index a1c210e..33c4545 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -51,10 +51,7 @@ EXTRA_DIST =3D \
>         plugins \
>         win
>
> -SUBDIRS =3D \
> -       images \
> -       service-win32 \
> -       install-win32
> +SUBDIRS =3D service-win32
>
>  TESTS =3D t_client.sh t_lpback.sh t_cltsrv.sh
>  sbin_PROGRAMS =3D openvpn
> diff --git a/configure.ac b/configure.ac
> index aa1d509..747c7b4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -988,8 +988,5 @@ AC_CONFIG_FILES([t_client.sh], [chmod +x t_client.sh])
>  AC_OUTPUT([
>         Makefile
>         openvpn.spec
> -       images/Makefile
>         service-win32/Makefile
> -       install-win32/Makefile
> -       install-win32/settings
>  ])
> diff --git a/images/.svnignore b/images/.svnignore
> deleted file mode 100644
> index 282522d..0000000
> --- a/images/.svnignore
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -Makefile
> -Makefile.in
> diff --git a/images/Makefile.am b/images/Makefile.am
> deleted file mode 100644
> index 334554f..0000000
> --- a/images/Makefile.am
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -#
> -#  OpenVPN -- An application to securely tunnel IP networks
> -#             over a single UDP port, with support for SSL/TLS-based
> -#             session authentication and key exchange,
> -#             packet encryption, packet authentication, and
> -#             packet compression.
> -#
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> -#
> -#  This program is free software; you can redistribute it and/or modify
> -#  it under the terms of the GNU General Public License version 2
> -#  as published by the Free Software Foundation.
> -#
> -#  This program is distributed in the hope that it will be useful,
> -#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#  GNU General Public License for more details.
> -#
> -#  You should have received a copy of the GNU General Public License
> -#  along with this program (see the file COPYING included with this
> -#  distribution); if not, write to the Free Software Foundation, Inc.,
> -#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> -#
> -
> -MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in
> -
> -images =3D \
> -       install-whirl.bmp \
> -       icon.ico
> -
> -if WIN32
> -
> -imagedir =3D $(win32datadir)/images
> -dist_image_DATA =3D $(images)
> -
> -else
> -
> -dist_noinst_DATA =3D $(images)
> -
> -endif
> -
> diff --git a/images/icon.ico b/images/icon.ico
> deleted file mode 100755
> index 03ea0b1dccf355d4f5ac877c0918b374c7b7c4ee..0000000000000000000000000=
000000000000000
> GIT binary patch
> literal 0
> HcmV?d00001
>
> literal 22486
> zcmeHP2Xs`$*PoC;=3Dv7f_5_*>+QUvK$P!N@...1554...&#s6adn3Cc*gzDOq9}-B14RTxY=
Jh<B
> zrUHT@...1555...?Io$vRX_vY=3D(vRO8Wp6`E-?|3uq&b@...1556...?z?67p%7uBm?&Rf=
;3+Of
> z6cu7PYSGa~dscBFwxh3kbF*Dmh-U!?ezX`7Aw<m@...1557...(OsOg=3Dp4Nhz6KW
> z7SVt(@KH~gQP}?;I-4gqtY0hJy`3&&5<K#Q^;z=3DUpR(nKb!+7-i!)_rW|r*xUWRP+
> zx<__+H(mChnjxoc%$6T-&X!+o&z1+0_sQAYvgI}7(xunym2nF)WnNyMd}no*+_-+7
> zOixdjhYuZ;w@...1558...)s6^o$I-c6E~6x_OhFkd!6YtXe4>zUGl_C#1_)mt@...1559...
> zhY!h|JSo4}k}aS6E>k*ZdF4y<y)y0mdAakapXAfuc)=3D@...1652...=3DHz6{O&iwBT4Ox&NNS#Z
> zVV)N}*UGk7OM_QEaysO^?+dSt{n9HB>`#_W$EM4PYqI1mA7;oufZq@...1560...+H*WtF4~=
nX
> z&!0OdQ%>i}XCeQtojc_7pjGb`k91)VP8>fjm+a1wlYhvPA8g2yxsdJ9!4$b*N47ln
> zSDswGYK0u~Q3lqUA#-zc<=3Dvlq<>7+|WmZ<U{Qb9I<zsWbvc>pxITd?*{9K;A{o@...1688...=
...|
> z`<Gqv{dHM#%GxaX3D%jkB2h+T|MBSKVdX#gZx8-a9dPowwMVgHO|DT@{JFQYvu12;
> z*p=3DeOdhF`%sP7yS8+*62uVZL`r!&IgXzJ_}8(Y^I>2Oqbwk+vzbaD<F7~9o(i^I{Y
> z+Z_%^cv0uoHKH3kyR>jPqHc3IN;{if6&rhPb!SzF<E~l`#}&?Mv3SZmYdajRi#QyO
> zoHw!Eo&<}ubvQ~mi#G@...1562...;Uy~A-`1<F+voMVLZ
> zJ|H+s^lVj{<vr-{&5H3fAfB`AFr!s5LN%Sv0c{$VD%Gyv4Q%R{?NUqH*=3DRs#fMsW4
> zqy3*<JARfw|F~Ty|CuX~9yuaw!)8sv`@il$jvT!-Q+^9u^4p$0^3Kn^GTq}*w(<5)
> zGUVfPGiCQF8Ok1>_vXoAGre-}$y|97Hfa%T(t=3D$%@*db5+UL)<X3H6yU=3Dv|?X%Bxp
> zkt_Sd*6oLl{vm0VvSou{r)cYGqnGT-ky$xX=3DHyD54cKusSFT>ULivG{=3Dkw%1*z6y-
> zZI$C!X31BUWy$SZx5!zr`8$64QQ6du@...1563...+0!ZN&9kST4tVnc#c;#
> ze<NL{oXJx*@%6+kWh?1#{ycR`-uOX=3D?D>9%^kz$C<41m*DIfUCE4LobmD$<Z^33Ve
> z@?O~PHt-9yrSu68e(jaJVXse~JR#5h^_NUJuwVHN`hYLsgI4U#QGTn{o9S}?&K%`~
> zGO@...1564...`n>NYcuxI=3DB?v=3D^=3DewW>_pSRA)P(FgbXziNSa@`MW<a$8Y$r-TQhR=
t7-oFo5C
> z%agzE{zdLPl`EJ1nj^peB}bk;b4HH(K2ttDKNGlFa^B8t$eblTSyFD_vRNKGdPL6r
> z&!+#Qb_?&<{}g?<@2L}BBCJJ=3Du*V0q^Yz(lb*jawr_saqUZY;QA<7cQcr#SH6u0Bt
> z{j{qn+AkU7v8dK{m91c5Twl`VYJ=3D9T#`qPemUg+CK4v1+yUOKqUDv?vZucM&8kIsn
> zyP95aAjF{ViYS6cGmf|J<aSrMgMDSyczae|t}D^FkK?USX=3DwCO$a+1DdL-(DIDQ){
> zql~`VknuUA>gs^*QjIX)50&O-XH~bmj8VP4E4tl-<Km)kMA^h)^!8|QLxfSQ%;85y
> zU_6|)VrF;4%EoYacE*x@...1565...(u_b(}nw+?O-HhS5I8tb7j6c)IDBGedOpo7F$L+q?
> zU{JE68t3kG8m7mGKMM)3Rs*#RJ{+&pT8}^Qyfy9|XwWYP`mOZ%i)h@^SPfj&*%&X4
> zuBY_)AT-P!>{ZtoFIOLZHya31sJd$z{X?qXZ&uj(l&Ds%RX5hmX^m^BlLku1k?eNY
> z!P4+_scp=3DvS>FAGQFC2aLyf3EU2B@...1566...#2<&P0f18D)kJE^2Kj5yB_L^p1$T$xL=
iH1
> zd9>2VVs~{nM_sO=3DY65i8_ZZ7I+A#(_cUj-Cz1H94=3DWfv3-mUA`zF<yAQQDG0kGdkc
> zW7gBwR5LwXv%NKBR_b1BoG38vFL`Ia$tFhiy4SQRS+YatCvULL^^XVs?Ka~Srj+*r
> ztT?3v8h%e>#1X@...1567...*!fCy~^j)r!(H5Zyk;NY#`!?>4-6yb1|M70iV4ec@...1689...=
...
> z$aBsim&!yg$b9iA@+12E7vV1%TWs6BS$=3D}tkvZS-qetZ)<Ut3LlT}VdU(ML02l6uJ
> zP0almTWn0pRWZdm#6KCxCx1SYE1#T~DZfMPlMVmtNlTNASAIE`EAK<D$Jm4M&Y5(?
> z8t~t(-%3~U5c4j^MvR*n|Im-$JS{`+MBK9taR+0UImmr~*|9^#J&c_g6V!Rxqv8t2
> z3XDr8ArE9OS|2%PC&WLDZ5VIt`+cv9>lj-wwqpFln1C_PG30%x|NK+MXk8|!%Qp~H
> zF@...1569...?!u*mk*pWXDs~B*@+8<P`wt3?QnSp$nxiRzJ-Me<m)U#(*yuo-$$3@...1690...=
0...)xe
> z&B#-6OlD@...1571...^?EQ6*Jagu>?2WvA+zRBc$Uzy;F{geTIr?Pepa12a|68#HUfF*v
> z_OY2PquSot`;nWgcj;2S*29AvTwo0^KzFxyX!jHs*Rtt_;}`Ul^5Kt+xM0-QaSffb
> z+g-zl&j<znk}=3DT*Pt86z8ixNFAO4*Rt5c82au=3DZ2d(q{hzlBHcWliX<I^bf9GuE;{
> zS9XK_uN0-auGaW1pHS^E3=3DO@;j_tl;C>_cGV*yWV{HqmCR3(m;w@)ZnoLw$gV}(#w
> z<5ySBGDaZP&nA-goV67~1&x1?YCdStauv50UBc{f#ndE5M0az75h*s(qbh*H_!Wb6
> zPgRDDZg*D$|EVTy)O<{j_UOpA+iekWxfsq^@ra7t+}GWx@...1564...&ap@...1572...|-=
Fm^wudhRml
> z*HVpJEOeKv9ee87Iv!OhO|McDs;P!OaA4eddsQEPi@...1573...{L{H*h)mJs#;l6PfR`8^+
> zSxI|$rJ~(U<*eDkhcV3UhTiDMI4-yIftHH?aFf9e12lrGTg_X|I1F9J?z=3D0fXqhv5
> z4K^eyV&UI-T~Xie^iiWvDB+22y<a-a!n97l?J8+#)V&6(@z;1^nhA?R2}>7T_bdId
> zX+Nf1WxT+?6-P!|Q;pN>Z6_ZWXQTpV)Ckl@...1574...?lS}5@?Wj5v+!KCj9O8cfV)OEYf
> zTu5`d0N*#2nT^|x$lv}LI^omEJE~anmsh82DZiR^l~WOU)<Oy|W>sBAI9J0?-gqNz
> zDqY2VJ2|Vrq7`A8hq$<&6;;;|AI-YP+pjt*F(Y!jD_RrUnhIoE10acJcJ;5K@...1575...
> zluC53WtbngP2_=3DYw@...1576...<)8Luzi_z~5rU9a9=3DP`I_9PaLRNE9-4{xdvJ$!{DU=
;w(z0%
> zpg}V;E7jXvhvF7~P2YjKT+P{C#%BPKjxt@...1577...=3DbberpVP*BfcX>XZaE~7Ezs*?b=
HGp
> z8s>gHT6d_jQg~gaqVD<)Us4&YH7GRic2<{JDPO#F=3D{BwXdy%b~kMAY$$Fa2y{WWIL
> zC0yj`V4S{zU%$;ouw60wEX@...1578...|_U*#SZEiP3w~C-^sACt#oYL5)C;1taHx<#MZB$=
zI
> zx0znwi~*JNi*B1$G`74C&!~w;0lmAP)T;4A{S1Ey^Z}JhcP@~&p5cxv(`m@...1579...%9Z=
<9
> zDONOqdi$kA|26;R9mxN?WwgOPz<oM?D-#yDJfiQr$HcN_iN#i}SpF6AnL{QlOkBRK
> z%;5J9i|DvCAHIDq>!Ur-N5^}b&G>Fp*ox&#*E1g?puT7J;`QOR#-zmn=3DLPT!w|M$!
> zOh=3D!L9+ftH^z2_m;?l)q_58$TOQwyV^D}u5R5%HqFHjb-(RkYI=3DlmJ>eQ-cv&aJlj
> zBOdv9pTO973opUrGUwMsdEV-GdA4;Ne@...1580...*0ci$OMhNm5Ixm_kQ~r`LD9@...1691...=
1...<Fhi
> z>j0jy_2q%box`W^7t5C|jmF$F054=3D|{FuRi5O8yC`0=3DPOvD$9WmbT+giG@...1581...
> zwfvAHdGWH9Q60yh6wxlv8Vf(cvl{h3toEq1$q&ug&%GO|=3DjsxDFDV&bN*ib4CwLB{
> ze#mN%N_%g_M{53~dY&#Z|M^ER+(XX&-kR_B{CM5iKPmr}IP;(NT%JGVuiE~NQ<Q(b
> zg`eQzem-GqOYHG|L#G@...1582...^A@...1583...<y49+|&*<rQ~NJ;?nZ0^B?s{wUO|0#=
a>#>A;I^
> zJ@&L1J}p^1Fg;mtPtkWLaD3;S;PIdx1E4-X3{bxtTP4<lv-|)sHQMdjYW4f@...1576...<*=
Pi
> zU6>dECqGT!+z<WcYC4ai|5Ok<XD~)x*Z6_T>KGphm=3D8E$!gna20z?7w&GAMFkrFP%
> zT73KPG9Ut`f>0bEJ=3DlSL;YmWo<J*TM;HN|iky_69J_1AL?{=3D)=3D;Rh3bk3ZiF+N09M
> zgt<RacLnq&0^kHp11tfo1JIr<1<U|E1}Fo)5}z*INV{Wz-`XzV5o{c`um8lOV(HT5
> z<R1=3D51}OU#pv*=3DebzBUeet^1_Z%+%w*N};N-3q!UCeQnkwu>@M4Zv5+vxdB9Em|*P
> zMuYcg56}FLOW+%cIa2`C)90dJN)u0gx>uh;Y!LoqDdX6$chIJC?b<GXj(S-@...1584...<c
> zcuN8L9r=3D>`IB4=3D8f@=3Dfs)<O6Wrk*I94w*q?w2jUN)GGsm$xsaAi*0i#!(RBVqRn4F
> zBNi=3DNC17*QfdBCTGVtsh!aj>W?;NK+BOjj)H`YTLxW0m92xKdAaE|q<%QK<V<{qpL
> zz&{1NBj+z&BO1Jt%Cj#AJ|_TrA9YC|8Hj)H0JwV2AfD%Ib9QMRcq;(^MU?Hs1zYsm
> zuMI-aUnjZmJA>fAL;j8rmH(y=3D3<|(Mj%WYE=3Df7&*dngD!`X{?S4hw?IJ($h&?E2OT
> zo<I551!Vcj(1W^v$NPsge|t=3D!_t9R`7V{j!07(G*n7vLv9uxgyn$m0222h6IZ2Zro
> zUY=3Dv_S-S;sG3RQ)o*;C&-$enn0a-!t2J`*v^5zM#V2RRy@*V;>VdL*XeK_}K(b7b5
> z6YQn=3D{&xjkdt75*7wfG6v~m9Zy1kuxUq2yLeE$6gZU0`g@...1585...)ums6pGVc#tNK{=
R{i
> ztiXHAeMk&KpMEviIlaJjJo0g}SZ?^An}YDxGB}9)>}S8}J#Yl!KLcZP3mhNq=3D}5i%
> zVEz{U-Y15@|3~aW5!wpw9iTDj7jy=3D+vnvYVpNqNmViMBC?8WN@...1586...)dilJ{SW3v=
%sx5
> zcgYW;&X~W*pL%$%03PemU(orGfBk6ipS4KwFAClVLg0TI{3}og>Wn$3`JXR<|625a
> zUBDQ1uq*ff{rTIp?kx;~|3>QI#|t+b`ZwBh4d~coQ?1)9>1$pG*!%4D(bT{D5lfi*
> z*Cho0w-R^cOqJJA|1XSTef*|j{FWg6cjF8q>Wn@...1587...<@4=3DHnWO$i2Xx8HOqTv|4
> zf7HK(d~v;fZLB{4V4jr$@E_Cd;XH%3<Ng%iEMBc;=3Dmr_S1^f=3D!2lyV)pS+P{h#nK*
> ze~s8n#~+%Oz2uoR1yDwRpKr%Ijq!%0*M96N@!@>z1NN7^pl1<)qO5bzXMVRqbcc^H
> zc{BE69%ZLxuW!LvIDq_b4uZ!ydjU<j54CU>&T0F_q;I#0FTY=3D>-i`O>Z50oFlq~A;
> zeKXe0{AJrkXgV=3DY-UQ0Q*u*ZMf1Ud<0%uxG*>=3DbhJ%)4PYgmV#Vyp;o?gAXS2(4c+
> zUL2tLvuqD2$WGa1*#*3p0X@...1588...}8`>_wc7PqXpn5;x*?H@...1589...?Kt-O
> zqyl(T2F3!6mF@...1590...%Uzl8EfhF1}Yg7eD)8>@EvHDx(IK(Jn_KIxlD3Q0G)_J@...1386...=
591...
> z#GEyMLk7O%jH@...1592...$=3D~xPJxtF}seW18*5%DBx1o98AV2(4;JU|Goq;eju;e0Q#}p
> z0JQ<ZXyhA{DUp(pH?pkTJF;w4>d3O?Qks{IOley>GO2C#@c6dX!w8~7bs?UwiOU6C
> zFz}LrmlM2jP?rwo#luKkJOC&DhEXCu${Q9RnG%+S>xmR0A_=3DKNl*<t!Do+Tvj2DV;
> z{_l38g?j23h5c_~)}(L|dp3FPtnx=3D@&cL|22%rX_JAii;Zvtil<^a9{d<J+MKp)!&
> z5Ch<y2j{97aNy)4+Q#SG$3n|@u``12uH`<5*k`Nuxs-u1;BJ79buU(?0k<K5zEaFv
> zvRbrw?X<wX**`10UK{*UXZYjA$VqHxz<Z;M$*sqk<CLcS^zppE<z2{S-)k+euWSw;
> zjT9gF)i=3DNS*?tCN3L*ar%Fex?jTpLCf{KSJe<eU`Mc>Esa;%H~|3v`fIob#n7jWOW
> zf0PBl*iG;6#md(?hjVRrN|ci}H4E?-pd{dO$X*6?<^!}XU7+YfhkCw!T<xJLe?^pM
> zLR>=3D+B|l=3Drhi4?~e2}ufVB@...1593...^(u<jrLQ9z^XY4}>?{ueBAEj>dNoxnSi0K2=
hD{;J
> ze-1cTQ-11CpLg&(2je_L#&7+2{f2f6b4=3DreTGqfk&bQ0XI(>gb#CD4BlzCPTMjd)D
> z1o^iCCycVsMJ}jfV<R7l1l|1s_?<)_-@...1499...!dCLVQ<Ijq0zx;<FY<NfJO>;9DTJ3^=
5E
> zW8f&8KV{x_``*_B&Flhr{*Hd;+o7z1v1Y+{55}6ND_XEYw)<Dg-x82_ku^L>`I##{
> z^C|8^e0FmfXzKk5R5A|<<(+=3D)B6LXm7eEpEn^ySU2fsCGKTrm;1-iqv+oLv=3DpLd#E
> zyO~#UUuTBE_f6mgI|J(cnGopkx2PI?2Y8>)J21*axd5vHc6sgf(-^BrpT{+G?WWJA
> zecllQU)t7|fP&WWNeDFb+4fa*phIKl?6CWR@...1594...>KYi!rs<&v1_wGy1%~OQ;E2jBh=
pV
> zVC72SQOEt)a2@(`L!?3auPPdl|3Tw7RK5R0gUCOL^3!j<`t?q`-Dm6^OlJSFL5g?&
> zHOwj`jd(5pZBwk@...1595...`HN1fSdx>aF3E7?=3DFA$vAw&&?rQyIXPdUseg@...1692...=
..=3DA)
> zaE%-WciOz$rahr-fJndrfL-rd=3DbD-U)c*7CPTfrydq`RMZU*8NsE@...1597...*@|<SfM8
> z1Hdh(=3DHgC<zkkog{T2NYWiuhreeN-gac#<0En1Rj_+IFrDF^RrHUk358>sIUa~|j0
> z<C{RZ_CCXR!FDztb4Gl&(7J!8>`{O(0KE72-~TN1@...1598...#zj0qxbCMXN<y+@0CthxU=
*q
> z)ZBg>aA~)AcW?w?m$9Ha?}&=3D1*a3S#9`Unze@...1599...{V<@Rr<0;dl^>D))S|BQ*Z
> z>=3D5^IX^65g7N*^50tnUaya-&Sw*w{}vD<vcV~0YJU9W{PTqC^($FvmtyD$_y3fe#a
> z{$9Wh)pl`>&6UqWylA^S=3DiUeV?OMz1Uou})dqDrk`%iVQMw}DMeF)d`gbDuZ3e^4s
> zxFzW?jo*B&nBfY@...1600...?_%v-%xTCqtV~Q4o!(O4>gacQ6L<xZ!M~69SIl+%`vbKT
> zfv4h?0h5l}?M=3D^1kX^6se#%dOc9-w>O|D^Dh%zx|nh_!{?~;_Bl9w%Sbp8$bUsm$N
> zcknwXn?D#AqD*suH$6n$ueJPlPR%F(eSbs#1T8<m!?MZ$Mj>Ph6?cu2A9l0fyZQ8|
> z)8CN)E+s$oX9&L)^!c(-<4EexBO$K!B=3DE{I?``txS@...1601...{77fTHo!Z7qUk)mR`1e
> zg=3DlAdt47^tEb()QGEvX?n?s=3DYHBetW?Yky?V}1KX`#I(k&frtM_xuen+HLu;D9A(K
> z6o|in-^0MG4=3D5<_^vCC2u(CnD@...1602...|X+<;(OL@...1603...|w)#>Z1YWaue*PR=
g|%1+t3
> z0GRh52yspd@...1604...(SL7puktbxBv8gVG>&P05_rQ#ps4ubl#F+^GD<8)5{
> zMTm2_X1*`VSMvAU4;E~-ub~uVqfI#&U>(ehCju%1RP6Kl!gZqQ%lJJPK2gz3@...1605...)
> z9Ba)voLiWf<23NAtGS3H8sqom_wgMB<2c)0F7x;f0NR&(09^qU0en}K?4K@...1606...
> zw#A;MK$G_*{yJMw+la-umkFLL0F<jBT>t(bfLjuv`12e_eF0rswp__(TZfXDGP939
> zk8$(3uYVFvUOr>Ld!WssfAr^5P@...1499...#tL&e{apKExp5c5fQA)qwCh`V6B`%E|{#?S=
dl
> z%wLkE;tR^FWnPGHgeK12CT^Kz-kJDxhB17o@...1607...%6tf3MU!r^~wN3-t~_(^-u<(H1=
S<
> zW5U1DKlH`DCcoLb<Nbr`yCwDeggI{E8{Z9ngSMs@...1608...=3D@...1693...}R!pJk}N*v{t^<~<=
H5
> zW6|XIO_Y`Xlz=3Dsv-#lqv#ejPcAO&Ej6-xapi_e8;Pyu6yE`cWb?g!8xb_DQu2ra8F
> znKSc_#tmQ|7mBR@...1609...)pwC%ijChGybN2Pu+b~*;I<6KJpY0wBHvwz<^
> zmx0%%$QNu5_kniGU)F-!-~K;Z1M{&Gg^-<VqQ26;1lyB;V{A8Mr~xQwpM&*t4TZID
> zmvc?4z@...1610...!DI|&>}}AvoN|Ri>r3!7V#U8NKi9~6x8#3e9Vfu!AwVemT3DQlp!+%?
> z4G_v676vB=3DG^YYCRo4r%7RF8!0o<#?$QTGW6*N8pv<4JLhRcC_C3sS=3DJ_RuLWn36Y
> zMtdLkIR)@F;9h_ci~sww`>&rd4P(GQfDr)RZ!@NSA3&XB-g6V65uhZ%fBq%4rHl{b
> z|2ouHCK>HxN#V!X|5{S`L6(t8;VCHd!c)Ri+(P7_OzI?rH#{XWDGHx2vBYOesbNN$
> z5|$bn&(E2{Qp?5jb0&L<e^V9DHp_5txg?g6DUm4x5BT7FCVbHZjC>_{u?=3D29OUjUM
> zo=3DL}~8&5t4-zdcwtBprH2|FMtr*P-7Oc7CDLHYTwz)%`AP2S*v@...1611...!+9s>D9v+=
bev1
> hg?)-gDe+$tKG0&Bf+ewp&`~VaM_MRlQaJbh{{ZxLA(a3C
>
> diff --git a/images/install-whirl.bmp b/images/install-whirl.bmp
> deleted file mode 100755
> index 03f33fce96789420beb692679093506ca0685469..0000000000000000000000000=
000000000000000
> GIT binary patch
> literal 0
> HcmV?d00001
>
> literal 25820
> zcmeI5`EOlE701he!EbZ{T4*T<XrZ81P$-)~qNt^aMS#>oS~jU5#3q&`ZPG$R>5}eg
> zplg~^pbJam=3Dj=3D|L#QTzXiPzYPcRR_u?>#@;m(R?Zd+xmZ{G5kXRknCfH`BRu&ur&A
> z=3Dgc{0#_F|S=3D)U<p`@53#68>%G-&Op3%Xx1lJ@...1612...{`F{T8^3N8Kgq7ba=3DRg=
I+RSqD-
> zuV7fgaP@...1613...=3DL-3@...1614...!Ep6+VD-<SB8L?WS3d_<{|qW}Si$gr;6Nq_
> z=3DH}-73fW91m&@j|S-<einKP$P&-f*p&t|iUPeUgLdyaQgt~6xmWqN8dm&<8kKA(ps
> zlgTX1&ugJ((&@8j&z{j&GPAR}nVD(7WPX00aRos@...1615...#~xb?Ch+*nu@...1616...=
%=3DENRL*ew)
> z6kYganrA$;sjre@...1617...~vy?M>=3D0*GY!XEkbCdy%RQ^V<*0&tGCxApb*0D?{eZZ<X4
> zofsU@...1618...+4=3D4<5~!1{gK1XjrDL{3%k2IJC7ZO<ytaw>SS-v@...1619...
> z42>K*cz~|8q_g8#ecfSdY02coc-`Sz3V~Y-k9T+ZgQ1)mH8(Z@...1620...$nDnoN8%m93L=
Ci
> z5<fFGHoABBPC)Yu+gn>E#>e~;@*T(8>8r7!jw*>yZz6{DpTMxKwYj^i1D5NcCMPE#
> z>*?;Ao6BpVWLWX7%}vL<ItK^(_0vFqA1%P7bULkttu0OPa(pai189IM-31<*($glZ
> zgC(vdbky6^4MbXETIe|1*3yiU(88{cV?D<iYOGuu>+7bbCVjoo-`CsH+~|*4tCQ*K
> z?AX6|_vpwezmQ&72*X1se0ioXrm%Zws(3lPSr~!<ix`Of!7@@NJv=3Dm|g_%qM`+JXf
> z`@`3-Fs!Ai!RO-G=3Dm`97Z)^1#iGpowX_}sng<)!Pf)ap2scLJQVG$vvevgCweT;2#
> zA|5Sy&;VFpTu%)2qXHPSHf0cNYCL-;*38Hxn4BCQRvOJPn5Kq$v;YKJNQPI&gKF?K
> z{L%K-+5`KU!pNxtz@...1621...>Lv%3X8fOWNoMJ_?#CctmAO2YUJZt*Mp<3qW&ltFhH;RRY
> z1;1h<zw}onE|W~@=3DZdiPAyu++GQ}1B_2sv~mfLacD7yfl`OG}t-PzjQi01b<TjUU>
> zGc-8h>lbOQJPcWXdv;dus;=3D6V+Og9<2sOIJAJNiz<{>|y%pap){(q8RSa9YMnFR7a
> zr03*DX$;#&!n4s1fo}EzH2LZ(<XxK2&xalH-gC|_D+F&a2TEXgXVu)LcLhC@...1598...~c=
yu
> zKobc>6nCWzhH5*Foei(pl=3D<C%^7Bh+!8dr|mFAQKMHnJ`w{4$&+uHQ`YlBzXov`Ds
> z)a=3D`1#LuEf28%cdoGG}sH#~n`K$Tm!&z?>CHKr#7wQn-)nFxDHC&Qrv2SbNakeLb$
> zef-$!=3DGC^4C?AeY#fh{fuw*A=3DyP}}w6VtZYNi&%2A{I^oF>{os*iQE8a9Q-{Z}>h<
> zB9Hruk!%|`RhQnt4TT{#|MC4^X|o7J06gCSm<E%zug7!5fJ6>uKLo?WwFh)i5AL5A
> zdeU2-pDmWgku%|yn=3D%(~2;{kGYk^Cy?f98LADLJBb7VFK-+0<7{rmPxt@...1622...(%;=
>-
> z$Z}$Xc;D}Xi#M8)Ty|H$>k_}Q(NWf|JXorwD6xkQ9jw7#5K27QQj~r<MxHi~c=3D+b7
> zPevX?)KS_lik;^|4DZ@...1623...}?^VPpZ8)6t@...1624...#ae0t^{_eLb@>(BQG?k&V=
-lV
> z9U$03^M%LGjo}lA=3D7rcSsCCpe%gSa<Bk`;Kbi)?c;2(C*xle1;-+Cq<ybksIFWMDq
> zYhAcLXpWtDC5bcmbxhf;-0G_OBZuM-g*j}sgEjk<67#$8`{HkShE^ubuC%+lsuYHp
> zeYg}({n?QeyP6(`btl4$)*Egq^AMitD1vZuc!=3DKINK-p>HRR^PPdu2_DpZFz2VyVW
> z%;41N@...1625...&b7Q#Wu#s&UjGqdCHg&*~ziF$3YtwF7gQg-HA;CQ+c;PyoUGVlh
> zg4U#~71tnkf_Nx0NJ1j|rliQBVRM8w;T-+6M5ep5LzzkAzANb0B4Q+DB0A)8N__(I
> z9)@3kDkp4Ho{_1IqF#iqP#3Z&X=3Dx_%ppTA(7p{*4!{SdZUx4WZIed@...1626...@pasL%=
YYS
> z^g3x=3Dhcw#mY<hu}sIL@...1627...+hm`2qrGTJ3^B!(Z6Yv)a}vyxSLD!%ij|YP
> z(h}=3DeH+n5)g*>$bM{Q9I2~+S%Z4enxu~v^T+}{_%E&G_2Dw%g}jI|983|e3IL+l&f
> zS@...1478...~cU~Lu08<Ss`-qRBssa6g%+IYDbMsi4l*vSpUVZ)GpB%|qY*ck;-kwaO4R7v=
cI
> zHT?@Bgb>Jbxaf{_Yw7)vIE`DdkxR_<6JDId(8{3@...1628...?!oU7e<ig&m-Zbtx_)O$p9!
> zBvucW(52|ZpTC+nlQWO#D3d;2AIIn!uS|>f2s8Uj>bVB=3Do}q_x`uyY{@vi9WQV7b#
> z5K7yuX?g3Bf|2;W`}uozISi@...1629...#zYW5W9y$|G8*=3Dx|A+OD$sAJ8}o>?*gP>izd=
Ol0
> zT`Cs4!La1c>DP7kg=3Dyc)p%<PLGQxHW9T}6iX$cHjj-PlCIWY^=3Da?U_;<CF2OMLd|W
> zq><~WPoidiWEbVB?2#6(xi1q$8<Of$5rFHTh+Foj<>$9}HVq9vURxH1n+%3-3Tw8-
> z81Cy0FAxnJ=3D^93|gf1QE>vaIy`3f&d33&N~l)Tt9LPM=3D`<<Rbj%1=3DMUO0$S1-kW@...1186...=
.1630...
> zBZ<~X2@...1631...&cE|cU85q0>1P|9GQ@...1632...*rf@...1633...#{)cUI0UwEf0B=
C`LQT?qZkUj
> zpMNw<SYR>;PiI3^z@...1634...<gk1Lu=3DE>7;b$b#*htDx|TsoiY{#_Vbh>!n5ItIak0AU
> z!2Z3(@j>4%rOFZ(tUps@(?nXjSeL@...1635...;@)K#B{1BOaxR79@...1636...*tDUxXE
> zLC-<(mvPA~pQ62SU6AT>t3WYy%v+zvNqhf2nJYI1AA2Bk<C8fwc~wL#6GaYHDNyUF
> zx^m@...1637...%o+Z~2GIu{hccitH=3DHS=3DoZaB&Pd7ZHskQ|3IASD7zq;+%-lIt(K@...1186...=
.1638...+Je
> zZhl^D8i6H&A*TwmPf99-5eP_2*rn`UOj;N$Jow-}!9;YTLR{3$AR42Or<!U=3D)Q9iQ
> zD66EYzqQ5~;#)|e_Cm(X8@^&U5@?a%lh(J8!I0uo{@}$~ygT!3=3DgBeV(fBmh)l%Pr
> zD&O1gR5{+G_QhiP$h~gYC}q=3Dddg&OJ+956l;zx-Tati4>i~b{asQ^xj4#dspAu56w
> zjo2jgq|~z*8qX8Pf|4FBvqRCHWw<+Dz>{Pc(mwPh<nZ>t#jzP?&y4X5CnI(eQ4p!u
> zdB|)?X<kM|gzhSfp>mzfOD#zZg_kZZ@...1639...+KP<~jJnbVUIoIR_*uKu
> zEf&z`>&tBmvI&!Z=3D#QE1i4gghM$CR#WS3e%YILR&bO8#PGK}QNR&8?WUF6VkJ#rDX
> zx(E`ea(tVp1%_G$r%mlrPNTFh2#&V5as5ODh*zEx7_NOisY@@}5D?*%->H+sQd_n`
> z8K9&%{z5|t6c593%d#9kp~PGZv5#*Uj7)y}nH+JH>z~M7ez%ccd4#pwn~d5ty3|?7
> z244AOVKl(<ynAENA0P5cKcUJY^gnvZV94Gpbx9xCH^%}IPnE_O_3@`BCz-679eO9V
> zgCjc{866pMv$lmgYw1<x(C4&iMB1?eOm%D>?!>r(YTV0oB>tgMD)bJeaGR7M1NV)H
> zEl7!sVQ?TB^|Sur*2D9dAdZodY5J-c@...1640...&<rXXj$|m*wFO)-$vw6O?7*hz>{|Cj
> z>EcVCT{<`&{`6&aYs?tFW&?a%4#g1{3Izw7VHKE#z@...560...{786&=3DhB?wTP)!lAXR7=
8am
> zM;}ic45j*_z6F-2G7J?bcLtcI3HcjXj7H^RkoHIhN3OPJzt%F0vb>5p7MVvJ`l}U)
> zO=3DBqyVnz<rXBXz@...1641...%XZG;O6w9n-Sp_ET0<nYj7_|ZQ(4HNOn975<wnTm1nqb0=
&r
> zh)nob%zpUSf)EIeT(K$8IGy;1hI1C)FFp}ljAo2M_}<?;>4FAbm&=3DF5ylKP^#=3D!OE
> zt+`*kmjBr+vmnFsvsd!J`F9>b5<m41sfZljumz9DV9qOx0^$=3Dh;bjqq#d2tmXX35T
> z_Yyd2cbKFK&TMGY$YG6%wV5YXMeGzo<-v|Pf|G8`sVmjFA|+!M45b_lkvC+X>W0h`
> zb4^1ixu6qszT|$0Me;of274=3D>Democ%8<rbi*&+Nc*yw9VNHK1#-7LZ;1<utMh?-L
> zvieDjef&>9Y|RdfFu@...1642...!4Ne7Mtf%YcBvpnT_bNUDi>URU*?SUNezbRd^^ozyL5DP
> zL^y33S;d_@;UX!R2)_j=3Dkr4Ts*blijq_vPbE~!bIf(+Ms<SXW&!pnxqEf*wR`X!}A
> z@...1643...|v?mXJeQW$#x6Btv@...1594...{TX!K(m!^>k3ZlHKX{{!s6j(@(WO=3D-j8=
GM0c&&|^
> zOLZ_r=3D{XD|hyAhI5`JXi;3U?j9mx`4Nb2hjOowcwGRR^dAAZY<C*570@)ZrYQ%wlm
> zN(ek|td9?vk{A}oOF8!g5C>y5`m08c3XNUrMAulqHjZh9&?-BEG&(ccB#j!kQd%0r
> zbT0hlW~WY-2h8=3D8o3n=3DoV`<ceCBsR;ryh!p65);1%EX~IgQ1>V@...1644...)?WZ-;F=
Yw@...1645...
> zHCmmo=3Du&}H(x>Z7j=3D^s#!jP3>8Wapa{ZK|D2?J9uy35yuZ-Hj1*}Dg33%`9uDqY}r
> zTX`^?)~%9Hf}vA`#&#))wSgG>j%zkmrJ-i7R0@...1646...$#iOWQ3~l=3DuiDVQ!!Xjxr7=
?u|
> z)uVB&1<ol8Veqg2m9HNP!C8I;(Fi}YBXN=3D{WQu_7c)k!)MKH8&n%(Jhk7hZJ?;Z~c
> zV?Wz4f9-?uDuCw4e>dpkTS%J*inRf!OTYSO{+F-iCDqKYY>8eB5Dc}VWL|2C;{%vM
> z$RQ2#By1YdmS(wIZgCCF%{KZE_PKmAX{xF(x=3DtkVQUQT95vL(ci94bd@%`k!lbk(K
> zt{9pYkpG=3D2|B5l46Qq^u(#4V(LLS}1Z~$8VnLIPb&SY01rh?0S&HY&p3B9k*_z<40
> zc_B82Wd5Q{<tr(!9h>dj??6uCj^r!N9=3D2k?lwBHalCpeATcV>};-$2s<>ZlhZi46!
> z4Buteof&+>roo0Vtg_w%8UK2!RCgzemH>9@...1647...#KnV&T36yh*qRE!G~18YOGBKSb)=
MC
> z*U?JG?S~QCrO%#(9An~hkFdEh%b2@...1648...`(HsBpy3N^Qb5YNp4828wjIA3r
> z5;-(nrjU^kr->T3l#aj+Ou7~VU~h}Uo;Kzkj|zg<BOg_oJw6fQ`btIiLj|8*OJX6y
> zZ)|*_Po$jO2+IW%ITdyoTIr=3Daw^T6WPtQzarf|VtD4m{6?NErEZxPiJ0MWYsb#v(*
> zyHu9|nRCe@...1649...+vq@...1650...~ZihRj>09%W!>gg^wybq{5!Ui?E2*?cU$U&~dO=
1~F?m!_vBs
> z9E?wqq+eY=3DZU9aiO@...1651...`zN>mpl)0@...1652...;9F>elIa@...1653...!dDM=
f2G0G=3DU^8W<HZvk`E
> zVPbhNVJa}RXTWwt6Xzg8CT`P~uuRn2^y4(La3JQdI{fY=3DuNWGf%fgU)h|M>jac4<B
> z|Acu`Vp30{c;y;^?n{Y*-~qDB;c%Mg1^aBDC7yZv-)DdO@...1654...&=3DQuFd%~tBBx<d=
{g
> z46#;uVRj8A?o~2|fOa%sgLUm{*@`uNNlS<uaJaHE27+<@Q7o#VE;^{N`ypmTVhZxg
> z{WWJ~TGI#U*xYa+%zc{37&0PfkpvTcM9lmUi`b<~K!#iIi*{;sX=3DLuuP8o8j%^(T*
> z=3D@...1694...>r?1h$M%z1&>y%b*j!VV?XQimsEpj66*iLs2%=3DSLgal~}Wh8Gf7|KEnU3458
> zOX>VN{#e9sQ!#`F0BIrdH+)KrO#^{x%2INZiB*I0SCNkHVrUINbMka}-`=3D^;KAbU{
> z(C$cr8z~PLs6O*>_TD{nrNqx~Y9;3}L4`y3gqVf=3Dxx*5pg@...1655...!586ry`HE
> zBPp75-|k(=3DD)-}x|42f73scK>iqTuDQ;E}P%M1YYNF|m_ttBy(R_7MNrjy~eriBev
> zd19MCeI?I%BYRilaLE(gQo~u9<-{tnLEJMltwG>LN6TelOd0+NPw3@...1656...{gEeFF
> zGc%MSE#gTOH-(jJ8nKT`R52MPoI1N6XZTGcuGFPvwSLOLaM6Y<g)4^x6%1Dn7Rwz;
> z1;gcXZspXgV7PLySnfzF7%rD{E2mxs!<B=3D@...1695...|3ZaJigYIrS<St{g0uJCX{9%jMk4
> hsaL^p<zTVgkyJ2TF6UNGy$Xga2aDy7#QdL1{tGA-a#jEU
>
> diff --git a/install-win32/.svnignore b/install-win32/.svnignore
> deleted file mode 100644
> index 9bf9495..0000000
> --- a/install-win32/.svnignore
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -*.o
> -Makefile.in
> -settings
> -Makefile
> diff --git a/install-win32/GetWindowsVersion.nsi b/install-win32/GetWindo=
wsVersion.nsi
> deleted file mode 100644
> index 103caff..0000000
> --- a/install-win32/GetWindowsVersion.nsi
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -; Turn off old selected section
> -; GetWindowsVersion
> -;
> -; Based on Yazno's function
> -; Updated by Joost Verburg
> -; Updated for Windows 98 SE by Matthew Win Tibbals 5-21-03
> -; Updated for Vista by Joe Cincotta 12-2-07
> -;
> -; Returns on top of stack
> -;
> -; Windows Version (95, 98, ME, NT x.x, 2000, XP, 2003, VISTA)
> -; or
> -; '' (Unknown Windows Version)
> -;
> -; Usage:
> -;   Call GetWindowsVersion
> -;   Pop $R0
> -;   ; at this point $R0 is "NT 4.0" or whatnot
> -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
> -Function GetWindowsVersion
> -
> -  Push $R0
> -  Push $R1
> -
> -  ClearErrors
> -
> -  ReadRegStr $R0 HKLM \
> -  "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
> -
> -  IfErrors 0 lbl_winnt
> -
> -  ; we are not NT
> -  ReadRegStr $R0 HKLM \
> -  "SOFTWARE\Microsoft\Windows\CurrentVersion" VersionNumber
> -
> -  StrCpy $R1 $R0 1
> -  StrCmp $R1 '4' 0 lbl_error
> -
> -  StrCpy $R1 $R0 3
> -
> -  StrCmp $R1 '4.0' lbl_win32_95
> -  StrCmp $R1 '4.9' lbl_win32_ME lbl_win32_98
> -
> -  lbl_win32_95:
> -    StrCpy $R0 '95'
> -  Goto lbl_done
> -
> -  lbl_win32_98:
> -;;beginning of additions to support win 98 SE
> -    push $R0
> -    push "."
> -    call strstr
> -    pop $R0
> -    StrCpy $R0 $R0 "" 1
> -    StrCmp $R0 "10.2222" lbl_win32_98SE
> -    StrCpy $R0 '98'  ;;this line was not added
> -  Goto lbl_done      ;;this line was not added either
> -
> -  lbl_win32_98SE:
> -    StrCpy $R0 '98 SE'
> -  Goto lbl_done
> -;;end of additions to support win 98 SE
> -  lbl_win32_ME:
> -    StrCpy $R0 'ME'
> -  Goto lbl_done
> -
> -  lbl_winnt:
> -
> -  StrCpy $R1 $R0 1
> -
> -  StrCmp $R1 '3' lbl_winnt_x
> -  StrCmp $R1 '4' lbl_winnt_x
> -
> -  StrCpy $R1 $R0 3
> -
> -  StrCmp $R1 '5.0' lbl_winnt_2000
> -  StrCmp $R1 '5.1' lbl_winnt_XP
> -  StrCmp $R1 '5.2' lbl_winnt_2003
> -  StrCmp $R1 '6.0' lbl_winnt_VISTA lbl_error
> -
> -  lbl_winnt_x:
> -    StrCpy $R0 "NT $R0" 6
> -  Goto lbl_done
> -
> -  lbl_winnt_2000:
> -    Strcpy $R0 '2000'
> -  Goto lbl_done
> -
> -  lbl_winnt_XP:
> -    Strcpy $R0 'XP'
> -  Goto lbl_done
> -
> -  lbl_winnt_2003:
> -    Strcpy $R0 '2003'
> -  Goto lbl_done
> -
> -  lbl_winnt_VISTA:
> -    Strcpy $R0 'VISTA'
> -  Goto lbl_done
> -
> -  lbl_error:
> -    Strcpy $R0 ''
> -  lbl_done:
> -
> -  Pop $R1
> -  Exch $R0
> -
> -FunctionEnd
> -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=
;;;;;;;;;;;;;;;;;;;;;;;
> diff --git a/install-win32/Makefile.am b/install-win32/Makefile.am
> deleted file mode 100644
> index 75932fe..0000000
> --- a/install-win32/Makefile.am
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -#
> -#  OpenVPN -- An application to securely tunnel IP networks
> -#             over a single UDP port, with support for SSL/TLS-based
> -#             session authentication and key exchange,
> -#             packet encryption, packet authentication, and
> -#             packet compression.
> -#
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> -#
> -#  This program is free software; you can redistribute it and/or modify
> -#  it under the terms of the GNU General Public License version 2
> -#  as published by the Free Software Foundation.
> -#
> -#  This program is distributed in the hope that it will be useful,
> -#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#  GNU General Public License for more details.
> -#
> -#  You should have received a copy of the GNU General Public License
> -#  along with this program (see the file COPYING included with this
> -#  distribution); if not, write to the Free Software Foundation, Inc.,
> -#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> -#
> -
> -MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in
> -
> -dist_noinst_DATA =3D \
> -       openssl \
> -       GetWindowsVersion.nsi \
> -       build-pkcs11-helper.sh \
> -       buildinstaller \
> -       ddk-common \
> -       doclean \
> -       dosname.pl \
> -       getgui \
> -       getopenssl \
> -       getpkcs11helper \
> -       getprebuilt \
> -       getxgui \
> -       ifdef.pl \
> -       m4todef.pl \
> -       macro.pl \
> -       makeopenvpn \
> -       maketap \
> -       maketapinstall \
> -       maketext \
> -       openvpn.nsi \
> -       setpath.nsi \
> -       settings.in \
> -       trans.pl \
> -       u2d.c \
> -       winconfig
> -
> -if WIN32
> -
> -nodist_doc_DATA =3D tmp/license.txt
> -
> -confdir =3D $(win32datadir)/config
> -nodist_conf_DATA =3D \
> -       tmp/openssl-1.0.0.cnf \
> -       tmp/client.ovpn \
> -       tmp/server.ovpn
> -dist_conf_DATA =3D \
> -       sample.ovpn
> -
> -easyrsadir =3D $(win32datadir)/easy-rsa/Windows
> -nodist_easyrsa_DATA =3D \
> -       $(top_srcdir)/easy-rsa/Windows/*
> -
> -keysdir =3D $(win32datadir)/sample-keys
> -nodist_keys_DATA =3D \
> -       $(top_srcdir)/sample-keys/*
> -
> -tmp:
> -       mkdir tmp
> -
> -tmp/client.ovpn:       tmp $(top_srcdir)/sample-config-files/client.conf
> -       cp $(top_srcdir)/sample-config-files/client.conf tmp/client.ovpn
> -
> -tmp/server.ovpn:       tmp $(top_srcdir)/sample-config-files/server.conf
> -       cp $(top_srcdir)/sample-config-files/server.conf tmp/server.ovpn
> -
> -tmp/license.txt:       tmp $(top_srcdir)/COPYING $(top_srcdir)/COPYRIGHT=
.GPL
> -       cat $(top_srcdir)/COPYING $(top_srcdir)/COPYRIGHT.GPL > tmp/licen=
se.txt
> -
> -tmp/openssl-1.0.0.cnf: tmp $(top_srcdir)/easy-rsa/2.0/openssl-1.0.0.cnf
> -       cp $(top_srcdir)/easy-rsa/2.0/openssl-1.0.0.cnf tmp/openssl-1.0.0=
.cnf
> -
> -clean-local:
> -       -rm -fr tmp
> -
> -else
> -
> -dist_noinst_DATA +=3D sample.ovpn
> -
> -endif
> -
> diff --git a/install-win32/build-pkcs11-helper.sh b/install-win32/build-p=
kcs11-helper.sh
> deleted file mode 100644
> index fd336df..0000000
> --- a/install-win32/build-pkcs11-helper.sh
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -F=3Dpkcs11-helper-1.06-beta1
> -OPENSSL_DIR=3D`pwd`/openssl-0.9.8h
> -
> -PKCS11_HELPER_DIR=3D`pwd`/pkcs11-helper
> -rm -rf $PKCS11_HELPER_DIR
> -mkdir $PKCS11_HELPER_DIR
> -tbz=3D$F.tar.bz2
> -
> -rm -rf $F
> -tar xfj $tbz
> -
> -cd $F
> -./configure \
> -       MAN2HTML=3Dtrue \
> -       --disable-crypto-engine-gnutls \
> -        --disable-crypto-engine-nss \
> -        PKG_CONFIG=3Dtrue \
> -        OPENSSL_CFLAGS=3D"-I${OPENSSL_DIR}/include" \
> -        OPENSSL_LIBS=3D"-L${OPENSSL_DIR}/out -leay32"
> -
> -make
> -make install DESTDIR=3D"${PKCS11_HELPER_DIR}"
> -
> -# ./configure doesn't need this any more: ac_cv_type_size_t=3Dno
> diff --git a/install-win32/buildinstaller b/install-win32/buildinstaller
> deleted file mode 100644
> index a17a027..0000000
> --- a/install-win32/buildinstaller
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -#!/bin/sh
> -
> -# load version.nsi definitions
> -. autodefs/defs.sh
> -
> -# build the installer
> -rm -f $GENOUT/*.exe
> -'/c/Program Files/NSIS/makensis' $GENOUT/nsi/openvpn.nsi &>makensis.log
> -tail -20 makensis.log
> -
> -# sign the installer
> -if [ -d "$SIGNTOOL" ]; then
> -    python $SIGNTOOL/signapp.py "$(echo $(pwd)/$GENOUT/*.exe)"
> -fi
> diff --git a/install-win32/ddk-common b/install-win32/ddk-common
> deleted file mode 100644
> index b45c9e5..0000000
> --- a/install-win32/ddk-common
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# DDKs <=3D 5600 use "AMD64", later use "x64"
> -x64_tag=3Dx64
> diff --git a/install-win32/doclean b/install-win32/doclean
> deleted file mode 100644
> index 3f39543..0000000
> --- a/install-win32/doclean
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#!/bin/sh
> -
> -# get version.nsi definitions
> -. autodefs/defs.sh
> -
> -[ "$CLEAN" =3D "yes" ] && rm -rf $GENOUT && KEEPAUTODEFS=3D"yes" ./docle=
an
> diff --git a/install-win32/dosname.pl b/install-win32/dosname.pl
> deleted file mode 100644
> index a678e66..0000000
> --- a/install-win32/dosname.pl
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -#!/usr/bin/perl
> -
> -# convert a unix filename to a DOS filename
> -
> -while ($unixname =3D shift(@ARGV)) {
> -  $unixname =3D~ s#^/([a-zA-Z])(/|$)#$1:\\#g;
> -  $unixname =3D~ s#/#\\#g;
> -  print "$unixname\n";
> -}
> diff --git a/install-win32/getgui b/install-win32/getgui
> deleted file mode 100644
> index aa83e85..0000000
> --- a/install-win32/getgui
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -#!/bin/sh
> -
> -# Get and sign the OpenVPN GUI
> -
> -# load version.nsi definitions
> -. autodefs/defs.sh
> -
> -GUI=3D"$OPENVPN_GUI_DIR/$OPENVPN_GUI"
> -
> -if [ -f "$GUI" ]; then
> -    mkdir -p $GENOUT/bin &>/dev/null
> -    cp $GUI $GENOUT/bin
> -fi
> -
> -if [ -f "$GENOUT/bin/$OPENVPN_GUI" ]; then
> -    echo '!define OPENVPN_GUI_DEFINED' >autodefs/guidefs.nsi
> -else
> -    cat /dev/null >autodefs/guidefs.nsi
> -fi
> diff --git a/install-win32/getopenssl b/install-win32/getopenssl
> deleted file mode 100644
> index b772741..0000000
> --- a/install-win32/getopenssl
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -#!/bin/sh
> -
> -# get version.nsi definitions
> -. autodefs/defs.sh
> -
> -# Get OpenSSL binaries
> -if [ -d "$OPENSSL_DIR" ] ; then
> -    mkdir -p $GENOUT/lib &>/dev/null
> -    mkdir -p $GENOUT/bin &>/dev/null
> -    for f in libeay32.dll libssl32.dll out/openssl.exe ; do
> -       cp $OPENSSL_DIR/$f $GENOUT/lib
> -        if [ -z "$NO_STRIP" ]; then
> -           strip $GENOUT/lib/`basename $f`
> -       fi
> -    done
> -    mv $GENOUT/lib/openssl.exe $GENOUT/bin
> -else
> -    echo OpenSSL DIR $OPENSSL_DIR NOT FOUND
> -fi
> diff --git a/install-win32/getpkcs11helper b/install-win32/getpkcs11helper
> deleted file mode 100644
> index 8fcfdd4..0000000
> --- a/install-win32/getpkcs11helper
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -#!/bin/sh
> -
> -# get version.nsi definitions
> -. autodefs/defs.sh
> -
> -# Get PKCS11-helper libraries
> -if [ -d "$PKCS11_HELPER_DIR" ] ; then
> -    mkdir -p $GENOUT/lib &>/dev/null
> -    for f in libpkcs11-helper-1.dll ; do
> -       cp $PKCS11_HELPER_DIR/usr/local/bin/$f $GENOUT/lib
> -        if [ -z "$NO_STRIP" ]; then
> -           strip $GENOUT/lib/$f
> -       fi
> -    done
> -else
> -    echo PKCS11-helper DIR $PKCS11_HELPER_DIR NOT FOUND
> -fi
> diff --git a/install-win32/getprebuilt b/install-win32/getprebuilt
> deleted file mode 100644
> index 36c4827..0000000
> --- a/install-win32/getprebuilt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#!/bin/sh
> -
> -# get version.nsi definitions
> -. autodefs/defs.sh
> -
> -# Get PKCS11-helper libraries
> -if [ -d "$GENOUT_PREBUILT" ] && ! [ -d "$GENOUT" ]; then
> -    echo LOADING prebuilt binaries from $GENOUT_PREBUILT
> -    cp -a $GENOUT_PREBUILT $GENOUT
> -fi
> diff --git a/install-win32/getxgui b/install-win32/getxgui
> deleted file mode 100644
> index 3a1e626..0000000
> --- a/install-win32/getxgui
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -#!/bin/sh
> -
> -# Get and sign the OpenVPN XML-based GUI
> -
> -# load version.nsi definitions
> -. autodefs/defs.sh
> -
> -if [ -d "$OPENVPN_XGUI_DIR" ]; then
> -    SIGNED_EXES=3D"gui/ovpn-xgui-en.exe sta/ovpn-tray.exe"
> -    UNSIGNED_EXES=3D"xmlserv/ovpn-xmlserv.exe"
> -    EXES=3D"$SIGNED_EXES $UNSIGNED_EXES"
> -
> -    mkdir -p $GENOUT/bin &>/dev/null
> -
> -    if [ -z "$NO_STRIP" ]; then
> -       for f in $EXES; do
> -           cp $OPENVPN_XGUI_DIR/$f $GENOUT/bin
> -           strip $GENOUT/bin/`basename $f`
> -       done
> -    fi
> -
> -    rm -rf $GENOUT/htdocs
> -    cp -a $OPENVPN_XGUI_DIR/ajax/htdocs $GENOUT/htdocs
> -
> -    echo '!define OPENVPN_XGUI_DEFINED' >autodefs/xguidefs.nsi
> -else
> -    cat /dev/null >autodefs/xguidefs.nsi
> -fi
> diff --git a/install-win32/ifdef.pl b/install-win32/ifdef.pl
> deleted file mode 100644
> index d240ebb..0000000
> --- a/install-win32/ifdef.pl
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -#!/usr/bin/perl
> -
> -# Simple ifdef/else/endif processor.
> -
> -die "usage: ifdef [-C<command-prefix>] [-Dname ...] [control-file ...] "=
 if (@ARGV[0] =3D~ /^(-h|--help)$/);
> -
> -%Parms =3D ();
> -
> -$pre =3D "!";
> -while ($arg=3Dshift(@ARGV)) {
> -    if ($arg =3D~ /^-/) {
> -       if ($arg =3D~ /^-D(\w+)$/) {
> -           $Parms{$1} =3D 1;
> -       } elsif ($arg =3D~ /-C(.*)$/) {
> -         $pre =3D $1;
> -       } else {
> -           die "unrecognized option: $arg";
> -       }
> -    } else {
> -       open(CONTROL, "< $arg") or die "cannot open $arg";
> -       while (<CONTROL>) {
> -           if (/^!define\s+(\w+)/) {
> -                $Parms{$1} =3D 1;
> -            }
> -        }
> -    }
> -}
> -
> -sub ifdef {
> -  my ($var, $enabled) =3D @_;
> -  my $def =3D 0;
> -  $def =3D 1 if (defined $Parms{$var}) || ($var eq "true");
> -  $def =3D 0 if $var eq "false";
> -  while (<STDIN>) {
> -    if (/^\s*\Q$pre\Eifdef\s+(\w+)\s*$/) {
> -      return 1 if ifdef ($1, $def & $enabled);
> -    } elsif (/^\s*\Q$pre\Eelseif\s+(\w+)\s*$/) {
> -      $def =3D $def ^ 1;
> -      return ifdef ($1, $def & $enabled);
> -    } elsif (/^\s*\Q$pre\Eelse\s*$/) {
> -      $def =3D $def ^ 1;
> -    } elsif (/^\s*\Q$pre\Eendif\s*$/) {
> -      return 0;
> -    } elsif (/^\s*\Q$pre\E/) {
> -      die "unrecognized command: $_";
> -    } else {
> -      print if $def && $enabled;
> -    }
> -  }
> -  return 1;
> -}
> -
> -ifdef("true", 1);
> diff --git a/install-win32/m4todef.pl b/install-win32/m4todef.pl
> deleted file mode 100644
> index d2705b0..0000000
> --- a/install-win32/m4todef.pl
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#!/usr/bin/perl
> -
> -# used to convert version.m4 to simple
> -# definition format
> -
> -while (<STDIN>) {
> -  chomp;
> -  if (/^\s*$/) {
> -    print "\n";
> -  } elsif (/^define\((\w+),\[(.*?)\]\)/) {
> -    print "!define $1 \"$2\"\n";
> -  } elsif (/^dnl(.*)$/) {
> -    print "#$1\n";
> -  }
> -}
> diff --git a/install-win32/macro.pl b/install-win32/macro.pl
> deleted file mode 100644
> index 08ba58a..0000000
> --- a/install-win32/macro.pl
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -#!/usr/bin/perl
> -
> -# Simple macro processor.
> -
> -# Macros are defined in a control file that follows
> -# a simple definition-based grammar as documented in the
> -# trans script.  Stdin is then copied to stdout, and any
> -# occurrence of @@MACRO@@ is substituted.  Macros can also
> -# be specified on the command line.
> -
> -die "usage: macro [-O<openquote>] [-C<closequote>] [-Dname=3Dvar ...] [c=
ontrol-file ...] " if (@ARGV < 1);
> -
> -%Parms =3D ();
> -$open_quote =3D "@@";
> -$close_quote =3D "@@";
> -
> -while ($arg=3Dshift(@ARGV)) {
> -  if ($arg =3D~ /^-/) {
> -    if ($arg =3D~ /^-D(\w+)(?:=3D(.*))?$/) {
> -      $Parms{$1} =3D $2
> -    } elsif ($arg =3D~ /-O(.*)$/) {
> -      $open_quote =3D $1;
> -    } elsif ($arg =3D~ /-C(.*)$/) {
> -      $close_quote =3D $1;
> -    } else {
> -      die "unrecognized option: $arg";
> -    }
> -  } else {
> -    open(CONTROL, "< $arg") or die "cannot open $arg";
> -    while (<CONTROL>) {
> -      if (/^!define\s+(\w+)(?:\s+['"]?(.*?)['"]?)?\s*$/) {
> -       $Parms{$1} =3D $2;
> -      }
> -    }
> -  }
> -}
> -
> -sub print_symbol_table {
> -  foreach my $k (sort (keys(%Parms))) {
> -    my $v =3D $Parms{$k};
> -    print "[$k] -> \"$v\"\n";
> -  }
> -}
> -
> -#print_symbol_table ();
> -#exit 0;
> -
> -while (<STDIN>) {
> -  s{
> -    \Q$open_quote\E
> -    \s*
> -    (
> -    \w+
> -   )
> -    \s*
> -    \Q$close_quote\E
> -  }{
> -    $Parms{$1}
> -  }xge;
> -  print;
> -}
> diff --git a/install-win32/makeopenvpn b/install-win32/makeopenvpn
> deleted file mode 100755
> index ced2a54..0000000
> --- a/install-win32/makeopenvpn
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -#!/bin/sh
> -
> -H=3D`pwd`
> -
> -case "`uname -o 2>/dev/null`" in
> -  *inux)
> -
> -    # cross-compiling, make dude's life easier
> -    XAUTOCONF=3D"--host=3Di586-mingw32msvc --build=3Di386-linux $XAUTOCO=
NF"
> -    export CC=3Di586-mingw32msvc-gcc
> -    export CXXCPP=3Di586-mingw32msvc-cpp
> -    export CXX=3Di586-mingw32msvc-g++
> -    # this requires the human to setup these environ vars:
> -    # OPENSSL_DIR LZO_DIR PKCS11_HELPER_DIR
> -    OPENSSL_INC_DIR=3D$OPENSSL_DIR/include
> -    OPENSSL_LIB_DIR=3D$OPENSSL_DIR/out
> -    LZO_INC_DIR=3D$LZO_DIR/include
> -    LZO_LIB_DIR=3D$LZO_DIR/src/.libs
> -    PKCS11_INC_DIR=3D$PKCS11_HELPER_DIR/include/pkcs11-helper-1.0/
> -    PKCS11_LIB_DIR=3D$PKCS11_HELPER_DIR/lib/.libs/
> -    ;;
> -  *)
> -    # get version.nsi definitions
> -    . autodefs/defs.sh
> -    XAUTOCONF=3D""
> -    # default configuration creates relative-path environ vars:
> -    OPENSSL_INC_DIR=3D$H/$OPENSSL_DIR/include
> -    OPENSSL_LIB_DIR=3D$H/$OPENSSL_DIR/out
> -    LZO_INC_DIR=3D$H/$LZO_DIR/include
> -    LZO_LIB_DIR=3D$H/$LZO_DIR
> -    PKCS11_INC_DIR=3D$H/$PKCS11_HELPER_DIR/usr/local/include
> -    PKCS11_LIB_DIR=3D$H/$PKCS11_HELPER_DIR/usr/local/lib
> -    ;;
> -esac
> -if $CC --version &>/dev/null && [ -d "$OPENSSL_DIR" ] && [ -d "$LZO_DIR"=
 ] && [ -d "$PKCS11_HELPER_DIR" ]; then
> -    # build OpenVPN binary
> -
> -    if ! [ -f Makefile ]; then
> -       autoreconf -i -v \
> -       && ./configure $XAUTOCONF \
> -           --enable-strict \
> -           --prefix=3D$H/windest \
> -           MAN2HTML=3Dtrue \
> -           --with-ssl-headers=3D$OPENSSL_INC_DIR \
> -           --with-ssl-lib=3D$OPENSSL_LIB_DIR \
> -           --with-lzo-headers=3D$LZO_INC_DIR \
> -           --with-lzo-lib=3D$LZO_LIB_DIR \
> -           --with-pkcs11-helper-headers=3D$PKCS11_INC_DIR \
> -           --with-pkcs11-helper-lib=3D$PKCS11_LIB_DIR \
> -           || exit 1
> -    fi
> -
> -    make -j $MAKE_JOBS && make install
> -
> -    if [ -n "$GENOOUT" ];then
> -    # copy OpenVPN and service executables to GENOUT/bin
> -      mkdir -p $GENOUT/bin &>/dev/null
> -      cp windest/sbin/openvpn.exe $GENOUT/bin
> -      cp windest/sbin/openvpnserv.exe $GENOUT/bin
> -      if [ -z "$NO_STRIP" ]; then
> -       strip $GENOUT/bin/openvpn.exe
> -       strip $GENOUT/bin/openvpnserv.exe
> -      fi
> -    fi
> -else
> -    echo DID NOT BUILD openvpn.exe and openvpnserv.exe because one or mo=
re of gcc, OPENSSL_DIR, LZO_DIR, or PKCS11_HELPER_DIR directories were miss=
ing
> -fi
> diff --git a/install-win32/maketap b/install-win32/maketap
> deleted file mode 100644
> index b9c4070..0000000
> --- a/install-win32/maketap
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -#!/bin/sh
> -
> -# Get the x86 and x64 versions of the TAP driver
> -
> -# get version.nsi definitions
> -. autodefs/defs.sh
> -
> -if [ -d "$TAPBINSRC" ]; then
> -    mkdir -p $GENOUT/driver/i386 &>/dev/null
> -    mkdir -p $GENOUT/driver/amd64 &>/dev/null
> -    for arch in i386 amd64; do
> -       s=3D$TAPBINSRC/$arch
> -       cp $s/*.sys $s/*.cat $s/*.inf $GENOUT/driver/$arch
> -    done
> -else
> -    echo Cannot find pre-built tap drivers
> -fi
> diff --git a/install-win32/maketapinstall b/install-win32/maketapinstall
> deleted file mode 100644
> index 9fe0470..0000000
> --- a/install-win32/maketapinstall
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#!/bin/sh
> -
> -# Get the x86 and x64 versions of the tapinstall tool
> -
> -# get version.nsi definitions
> -. autodefs/defs.sh
> -
> -if [ -d "$TAPBINSRC" ]; then
> -    mkdir -p $GENOUT/tapinstall/i386 &>/dev/null
> -    mkdir -p $GENOUT/tapinstall/amd64 &>/dev/null
> -    cp $TAPBINSRC/i386/tapinstall.exe $GENOUT/tapinstall/i386
> -    cp $TAPBINSRC/amd64/tapinstall.exe $GENOUT/tapinstall/amd64
> -else
> -    echo Cannot find pre-built tapinstall
> -fi
> diff --git a/install-win32/maketext b/install-win32/maketext
> deleted file mode 100644
> index 9a94a81..0000000
> --- a/install-win32/maketext
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -#!/bin/sh
> -
> -# get version.nsi definitions
> -. autodefs/defs.sh
> -
> -mkdir -p $GENOUT/text &>/dev/null
> -
> -# build license file
> -cat COPYING COPYRIGHT.GPL >$GENOUT/text/license.txt
> -
> -# copy install file
> -cp INSTALL-win32.txt $GENOUT/text/INSTALL-win32.txt
> -
> -# copy sample configuration files and docs
> -s=3D$GENOUT/samples
> -mkdir -p $s &>/dev/null
> -cp sample-config-files/client.conf $s/client.$PRODUCT_FILE_EXT
> -cp sample-config-files/server.conf $s/server.$PRODUCT_FILE_EXT
> -cp install-win32/sample.ovpn $s/sample.$PRODUCT_FILE_EXT
> -
> -# get easy-rsa (Windows)
> -e=3D$GENOUT/easy-rsa
> -mkdir -p $e &>/dev/null
> -cp easy-rsa/1.0/openssl.cnf $e/openssl.cnf.sample
> -cp easy-rsa/Windows/* $e
> -
> -# get images
> -i=3D$GENOUT/images
> -mkdir -p $i &>/dev/null
> -cp images/*.ico $i
> -cp images/*.bmp $i
> -
> -# get NSI files
> -n=3D$GENOUT/nsi
> -mkdir -p $n &>/dev/null
> -cp autodefs/defs.nsi $n
> -cp autodefs/guidefs.nsi $n
> -cp autodefs/xguidefs.nsi $n
> -cp install-win32/openvpn.nsi $n
> -cp install-win32/setpath.nsi $n
> -cp install-win32/GetWindowsVersion.nsi $n
> -
> -if [ -n "$EXTRACT_FILES" ]; then
> -    cp "$EXTRACT_FILES/MultiFileExtract.nsi" $n
> -fi
> -
> -# get OpenVPN client config files
> -if [ -n "$SAMPCONF_DIR" ]; then
> -    c=3D$GENOUT/conf
> -    mkdir -p $c &>/dev/null
> -    test -n "$SAMPCONF_CONF" && cp "../$SAMPCONF_DIR/$SAMPCONF_CONF" $c
> -    test -n "$SAMPCONF_CONF2" && cp "../$SAMPCONF_DIR/$SAMPCONF_CONF2" $c
> -    test -n "$SAMPCONF_P12" && cp "../$SAMPCONF_DIR/$SAMPCONF_P12" $c
> -    test -n "$SAMPCONF_TA" && cp "../$SAMPCONF_DIR/$SAMPCONF_TA" $c
> -    test -n "$SAMPCONF_CA" && cp "../$SAMPCONF_DIR/$SAMPCONF_CA" $c
> -    test -n "$SAMPCONF_CRT" && cp "../$SAMPCONF_DIR/$SAMPCONF_CRT" $c
> -    test -n "$SAMPCONF_KEY" && cp "../$SAMPCONF_DIR/$SAMPCONF_KEY" $c
> -    test -n "$SAMPCONF_DH" && cp "../$SAMPCONF_DIR/$SAMPCONF_DH" $c
> -fi
> diff --git a/install-win32/openssl/README.txt b/install-win32/openssl/REA=
DME.txt
> deleted file mode 100644
> index 6a042f4..0000000
> --- a/install-win32/openssl/README.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Rebuild OpenSSL tarball without symbolic links, so
> -it can be extracted on Windows (run on Unix):
> -
> -  [download tarball and .asc sig]
> -  gpg --verify openssl-0.9.8k.tar.gz.asc
> -  tar xfz openssl-0.9.8k.tar.gz
> -  tar cfzh openssl-0.9.8k-nolinks.tar.gz openssl-0.9.8k
> -
> -To apply patch (in MSYS shell):
> -
> -  cd /c/src/openssl-0.9.8k
> -  patch -p1 <../21/install-win32/openssl/openssl098.patch
> -
> -To build OpenSSL, open a command prompt window, then:
> -
> -  cd \src\openssl-0.9.8k
> -  ms\mw
> -
> -To build a new patch (optional):
> -
> -  diff -urw openssl-0.9.8k.orig openssl-0.9.8k | grep -v '^Only in' >ope=
nssl098.patch
> diff --git a/install-win32/openssl/openssl097.patch b/install-win32/opens=
sl/openssl097.patch
> deleted file mode 100644
> index ccef40a..0000000
> --- a/install-win32/openssl/openssl097.patch
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -[in msys bash window]
> -cd /c/src/openssl-0.9.7m
> -patch -p1 <../21/install-win32/openssl.patch
> -
> -[open command prompt window]
> -cd \src\openssl-0.9.7m
> -ms\mw
> -
> -diff -wur openssl-0.9.7m.orig/ms/mw.bat openssl-0.9.7m/ms/mw.bat
> ---- openssl-0.9.7m.orig/ms/mw.bat      Sat Feb 22 11:02:46 2003
> -+++ openssl-0.9.7m/ms/mw.bat   Mon Jan 21 23:12:34 2008
> -@@ -1,17 +1,23 @@
> - @rem OpenSSL with Mingw32
> - @rem --------------------
> -
> -+@rem Include MinGW, MSYS, and ActiveState Perl in path
> -+set PATH=3Dc:\perl\bin;c:\MinGW\bin;c:\msys\1.0\bin;C:\WINDOWS\system32=
;C:\WINDOWS;C:\WINDOWS\System32\Wbem
> -+
> - @rem Makefile
> - perl util\mkfiles.pl >MINFO
> --perl util\mk1mf.pl Mingw32 >ms\mingw32.mak
> -+perl util\mk1mf.pl no-idea no-mdc2 no-rc5 Mingw32 >ms\mingw32.mak
> -+
> - @rem DLL definition files
> --perl util\mkdef.pl 32 libeay >ms\libeay32.def
> -+perl util\mkdef.pl no-idea no-mdc2 no-rc5 32 libeay >ms\libeay32.def
> - if errorlevel 1 goto end
> --perl util\mkdef.pl 32 ssleay >ms\ssleay32.def
> -+perl util\mkdef.pl no-idea no-mdc2 no-rc5 32 ssleay >ms\ssleay32.def
> - if errorlevel 1 goto end
> -
> - @rem Build the libraries
> --make -f ms/mingw32.mak
> -+
> -+@rem JY added --win32 flag
> -+make --win32 -f ms/mingw32.mak
> - if errorlevel 1 goto end
> -
> - @rem Generate the DLLs and input libraries
> -@@ -20,7 +26,9 @@
> - dllwrap --dllname libssl32.dll --output-lib out/libssl32.a --def ms/ssl=
eay32.def out/libssl.a out/libeay32.a
> - if errorlevel 1 goto end
> -
> -+@rem JY added openssl.exe linked to DLL
> -+gcc -o openssl  tmp\verify.o tmp\asn1pars.o tmp\req.o tmp\dgst.o tmp\dh=
.o tmp\dhparam.o tmp\enc.o tmp\passwd.o tmp\gendh.o tmp\errstr.o tmp\ca.o t=
mp\pkcs7.o tmp\crl2p7.o tmp\crl.o tmp\rsa.o tmp\rsautl.o tmp\dsa.o tmp\dsap=
aram.o tmp\x509.o tmp\genrsa.o tmp\gendsa.o tmp\s_server.o tmp\s_client.o t=
mp\speed.o tmp\s_time.o tmp\apps.o tmp\s_cb.o tmp\s_socket.o tmp\app_rand.o=
 tmp\version.o tmp\sess_id.o tmp\ciphers.o tmp\nseq.o tmp\pkcs12.o tmp\pkcs=
8.o tmp\spkac.o tmp\smime.o tmp\rand.o tmp\engine.o tmp\ocsp.o tmp\prime.o =
tmp\openssl.o -leay32 -lssl32 -L. -lwsock32 -lgdi32
> -+
> - echo Done compiling OpenSSL
> -
> - :end
> --
> -diff -wur openssl-0.9.7m.orig/util/pl/Mingw32.pl openssl-0.9.7m/util/pl/=
Mingw32.pl
> ---- openssl-0.9.7m.orig/util/pl/Mingw32.pl     Sun May 16 23:28:32 2004
> -+++ openssl-0.9.7m/util/pl/Mingw32.pl  Mon Jan 21 17:52:36 2008
> -@@ -99,10 +99,10 @@
> -       $n=3D&bname($target);
> -       $ret.=3D"$target: $files $dep_libs\n";
> -       $ret.=3D"\t\$(LINK) ${efile}$target \$(LFLAGS) $files $libs\n";
> --      if (defined $sha1file)
> --              {
> --              $ret.=3D"\t$openssl sha1 -hmac etaonrishdlcupfm -binary $=
target > $sha1file";
> --              }
> -+#     if (defined $sha1file)
> -+#             {
> -+#             $ret.=3D"\t$openssl sha1 -hmac etaonrishdlcupfm -binary $=
target > $sha1file";
> -+#             }
> -       $ret.=3D"\n";
> -       return($ret);
> -       }
> diff --git a/install-win32/openssl/openssl098.patch b/install-win32/opens=
sl/openssl098.patch
> deleted file mode 100644
> index 653d2fe..0000000
> --- a/install-win32/openssl/openssl098.patch
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -diff -urw tmp/openssl-0.9.8h/crypto/pqueue/pqueue.c openssl-0.9.8h/crypt=
o/pqueue/pqueue.c
> ---- tmp/openssl-0.9.8h/crypto/pqueue/pqueue.c  Tue Jun 28 06:53:34 2005
> -+++ openssl-0.9.8h/crypto/pqueue/pqueue.c      Wed Jun  4 02:52:42 2008
> -@@ -199,10 +199,10 @@
> -       return found;
> -       }
> -
> --#if PQ_64BIT_IS_INTEGER
> - void
> - pqueue_print(pqueue_s *pq)
> -       {
> -+#if PQ_64BIT_IS_INTEGER
> -       pitem *item =3D pq->items;
> -
> -       while(item !=3D NULL)
> -@@ -210,8 +210,8 @@
> -               printf("item\t" PQ_64BIT_PRINT "\n", item->priority);
> -               item =3D item->next;
> -               }
> --      }
> - #endif
> -+      }
> -
> - pitem *
> - pqueue_iterator(pqueue_s *pq)
> -diff -urw tmp/openssl-0.9.8h/ms/mw.bat openssl-0.9.8h/ms/mw.bat
> ---- tmp/openssl-0.9.8h/ms/mw.bat       Sat Feb 22 11:00:10 2003
> -+++ openssl-0.9.8h/ms/mw.bat   Wed Jun  4 02:56:54 2008
> -@@ -1,17 +1,23 @@
> - @rem OpenSSL with Mingw32
> - @rem --------------------
> -
> -+@rem Include MinGW, MSYS, and ActiveState Perl in path
> -+set PATH=3Dc:\bin;C:\Perl\bin\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOW=
S\System32\Wbem;c:\MinGW\bin;c:\msys\1.0\bin
> -+
> - @rem Makefile
> - perl util\mkfiles.pl >MINFO
> --perl util\mk1mf.pl Mingw32 >ms\mingw32.mak
> -+perl util\mk1mf.pl no-idea no-mdc2 no-rc5 Mingw32 >ms\mingw32.mak
> -+
> - @rem DLL definition files
> --perl util\mkdef.pl 32 libeay >ms\libeay32.def
> -+perl util\mkdef.pl no-idea no-mdc2 no-rc5 32 libeay >ms\libeay32.def
> - if errorlevel 1 goto end
> --perl util\mkdef.pl 32 ssleay >ms\ssleay32.def
> -+perl util\mkdef.pl no-idea no-mdc2 no-rc5 32 ssleay >ms\ssleay32.def
> - if errorlevel 1 goto end
> -
> - @rem Build the libraries
> --make -f ms/mingw32.mak
> -+
> -+@rem JY added --win32
> -+make --win32 -f ms/mingw32.mak
> - if errorlevel 1 goto end
> -
> - @rem Generate the DLLs and input libraries
> diff --git a/install-win32/openvpn.nsi b/install-win32/openvpn.nsi
> deleted file mode 100755
> index f06c5aa..0000000
> --- a/install-win32/openvpn.nsi
> +++ /dev/null
> @@ -1,886 +0,0 @@
> -; **********************************************************************=
******
> -; * Copyright (C) 2002-2010 OpenVPN Technologies, Inc.                  =
          *
> -; *  This program is free software; you can redistribute it and/or modif=
y    *
> -; *  it under the terms of the GNU General Public License version 2     =
     *
> -; *  as published by the Free Software Foundation.                      =
     *
> -; **********************************************************************=
******
> -
> -; OpenVPN install script for Windows, using NSIS
> -
> -SetCompressor lzma
> -
> -!include "MUI.nsh"
> -
> -!include "defs.nsi"
> -!include "guidefs.nsi"
> -!include "xguidefs.nsi"
> -!include "setpath.nsi"
> -!include "GetWindowsVersion.nsi"
> -
> -!ifdef EXTRACT_FILES
> -!include "MultiFileExtract.nsi"
> -!endif
> -
> -!define GEN ".."
> -!define BIN "${GEN}\bin"
> -!define LIB "${GEN}\lib"
> -
> -; Which GUI to use (XGUI has priority).
> -; We will define either USE_XGUI (XML-based version) or
> -; USE_GUI (Mathias Sundman version) but not both.
> -!ifdef OPENVPN_XGUI_DEFINED
> -!define USE_XGUI
> -!else
> -!ifdef OPENVPN_GUI_DEFINED
> -!define USE_GUI
> -!endif
> -!endif
> -
> -!define PRODUCT_ICON "icon.ico"
> -
> -!ifdef USE_XGUI
> -!define XGUI_POSTFIX "X"
> -!else
> -!define XGUI_POSTFIX ""
> -!endif
> -
> -!ifdef PRODUCT_TAP_DEBUG
> -!define DBG_POSTFIX "-DBG"
> -!else
> -!define DBG_POSTFIX ""
> -!endif
> -
> -!define VERSION "${PRODUCT_VERSION}${XGUI_POSTFIX}${DBG_POSTFIX}"
> -
> -!define TAP "${PRODUCT_TAP_ID}"
> -!define TAPDRV "${TAP}.sys"
> -
> -; Default service settings
> -!define SERV_CONFIG_DIR   "$INSTDIR\config"
> -!define SERV_CONFIG_EXT   "${PRODUCT_FILE_EXT}"
> -!define SERV_EXE_PATH     "$INSTDIR\bin\${PRODUCT_UNIX_NAME}.exe"
> -!define SERV_LOG_DIR      "$INSTDIR\log"
> -!define SERV_PRIORITY     "NORMAL_PRIORITY_CLASS"
> -!define SERV_LOG_APPEND   "0"
> -
> -; XGUI variables
> -!define XGUI_EXE      ovpn-xgui-en.exe
> -!define XGUI_TRAY     ovpn-tray.exe
> -!define XGUI_XMLSERV  ovpn-xmlserv.exe
> -!define XGUI_HTDOCS   htdocs
> -
> -!define XGUI_AJAX_GUI_NAME       "${PRODUCT_NAME} Ajax GUI"
> -!define XGUI_TRANSITION_GUI_NAME "${PRODUCT_NAME} Transitional GUI"
> -
> -;--------------------------------
> -;Configuration
> -
> -  ;General
> -
> -  OutFile "${GEN}\${PRODUCT_UNIX_NAME}-${VERSION}${OUTFILE_LABEL}-instal=
l.exe"
> -
> -  ShowInstDetails show
> -  ShowUninstDetails show
> -
> -  ;Folder selection page
> -  InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
> -
> -  ;Remember install folder
> -  InstallDirRegKey HKCU "Software\${PRODUCT_NAME}" ""
> -
> -;--------------------------------
> -;Modern UI Configuration
> -
> -  Name "${PRODUCT_NAME} ${VERSION} ${TITLE_LABEL}"
> -
> -  !define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the i=
nstallation of ${PRODUCT_NAME}, an Open Source VPN package by James Yonan.\=
r\n\r\nNote that the Windows version of ${PRODUCT_NAME} will only run on Wi=
n 2000, XP, or higher.\r\n\r\n\r\n"
> -
> -  !define MUI_COMPONENTSPAGE_TEXT_TOP "Select the components to install/=
upgrade.  Stop any ${PRODUCT_NAME} processes or the ${PRODUCT_NAME} service=
 if it is running.  All DLLs are installed locally."
> -
> -  !define MUI_COMPONENTSPAGE_SMALLDESC
> -  !ifdef USE_XGUI
> -    !define MUI_FINISHPAGE_SHOWREADME "http://openvpn.net/"
> -    !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
> -  !else
> -    !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\INSTALL-win32.txt"
> -  !endif
> -  !define MUI_FINISHPAGE_NOAUTOCLOSE
> -  !define MUI_ABORTWARNING
> -  !define MUI_ICON "${GEN}\images\${PRODUCT_ICON}"
> -  !define MUI_UNICON "${GEN}\images\${PRODUCT_ICON}"
> -  !define MUI_HEADERIMAGE
> -  !define MUI_HEADERIMAGE_BITMAP "${GEN}\images\install-whirl.bmp"
> -  !define MUI_UNFINISHPAGE_NOAUTOCLOSE
> -
> -  !insertmacro MUI_PAGE_WELCOME
> -  !insertmacro MUI_PAGE_LICENSE "${GEN}\text\license.txt"
> -  !insertmacro MUI_PAGE_COMPONENTS
> -  !insertmacro MUI_PAGE_DIRECTORY
> -  !insertmacro MUI_PAGE_INSTFILES
> -  !insertmacro MUI_PAGE_FINISH
> -
> -  !insertmacro MUI_UNPAGE_CONFIRM
> -  !insertmacro MUI_UNPAGE_INSTFILES
> -  !insertmacro MUI_UNPAGE_FINISH
> -
> -
> -;--------------------------------
> -;Languages
> -
> -  !insertmacro MUI_LANGUAGE "English"
> -
> -;--------------------------------
> -;Language Strings
> -
> -  LangString DESC_SecOpenVPNUserSpace ${LANG_ENGLISH} "Install ${PRODUCT=
_NAME} user-space components, including ${PRODUCT_UNIX_NAME}.exe."
> -
> -!ifdef USE_GUI
> -  LangString DESC_SecOpenVPNGUI ${LANG_ENGLISH} "Install ${PRODUCT_NAME}=
 GUI by Mathias Sundman"
> -!endif
> -
> -!ifdef USE_XGUI
> -  LangString DESC_SecOpenVPNXGUI ${LANG_ENGLISH} "Install ${PRODUCT_NAME=
} XML-based GUI"
> -!endif
> -
> -  LangString DESC_SecOpenVPNEasyRSA ${LANG_ENGLISH} "Install ${PRODUCT_N=
AME} RSA scripts for X509 certificate management."
> -
> -  LangString DESC_SecOpenSSLDLLs ${LANG_ENGLISH} "Install OpenSSL DLLs l=
ocally (may be omitted if DLLs are already installed globally)."
> -
> -  LangString DESC_SecPKCS11DLLs ${LANG_ENGLISH} "Install PKCS#11 helper =
DLLs locally (may be omitted if DLLs are already installed globally)."
> -
> -  LangString DESC_SecTAP ${LANG_ENGLISH} "Install/Upgrade the TAP virtua=
l device driver.  Will not interfere with CIPE."
> -
> -  LangString DESC_SecService ${LANG_ENGLISH} "Install the ${PRODUCT_NAME=
} service wrapper (${PRODUCT_UNIX_NAME}serv.exe)"
> -
> -  LangString DESC_SecOpenSSLUtilities ${LANG_ENGLISH} "Install the OpenS=
SL Utilities (used for generating public/private key pairs)."
> -
> -  LangString DESC_SecAddPath ${LANG_ENGLISH} "Add ${PRODUCT_NAME} execut=
able directory to the current user's PATH."
> -
> -  LangString DESC_SecAddShortcuts ${LANG_ENGLISH} "Add ${PRODUCT_NAME} s=
hortcuts to the current user's Start Menu."
> -
> -  LangString DESC_SecFileAssociation ${LANG_ENGLISH} "Register ${PRODUCT=
_NAME} config file association (*.${SERV_CONFIG_EXT})"
> -
> -;--------------------------------
> -;Reserve Files
> -
> -  ;Things that need to be extracted on first (keep these lines before an=
y File command!)
> -  ;Only useful for BZIP2 compression
> -
> -  ReserveFile "${GEN}\images\install-whirl.bmp"
> -
> -;--------------------------------
> -;Macros
> -
> -!macro WriteRegStringIfUndef ROOT SUBKEY KEY VALUE
> -Push $R0
> -ReadRegStr $R0 "${ROOT}" "${SUBKEY}" "${KEY}"
> -StrCmp $R0 "" +1 +2
> -WriteRegStr "${ROOT}" "${SUBKEY}" "${KEY}" '${VALUE}'
> -Pop $R0
> -!macroend
> -
> -!macro DelRegStringIfUnchanged ROOT SUBKEY KEY VALUE
> -Push $R0
> -ReadRegStr $R0 "${ROOT}" "${SUBKEY}" "${KEY}"
> -StrCmp $R0 '${VALUE}' +1 +2
> -DeleteRegValue "${ROOT}" "${SUBKEY}" "${KEY}"
> -Pop $R0
> -!macroend
> -
> -!macro DelRegKeyIfUnchanged ROOT SUBKEY VALUE
> -Push $R0
> -ReadRegStr $R0 "${ROOT}" "${SUBKEY}" ""
> -StrCmp $R0 '${VALUE}' +1 +2
> -DeleteRegKey "${ROOT}" "${SUBKEY}"
> -Pop $R0
> -!macroend
> -
> -!macro DelRegKeyIfEmpty ROOT SUBKEY
> -Push $R0
> -EnumRegValue $R0 "${ROOT}" "${SUBKEY}" 1
> -StrCmp $R0 "" +1 +2
> -DeleteRegKey /ifempty "${ROOT}" "${SUBKEY}"
> -Pop $R0
> -!macroend
> -
> -;------------------------------------------
> -;Set reboot flag based on tapinstall return
> -
> -Function CheckReboot
> -  IntCmp $R0 1 "" noreboot noreboot
> -  IntOp $R0 0 & 0
> -  SetRebootFlag true
> -  DetailPrint "REBOOT flag set"
> - noreboot:
> -FunctionEnd
> -
> -;--------------------------------
> -;Installer Sections
> -
> -Function .onInit
> -  ClearErrors
> -
> -# Verify that user has admin privs
> -  UserInfo::GetName
> -  IfErrors ok
> -  Pop $R0
> -  UserInfo::GetAccountType
> -  Pop $R1
> -  StrCmp $R1 "Admin" ok
> -    Messagebox MB_OK "Administrator privileges required to install ${PRO=
DUCT_NAME} [$R0/$R1]"
> -    Abort
> -  ok:
> -
> -# Delete previous start menu
> -  RMDir /r $SMPROGRAMS\${PRODUCT_NAME}
> -
> -!ifdef CHECK_WINDOWS_VERSION
> -# Check windows version
> -  Call GetWindowsVersion
> -  Pop $1
> -  StrCmp $1 "2000" goodwinver
> -  StrCmp $1 "XP" goodwinver
> -  StrCmp $1 "2003" goodwinver
> -  StrCmp $1 "VISTA" goodwinver
> -
> -  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} does not currently support Wi=
ndows $1"
> -  Abort
> -
> -goodwinver:
> -  System::Call "kernel32::GetCurrentProcess() i .s"
> -  System::Call "kernel32::IsWow64Process(i s, *i .r0)"
> -  IntCmp $0 0 init32bits
> -
> -  ; we are running on 64-bit windows
> -  StrCmp $1 "VISTA" vista64bummer
> -
> -#  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} doesn't currently support 64=
-bit Windows."
> -#  Abort
> -
> -vista64bummer:
> -
> -#  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} doesn't currently support 64=
-bit Vista because Microsoft doesn't allow the installation of 64 bit unsig=
ned drivers."
> -#  Abort
> -
> -init32bits:
> -
> -!endif
> -
> -FunctionEnd
> -
> -!ifndef SF_SELECTED
> -!define SF_SELECTED 1
> -!endif
> -
> -;--------------------
> -;Pre-install section
> -
> -Section -pre
> -
> -  ; Stop OpenVPN if currently running
> -  DetailPrint "Previous Service REMOVE (if exists)"
> -  nsExec::ExecToLog '"$INSTDIR\bin\${PRODUCT_UNIX_NAME}serv.exe" -remove'
> -  Pop $R0 # return value/error/timeout
> -
> -!ifdef USE_XGUI
> -  DetailPrint "Previous XML Service REMOVE (if exists)"
> -  nsExec::ExecToLog '"$INSTDIR\bin\${XGUI_XMLSERV}" -remove'
> -  Pop $R0 # return value/error/timeout
> -!endif
> -
> -  Sleep 3000
> -
> -SectionEnd
> -
> -Section "${PRODUCT_NAME} User-Space Components" SecOpenVPNUserSpace
> -
> -  SetOverwrite on
> -  SetOutPath "$INSTDIR\bin"
> -
> -  File "${BIN}\${PRODUCT_UNIX_NAME}.exe"
> -
> -SectionEnd
> -
> -!ifdef USE_GUI
> -Section "${PRODUCT_NAME} GUI" SecOpenVPNGUI
> -
> -  SetOverwrite on
> -  SetOutPath "$INSTDIR\bin"
> -
> -  File "${BIN}\${OPENVPN_GUI}"
> -
> -SectionEnd
> -!endif
> -
> -!ifdef USE_XGUI
> -Section "${PRODUCT_NAME} XML-based GUI" SecOpenVPNXGUI
> -
> -  SetOverwrite on
> -
> -  SetOutPath "$INSTDIR\bin"
> -  File "${BIN}\${XGUI_EXE}"
> -  File "${BIN}\${XGUI_TRAY}"
> -  File "${BIN}\${XGUI_XMLSERV}"
> -
> -  SetOutPath "$INSTDIR\${XGUI_HTDOCS}"
> -  File "${GEN}\${XGUI_HTDOCS}\*.*"
> -
> -SectionEnd
> -!endif
> -
> -Section "${PRODUCT_NAME} RSA Certificate Management Scripts" SecOpenVPNE=
asyRSA
> -
> -  SetOverwrite on
> -  SetOutPath "$INSTDIR\easy-rsa"
> -
> -  File "${GEN}\easy-rsa\openssl-1.0.0.cnf"
> -  File "${GEN}\easy-rsa\vars.bat.sample"
> -
> -  File "${GEN}\easy-rsa\init-config.bat"
> -
> -  File "${GEN}\easy-rsa\README.txt"
> -  File "${GEN}\easy-rsa\build-ca.bat"
> -  File "${GEN}\easy-rsa\build-dh.bat"
> -  File "${GEN}\easy-rsa\build-key-server.bat"
> -  File "${GEN}\easy-rsa\build-key.bat"
> -  File "${GEN}\easy-rsa\build-key-pkcs12.bat"
> -  File "${GEN}\easy-rsa\clean-all.bat"
> -  File "${GEN}\easy-rsa\index.txt.start"
> -  File "${GEN}\easy-rsa\revoke-full.bat"
> -  File "${GEN}\easy-rsa\serial.start"
> -
> -SectionEnd
> -
> -Section "${PRODUCT_NAME} Service" SecService
> -
> -  SetOverwrite on
> -
> -  SetOutPath "$INSTDIR\bin"
> -  File "${BIN}\${PRODUCT_UNIX_NAME}serv.exe"
> -
> -  SetOutPath "$INSTDIR\config"
> -
> -  FileOpen $R0 "$INSTDIR\config\README.txt" w
> -  FileWrite $R0 "This directory should contain ${PRODUCT_NAME} configura=
tion files$\r$\n"
> -  FileWrite $R0 "each having an extension of .${SERV_CONFIG_EXT}$\r$\n"
> -  FileWrite $R0 "$\r$\n"
> -  FileWrite $R0 "When ${PRODUCT_NAME} is started as a service, a separat=
e ${PRODUCT_NAME}$\r$\n"
> -  FileWrite $R0 "process will be instantiated for each configuration fil=
e.$\r$\n"
> -  FileClose $R0
> -
> -  SetOutPath "$INSTDIR\sample-config"
> -  File "${GEN}\samples\sample.${SERV_CONFIG_EXT}"
> -  File "${GEN}\samples\client.${SERV_CONFIG_EXT}"
> -  File "${GEN}\samples\server.${SERV_CONFIG_EXT}"
> -
> -  CreateDirectory "$INSTDIR\log"
> -  FileOpen $R0 "$INSTDIR\log\README.txt" w
> -  FileWrite $R0 "This directory will contain the log files for ${PRODUCT=
_NAME}$\r$\n"
> -  FileWrite $R0 "sessions which are being run as a service.$\r$\n"
> -  FileClose $R0
> -
> -SectionEnd
> -
> -Section "${PRODUCT_NAME} File Associations" SecFileAssociation
> -SectionEnd
> -
> -Section "OpenSSL DLLs" SecOpenSSLDLLs
> -
> -  SetOverwrite on
> -  SetOutPath "$INSTDIR\bin"
> -  File "${LIB}\libeay32.dll"
> -  File "${LIB}\libssl32.dll"
> -
> -SectionEnd
> -
> -Section "OpenSSL Utilities" SecOpenSSLUtilities
> -
> -  SetOverwrite on
> -  SetOutPath "$INSTDIR\bin"
> -  File "${BIN}\openssl.exe"
> -
> -SectionEnd
> -
> -Section "PKCS#11 DLLs" SecPKCS11DLLs
> -
> -  SetOverwrite on
> -  SetOutPath "$INSTDIR\bin"
> -  File "${LIB}\libpkcs11-helper-1.dll"
> -
> -SectionEnd
> -
> -Section "TAP Virtual Ethernet Adapter" SecTAP
> -
> -  SetOverwrite on
> -
> -  FileOpen $R0 "$INSTDIR\bin\addtap.bat" w
> -  FileWrite $R0 "rem Add a new TAP virtual ethernet adapter$\r$\n"
> -  FileWrite $R0 '"$INSTDIR\bin\tapinstall.exe" install "$INSTDIR\driver\=
OemWin2k.inf" ${TAP}$\r$\n'
> -  FileWrite $R0 "pause$\r$\n"
> -  FileClose $R0
> -
> -  FileOpen $R0 "$INSTDIR\bin\deltapall.bat" w
> -  FileWrite $R0 "echo WARNING: this script will delete ALL TAP virtual a=
dapters (use the device manager to delete adapters one at a time)$\r$\n"
> -  FileWrite $R0 "pause$\r$\n"
> -  FileWrite $R0 '"$INSTDIR\bin\tapinstall.exe" remove ${TAP}$\r$\n'
> -  FileWrite $R0 "pause$\r$\n"
> -  FileClose $R0
> -
> -  ; Check if we are running on a 64 bit system.
> -  System::Call "kernel32::GetCurrentProcess() i .s"
> -  System::Call "kernel32::IsWow64Process(i s, *i .r0)"
> -  IntCmp $0 0 tap-32bit
> -
> -; tap-64bit:
> -
> -  DetailPrint "We are running on a 64-bit system."
> -
> -  SetOutPath "$INSTDIR\bin"
> -
> -  File "${GEN}\tapinstall\amd64\tapinstall.exe"
> -
> -  SetOutPath "$INSTDIR\driver"
> -
> -  File "${GEN}\driver\amd64\OemWin2k.inf"
> -  File "${GEN}\driver\amd64\${PRODUCT_TAP_ID}.cat"
> -  File "${GEN}\driver\amd64\${TAPDRV}"
> -
> -goto tapend
> -
> -tap-32bit:
> -
> -  DetailPrint "We are running on a 32-bit system."
> -
> -  SetOutPath "$INSTDIR\bin"
> -  File "${GEN}\tapinstall\i386\tapinstall.exe"
> -
> -  SetOutPath "$INSTDIR\driver"
> -  File "${GEN}\driver\i386\OemWin2k.inf"
> -  File "${GEN}\driver\i386\${PRODUCT_TAP_ID}.cat"
> -  File "${GEN}\driver\i386\${TAPDRV}"
> -
> -  tapend:
> -
> -SectionEnd
> -
> -Section "Add ${PRODUCT_NAME} to PATH" SecAddPath
> -
> -  ; remove previously set path (if any)
> -  Push "$INSTDIR\bin"
> -  Call RemoveFromPath
> -
> -  ; append our bin directory to end of current user path
> -  Push "$INSTDIR\bin"
> -  Call AddToPath
> -
> -SectionEnd
> -
> -Section "Add Shortcuts to Start Menu" SecAddShortcuts
> -
> -  SetOverwrite on
> -  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
> -  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}\Documentation"
> -  WriteINIStr "$SMPROGRAMS\${PRODUCT_NAME}\Documentation\${PRODUCT_NAME}=
 Windows Notes.url" "InternetShortcut" "URL" "http://openvpn.net/INSTALL-wi=
n32.html"
> -  WriteINIStr "$SMPROGRAMS\${PRODUCT_NAME}\Documentation\${PRODUCT_NAME}=
 Manual Page.url" "InternetShortcut" "URL" "http://openvpn.net/man.html"
> -  WriteINIStr "$SMPROGRAMS\${PRODUCT_NAME}\Documentation\${PRODUCT_NAME}=
 HOWTO.url" "InternetShortcut" "URL" "http://openvpn.net/howto.html"
> -  WriteINIStr "$SMPROGRAMS\${PRODUCT_NAME}\Documentation\${PRODUCT_NAME}=
 Web Site.url" "InternetShortcut" "URL" "http://openvpn.net/"
> -  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall ${PRODUCT_NAME}.=
lnk" "$INSTDIR\Uninstall.exe"
> -
> -SectionEnd
> -
> -;--------------------
> -;Post-install section
> -
> -Section -post
> -
> -  SetOverwrite on
> -
> -  ; delete old devcon.exe
> -  Delete "$INSTDIR\bin\devcon.exe"
> -
> -  ; Store README, license, icon
> -  SetOverwrite on
> -  SetOutPath $INSTDIR
> -  !ifndef USE_XGUI
> -    File "${GEN}\text\INSTALL-win32.txt"
> -  !endif
> -  File "${GEN}\text\license.txt"
> -  File "${GEN}\images\${PRODUCT_ICON}"
> -
> -  ; store sample config files
> -  !ifdef SAMPCONF_DIR
> -    SetOverwrite on
> -    SetOutPath "$INSTDIR\config"
> -  !ifdef SAMPCONF_CONF
> -    File "${GEN}\conf\${SAMPCONF_CONF}"
> -  !endif
> -  !ifdef SAMPCONF_CONF2
> -    File "${GEN}\conf\${SAMPCONF_CONF2}"
> -  !endif
> -  !ifdef SAMPCONF_P12
> -    File "${GEN}\conf\${SAMPCONF_P12}"
> -  !endif
> -  !ifdef SAMPCONF_TA
> -    File "${GEN}\conf\${SAMPCONF_TA}"
> -  !endif
> -  !ifdef SAMPCONF_CA
> -    File "${GEN}\conf\${SAMPCONF_CA}"
> -  !endif
> -  !ifdef SAMPCONF_CRT
> -    File "${GEN}\conf\${SAMPCONF_CRT}"
> -  !endif
> -  !ifdef SAMPCONF_KEY
> -    File "${GEN}\conf\${SAMPCONF_KEY}"
> -  !endif
> -  !ifdef SAMPCONF_DH
> -    File "${GEN}\conf\${SAMPCONF_DH}"
> -  !endif
> -  !endif
> -
> -  ; Try to extract files if present
> -  !ifdef EXTRACT_FILES
> -    Push "$INSTDIR"
> -    Call MultiFileExtract
> -    Pop $R0
> -    IntCmp $R0 0 +3 +1 +1
> -    DetailPrint "MultiFileExtract Failed status=3D$R0"
> -    goto +2
> -    DetailPrint "MultiFileExtract Succeeded"
> -  !endif
> -
> -  ;
> -  ; install/upgrade TAP driver if selected, using tapinstall.exe
> -  ;
> -  SectionGetFlags ${SecTAP} $R0
> -  IntOp $R0 $R0 & ${SF_SELECTED}
> -  IntCmp $R0 ${SF_SELECTED} "" notap notap
> -    ; TAP install/update was selected.
> -    ; Should we install or update?
> -    ; If tapinstall error occurred, $5 will
> -    ; be nonzero.
> -    IntOp $5 0 & 0
> -    nsExec::ExecToStack '"$INSTDIR\bin\tapinstall.exe" hwids ${TAP}'
> -    Pop $R0 # return value/error/timeout
> -    IntOp $5 $5 | $R0
> -    DetailPrint "tapinstall hwids returned: $R0"
> -
> -    ; If tapinstall output string contains "${TAP}" we assume
> -    ; that TAP device has been previously installed,
> -    ; therefore we will update, not install.
> -    Push "${TAP}"
> -    Call StrStr
> -    Pop $R0
> -
> -    IntCmp $5 0 "" tapinstall_check_error tapinstall_check_error
> -    IntCmp $R0 -1 tapinstall
> -
> - ;tapupdate:
> -    DetailPrint "TAP UPDATE"
> -    nsExec::ExecToLog '"$INSTDIR\bin\tapinstall.exe" update "$INSTDIR\dr=
iver\OemWin2k.inf" ${TAP}'
> -    Pop $R0 # return value/error/timeout
> -    Call CheckReboot
> -    IntOp $5 $5 | $R0
> -    DetailPrint "tapinstall update returned: $R0"
> -    Goto tapinstall_check_error
> -
> - tapinstall:
> -    DetailPrint "TAP REMOVE OLD TAP"
> -
> -    nsExec::ExecToLog '"$INSTDIR\bin\tapinstall.exe" remove TAP0801'
> -    Pop $R0 # return value/error/timeout
> -    DetailPrint "tapinstall remove TAP0801 returned: $R0"
> -
> -    DetailPrint "TAP INSTALL (${TAP})"
> -    nsExec::ExecToLog '"$INSTDIR\bin\tapinstall.exe" install "$INSTDIR\d=
river\OemWin2k.inf" ${TAP}'
> -    Pop $R0 # return value/error/timeout
> -    Call CheckReboot
> -    IntOp $5 $5 | $R0
> -    DetailPrint "tapinstall install returned: $R0"
> -
> - tapinstall_check_error:
> -    DetailPrint "tapinstall cumulative status: $5"
> -    IntCmp $5 0 notap
> -    MessageBox MB_OK "An error occurred installing the TAP device driver=
."
> -
> - notap:
> -
> -  ; Store install folder in registry
> -  WriteRegStr HKLM SOFTWARE\${PRODUCT_NAME} "" $INSTDIR
> -
> -  ; install as a service if requested
> -  SectionGetFlags ${SecService} $R0
> -  IntOp $R0 $R0 & ${SF_SELECTED}
> -  IntCmp $R0 ${SF_SELECTED} "" noserv noserv
> -
> -    ; set registry parameters for openvpnserv
> -    !insertmacro WriteRegStringIfUndef HKLM "SOFTWARE\${PRODUCT_NAME}" "=
config_dir"  "${SERV_CONFIG_DIR}"
> -    !insertmacro WriteRegStringIfUndef HKLM "SOFTWARE\${PRODUCT_NAME}" "=
config_ext"  "${SERV_CONFIG_EXT}"
> -    !insertmacro WriteRegStringIfUndef HKLM "SOFTWARE\${PRODUCT_NAME}" "=
exe_path"    "${SERV_EXE_PATH}"
> -    !insertmacro WriteRegStringIfUndef HKLM "SOFTWARE\${PRODUCT_NAME}" "=
log_dir"     "${SERV_LOG_DIR}"
> -    !insertmacro WriteRegStringIfUndef HKLM "SOFTWARE\${PRODUCT_NAME}" "=
priority"    "${SERV_PRIORITY}"
> -    !insertmacro WriteRegStringIfUndef HKLM "SOFTWARE\${PRODUCT_NAME}" "=
log_append"  "${SERV_LOG_APPEND}"
> -
> -    ; install openvpnserv as a service (to be started manually from serv=
ice control manager)
> -    DetailPrint "Service INSTALL"
> -    nsExec::ExecToLog '"$INSTDIR\bin\${PRODUCT_UNIX_NAME}serv.exe" -inst=
all'
> -    Pop $R0 # return value/error/timeout
> -
> - noserv:
> -  !ifdef USE_XGUI
> -    IfFileExists "$INSTDIR\bin\${XGUI_XMLSERV}" "" fileass
> -      ; install and automatically start XML service
> -      DetailPrint "XML Service INSTALL"
> -      nsExec::ExecToLog '"$INSTDIR\bin\${XGUI_XMLSERV}" -install'
> -      Pop $R0 # return value/error/timeout
> -
> -      Sleep 2000
> -
> -      DetailPrint "XML Service START"
> -      nsExec::ExecToLog '"$INSTDIR\bin\${XGUI_XMLSERV}" -start'
> -      Pop $R0 # return value/error/timeout
> -
> -  !endif
> -
> -  ; Create file association if requested
> - fileass:
> -  SectionGetFlags ${SecFileAssociation} $R0
> -  IntOp $R0 $R0 & ${SF_SELECTED}
> -  IntCmp $R0 ${SF_SELECTED} "" noass noass
> -    WriteRegStr HKCR ".${SERV_CONFIG_EXT}" "" "${PRODUCT_NAME}File"
> -    WriteRegStr HKCR "${PRODUCT_NAME}File" "" "${PRODUCT_NAME} Config Fi=
le"
> -    WriteRegStr HKCR "${PRODUCT_NAME}File\shell" "" "open"
> -    WriteRegStr HKCR "${PRODUCT_NAME}File\DefaultIcon" "" "$INSTDIR\${PR=
ODUCT_ICON},0"
> -    WriteRegStr HKCR "${PRODUCT_NAME}File\shell\open\command" "" 'notepa=
d.exe "%1"'
> -    WriteRegStr HKCR "${PRODUCT_NAME}File\shell\run" "" "Start ${PRODUCT=
_NAME} on this config file"
> -    WriteRegStr HKCR "${PRODUCT_NAME}File\shell\run\command" "" '"$INSTD=
IR\bin\${PRODUCT_UNIX_NAME}.exe" --pause-exit --config "%1"'
> -
> -  ; Create start menu folders
> - noass:
> -  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}\Utilities"
> -  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}\Shortcuts"
> -
> -  ; Create start menu and desktop shortcuts to OpenVPN GUI
> -  !ifdef USE_GUI
> -    IfFileExists "$INSTDIR\bin\${OPENVPN_GUI}" "" tryaddxgui
> -      CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME} GUI.ln=
k" "$INSTDIR\bin\${OPENVPN_GUI}" ""
> -      CreateShortcut "$DESKTOP\${PRODUCT_NAME} GUI.lnk" "$INSTDIR\bin\${=
OPENVPN_GUI}"
> -  !endif
> -
> -  ; Create start menu and desktop shortcuts to OpenVPN XGUI
> - tryaddxgui:
> -  !ifdef USE_XGUI
> -    IfFileExists "$INSTDIR\bin\${XGUI_EXE}" "" tryaddtray
> -      CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${XGUI_TRANSITION_GUI_=
NAME}.lnk" "$INSTDIR\bin\${XGUI_EXE}" ""
> -#      CreateShortcut "$DESKTOP\${XGUI_TRANSITION_GUI_NAME}.lnk" "$INSTD=
IR\bin\${XGUI_EXE}"
> - tryaddtray:
> -    IfFileExists "$INSTDIR\bin\${XGUI_TRAY}" "" tryaddtap
> -      CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${XGUI_AJAX_GUI_NAME}.=
lnk" "$INSTDIR\bin\${XGUI_EXE}" ""
> -      CreateShortcut "$DESKTOP\${XGUI_AJAX_GUI_NAME}.lnk" "$INSTDIR\bin\=
${XGUI_TRAY}"
> -  !endif
> -
> -    ; Create start menu shortcuts to addtap.bat and deltapall.bat
> - tryaddtap:
> -    IfFileExists "$INSTDIR\bin\addtap.bat" "" trydeltap
> -      CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Utilities\Add a new TA=
P virtual ethernet adapter.lnk" "$INSTDIR\bin\addtap.bat" ""
> -
> - trydeltap:
> -    IfFileExists "$INSTDIR\bin\deltapall.bat" "" config_shortcut
> -      CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Utilities\Delete ALL T=
AP virtual ethernet adapters.lnk" "$INSTDIR\bin\deltapall.bat" ""
> -
> -    ; Create start menu shortcuts for config and log directories
> - config_shortcut:
> -    IfFileExists "$INSTDIR\config" "" log_shortcut
> -      CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Shortcuts\${PRODUCT_NA=
ME} configuration file directory.lnk" "$INSTDIR\config" ""
> -
> - log_shortcut:
> -    IfFileExists "$INSTDIR\log" "" samp_shortcut
> -      CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Shortcuts\${PRODUCT_NA=
ME} log file directory.lnk" "$INSTDIR\log" ""
> -
> - samp_shortcut:
> -    IfFileExists "$INSTDIR\sample-config" "" genkey_shortcut
> -      CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Shortcuts\${PRODUCT_NA=
ME} Sample Configuration Files.lnk" "$INSTDIR\sample-config" ""
> -
> - genkey_shortcut:
> -    IfFileExists "$INSTDIR\bin\${PRODUCT_UNIX_NAME}.exe" "" noshortcuts
> -      IfFileExists "$INSTDIR\config" "" noshortcuts
> -        CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Utilities\Generate a=
 static ${PRODUCT_NAME} key.lnk" "$INSTDIR\bin\${PRODUCT_UNIX_NAME}.exe" '-=
-pause-exit --verb 3 --genkey --secret "$INSTDIR\config\key.txt"' "$INSTDIR=
\${PRODUCT_ICON}" 0
> -
> - noshortcuts:
> -  ; Create uninstaller
> -  WriteUninstaller "$INSTDIR\Uninstall.exe"
> -
> -  ; Show up in Add/Remove programs
> -  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\=
${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME} ${VERSION}"
> -  WriteRegExpandStr HKLM "Software\Microsoft\Windows\CurrentVersion\Unin=
stall\${PRODUCT_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
> -  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\=
${PRODUCT_NAME}" "DisplayIcon" "$INSTDIR\${PRODUCT_ICON}"
> -  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\=
${PRODUCT_NAME}" "DisplayVersion" "${VERSION}"
> -
> -  ; Advise a reboot
> -  ;Messagebox MB_OK "IMPORTANT: Rebooting the system is advised in order=
 to finalize TAP driver installation/upgrade (this is an informational mess=
age only, pressing OK will not reboot)."
> -
> -SectionEnd
> -
> -;--------------------------------
> -;Descriptions
> -
> -!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenVPNUserSpace} $(DESC_SecOpe=
nVPNUserSpace)
> -  !ifdef USE_GUI
> -    !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenVPNGUI} $(DESC_SecOpenVPN=
GUI)
> -  !endif
> -  !ifdef USE_XGUI
> -    !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenVPNXGUI} $(DESC_SecOpenVP=
NXGUI)
> -  !endif
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenVPNEasyRSA} $(DESC_SecOpenV=
PNEasyRSA)
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecTAP} $(DESC_SecTAP)
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenSSLUtilities} $(DESC_SecOpe=
nSSLUtilities)
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenSSLDLLs} $(DESC_SecOpenSSLD=
LLs)
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecPKCS11DLLs} $(DESC_SecPKCS11DLL=
s)
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecAddPath} $(DESC_SecAddPath)
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecAddShortcuts} $(DESC_SecAddShor=
tcuts)
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecService} $(DESC_SecService)
> -  !insertmacro MUI_DESCRIPTION_TEXT ${SecFileAssociation} $(DESC_SecFile=
Association)
> -!insertmacro MUI_FUNCTION_DESCRIPTION_END
> -
> -;--------------------------------
> -;Uninstaller Section
> -
> -Function un.onInit
> -  ClearErrors
> -  UserInfo::GetName
> -  IfErrors ok
> -  Pop $R0
> -  UserInfo::GetAccountType
> -  Pop $R1
> -  StrCmp $R1 "Admin" ok
> -    Messagebox MB_OK "Administrator privileges required to uninstall ${P=
RODUCT_NAME} [$R0/$R1]"
> -    Abort
> -  ok:
> -FunctionEnd
> -
> -Section "Uninstall"
> -
> -!ifdef USE_XGUI
> -  DetailPrint "XML Service REMOVE"
> -  nsExec::ExecToLog '"$INSTDIR\bin\${XGUI_XMLSERV}" -remove'
> -  Pop $R0 # return value/error/timeout
> -!endif
> -
> -  ; Stop OpenVPN if currently running
> -  DetailPrint "Service REMOVE"
> -  nsExec::ExecToLog '"$INSTDIR\bin\${PRODUCT_UNIX_NAME}serv.exe" -remove'
> -  Pop $R0 # return value/error/timeout
> -
> -  Sleep 3000
> -
> -  DetailPrint "TAP REMOVE"
> -  nsExec::ExecToLog '"$INSTDIR\bin\tapinstall.exe" remove ${TAP}'
> -  Pop $R0 # return value/error/timeout
> -  DetailPrint "tapinstall remove returned: $R0"
> -
> -  Push "$INSTDIR\bin"
> -  Call un.RemoveFromPath
> -
> -  RMDir /r $SMPROGRAMS\${PRODUCT_NAME}
> -
> -  ; delete sample config files
> -  !ifdef SAMPCONF_DIR
> -  !ifdef SAMPCONF_CONF
> -    Delete "$INSTDIR\config\${SAMPCONF_CONF}"
> -  !endif
> -  !ifdef SAMPCONF_CONF2
> -    Delete "$INSTDIR\config\${SAMPCONF_CONF2}"
> -  !endif
> -  !ifdef SAMPCONF_P12
> -    Delete "$INSTDIR\config\${SAMPCONF_P12}"
> -  !endif
> -  !ifdef SAMPCONF_TA
> -    Delete "$INSTDIR\config\${SAMPCONF_TA}"
> -  !endif
> -  !ifdef SAMPCONF_CA
> -    Delete "$INSTDIR\config\${SAMPCONF_CA}"
> -  !endif
> -  !ifdef SAMPCONF_CRT
> -    Delete "$INSTDIR\config\${SAMPCONF_CRT}"
> -  !endif
> -  !ifdef SAMPCONF_KEY
> -    Delete "$INSTDIR\config\${SAMPCONF_KEY}"
> -  !endif
> -  !ifdef SAMPCONF_DH
> -    Delete "$INSTDIR\config\${SAMPCONF_DH}"
> -  !endif
> -  !endif
> -
> -  !ifdef USE_GUI
> -    Delete "$INSTDIR\bin\${OPENVPN_GUI}"
> -    Delete "$DESKTOP\${PRODUCT_NAME} GUI.lnk"
> -  !endif
> -
> -  !ifdef USE_XGUI
> -    Delete "$INSTDIR\bin\${XGUI_EXE}"
> -    Delete "$INSTDIR\bin\${XGUI_TRAY}"
> -    Delete "$INSTDIR\bin\${XGUI_XMLSERV}"
> -    RMDir /r "$INSTDIR\${XGUI_HTDOCS}"
> -    Delete "$DESKTOP\${XGUI_AJAX_GUI_NAME}.lnk"
> -    Delete "$DESKTOP\${XGUI_TRANSITION_GUI_NAME}.lnk"
> -  !endif
> -
> -  Delete "$INSTDIR\bin\${PRODUCT_UNIX_NAME}.exe"
> -  Delete "$INSTDIR\bin\${PRODUCT_UNIX_NAME}serv.exe"
> -  Delete "$INSTDIR\bin\libeay32.dll"
> -  Delete "$INSTDIR\bin\libssl32.dll"
> -  Delete "$INSTDIR\bin\libpkcs11-helper-1.dll"
> -  Delete "$INSTDIR\bin\tapinstall.exe"
> -  Delete "$INSTDIR\bin\addtap.bat"
> -  Delete "$INSTDIR\bin\deltapall.bat"
> -
> -  Delete "$INSTDIR\config\README.txt"
> -  Delete "$INSTDIR\config\sample.${SERV_CONFIG_EXT}.txt"
> -
> -  Delete "$INSTDIR\log\README.txt"
> -
> -  Delete "$INSTDIR\driver\OemWin2k.inf"
> -  Delete "$INSTDIR\driver\${PRODUCT_TAP_ID}.cat"
> -  Delete "$INSTDIR\driver\${TAPDRV}"
> -
> -  Delete "$INSTDIR\bin\openssl.exe"
> -
> -  Delete "$INSTDIR\INSTALL-win32.txt"
> -  Delete "$INSTDIR\${PRODUCT_ICON}"
> -  Delete "$INSTDIR\license.txt"
> -  Delete "$INSTDIR\Uninstall.exe"
> -
> -  Delete "$INSTDIR\easy-rsa\openssl-1.0.0.cnf"
> -  Delete "$INSTDIR\easy-rsa\vars.bat.sample"
> -  Delete "$INSTDIR\easy-rsa\init-config.bat"
> -  Delete "$INSTDIR\easy-rsa\README.txt"
> -  Delete "$INSTDIR\easy-rsa\build-ca.bat"
> -  Delete "$INSTDIR\easy-rsa\build-dh.bat"
> -  Delete "$INSTDIR\easy-rsa\build-key-server.bat"
> -  Delete "$INSTDIR\easy-rsa\build-key.bat"
> -  Delete "$INSTDIR\easy-rsa\build-key-pkcs12.bat"
> -  Delete "$INSTDIR\easy-rsa\clean-all.bat"
> -  Delete "$INSTDIR\easy-rsa\index.txt.start"
> -  Delete "$INSTDIR\easy-rsa\revoke-key.bat"
> -  Delete "$INSTDIR\easy-rsa\revoke-full.bat"
> -  Delete "$INSTDIR\easy-rsa\serial.start"
> -
> -  Delete "$INSTDIR\sample-config\*.${PRODUCT_FILE_EXT}"
> -
> -  RMDir "$INSTDIR\bin"
> -  RMDir "$INSTDIR\config"
> -  RMDir "$INSTDIR\driver"
> -  RMDir "$INSTDIR\easy-rsa"
> -  RMDir "$INSTDIR\sample-config"
> -  RMDir /r "$INSTDIR\log"
> -  RMDir "$INSTDIR"
> -
> -  !insertmacro DelRegKeyIfUnchanged HKCR ".${SERV_CONFIG_EXT}" "${PRODUC=
T_NAME}File"
> -  DeleteRegKey HKCR "${PRODUCT_NAME}File"
> -  DeleteRegKey HKLM SOFTWARE\${PRODUCT_NAME}
> -  DeleteRegKey HKCU "Software\${PRODUCT_NAME}"
> -  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall=
\${PRODUCT_NAME}"
> -
> -  ;Messagebox MB_OK "IMPORTANT: If you intend on reinstalling ${PRODUCT_=
NAME} after this uninstall, and you are running Win2K, you are strongly urg=
ed to reboot before reinstalling (this is an informational message only, pr=
essing OK will not reboot)."
> -
> -SectionEnd
> diff --git a/install-win32/setpath.nsi b/install-win32/setpath.nsi
> deleted file mode 100755
> index a9626c3..0000000
> --- a/install-win32/setpath.nsi
> +++ /dev/null
> @@ -1,231 +0,0 @@
> -; Modify the user's PATH variable.
> -;
> -; Modified by JY to have both a RemoveFromPath
> -; and an un.RemoveFromPath which are basically
> -; copies of each other.  Why does NSIS demand
> -; this nonsense?
> -;
> -; Modified Feb 14, 2005 by Mathias Sundman:
> -;   Added code to remove the semicolon at the end of the path
> -;   when uninstalling.
> -;
> -;   Added code to make sure we don't insert an extra semicolon
> -;   before our path if there already exist one at the end of
> -;   the original path.
> -;
> -;   Removed duplicated "un. and install" functions and made
> -;   macros to duplicate the code instead.
> -
> -; example usage
> -;
> -;Section "Add to path"
> -;  Push $INSTDIR
> -;  Call AddToPath
> -;SectionEnd
> -;
> -;# ...
> -;
> -;Section "uninstall"
> -;  # ...
> -;  Push $INSTDIR
> -;  Call un.RemoveFromPath
> -;  # ...
> -;SectionEnd
> -
> -!verbose 3
> -!include "WinMessages.NSH"
> -!verbose 4
> -
> -;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -; AddToPath - Adds the given dir to the search path.
> -;        Input - head of the stack
> -;        Note - Win9x systems requires reboot
> -;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -Function AddToPath
> -  Exch $0
> -  Push $1
> -  Push $2
> -
> -  Call IsNT
> -  Pop $1
> -  StrCmp $1 1 AddToPath_NT
> -    ; Not on NT
> -    StrCpy $1 $WINDIR 2
> -    FileOpen $1 "$1\autoexec.bat" a
> -    FileSeek $1 0 END
> -    GetFullPathName /SHORT $0 $0
> -    FileWrite $1 "$\r$\nSET PATH=3D%PATH%;$0$\r$\n"
> -    FileClose $1
> -    Goto AddToPath_done
> -
> -  AddToPath_NT:
> -    ReadRegStr $1 HKCU "Environment" "PATH"
> -    StrCpy $2 $1 1 -1 # copy last char
> -    StrCmp $2 ";" 0 +2 # if last char =3D=3D ;
> -      StrCpy $1 $1 -1 # remove last char
> -
> -    StrCmp $1 "" AddToPath_NTdoIt
> -      StrCpy $0 "$1;$0"
> -      Goto AddToPath_NTdoIt
> -    AddToPath_NTdoIt:
> -      WriteRegExpandStr HKCU "Environment" "PATH" $0
> -      SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environmen=
t" /TIMEOUT=3D5000
> -
> -  AddToPath_done:
> -    Pop $2
> -    Pop $1
> -    Pop $0
> -FunctionEnd
> -
> -;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -; RemoveFromPath - Remove a given dir from the path
> -;     Input: head of the stack
> -;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -!macro RemoveFromPath un
> -Function ${un}RemoveFromPath
> -  Exch $0
> -  Push $1
> -  Push $2
> -  Push $3
> -  Push $4
> -  Push $5
> -
> -  Call ${un}IsNT
> -  Pop $1
> -  StrCmp $1 1 RemoveFromPath_NT
> -    ; Not on NT
> -    StrCpy $1 $WINDIR 2
> -    FileOpen $1 "$1\autoexec.bat" r
> -    GetTempFileName $4
> -    FileOpen $2 $4 w
> -    GetFullPathName /SHORT $0 $0
> -    StrCpy $0 "SET PATH=3D%PATH%;$0"
> -    SetRebootFlag true
> -    Goto RemoveFromPath_dosLoop
> -
> -    RemoveFromPath_dosLoop:
> -      FileRead $1 $3
> -      StrCmp $3 "$0$\r$\n" RemoveFromPath_dosLoop
> -      StrCmp $3 "$0$\n" RemoveFromPath_dosLoop
> -      StrCmp $3 "$0" RemoveFromPath_dosLoop
> -      StrCmp $3 "" RemoveFromPath_dosLoopEnd
> -      FileWrite $2 $3
> -      Goto RemoveFromPath_dosLoop
> -
> -    RemoveFromPath_dosLoopEnd:
> -      FileClose $2
> -      FileClose $1
> -      StrCpy $1 $WINDIR 2
> -      Delete "$1\autoexec.bat"
> -      CopyFiles /SILENT $4 "$1\autoexec.bat"
> -      Delete $4
> -      Goto RemoveFromPath_done
> -
> -  RemoveFromPath_NT:
> -    StrLen $2 $0
> -    ReadRegStr $1 HKCU "Environment" "PATH"
> -    Push $1
> -    Push $0
> -    Call ${un}StrStr ; Find $0 in $1
> -    Pop $0 ; pos of our dir
> -    IntCmp $0 -1 RemoveFromPath_done
> -      ; else, it is in path
> -      StrCpy $3 $1 $0 ; $3 now has the part of the path before our dir
> -      IntOp $2 $2 + $0 ; $2 now contains the pos after our dir in the pa=
th (';')
> -      IntOp $2 $2 + 1 ; $2 now containts the pos after our dir and the s=
emicolon.
> -      StrLen $0 $1
> -      StrCpy $1 $1 $0 $2
> -      StrCpy $3 "$3$1"
> -
> -      StrCpy $5 $3 1 -1 # copy last char
> -      StrCmp $5 ";" 0 +2 # if last char =3D=3D ;
> -        StrCpy $3 $3 -1 # remove last char
> -
> -      WriteRegExpandStr HKCU "Environment" "PATH" $3
> -      SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environmen=
t" /TIMEOUT=3D5000
> -
> -  RemoveFromPath_done:
> -    Pop $5
> -    Pop $4
> -    Pop $3
> -    Pop $2
> -    Pop $1
> -    Pop $0
> -FunctionEnd
> -!macroend
> -!insertmacro RemoveFromPath ""
> -!insertmacro RemoveFromPath "un."
> -
> -
> -;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -; StrStr - Finds a given string in another given string.
> -;               Returns -1 if not found and the pos if found.
> -;          Input: head of the stack - string to find
> -;                      second in the stack - string to find in
> -;          Output: head of the stack
> -;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -!macro StrStr un
> -Function ${un}StrStr
> -  Push $0
> -  Exch
> -  Pop $0 ; $0 now have the string to find
> -  Push $1
> -  Exch 2
> -  Pop $1 ; $1 now have the string to find in
> -  Exch
> -  Push $2
> -  Push $3
> -  Push $4
> -  Push $5
> -
> -  StrCpy $2 -1
> -  StrLen $3 $0
> -  StrLen $4 $1
> -  IntOp $4 $4 - $3
> -
> -  StrStr_loop:
> -    IntOp $2 $2 + 1
> -    IntCmp $2 $4 0 0 StrStrReturn_notFound
> -    StrCpy $5 $1 $3 $2
> -    StrCmp $5 $0 StrStr_done StrStr_loop
> -
> -  StrStrReturn_notFound:
> -    StrCpy $2 -1
> -
> -  StrStr_done:
> -    Pop $5
> -    Pop $4
> -    Pop $3
> -    Exch $2
> -    Exch 2
> -    Pop $0
> -    Pop $1
> -FunctionEnd
> -!macroend
> -!insertmacro StrStr ""
> -!insertmacro StrStr "un."
> -
> -;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -; IsNT - Returns 1 if the current system is NT, 0
> -;        otherwise.
> -;     Output: head of the stack
> -;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -!macro IsNT un
> -Function ${un}IsNT
> -  Push $0
> -  ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" Curr=
entVersion
> -  StrCmp $0 "" 0 IsNT_yes
> -  ; we are not NT.
> -  Pop $0
> -  Push 0
> -  Return
> -
> -  IsNT_yes:
> -    ; NT!!!
> -    Pop $0
> -    Push 1
> -FunctionEnd
> -!macroend
> -!insertmacro IsNT ""
> -!insertmacro IsNT "un."
> -
> diff --git a/install-win32/settings.in b/install-win32/settings.in
> deleted file mode 100644
> index 4a0a564..0000000
> --- a/install-win32/settings.in
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -# Version numbers, settings, and dependencies
> -# for Windows OpenVPN installer.
> -
> -# Get the OpenVPN version number
> -!include "autodefs/version.in"
> -
> -# Branding
> -!define PRODUCT_NAME      "OpenVPN"
> -!define PRODUCT_UNIX_NAME "openvpn"
> -!define PRODUCT_FILE_EXT  "ovpn"
> -
> -# Allow --askpass and --auth-user-pass passwords to be read from a file
> -;!define ENABLE_PASSWORD_SAVE
> -
> -# Include the OpenVPN GUI exe in the installer.
> -# May be undefined.
> -!define OPENVPN_GUI_DIR "../openvpn-gui"
> -!define OPENVPN_GUI     "openvpn-gui-1.0.3.exe"
> -
> -# Include the OpenVPN XML-based GUI exe in the installer.
> -# May be undefined.
> -;!define OPENVPN_XGUI_DIR "../ovpnxml"
> -
> -# Prebuilt libraries.  DMALLOC is optional.
> -!define OPENSSL_DIR      "../openssl.mingw/openssl-0.9.8o"
> -!define LZO_DIR                  "../lzo-2.02"
> -!define PKCS11_HELPER_DIR "../pkcs11-helper"
> -;!define DMALLOC_DIR     "../dmalloc-5.4.2"
> -
> -# Prebuilt TAP drivers and tapinstall
> -!define TAPBINSRC "../tap_dist"
> -
> -# Directory containing python script for signing .exe files
> -!define SIGNTOOL        "../signtool"
> -
> -# Optional directory of prebuilt OpenVPN binary components,
> -# to be used as a source when build-from-scratch prerequisites
> -# are not met.
> -;!define GENOUT_PREBUILT  "../gen-prebuilt"
> -
> -# -j parameter passed to make
> -!define MAKE_JOBS 1
> -
> -# output directory for built binaries
> -# and other generated files
> -!define GENOUT "gen"
> -
> -# delete GENOUT directory before starting
> -# set to "yes" or "no"
> -!define CLEAN "yes"
> -
> -# Don't strip executables and DLLs
> -;!define NO_STRIP
> -
> -; DEBUGGING -- set to something like "-DBG2"
> -!define OUTFILE_LABEL ""
> -
> -; DEBUGGING -- set to something like "DEBUG2"
> -!define TITLE_LABEL ""
> -
> -# include a sample configuration file and key
> -;!define SAMPCONF_DIR   "test-key"
> -;!define SAMPCONF_CONF  "test.ovpn"
> -;!define SAMPCONF_P12   "test.p12"
> -;!define SAMPCONF_TA    "ta.key"
> -;!define SAMPCONF_CA    "ca.crt"
> -;!define SAMPCONF_CRT   "test.crt"
> -;!define SAMPCONF_KEY   "test.key"
> -
> -# Extract files embedded in installer
> -;!define EXTRACT_FILES
> diff --git a/install-win32/trans.pl b/install-win32/trans.pl
> deleted file mode 100644
> index 34fd207..0000000
> --- a/install-win32/trans.pl
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -#!/usr/bin/perl
> -
> -# This script translates a simple definition-based grammar
> -# to either C, sh, Javascript, or in (in =3D identity grammar, i.e.
> -# same grammar as input).
> -#
> -# Input grammar:
> -#   (1) comments having ';' or '#' as the first char in the line
> -#   (2) a blank line
> -#   (3) !include "file"
> -#   (4) !define foo bar
> -#   (5) !define foo "bar"
> -#
> -# Environmental variables can be used to override a setting.
> -# The special value "null" causes the variable to be undefined.
> -# If an environmental value is bracketed, i.e [abc], the brackets
> -# will be converted to double quotes prior to output.
> -
> -sub comment {
> -  my ($cmt) =3D @_;
> -  print "//$cmt\n" if ($mode =3D~ /^(c|js|h)$/);
> -  print "#$cmt\n" if ($mode =3D~ /^(sh|nsi|in)$/);
> -}
> -
> -sub define {
> -  my ($name, $value) =3D @_;
> -  if ($mode eq "sh") {
> -    $value=3D"true" if !$value;
> -    print "[ -z \"\$$name\" ] && export $name=3D$value\n";
> -    print "[ \"\$$name\" =3D \"$nulltag\" ] && unset $name\n";
> -  } else {
> -    if ($ENV{$name}) {
> -      $value =3D $ENV{$name};
> -      $value =3D "\"$1\"" if ($value =3D~ /\[(.*)\]$/);
> -    }
> -    if ($value ne $nulltag) {
> -      print "#define $name $value\n" if ($mode =3D~ /^(c|h)$/);
> -      print "!define $name $value\n" if ($mode =3D~ /^(nsi|in)$/);
> -      print "var $name=3D$value;\n" if ($mode eq "js");
> -    } else {
> -      print "//#undef $name\n" if ($mode =3D~ /^(c|h)$/);
> -      print "#!undef $name\n" if ($mode eq "nsi");
> -      print ";!undef $name\n" if ($mode eq "in");
> -      print "//undef $name\n" if ($mode eq "js");
> -    }
> -  }
> -}
> -
> -sub include_file {
> -  local $_;
> -  $include_file_level++;
> -  die "!include file nesting too deep" if ($include_file_level > $max_in=
c_depth);
> -  my ($parm) =3D @_;
> -  my $fn =3D "$incdir/$parm";
> -  local *IN;
> -  open(IN, "< $fn") or die "cannot open $fn";
> -    while (<IN>) {
> -      chomp;
> -      if (/^\s*$/) {
> -       print "\n";
> -      } elsif (/^[#;](.*)$/) {
> -       comment ($1);
> -      } elsif (/^!define\s+(\w+)(?:\s+(.*?))?\s*$/) {
> -       define ($1, $2);
> -      } elsif (/^!include\s+"(.+)"$/) {
> -       include_file ($1);
> -      } else {
> -       die "can't parse this line: $_\n";
> -      }
> -    }
> -  $include_file_level--;
> -}
> -
> -die "usage: trans <c|h|sh|js|nsi|in> [-I<dir>] [files ...]" if (@ARGV < =
1);
> -
> -($mode) =3D shift(@ARGV);
> -die "mode must be one of c, h, sh, js, nsi, or in" if !($mode =3D~ /^(c|=
h|sh|js|nsi|in)$/);
> -
> -$nulltag =3D "null";
> -$max_inc_depth =3D 10;
> -$include_file_level =3D 0;
> -$incdir =3D ".";
> -
> -comment(" This file was automatically generated by trans.pl");
> -
> -while ($arg=3Dshift(@ARGV)) {
> -  if ($arg =3D~ /^-/) {
> -    if ($arg =3D~ /^-I(.*)$/) {
> -      $incdir =3D $1;
> -    } else {
> -      die "unrecognized option: $arg";
> -    }
> -  } else {
> -    print "\n";
> -    include_file ($arg);
> -  }
> -}
> diff --git a/install-win32/u2d.c b/install-win32/u2d.c
> deleted file mode 100755
> index bf1f5e8..0000000
> --- a/install-win32/u2d.c
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -#include <stdio.h>
> -
> -int
> -main (int argc, char *argv[])
> -{
> -  int c;
> -  int enable =3D 1;
> -
> -  while ((c =3D getchar()) !=3D EOF)
> -    {
> -#if 0
> -      if (c =3D=3D '\r')
> -       enable =3D 0;
> -      if (enable && c =3D=3D '\n')
> -       putchar ('\r');
> -#endif
> -      putchar (c);
> -    }
> -  return 0;
> -}
> diff --git a/install-win32/winconfig b/install-win32/winconfig
> deleted file mode 100644
> index 9d686c9..0000000
> --- a/install-win32/winconfig
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -#!/bin/sh
> -
> -# prepare files for building on Windows
> -# run from top directory: install-win32/winconfig
> -
> -rm -rf autodefs
> -mkdir autodefs
> -
> -# build multi-grammar definition files
> -perl install-win32/m4todef.pl <version.m4 >autodefs/version.in
> -for g in "h" "sh" "nsi" "in" ; do
> -    perl install-win32/trans.pl $g install-win32/settings.in >autodefs/d=
efs.$g
> -done
> -
> -cat /dev/null >autodefs/guidefs.nsi
> -
> -echo '#include "autodefs/defs.h"' >autodefs.h
> -echo '#include "config.h"' >>autodefs.h
> --
> 1.7.3.4
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



