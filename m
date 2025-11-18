From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_DFFF76BF-F4F4-46E8-8844-196271DC084C"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Message-Id: <2E25FB29-2D09-4672-BFE3-3E072226281A@...2722...>
Date: Tue, 18 Nov 2025 20:50:22 +0200
Subject: [Openvpn-devel] OpenVPN 2.7_rc2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_DFFF76BF-F4F4-46E8-8844-196271DC084C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_rc2.

This is the second release candidate for the feature release 2.7.0.

Security fixes:

* CVE-2025-12106: IPv6 address parsing: fix buffer overread on invalid input
* CVE-2025-13086: HMAC verification check: fix incorrect memcmp() call

Important bug fixes since 2.7_rc1:

* even more type conversion related warnings have been fixed
* DCO FreeBSD improvements:
    * improving debug messages (verb 6)
    * implement client-side counter handling
    * repair --inactive (and document shortcomings)
    * repair handling of DCO disconnection notifications in --client mode
* Windows/Service improvements, hardening, bugfixes
    * fix DNS address list generation (if 3 or more --dns addresses in use)
    * fix DNS server undo_list
    * disallow "stdin" as config name unless user has OpenVPN admin privs
    * fix compilation errors with MSVC v19
    * iservice: improve validation of config path (pathcc lib)
         * [NOTE: this breaks OpenVPN compatibility with Windows 7]
    * tapctl: refactor, improve output, change driver default to ovpn-dco
    * iservice: when restoring iface metrics, enforce correct ifindex
* improve cmocka unit test assert() handling
* PUSH_UPDATE server: fix reporting of client IPs in ``status`` output afte=
r pushing a new IPv4/IPv6 address to client
* AEAD cipher safety margins: fix calculation of AEAD blocks in use (old co=
de would undercount blocks)
* fix invalid pointer creation / memory overread in tls_pre_decrypt
* deprecate ``--opt-verify`` (change into no-op + warning)

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

--Apple-Mail=_DFFF76BF-F4F4-46E8-8844-196271DC084C
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
enVPN 2.7_rc2.</p><p style=3D"margin: 0px; font-width: normal; line-height:=
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
 0); -webkit-text-stroke-color: rgb(0, 0, 0);">This is the second release c=
andidate for the feature release 2.7.0.</p><p style=3D"margin: 0px; font-wi=
dth: normal; line-height: normal; font-size-adjust: none; font-kerning: aut=
o; font-variant-alternates: normal; font-variant-ligatures: normal; font-va=
riant-numeric: normal; font-variant-east-asian: normal; font-variant-positi=
on: normal; font-feature-settings: normal; font-optical-sizing: auto; font-=
variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color:=
 rgb(0, 0, 0);"><br></p><p style=3D"margin: 0px; font-width: normal; line-h=
eight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alt=
ernates: normal; font-variant-ligatures: normal; font-variant-numeric: norm=
al; font-variant-east-asian: normal; font-variant-position: normal; font-fe=
ature-settings: normal; font-optical-sizing: auto; font-variation-settings:=
 normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">Sec=
urity fixes:</p><p style=3D"margin: 0px; font-width: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-feature-se=
ttings: normal; font-optical-sizing: auto; font-variation-settings: normal;=
 color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br></p><p =
style=3D"margin: 0px; font-width: normal; line-height: normal; font-size-ad=
just: none; font-kerning: auto; font-variant-alternates: normal; font-varia=
nt-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian=
: normal; font-variant-position: normal; font-feature-settings: normal; fon=
t-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0=
); -webkit-text-stroke-color: rgb(0, 0, 0);">* CVE-2025-12106: IPv6 address=
 parsing: fix buffer overread on invalid input</p><p style=3D"margin: 0px; =
font-width: normal; line-height: normal; font-size-adjust: none; font-kerni=
ng: auto; font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; font-variant=
-position: normal; font-feature-settings: normal; font-optical-sizing: auto=
; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke=
-color: rgb(0, 0, 0);">* CVE-2025-13086: HMAC verification check: fix incor=
rect memcmp() call</p><p style=3D"margin: 0px; font-width: normal; line-hei=
ght: normal; font-size-adjust: none; font-kerning: auto; font-variant-alter=
nates: normal; font-variant-ligatures: normal; font-variant-numeric: normal=
; font-variant-east-asian: normal; font-variant-position: normal; font-feat=
ure-settings: normal; font-optical-sizing: auto; font-variation-settings: n=
ormal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br><=
/p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-s=
ize-adjust: none; font-kerning: auto; font-variant-alternates: normal; font=
-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east=
-asian: normal; font-variant-position: normal; font-feature-settings: norma=
l; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0=
, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">Important bug fixes sinc=
e 2.7_rc1:</p><p style=3D"margin: 0px; font-width: normal; line-height: nor=
mal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: n=
ormal; font-variant-ligatures: normal; font-variant-numeric: normal; font-v=
ariant-east-asian: normal; font-variant-position: normal; font-feature-sett=
ings: normal; font-optical-sizing: auto; font-variation-settings: normal; c=
olor: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br></p><p st=
yle=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adju=
st: none; font-kerning: auto; font-variant-alternates: normal; font-variant=
-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: =
normal; font-variant-position: normal; font-feature-settings: normal; font-=
optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);=
 -webkit-text-stroke-color: rgb(0, 0, 0);">* even more type conversion rela=
ted warnings have been fixed</p><p style=3D"margin: 0px; font-width: normal=
; line-height: normal; font-size-adjust: none; font-kerning: auto; font-var=
iant-alternates: normal; font-variant-ligatures: normal; font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-variant-position: normal;=
 font-feature-settings: normal; font-optical-sizing: auto; font-variation-s=
ettings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, =
0);">* DCO FreeBSD improvements:</p><p style=3D"margin: 0px; font-width: no=
rmal; line-height: normal; font-size-adjust: none; font-kerning: auto; font=
-variant-alternates: normal; font-variant-ligatures: normal; font-variant-n=
umeric: normal; font-variant-east-asian: normal; font-variant-position: nor=
mal; font-feature-settings: normal; font-optical-sizing: auto; font-variati=
on-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0,=
 0, 0);">&nbsp; &nbsp; * improving debug messages (verb 6)</p><p style=3D"m=
argin: 0px; font-width: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * implement client-side co=
unter handling</p><p style=3D"margin: 0px; font-width: normal; line-height:=
 normal; font-size-adjust: none; font-kerning: auto; font-variant-alternate=
s: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fo=
nt-variant-east-asian: normal; font-variant-position: normal; font-feature-=
settings: normal; font-optical-sizing: auto; font-variation-settings: norma=
l; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; &n=
bsp; * repair --inactive (and document shortcomings)</p><p style=3D"margin:=
 0px; font-width: normal; line-height: normal; font-size-adjust: none; font=
-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: no=
rmal; font-variant-numeric: normal; font-variant-east-asian: normal; font-v=
ariant-position: normal; font-feature-settings: normal; font-optical-sizing=
: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-=
stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * repair handling of DCO disconn=
ection notifications in --client mode</p><p style=3D"margin: 0px; font-widt=
h: normal; line-height: normal; font-size-adjust: none; font-kerning: auto;=
 font-variant-alternates: normal; font-variant-ligatures: normal; font-vari=
ant-numeric: normal; font-variant-east-asian: normal; font-variant-position=
: normal; font-feature-settings: normal; font-optical-sizing: auto; font-va=
riation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: r=
gb(0, 0, 0);">* Windows/Service improvements, hardening, bugfixes</p><p sty=
le=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * fix DNS address l=
ist generation (if 3 or more --dns addresses in use)</p><p style=3D"margin:=
 0px; font-width: normal; line-height: normal; font-size-adjust: none; font=
-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: no=
rmal; font-variant-numeric: normal; font-variant-east-asian: normal; font-v=
ariant-position: normal; font-feature-settings: normal; font-optical-sizing=
: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-=
stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * fix DNS server undo_list</p><p=
 style=3D"margin: 0px; font-width: normal; line-height: normal; font-size-a=
djust: none; font-kerning: auto; font-variant-alternates: normal; font-vari=
ant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asia=
n: normal; font-variant-position: normal; font-feature-settings: normal; fo=
nt-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, =
0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * disallow "std=
in" as config name unless user has OpenVPN admin privs</p><p style=3D"margi=
n: 0px; font-width: normal; line-height: normal; font-size-adjust: none; fo=
nt-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: =
normal; font-variant-numeric: normal; font-variant-east-asian: normal; font=
-variant-position: normal; font-feature-settings: normal; font-optical-sizi=
ng: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-tex=
t-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * fix compilation errors with =
MSVC v19</p><p style=3D"margin: 0px; font-width: normal; line-height: norma=
l; font-size-adjust: none; font-kerning: auto; font-variant-alternates: nor=
mal; font-variant-ligatures: normal; font-variant-numeric: normal; font-var=
iant-east-asian: normal; font-variant-position: normal; font-feature-settin=
gs: normal; font-optical-sizing: auto; font-variation-settings: normal; col=
or: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; *=
 iservice: improve validation of config path (pathcc lib)</p><p style=3D"ma=
rgin: 0px; font-width: normal; line-height: normal; font-size-adjust: none;=
 font-kerning: auto; font-variant-alternates: normal; font-variant-ligature=
s: normal; font-variant-numeric: normal; font-variant-east-asian: normal; f=
ont-variant-position: normal; font-feature-settings: normal; font-optical-s=
izing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-=
text-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* [NOTE=
: this breaks OpenVPN compatibility with Windows 7]</p><p style=3D"margin: =
0px; font-width: normal; line-height: normal; font-size-adjust: none; font-=
kerning: auto; font-variant-alternates: normal; font-variant-ligatures: nor=
mal; font-variant-numeric: normal; font-variant-east-asian: normal; font-va=
riant-position: normal; font-feature-settings: normal; font-optical-sizing:=
 auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-s=
troke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * tapctl: refactor, improve outpu=
t, change driver default to ovpn-dco</p><p style=3D"margin: 0px; font-width=
: normal; line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; font-varia=
nt-numeric: normal; font-variant-east-asian: normal; font-variant-position:=
 normal; font-feature-settings: normal; font-optical-sizing: auto; font-var=
iation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rg=
b(0, 0, 0);">&nbsp; &nbsp; * iservice: when restoring iface metrics, enforc=
e correct ifindex</p><p style=3D"margin: 0px; font-width: normal; line-heig=
ht: normal; font-size-adjust: none; font-kerning: auto; font-variant-altern=
ates: normal; font-variant-ligatures: normal; font-variant-numeric: normal;=
 font-variant-east-asian: normal; font-variant-position: normal; font-featu=
re-settings: normal; font-optical-sizing: auto; font-variation-settings: no=
rmal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* impr=
ove cmocka unit test assert() handling</p><p style=3D"margin: 0px; font-wid=
th: normal; line-height: normal; font-size-adjust: none; font-kerning: auto=
; font-variant-alternates: normal; font-variant-ligatures: normal; font-var=
iant-numeric: normal; font-variant-east-asian: normal; font-variant-positio=
n: normal; font-feature-settings: normal; font-optical-sizing: auto; font-v=
ariation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: =
rgb(0, 0, 0);">* PUSH_UPDATE server: fix reporting of client IPs in ``statu=
s`` output after pushing a new IPv4/IPv6 address to client</p><p style=3D"m=
argin: 0px; font-width: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0);">* AEAD cipher safety margins: fix calcul=
ation of AEAD blocks in use (old code would undercount blocks)</p><p style=
=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjust:=
 none; font-kerning: auto; font-variant-alternates: normal; font-variant-li=
gatures: normal; font-variant-numeric: normal; font-variant-east-asian: nor=
mal; font-variant-position: normal; font-feature-settings: normal; font-opt=
ical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -w=
ebkit-text-stroke-color: rgb(0, 0, 0);">* fix invalid pointer creation / me=
mory overread in tls_pre_decrypt</p><p style=3D"margin: 0px; font-width: no=
rmal; line-height: normal; font-size-adjust: none; font-kerning: auto; font=
-variant-alternates: normal; font-variant-ligatures: normal; font-variant-n=
umeric: normal; font-variant-east-asian: normal; font-variant-position: nor=
mal; font-feature-settings: normal; font-optical-sizing: auto; font-variati=
on-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0,=
 0, 0);">* deprecate ``--opt-verify`` (change into no-op + warning)</p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none">More details can be found in the Ch=
anges document:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(53, =
134, 255); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(5=
3, 134, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -web=
kit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://github.com/Ope=
nVPN/openvpn/blob/master/Changes.rst"><span style=3D"font-kerning: none; co=
lor: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);">http=
s://github.com/OpenVPN/openvpn/blob/master/Changes.rst</span></a>&gt;</span=
></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none">Source code and Windows installers =
can be downloaded from our download page:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(53, =
134, 255); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(5=
3, 134, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -web=
kit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://openvpn.net/co=
mmunity-downloads/"><span style=3D"font-kerning: none; color: rgb(53, 134, =
255); -webkit-text-stroke-color: rgb(53, 134, 255);">https://openvpn.net/co=
mmunity-downloads/</span></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none">Packages for Debian, Ubuntu, Fedora=
, RHEL, and openSUSE are available in the various</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none">official Community repositories:</s=
pan></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(53, =
134, 255); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(5=
3, 134, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -web=
kit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://community.open=
vpn.net/Pages/OpenVPN%20software%20repos"><span style=3D"font-kerning: none=
; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);">=
https://community.openvpn.net/Pages/OpenVPN%20software%20repos</span></a>&g=
t;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none">Kind regards,</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none">Yuriy Darnobyt</span></p></body></h=
tml>=

--Apple-Mail=_DFFF76BF-F4F4-46E8-8844-196271DC084C--

