From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_EE4F78C7-F728-4299-9B8D-A66DADE7D525"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Message-Id: <112D94AC-CF5C-4A85-8901-92BDAD8780F8@...2722...>
Date: Wed, 22 Apr 2026 23:36:23 +0300
Subject: [Openvpn-devel] OpenVPN 2.6.20 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_EE4F78C7-F728-4299-9B8D-A66DADE7D525
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.6.20. This=
 is a bugfix release containing security fixes.

For details see [Changes.rst](https://github.com/OpenVPN/openvpn/blob/v2.6.=
20/Changes.rst)

Security fixes:

* CVE-2026-40215: fix race condition in TLS handshake that could lead to le=
aking of
  packet data from a previous handshake under specific circumstances
* CVE-2026-35058: fix server ASSERT() on receiving a suitably malformed pac=
ket with
  a valid tls-crypt-v2 key
=20=20
Bugfixes:

* management: stop periodic bytecount output on mgmt client disconnection
* FreeBSD: make DCO work on systems with no IPv4 support
* FreeBSD: fix compilation with --enable-async-push on FreeBSD 15
* Linux: make DCO work on big endian architectures (MIPS, PowerPC)
* Windows: fix deinstallation progress bar on adapter deletion.
* Linux: fix problem with DCO kernel notifications getting lost, leading
  to overcounting of number of connected clients and general confusion
  between kernel and userland regarding peer status (Github openvpn#900,
  openvpn#918, openvpn#931, openvpn#919, openvpn#945) - this is a backport =
of
  the fixes in 2.7 plus the infrastructural changes around DCO needed to su=
pport it.

Windows MSI changes since 2.6.19-I001:
* Built against OpenSSL 3.6.2
* Included openvpn-gui updated to 11.63.0.0
  * Translation cleanup. Remove obsolete strings related to support for Ope=
nVPN < 2.0
  * Translation updates.

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.6.20/Changes.rst <https://githu=
b.com/OpenVPN/openvpn/blob/v2./Changes.rst>>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in th=
e various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
Yuriy Darnobyt=

--Apple-Mail=_EE4F78C7-F728-4299-9B8D-A66DADE7D525
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" c=
ontent=3D"text/html; charset=3Dus-ascii"></head><body style=3D"overflow-wra=
p: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;"><d=
iv><div>The OpenVPN community project team is proud to release OpenVPN 2.6.=
20. This is a bugfix release containing security fixes.</div><div><br></div=
><div>For details see [Changes.rst](https://github.com/OpenVPN/openvpn/blob=
/v2.6.20/Changes.rst)</div><div><br></div><div>Security fixes:</div><div><b=
r></div><div>* CVE-2026-40215: fix race condition in TLS handshake that cou=
ld lead to leaking of</div><div>&nbsp; packet data from a previous handshak=
e under specific circumstances</div><div>* CVE-2026-35058: fix server ASSER=
T() on receiving a suitably malformed packet with</div><div>&nbsp; a valid =
tls-crypt-v2 key</div><div>&nbsp;&nbsp;</div><div>Bugfixes:</div><div><br><=
/div><div>* management: stop periodic bytecount output on mgmt client disco=
nnection</div><div>* FreeBSD: make DCO work on systems with no IPv4 support=
</div><div>* FreeBSD: fix compilation with --enable-async-push on FreeBSD 1=
5</div><div>* Linux: make DCO work on big endian architectures (MIPS, Power=
PC)</div><div>* Windows: fix deinstallation progress bar on adapter deletio=
n.</div><div>* Linux: fix problem with DCO kernel notifications getting los=
t, leading</div><div>&nbsp; to overcounting of number of connected clients =
and general confusion</div><div>&nbsp; between kernel and userland regardin=
g peer status (Github openvpn#900,</div><div>&nbsp; openvpn#918, openvpn#93=
1, openvpn#919, openvpn#945) - this is a backport of</div><div>&nbsp; the f=
ixes in 2.7 plus the infrastructural changes around DCO needed to support i=
t.</div><div><br></div><div>Windows MSI changes since 2.6.19-I001:</div><di=
v>* Built against OpenSSL 3.6.2</div><div>* Included openvpn-gui updated to=
 11.63.0.0</div><div>&nbsp; * Translation cleanup. Remove obsolete strings =
related to support for OpenVPN &lt; 2.0</div><div>&nbsp; * Translation upda=
tes.</div></div><br>More details can be found in the Changes document:<br><=
br>&lt;<a href=3D"https://github.com/OpenVPN/openvpn/blob/v2./Changes.rst">=
https://github.com/OpenVPN/openvpn/blob/v2.6.20/Changes.rst</a>&gt;<br><br>=
Source code and Windows installers can be downloaded from our download page=
:<br><br>&lt;<a href=3D"https://openvpn.net/community/">https://openvpn.net=
/community/</a>&gt;<br><br>Packages for Debian, Ubuntu, Fedora, RHEL, and o=
penSUSE are available in the various<br>official Community repositories:<br=
><br>&lt;<a href=3D"https://community.openvpn.net/Pages/OpenVPN%20software%=
20repos">https://community.openvpn.net/Pages/OpenVPN%20software%20repos</a>=
&gt;<div><br></div><div><p style=3D"margin: 0px; font-style: normal; font-v=
ariant-caps: normal; font-width: normal; line-height: normal; font-size-adj=
ust: none; font-kerning: auto; font-variant-alternates: normal; font-varian=
t-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian:=
 normal; font-variant-position: normal; font-variant-emoji: normal; font-fe=
ature-settings: normal; font-optical-sizing: auto; font-variation-settings:=
 normal; color: rgb(0, 0, 0); -webkit-text-stroke-width: 0px; -webkit-text-=
stroke-color: rgb(0, 0, 0);"><span style=3D"font-kerning: none">Kind regard=
s,</span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-width: normal; line-height: normal; font-size-adjust: none; font-kerning:=
 auto; font-variant-alternates: normal; font-variant-ligatures: normal; fon=
t-variant-numeric: normal; font-variant-east-asian: normal; font-variant-po=
sition: normal; font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0=
, 0); -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, =
0);"><span style=3D"font-kerning: none">Yuriy Darnobyt</span></p></div></bo=
dy></html>=

--Apple-Mail=_EE4F78C7-F728-4299-9B8D-A66DADE7D525--

