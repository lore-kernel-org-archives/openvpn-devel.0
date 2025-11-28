From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_F5A70176-DB45-4CCC-A05E-2DAB83FED743"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Message-Id: <7BB31ECE-5943-44AA-B1A1-4DD27289DCFD@...2722...>
Date: Fri, 28 Nov 2025 21:44:14 +0200
Subject: [Openvpn-devel] OpenVPN 2.7_rc3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--Apple-Mail=_F5A70176-DB45-4CCC-A05E-2DAB83FED743
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_rc3.

This is the third release candidate for the feature release 2.7.0.

Security fixes:

* CVE-2025-13751: Windows/interactive service: fix bug where the interactiv=
e service would error-exit in
  certain error conditions instead of just logging the fact and
  continuing.  After the error-exit, OpenVPN connections will no
  longer work until the service is restarted (or the system rebooted).
  This can be triggered by any authenticated local user, and has
  thus been classified as a "local denial of service" attack.

Important bug fixes since 2.7_rc2:

* Windows/Interactive Service bugfixes:
  many small bugfixes to registry-related DNS domain handling
* Windows/Interactive Service: harden service pipe handling
  close a small race condition, and add restrictive ACLs
* more type conversion related warnings have been fixed
* --multihome behaviour regarding egress interface selection has been
  changed. See Changes.rst and manpage for details.
* cleanup dead code in event handling code (leftover of the multisocket
  patch set)
* add new feature, --tls-crypt-v2-max-age n.  See Changes.rst and
  manpage for details.
* improve documentation to point out the pitfalls of case-insensitive
  filesystems and --client-config-dir
* split default gateway query logic in two:=20
    * for --redirect-gateway functionality, query for the gateway towards=20
      the actual IP address of the VPN server connecting to
    * for the "net_gateway" special destination for --route, and the=20
      corresponding environment variable, always query for 0.0.0.0 / ::
  (this will only make a difference in certain scenarios using a local=20
  proxy, or on a system with multiple interfaces, not using the "default
  route" for the VPN connection * see github#890)
* upgrade embedded pkcs11-helper vcpkg + pkcs11-uri patch to 1.31=20
* CMake / autoconf cleanup wrt unused checks, outdated old-Linux checks,=20
  Windows oddities
* DCO (primarily Linux): improve handling of bulk notifications from
  kernel (do not lose notifications, do not crash) (github#900)

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

--Apple-Mail=_F5A70176-DB45-4CCC-A05E-2DAB83FED743
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
enVPN 2.7_rc3.</p><p style=3D"margin: 0px; font-width: normal; line-height:=
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
 0); -webkit-text-stroke-color: rgb(0, 0, 0);">This is the third release ca=
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
; -webkit-text-stroke-color: rgb(0, 0, 0);">* CVE-2025-13751: Windows/inter=
active service: fix bug where the interactive service would error-exit in</=
p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-si=
ze-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-=
variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-=
asian: normal; font-variant-position: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; certain error cond=
itions instead of just logging the fact and</p><p style=3D"margin: 0px; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-co=
lor: rgb(0, 0, 0);">&nbsp; continuing. &nbsp;After the error-exit, OpenVPN =
connections will no</p><p style=3D"margin: 0px; font-width: normal; line-he=
ight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alte=
rnates: normal; font-variant-ligatures: normal; font-variant-numeric: norma=
l; font-variant-east-asian: normal; font-variant-position: normal; font-fea=
ture-settings: normal; font-optical-sizing: auto; font-variation-settings: =
normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbs=
p; longer work until the service is restarted (or the system rebooted).</p>=
<p style=3D"margin: 0px; font-width: normal; line-height: normal; font-size=
-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-va=
riant-ligatures: normal; font-variant-numeric: normal; font-variant-east-as=
ian: normal; font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; This can be triggere=
d by any authenticated local user, and has</p><p style=3D"margin: 0px; font=
-width: normal; line-height: normal; font-size-adjust: none; font-kerning: =
auto; font-variant-alternates: normal; font-variant-ligatures: normal; font=
-variant-numeric: normal; font-variant-east-asian: normal; font-variant-pos=
ition: normal; font-feature-settings: normal; font-optical-sizing: auto; fo=
nt-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-col=
or: rgb(0, 0, 0);">&nbsp; thus been classified as a "local denial of servic=
e" attack.</p><p style=3D"margin: 0px; font-width: normal; line-height: nor=
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
 -webkit-text-stroke-color: rgb(0, 0, 0);">Important bug fixes since 2.7_rc=
2:</p><p style=3D"margin: 0px; font-width: normal; line-height: normal; fon=
t-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; f=
ont-variant-ligatures: normal; font-variant-numeric: normal; font-variant-e=
ast-asian: normal; font-variant-position: normal; font-feature-settings: no=
rmal; font-optical-sizing: auto; font-variation-settings: normal; color: rg=
b(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><br></p><p style=3D"m=
argin: 0px; font-width: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0);">* Windows/Interactive Service bugfixes:<=
/p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-s=
ize-adjust: none; font-kerning: auto; font-variant-alternates: normal; font=
-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east=
-asian: normal; font-variant-position: normal; font-feature-settings: norma=
l; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0=
, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; many small bugfix=
es to registry-related DNS domain handling</p><p style=3D"margin: 0px; font=
-width: normal; line-height: normal; font-size-adjust: none; font-kerning: =
auto; font-variant-alternates: normal; font-variant-ligatures: normal; font=
-variant-numeric: normal; font-variant-east-asian: normal; font-variant-pos=
ition: normal; font-feature-settings: normal; font-optical-sizing: auto; fo=
nt-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-col=
or: rgb(0, 0, 0);">* Windows/Interactive Service: harden service pipe handl=
ing</p><p style=3D"margin: 0px; font-width: normal; line-height: normal; fo=
nt-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-=
east-asian: normal; font-variant-position: normal; font-feature-settings: n=
ormal; font-optical-sizing: auto; font-variation-settings: normal; color: r=
gb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; close a small=
 race condition, and add restrictive ACLs</p><p style=3D"margin: 0px; font-=
width: normal; line-height: normal; font-size-adjust: none; font-kerning: a=
uto; font-variant-alternates: normal; font-variant-ligatures: normal; font-=
variant-numeric: normal; font-variant-east-asian: normal; font-variant-posi=
tion: normal; font-feature-settings: normal; font-optical-sizing: auto; fon=
t-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-colo=
r: rgb(0, 0, 0);">* more type conversion related warnings have been fixed</=
p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-si=
ze-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-=
variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-=
asian: normal; font-variant-position: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* --multihome behaviour r=
egarding egress interface selection has been</p><p style=3D"margin: 0px; fo=
nt-width: normal; line-height: normal; font-size-adjust: none; font-kerning=
: auto; font-variant-alternates: normal; font-variant-ligatures: normal; fo=
nt-variant-numeric: normal; font-variant-east-asian: normal; font-variant-p=
osition: normal; font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-c=
olor: rgb(0, 0, 0);">&nbsp; changed. See Changes.rst and manpage for detail=
s.</p><p style=3D"margin: 0px; font-width: normal; line-height: normal; fon=
t-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; f=
ont-variant-ligatures: normal; font-variant-numeric: normal; font-variant-e=
ast-asian: normal; font-variant-position: normal; font-feature-settings: no=
rmal; font-optical-sizing: auto; font-variation-settings: normal; color: rg=
b(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* cleanup dead code i=
n event handling code (leftover of the multisocket</p><p style=3D"margin: 0=
px; font-width: normal; line-height: normal; font-size-adjust: none; font-k=
erning: auto; font-variant-alternates: normal; font-variant-ligatures: norm=
al; font-variant-numeric: normal; font-variant-east-asian: normal; font-var=
iant-position: normal; font-feature-settings: normal; font-optical-sizing: =
auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-st=
roke-color: rgb(0, 0, 0);">&nbsp; patch set)</p><p style=3D"margin: 0px; fo=
nt-width: normal; line-height: normal; font-size-adjust: none; font-kerning=
: auto; font-variant-alternates: normal; font-variant-ligatures: normal; fo=
nt-variant-numeric: normal; font-variant-east-asian: normal; font-variant-p=
osition: normal; font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-c=
olor: rgb(0, 0, 0);">* add new feature, --tls-crypt-v2-max-age n. &nbsp;See=
 Changes.rst and</p><p style=3D"margin: 0px; font-width: normal; line-heigh=
t: normal; font-size-adjust: none; font-kerning: auto; font-variant-alterna=
tes: normal; font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; font-featur=
e-settings: normal; font-optical-sizing: auto; font-variation-settings: nor=
mal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; =
manpage for details.</p><p style=3D"margin: 0px; font-width: normal; line-h=
eight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alt=
ernates: normal; font-variant-ligatures: normal; font-variant-numeric: norm=
al; font-variant-east-asian: normal; font-variant-position: normal; font-fe=
ature-settings: normal; font-optical-sizing: auto; font-variation-settings:=
 normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* i=
mprove documentation to point out the pitfalls of case-insensitive</p><p st=
yle=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adju=
st: none; font-kerning: auto; font-variant-alternates: normal; font-variant=
-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: =
normal; font-variant-position: normal; font-feature-settings: normal; font-=
optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);=
 -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; filesystems and --client-=
config-dir</p><p style=3D"margin: 0px; font-width: normal; line-height: nor=
mal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: n=
ormal; font-variant-ligatures: normal; font-variant-numeric: normal; font-v=
ariant-east-asian: normal; font-variant-position: normal; font-feature-sett=
ings: normal; font-optical-sizing: auto; font-variation-settings: normal; c=
olor: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* split defau=
lt gateway query logic in two:&nbsp;</p><p style=3D"margin: 0px; font-width=
: normal; line-height: normal; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; font-varia=
nt-numeric: normal; font-variant-east-asian: normal; font-variant-position:=
 normal; font-feature-settings: normal; font-optical-sizing: auto; font-var=
iation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rg=
b(0, 0, 0);">&nbsp; &nbsp; * for --redirect-gateway functionality, query fo=
r the gateway towards&nbsp;</p><p style=3D"margin: 0px; font-width: normal;=
 line-height: normal; font-size-adjust: none; font-kerning: auto; font-vari=
ant-alternates: normal; font-variant-ligatures: normal; font-variant-numeri=
c: normal; font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; font-variation-se=
ttings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0=
);">&nbsp; &nbsp; &nbsp; the actual IP address of the VPN server connecting=
 to</p><p style=3D"margin: 0px; font-width: normal; line-height: normal; fo=
nt-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-=
east-asian: normal; font-variant-position: normal; font-feature-settings: n=
ormal; font-optical-sizing: auto; font-variation-settings: normal; color: r=
gb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; * for =
the "net_gateway" special destination for --route, and the&nbsp;</p><p styl=
e=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjust=
: none; font-kerning: auto; font-variant-alternates: normal; font-variant-l=
igatures: normal; font-variant-numeric: normal; font-variant-east-asian: no=
rmal; font-variant-position: normal; font-feature-settings: normal; font-op=
tical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -=
webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; corresponding=
 environment variable, always query for 0.0.0.0 / ::</p><p style=3D"margin:=
 0px; font-width: normal; line-height: normal; font-size-adjust: none; font=
-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: no=
rmal; font-variant-numeric: normal; font-variant-east-asian: normal; font-v=
ariant-position: normal; font-feature-settings: normal; font-optical-sizing=
: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-=
stroke-color: rgb(0, 0, 0);">&nbsp; (this will only make a difference in ce=
rtain scenarios using a local&nbsp;</p><p style=3D"margin: 0px; font-width:=
 normal; line-height: normal; font-size-adjust: none; font-kerning: auto; f=
ont-variant-alternates: normal; font-variant-ligatures: normal; font-varian=
t-numeric: normal; font-variant-east-asian: normal; font-variant-position: =
normal; font-feature-settings: normal; font-optical-sizing: auto; font-vari=
ation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb=
(0, 0, 0);">&nbsp; proxy, or on a system with multiple interfaces, not usin=
g the "default</p><p style=3D"margin: 0px; font-width: normal; line-height:=
 normal; font-size-adjust: none; font-kerning: auto; font-variant-alternate=
s: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fo=
nt-variant-east-asian: normal; font-variant-position: normal; font-feature-=
settings: normal; font-optical-sizing: auto; font-variation-settings: norma=
l; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; ro=
ute" for the VPN connection * see github#890)</p><p style=3D"margin: 0px; f=
ont-width: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-=
color: rgb(0, 0, 0);">* upgrade embedded pkcs11-helper vcpkg + pkcs11-uri p=
atch to 1.31&nbsp;</p><p style=3D"margin: 0px; font-width: normal; line-hei=
ght: normal; font-size-adjust: none; font-kerning: auto; font-variant-alter=
nates: normal; font-variant-ligatures: normal; font-variant-numeric: normal=
; font-variant-east-asian: normal; font-variant-position: normal; font-feat=
ure-settings: normal; font-optical-sizing: auto; font-variation-settings: n=
ormal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* CMa=
ke / autoconf cleanup wrt unused checks, outdated old-Linux checks,&nbsp;</=
p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-si=
ze-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-=
variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-=
asian: normal; font-variant-position: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&nbsp; Windows oddities</=
p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-si=
ze-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-=
variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-=
asian: normal; font-variant-position: normal; font-feature-settings: normal=
; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0,=
 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">* DCO (primarily Linux): =
improve handling of bulk notifications from</p><p style=3D"margin: 0px; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-co=
lor: rgb(0, 0, 0);">&nbsp; kernel (do not lose notifications, do not crash)=
 (github#900)</p><p style=3D"margin: 0px; font-width: normal; line-height: =
normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates=
: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fon=
t-variant-east-asian: normal; font-variant-position: normal; font-feature-s=
ettings: normal; font-optical-sizing: auto; font-variation-settings: normal=
; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min-height:=
 14px;"><span style=3D"font-kerning: none;"></span><br></p><p style=3D"marg=
in: 0px; font-width: normal; line-height: normal; font-size-adjust: none; f=
ont-kerning: auto; font-variant-alternates: normal; font-variant-ligatures:=
 normal; font-variant-numeric: normal; font-variant-east-asian: normal; fon=
t-variant-position: normal; font-feature-settings: normal; font-optical-siz=
ing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-te=
xt-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">More de=
tails can be found in the Changes document:</span></p><p style=3D"margin: 0=
px; font-width: normal; line-height: normal; font-size-adjust: none; font-k=
erning: auto; font-variant-alternates: normal; font-variant-ligatures: norm=
al; font-variant-numeric: normal; font-variant-east-asian: normal; font-var=
iant-position: normal; font-feature-settings: normal; font-optical-sizing: =
auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-st=
roke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: n=
one;"></span><br></p><p style=3D"margin: 0px; font-width: normal; line-heig=
ht: normal; font-size-adjust: none; font-kerning: auto; font-variant-altern=
ates: normal; font-variant-ligatures: normal; font-variant-numeric: normal;=
 font-variant-east-asian: normal; font-variant-position: normal; font-featu=
re-settings: normal; font-optical-sizing: auto; font-variation-settings: no=
rmal; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255=
);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-st=
roke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://github.com/OpenVPN/openvp=
n/blob/master/Changes.rst"><span style=3D"font-kerning: none; color: rgb(53=
, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);">https://github.=
com/OpenVPN/openvpn/blob/master/Changes.rst</span></a>&gt;</span></p><p sty=
le=3D"margin: 0px; font-width: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"=
font-kerning: none;"></span><br></p><p style=3D"margin: 0px; font-width: no=
rmal; line-height: normal; font-size-adjust: none; font-kerning: auto; font=
-variant-alternates: normal; font-variant-ligatures: normal; font-variant-n=
umeric: normal; font-variant-east-asian: normal; font-variant-position: nor=
mal; font-feature-settings: normal; font-optical-sizing: auto; font-variati=
on-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0,=
 0, 0);"><span style=3D"font-kerning: none;">Source code and Windows instal=
lers can be downloaded from our download page:</span></p><p style=3D"margin=
: 0px; font-width: normal; line-height: normal; font-size-adjust: none; fon=
t-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: n=
ormal; font-variant-numeric: normal; font-variant-east-asian: normal; font-=
variant-position: normal; font-feature-settings: normal; font-optical-sizin=
g: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text=
-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning=
: none;"></span><br></p><p style=3D"margin: 0px; font-width: normal; line-h=
eight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alt=
ernates: normal; font-variant-ligatures: normal; font-variant-numeric: norm=
al; font-variant-east-asian: normal; font-variant-position: normal; font-fe=
ature-settings: normal; font-optical-sizing: auto; font-variation-settings:=
 normal; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, =
255);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text=
-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://openvpn.net/community-=
downloads/"><span style=3D"font-kerning: none; color: rgb(53, 134, 255); -w=
ebkit-text-stroke-color: rgb(53, 134, 255);">https://openvpn.net/community-=
downloads/</span></a>&gt;</span></p><p style=3D"margin: 0px; font-width: no=
rmal; line-height: normal; font-size-adjust: none; font-kerning: auto; font=
-variant-alternates: normal; font-variant-ligatures: normal; font-variant-n=
umeric: normal; font-variant-east-asian: normal; font-variant-position: nor=
mal; font-feature-settings: normal; font-optical-sizing: auto; font-variati=
on-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0,=
 0, 0); min-height: 14px;"><span style=3D"font-kerning: none;"></span><br><=
/p><p style=3D"margin: 0px; font-width: normal; line-height: normal; font-s=
ize-adjust: none; font-kerning: auto; font-variant-alternates: normal; font=
-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east=
-asian: normal; font-variant-position: normal; font-feature-settings: norma=
l; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0=
, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kern=
ing: none;">Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are ava=
ilable in the various</span></p><p style=3D"margin: 0px; font-width: normal=
; line-height: normal; font-size-adjust: none; font-kerning: auto; font-var=
iant-alternates: normal; font-variant-ligatures: normal; font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-variant-position: normal;=
 font-feature-settings: normal; font-optical-sizing: auto; font-variation-s=
ettings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none;">official Community repositories:</=
span></p><p style=3D"margin: 0px; font-width: normal; line-height: normal; =
font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal=
; font-variant-ligatures: normal; font-variant-numeric: normal; font-varian=
t-east-asian: normal; font-variant-position: normal; font-feature-settings:=
 normal; font-optical-sizing: auto; font-variation-settings: normal; color:=
 rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;">=
<span style=3D"font-kerning: none;"></span><br></p><p style=3D"margin: 0px;=
 font-width: normal; line-height: normal; font-size-adjust: none; font-kern=
ing: auto; font-variant-alternates: normal; font-variant-ligatures: normal;=
 font-variant-numeric: normal; font-variant-east-asian: normal; font-varian=
t-position: normal; font-feature-settings: normal; font-optical-sizing: aut=
o; font-variation-settings: normal; color: rgb(53, 134, 255); -webkit-text-=
stroke-color: rgb(53, 134, 255);"><span style=3D"font-kerning: none; color:=
 rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);">&lt;<a href=3D"htt=
ps://community.openvpn.net/Pages/OpenVPN%20software%20repos"><span style=3D=
"font-kerning: none; color: rgb(53, 134, 255); -webkit-text-stroke-color: r=
gb(53, 134, 255);">https://community.openvpn.net/Pages/OpenVPN%20software%2=
0repos</span></a>&gt;</span></p><p style=3D"margin: 0px; font-width: normal=
; line-height: normal; font-size-adjust: none; font-kerning: auto; font-var=
iant-alternates: normal; font-variant-ligatures: normal; font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-variant-position: normal;=
 font-feature-settings: normal; font-optical-sizing: auto; font-variation-s=
ettings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, =
0); min-height: 14px;"><span style=3D"font-kerning: none;"></span><br></p><=
p style=3D"margin: 0px; font-width: normal; line-height: normal; font-size-=
adjust: none; font-kerning: auto; font-variant-alternates: normal; font-var=
iant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asi=
an: normal; font-variant-position: normal; font-feature-settings: normal; f=
ont-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0,=
 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning:=
 none;">Kind regards,</span></p><p style=3D"margin: 0px; font-width: normal=
; line-height: normal; font-size-adjust: none; font-kerning: auto; font-var=
iant-alternates: normal; font-variant-ligatures: normal; font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-variant-position: normal;=
 font-feature-settings: normal; font-optical-sizing: auto; font-variation-s=
ettings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none;">Yuriy Darnobyt</span></p></body></=
html>=

--Apple-Mail=_F5A70176-DB45-4CCC-A05E-2DAB83FED743--

