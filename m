Date: Wed, 11 Jan 2012 20:11:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120111191118.GA27815@...1296...>
References: <1326290252-25076-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1326290252-25076-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] autotools ./configure don't like
	compat.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: dazo@...1345..., openvpn-devel@lists.sourceforge.net

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 11, 2012 at 02:57:32PM +0100, David Sommerseth wrote:
> The compat.h include file cannot be loaded when ./configure runs,
> as many of the HAVE_* declarations are not set.  This makes test
> compilations when looking for features fail.
>=20
> As ./configure will load syshead.h, it pulls in compat.h this way.
> Looking more carefully at syshead.h, there's a #ifndef PACKAGE_NAME
> check if config.h should be included.  This looks like a check if
> syshead.h is loaded via ./configure or if it is a more normal
> compilation.  Moving the compat.h inclusion into this #ifndef block.

As I've seen you testing this on IRC and this fixes things -> ACK :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTw3e1qkuBuNlUUl1AQLR+AQAgiEv28SMP+lHPZIj1UEMvf0MqIBtnf7+
h0EAH0OUkBSRh25ePtlveBULRjC9VRvL7w8iGX7A5zrCr4O2A5j6U1Xh8bI42ouf
kfYgDPzaBrd5XXHFP/feXKYPmgYlV1YKOayoKCH6Ndpri/YLueVrsC2A27e1upT1
C7TqP+UBtRI=
=efBU
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

