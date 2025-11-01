From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_CAFFEC82-72BC-4388-99A0-ACA934A59A88"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Message-Id: <0D74CA76-785C-4920-9956-7DE92047F3CA@...2722...>
Date: Sat, 1 Nov 2025 09:02:56 +0200
Subject: [Openvpn-devel] OpenVPN 2.7_rc1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_CAFFEC82-72BC-4388-99A0-ACA934A59A88
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_rc1.
This is a first release candidate for the feature release 2.7.0 which inclu=
des improvements and bug fixes.

Feature changes since 2.7_beta3:

* add warning for unsupported combination of --push and --tls-server
* add warning for unsupported combination of --reneg-bytes or --reneg-pkts =
with DCO
* remove perf_push()/perf_pop() infrastructure (because it did not work any=
more, and compiler profiling will give
  better results today)
* ensure compatibility with OpenSSL 3.6.0 - specifically, do not crash in t=
_lpback.sh trying to use=20
   new encrypt-then-mac (ETM) ciphers
* improved PUSH_UPDATE server side support, which now handles changes of pu=
shed ifconfig/ifconfig-ipv6 addresses
   correctly (send packets to new IP addresses to this client, stop sending=
 packets to the old addresses).
* freshen URLs all over the tree, and change to HTTPS where possible
* on DCO Linux/FreeBSD, add support for clients receiving an IPv4/IPv6 addr=
ess that is not part of
   the --server/--server-ipv6 subnet (=3D install extra on-interface host r=
outes).
* Windows programs use a new API for path name canonicalization now (PathCc=
hCanonicalizeEx()) which will break building
   with MinGW on Ubuntu 22.04 -> Upgrade to 24.04 to make builds work again.
* on Windows, when setting up WINS servers using netsh, use interface index=
 instead of adapter name now
   ("as for all other netsh calls")
* remove undocumented and unused --memstats feature

Important bug fixes since 2.7_beta3:

* even more type conversion related warnings have been fixed
* more bugfixes related to BYTECOUNT display on the management interface an=
d byte counters on DCO platforms in general
* numerous minibugs reported by ZeroPath AI have been fixed (small memleaks=
, possible file descriptor leaks,
  improved sanity checks, add ASSERT() on function contracts, etc.)

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

--Apple-Mail=_CAFFEC82-72BC-4388-99A0-ACA934A59A88
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><div><div><font color=3D"#0000=
00">The OpenVPN community project team is proud to release OpenVPN 2.7_rc1.=
</font></div><div><font color=3D"#000000">This is a first release candidate=
&nbsp;<span style=3D"caret-color: rgb(0, 0, 0);">for the feature release 2.=
7.0</span></font><span style=3D"color: rgb(0, 0, 0);">&nbsp;which includes =
improvements and bug fixes.</span></div><div><font color=3D"#000000"><br></=
font></div><div><div><font color=3D"#000000"><span style=3D"caret-color: rg=
b(0, 0, 0);">Feature changes since 2.7_beta3:</span></font></div><div><font=
 color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);"><br></span></=
font></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, =
0, 0);">* add warning for unsupported combination of --push and --tls-serve=
r</span></font></div><div><font color=3D"#000000"><span style=3D"caret-colo=
r: rgb(0, 0, 0);">* add warning for unsupported combination of --reneg-byte=
s or --reneg-pkts with DCO</span></font></div><div><font color=3D"#000000">=
<span style=3D"caret-color: rgb(0, 0, 0);">* remove perf_push()/perf_pop() =
infrastructure (because it did not work anymore, and compiler profiling wil=
l give</span></font></div><div><font color=3D"#000000"><span style=3D"caret=
-color: rgb(0, 0, 0);">&nbsp; </span></font><span style=3D"caret-color: rgb=
(0, 0, 0); color: rgb(0, 0, 0);">better results today)</span></div><div><fo=
nt color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* ensure co=
mpatibility with OpenSSL 3.6.0 - specifically, do not crash in t_lpback.sh =
trying to use&nbsp;</span></font></div><div><font color=3D"#000000"><span s=
tyle=3D"caret-color: rgb(0, 0, 0);">&nbsp; &nbsp;new encrypt-then-mac (ETM)=
 ciphers</span></font></div><div><font color=3D"#000000"><span style=3D"car=
et-color: rgb(0, 0, 0);">* improved PUSH_UPDATE server side support, which =
now handles changes of pushed ifconfig/ifconfig-ipv6 addresses</span></font=
></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0=
);">&nbsp; &nbsp;correctly (send packets to new IP addresses to this client=
, stop sending packets to the old addresses).</span></font></div><div><font=
 color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* freshen URL=
s all over the tree, and change to HTTPS where possible</span></font></div>=
<div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* o=
n DCO Linux/FreeBSD, add support for clients receiving an IPv4/IPv6 address=
 that is not part of</span></font></div><div><font color=3D"#000000"><span =
style=3D"caret-color: rgb(0, 0, 0);">&nbsp; &nbsp;the --server/--server-ipv=
6 subnet (=3D install extra on-interface host routes).</span></font></div><=
div><font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* Wi=
ndows programs use a new API for path name canonicalization now (PathCchCan=
onicalizeEx()) which will break building</span></font></div><div><font colo=
r=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">&nbsp; &nbsp;with =
MinGW on Ubuntu 22.04 -&gt; Upgrade to 24.04 to make builds work again.</sp=
an></font></div><div><font color=3D"#000000"><span style=3D"caret-color: rg=
b(0, 0, 0);">* on Windows, when setting up WINS servers using netsh, use in=
terface index instead of adapter name now</span></font></div><div><font col=
or=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">&nbsp; &nbsp;("as=
 for all other netsh calls")</span></font></div><div><font color=3D"#000000=
"><span style=3D"caret-color: rgb(0, 0, 0);">* remove undocumented and unus=
ed --memstats feature</span></font></div><div><font color=3D"#000000"><span=
 style=3D"caret-color: rgb(0, 0, 0);"><br></span></font></div><div><font co=
lor=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">Important bug fi=
xes since 2.7_beta3:</span></font></div><div><font color=3D"#000000"><span =
style=3D"caret-color: rgb(0, 0, 0);"><br></span></font></div><div><font col=
or=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* even more type =
conversion related warnings have been fixed</span></font></div><div><font c=
olor=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">* more bugfixes=
 related to BYTECOUNT display on the management interface and byte counters=
 on DCO platforms in general</span></font></div><div><font color=3D"#000000=
"><span style=3D"caret-color: rgb(0, 0, 0);">* numerous minibugs reported b=
y ZeroPath AI have been fixed (small memleaks, possible file descriptor lea=
ks,</span></font></div><div><font color=3D"#000000"><span style=3D"caret-co=
lor: rgb(0, 0, 0);">&nbsp; improved sanity checks, add ASSERT() on function=
 contracts, etc.)</span></font></div></div></div><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0=
); color: rgb(0, 0, 0);">More details can be found in the Changes document:=
</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br st=
yle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"care=
t-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://=
github.com/OpenVPN/openvpn/blob/master/Changes.rst">https://github.com/Open=
VPN/openvpn/blob/master/Changes.rst</a><span style=3D"caret-color: rgb(0, 0=
, 0); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rg=
b(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);=
">Source code and Windows installers can be downloaded from our download pa=
ge:</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br=
 style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"c=
aret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https=
://openvpn.net/community-downloads/">https://openvpn.net/community-download=
s/</a><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;<=
/span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br sty=
le=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret=
-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Packages for Debian, Ubuntu, Fe=
dora, RHEL, and openSUSE are available in the various</span><br style=3D"ca=
ret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);">official Community repositories:</span>=
<br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"=
caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color=
: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://communi=
ty.openvpn.net/Pages/OpenVPN%20software%20repos">https://community.openvpn.=
net/Pages/OpenVPN%20software%20repos</a><span style=3D"caret-color: rgb(0, =
0, 0); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0,=
 0); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: r=
gb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
;">Kind regards,</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0=
, 0, 0);"><font color=3D"#000000">Yuriy Darnobyt</font></body></html>=

--Apple-Mail=_CAFFEC82-72BC-4388-99A0-ACA934A59A88--

