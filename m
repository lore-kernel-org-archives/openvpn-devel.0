From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_C7AF659C-E12B-4E60-90D4-B4B648CF699C"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Message-Id: <010B9529-6C1E-454A-9846-26AC9581AFE9@...2722...>
Date: Thu, 25 Sep 2025 17:42:01 +0300
Subject: [Openvpn-devel] OpenVPN 2.7_beta2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_C7AF659C-E12B-4E60-90D4-B4B648CF699C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_beta2.
This is a second beta which includes important bugfixes.

Feature changes since 2.7_beta1:

* greatly improved event log handling for the Windows interactive service -=
 this brings build system
changes and a new openvpnservmsg.dll

Important bug fixes since 2.7_beta1:

* add proper input sanitation to DNS strings to prevent an attack coming fr=
om a trusted-but-malicous
OpenVPN server (CVE-2025-10680, affects unixoid systems with --dns-updown s=
cripts and windows
using the built-in powershell call)
* bugfixes when using multi-socket on windows (properly recognize that TCP =
server mode does not work
with DCO, properly handle TCP multi-socket server setups without DCO)
* bring back configuring of IPv4 broadcast addresses on Linux
* repair "--dhcp-option DNS" setting in combination with DHCP (TAP) or "--u=
p" scripts
(Github: OpenVPN/openvpn#839, OpenVPN/openvpn#840)

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

--Apple-Mail=_C7AF659C-E12B-4E60-90D4-B4B648CF699C
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><div><div><font color=3D"#0000=
00"><span style=3D"caret-color: rgb(0, 0, 0);">The OpenVPN community projec=
t team is proud to release OpenVPN 2.7_beta2.</span></font></div><div><font=
 color=3D"#000000">This is a second beta which includes important bugfixes.=
</font></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0=
, 0, 0);"><br></span></font></div><div><font color=3D"#000000"><span style=
=3D"caret-color: rgb(0, 0, 0);">Feature changes since 2.7_beta1:</span></fo=
nt></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0,=
 0);"><br></span></font></div><div><font color=3D"#000000"><span style=3D"c=
aret-color: rgb(0, 0, 0);">* greatly improved event log handling for the Wi=
ndows interactive service - this brings build system</span></font></div><di=
v><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">change=
s and a new openvpnservmsg.dll</span></font></div><div><font color=3D"#0000=
00"><span style=3D"caret-color: rgb(0, 0, 0);"><br></span></font></div><div=
><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">Importa=
nt bug fixes since 2.7_beta1:</span></font></div><div><font color=3D"#00000=
0"><span style=3D"caret-color: rgb(0, 0, 0);"><br></span></font></div><div>=
<font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* add pr=
oper input sanitation to DNS strings to prevent an attack coming from a tru=
sted-but-malicous</span></font></div><div><font color=3D"#000000"><span sty=
le=3D"caret-color: rgb(0, 0, 0);">OpenVPN server (CVE-2025-10680, affects u=
nixoid systems with --dns-updown scripts and windows</span></font></div><di=
v><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">using =
the built-in powershell call)</span></font></div><div><font color=3D"#00000=
0"><span style=3D"caret-color: rgb(0, 0, 0);">* bugfixes when using multi-s=
ocket on windows (properly recognize that TCP server mode does not work</sp=
an></font></div><div><font color=3D"#000000"><span style=3D"caret-color: rg=
b(0, 0, 0);">with DCO, properly handle TCP multi-socket server setups witho=
ut DCO)</span></font></div><div><font color=3D"#000000"><span style=3D"care=
t-color: rgb(0, 0, 0);">* bring back configuring of IPv4 broadcast addresse=
s on Linux</span></font></div><div><font color=3D"#000000"><span style=3D"c=
aret-color: rgb(0, 0, 0);">* repair "--dhcp-option DNS" setting in combinat=
ion with DHCP (TAP) or "--up" scripts</span></font></div><div><font color=
=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">(Github: OpenVPN/op=
envpn#839, OpenVPN/openvpn#840)</span></font></div></div><br style=3D"caret=
-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb=
(0, 0, 0); color: rgb(0, 0, 0);">More details can be found in the Changes d=
ocument:</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);=
"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"=
https://github.com/OpenVPN/openvpn/blob/master/Changes.rst">https://github.=
com/OpenVPN/openvpn/blob/master/Changes.rst</a><span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); c=
olor: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0=
, 0, 0);">Source code and Windows installers can be downloaded from our dow=
nload page:</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span st=
yle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=
=3D"https://openvpn.net/community-downloads/">https://openvpn.net/community=
-downloads/</a><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0=
);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);=
"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Packages for Debian, U=
buntu, Fedora, RHEL, and openSUSE are available in the various</span><br st=
yle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"care=
t-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">official Community repositorie=
s:</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"ca=
ret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https:=
//community.openvpn.net/Pages/OpenVPN%20software%20repos">https://community=
.openvpn.net/Pages/OpenVPN%20software%20repos</a><span style=3D"caret-color=
: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0);=
 color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb=
(0, 0, 0);">Kind regards,</span><br style=3D"caret-color: rgb(0, 0, 0); col=
or: rgb(0, 0, 0);"><font color=3D"#000000">Yuriy Darnobyt</font></body></ht=
ml>=

--Apple-Mail=_C7AF659C-E12B-4E60-90D4-B4B648CF699C--

