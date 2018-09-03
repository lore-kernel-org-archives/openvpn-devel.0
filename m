MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@...1808...>
Date: Mon, 3 Sep 2018 11:24:16 +0200
Message-ID: <CAATJJ0JWDwT-BLR2W4bxRrJJu+jooVOhGpG2yrRvoXW3H1ii8g@...278...>
Content-Type: multipart/alternative; boundary="0000000000008396090574f41cb6"
Subject: [Openvpn-devel] sbuild_wrapper: please unify service rules with
 openvpn repository
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000008396090574f41cb6
Content-Type: text/plain; charset="UTF-8"

Hi,
the upstream provided .deb [1] e.g. for Ubuntu Xenial gets its service file
from [2] which is outdated.
This makes the upstream Repos [3] not being in sync
I'd ask you to follow the main repo [4] on that to eliminate some Delta.

In general I think that some of the packaging is outdated and
sbuild_wrapper could fetch some more from Debian [5] and Ubuntu [6] (which
match among each other on this)

P.S. those upstream debs are AFAIK built by [7]

[1]:
http://build.openvpn.net/debian/openvpn/release/2.4/pool/xenial/main/o/openvpn/
[2]:
https://github.com/OpenVPN/sbuild_wrapper/tree/master/packaging/xenial/debian
[3]: https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos
[4]:
https://github.com/OpenVPN/openvpn/blob/master/distro/systemd/openvpn-server%40.service.in
[5]: https://salsa.debian.org/paelzer-guest/openvpn
[6]:
https://code.launchpad.net/~usd-import-team/ubuntu/+source/openvpn/+git/openvpn/+ref/ubuntu/devel
[7]: https://github.com/OpenVPN/sbuild_wrapper

-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd

--0000000000008396090574f41cb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r">Hi,<div>the upstream provided .deb [1] e.g. for Ubuntu Xenial gets its s=
ervice file from [2] which is outdated.</div><div>This makes the upstream R=
epos [3] not being in sync=C2=A0</div><div>I&#39;d ask you to follow the ma=
in repo [4] on that to eliminate some Delta.</div><div><br></div><div>In ge=
neral I think that some of the packaging is outdated and sbuild_wrapper cou=
ld fetch some more from Debian [5] and Ubuntu [6] (which match among each o=
ther on this)</div><div><br></div><div>P.S. those upstream debs are AFAIK b=
uilt by [7]</div><div><br></div><div>[1]:=C2=A0<a href=3D"http://build.open=
vpn.net/debian/openvpn/release/2.4/pool/xenial/main/o/openvpn/">http://buil=
d.openvpn.net/debian/openvpn/release/2.4/pool/xenial/main/o/openvpn/</a></d=
iv><div><div>[2]:=C2=A0<a href=3D"https://github.com/OpenVPN/sbuild_wrapper=
/tree/master/packaging/xenial/debian">https://github.com/OpenVPN/sbuild_wra=
pper/tree/master/packaging/xenial/debian</a></div></div><div>[3]:=C2=A0<a h=
ref=3D"https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos">htt=
ps://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos</a></div><div>=
[4]:=C2=A0<a href=3D"https://github.com/OpenVPN/openvpn/blob/master/distro/=
systemd/openvpn-server%40.service.in">https://github.com/OpenVPN/openvpn/bl=
ob/master/distro/systemd/openvpn-server%40.service.in</a><br></div><div>[5]=
:=C2=A0<a href=3D"https://salsa.debian.org/paelzer-guest/openvpn">https://s=
alsa.debian.org/paelzer-guest/openvpn</a></div><div>[6]:=C2=A0<a href=3D"ht=
tps://code.launchpad.net/~usd-import-team/ubuntu/+source/openvpn/+git/openv=
pn/+ref/ubuntu/devel">https://code.launchpad.net/~usd-import-team/ubuntu/+s=
ource/openvpn/+git/openvpn/+ref/ubuntu/devel</a></div><div>[7]:=C2=A0<a hre=
f=3D"https://github.com/OpenVPN/sbuild_wrapper">https://github.com/OpenVPN/=
sbuild_wrapper</a></div><div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span style=3D"=
color:rgb(136,136,136);font-size:12.8px">Christian Ehrhardt</span><div styl=
e=3D"color:rgb(136,136,136);font-size:12.8px">Software Engineer, Ubuntu Ser=
ver</div><div style=3D"color:rgb(136,136,136);font-size:12.8px">Canonical L=
td</div></div></div></div></div></div></div></div></div></div></div></div><=
/div></div></div>

--0000000000008396090574f41cb6--

