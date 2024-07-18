From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_77D3F70E-C190-48BB-8895-4254B80E72A3"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Message-Id: <443C3BEB-F5AD-4B96-AC53-EE3FF76EA552@...2722...>
Date: Thu, 18 Jul 2024 20:41:18 +0300
Subject: [Openvpn-devel] OpenVPN 2.6.12 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_77D3F70E-C190-48BB-8895-4254B80E72A3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.6.12.

This is a bugfix release.

Bug fixes:

* the fix for CVE-2024-5594 (refuse control channel messages with nonprinta=
ble characters) was too strict, breaking user
   configurations with AUTH_FAIL messages having trailing CR/NL characters.=
 This often happens if the AUTH_FAIL reason
   is set by a script. Strip those before testing the command buffer (githu=
b =E2=80=8B#568). Also, add unit test.
* Http-proxy: fix bug preventing proxy credentials caching (trac #1187)

Windows MSI changes since 2.6.11:

* Built against OpenSSL 3.3.1
* Included openvpn-gui updated to 11.50.0.0
   *Update Italian language (github =E2=80=8B#696)

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

(The Changes document also contains a section with work-arounds for
common problems encountered when using OpenVPN with OpenSSL 3)

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbun=
tu:UsingOpenVPNaptrepositories>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release-2.6/>

Kind regards,
Yuriy Darnobyt=

--Apple-Mail=_77D3F70E-C190-48BB-8895-4254B80E72A3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-mod=
e: space; line-break: after-white-space;"><p style=3D"margin: 0px; font-sty=
le: normal; font-variant-caps: normal; font-stretch: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-variant-em=
oji: normal; font-feature-settings: normal; font-optical-sizing: auto; font=
-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-width=
: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kernin=
g: none">The OpenVPN community project team is proud to release OpenVPN 2.6=
.12.</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">This is a bugfix release.</span><=
/p><p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-stretch: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-variant-emoji: normal; font-feature-settings: nor=
mal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb=
(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0=
, 0, 0); min-height: 14px;"><br><span style=3D"font-kerning: none"></span><=
/p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-=
stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, 255);"><span st=
yle=3D"font-kerning: none">Bug fixes:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-=
stroke-width: 0px; -webkit-text-stroke-color: rgb(255, 255, 255); min-heigh=
t: 14px;"><br></p><p style=3D"margin: 0px; font-stretch: normal; line-heigh=
t: normal; font-size-adjust: none; font-kerning: auto; font-variant-alterna=
tes: normal; font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; font-featur=
e-settings: normal; font-optical-sizing: auto; font-variation-settings: nor=
mal;"><span style=3D"-webkit-text-stroke-color: rgb(255, 255, 255);">* the =
fix for CVE-2024-5594 (refuse control channel messages with nonprintable ch=
aracters) was too strict, breaking user</span></p><p style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal;"><span style=3D"-webkit-text-stroke-co=
lor: rgb(255, 255, 255);">&nbsp; &nbsp;configurations with&nbsp;</span><spa=
n style=3D"-webkit-text-stroke-color: rgb(255, 255, 255);">AUTH_FAIL messag=
es having trailing CR/NL characters. This often happens if the AUTH_FAIL re=
ason</span></p><p style=3D"margin: 0px; font-stretch: normal; line-height: =
normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates=
: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fon=
t-variant-east-asian: normal; font-variant-position: normal; font-feature-s=
ettings: normal; font-optical-sizing: auto; font-variation-settings: normal=
;"><span style=3D"-webkit-text-stroke-color: rgb(255, 255, 255);">&nbsp; &n=
bsp;is set by a script. Strip those before testing the command buffer (gith=
ub =E2=80=8B#568). Also, add unit test.</span></p><p style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal;"><span style=3D"font-kerning: none; -w=
ebkit-text-stroke-color: rgb(255, 255, 255);"></span></p><p style=3D"margin=
: 0px; font-stretch: normal; line-height: normal; font-size-adjust: none; f=
ont-kerning: auto; font-variant-alternates: normal; font-variant-ligatures:=
 normal; font-variant-numeric: normal; font-variant-east-asian: normal; fon=
t-variant-position: normal; font-feature-settings: normal; font-optical-siz=
ing: auto; font-variation-settings: normal;"><span style=3D"-webkit-text-st=
roke-color: rgb(255, 255, 255);">* Http-proxy: fix bug preventing proxy cre=
dentials caching (trac #1187)</span></p><p style=3D"margin: 0px; font-style=
: normal; font-variant-caps: normal; font-stretch: normal; line-height: nor=
mal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: n=
ormal; font-variant-ligatures: normal; font-variant-numeric: normal; font-v=
ariant-east-asian: normal; font-variant-position: normal; font-variant-emoj=
i: normal; font-feature-settings: normal; font-optical-sizing: auto; font-v=
ariation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-str=
oke-color: rgb(255, 255, 255);"><br></p><p style=3D"margin: 0px; font-style=
: normal; font-variant-caps: normal; font-stretch: normal; line-height: nor=
mal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: n=
ormal; font-variant-ligatures: normal; font-variant-numeric: normal; font-v=
ariant-east-asian: normal; font-variant-position: normal; font-variant-emoj=
i: normal; font-feature-settings: normal; font-optical-sizing: auto; font-v=
ariation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-str=
oke-color: rgb(255, 255, 255);">Windows MSI changes since 2.6.11:</p><p sty=
le=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-stre=
tch: normal; line-height: normal; font-size-adjust: none; font-kerning: aut=
o; font-variant-alternates: normal; font-variant-ligatures: normal; font-va=
riant-numeric: normal; font-variant-east-asian: normal; font-variant-positi=
on: normal; font-variant-emoji: normal; font-feature-settings: normal; font=
-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke=
-width: 0px; -webkit-text-stroke-color: rgb(255, 255, 255); min-height: 14p=
x;"><br></p><p style=3D"margin: 0px; font-stretch: normal; line-height: nor=
mal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: n=
ormal; font-variant-ligatures: normal; font-variant-numeric: normal; font-v=
ariant-east-asian: normal; font-variant-position: normal; font-feature-sett=
ings: normal; font-optical-sizing: auto; font-variation-settings: normal;">=
<span style=3D"-webkit-text-stroke-color: rgb(255, 255, 255);">* Built agai=
nst OpenSSL 3.3.1</span></p><p style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; font-varia=
nt-alternates: normal; font-variant-ligatures: normal; font-variant-numeric=
: normal; font-variant-east-asian: normal; font-variant-position: normal; f=
ont-feature-settings: normal; font-optical-sizing: auto; font-variation-set=
tings: normal;"><span style=3D"-webkit-text-stroke-color: rgb(255, 255, 255=
);">* Included openvpn-gui updated to 11.50.0.0</span></p><p style=3D"margi=
n: 0px; font-stretch: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures=
: normal; font-variant-numeric: normal; font-variant-east-asian: normal; fo=
nt-variant-position: normal; font-feature-settings: normal; font-optical-si=
zing: auto; font-variation-settings: normal;"><span style=3D"font-kerning: =
none; -webkit-text-stroke-color: rgb(255, 255, 255);"></span></p><p style=
=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal;"><span style=3D"-webk=
it-text-stroke-color: rgb(255, 255, 255);">&nbsp; &nbsp;*Update Italian lan=
guage (github =E2=80=8B#696)</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">More details can be found in the =
Changes document:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(42=
, 109, 255); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb=
(42, 109, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -w=
ebkit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://github.com/O=
penVPN/openvpn/blob/release/2.6/Changes.rst"><span style=3D"font-kerning: n=
one; color: rgb(42, 109, 255); -webkit-text-stroke-color: rgb(42, 109, 255)=
;">https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst</span></=
a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">(The Changes document also contai=
ns a section with work-arounds for</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">common problems encountered when =
using OpenVPN with OpenSSL 3)</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">Source code and Windows installer=
s can be downloaded from our download page:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(42=
, 109, 255); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb=
(42, 109, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -w=
ebkit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://openvpn.net/=
community-downloads/"><span style=3D"font-kerning: none; color: rgb(42, 109=
, 255); -webkit-text-stroke-color: rgb(42, 109, 255);">https://openvpn.net/=
community-downloads/</span></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">Debian and Ubuntu packages are av=
ailable in the official apt repositories:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(42=
, 109, 255); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb=
(42, 109, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -w=
ebkit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://community.op=
envpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrep=
ositories"><span style=3D"font-kerning: none; color: rgb(42, 109, 255); -we=
bkit-text-stroke-color: rgb(42, 109, 255);">https://community.openvpn.net/o=
penvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories</=
span></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">On Red Hat derivatives we recomme=
nd using the Fedora Copr repository.</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(42=
, 109, 255); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb=
(42, 109, 255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -w=
ebkit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://copr.fedorai=
nfracloud.org/coprs/dsommers/openvpn-release-2.6/"><span style=3D"font-kern=
ing: none; color: rgb(42, 109, 255); -webkit-text-stroke-color: rgb(42, 109=
, 255);">https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release-2=
.6/</span></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">Kind regards,</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-variant-emoji: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0=
, 0);"><span style=3D"font-kerning: none">Yuriy Darnobyt</span></p></body><=
/html>=

--Apple-Mail=_77D3F70E-C190-48BB-8895-4254B80E72A3--

