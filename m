From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_E7D160EB-D7B9-4BB8-B430-68ACEDD1626D"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Message-Id: <0290ABFB-76B6-4C33-B75D-3B9AAE7161B5@...2722...>
Date: Fri, 17 Nov 2023 18:27:35 +0200
Subject: [Openvpn-devel] OpenVPN 2.6.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_E7D160EB-D7B9-4BB8-B430-68ACEDD1626D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.6.8.

This is a small bugfix release fixing a few regressions in 2.6.7 release.

User visible changes:

* Windows: print warning if pushed options require DHCP (e.g. DOMAIN-SEARCH=
) and driver in use does not use DHCP (wintun, dco).

Bug fixes:

* SIGSEGV crash: Do not check key_state buffers that are in S_UNDEF state (=
Github =E2=80=8B#449) - the new sanity check function introduced in 2.6.7 s=
ometimes tried to use a NULL pointer after an unsuccessful TLS handshake
* Windows: --dns option did not work when tap-windows6 driver was used, bec=
ause internal flag for "apply DNS option to DHCP server" wasn't set (Github=
 =E2=80=8B#447)
* Windows: fix status/log file permissions, caused by regression after chan=
ging to CMake build system (Github: =E2=80=8B#454, Trac: =E2=80=8B#1430)
* Windows: fix --chdir failures, also caused by error in CMake build system=
 (Github =E2=80=8B#448)

Windows MSI changes since 2.6.7:

* Included openvpn-gui updated to 11.46.0.0

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

--Apple-Mail=_E7D160EB-D7B9-4BB8-B430-68ACEDD1626D
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-mod=
e: space; line-break: after-white-space;"><p style=3D"margin: 0px; font-sty=
le: normal; font-variant-caps: normal; font-stretch: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-feature-se=
ttings: normal; font-optical-sizing: auto; font-variation-settings: normal;=
 color: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-c=
olor: rgb(0, 0, 0);"><span style=3D"font-kerning: none">The OpenVPN communi=
ty project team is proud to release OpenVPN 2.6.8.</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">This is a small bugfix release fixing a few regressions in 2.=
6.7 release.</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-stretch: normal; line-height: normal; font-si=
ze-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-=
variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-=
asian: normal; font-variant-position: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal;"><font color=
=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0); -webkit-text-stroke-=
color: rgb(0, 0, 0);">User visible changes:</span></font></p><p style=3D"ma=
rgin: 0px; font-stretch: normal; line-height: normal; font-size-adjust: non=
e; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatu=
res: normal; font-variant-numeric: normal; font-variant-east-asian: normal;=
 font-variant-position: normal; font-feature-settings: normal; font-optical=
-sizing: auto; font-variation-settings: normal;"><font color=3D"#000000"><s=
pan style=3D"caret-color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0=
, 0);"><br></span></font></p><p style=3D"margin: 0px; font-stretch: normal;=
 line-height: normal; font-size-adjust: none; font-kerning: auto; font-vari=
ant-alternates: normal; font-variant-ligatures: normal; font-variant-numeri=
c: normal; font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; font-variation-se=
ttings: normal;"><font color=3D"#000000"><span style=3D"caret-color: rgb(0,=
 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* Windows: print warning =
if pushed options require DHCP (e.g. DOMAIN-SEARCH) and driver in use does =
not use DHCP (wintun, dco).</span></font></p><p style=3D"margin: 0px; font-=
stretch: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal;"><font color=3D"#000000"><span style=3D"car=
et-color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br></spa=
n></font></p><p style=3D"margin: 0px; font-stretch: normal; line-height: no=
rmal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: =
normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-=
variant-east-asian: normal; font-variant-position: normal; font-feature-set=
tings: normal; font-optical-sizing: auto; font-variation-settings: normal;"=
><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0); -webkit-=
text-stroke-color: rgb(0, 0, 0);">Bug fixes:</span></font></p><p style=3D"m=
argin: 0px; font-stretch: normal; line-height: normal; font-size-adjust: no=
ne; font-kerning: auto; font-variant-alternates: normal; font-variant-ligat=
ures: normal; font-variant-numeric: normal; font-variant-east-asian: normal=
; font-variant-position: normal; font-feature-settings: normal; font-optica=
l-sizing: auto; font-variation-settings: normal;"><font color=3D"#000000"><=
span style=3D"caret-color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, =
0, 0);"><br></span></font></p><p style=3D"margin: 0px; font-stretch: normal=
; line-height: normal; font-size-adjust: none; font-kerning: auto; font-var=
iant-alternates: normal; font-variant-ligatures: normal; font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-variant-position: normal;=
 font-feature-settings: normal; font-optical-sizing: auto; font-variation-s=
ettings: normal;"><font color=3D"#000000"><span style=3D"caret-color: rgb(0=
, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* SIGSEGV crash: Do not =
check key_state buffers that are in S_UNDEF state (Github =E2=80=8B#449) - =
the new sanity check function introduced in 2.6.7 sometimes tried to use a =
NULL pointer after an unsuccessful TLS handshake</span></font></p><p style=
=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal;"><font color=3D"#0000=
00"><span style=3D"caret-color: rgb(0, 0, 0); -webkit-text-stroke-color: rg=
b(0, 0, 0);">* Windows: --dns option did not work when tap-windows6 driver =
was used, because internal flag for "apply DNS option to DHCP server" wasn'=
t set (Github =E2=80=8B#447)</span></font></p><p style=3D"margin: 0px; font=
-stretch: normal; line-height: normal; font-size-adjust: none; font-kerning=
: auto; font-variant-alternates: normal; font-variant-ligatures: normal; fo=
nt-variant-numeric: normal; font-variant-east-asian: normal; font-variant-p=
osition: normal; font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal;"><font color=3D"#000000"><span style=3D"ca=
ret-color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* Window=
s: fix status/log file permissions, caused by regression after changing to =
CMake build system (Github: =E2=80=8B#454, Trac: =E2=80=8B#1430)</span></fo=
nt></p><p style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal=
; font-variant-ligatures: normal; font-variant-numeric: normal; font-varian=
t-east-asian: normal; font-variant-position: normal; font-feature-settings:=
 normal; font-optical-sizing: auto; font-variation-settings: normal;"><font=
 color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0); -webkit-text-s=
troke-color: rgb(0, 0, 0);">* Windows: fix --chdir failures, also caused by=
 error in CMake build system (Github =E2=80=8B#448)</span></font></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">Windows MSI changes since 2.6.7:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">* Included openvpn-gui updated to 11.46.0.0</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">More details can be found in the Changes document:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(53, 134, 255); -webkit-text-st=
roke-width: 0px; -webkit-text-stroke-color: rgb(53, 134, 255);"><span style=
=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb=
(0, 0, 0);">&lt;<a href=3D"https://github.com/OpenVPN/openvpn/blob/release/=
2.6/Changes.rst"><span style=3D"font-kerning: none; color: rgb(53, 134, 255=
); -webkit-text-stroke-color: rgb(53, 134, 255);">https://github.com/OpenVP=
N/openvpn/blob/release/2.6/Changes.rst</span></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">(The Changes document also contains a section with work-aroun=
ds for</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">common problems encountered when using OpenVPN with OpenSSL 3=
)</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">Source code and Windows installers can be downloaded from our=
 download page:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(53, 134, 255); -webkit-text-st=
roke-width: 0px; -webkit-text-stroke-color: rgb(53, 134, 255);"><span style=
=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb=
(0, 0, 0);">&lt;<a href=3D"https://openvpn.net/community-downloads/"><span =
style=3D"font-kerning: none; color: rgb(53, 134, 255); -webkit-text-stroke-=
color: rgb(53, 134, 255);">https://openvpn.net/community-downloads/</span><=
/a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">Debian and Ubuntu packages are available in the official apt =
repositories:</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(53, 134, 255); -webkit-text-st=
roke-width: 0px; -webkit-text-stroke-color: rgb(53, 134, 255);"><span style=
=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb=
(0, 0, 0);">&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/Openv=
pnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories"><span style=3D"fo=
nt-kerning: none; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(=
53, 134, 255);">https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareR=
epos#DebianUbuntu:UsingOpenVPNaptrepositories</span></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">On Red Hat derivatives we recommend using the Fedora Copr rep=
ository.</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(53, 134, 255); -webkit-text-st=
roke-width: 0px; -webkit-text-stroke-color: rgb(53, 134, 255);"><span style=
=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb=
(0, 0, 0);">&lt;<a href=3D"https://copr.fedorainfracloud.org/coprs/dsommers=
/openvpn-release-2.6/"><span style=3D"font-kerning: none; color: rgb(53, 13=
4, 255); -webkit-text-stroke-color: rgb(53, 134, 255);">https://copr.fedora=
infracloud.org/coprs/dsommers/openvpn-release-2.6/</span></a>&gt;</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><sp=
an style=3D"font-kerning: none"></span><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">Kind regards,</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-k=
erning: none">Yuriy Darnobyt</span></p></body></html>=

--Apple-Mail=_E7D160EB-D7B9-4BB8-B430-68ACEDD1626D--

