Date: Thu, 14 Apr 2022 18:56:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YlhSV79z4W2J5lKJ@...1296...>
References: <000201d84fe6$fa5b7600$ef126200$@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xmmkCuIELIxCNzqX"
Content-Disposition: inline
In-Reply-To: <000201d84fe6$fa5b7600$ef126200$@chinatelecom.cn>
Subject: Re: [Openvpn-devel] a problem with openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: yuanxun <yuanx3@...2645...>
Cc: openvpn-devel@lists.sourceforge.net

--xmmkCuIELIxCNzqX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 14, 2022 at 06:03:57PM +0800, yuanxun wrote:
> Recently found a problem with openvpn
>=20
> environment:
>=20
> Linux version 5.4.0-100-generic (buildd@...2671...) (gcc version 9.3.0
> (Ubuntu 9.3.0-17ubuntu1~20.04))
>=20
> OpenVPN 2.6_git [git:dco/a503c91735538f21] x86_64-pc-linux-gnu [SSL
> (OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO] [AEAD] [DCO]
>=20
> When the Windows client is disconnected, the management interface "status"
> is used on the server, and the connected client will not exit immediately.

This depends on *how* the client is disconnected, and how it was connected
to start with.

On a TCP connection, the server knows (because TCP goes away).

On an UDP session, the server can't know whether the client has been
disconnected or is just "not sending anything", so how long it will take
to update the status file depends on the "keepalive" settings (no keepalive
=3D it might never update the status) and whether or not the client is
using "explicit-exit-notify" <<- "tell the server the client was=20
shutdown".

But even if explicit-exit-notify, it might run into timeout delays, if
the client is not properly disconnected but the machine crashes, the
internet router dies, ...


So, yes, this is the way it is.  If you think this is a problem, be
more specific, like "client config, server and client log when the
client disconnects (both with --verb 4), etc"

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xmmkCuIELIxCNzqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiWFJXAAoJEB2Cnv7KVigSfHgL/i56DuqqFJm5ECpPSjQl9Dlk
qByiXS8u/T/F/irYv6Wpjnyos3tiVFe/wUnwiLfXH4tsSMX0dx47VNauhbun8Yw1
LZJ/jczZkrWU0Ad8uJ9iuijR01WEKz7BTle/7HC7cGrh+atkPaPiqLlyMwBx6jvM
J6Z5Gf49YTspfHxG1b98FnXDMMUCghn5XnNTmwDRUIjgfP3V6L9j2WMXLA6Z0fEI
TZJoHqZjUMUt5A+8hrAnirXyADVFEmUxDYkDN10FmwwVTBDBTk9jm93nJC7WQlRv
czVdxzKvnvt5XcVeL5+eEO34Im8joMIBOIMJgiR2Xl7K5gMfqXGIARasL1Q1H58a
ZwyrB3Cs6gaf8dxg6DRG8L9g2sVLIES62rp1zxXXhlMAJLQNzRgd6aD+I7aF9SoU
LyUmsDGKDfO7cj09tgDH2PnJpsnmnCsOrKic7FmGo+f47ivp/VCkW1ybH5zojw0h
IrDMBTKh93mmuAyUcbb0P1TQHBXzv8LtZx1GSWkPBg==
=qJn1
-----END PGP SIGNATURE-----

--xmmkCuIELIxCNzqX--

