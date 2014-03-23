Date: Sun, 23 Mar 2014 22:20:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140323212027.GE16637@...1296...>
References: <1393684575-28112-2-git-send-email-steffan@...1856...>
	<201403232113.s2NLDWNW028186@...1295...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v+M6uv+WTWi6sV+t"
Content-Disposition: inline
In-Reply-To: <201403232113.s2NLDWNW028186@...1295...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add openssl-specific common
	cipher list names to ssl.c.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--v+M6uv+WTWi6sV+t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 23, 2014 at 10:13:32PM +0100, Gert Doering wrote:
> Your patch has been applied to the master and release/2.3 branch.
>=20
> commit 0146fd00c3bd70a470290be7be27ee75db2db63b (master)
> commit a39ceebc4f7cf05f07941556c9d11430cf855e22 (master)

The second line should, obviously, have been "(release/2.3)".  Too quick...

But the commit ID is right :-)

And now, a new episode of "watch buildbot burn"... *some* of these many
patches pushed today might have actually fixed OpenSolaris' socket=20
problems... let's see which buildbots had too old OpenSSL versions...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v+M6uv+WTWi6sV+t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUy9QG6kuBuNlUUl1AQLD+AP+NjU4xKN+krOuSaUZ4/SMcDV3bI9p7XyA
Y0BkobqVBIA7doLSfhXmbzgPz/W1pOPYmr6LRqZOR4kA/7eOTITxNpbGOPxhw5Y3
f5tQzXnS3FAc2jnFypG+7scyS1+bqAc4RZWrUlUrNbEvpPPNrkot6nwTPkdO1ecS
suKhh7hxMWk=
=ZDAw
-----END PGP SIGNATURE-----

--v+M6uv+WTWi6sV+t--

