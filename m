Date: Thu, 11 Apr 2013 12:52:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130411105202.GA26778@...1296...>
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <201304110933.r3B9XwPT011987@...1729...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
	the output of the status command
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2013 at 11:33:58AM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch (ACK by me).=20=20
>=20
> I'm not sure whether we need this in release/2.3, but if people see the=20
> need, please speak up and I'll cherry-pick :-)
>=20
> commit 662ce6acc065bddf6490b3494725b8b3987b7def (master)

... unfortunately, it breaks --disable-managemnt builds :-( - good that
we have buildbots, stupid me for not noticing it before ACK-and-push.

Arne, could you send a post-patch, please, to #ifdef ENABLE_MANAGEMENT the
problematic line?

thanks,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUWaV0qkuBuNlUUl1AQJFmAQAtcbhExeghddlsDm3w35vB0d6GDV9d8Iq
SZWnb0+0x922bpAYwyyvndwdmp4VOkmJ4I5x6mSjGowymPQX+xFEt1lajNqNh8UU
3IJ+pNIkx+YQ0FStQcswx/ZgfKbQLi+5L4HXACbaNXXMgloMkoSa2xlmG7yzAqiY
q5JNTkgJNUY=
=RVJl
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

