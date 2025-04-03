From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_D1FED8A1-2F52-4C3D-A8E7-5174346BDD9B"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Message-Id: <F8589660-D883-4C6F-960F-97BF5DD3A46E@...515...>
Date: Thu, 3 Apr 2025 14:24:03 +0300
Subject: [Openvpn-devel] OpenVPN 2.6.14 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_D1FED8A1-2F52-4C3D-A8E7-5174346BDD9B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.6.14.

This is a bugfix release containing one security fix.

Security fixes:

* CVE-2025-2704: fix possible ASSERT() on OpenVPN servers using --tls-crypt=
-v2 Security scope: OpenVPN servers
  between 2.6.1 and 2.6.13 using --tls-crypt-v2 can be made to abort with a=
n ASSERT() message by sending a particular
  combination of authenticated and malformed packets. To trigger the bug, a=
 valid tls-crypt-v2 client key is needed, or network
  observation of a handshake with a valid tls-crypt-v2 client key. No crypt=
o integrity is violated, no data is leaked, and no remote
  code execution is possible. This bug does not affect OpenVPN clients. (Bu=
g found by internal QA at OpenVPN Inc)

Bug fixes:

* Linux DCO: repair source IP selection for --multihome (Qingfang Deng)

Windows MSI changes since 2.6.13:

* Built against OpenSSL 3.4.1
* Included openvpn-gui updated to 11.52.0.0

    * Use correct %TEMP% directory for debug log file.
    * Disable config in menu listing if its ovpn file becomes inaccessible =
(github openvpn-gui#729)

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

--Apple-Mail=_D1FED8A1-2F52-4C3D-A8E7-5174346BDD9B
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><meta http-equiv=3D"content-ty=
pe" content=3D"text/html; charset=3Dus-ascii"><div style=3D"overflow-wrap: =
break-word; -webkit-nbsp-mode: space; line-break: after-white-space;"><div =
style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-s=
tretch: normal; line-height: normal; font-size-adjust: none; font-kerning: =
auto; font-variant-alternates: normal; font-variant-ligatures: normal; font=
-variant-numeric: normal; font-variant-east-asian: normal; font-variant-pos=
ition: normal; font-feature-settings: normal; font-optical-sizing: auto; fo=
nt-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-wid=
th: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kern=
ing: none">The OpenVPN community project team is proud to release OpenVPN 2=
.6.14.</span></div><div style=3D"margin: 0px; font-style: normal; font-vari=
ant-caps: normal; font-stretch: normal; line-height: normal; font-size-adju=
st: none; font-kerning: auto; font-variant-alternates: normal; font-variant=
-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: =
normal; font-variant-position: normal; font-feature-settings: normal; font-=
optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);=
 -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); m=
in-height: 14px;"><span style=3D"font-kerning: none"></span><br></div><div =
style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-s=
tretch: normal; line-height: normal; font-size-adjust: none; font-kerning: =
auto; font-variant-alternates: normal; font-variant-ligatures: normal; font=
-variant-numeric: normal; font-variant-east-asian: normal; font-variant-pos=
ition: normal; font-feature-settings: normal; font-optical-sizing: auto; fo=
nt-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-wid=
th: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kern=
ing: none">This is a bugfix release containing one security fix.</span></di=
v><div style=3D"margin: 0px; font-style: normal; font-variant-caps: normal;=
 font-stretch: normal; line-height: normal; font-size-adjust: none; font-ke=
rning: auto; font-variant-alternates: normal; font-variant-ligatures: norma=
l; font-variant-numeric: normal; font-variant-east-asian: normal; font-vari=
ant-position: normal; font-feature-settings: normal; font-optical-sizing: a=
uto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-str=
oke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"fo=
nt-kerning: none"><br></span></div><div style=3D"margin: 0px; font-style: n=
ormal; font-variant-caps: normal; font-stretch: normal; line-height: normal=
; font-size-adjust: none; font-kerning: auto; font-variant-alternates: norm=
al; font-variant-ligatures: normal; font-variant-numeric: normal; font-vari=
ant-east-asian: normal; font-variant-position: normal; font-feature-setting=
s: normal; font-optical-sizing: auto; font-variation-settings: normal; colo=
r: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color:=
 rgb(0, 0, 0);"><span style=3D"font-kerning: none">Security fixes:</span></=
div><div style=3D"margin: 0px; font-style: normal; font-variant-caps: norma=
l; font-stretch: normal; line-height: normal; font-size-adjust: none; font-=
kerning: auto; font-variant-alternates: normal; font-variant-ligatures: nor=
mal; font-variant-numeric: normal; font-variant-east-asian: normal; font-va=
riant-position: normal; font-feature-settings: normal; font-optical-sizing:=
 auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-s=
troke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"=
font-kerning: none"><br></span></div><div style=3D"margin: 0px; font-style:=
 normal; font-variant-caps: normal; font-stretch: normal; line-height: norm=
al; font-size-adjust: none; font-kerning: auto; font-variant-alternates: no=
rmal; font-variant-ligatures: normal; font-variant-numeric: normal; font-va=
riant-east-asian: normal; font-variant-position: normal; font-feature-setti=
ngs: normal; font-optical-sizing: auto; font-variation-settings: normal; co=
lor: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-colo=
r: rgb(0, 0, 0);"><span style=3D"font-kerning: none">*&nbsp;CVE-2025-2704: =
fix possible ASSERT() on OpenVPN servers using --tls-crypt-v2 Security scop=
e: OpenVPN servers</span></div><div style=3D"margin: 0px; font-style: norma=
l; font-variant-caps: normal; font-stretch: normal; line-height: normal; fo=
nt-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-=
east-asian: normal; font-variant-position: normal; font-feature-settings: n=
ormal; font-optical-sizing: auto; font-variation-settings: normal; color: r=
gb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb=
(0, 0, 0);"><span style=3D"font-kerning: none">&nbsp; between 2.6.1 and 2.6=
.13 using --tls-crypt-v2 can be made to abort with an ASSERT() message by s=
ending a particular</span></div><div style=3D"margin: 0px; font-style: norm=
al; font-variant-caps: normal; font-stretch: normal; line-height: normal; f=
ont-size-adjust: none; font-kerning: auto; font-variant-alternates: normal;=
 font-variant-ligatures: normal; font-variant-numeric: normal; font-variant=
-east-asian: normal; font-variant-position: normal; font-feature-settings: =
normal; font-optical-sizing: auto; font-variation-settings: normal; color: =
rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rg=
b(0, 0, 0);"><span style=3D"font-kerning: none">&nbsp; combination of authe=
nticated and malformed packets. To trigger the bug, a valid tls-crypt-v2 cl=
ient key is needed, or network</span></div><div style=3D"margin: 0px; font-=
style: normal; font-variant-caps: normal; font-stretch: normal; line-height=
: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternat=
es: normal; font-variant-ligatures: normal; font-variant-numeric: normal; f=
ont-variant-east-asian: normal; font-variant-position: normal; font-feature=
-settings: normal; font-optical-sizing: auto; font-variation-settings: norm=
al; color: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-strok=
e-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none">&nbsp; observati=
on of a handshake with a valid tls-crypt-v2 client key. No crypto integrity=
 is violated, no data is leaked,&nbsp;</span>and no remote</div><div style=
=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-stretc=
h: normal; line-height: normal; font-size-adjust: none; font-kerning: auto;=
 font-variant-alternates: normal; font-variant-ligatures: normal; font-vari=
ant-numeric: normal; font-variant-east-asian: normal; font-variant-position=
: normal; font-feature-settings: normal; font-optical-sizing: auto; font-va=
riation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-width: 0=
px; -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; code execution is poss=
ible. This bug does not affect OpenVPN clients. (Bug found by internal QA a=
t OpenVPN Inc)</div><div style=3D"margin: 0px; font-style: normal; font-var=
iant-caps: normal; font-stretch: normal; line-height: normal; font-size-adj=
ust: none; font-kerning: auto; font-variant-alternates: normal; font-varian=
t-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian:=
 normal; font-variant-position: normal; font-feature-settings: normal; font=
-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0)=
; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); =
min-height: 14px;"><span style=3D"font-kerning: none"></span><br></div><div=
 style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-=
stretch: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-tex=
t-stroke-color: rgb(255, 255, 255);"><span style=3D"font-kerning: none">Bug=
 fixes:</span></div><div style=3D"margin: 0px; font-style: normal; font-var=
iant-caps: normal; font-stretch: normal; line-height: normal; font-size-adj=
ust: none; font-kerning: auto; font-variant-alternates: normal; font-varian=
t-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian:=
 normal; font-variant-position: normal; font-feature-settings: normal; font=
-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke=
-width: 0px; -webkit-text-stroke-color: rgb(255, 255, 255); min-height: 14p=
x;"><span style=3D"font-kerning: none"></span><br></div><div style=3D"margi=
n: 0px; font-style: normal; font-variant-caps: normal; font-stretch: normal=
; line-height: normal; font-size-adjust: none; font-kerning: auto; font-var=
iant-alternates: normal; font-variant-ligatures: normal; font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-variant-position: normal;=
 font-feature-settings: normal; font-optical-sizing: auto; font-variation-s=
ettings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color:=
 rgb(255, 255, 255);"><span style=3D"font-kerning: none">*&nbsp;Linux DCO: =
repair source IP selection for --multihome (Qingfang Deng)</span></div><div=
 style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-=
stretch: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-tex=
t-stroke-color: rgb(255, 255, 255); min-height: 14px;"><br></div><div style=
=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal; min-height: 14px;"><f=
ont color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0); -webkit-tex=
t-stroke-color: rgb(0, 0, 0);">Windows MSI changes since 2.6.13:</span></fo=
nt></div><div style=3D"margin: 0px; font-stretch: normal; line-height: norm=
al; font-size-adjust: none; font-kerning: auto; font-variant-alternates: no=
rmal; font-variant-ligatures: normal; font-variant-numeric: normal; font-va=
riant-east-asian: normal; font-variant-position: normal; font-feature-setti=
ngs: normal; font-optical-sizing: auto; font-variation-settings: normal; mi=
n-height: 14px;"><font color=3D"#000000"><span style=3D"caret-color: rgb(0,=
 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br></span></font></div><=
div style=3D"margin: 0px; font-stretch: normal; line-height: normal; font-s=
ize-adjust: none; font-kerning: auto; font-variant-alternates: normal; font=
-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east=
-asian: normal; font-variant-position: normal; font-feature-settings: norma=
l; font-optical-sizing: auto; font-variation-settings: normal; min-height: =
14px;"><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0); -w=
ebkit-text-stroke-color: rgb(0, 0, 0);">* Built against OpenSSL 3.4.1</span=
></font></div><div style=3D"margin: 0px; font-stretch: normal; line-height:=
 normal; font-size-adjust: none; font-kerning: auto; font-variant-alternate=
s: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fo=
nt-variant-east-asian: normal; font-variant-position: normal; font-feature-=
settings: normal; font-optical-sizing: auto; font-variation-settings: norma=
l; min-height: 14px;"><font color=3D"#000000"><span style=3D"caret-color: r=
gb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* Included openvpn-g=
ui updated to 11.52.0.0</span></font></div><div style=3D"margin: 0px; font-=
stretch: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; min-height: 14px;"><font color=3D"#000000">=
<span style=3D"caret-color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0,=
 0, 0);"><br></span></font></div><div style=3D"margin: 0px; font-stretch: n=
ormal; line-height: normal; font-size-adjust: none; font-kerning: auto; fon=
t-variant-alternates: normal; font-variant-ligatures: normal; font-variant-=
numeric: normal; font-variant-east-asian: normal; font-variant-position: no=
rmal; font-feature-settings: normal; font-optical-sizing: auto; font-variat=
ion-settings: normal; min-height: 14px;"><font color=3D"#000000"><span styl=
e=3D"caret-color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&=
nbsp; &nbsp; * Use correct %TEMP% directory for debug log file.</span></fon=
t></div><div style=3D"margin: 0px; font-stretch: normal; line-height: norma=
l; font-size-adjust: none; font-kerning: auto; font-variant-alternates: nor=
mal; font-variant-ligatures: normal; font-variant-numeric: normal; font-var=
iant-east-asian: normal; font-variant-position: normal; font-feature-settin=
gs: normal; font-optical-sizing: auto; font-variation-settings: normal; min=
-height: 14px;"><font color=3D"#000000"><span style=3D"caret-color: rgb(0, =
0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * Disable co=
nfig in menu listing if its ovpn file becomes inaccessible (github openvpn-=
gui#729)</span></font></div><div style=3D"margin: 0px; font-style: normal; =
font-variant-caps: normal; font-stretch: normal; line-height: normal; font-=
size-adjust: none; font-kerning: auto; font-variant-alternates: normal; fon=
t-variant-ligatures: normal; font-variant-numeric: normal; font-variant-eas=
t-asian: normal; font-variant-position: normal; font-feature-settings: norm=
al; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(=
0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0,=
 0, 0); min-height: 14px;"><br></div><div style=3D"margin: 0px; font-style:=
 normal; font-variant-caps: normal; font-stretch: normal; line-height: norm=
al; font-size-adjust: none; font-kerning: auto; font-variant-alternates: no=
rmal; font-variant-ligatures: normal; font-variant-numeric: normal; font-va=
riant-east-asian: normal; font-variant-position: normal; font-feature-setti=
ngs: normal; font-optical-sizing: auto; font-variation-settings: normal; co=
lor: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-colo=
r: rgb(0, 0, 0);"><span style=3D"font-kerning: none">More details can be fo=
und in the Changes document:</span></div><div style=3D"margin: 0px; font-st=
yle: normal; font-variant-caps: normal; font-stretch: normal; line-height: =
normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates=
: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fon=
t-variant-east-asian: normal; font-variant-position: normal; font-feature-s=
ettings: normal; font-optical-sizing: auto; font-variation-settings: normal=
; color: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-=
color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: none">=
</span><br></div><div style=3D"margin: 0px; font-style: normal; font-varian=
t-caps: normal; font-stretch: normal; line-height: normal; font-size-adjust=
: none; font-kerning: auto; font-variant-alternates: normal; font-variant-l=
igatures: normal; font-variant-numeric: normal; font-variant-east-asian: no=
rmal; font-variant-position: normal; font-feature-settings: normal; font-op=
tical-sizing: auto; font-variation-settings: normal; color: rgb(33, 81, 255=
); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(33, 81, 2=
55);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-=
stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://github.com/OpenVPN/open=
vpn/blob/release/2.6/Changes.rst"><span style=3D"font-kerning: none; color:=
 rgb(33, 81, 255); -webkit-text-stroke-color: rgb(33, 81, 255);">https://gi=
thub.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst</span></a>&gt;</span>=
</div><div style=3D"margin: 0px; font-style: normal; font-variant-caps: nor=
mal; font-stretch: normal; line-height: normal; font-size-adjust: none; fon=
t-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: n=
ormal; font-variant-numeric: normal; font-variant-east-asian: normal; font-=
variant-position: normal; font-feature-settings: normal; font-optical-sizin=
g: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text=
-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14=
px;"><span style=3D"font-kerning: none"></span><br></div><div style=3D"marg=
in: 0px; font-style: normal; font-variant-caps: normal; font-stretch: norma=
l; line-height: normal; font-size-adjust: none; font-kerning: auto; font-va=
riant-alternates: normal; font-variant-ligatures: normal; font-variant-nume=
ric: normal; font-variant-east-asian: normal; font-variant-position: normal=
; font-feature-settings: normal; font-optical-sizing: auto; font-variation-=
settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -web=
kit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none">(T=
he Changes document also contains a section with work-arounds for</span></d=
iv><div style=3D"margin: 0px; font-style: normal; font-variant-caps: normal=
; font-stretch: normal; line-height: normal; font-size-adjust: none; font-k=
erning: auto; font-variant-alternates: normal; font-variant-ligatures: norm=
al; font-variant-numeric: normal; font-variant-east-asian: normal; font-var=
iant-position: normal; font-feature-settings: normal; font-optical-sizing: =
auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-st=
roke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"f=
ont-kerning: none">common problems encountered when using OpenVPN with Open=
SSL 3)</span></div><div style=3D"margin: 0px; font-style: normal; font-vari=
ant-caps: normal; font-stretch: normal; line-height: normal; font-size-adju=
st: none; font-kerning: auto; font-variant-alternates: normal; font-variant=
-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: =
normal; font-variant-position: normal; font-feature-settings: normal; font-=
optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);=
 -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); m=
in-height: 14px;"><span style=3D"font-kerning: none"></span><br></div><div =
style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-s=
tretch: normal; line-height: normal; font-size-adjust: none; font-kerning: =
auto; font-variant-alternates: normal; font-variant-ligatures: normal; font=
-variant-numeric: normal; font-variant-east-asian: normal; font-variant-pos=
ition: normal; font-feature-settings: normal; font-optical-sizing: auto; fo=
nt-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-wid=
th: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kern=
ing: none">Source code and Windows installers can be downloaded from our do=
wnload page:</span></div><div style=3D"margin: 0px; font-style: normal; fon=
t-variant-caps: normal; font-stretch: normal; line-height: normal; font-siz=
e-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-v=
ariant-ligatures: normal; font-variant-numeric: normal; font-variant-east-a=
sian: normal; font-variant-position: normal; font-feature-settings: normal;=
 font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, =
0, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0,=
 0); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></div=
><div style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-stretch: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal; color: rgb(33, 81, 255); -webkit-text-=
stroke-width: 0px; -webkit-text-stroke-color: rgb(33, 81, 255);"><span styl=
e=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rg=
b(0, 0, 0);">&lt;<a href=3D"https://openvpn.net/community-downloads/"><span=
 style=3D"font-kerning: none; color: rgb(33, 81, 255); -webkit-text-stroke-=
color: rgb(33, 81, 255);">https://openvpn.net/community-downloads/</span></=
a>&gt;</span></div><div style=3D"margin: 0px; font-style: normal; font-vari=
ant-caps: normal; font-stretch: normal; line-height: normal; font-size-adju=
st: none; font-kerning: auto; font-variant-alternates: normal; font-variant=
-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: =
normal; font-variant-position: normal; font-feature-settings: normal; font-=
optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);=
 -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); m=
in-height: 14px;"><span style=3D"font-kerning: none"></span><br></div><div =
style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-s=
tretch: normal; line-height: normal; font-size-adjust: none; font-kerning: =
auto; font-variant-alternates: normal; font-variant-ligatures: normal; font=
-variant-numeric: normal; font-variant-east-asian: normal; font-variant-pos=
ition: normal; font-feature-settings: normal; font-optical-sizing: auto; fo=
nt-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-wid=
th: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kern=
ing: none">Debian and Ubuntu packages are available in the official apt rep=
ositories:</span></div><div style=3D"margin: 0px; font-style: normal; font-=
variant-caps: normal; font-stretch: normal; line-height: normal; font-size-=
adjust: none; font-kerning: auto; font-variant-alternates: normal; font-var=
iant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asi=
an: normal; font-variant-position: normal; font-feature-settings: normal; f=
ont-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0,=
 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0=
); min-height: 14px;"><span style=3D"font-kerning: none"></span><br></div><=
div style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fo=
nt-stretch: normal; line-height: normal; font-size-adjust: none; font-kerni=
ng: auto; font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; font-variant=
-position: normal; font-feature-settings: normal; font-optical-sizing: auto=
; font-variation-settings: normal; color: rgb(33, 81, 255); -webkit-text-st=
roke-width: 0px; -webkit-text-stroke-color: rgb(33, 81, 255);"><span style=
=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb=
(0, 0, 0);">&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/Openv=
pnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories"><span style=3D"fo=
nt-kerning: none; color: rgb(33, 81, 255); -webkit-text-stroke-color: rgb(3=
3, 81, 255);">https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRep=
os#DebianUbuntu:UsingOpenVPNaptrepositories</span></a>&gt;</span></div><div=
 style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-=
stretch: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-wi=
dth: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span=
 style=3D"font-kerning: none"></span><br></div><div style=3D"margin: 0px; f=
ont-style: normal; font-variant-caps: normal; font-stretch: normal; line-he=
ight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alte=
rnates: normal; font-variant-ligatures: normal; font-variant-numeric: norma=
l; font-variant-east-asian: normal; font-variant-position: normal; font-fea=
ture-settings: normal; font-optical-sizing: auto; font-variation-settings: =
normal; color: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-s=
troke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none">On Red Hat d=
erivatives we recommend using the Fedora Copr repository.</span></div><div =
style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-s=
tretch: normal; line-height: normal; font-size-adjust: none; font-kerning: =
auto; font-variant-alternates: normal; font-variant-ligatures: normal; font=
-variant-numeric: normal; font-variant-east-asian: normal; font-variant-pos=
ition: normal; font-feature-settings: normal; font-optical-sizing: auto; fo=
nt-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-wid=
th: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span =
style=3D"font-kerning: none"></span><br></div><div style=3D"margin: 0px; fo=
nt-style: normal; font-variant-caps: normal; font-stretch: normal; line-hei=
ght: normal; font-size-adjust: none; font-kerning: auto; font-variant-alter=
nates: normal; font-variant-ligatures: normal; font-variant-numeric: normal=
; font-variant-east-asian: normal; font-variant-position: normal; font-feat=
ure-settings: normal; font-optical-sizing: auto; font-variation-settings: n=
ormal; color: rgb(33, 81, 255); -webkit-text-stroke-width: 0px; -webkit-tex=
t-stroke-color: rgb(33, 81, 255);"><span style=3D"font-kerning: none; color=
: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"ht=
tps://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release-2.6/"><span =
style=3D"font-kerning: none; color: rgb(33, 81, 255); -webkit-text-stroke-c=
olor: rgb(33, 81, 255);">https://copr.fedorainfracloud.org/coprs/dsommers/o=
penvpn-release-2.6/</span></a>&gt;</span></div><div style=3D"margin: 0px; f=
ont-style: normal; font-variant-caps: normal; font-stretch: normal; line-he=
ight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alte=
rnates: normal; font-variant-ligatures: normal; font-variant-numeric: norma=
l; font-variant-east-asian: normal; font-variant-position: normal; font-fea=
ture-settings: normal; font-optical-sizing: auto; font-variation-settings: =
normal; color: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-s=
troke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: =
none"></span><br></div><div style=3D"margin: 0px; font-style: normal; font-=
variant-caps: normal; font-stretch: normal; line-height: normal; font-size-=
adjust: none; font-kerning: auto; font-variant-alternates: normal; font-var=
iant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asi=
an: normal; font-variant-position: normal; font-feature-settings: normal; f=
ont-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0,=
 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0=
);"><span style=3D"font-kerning: none">Kind regards,</span></div><div style=
=3D"margin: 0px; font-style: normal; font-variant-caps: normal; font-stretc=
h: normal; line-height: normal; font-size-adjust: none; font-kerning: auto;=
 font-variant-alternates: normal; font-variant-ligatures: normal; font-vari=
ant-numeric: normal; font-variant-east-asian: normal; font-variant-position=
: normal; font-feature-settings: normal; font-optical-sizing: auto; font-va=
riation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-width: 0=
px; -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: =
none">Yuriy Darnobyt</span></div></div></body></html>=

--Apple-Mail=_D1FED8A1-2F52-4C3D-A8E7-5174346BDD9B--

