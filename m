Message-ID: <1581683898.3296.4.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Fri, 14 Feb 2020 07:38:18 -0500
In-Reply-To: <778643d1-7f14-a31b-949a-8aab94473e64@...1227...>
References: <1518302884.3072.1.camel@...2316...>
 <1518303011.3072.4.camel@...2316...>
 <778643d1-7f14-a31b-949a-8aab94473e64@...1227...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-nJVYAuDpfXHerozhJiN7"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v4 2/2] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--=-nJVYAuDpfXHerozhJiN7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-13 at 19:18 +0100, Arne Schwabe wrote:
> Am 10.02.18 um 23:50 schrieb James Bottomley:
> > Testing engines is problematic, so one of the prerequisites built
> > for the tests is a simple openssl engine that reads a non-standard
> > PEM guarded key.  The test is simply can we run a client/server
> > configuration with the usual sample key replaced by an engine key.
> > The trivial engine prints out some operations and we check for
> > these in the log to make sure the engine was used to load the key
> > and that it correctly got the password.
>=20
> This tests the openssl engine functionality in a sensible way. But I
> think it is not fully ready to be commited. To get it working I
> needed to do following changes on my Mac:

That could be ... I only have a linux box to try this out on.

> commit afa697cec15b4e54e720efe9de39c9b20b13c5c8 (HEAD ->
> review/enginekeys)
> Author: Arne Schwabe <arne@...1227...>
> Date:   Thu Feb 13 18:13:34 2020 +0100
>=20
>     foo
>=20
> diff --git a/tests/unit_tests/engine-key/Makefile.am
> b/tests/unit_tests/engine-key/Makefile.am
> index 73921965..6d7fc9c5 100644
> --- a/tests/unit_tests/engine-key/Makefile.am
> +++ b/tests/unit_tests/engine-key/Makefile.am
> @@ -10,4 +10,6 @@ TESTS_ENVIRONMENT =3D srcdir=3D"$(abs_srcdir)"; \
>  TESTS =3D check_engine_keys.sh
>=20
>  libtestengine_la_SOURCES =3D libtestengine.c
> -libtestengine_la_LDFLAGS =3D -rpath /lib -avoid-version
> +libtestengine_la_LDFLAGS =3D @TEST_LDFLAGS@  -rpath /lib
> +libtestengine_la_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir)
> -I$(compat_srcdir)
> +
> diff --git a/tests/unit_tests/engine-key/libtestengine.c
> b/tests/unit_tests/engine-key/libtestengine.c
> index fa7f5de1..46ec1e33 100644
> --- a/tests/unit_tests/engine-key/libtestengine.c
> +++ b/tests/unit_tests/engine-key/libtestengine.c
> @@ -30,7 +30,6 @@ static EVP_PKEY *engine_load_key(ENGINE *e, const
> char
> *key_id,
>         PKCS8_PRIV_KEY_INFO *p8inf;
>         UI *ui;
>         char auth[256];
> -       int len;

the variable is certainly unused and can go.

>         fprintf(stderr, "ENGINE: engine_load_key called\n");
>=20
> diff --git a/tests/unit_tests/engine-key/openssl.cnf
> b/tests/unit_tests/engine-key/openssl.cnf
> index 53200c46..e9513a92 100644
> --- a/tests/unit_tests/engine-key/openssl.cnf
> +++ b/tests/unit_tests/engine-key/openssl.cnf
> @@ -9,4 +9,4 @@ engines         =3D engines_section
>  testengine     =3D testengine_section
>=20
>  [testengine_section]
> -dynamic_path   =3D $ENV::srcdir/.libs/libtestengine.so
> +dynamic_path   =3D $ENV::srcdir/.libs/libtestengine.dylib

This can't really be done though: the .dylib extension won't work on
Linux because shared objects are .so files.

There is a way to generate and use .so files on a MAC as well,
according to the openssl people (half the mac engines seem to have a
.so extension and the other half a .dylib one), I'll see if I can
figure out what it is.

James

--=-nJVYAuDpfXHerozhJiN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXkaUugAKCRDnQslM7pis
hTCIAQDrzxG8WrL7WrNB6zFOHOA9HmFXl0SPGAFSy3gq1rU6twEAv77ZPQY2ltC+
Kc/CsyFL2YJWEWEENx0YGPKDp5EHE2k=
=ndpu
-----END PGP SIGNATURE-----

--=-nJVYAuDpfXHerozhJiN7--


