From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_09E118A3-BFB6-412F-8585-F7992CCA2377"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Message-Id: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
Date: Thu, 9 Nov 2023 22:56:10 +0200
Subject: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_09E118A3-BFB6-412F-8585-F7992CCA2377
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.6.7.

This is a bugfix release containing security fixes.

Security Fixes:

* CVE-2023-46850 OpenVPN versions between 2.6.0 and 2.6.6 incorrectly use a=
 send buffer after
 it has been free()d in some circumstances, causing some free()d memory to =
be sent to the peer.
 All configurations using TLS (e.g. not using --secret) are affected by thi=
s issue.
 (found while tracking down CVE-2023-46849 / Github #400, #417)
* CVE-2023-46849 OpenVPN versions between 2.6.0 and 2.6.6 incorrectly resto=
re --fragment configuration
 in some circumstances, leading to a division by zero when --fragment is us=
ed. On platforms where
 division by zero is fatal, this will cause an OpenVPN crash.(Github #400, =
#417).

User visible changes:

* DCO: warn if DATA_V1 packets are sent by the other side - this a hard inc=
ompatibility between
 a 2.6.x client connecting to a 2.4.0-2.4.4 server, and the only fix is to =
use --disable-dco.
* Remove OpenSSL Engine method for loading a key. This had to be removed be=
cause the original author
 did not agree to relicensing the code with the new linking exception added=
. This was a somewhat
 obsolete feature anyway as it only worked with OpenSSL 1.x, which is end-o=
f-support.
* add warning if p2p NCP client connects to a p2mp server - this is a combi=
nation that used to work
 without cipher negotiation (pre 2.6 on both ends), but would fail in non-o=
bvious ways with 2.6 to 2.6.
* add warning to --show-groups that not all supported groups are listed (th=
is is
 due the internal enumeration in OpenSSL being a bit weird, omitting X448 a=
nd X25519 curves).
* --dns: remove support for exclude-domains argument (this was a new 2.6 op=
tion,
 with no backend support implemented yet on any platform, and it turns out =
that=20
 no platform supported it at all - so remove option again)
* warn user if INFO control message too long, do not forward to management =
client
 (safeguard against protocol-violating server implementations)

New features:

* DCO-WIN: get and log driver version (for easier debugging).
* print "peer temporary key details" in TLS handshake
* log OpenSSL errors on failure to set certificate, for example if the algo=
rithms used=20
 are in acceptable to OpenSSL (misleading message would be printed in crypt=
oapi / pkcs11 scenarios)
* add CMake build system for MinGW and MSVC builds
* remove old MSVC build system
* improve cmocka unit test building for Windows

Windows MSI changes since 2.6.6:

* Included openvpn-gui updated to 11.45.0.0
   * Add clarity for error on missing management parameter. See GH #657
   * Improve "OpenVPN GUI" tooltip handling See GH #649
* MSIs now use OpenSSL 3.1.4

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

--Apple-Mail=_09E118A3-BFB6-412F-8585-F7992CCA2377
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><span style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0);">The OpenVPN community project team is pro=
ud to release OpenVPN 2.6.7.</span><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Th=
is is a bugfix release containing security fixes.</span><br style=3D"caret-=
color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0,=
 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); col=
or: rgb(0, 0, 0);">Security Fixes:</span><br style=3D"caret-color: rgb(0, 0=
, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0=
);">* CVE-2023-46850 OpenVPN versions between 2.6.0 and 2.6.6 incorrectly u=
se a send buffer after</span><br style=3D"caret-color: rgb(0, 0, 0); color:=
 rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">&nbsp;it has been free()d in some circumstances, causing some free()d =
memory to be sent to the peer.</span><br style=3D"caret-color: rgb(0, 0, 0)=
; color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rg=
b(0, 0, 0);">&nbsp;All configurations using TLS (e.g. not using --secret) a=
re affected by this issue.</span><br style=3D"caret-color: rgb(0, 0, 0); co=
lor: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0);">&nbsp;(found while tracking down CVE-2023-46849 / Github #400, #41=
7)</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><spa=
n style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* CVE-2023-4684=
9 OpenVPN versions between 2.6.0 and 2.6.6 incorrectly restore --fragment c=
onfiguration</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0,=
 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&nbsp=
;in some circumstances, leading to a division by zero when --fragment is us=
ed. On platforms where</span><br style=3D"caret-color: rgb(0, 0, 0); color:=
 rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">&nbsp;division by zero is fatal, this will cause an OpenVPN crash.(Git=
hub #400, #417).</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0=
, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><sp=
an style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">User visible c=
hanges:</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"=
><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* DCO: warn if DATA_V1=
 packets are sent by the other side - this a hard incompatibility between</=
span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span st=
yle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&nbsp;a 2.6.x clien=
t connecting to a 2.4.0-2.4.4 server, and the only fix is to use --disable-=
dco.</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><s=
pan style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* Remove Open=
SSL Engine method for loading a key. This had to be removed because the ori=
ginal author</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0,=
 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&nbsp=
;did not agree to relicensing the code with the new linking exception added=
. This was a somewhat</span><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0=
);">&nbsp;obsolete feature anyway as it only worked with OpenSSL 1.x, which=
 is end-of-support.</span><br style=3D"caret-color: rgb(0, 0, 0); color: rg=
b(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);=
">* add warning if p2p NCP client connects to a p2mp server - this is a com=
bination that used to work</span><br style=3D"caret-color: rgb(0, 0, 0); co=
lor: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0);">&nbsp;without cipher negotiation (pre 2.6 on both ends), but would=
 fail in non-obvious ways with 2.6 to 2.6.</span><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0=
); color: rgb(0, 0, 0);">* add warning to --show-groups that not all suppor=
ted groups are listed (this is</span><br style=3D"caret-color: rgb(0, 0, 0)=
; color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rg=
b(0, 0, 0);">&nbsp;due the internal enumeration in OpenSSL being a bit weir=
d, omitting X448 and X25519 curves).</span><br style=3D"caret-color: rgb(0,=
 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); col=
or: rgb(0, 0, 0);">* --dns: remove support for exclude-domains argument (th=
is was a new 2.6 option,</span><br style=3D"caret-color: rgb(0, 0, 0); colo=
r: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0=
, 0);">&nbsp;with no backend support implemented yet on any platform, and i=
t turns out that&nbsp;</span><br style=3D"caret-color: rgb(0, 0, 0); color:=
 rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">&nbsp;no platform supported it at all - so remove option again)</span>=
<br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* warn user if INFO co=
ntrol message too long, do not forward to management client</span><br style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-c=
olor: rgb(0, 0, 0); color: rgb(0, 0, 0);">&nbsp;(safeguard against protocol=
-violating server implementations)</span><br style=3D"caret-color: rgb(0, 0=
, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0=
);">New features:</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(=
0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><s=
pan style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* DCO-WIN: ge=
t and log driver version (for easier debugging).</span><br style=3D"caret-c=
olor: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0=
, 0, 0); color: rgb(0, 0, 0);">* print "peer temporary key details" in TLS =
handshake</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* log Op=
enSSL errors on failure to set certificate, for example if the algorithms u=
sed&nbsp;</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&nbsp;ar=
e in acceptable to OpenSSL (misleading message would be printed in cryptoap=
i / pkcs11 scenarios)</span><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0=
);">* add CMake build system for MinGW and MSVC builds</span><br style=3D"c=
aret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color:=
 rgb(0, 0, 0); color: rgb(0, 0, 0);">* remove old MSVC build system</span><=
br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D=
"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* improve cmocka unit tes=
t building for Windows</span><br style=3D"caret-color: rgb(0, 0, 0); color:=
 rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Windows =
MSI changes since 2.6.6:</span><br style=3D"caret-color: rgb(0, 0, 0); colo=
r: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* Incl=
uded openvpn-gui updated to 11.45.0.0</span><br style=3D"caret-color: rgb(0=
, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); co=
lor: rgb(0, 0, 0);">&nbsp;&nbsp;&nbsp;* Add clarity for error on missing ma=
nagement parameter. See GH #657</span><br style=3D"caret-color: rgb(0, 0, 0=
); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: r=
gb(0, 0, 0);">&nbsp;&nbsp;&nbsp;* Improve "OpenVPN GUI" tooltip handling Se=
e GH #649</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">* MSIs n=
ow use OpenSSL 3.1.4</span><br style=3D"caret-color: rgb(0, 0, 0); color: r=
gb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"=
><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">More detai=
ls can be found in the Changes document:</span><br style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); c=
olor: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0=
, 0, 0);">&lt;</span><a href=3D"https://github.com/OpenVPN/openvpn/blob/rel=
ease/2.6/Changes.rst">https://github.com/OpenVPN/openvpn/blob/release/2.6/C=
hanges.rst</a><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"=
><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">(The Changes document =
also contains a section with work-arounds for</span><br style=3D"caret-colo=
r: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0=
, 0); color: rgb(0, 0, 0);">common problems encountered when using OpenVPN =
with OpenSSL 3)</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><spa=
n style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Source code and=
 Windows installers can be downloaded from our download page:</span><br sty=
le=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-c=
olor: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0=
, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://openvpn.net/co=
mmunity-downloads/">https://openvpn.net/community-downloads/</a><span style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><br style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-col=
or: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, =
0, 0); color: rgb(0, 0, 0);">Debian and Ubuntu packages are available in th=
e official apt repositories:</span><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&l=
t;</span><a href=3D"https://community.openvpn.net/openvpn/wiki/OpenvpnSoftw=
areRepos#DebianUbuntu:UsingOpenVPNaptrepositories">https://community.openvp=
n.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptreposit=
ories</a><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&g=
t;</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"ca=
ret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">On Red Hat derivatives we re=
commend using the Fedora Copr repository.</span><br style=3D"caret-color: r=
gb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(=
0, 0, 0);">&lt;</span><a href=3D"https://copr.fedorainfracloud.org/coprs/ds=
ommers/openvpn-release-2.6/">https://copr.fedorainfracloud.org/coprs/dsomme=
rs/openvpn-release-2.6/</a><span style=3D"caret-color: rgb(0, 0, 0); color:=
 rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0); color: r=
gb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"=
><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Kind regar=
ds,</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><sp=
an style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Yuriy Darnobyt=
</span></body></html>=

--Apple-Mail=_09E118A3-BFB6-412F-8585-F7992CCA2377--

