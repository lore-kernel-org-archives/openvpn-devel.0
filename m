Date: Tue, 10 Nov 2015 20:59:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151110195941.GT24952@...1296...>
References: <1446761780-13816-1-git-send-email-steffan@...1856...>
	<1446795759-3288-1-git-send-email-steffan@...1856...>
	<20151106205635.GA24952@...1296...>
	<56403904.10006@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline
In-Reply-To: <56403904.10006@...1227...>
Subject: Re: [Openvpn-devel] [PATCH (master,
 v2)] Fix (potential) memory leak in init_route_list()
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

--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 09, 2015 at 07:11:16AM +0100, Arne Schwabe wrote:
> > I can see why we do this gc_addspecial() dance in socket.c (because the
> > elements returned by getaddrinfo() are being pointed at, not copied).
> >=20
> > This usage here seems unneeded, as the code will walk netlist, copy
> > out the IPv4 addresses into a separate (gc-allocated) struct route_ipv4,
> > and never use parts of netlist again - so freeaddrinfo() *should* work,
> > and make the code slightly less complex.
> >=20
> > Arne, this came from you in commit e719a053534 (and I ACKed it) - could
> > you revisit this particular use and check whether it's truly needed?
>=20
> I don't think it is really needed. It is more consistency and we try to
> use gc functions instead of free/malloc.

Uh, I'm not sure I buy the "consistency" argument here - today we call
freeaddrinfo() in 9 places (not counting buffer.h), and gc_addspecial()
in 2 places...  so I'd more call for "simplicity wins", that is, if there=20
is no reason to delay calling freeaddrinfo(), we shouldn't do so - the
memory in use is not related to a gc...

Do you agree?

(For the time being I have merged Steffan's patch to fix the memory leak,
because it's a well-defined and correct change on its own - but I think thi=
s=20
one still needs changing :-))

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gMqNd2jlyJQcupG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkJMpKkuBuNlUUl1AQJXgAQAg+oEgN5pLF30lhvxWTVvqnI1gQu2HSbr
KoC+Zgzo1rFB4Rqnh9xcFT3oaLq3EBBirWkx7c5LsqsQ8eo5itZaOgEZbYu+CeG/
YyCWd3lA4Bld6sZ1b5K2lcgAebhNZiKalHKQ5QeTKy2FDOk2z2YF2zs0tsAoVzRg
ZBwLeCm6DrQ=
=MDh5
-----END PGP SIGNATURE-----

--gMqNd2jlyJQcupG/--

