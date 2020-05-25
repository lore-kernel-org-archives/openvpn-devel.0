Message-ID: <1590418289.4938.11.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 25 May 2020 07:51:29 -0700
In-Reply-To: <1c51551c-0038-9577-ceb5-7f5fd298e088@...1227...>
References: <20200524203322.15885-1-James.Bottomley@...2316...>
 <20200524203322.15885-3-James.Bottomley@...2316...>
 <20200525060415.GY1431@...1296...>
 <1c51551c-0038-9577-ceb5-7f5fd298e088@...1227...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-1UxNtpNJIbvpT+1tdbVY"
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
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=-1UxNtpNJIbvpT+1tdbVY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-25 at 14:52 +0200, Arne Schwabe wrote:
> Am 25.05.20 um 08:04 schrieb Gert Doering:
> > Hi,
> >=20
> > I see the granularity of your patch set as "not right":
> >=20
> > On Sun, May 24, 2020 at 01:33:22PM -0700, James Bottomley wrote:
> > > Testing engines is problematic, so one of the prerequisites built
> > > for the tests is a simple openssl engine that reads a non-
> > > standard PEM guarded key.  The test is simply can we run a
> > > client/server configuration with the usual sample key replaced by
> > > an engine key. The trivial engine prints out some operations and
> > > we check for these in the log to make sure the engine was used to
> > > load the key and that it correctly got the password.
> >=20
> > This patch says "add unit tests", but it contains changes to
> > configure.ac and OpenVPN code
> >=20
> > >  configure.ac                                  |   5 +
> > >  src/openvpn/crypto_openssl.c                  |   1 +
> >=20
> > These two hunks should go to the first patch.
> >=20
> > Every patch should be fully testable on its own - so if I apply
> > only the first hunk, I should be able to use and test engine keys,
> > without having to apply the "add a unit test" patch set.
> >=20
> > > diff --git a/src/openvpn/crypto_openssl.c
> > > b/src/openvpn/crypto_openssl.c
> > > index a7569623..34637ebf 100644
> > > --- a/src/openvpn/crypto_openssl.c
> > > +++ b/src/openvpn/crypto_openssl.c
> > > @@ -92,6 +92,7 @@ setup_engine(const char *engine)
> > >  {
> > >      ENGINE *e =3D NULL;
> > >=20=20
> > > +    OPENSSL_config(NULL);
> > >      ENGINE_load_builtin_engines();
> > >=20=20
> > >      if (engine)
> >=20
> > For that change, I wonder what side effects it might have on
> > existing
> > setups.  Arne, can you help?  Is this "safe"?
> >=20
>=20
> For OpenSSL 1.1 this is actually a NACK since it is depreacted API
> and we want to wrap those into ifdefs to be able to remove them when
> we drop support for older version.

OK ... it's replacement is a simple

OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);

which is easy to #ifdef around.

> For OpenSSL 1.1 this is a deprecated function to contrary to other
> depreacted function like OpenSSL_init() not a noop.
>=20
> But this command even though it does not have a return value or
> reports erro, can still put errors on the error stack.
>=20
> Reading the general openssl.cnf at engine_setup also feels a bit like
> the wrong place but since this code is only executed when --engine is
> present in the config and we will remove that OPENSSL_config in the
> future anyway (with the ifdef) it a low risk to put it here instead
> of a more proper place, so I am fine to do here.

So if the desire is to make openvpn fully consistent with regard to
local configuration files, the statement should be in crypto_lib_init()
rather than conditioning the behaviour on setting the engines
parameter.  I can certainly do that, as a separate patch, but it would
have a slightly wider blast radius.

> As a side note, engines are deprecated in OpenSSL 3.0.0 and are
> replaced by providers. But that will probably take a long time until
> that is really depreacted and removed, so adding/fixing this for now
> is okay.

Heh, yes, we're all waiting to see how that works out.

James

--=-1UxNtpNJIbvpT+1tdbVY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXsvbcgAKCRDnQslM7pis
hRaGAQCfpR/oOS6+fFuktqOVrwgDBpR8FFV5ge2z9kT+te6JgQEA4cT28Iwh9QYg
OmZAZzKGRHciGpMRdWODR5GI9aXgbS8=
=r3KZ
-----END PGP SIGNATURE-----

--=-1UxNtpNJIbvpT+1tdbVY--


