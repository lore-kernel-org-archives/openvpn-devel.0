Message-ID: <1590417371.4938.6.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 25 May 2020 07:36:11 -0700
In-Reply-To: <20200525060415.GY1431@...1296...>
References: <20200524203322.15885-1-James.Bottomley@...2316...>
 <20200524203322.15885-3-James.Bottomley@...2316...>
 <20200525060415.GY1431@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-XDkQHkwGN0bdpO92cj/u"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=-XDkQHkwGN0bdpO92cj/u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-25 at 08:04 +0200, Gert Doering wrote:
> Hi,
>=20
> I see the granularity of your patch set as "not right":
>=20
> On Sun, May 24, 2020 at 01:33:22PM -0700, James Bottomley wrote:
> > Testing engines is problematic, so one of the prerequisites built
> > for
> > the tests is a simple openssl engine that reads a non-standard PEM
> > guarded key.  The test is simply can we run a client/server
> > configuration with the usual sample key replaced by an engine key.
> > The trivial engine prints out some operations and we check for
> > these
> > in the log to make sure the engine was used to load the key and
> > that
> > it correctly got the password.
>=20
> This patch says "add unit tests", but it contains changes to
> configure.ac
> and OpenVPN code
>=20
> >  configure.ac                                  |   5 +
> >  src/openvpn/crypto_openssl.c                  |   1 +
>=20
> These two hunks should go to the first patch.

The configure.ac one adds the test Makefile ... it can't move.  The
other pieces figure out what the dynamic extension is, which is only
used by the test, so I think everything in the configure.ac change is
in the right place.

The second is a bit more problematic:  Right at the moment openvpn is
blind to local openssl configuration files.  To make the test work, it
needs to be able to add an engine, which requires a local file, so it's
only function is to enable the test, but it does add to openvpn
capabilities, I suppose.

James

> Every patch should be fully testable on its own - so if I apply only
> the first hunk, I should be able to use and test engine keys, without
> having to apply the "add a unit test" patch set.
>=20
> > diff --git a/src/openvpn/crypto_openssl.c
> > b/src/openvpn/crypto_openssl.c
> > index a7569623..34637ebf 100644
> > --- a/src/openvpn/crypto_openssl.c
> > +++ b/src/openvpn/crypto_openssl.c
> > @@ -92,6 +92,7 @@ setup_engine(const char *engine)
> >  {
> >      ENGINE *e =3D NULL;
> >=20=20
> > +    OPENSSL_config(NULL);
> >      ENGINE_load_builtin_engines();
> >=20=20
> >      if (engine)
>=20
> For that change, I wonder what side effects it might have on existing
> setups.  Arne, can you help?  Is this "safe"?
>=20
> gert

--=-XDkQHkwGN0bdpO92cj/u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXsvX2wAKCRDnQslM7pis
hYK1AQC1+aayS2fQNgrs3ljbaI3Kb5GiRhh+l67JTCgRfezF/QEA+nFdAkV1ZHzk
OJGxhLgq/wF8Jh3SSL3P3R5pm6gyjl4=
=NXVb
-----END PGP SIGNATURE-----

--=-XDkQHkwGN0bdpO92cj/u--


