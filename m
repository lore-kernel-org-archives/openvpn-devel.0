Date: Tue, 6 Nov 2012 11:23:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121106102317.GQ742@...1296...>
References: <1352196216-11560-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XqOulWco09xrjj7X"
Content-Disposition: inline
In-Reply-To: <1352196216-11560-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Fix double-free issue in
	pf_destroy_context()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--XqOulWco09xrjj7X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 06, 2012 at 11:03:36AM +0100, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> In commit dc7be6d078ba106f9b0de12f3e879c3561c3c537 the string_alloc() call
> in pf_init_context() was modified to use the gc_arena object for memory
> allocation.  What was not taken into consideration was that pf_destroy_co=
ntext()
> was also freeing memory allocated by string_alloc(), and when pf_init_con=
text()
> is calling gc_free() a double-free situation showed up.
>=20
> Lets remove the explict free, and let gc_free take care of all the memory=
 handling.

ACK (having read the through the relevant bits of init.c and through
pf_init_context()).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XqOulWco09xrjj7X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUJjlFakuBuNlUUl1AQKqtQQAisOOqh1elum4qmj6ciKEneokXL6F9bMu
o3ZTAIf5I24Jeusd1nmI/a4UzdwcXerw8wt0Kf49W/Oqk+dIR3ouQo5Bz3xLNh0g
yXHuCeDuUH5mzWrN6kIUX6roC3SA74iJg3/WbQ3y03NBHeIasAvnuDeiTJ7RfOAt
PCJf8/Y8YyI=
=t7YR
-----END PGP SIGNATURE-----

--XqOulWco09xrjj7X--

