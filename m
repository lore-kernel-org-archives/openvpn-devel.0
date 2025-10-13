From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_D346784F-89C4-414D-B699-885614A0EA53"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Message-Id: <8074294C-4A54-4B27-8F45-948D40CBC9C4@...2722...>
Date: Mon, 13 Oct 2025 23:09:19 +0300
Subject: [Openvpn-devel] OpenVPN 2.7_beta3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Apple-Mail=_D346784F-89C4-414D-B699-885614A0EA53
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_beta3.
This is a third beta which includes improvements and bug fixes.

Feature changes since 2.7_beta2:

* improvements on PUSH_UPDATE handling on the server side
* improve "recursive routing checks", prepare the way for a policy-based se=
tup where "packets to VPN server"
  could end up in the tunnel without interfering with OpenVPN operations
* add support for "eoch" data format to DCO on Windows (needs dco-win drive=
r 2.8.0+)
* clean up and remove outdated stuff from COPYING

Important bug fixes since 2.7_beta2:

* bugfixes reconnect and PUSH_UPDATE handling on the client side (notably h=
andling of=20
  ifconfig/ifconfig-ipv6/redirect-gateway ipv6 if the server is not always =
pushing the same address families)

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

--Apple-Mail=_D346784F-89C4-414D-B699-885614A0EA53
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><div><div><font color=3D"#0000=
00">The OpenVPN community project team is proud to release OpenVPN 2.7_beta=
3.</font></div><div><font color=3D"#000000">This is a third beta which incl=
udes improvements and bug fixes.</font></div><div><font color=3D"#000000"><=
br></font></div><div><font color=3D"#000000">Feature changes since 2.7_beta=
2:</font></div><div><font color=3D"#000000"><br></font></div><div><font col=
or=3D"#000000">*&nbsp;</font>improvements on PUSH_UPDATE handling on the se=
rver side</div><div>* improve "recursive routing checks", prepare the way f=
or a policy-based setup where "packets to VPN server"</div><div>&nbsp; coul=
d end up in the tunnel without interfering with OpenVPN operations</div><di=
v>* add support for "eoch" data format to DCO on Windows (needs dco-win dri=
ver 2.8.0+)</div><div>* clean up and remove outdated stuff from COPYING</di=
v><div><font color=3D"#000000"><br></font></div><div><font color=3D"#000000=
">Important bug fixes since 2.7_beta2:</font></div><div><font color=3D"#000=
000"><br></font></div><div><font color=3D"#000000">*&nbsp;<span style=3D"ca=
ret-color: rgb(0, 0, 0);">bugfixes reconnect and PUSH_UPDATE handling on th=
e client side (notably handling of&nbsp;</span></font></div><div><font colo=
r=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">&nbsp; ifconfig/if=
config-ipv6/redirect-gateway ipv6 if the server is not always pushing the s=
ame address families)</span></font></div></div><br style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0);=
 color: rgb(0, 0, 0);">More details can be found in the Changes document:</=
span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br styl=
e=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-=
color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://gi=
thub.com/OpenVPN/openvpn/blob/master/Changes.rst">https://github.com/OpenVP=
N/openvpn/blob/master/Changes.rst</a><span style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0)=
; color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(=
0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">=
Source code and Windows installers can be downloaded from our download page=
:</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br s=
tyle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"car=
et-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https:/=
/openvpn.net/community-downloads/">https://openvpn.net/community-downloads/=
</a><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</s=
pan><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-c=
olor: rgb(0, 0, 0); color: rgb(0, 0, 0);">Packages for Debian, Ubuntu, Fedo=
ra, RHEL, and openSUSE are available in the various</span><br style=3D"care=
t-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0);">official Community repositories:</span><b=
r style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"ca=
ret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://community=
.openvpn.net/Pages/OpenVPN%20software%20repos">https://community.openvpn.ne=
t/Pages/OpenVPN%20software%20repos</a><span style=3D"caret-color: rgb(0, 0,=
 0); color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0=
); color: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb=
(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"=
>Kind regards,</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, =
0, 0);"><font color=3D"#000000">Yuriy Darnobyt</font></body></html>=

--Apple-Mail=_D346784F-89C4-414D-B699-885614A0EA53--

