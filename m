From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_5CDB0EC6-CA17-4C33-959D-3BB5DEB6E3D0"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Message-Id: <9F5CC7E1-D7A0-4C16-836D-DFFBD70D1E17@...2722...>
Date: Fri, 20 Jun 2025 22:09:51 +0300
Subject: [Openvpn-devel] OpenVPN 2.7_alpha2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

--Apple-Mail=_5CDB0EC6-CA17-4C33-959D-3BB5DEB6E3D0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_alpha2.
This is the second Alpha release for the feature release 2.7.0.
As the Alpha name implies this is an early release build, this is not inten=
ded=20
for production use.

This release include security fix for CVE-2025-50054

Highlights of this release include:
* Multi-socket support for servers -- Handle multiple addresses/ports/proto=
cols=20
within one server
* Improved Client support for DNS options
* Client implementations for Linux/BSD, included with the default install
* New client implementation for Windows, adding support for features like s=
plit=20
DNS and DNSSEC
* Architectural improvements on Windows
* The block-local flag is now enforced with WFP filters
* Windows network adapters are now generated on demand
* Windows automatic service now runs as an unprivileged user
* Support for server mode in win-dco driver
Note: Support for the wintun driver has been removed. win-dco is now the=20
default, tap-windows6 is the fallback solution for use-cases not covered by=
 win-dco.
* Improved data channel
* Enforcement of AES-GCM usage limit
* Epoch data keys and packet format
* Support for new upstream DCO Linux kernel module
* This release supports the new ovpn DCO Linux kernel module which will be=
=20
available in future upstream Linux kernel releases. Backports of the new mo=
dule=20
to current kernels are available via the ovpn-backports project.
* TLS 1.3 support with bleeding-edge mbedTLS versions

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/master/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in th=
e various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
Yuriy Darnobyt

--Apple-Mail=_5CDB0EC6-CA17-4C33-959D-3BB5DEB6E3D0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><div><font color=3D"#000000"><=
span style=3D"caret-color: rgb(0, 0, 0);">The OpenVPN community project tea=
m is proud to release OpenVPN 2.7_alpha2.</span></font></div><div><font col=
or=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">This is the secon=
d Alpha release for the feature release 2.7.0.</span></font></div><div><fon=
t color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">As the Alpha=
 name implies this is an early release build, this is not intended&nbsp;</s=
pan></font></div><div><font color=3D"#000000"><span style=3D"caret-color: r=
gb(0, 0, 0);">for production use.</span></font></div><div><font color=3D"#0=
00000"><span style=3D"caret-color: rgb(0, 0, 0);"><br></span></font></div><=
div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">This=
 release include security fix for CVE-2025-50054</span></font></div><div><f=
ont color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);"><br></span=
></font></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(=
0, 0, 0);">Highlights of this release include:</span></font></div><div><fon=
t color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* Multi-sock=
et support for servers -- Handle multiple addresses/ports/protocols&nbsp;</=
span></font></div><div><font color=3D"#000000"><span style=3D"caret-color: =
rgb(0, 0, 0);">within one server</span></font></div><div><font color=3D"#00=
0000"><span style=3D"caret-color: rgb(0, 0, 0);">* Improved Client support =
for DNS options</span></font></div><div><font color=3D"#000000"><span style=
=3D"caret-color: rgb(0, 0, 0);">* Client implementations for Linux/BSD, inc=
luded with the default install</span></font></div><div><font color=3D"#0000=
00"><span style=3D"caret-color: rgb(0, 0, 0);">* New client implementation =
for Windows, adding support for features like split&nbsp;</span></font></di=
v><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">D=
NS and DNSSEC</span></font></div><div><font color=3D"#000000"><span style=
=3D"caret-color: rgb(0, 0, 0);">* Architectural improvements on Windows</sp=
an></font></div><div><font color=3D"#000000"><span style=3D"caret-color: rg=
b(0, 0, 0);">* The block-local flag is now enforced with WFP filters</span>=
</font></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0=
, 0, 0);">* Windows network adapters are now generated on demand</span></fo=
nt></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0,=
 0);">* Windows automatic service now runs as an unprivileged user</span></=
font></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, =
0, 0);">* Support for server mode in win-dco driver</span></font></div><div=
><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">Note: S=
upport for the wintun driver has been removed. win-dco is now the&nbsp;</sp=
an></font></div><div><font color=3D"#000000"><span style=3D"caret-color: rg=
b(0, 0, 0);">default, tap-windows6 is the fallback solution for use-cases n=
ot covered by win-dco.</span></font></div><div><font color=3D"#000000"><spa=
n style=3D"caret-color: rgb(0, 0, 0);">* Improved data channel</span></font=
></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0=
);">* Enforcement of AES-GCM usage limit</span></font></div><div><font colo=
r=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* Epoch data keys =
and packet format</span></font></div><div><font color=3D"#000000"><span sty=
le=3D"caret-color: rgb(0, 0, 0);">* Support for new upstream DCO Linux kern=
el module</span></font></div><div><font color=3D"#000000"><span style=3D"ca=
ret-color: rgb(0, 0, 0);">* This release supports the new ovpn DCO Linux ke=
rnel module which will be&nbsp;</span></font></div><div><font color=3D"#000=
000"><span style=3D"caret-color: rgb(0, 0, 0);">available in future upstrea=
m Linux kernel releases. Backports of the new module&nbsp;</span></font></d=
iv><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">=
to current kernels are available via the ovpn-backports project.</span></fo=
nt></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0,=
 0);">* TLS 1.3 support with bleeding-edge mbedTLS versions</span></font></=
div><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span sty=
le=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">More details can be =
found in the Changes document:</span><br style=3D"caret-color: rgb(0, 0, 0)=
; color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(=
0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">=
&lt;</span><a href=3D"https://github.com/OpenVPN/openvpn/blob/master/Change=
s.rst">https://github.com/OpenVPN/openvpn/blob/master/Changes.rst</a><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><br st=
yle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-=
color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(=
0, 0, 0); color: rgb(0, 0, 0);">Source code and Windows installers can be d=
ownloaded from our download page:</span><br style=3D"caret-color: rgb(0, 0,=
 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: r=
gb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;">&lt;</span><a href=3D"https://openvpn.net/community-downloads/">https://=
openvpn.net/community-downloads/</a><span style=3D"caret-color: rgb(0, 0, 0=
); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0);=
 color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0=
, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">P=
ackages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in the=
 various</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);=
"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">official =
Community repositories:</span><br style=3D"caret-color: rgb(0, 0, 0); color=
: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0=
);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</s=
pan><a href=3D"https://community.openvpn.net/Pages/OpenVPN%20software%20rep=
os">https://community.openvpn.net/Pages/OpenVPN%20software%20repos</a><span=
 style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span><br s=
tyle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret=
-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb=
(0, 0, 0); color: rgb(0, 0, 0);">Kind regards,</span><br style=3D"caret-col=
or: rgb(0, 0, 0); color: rgb(0, 0, 0);"><font color=3D"#000000"><span style=
=3D"caret-color: rgb(0, 0, 0);">Yuriy Darnobyt</span></font><br></body></ht=
ml>=

--Apple-Mail=_5CDB0EC6-CA17-4C33-959D-3BB5DEB6E3D0--

