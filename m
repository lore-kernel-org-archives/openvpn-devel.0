Date: Sun, 3 Jun 2012 11:57:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120603095733.GJ400@...1296...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-2-git-send-email-arne@...1227...>
	<4FCA3E23.9010805@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <4FCA3E23.9010805@...1114...>
Subject: Re: [Openvpn-devel] [PATCH 1/8] Silence Port is now 1194 IANA
	warning if remote option with port is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--tMbDGjvJuJijemkf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Sat, Jun 02, 2012 at 06:24:03PM +0200, David Sommerseth wrote:
> Instead of this change, wouldn't it rather make sense to just remove
> the whole "#if 1 /* JYFIXME -- port warning */" block in init.c:2470
> instead?  This "new" port number was introduced in November 2004, so
> I'd say this warning has been laying around long enough.
>=20
> When doing that, we can also get rid of the port_option_used member
> completely too.  If you do:
>=20
>    $ git grep -n port_option_used
>=20
> in the source tree, you see where this is used, and it's not many
> places at all.

Sounds good to me.  Feature-ACK on removing the warning block and
port_option_used.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT8s1DakuBuNlUUl1AQKjcwP+IvLxCbGbfHchKjOz+iT5JTqwQCEyeSz5
je3c5iGM0R8GI2oOnkPfVh692KcLV6x5EAU5RyJ8ynUcW0jtNaRXhTK0y3kgY20d
VtIvgLXcCnMT+3Sx87uWdKJ5XHXxGkBP471D8fXmLTLOGVbGg8fwxOdHjxClmBeE
YYqulJLNV/0=
=JWBu
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--

