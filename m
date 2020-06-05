References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
Date: Fri, 5 Jun 2020 13:31:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200528225920.6983-4-James.Bottomley@...2316...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HdEhvvMIBqy7galuiwknCD3ItSKjR17RE"
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2316...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HdEhvvMIBqy7galuiwknCD3ItSKjR17RE
Content-Type: multipart/mixed; boundary="u2SAckCFlrEwYyvhGkbBNMboazOMsR0pb"

--u2SAckCFlrEwYyvhGkbBNMboazOMsR0pb
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.05.20 um 00:59 schrieb James Bottomley:
> Testing engines is problematic, so one of the prerequisites built for
> the tests is a simple openssl engine that reads a non-standard PEM
> guarded key.  The test is simply can we run a client/server
> configuration with the usual sample key replaced by an engine key.
> The trivial engine prints out some operations and we check for these
> in the log to make sure the engine was used to load the key and that
> it correctly got the password.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@...2316...>
>=20
> ---
> v5: do not hard code dynamic library extension into openssl.cnf (MacOS)
> v4: add OPENSSL_config(NULL) so debian checks will work
> v3: added this patch
> ---
>  configure.ac                                  |   5 +
>  tests/unit_tests/Makefile.am                  |   3 +
>  tests/unit_tests/engine-key/Makefile.am       |  24 +++++
>  .../engine-key/check_engine_keys.sh           |  30 ++++++
>  tests/unit_tests/engine-key/libtestengine.c   | 101 ++++++++++++++++++
>  tests/unit_tests/engine-key/openssl.cnf.in    |  12 +++
>  6 files changed, 175 insertions(+)
>  create mode 100644 tests/unit_tests/engine-key/Makefile.am
>  create mode 100755 tests/unit_tests/engine-key/check_engine_keys.sh
>  create mode 100644 tests/unit_tests/engine-key/libtestengine.c
>  create mode 100644 tests/unit_tests/engine-key/openssl.cnf.in
>=20
> diff --git a/configure.ac b/configure.ac
> index 273a8d1b..92d4eeba 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1387,6 +1387,10 @@ AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKO=
UT}" =3D "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam=
}" =3D "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_ro=
ot}" =3D "yes"])
>  AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" =
=3D "yes"])
> +AM_CONDITIONAL([OPENSSL_ENGINE], [test "${have_openssl_engine}" =3D "yes=
"])
> +
> +shrext=3D$shrext_cmds
> +AC_SUBST([shrext])
>=20=20
>  sampledir=3D"\$(docdir)/sample"
>  AC_SUBST([plugindir])
> @@ -1448,6 +1452,7 @@ AC_CONFIG_FILES([
>          tests/unit_tests/openvpn/Makefile
>          tests/unit_tests/plugins/Makefile
>          tests/unit_tests/plugins/auth-pam/Makefile
> +	tests/unit_tests/engine-key/Makefile
>  	sample/Makefile
>  ])
>  AC_CONFIG_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])
> diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
> index 33fefaac..f27cd90f 100644
> --- a/tests/unit_tests/Makefile.am
> +++ b/tests/unit_tests/Makefile.am
> @@ -2,4 +2,7 @@ AUTOMAKE_OPTIONS =3D foreign
>=20=20
>  if ENABLE_UNITTESTS
>  SUBDIRS =3D example_test openvpn plugins
> +if OPENSSL_ENGINE
> +SUBDIRS +=3D engine-key
> +endif
>  endif
> diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/e=
ngine-key/Makefile.am
> new file mode 100644
> index 00000000..05f56bfd
> --- /dev/null
> +++ b/tests/unit_tests/engine-key/Makefile.am
> @@ -0,0 +1,24 @@
> +AUTOMAKE_OPTIONS =3D foreign
> +
> +check_LTLIBRARIES =3D libtestengine.la
> +conffiles =3D openssl.cnf
> +
> +TESTS_ENVIRONMENT =3D srcdir=3D"$(abs_srcdir)"; \
> +	builddir=3D"$(abs_builddir)"; \
> +	top_builddir=3D"$(top_builddir)"; \
> +	top_srcdir=3D"$(top_srcdir)"; \
> +	export srcdir builddir top_builddir top_srcdir;
> +
> +TESTS =3D check_engine_keys.sh
> +check_engine_keys.sh: $(conffiles)
> +
> +clean-local:
> +	rm -f $(conffiles)
> +
> +$(builddir)/%.cnf: $(srcdir)/%.cnf.in
> +	sed 's/SHREXT/@shrext@/' < $< > $@
> +
> +libtestengine_la_SOURCES =3D libtestengine.c
> +libtestengine_la_LDFLAGS =3D @TEST_LDFLAGS@ -rpath /lib -avoid-version -=
module -shared -export-dynamic
> +libtestengine_la_CFLAGS =3D @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat=
_srcdir)
> +
> diff --git a/tests/unit_tests/engine-key/check_engine_keys.sh b/tests/uni=
t_tests/engine-key/check_engine_keys.sh
> new file mode 100755
> index 00000000..e0c9d7b0
> --- /dev/null
> +++ b/tests/unit_tests/engine-key/check_engine_keys.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +OPENSSL_CONF=3D"${builddir}/openssl.cnf"
> +export OPENSSL_CONF
> +
> +password=3D'AT3S4PASSWD'
> +
> +key=3D"${builddir}/client.key"
> +pwdfile=3D"${builddir}/passwd"
> +
> +# create an engine key for us
> +sed 's/PRIVATE KEY/TEST ENGINE KEY/' < ${top_srcdir}/sample/sample-keys/=
client.key > ${key}
> +echo "$password" > $pwdfile
> +
> +# note here we've induced a mismatch in the client key and the server
> +# cert which openvpn should report and die.  Check that it does.  Note
> +# also that this mismatch depends on openssl not openvpn, so it is
> +# somewhat fragile
> +${top_builddir}/src/openvpn/openvpn --cd ${top_srcdir}/sample --config s=
ample-config-files/loopback-server --engine testengine --key ${key} --askpa=
ss $pwdfile > log.txt 2>&1
> +
> +# first off check we died because of a key mismatch.  If this doesn't
> +# pass, suspect openssl of returning different messages and update the
> +# test accordingly
> +grep -q 'X509_check_private_key:key values mismatch' log.txt || { echo "=
Key mismatch not detected"; exit 1; }
> +
> +# now look for the engine prints (these are under our control)
> +grep -q 'ENGINE: engine_init called' log.txt || { echo "Engine initializ=
ation not detected"; exit 1; }
> +grep -q 'ENGINE: engine_load_key called' log.txt || { echo "Key was not =
loaded from engine"; exit 1; }
> +grep -q "ENGINE: engine_load_key got password ${password}" log.txt || { =
echo "Key password was not retrieved by the engine"; exit 1; }
> +exit 0
> diff --git a/tests/unit_tests/engine-key/libtestengine.c b/tests/unit_tes=
ts/engine-key/libtestengine.c
> new file mode 100644
> index 00000000..46ec1e33
> --- /dev/null
> +++ b/tests/unit_tests/engine-key/libtestengine.c
> @@ -0,0 +1,101 @@
> +#include <string.h>
> +#include <openssl/engine.h>
> +#include <openssl/evp.h>
> +#include <openssl/pem.h>
> +
> +static char *engine_id =3D "testengine";
> +static char *engine_name =3D "Engine for testing openvpn engine key supp=
ort";
> +
> +static int is_initialized =3D 0;
> +
> +static int engine_init(ENGINE *e)
> +{
> +	is_initialized =3D 1;
> +	fprintf(stderr, "ENGINE: engine_init called\n");
> +	return 1;
> +}
> +
> +static int engine_finish(ENGINE *e)
> +{
> +	fprintf(stderr, "ENGINE: engine_finsh called\n");
> +	is_initialized =3D 0;
> +	return 1;
> +}
> +
> +static EVP_PKEY *engine_load_key(ENGINE *e, const char *key_id,
> +				 UI_METHOD *ui_method, void *cb_data)
> +{
> +	BIO *b;
> +	EVP_PKEY *pkey;
> +	PKCS8_PRIV_KEY_INFO *p8inf;
> +	UI *ui;
> +	char auth[256];
> +
> +	fprintf(stderr, "ENGINE: engine_load_key called\n");
> +
> +	if (!is_initialized) {
> +		fprintf(stderr, "Load Key called without correct initialization\n");
> +		return NULL;
> +	}
> +	b =3D BIO_new_file(key_id, "r");
> +	if (!b) {
> +		fprintf(stderr, "File %s does not exist or cannot be read\n", key_id);
> +		return 0;
> +	}
> +	/* Basically read an EVP_PKEY private key file with different
> +	 * PEM guards --- we are a test engine */
> +	p8inf =3D PEM_ASN1_read_bio((d2i_of_void *)d2i_PKCS8_PRIV_KEY_INFO,
> +				 "TEST ENGINE KEY", b,
> +				 NULL, NULL, NULL);
> +	BIO_free(b);
> +	if (!p8inf) {
> +		fprintf(stderr, "Failed to read engine private key\n");
> +		return NULL;
> +	}
> +	pkey =3D EVP_PKCS82PKEY(p8inf);
> +
> +	/* now we have a private key, pretend it had a password
> +	 * this verifies the password makes it through openvpn OK */
> +	ui =3D UI_new();
> +
> +	if (ui_method)
> +		UI_set_method(ui, ui_method);
> +
> +	UI_add_user_data(ui, cb_data);
> +
> +	if (UI_add_input_string(ui, "enter test engine key",
> +				UI_INPUT_FLAG_DEFAULT_PWD,
> +				auth, 0, sizeof(auth)) =3D=3D 0) {
> +		fprintf(stderr, "UI_add_input_string failed\n");
> +		goto out;
> +	}
> +
> +	if (UI_process(ui)) {
> +		fprintf(stderr, "UI_process failed\n");
> +		goto out;
> +	}
> +
> +	fprintf(stderr, "ENGINE: engine_load_key got password %s\n", auth);
> +
> + out:
> +	UI_free(ui);
> +
> +	return pkey;
> +}
> +
> +
> +static int engine_bind_fn(ENGINE *e, const char *id)
> +{
> +	if (id && strcmp(id, engine_id) !=3D 0)
> +		return 0;
> +	if (!ENGINE_set_id(e, engine_id) ||
> +	    !ENGINE_set_name(e, engine_name) ||
> +	    !ENGINE_set_init_function(e, engine_init) ||
> +	    !ENGINE_set_finish_function(e, engine_finish) ||
> +	    !ENGINE_set_load_privkey_function(e, engine_load_key))
> +		return 0;
> +	return 1;
> +}
> +
> +IMPLEMENT_DYNAMIC_CHECK_FN()
> +IMPLEMENT_DYNAMIC_BIND_FN(engine_bind_fn)
> diff --git a/tests/unit_tests/engine-key/openssl.cnf.in b/tests/unit_test=
s/engine-key/openssl.cnf.in
> new file mode 100644
> index 00000000..93edd483
> --- /dev/null
> +++ b/tests/unit_tests/engine-key/openssl.cnf.in
> @@ -0,0 +1,12 @@
> +HOME		=3D .
> +openssl_conf	=3D openssl_init
> +
> +[req]
> +[openssl_init]
> +engines		=3D engines_section
> +
> +[engines_section]
> +testengine	=3D testengine_section
> +
> +[testengine_section]
> +dynamic_path	=3D $ENV::srcdir/.libs/libtestengineSHREXT
>=20

Somehow this turns into a autoconf/automake nightmare:

[testengine_section]
dynamic_path	=3D $ENV::srcdir/.libs/libtestengine`test .odule =3D .yes
SHREXTSHREXT echo .so || echo .dylib`

is what I end up in the openssl.cnf

The generated Makefile already has:

$(builddir)/%.cnf: $(srcdir)/%.cnf.in
 	sed 's/SHREXT/`test .$module =3D .yes && echo .so || echo .dylib`/' < $<
> $@

Maybe instead of using that use magic useing two different section like
testengineso and testenginedylib and then makeing the engine name in the
script dynamic?

Also for some reason the makefile still builds it now as .so instead of
.dylib and if I manually put the  full path in the openssl.cnf the test
works:

dynamic_path	=3D
/Users/arne/oss/openvpn-ossl/tests/unit_tests/engine-key/.libs/libtestengin=
e.so

Any idea? I can also help to get this mess resolve but maybe you have a
quick idea what is wrong.

Arne


--u2SAckCFlrEwYyvhGkbBNMboazOMsR0pb--

--HdEhvvMIBqy7galuiwknCD3ItSKjR17RE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7aLSUACgkQFRhsZwKx
RFRlIBAAsoZv8Lb/eDM0gPDQYUG8uBtCvQt3qHOtIQ357vuZ1CPEI62Vc1YrkBdn
jvFhDB1WCyHDlUSkVHxw7dOIc7B9QXIfYW2JrfehS/809fX78tOTz2cY/o6xwaMU
qyoyoqTYj/EMmz6BGvPWHAFPPdZ4uCEkPqWM8bqC+C97xx/wkIOkrr4ZdosbqKYT
QgpbkuO04e3XWwIq8GU39++FUSOyI/eOI+1hDYKG/TqMZCPONpaM8tfTDL486cZf
X9Tk16N8H9h5k8ZV/0kAG7JITQ9Fau6IgpHaeTQf0OPLG0RGR/cyrh709+wsewpP
KIHUsyChaDSl1btHnvNTZYLP14elND3NhwMFAP4/urj2FVVpast6rCYlK1GOi8fB
VpWxK5I1VYfJRkDBIsbVKxYo6qixAft1JaFNj82LK7/Em+gXaHXWD2wKlK5fBinm
cHK42LTP2T2v/WxuyEFNmwOnaY2p0uqcLJGc1hyDA1Bgri3yniPMHAll0II9m8Ia
5NtL8d5z6dkgWEOQKStxvrn0FhONi92VI5BU7Iu/glKcvW9wiZZKoCwBMQNNFKK9
UiIoSwU9loMC5Q3R3XjWVmVo3aj6MI/GT/hXqEwpiYWiKlc9t5PX1XB5EQMK1hYZ
QyTJ2+xpK3PCLAbX9K7JGnnOEpz0sVQnbxOdaB5OsF9wnVvkz9M=
=rYDX
-----END PGP SIGNATURE-----

--HdEhvvMIBqy7galuiwknCD3ItSKjR17RE--

