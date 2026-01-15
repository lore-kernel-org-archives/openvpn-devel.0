From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_FE828BBC-65F1-4B5D-8EEA-0A51A6009997"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Message-Id: <42FB1E1A-5A83-4511-A3F5-A4A157F4F2BE@...2722...>
Date: Thu, 15 Jan 2026 22:27:21 +0200
Subject: [Openvpn-devel] OpenVPN 2.7_rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_FE828BBC-65F1-4B5D-8EEA-0A51A6009997
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_rc5.

This is the fifth release candidate for the feature release 2.7.0.

Security fixes:

* CVE-2025-15497: in epoch key handling (an authenticated remote system
  can send a valid OpenVPN data packet that triggers an edge case
  where a too-strict check would trigger an ASSERT(), exiting OpenVPN)

Important bug fixes since 2.7_rc4:

* remove "resolve --remote on incoming TCP connects on --tcp-server"
  code base, because that did not work in a long time (since 2.4) and
  is seen as too obscure and too complicated to rescue.=20
* repair interaction between DCO and persist-tun after reconnection
  (in this case the client side would fail to set up the DCO event
  handler, and not notice further --ping timeouts - GH: #947)
* remove ENABLE_X509ALTUSERNAME conditional, always enabling
  "configure --enable-x509-alt-username".  Effectively no change in
  code size, and one less build variant to maintain and test (GH: OpenVPN/o=
penvpn#917).
* require "script-security 2" when using `--dev unix:<program>`
* socks client: fix and improve various code parts
* configure etc: drop support for systemd 216 and older, adapt
  other checks to reflect modern systemd setups
* fix unit test building with libcmocka 2.0+
* fix Android build warnings about unused variables/methods
* allow --test-crypto to run without --secret
  (prepare for removal of --secret after 2.7)
* improve WolfSSL build compatibility

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/master/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in th=
e various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
Yuriy Darnobyt=

--Apple-Mail=_FE828BBC-65F1-4B5D-8EEA-0A51A6009997
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><p style=3D"margin: 0px; font-=
width: normal; line-height: normal; font-size-adjust: none; font-kerning: a=
uto; font-variant-alternates: normal; font-variant-ligatures: normal; font-=
variant-numeric: normal; font-variant-east-asian: normal; font-variant-posi=
tion: normal; font-feature-settings: normal; font-optical-sizing: auto; fon=
t-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-colo=
r: rgb(0, 0, 0);">The OpenVPN community project team is proud to release Op=
enVPN 2.7_rc5.</p><p style=3D"margin: 0px; font-width: normal; line-height:=
 normal; font-size-adjust: none; font-kerning: auto; font-variant-alternate=
s: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fo=
nt-variant-east-asian: normal; font-variant-position: normal; font-feature-=
settings: normal; font-optical-sizing: auto; font-variation-settings: norma=
l; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br></p><=
p style=3D"margin: 0px; font-width: normal; line-height: normal; font-size-=
adjust: none; font-kerning: auto; font-variant-alternates: normal; font-var=
iant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asi=
an: normal; font-variant-position: normal; font-feature-settings: normal; f=
ont-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0,=
 0); -webkit-text-stroke-color: rgb(0, 0, 0);">This is the fifth release ca=
ndidate for the feature release 2.7.0.</p><p style=3D"margin: 0px; font-wid=
th: normal; line-height: normal; font-size-adjust: none; font-kerning: auto=
; font-variant-alternates: normal; font-variant-ligatures: normal; font-var=
iant-numeric: normal; font-variant-east-asian: normal; font-variant-positio=
n: normal; font-feature-settings: normal; font-optical-sizing: auto; font-v=
ariation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: =
rgb(0, 0, 0);"><br></p><p style=3D"margin: 0px; font-width: normal; line-he=
ight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alte=
rnates: normal; font-variant-ligatures: normal; font-variant-numeric: norma=
l; font-variant-east-asian: normal; font-variant-position: normal; font-fea=
ture-settings: normal; font-optical-sizing: auto; font-variation-settings: =
normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">Secu=
rity fixes:</p><p style=3D"margin: 0px; font-width: normal; line-height: no=
rmal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: =
normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-=
variant-east-asian: normal; font-variant-position: normal; font-feature-set=
tings: normal; font-optical-sizing: auto; font-variation-settings: normal; =
color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br></p><p s=
tyle=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adj=
ust: none; font-kerning: auto; font-variant-alternates: normal; font-varian=
t-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian:=
 normal; font-variant-position: normal; font-feature-settings: normal; font=
-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0)=
; -webkit-text-stroke-color: rgb(0, 0, 0);">* CVE-2025-15497: in epoch key =
handling (an authenticated remote system</p><p style=3D"margin: 0px; font-w=
idth: normal; line-height: normal; font-size-adjust: none; font-kerning: au=
to; font-variant-alternates: normal; font-variant-ligatures: normal; font-v=
ariant-numeric: normal; font-variant-east-asian: normal; font-variant-posit=
ion: normal; font-feature-settings: normal; font-optical-sizing: auto; font=
-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color=
: rgb(0, 0, 0);">&nbsp; can send a valid OpenVPN data packet that triggers =
an edge case</p><p style=3D"margin: 0px; font-width: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-feature-se=
ttings: normal; font-optical-sizing: auto; font-variation-settings: normal;=
 color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; wher=
e a too-strict check would trigger an ASSERT(), exiting OpenVPN)</p><p styl=
e=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjust=
: none; font-kerning: auto; font-variant-alternates: normal; font-variant-l=
igatures: normal; font-variant-numeric: normal; font-variant-east-asian: no=
rmal; font-variant-position: normal; font-feature-settings: normal; font-op=
tical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -=
webkit-text-stroke-color: rgb(0, 0, 0);"><br></p><p style=3D"margin: 0px; f=
ont-width: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
color: rgb(0, 0, 0);">Important bug fixes since 2.7_rc4:</p><p style=3D"mar=
gin: 0px; font-width: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures=
: normal; font-variant-numeric: normal; font-variant-east-asian: normal; fo=
nt-variant-position: normal; font-feature-settings: normal; font-optical-si=
zing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-t=
ext-stroke-color: rgb(0, 0, 0);"><br></p><p style=3D"margin: 0px; font-widt=
h: normal; line-height: normal; font-size-adjust: none; font-kerning: auto;=
 font-variant-alternates: normal; font-variant-ligatures: normal; font-vari=
ant-numeric: normal; font-variant-east-asian: normal; font-variant-position=
: normal; font-feature-settings: normal; font-optical-sizing: auto; font-va=
riation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: r=
gb(0, 0, 0);">* remove "resolve --remote on incoming TCP connects on --tcp-=
server"</p><p style=3D"margin: 0px; font-width: normal; line-height: normal=
; font-size-adjust: none; font-kerning: auto; font-variant-alternates: norm=
al; font-variant-ligatures: normal; font-variant-numeric: normal; font-vari=
ant-east-asian: normal; font-variant-position: normal; font-feature-setting=
s: normal; font-optical-sizing: auto; font-variation-settings: normal; colo=
r: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; code base=
, because that did not work in a long time (since 2.4) and</p><p style=3D"m=
argin: 0px; font-width: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0);">&nbsp; is seen as too obscure and too co=
mplicated to rescue.&nbsp;</p><p style=3D"margin: 0px; font-width: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; font-varia=
nt-alternates: normal; font-variant-ligatures: normal; font-variant-numeric=
: normal; font-variant-east-asian: normal; font-variant-position: normal; f=
ont-feature-settings: normal; font-optical-sizing: auto; font-variation-set=
tings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0)=
;">* repair interaction between DCO and persist-tun after reconnection</p><=
p style=3D"margin: 0px; font-width: normal; line-height: normal; font-size-=
adjust: none; font-kerning: auto; font-variant-alternates: normal; font-var=
iant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asi=
an: normal; font-variant-position: normal; font-feature-settings: normal; f=
ont-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0,=
 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; (in this case the cli=
ent side would fail to set up the DCO event</p><p style=3D"margin: 0px; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-co=
lor: rgb(0, 0, 0);">&nbsp; handler, and not notice further --ping timeouts =
- GH: #947)</p><p style=3D"margin: 0px; font-width: normal; line-height: no=
rmal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: =
normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-=
variant-east-asian: normal; font-variant-position: normal; font-feature-set=
tings: normal; font-optical-sizing: auto; font-variation-settings: normal; =
color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* remove ENA=
BLE_X509ALTUSERNAME conditional, always enabling</p><p style=3D"margin: 0px=
; font-width: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stro=
ke-color: rgb(0, 0, 0);">&nbsp; "configure --enable-x509-alt-username". &nb=
sp;Effectively no change in</p><p style=3D"margin: 0px; font-width: normal;=
 line-height: normal; font-size-adjust: none; font-kerning: auto; font-vari=
ant-alternates: normal; font-variant-ligatures: normal; font-variant-numeri=
c: normal; font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; font-variation-se=
ttings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0=
);">&nbsp; code size, and one less build variant to maintain and test (GH: =
OpenVPN/openvpn#917).</p><p style=3D"margin: 0px; font-width: normal; line-=
height: normal; font-size-adjust: none; font-kerning: auto; font-variant-al=
ternates: normal; font-variant-ligatures: normal; font-variant-numeric: nor=
mal; font-variant-east-asian: normal; font-variant-position: normal; font-f=
eature-settings: normal; font-optical-sizing: auto; font-variation-settings=
: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* =
require "script-security 2" when using `--dev unix:&lt;program&gt;`</p><p s=
tyle=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adj=
ust: none; font-kerning: auto; font-variant-alternates: normal; font-varian=
t-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian:=
 normal; font-variant-position: normal; font-feature-settings: normal; font=
-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0)=
; -webkit-text-stroke-color: rgb(0, 0, 0);">* socks client: fix and improve=
 various code parts</p><p style=3D"margin: 0px; font-width: normal; line-he=
ight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alte=
rnates: normal; font-variant-ligatures: normal; font-variant-numeric: norma=
l; font-variant-east-asian: normal; font-variant-position: normal; font-fea=
ture-settings: normal; font-optical-sizing: auto; font-variation-settings: =
normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* co=
nfigure etc: drop support for systemd 216 and older, adapt</p><p style=3D"m=
argin: 0px; font-width: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0);">&nbsp; other checks to reflect modern sy=
stemd setups</p><p style=3D"margin: 0px; font-width: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-feature-se=
ttings: normal; font-optical-sizing: auto; font-variation-settings: normal;=
 color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* fix unit =
test building with libcmocka 2.0+</p><p style=3D"margin: 0px; font-width: n=
ormal; line-height: normal; font-size-adjust: none; font-kerning: auto; fon=
t-variant-alternates: normal; font-variant-ligatures: normal; font-variant-=
numeric: normal; font-variant-east-asian: normal; font-variant-position: no=
rmal; font-feature-settings: normal; font-optical-sizing: auto; font-variat=
ion-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0=
, 0, 0);">* fix Android build warnings about unused variables/methods</p><p=
 style=3D"margin: 0px; font-width: normal; line-height: normal; font-size-a=
djust: none; font-kerning: auto; font-variant-alternates: normal; font-vari=
ant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asia=
n: normal; font-variant-position: normal; font-feature-settings: normal; fo=
nt-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, =
0); -webkit-text-stroke-color: rgb(0, 0, 0);">* allow --test-crypto to run =
without --secret</p><p style=3D"margin: 0px; font-width: normal; line-heigh=
t: normal; font-size-adjust: none; font-kerning: auto; font-variant-alterna=
tes: normal; font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; font-featur=
e-settings: normal; font-optical-sizing: auto; font-variation-settings: nor=
mal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; =
(prepare for removal of --secret after 2.7)</p><p style=3D"margin: 0px; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-co=
lor: rgb(0, 0, 0);">* improve WolfSSL build compatibility</p><p style=3D"ma=
rgin: 0px; font-width: normal; line-height: normal; font-size-adjust: none;=
 font-kerning: auto; font-variant-alternates: normal; font-variant-ligature=
s: normal; font-variant-numeric: normal; font-variant-east-asian: normal; f=
ont-variant-position: normal; font-feature-settings: normal; font-optical-s=
izing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-=
text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-ker=
ning: none;"></span><br></p><p style=3D"margin: 0px; font-width: normal; li=
ne-height: normal; font-size-adjust: none; font-kerning: auto; font-variant=
-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: =
normal; font-variant-east-asian: normal; font-variant-position: normal; fon=
t-feature-settings: normal; font-optical-sizing: auto; font-variation-setti=
ngs: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"=
><span style=3D"font-kerning: none;">More details can be found in the Chang=
es document:</span></p><p style=3D"margin: 0px; font-width: normal; line-he=
ight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alte=
rnates: normal; font-variant-ligatures: normal; font-variant-numeric: norma=
l; font-variant-east-asian: normal; font-variant-position: normal; font-fea=
ture-settings: normal; font-optical-sizing: auto; font-variation-settings: =
normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min-h=
eight: 14px;"><span style=3D"font-kerning: none;"></span><br></p><p style=
=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjust:=
 none; font-kerning: auto; font-variant-alternates: normal; font-variant-li=
gatures: normal; font-variant-numeric: normal; font-variant-east-asian: nor=
mal; font-variant-position: normal; font-feature-settings: normal; font-opt=
ical-sizing: auto; font-variation-settings: normal; color: rgb(53, 134, 255=
); -webkit-text-stroke-color: rgb(53, 134, 255);"><span style=3D"font-kerni=
ng: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&l=
t;<a href=3D"https://github.com/OpenVPN/openvpn/blob/master/Changes.rst"><s=
pan style=3D"font-kerning: none; color: rgb(53, 134, 255); -webkit-text-str=
oke-color: rgb(53, 134, 255);">https://github.com/OpenVPN/openvpn/blob/mast=
er/Changes.rst</span></a>&gt;</span></p><p style=3D"margin: 0px; font-width=
: normal; line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; font-varia=
nt-numeric: normal; font-variant-east-asian: normal; font-variant-position:=
 normal; font-feature-settings: normal; font-optical-sizing: auto; font-var=
iation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rg=
b(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: none;"></span><=
br></p><p style=3D"margin: 0px; font-width: normal; line-height: normal; fo=
nt-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-=
east-asian: normal; font-variant-position: normal; font-feature-settings: n=
ormal; font-optical-sizing: auto; font-variation-settings: normal; color: r=
gb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-=
kerning: none;">Source code and Windows installers can be downloaded from o=
ur download page:</span></p><p style=3D"margin: 0px; font-width: normal; li=
ne-height: normal; font-size-adjust: none; font-kerning: auto; font-variant=
-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: =
normal; font-variant-east-asian: normal; font-variant-position: normal; fon=
t-feature-settings: normal; font-optical-sizing: auto; font-variation-setti=
ngs: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); =
min-height: 14px;"><span style=3D"font-kerning: none;"></span><br></p><p st=
yle=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adju=
st: none; font-kerning: auto; font-variant-alternates: normal; font-variant=
-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: =
normal; font-variant-position: normal; font-feature-settings: normal; font-=
optical-sizing: auto; font-variation-settings: normal; color: rgb(53, 134, =
255); -webkit-text-stroke-color: rgb(53, 134, 255);"><span style=3D"font-ke=
rning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"=
>&lt;<a href=3D"https://openvpn.net/community-downloads/"><span style=3D"fo=
nt-kerning: none; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(=
53, 134, 255);">https://openvpn.net/community-downloads/</span></a>&gt;</sp=
an></p><p style=3D"margin: 0px; font-width: normal; line-height: normal; fo=
nt-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-=
east-asian: normal; font-variant-position: normal; font-feature-settings: n=
ormal; font-optical-sizing: auto; font-variation-settings: normal; color: r=
gb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><s=
pan style=3D"font-kerning: none;"></span><br></p><p style=3D"margin: 0px; f=
ont-width: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
color: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">Packages for Debi=
an, Ubuntu, Fedora, RHEL, and openSUSE are available in the various</span><=
/p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-s=
ize-adjust: none; font-kerning: auto; font-variant-alternates: normal; font=
-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east=
-asian: normal; font-variant-position: normal; font-feature-settings: norma=
l; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0=
, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kern=
ing: none;">official Community repositories:</span></p><p style=3D"margin: =
0px; font-width: normal; line-height: normal; font-size-adjust: none; font-=
kerning: auto; font-variant-alternates: normal; font-variant-ligatures: nor=
mal; font-variant-numeric: normal; font-variant-east-asian: normal; font-va=
riant-position: normal; font-feature-settings: normal; font-optical-sizing:=
 auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-s=
troke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: =
none;"></span><br></p><p style=3D"margin: 0px; font-width: normal; line-hei=
ght: normal; font-size-adjust: none; font-kerning: auto; font-variant-alter=
nates: normal; font-variant-ligatures: normal; font-variant-numeric: normal=
; font-variant-east-asian: normal; font-variant-position: normal; font-feat=
ure-settings: normal; font-optical-sizing: auto; font-variation-settings: n=
ormal; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 25=
5);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-s=
troke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://community.openvpn.net/Pa=
ges/OpenVPN%20software%20repos"><span style=3D"font-kerning: none; color: r=
gb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);">https://co=
mmunity.openvpn.net/Pages/OpenVPN%20software%20repos</span></a>&gt;</span><=
/p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-s=
ize-adjust: none; font-kerning: auto; font-variant-alternates: normal; font=
-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east=
-asian: normal; font-variant-position: normal; font-feature-settings: norma=
l; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0=
, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span =
style=3D"font-kerning: none;"></span><br></p><p style=3D"margin: 0px; font-=
width: normal; line-height: normal; font-size-adjust: none; font-kerning: a=
uto; font-variant-alternates: normal; font-variant-ligatures: normal; font-=
variant-numeric: normal; font-variant-east-asian: normal; font-variant-posi=
tion: normal; font-feature-settings: normal; font-optical-sizing: auto; fon=
t-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-colo=
r: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">Kind regards,</span><=
/p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-s=
ize-adjust: none; font-kerning: auto; font-variant-alternates: normal; font=
-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east=
-asian: normal; font-variant-position: normal; font-feature-settings: norma=
l; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0=
, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kern=
ing: none;">Yuriy Darnobyt</span></p></body></html>=

--Apple-Mail=_FE828BBC-65F1-4B5D-8EEA-0A51A6009997--

