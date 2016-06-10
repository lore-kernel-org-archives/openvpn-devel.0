Date: Fri, 10 Jun 2016 18:55:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160610165515.GG62247@...1296...>
References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
	<CAKuzo_jrwK47wDtoLNCZXP8-OG0izGmjZRrDb5vdT5shhY7FMQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jrwK47wDtoLNCZXP8-OG0izGmjZRrDb5vdT5shhY7FMQ@...278...>
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 10, 2016 at 12:43:20PM -0400, Selva Nair wrote:
> > @Selva, Arne: can we make the reconnect logic somewhat smarter overall,
> > like
> > "if reconnecting to the same host, wait 30 seconds instead of 5"?
>=20
> This is possible, but the case for progressively increasing the restart
> pause is not very strong. Can we get some feedback from people who serve
> 1000's of users?

I would generally consider it polite behaviour... (also, it might save
the client from filled-up disks...) - didn't think of exponential back-off
yet, but that would certainly be another approach to consider.

I have no idea how complicated it would be to implement, though.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1rw8qkuBuNlUUl1AQK6SgP/Xj0C248XM4Z3rQX5avxgjOBFwWnWXkFK
5Xz9ZTD/gyzMcTH7b+mMwQpwdHf7hScMxlzwUEB59xmY4jPkZfUvrlxMxa+NMvkT
ucqxWhN2wFjNzDT4WW74mKhzNP8HUvF/CAzHdkKhOiEfSycvPDjGDFC0cs/6sIrm
jeGRm7ETK5s=
=USdC
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--

