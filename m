References: <1518302884.3072.1.camel@...2316...>
 <1518303011.3072.4.camel@...2316...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <778643d1-7f14-a31b-949a-8aab94473e64@...1227...>
Date: Thu, 13 Feb 2020 19:18:26 +0100
MIME-Version: 1.0
In-Reply-To: <1518303011.3072.4.camel@...2316...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QG6O477onIrtD5zfBQghfWqWEOQPANFVb"
Subject: Re: [Openvpn-devel] [PATCH v4 2/2] Add unit tests for engine keys
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
--QG6O477onIrtD5zfBQghfWqWEOQPANFVb
Content-Type: multipart/mixed; boundary="rPJNCZJFrLqP6mFgLKsPaBWc95sj8Kws2"

--rPJNCZJFrLqP6mFgLKsPaBWc95sj8Kws2
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.02.18 um 23:50 schrieb James Bottomley:
> Testing engines is problematic, so one of the prerequisites built for
> the tests is a simple openssl engine that reads a non-standard PEM
> guarded key.  The test is simply can we run a client/server
> configuration with the usual sample key replaced by an engine key.
> The trivial engine prints out some operations and we check for these
> in the log to make sure the engine was used to load the key and that
> it correctly got the password.

This tests the openssl engine functionality in a sensible way. But I
think it is not fully ready to be commited. To get it working I needed
to do following changes on my Mac:

commit afa697cec15b4e54e720efe9de39c9b20b13c5c8 (HEAD -> review/enginekeys)
Author: Arne Schwabe <arne@...1227...>
Date:   Thu Feb 13 18:13:34 2020 +0100

    foo

diff --git a/tests/unit_tests/engine-key/Makefile.am
b/tests/unit_tests/engine-key/Makefile.am
index 73921965..6d7fc9c5 100644
--- a/tests/unit_tests/engine-key/Makefile.am
+++ b/tests/unit_tests/engine-key/Makefile.am
@@ -10,4 +10,6 @@ TESTS_ENVIRONMENT =3D srcdir=3D"$(abs_srcdir)"; \
 TESTS =3D check_engine_keys.sh

 libtestengine_la_SOURCES =3D libtestengine.c
-libtestengine_la_LDFLAGS =3D -rpath /lib -avoid-version
+libtestengine_la_LDFLAGS =3D @TEST_LDFLAGS@  -rpath /lib
+libtestengine_la_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir)
-I$(compat_srcdir)
+
diff --git a/tests/unit_tests/engine-key/libtestengine.c
b/tests/unit_tests/engine-key/libtestengine.c
index fa7f5de1..46ec1e33 100644
--- a/tests/unit_tests/engine-key/libtestengine.c
+++ b/tests/unit_tests/engine-key/libtestengine.c
@@ -30,7 +30,6 @@ static EVP_PKEY *engine_load_key(ENGINE *e, const char
*key_id,
        PKCS8_PRIV_KEY_INFO *p8inf;
        UI *ui;
        char auth[256];
-       int len;

        fprintf(stderr, "ENGINE: engine_load_key called\n");

diff --git a/tests/unit_tests/engine-key/openssl.cnf
b/tests/unit_tests/engine-key/openssl.cnf
index 53200c46..e9513a92 100644
--- a/tests/unit_tests/engine-key/openssl.cnf
+++ b/tests/unit_tests/engine-key/openssl.cnf
@@ -9,4 +9,4 @@ engines         =3D engines_section
 testengine     =3D testengine_section

 [testengine_section]
-dynamic_path   =3D $ENV::srcdir/.libs/libtestengine.so
+dynamic_path   =3D $ENV::srcdir/.libs/libtestengine.dylib



--rPJNCZJFrLqP6mFgLKsPaBWc95sj8Kws2--

--QG6O477onIrtD5zfBQghfWqWEOQPANFVb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5FkvIACgkQFRhsZwKx
RFTG0hAAsvYIovJNiqNbicyqzYRf4jy0QfwHIkwJt9A+TKd7etggQLednokZdq8E
Zwj26UROpk+pbfSifWug9qNUcJuGYW6nH4Ji4rzELkJdbqGUwXHaofYHAnpdavjI
p3BeCGF0Mm44g1uWYaKPwDdB3+u4z+eZhTrlnPs+IlSC9LNorVazFIqMyT4tuWGI
iTqiZ1p6JIERrFjgo/FQFT2GlxtoYc+QtSCrjcqVESZmI4+DgPO1vKULa29MhCJk
4lns05eJB+SdD9r4sBCh4P9+y6YhlOPeD1SVHb6F1AIDcbZjYFMEqWMTSoBX+2bM
DfWMIUvMBjY4quDAtqgCG57/Hk5crS9um6cMt5Bc7unTkQxj1pQWOeiBMkc5nUPW
dlRfHkmzqHYOW9v0RO8eCco8gaQRBHoxIcWPX1wJMeDJkicAWw/9fMQ7DnIVVB81
VzdN5B7as7mRfRVYTnKTJwKgPMcLEF+zyMhndmvyGoIAIvCm4T2+0+UJbneYeE6m
J5py91W7MB6erQ5+xiJS93SlMRlUHmRchGpwfUjFA5EQHzP5czpMbL244fz+Q1a8
ThTgJgqwcoD0Mo97Xb5mxVoxvvUzsfhmD4cu6Wbel1TmhAu0SYW1P4xZwktCrCTO
TP5l4KywczjhU+xcku5u87JA5ZFFdZHsTH9t+WtAC+9OF123q0M=
=qWG7
-----END PGP SIGNATURE-----

--QG6O477onIrtD5zfBQghfWqWEOQPANFVb--

