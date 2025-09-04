From: Yuriy Darnobyt <yuriy.darnobyt@...2722...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_2911EE85-19DE-47DA-9240-90A520AC4728"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Message-Id: <CF34B92B-9DE4-48A3-9C69-1731007656A1@...2722...>
Date: Thu, 4 Sep 2025 21:41:06 +0300
Subject: [Openvpn-devel] OpenVPN 2.7_beta1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

--Apple-Mail=_2911EE85-19DE-47DA-9240-90A520AC4728
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.7_beta1.
This is the first Beta release for the feature release 2.7.0. As the Beta n=
ame implies=20
this is an early release build, it is not intended for production use.

Feature changes since 2.7_alpha3:

- Introduction of route_redirect_gateway_ipv4 and _ipv6 env variables
- PUSH_UPDATE server support (via management interface)
- Rewrite of the management interface "bytecount" infastructure to better i=
nteract with DCO

Important bug fixes since 2.7_alpha3:

- Bugfixes in --dns-updown script for linux systems using resolvconf
- A large number of signed/unsigned related warnings have been fixed

The biggest noticeable difference in beta1 is the reformatting using
clang-format, leaving uncrustify as that wasn't stable across versions.

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

--Apple-Mail=_2911EE85-19DE-47DA-9240-90A520AC4728
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;"><div><div><font color=3D"#0000=
00"><span style=3D"caret-color: rgb(0, 0, 0);">The OpenVPN community projec=
t team is proud to release OpenVPN 2.7_beta1.</span></font></div><div><font=
 color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">This is the f=
irst Beta release for the feature release 2.7.0. As the Beta name implies&n=
bsp;</span></font></div><div><font color=3D"#000000"><span style=3D"caret-c=
olor: rgb(0, 0, 0);">this is an early release build, it is not intended for=
 production use.</span></font></div><div><font color=3D"#000000"><span styl=
e=3D"caret-color: rgb(0, 0, 0);"><br></span></font></div><div><font color=
=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">Feature changes sin=
ce 2.7_alpha3:</span></font></div><div><font color=3D"#000000"><span style=
=3D"caret-color: rgb(0, 0, 0);"><br></span></font></div><div><font color=3D=
"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">- Introduction of rout=
e_redirect_gateway_ipv4 and _ipv6 env variables</span></font></div><div><fo=
nt color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">- PUSH_UPDA=
TE server support (via management interface)</span></font></div><div><font =
color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);">- Rewrite of t=
he management interface "bytecount" infastructure to better interact with D=
CO</span></font></div><div><font color=3D"#000000"><span style=3D"caret-col=
or: rgb(0, 0, 0);"><br></span></font></div><div><font color=3D"#000000"><sp=
an style=3D"caret-color: rgb(0, 0, 0);">Important bug fixes since 2.7_alpha=
3:</span></font></div><div><font color=3D"#000000"><span style=3D"caret-col=
or: rgb(0, 0, 0);"><br></span></font></div><div><font color=3D"#000000"><sp=
an style=3D"caret-color: rgb(0, 0, 0);">- Bugfixes in --dns-updown script f=
or linux systems using resolvconf</span></font></div><div><font color=3D"#0=
00000"><span style=3D"caret-color: rgb(0, 0, 0);">- A large number of signe=
d/unsigned related warnings have been fixed</span></font></div></div><div><=
font color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, 0);"><br></spa=
n></font></div><div><font color=3D"#000000"><span style=3D"caret-color: rgb=
(0, 0, 0);"><div>The biggest noticeable difference in beta1 is the reformat=
ting using</div><div>clang-format, leaving uncrustify as that wasn't stable=
 across versions.</div></span></font></div><br style=3D"caret-color: rgb(0,=
 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); col=
or: rgb(0, 0, 0);">More details can be found in the Changes document:</span=
><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D=
"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-colo=
r: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://github=
.com/OpenVPN/openvpn/blob/master/Changes.rst">https://github.com/OpenVPN/op=
envpn/blob/master/Changes.rst</a><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0); co=
lor: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0=
, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Sour=
ce code and Windows installers can be downloaded from our download page:</s=
pan><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=
=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-c=
olor: rgb(0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://ope=
nvpn.net/community-downloads/">https://openvpn.net/community-downloads/</a>=
<span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&gt;</span>=
<br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"=
caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color=
: rgb(0, 0, 0); color: rgb(0, 0, 0);">Packages for Debian, Ubuntu, Fedora, =
RHEL, and openSUSE are available in the various</span><br style=3D"caret-co=
lor: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(0,=
 0, 0); color: rgb(0, 0, 0);">official Community repositories:</span><br st=
yle=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br style=3D"caret-=
color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><span style=3D"caret-color: rgb(=
0, 0, 0); color: rgb(0, 0, 0);">&lt;</span><a href=3D"https://community.ope=
nvpn.net/Pages/OpenVPN%20software%20repos">https://community.openvpn.net/Pa=
ges/OpenVPN%20software%20repos</a><span style=3D"caret-color: rgb(0, 0, 0);=
 color: rgb(0, 0, 0);">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0); c=
olor: rgb(0, 0, 0);"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, =
0, 0);"><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Kin=
d regards,</span><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0=
);"><font color=3D"#000000">Yuriy Darnobyt</font></body></html>=

--Apple-Mail=_2911EE85-19DE-47DA-9240-90A520AC4728--

