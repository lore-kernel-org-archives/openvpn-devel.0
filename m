Date: Tue, 15 Jun 2021 20:26:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210615182645.GE976@...1296...>
References: <E1lW0eX-00012w-9n@...2487...>
 <202104130557.13D5v3dv030280@...2054...>
 <54bcbe67-90cc-1f8e-5ff7-5c4a15fda096@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4raIqDplZ3r2o22S"
Content-Disposition: inline
In-Reply-To: <54bcbe67-90cc-1f8e-5ff7-5c4a15fda096@...277...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix build with mbedtls w/o
 SSL renegotiation support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Magnus Kroken <mkroken@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--4raIqDplZ3r2o22S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 21, 2021 at 11:44:25PM +0200, Magnus Kroken wrote:
> On 13.04.2021 07:57, Gert Doering wrote:
> > Your patch has been applied to the master branch.
> >=20
> > commit e4bd17c86e01aaf6f809d9ea355419c86c4defdc
> > Author: Max Fillinger
> > Date:   Mon Apr 12 19:46:17 2021 +0200
> >=20
> >       Fix build with mbedtls w/o SSL renegotiation support
>=20
> Please backport this to release/2.5 as well. 2.5.2 is affected by this=20
> and does not compile with an mbed TLS library built in this manner.

Took me a while, but here we go...

commit ad4f8e37617f3f020154bd224f9b693714c6370a (release/2.5)
Author: Max Fillinger <maximilian.fillinger@...2507...>
Date:   Mon Apr 12 19:46:17 2021 +0200

    Fix build with mbedtls w/o SSL renegotiation support

    Signed-off-by: Gert Doering <gert@...1296...>
    (cherry picked from commit e4bd17c86e01aaf6f809d9ea355419c86c4defdc)


and yes, this obviously makes sense as 2.5 has the offending
mbedtls_ssl_conf_renegotiation() call...=20

I do think that mbedTLS is being fairly unfriendly here - they should=20
always provide the function, and just return an error if the application=20
requests to *enable* SSL_RENEGOTIATION, but it wasn't compiled in...=20=20
*disabling* is a no-op in that case, so shouldn't require conditional
code in the caller.  But this is not a fairy tale, so I get to live with
the #ifdef...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--4raIqDplZ3r2o22S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgyPDkAAoJEB2Cnv7KVigSLfQL/iAhgKxZBA8pGdoe2HIlo6UT
SBD9evoGNZVwHZR1E7GSdM0s8Bk+WU7roD3DI/M5q7XCeZTA51W2SdgBAQ2Vc+v4
zuurvFf4uCyuhAouKOzHk1NJaxjHrQXMXAbIyx9nfcaaG/uYOeJQrkE9e4oNB9n2
0WmhRkpa/ju6BCZlTujC1hYQo2R3wYMEVFO8YOpo28dmte4AYexHZs8fM/y5cofV
tlUmN2Pnm53qRZP99H8JXK+bQw44dycQCRGi5Ltxt39m5Tylce64H0QvfovRGfX6
Hai24+VTup1shAmGrDRYb5nWYgaksPeQNdqoej5iga/0vCIlGH+h6HHGbhSQUqxM
/Oa7nEBl/lD+xJ+xN90IC6MfDLYZNs691WwAqRWpwjZPnF24GV6oTlTtgf/LeYoR
xvKWDCR236puFcFl9bMMLHwSPgUwlUdQlSQPU2ygm46JYqGHy0cPYn7/cQhioghd
cThbnWiG1Db1zTByF1DbrNZhHydZw3IcKM/NdaPO5Q==
=z5tj
-----END PGP SIGNATURE-----

--4raIqDplZ3r2o22S--

