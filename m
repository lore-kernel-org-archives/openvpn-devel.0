From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4BD36AD9-25DE-4F5E-904F-8CD8D38BDD33"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Message-Id: <F37E2C32-A990-4F12-9FC8-81E8AA3BB3E9@...2722...>
Date: Wed, 20 Mar 2024 21:18:37 +0200
Subject: [Openvpn-devel] OpenVPN 2.6.10 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_4BD36AD9-25DE-4F5E-904F-8CD8D38BDD33
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.6.10.

This is a bugfix release containing several security fixes for Windows and =
Windows TAP driver and documentation updates.

Security fixes:

* CVE-2024-27459: Windows: fix a possible stack overflow in the interactive=
 service component which might lead to a local privilege escalation.
  Reported-by: Vladimir Tokarev <vtokarev@...2393...>
* CVE-2024-24974: Windows: disallow access to the interactive service pipe =
from remote computers.
  Reported-by: Vladimir Tokarev <vtokarev@...2393...>
* CVE-2024-27903: Windows: disallow loading of plugins from untrusted insta=
llation paths, which could be used to attack openvpn.exe
  via a malicious plugin.  Plugins can now only be loaded from the OpenVPN =
install directory, the Windows system directory, and possibly
  from a directory specified by HKLM\SOFTWARE\OpenVPN\plugin_dir.
  Reported-by: Vladimir Tokarev <vtokarev@...2393...>
* CVE-2024-1305: Windows TAP driver: Fix potential integer overflow in !Tap=
SharedSendPacket.
  Reported-by: Vladimir Tokarev <vtokarev@...2393...>

User visible changes:

* Update copyright notices to 2024

Bug fixes:

* Windows: if the win-dco driver is used (default) and the GUI requests use=
 of a proxy server, the connection would fail.
  Disable DCO in this case.  (Github: #522)
* Compression: minor bugfix in checking option consistency vs. compiled-in =
algorithm support
* systemd unit files: remove obsolete syslog.target

Documentation:

* remove license warnings about mbedTLS linking (README.mbedtls)
* update documentation references in systemd unit files
* sample config files: remove obsolete tls-*.conf files
* document that auth-user-pass may be inlined

Windows MSI changes since 2.6.9:

* For the Windows-specific security fixes see above
* Built against OpenSSL 3.2.1
* Included tap6-windows driver updated to 9.27.0
  * Security fix, see above
* Included ovpn-dco-win driver updated to 1.0.1
  * Ensure we don't pass too large key size to CryptoNG. We do not consider=
 this a security issue since the CryptoNG API handles
    this gracefully either way.
* Included openvpn-gui updated to 11.48.0.0
  * Position tray tooltip above the taskbar
  * Combine title and message in tray icon tip text
  * Use a custom tooltip window for the tray icon
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

--Apple-Mail=_4BD36AD9-25DE-4F5E-904F-8CD8D38BDD33
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><p style=3D"margin: 0px; font-=
stretch: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-co=
lor: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">The OpenVPN communi=
ty project team is proud to release OpenVPN 2.6.10.</span></p><p style=3D"m=
argin: 0px; font-stretch: normal; line-height: normal; font-size-adjust: no=
ne; font-kerning: auto; font-variant-alternates: normal; font-variant-ligat=
ures: normal; font-variant-numeric: normal; font-variant-east-asian: normal=
; font-variant-position: normal; font-feature-settings: normal; font-optica=
l-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webk=
it-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-=
kerning: none;"></span><br></p><p style=3D"margin: 0px; font-stretch: norma=
l; line-height: normal; font-size-adjust: none; font-kerning: auto; font-va=
riant-alternates: normal; font-variant-ligatures: normal; font-variant-nume=
ric: normal; font-variant-east-asian: normal; font-variant-position: normal=
; font-feature-settings: normal; font-optical-sizing: auto; font-variation-=
settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0,=
 0);"><span style=3D"font-kerning: none;">This is a bugfix release containi=
ng several security fixes for Windows and Windows TAP driver and documentat=
ion updates.</span></p><p style=3D"margin: 0px; font-stretch: normal; line-=
height: normal; font-size-adjust: none; font-kerning: auto; font-variant-al=
ternates: normal; font-variant-ligatures: normal; font-variant-numeric: nor=
mal; font-variant-east-asian: normal; font-variant-position: normal; font-f=
eature-settings: normal; font-optical-sizing: auto; font-variation-settings=
: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min=
-height: 14px;"><br><span style=3D"font-kerning: none;"></span></p><p style=
=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal;">Security fixes:</p><=
p style=3D"margin: 0px; font-stretch: normal; line-height: normal; font-siz=
e-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-v=
ariant-ligatures: normal; font-variant-numeric: normal; font-variant-east-a=
sian: normal; font-variant-position: normal; font-feature-settings: normal;=
 font-optical-sizing: auto; font-variation-settings: normal;"><br></p><p st=
yle=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-ad=
just: none; font-kerning: auto; font-variant-alternates: normal; font-varia=
nt-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian=
: normal; font-variant-position: normal; font-feature-settings: normal; fon=
t-optical-sizing: auto; font-variation-settings: normal;">* CVE-2024-27459:=
 Windows: fix a possible stack overflow in the interactive service componen=
t which might lead to a local privilege escalation.</p><p style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-size-adjust: none; fon=
t-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: n=
ormal; font-variant-numeric: normal; font-variant-east-asian: normal; font-=
variant-position: normal; font-feature-settings: normal; font-optical-sizin=
g: auto; font-variation-settings: normal;">&nbsp; Reported-by: Vladimir Tok=
arev &lt;vtokarev@...2393...&gt;</p><p style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-size-adjust: none; font-kerning: auto; fo=
nt-variant-alternates: normal; font-variant-ligatures: normal; font-variant=
-numeric: normal; font-variant-east-asian: normal; font-variant-position: n=
ormal; font-feature-settings: normal; font-optical-sizing: auto; font-varia=
tion-settings: normal;">* CVE-2024-24974: Windows: disallow access to the i=
nteractive service pipe from remote computers.</p><p style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal;">&nbsp; Reported-by: Vladimir Tokarev =
&lt;vtokarev@...2393...&gt;</p><p style=3D"margin: 0px; font-stretch: norma=
l; line-height: normal; font-size-adjust: none; font-kerning: auto; font-va=
riant-alternates: normal; font-variant-ligatures: normal; font-variant-nume=
ric: normal; font-variant-east-asian: normal; font-variant-position: normal=
; font-feature-settings: normal; font-optical-sizing: auto; font-variation-=
settings: normal;">* CVE-2024-27903: Windows: disallow loading of plugins f=
rom untrusted installation paths, which could be used to attack openvpn.exe=
</p><p style=3D"margin: 0px; font-stretch: normal; line-height: normal; fon=
t-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; f=
ont-variant-ligatures: normal; font-variant-numeric: normal; font-variant-e=
ast-asian: normal; font-variant-position: normal; font-feature-settings: no=
rmal; font-optical-sizing: auto; font-variation-settings: normal;">&nbsp; v=
ia a malicious plugin. &nbsp;Plugins can now only be loaded from the OpenVP=
N install directory, the Windows system directory, and possibly</p><p style=
=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal;">&nbsp; from a direct=
ory specified by HKLM\SOFTWARE\OpenVPN\plugin_dir.</p><p style=3D"margin: 0=
px; font-stretch: normal; line-height: normal; font-size-adjust: none; font=
-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: no=
rmal; font-variant-numeric: normal; font-variant-east-asian: normal; font-v=
ariant-position: normal; font-feature-settings: normal; font-optical-sizing=
: auto; font-variation-settings: normal;">&nbsp; Reported-by: Vladimir Toka=
rev &lt;vtokarev@...2393...&gt;</p><p style=3D"margin: 0px; font-stretch: n=
ormal; line-height: normal; font-size-adjust: none; font-kerning: auto; fon=
t-variant-alternates: normal; font-variant-ligatures: normal; font-variant-=
numeric: normal; font-variant-east-asian: normal; font-variant-position: no=
rmal; font-feature-settings: normal; font-optical-sizing: auto; font-variat=
ion-settings: normal;">* CVE-2024-1305: Windows TAP driver: Fix potential i=
nteger overflow in !TapSharedSendPacket.</p><p style=3D"margin: 0px; font-s=
tretch: normal; line-height: normal; font-size-adjust: none; font-kerning: =
auto; font-variant-alternates: normal; font-variant-ligatures: normal; font=
-variant-numeric: normal; font-variant-east-asian: normal; font-variant-pos=
ition: normal; font-feature-settings: normal; font-optical-sizing: auto; fo=
nt-variation-settings: normal;">&nbsp; Reported-by: Vladimir Tokarev &lt;vt=
okarev@...2393...&gt;</p><p style=3D"margin: 0px; font-stretch: normal; lin=
e-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-=
alternates: normal; font-variant-ligatures: normal; font-variant-numeric: n=
ormal; font-variant-east-asian: normal; font-variant-position: normal; font=
-feature-settings: normal; font-optical-sizing: auto; font-variation-settin=
gs: normal;"><br></p><p style=3D"margin: 0px; font-stretch: normal; line-he=
ight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alte=
rnates: normal; font-variant-ligatures: normal; font-variant-numeric: norma=
l; font-variant-east-asian: normal; font-variant-position: normal; font-fea=
ture-settings: normal; font-optical-sizing: auto; font-variation-settings: =
normal;">User visible changes:</p><p style=3D"margin: 0px; font-stretch: no=
rmal; line-height: normal; font-size-adjust: none; font-kerning: auto; font=
-variant-alternates: normal; font-variant-ligatures: normal; font-variant-n=
umeric: normal; font-variant-east-asian: normal; font-variant-position: nor=
mal; font-feature-settings: normal; font-optical-sizing: auto; font-variati=
on-settings: normal;"><br></p><p style=3D"margin: 0px; font-stretch: normal=
; line-height: normal; font-size-adjust: none; font-kerning: auto; font-var=
iant-alternates: normal; font-variant-ligatures: normal; font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-variant-position: normal;=
 font-feature-settings: normal; font-optical-sizing: auto; font-variation-s=
ettings: normal;">* Update copyright notices to 2024</p><p style=3D"margin:=
 0px; font-stretch: normal; line-height: normal; font-size-adjust: none; fo=
nt-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: =
normal; font-variant-numeric: normal; font-variant-east-asian: normal; font=
-variant-position: normal; font-feature-settings: normal; font-optical-sizi=
ng: auto; font-variation-settings: normal;"><br></p><p style=3D"margin: 0px=
; font-stretch: normal; line-height: normal; font-size-adjust: none; font-k=
erning: auto; font-variant-alternates: normal; font-variant-ligatures: norm=
al; font-variant-numeric: normal; font-variant-east-asian: normal; font-var=
iant-position: normal; font-feature-settings: normal; font-optical-sizing: =
auto; font-variation-settings: normal;">Bug fixes:</p><p style=3D"margin: 0=
px; font-stretch: normal; line-height: normal; font-size-adjust: none; font=
-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: no=
rmal; font-variant-numeric: normal; font-variant-east-asian: normal; font-v=
ariant-position: normal; font-feature-settings: normal; font-optical-sizing=
: auto; font-variation-settings: normal;"><br></p><p style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal;">* Windows: if the win-dco driver is u=
sed (default) and the GUI requests use of a proxy server, the connection wo=
uld fail.</p><p style=3D"margin: 0px; font-stretch: normal; line-height: no=
rmal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: =
normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-=
variant-east-asian: normal; font-variant-position: normal; font-feature-set=
tings: normal; font-optical-sizing: auto; font-variation-settings: normal;"=
>&nbsp; Disable DCO in this case. &nbsp;(Github: #522)</p><p style=3D"margi=
n: 0px; font-stretch: normal; line-height: normal; font-size-adjust: none; =
font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures=
: normal; font-variant-numeric: normal; font-variant-east-asian: normal; fo=
nt-variant-position: normal; font-feature-settings: normal; font-optical-si=
zing: auto; font-variation-settings: normal;">* Compression: minor bugfix i=
n checking option consistency vs. compiled-in algorithm support</p><p style=
=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal;">* systemd unit files=
: remove obsolete syslog.target</p><p style=3D"margin: 0px; font-stretch: n=
ormal; line-height: normal; font-size-adjust: none; font-kerning: auto; fon=
t-variant-alternates: normal; font-variant-ligatures: normal; font-variant-=
numeric: normal; font-variant-east-asian: normal; font-variant-position: no=
rmal; font-feature-settings: normal; font-optical-sizing: auto; font-variat=
ion-settings: normal;"><br></p><p style=3D"margin: 0px; font-stretch: norma=
l; line-height: normal; font-size-adjust: none; font-kerning: auto; font-va=
riant-alternates: normal; font-variant-ligatures: normal; font-variant-nume=
ric: normal; font-variant-east-asian: normal; font-variant-position: normal=
; font-feature-settings: normal; font-optical-sizing: auto; font-variation-=
settings: normal;">Documentation:</p><p style=3D"margin: 0px; font-stretch:=
 normal; line-height: normal; font-size-adjust: none; font-kerning: auto; f=
ont-variant-alternates: normal; font-variant-ligatures: normal; font-varian=
t-numeric: normal; font-variant-east-asian: normal; font-variant-position: =
normal; font-feature-settings: normal; font-optical-sizing: auto; font-vari=
ation-settings: normal;"><br></p><p style=3D"margin: 0px; font-stretch: nor=
mal; line-height: normal; font-size-adjust: none; font-kerning: auto; font-=
variant-alternates: normal; font-variant-ligatures: normal; font-variant-nu=
meric: normal; font-variant-east-asian: normal; font-variant-position: norm=
al; font-feature-settings: normal; font-optical-sizing: auto; font-variatio=
n-settings: normal;">* remove license warnings about mbedTLS linking (READM=
E.mbedtls)</p><p style=3D"margin: 0px; font-stretch: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-feature-se=
ttings: normal; font-optical-sizing: auto; font-variation-settings: normal;=
">* update documentation references in systemd unit files</p><p style=3D"ma=
rgin: 0px; font-stretch: normal; line-height: normal; font-size-adjust: non=
e; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatu=
res: normal; font-variant-numeric: normal; font-variant-east-asian: normal;=
 font-variant-position: normal; font-feature-settings: normal; font-optical=
-sizing: auto; font-variation-settings: normal;">* sample config files: rem=
ove obsolete tls-*.conf files</p><p style=3D"margin: 0px; font-stretch: nor=
mal; line-height: normal; font-size-adjust: none; font-kerning: auto; font-=
variant-alternates: normal; font-variant-ligatures: normal; font-variant-nu=
meric: normal; font-variant-east-asian: normal; font-variant-position: norm=
al; font-feature-settings: normal; font-optical-sizing: auto; font-variatio=
n-settings: normal;">* document that auth-user-pass may be inlined</p><div>=
<br></div><p style=3D"margin: 0px; font-stretch: normal; line-height: norma=
l; font-size-adjust: none; font-kerning: auto; font-variant-alternates: nor=
mal; font-variant-ligatures: normal; font-variant-numeric: normal; font-var=
iant-east-asian: normal; font-variant-position: normal; font-feature-settin=
gs: normal; font-optical-sizing: auto; font-variation-settings: normal;">Wi=
ndows MSI changes since 2.6.9:</p><p style=3D"margin: 0px; font-stretch: no=
rmal; line-height: normal; font-size-adjust: none; font-kerning: auto; font=
-variant-alternates: normal; font-variant-ligatures: normal; font-variant-n=
umeric: normal; font-variant-east-asian: normal; font-variant-position: nor=
mal; font-feature-settings: normal; font-optical-sizing: auto; font-variati=
on-settings: normal;"><br></p><p style=3D"margin: 0px; font-stretch: normal=
; line-height: normal; font-size-adjust: none; font-kerning: auto; font-var=
iant-alternates: normal; font-variant-ligatures: normal; font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-variant-position: normal;=
 font-feature-settings: normal; font-optical-sizing: auto; font-variation-s=
ettings: normal;">* For the Windows-specific security fixes see above</p><p=
 style=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size=
-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-va=
riant-ligatures: normal; font-variant-numeric: normal; font-variant-east-as=
ian: normal; font-variant-position: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal;">* Built agains=
t OpenSSL 3.2.1</p><p style=3D"margin: 0px; font-stretch: normal; line-heig=
ht: normal; font-size-adjust: none; font-kerning: auto; font-variant-altern=
ates: normal; font-variant-ligatures: normal; font-variant-numeric: normal;=
 font-variant-east-asian: normal; font-variant-position: normal; font-featu=
re-settings: normal; font-optical-sizing: auto; font-variation-settings: no=
rmal;">* Included tap6-windows driver updated to 9.27.0</p><p style=3D"marg=
in: 0px; font-stretch: normal; line-height: normal; font-size-adjust: none;=
 font-kerning: auto; font-variant-alternates: normal; font-variant-ligature=
s: normal; font-variant-numeric: normal; font-variant-east-asian: normal; f=
ont-variant-position: normal; font-feature-settings: normal; font-optical-s=
izing: auto; font-variation-settings: normal;">&nbsp; * Security fix, see a=
bove</p><p style=3D"margin: 0px; font-stretch: normal; line-height: normal;=
 font-size-adjust: none; font-kerning: auto; font-variant-alternates: norma=
l; font-variant-ligatures: normal; font-variant-numeric: normal; font-varia=
nt-east-asian: normal; font-variant-position: normal; font-feature-settings=
: normal; font-optical-sizing: auto; font-variation-settings: normal;">* In=
cluded ovpn-dco-win driver updated to 1.0.1</p><p style=3D"margin: 0px; fon=
t-stretch: normal; line-height: normal; font-size-adjust: none; font-kernin=
g: auto; font-variant-alternates: normal; font-variant-ligatures: normal; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-variant-=
position: normal; font-feature-settings: normal; font-optical-sizing: auto;=
 font-variation-settings: normal;">&nbsp; * Ensure we don't pass too large =
key size to CryptoNG. We do not consider this a security issue since the Cr=
yptoNG API handles</p><p style=3D"margin: 0px; font-stretch: normal; line-h=
eight: normal; font-size-adjust: none; font-kerning: auto; font-variant-alt=
ernates: normal; font-variant-ligatures: normal; font-variant-numeric: norm=
al; font-variant-east-asian: normal; font-variant-position: normal; font-fe=
ature-settings: normal; font-optical-sizing: auto; font-variation-settings:=
 normal;">&nbsp; &nbsp; this gracefully either way.</p><p style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-size-adjust: none; fon=
t-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: n=
ormal; font-variant-numeric: normal; font-variant-east-asian: normal; font-=
variant-position: normal; font-feature-settings: normal; font-optical-sizin=
g: auto; font-variation-settings: normal;">* Included openvpn-gui updated t=
o 11.48.0.0</p><p style=3D"margin: 0px; font-stretch: normal; line-height: =
normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates=
: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fon=
t-variant-east-asian: normal; font-variant-position: normal; font-feature-s=
ettings: normal; font-optical-sizing: auto; font-variation-settings: normal=
;">&nbsp; * Position tray tooltip above the taskbar</p><p style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-size-adjust: none; fon=
t-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: n=
ormal; font-variant-numeric: normal; font-variant-east-asian: normal; font-=
variant-position: normal; font-feature-settings: normal; font-optical-sizin=
g: auto; font-variation-settings: normal;">&nbsp; * Combine title and messa=
ge in tray icon tip text</p><p style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; font-varia=
nt-alternates: normal; font-variant-ligatures: normal; font-variant-numeric=
: normal; font-variant-east-asian: normal; font-variant-position: normal; f=
ont-feature-settings: normal; font-optical-sizing: auto; font-variation-set=
tings: normal;">&nbsp; * Use a custom tooltip window for the tray icon</p><=
p style=3D"margin: 0px; font-stretch: normal; line-height: normal; font-siz=
e-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-v=
ariant-ligatures: normal; font-variant-numeric: normal; font-variant-east-a=
sian: normal; font-variant-position: normal; font-feature-settings: normal;=
 font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, =
0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span st=
yle=3D"font-kerning: none;"></span></p><p style=3D"margin: 0px; font-stretc=
h: normal; line-height: normal; font-size-adjust: none; font-kerning: auto;=
 font-variant-alternates: normal; font-variant-ligatures: normal; font-vari=
ant-numeric: normal; font-variant-east-asian: normal; font-variant-position=
: normal; font-feature-settings: normal; font-optical-sizing: auto; font-va=
riation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: r=
gb(0, 0, 0);"><span style=3D"font-kerning: none;">More details can be found=
 in the Changes document:</span></p><p style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-size-adjust: none; font-kerning: auto; fo=
nt-variant-alternates: normal; font-variant-ligatures: normal; font-variant=
-numeric: normal; font-variant-east-asian: normal; font-variant-position: n=
ormal; font-feature-settings: normal; font-optical-sizing: auto; font-varia=
tion-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(=
0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: none;"></span><br=
></p><p style=3D"margin: 0px; font-stretch: normal; line-height: normal; fo=
nt-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; =
font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-=
east-asian: normal; font-variant-position: normal; font-feature-settings: n=
ormal; font-optical-sizing: auto; font-variation-settings: normal; color: r=
gb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);"><span styl=
e=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rg=
b(0, 0, 0);">&lt;<a href=3D"https://github.com/OpenVPN/openvpn/blob/release=
/2.6/Changes.rst"><span style=3D"font-kerning: none; color: rgb(53, 134, 25=
5); -webkit-text-stroke-color: rgb(53, 134, 255);">https://github.com/OpenV=
PN/openvpn/blob/release/2.6/Changes.rst</span></a>&gt;</span></p><p style=
=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-adjus=
t: none; font-kerning: auto; font-variant-alternates: normal; font-variant-=
ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: n=
ormal; font-variant-position: normal; font-feature-settings: normal; font-o=
ptical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); =
-webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"=
font-kerning: none;"></span><br></p><p style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-size-adjust: none; font-kerning: auto; fo=
nt-variant-alternates: normal; font-variant-ligatures: normal; font-variant=
-numeric: normal; font-variant-east-asian: normal; font-variant-position: n=
ormal; font-feature-settings: normal; font-optical-sizing: auto; font-varia=
tion-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(=
0, 0, 0);"><span style=3D"font-kerning: none;">(The Changes document also c=
ontains a section with work-arounds for</span></p><p style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-size-adjust: none; font-ker=
ning: auto; font-variant-alternates: normal; font-variant-ligatures: normal=
; font-variant-numeric: normal; font-variant-east-asian: normal; font-varia=
nt-position: normal; font-feature-settings: normal; font-optical-sizing: au=
to; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stro=
ke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">common problem=
s encountered when using OpenVPN with OpenSSL 3)</span></p><p style=3D"marg=
in: 0px; font-stretch: normal; line-height: normal; font-size-adjust: none;=
 font-kerning: auto; font-variant-alternates: normal; font-variant-ligature=
s: normal; font-variant-numeric: normal; font-variant-east-asian: normal; f=
ont-variant-position: normal; font-feature-settings: normal; font-optical-s=
izing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-=
text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-ker=
ning: none;"></span><br></p><p style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-size-adjust: none; font-kerning: auto; font-varia=
nt-alternates: normal; font-variant-ligatures: normal; font-variant-numeric=
: normal; font-variant-east-asian: normal; font-variant-position: normal; f=
ont-feature-settings: normal; font-optical-sizing: auto; font-variation-set=
tings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0)=
;"><span style=3D"font-kerning: none;">Source code and Windows installers c=
an be downloaded from our download page:</span></p><p style=3D"margin: 0px;=
 font-stretch: normal; line-height: normal; font-size-adjust: none; font-ke=
rning: auto; font-variant-alternates: normal; font-variant-ligatures: norma=
l; font-variant-numeric: normal; font-variant-east-asian: normal; font-vari=
ant-position: normal; font-feature-settings: normal; font-optical-sizing: a=
uto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-str=
oke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: no=
ne;"></span><br></p><p style=3D"margin: 0px; font-stretch: normal; line-hei=
ght: normal; font-size-adjust: none; font-kerning: auto; font-variant-alter=
nates: normal; font-variant-ligatures: normal; font-variant-numeric: normal=
; font-variant-east-asian: normal; font-variant-position: normal; font-feat=
ure-settings: normal; font-optical-sizing: auto; font-variation-settings: n=
ormal; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 25=
5);"><span style=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-s=
troke-color: rgb(0, 0, 0);">&lt;<a href=3D"https://openvpn.net/community-do=
wnloads/"><span style=3D"font-kerning: none; color: rgb(53, 134, 255); -web=
kit-text-stroke-color: rgb(53, 134, 255);">https://openvpn.net/community-do=
wnloads/</span></a>&gt;</span></p><p style=3D"margin: 0px; font-stretch: no=
rmal; line-height: normal; font-size-adjust: none; font-kerning: auto; font=
-variant-alternates: normal; font-variant-ligatures: normal; font-variant-n=
umeric: normal; font-variant-east-asian: normal; font-variant-position: nor=
mal; font-feature-settings: normal; font-optical-sizing: auto; font-variati=
on-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0,=
 0, 0); min-height: 14px;"><span style=3D"font-kerning: none;"></span><br><=
/p><p style=3D"margin: 0px; font-stretch: normal; line-height: normal; font=
-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; fo=
nt-variant-ligatures: normal; font-variant-numeric: normal; font-variant-ea=
st-asian: normal; font-variant-position: normal; font-feature-settings: nor=
mal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb=
(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span style=3D"font-ke=
rning: none;">Debian and Ubuntu packages are available in the official apt =
repositories:</span></p><p style=3D"margin: 0px; font-stretch: normal; line=
-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-a=
lternates: normal; font-variant-ligatures: normal; font-variant-numeric: no=
rmal; font-variant-east-asian: normal; font-variant-position: normal; font-=
feature-settings: normal; font-optical-sizing: auto; font-variation-setting=
s: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); mi=
n-height: 14px;"><span style=3D"font-kerning: none;"></span><br></p><p styl=
e=3D"margin: 0px; font-stretch: normal; line-height: normal; font-size-adju=
st: none; font-kerning: auto; font-variant-alternates: normal; font-variant=
-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: =
normal; font-variant-position: normal; font-feature-settings: normal; font-=
optical-sizing: auto; font-variation-settings: normal; color: rgb(53, 134, =
255); -webkit-text-stroke-color: rgb(53, 134, 255);"><span style=3D"font-ke=
rning: none; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"=
>&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareR=
epos#DebianUbuntu:UsingOpenVPNaptrepositories"><span style=3D"font-kerning:=
 none; color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 25=
5);">https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#Debian=
Ubuntu:UsingOpenVPNaptrepositories</span></a>&gt;</span></p><p style=3D"mar=
gin: 0px; font-stretch: normal; line-height: normal; font-size-adjust: none=
; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatur=
es: normal; font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-feature-settings: normal; font-optical-=
sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit=
-text-stroke-color: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-ke=
rning: none;"></span><br></p><p style=3D"margin: 0px; font-stretch: normal;=
 line-height: normal; font-size-adjust: none; font-kerning: auto; font-vari=
ant-alternates: normal; font-variant-ligatures: normal; font-variant-numeri=
c: normal; font-variant-east-asian: normal; font-variant-position: normal; =
font-feature-settings: normal; font-optical-sizing: auto; font-variation-se=
ttings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0=
);"><span style=3D"font-kerning: none;">On Red Hat derivatives we recommend=
 using the Fedora Copr repository.</span></p><p style=3D"margin: 0px; font-=
stretch: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-feature-settings: normal; font-optical-sizing: auto; f=
ont-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text-stroke-co=
lor: rgb(0, 0, 0); min-height: 14px;"><span style=3D"font-kerning: none;"><=
/span><br></p><p style=3D"margin: 0px; font-stretch: normal; line-height: n=
ormal; font-size-adjust: none; font-kerning: auto; font-variant-alternates:=
 normal; font-variant-ligatures: normal; font-variant-numeric: normal; font=
-variant-east-asian: normal; font-variant-position: normal; font-feature-se=
ttings: normal; font-optical-sizing: auto; font-variation-settings: normal;=
 color: rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);"><=
span style=3D"font-kerning: none; color: rgb(0, 0, 0); -webkit-text-stroke-=
color: rgb(0, 0, 0);">&lt;<a href=3D"https://copr.fedorainfracloud.org/copr=
s/dsommers/openvpn-release-2.6/"><span style=3D"font-kerning: none; color: =
rgb(53, 134, 255); -webkit-text-stroke-color: rgb(53, 134, 255);">https://c=
opr.fedorainfracloud.org/coprs/dsommers/openvpn-release-2.6/</span></a>&gt;=
</span></p><p style=3D"margin: 0px; font-stretch: normal; line-height: norm=
al; font-size-adjust: none; font-kerning: auto; font-variant-alternates: no=
rmal; font-variant-ligatures: normal; font-variant-numeric: normal; font-va=
riant-east-asian: normal; font-variant-position: normal; font-feature-setti=
ngs: normal; font-optical-sizing: auto; font-variation-settings: normal; co=
lor: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 14p=
x;"><span style=3D"font-kerning: none;"></span><br></p><p style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-size-adjust: none; fon=
t-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: n=
ormal; font-variant-numeric: normal; font-variant-east-asian: normal; font-=
variant-position: normal; font-feature-settings: normal; font-optical-sizin=
g: auto; font-variation-settings: normal; color: rgb(0, 0, 0); -webkit-text=
-stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none;">Kind rega=
rds,</span></p><p style=3D"margin: 0px; font-stretch: normal; line-height: =
normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates=
: normal; font-variant-ligatures: normal; font-variant-numeric: normal; fon=
t-variant-east-asian: normal; font-variant-position: normal; font-feature-s=
ettings: normal; font-optical-sizing: auto; font-variation-settings: normal=
; color: rgb(0, 0, 0); -webkit-text-stroke-color: rgb(0, 0, 0);"><span styl=
e=3D"font-kerning: none;">Yuriy Darnobyt</span></p></body></html>=

--Apple-Mail=_4BD36AD9-25DE-4F5E-904F-8CD8D38BDD33--

