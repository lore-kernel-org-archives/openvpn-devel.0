Date: Mon, 26 Mar 2012 18:05:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326160546.GV1359@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9R6240woFu/reHS"
Content-Disposition: inline
Subject: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations now
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--/9R6240woFu/reHS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

one of the things the new build system brought is us is *this*:

if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include  -I../../src/compat =
     -I/usr/include -I/usr/include     -g -O2 -MT ssl_verify_polarssl.o -MD=
 -MP -MF ".deps/ssl_verify_polarssl.Tpo" -c -o ssl_verify_polarssl.o ssl_ve=
rify_polarssl.c;  then mv -f ".deps/ssl_verify_polarssl.Tpo" ".deps/ssl_ver=
ify_polarssl.Po"; else rm -f ".deps/ssl_verify_polarssl.Tpo"; exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include  -I../../src/compat =
     -I/usr/include -I/usr/include     -g -O2 -MT status.o -MD -MP -MF ".de=
ps/status.Tpo" -c -o status.o status.c;  then mv -f ".deps/status.Tpo" ".de=
ps/status.Po"; else rm -f ".deps/status.Tpo"; exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include  -I../../src/compat =
     -I/usr/include -I/usr/include     -g -O2 -MT tun.o -MD -MP -MF ".deps/=
tun.Tpo" -c -o tun.o tun.c;  then mv -f ".deps/tun.Tpo" ".deps/tun.Po"; els=
e rm -f ".deps/tun.Tpo"; exit 1; fi

... instead of straightforward "gcc" invocations.

... and I wonder what the benefit is?  I find it much harder to see what
"make" is doing here (my eyes hurt when I look at this!), and unless there=
=20
is a clear benefit, I don't like adding convolutions...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--/9R6240woFu/reHS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3CT2qkuBuNlUUl1AQLr0wP/WSTJS7fc5W8ckI0+puBc9reSMFjzdF5D
8xe0afbOKp+Aoamr8QrY6x6gU8cEfV2i/JPFulKCdmRaXGY5PEaw93FXPwVbopYE
ftsNeOLDci1bXvKnF+GIJgVQ9UJ83KvAG5Qy7FXP+J/Nk0382GjJy9v6pFgU8UA7
+V4V4pLWkPE=
=VNDz
-----END PGP SIGNATURE-----

--/9R6240woFu/reHS--

