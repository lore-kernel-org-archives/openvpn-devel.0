From: Jeremie Courreges-Anglas <jca@...2272...>
References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
 <20171119213837.GA80839@...1296...>
Date: Sun, 19 Nov 2017 23:01:39 +0100
In-Reply-To: <20171119213837.GA80839@...1296...> (Gert Doering's message
 of "Sun, 19 Nov 2017 22:38:37 +0100")
Message-ID: <8760a6kjwc.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile
 option for mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19 2017, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, Nov 19, 2017 at 09:37:56PM +0100, Gert Doering wrote:
>> .. of course this conflicts with o->renegotiate_seconds_min...
>>=20
>> Nevertheless, thanks for the patch :-) - it makes my FreeBSD 10.3=20
>> (mbedTLS 2.6) buildslave now happy again (on the default settings - with
>> --tls-cert-profile preferred, it refuses the old-hash cert, as it should=
).
>>=20
>> Also tested with openssl 1.0.1, where it warns and does nothing, as
>> expected.  Good :-)
>
> I *should* have tested with LibreSSL as well...
>
> ssl_openssl.o: In function `tls_ctx_set_cert_profile':
> /home/buildbot/build-openvpn/build-cron2-openbsd-60-amd64-stable-master--=
disable -lzo--disable-management/build/src/openvpn/ssl_openssl.c:404:
> undefined reference to `SSL_CTX_set_security_level'
> /home/buildbot/build-openvpn/build-cron2-openbsd-60-amd64-stable-master--=
disable-lzo--disable-management/build/src/openvpn/ssl_openssl.c:400: undefi=
ned reference to `SSL_CTX_set_security_level'
>
> ... *roll eyes*
>
> (Not sure, though, why it only complains about two out of three, but
> still annoyance...  if LibreSSL claims OPENSSL_VERSION_NUMBER >=3D 0x1010=
0000
> it better should provide everything needed)

LibreSSL defines:

  #define OPENSSL_VERSION_NUMBER        0x20000000L

breaking #ifdef checks based on it.  Sadly, people tend to prefer adding

  && !defined(LIBRESSL_VERSION_NUMBER)

to fix the build, rather than doing features detection using autoconf or
similar.  openvpn can easily solve this.

> This is on OpenBSD 6.0, which happens to be something Samuli's vagrant
> setup can provide nicely if anyone wants to have a look :-)

Here's a diff, master builds and seems to run fine as a client on
OpenBSD-current.

I can cook a similar diff for the remaining OPENSSL /
LIBRESSL_VERSION_NUMBER #ifdef.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=0001-Fix-build-with-LibreSSL.patch
Content-Transfer-Encoding: quoted-printable

From=2015315d3c3b25814a426bfc8184c4dfd262f28768 Mon Sep 17 00:00:00 2001
From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Sun, 19 Nov 2017 22:57:56 +0100
Subject: [PATCH] Fix build with LibreSSL

Detect the presence of SSL_CTX_set_security_level(), don't check
OPENSSL_VERSION_NUMBER.

Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
=2D--
 configure.ac              | 1 +
 src/openvpn/ssl_openssl.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 7f2e34f2..acfddb22 100644
=2D-- a/configure.ac
+++ b/configure.ac
@@ -927,6 +927,7 @@ if test "${enable_crypto}" =3D "yes" -a "${with_crypto_=
library}" =3D "openssl"; then
 			EVP_MD_CTX_reset \
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
+			SSL_CTX_set_security_level \
 			X509_get0_pubkey \
 			X509_STORE_get0_objects \
 			X509_OBJECT_free \
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index de89cb13..b782946e 100644
=2D-- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -386,7 +386,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, cons=
t char *ciphers)
 void
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 {
=2D#if (OPENSSL_VERSION_NUMBER >=3D 0x10100000)
+#ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL
     /* OpenSSL does not have certificate profiles, but a complex set of
      * callbacks that we could try to implement to achieve something simil=
ar.
      * For now, use OpenSSL's security levels to achieve similar (but not =
equal)
=2D-=20
2.15.0


--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAloR/0MACgkQDfp0rhUk
5+6LwQ//X0e7d01Qv7OFEPKXhVSH8F1k06n/RO6C30R9+/iD/QSfPO6RBS0jCBqj
odevLc1pskICJDVtRSTsO9NO2N6/jSS2fHkEpwk6RbMXIniRtoEqTPpBeSLJIjLo
MI1v42Nj491MN8Ox0IFVTe33w0oz+e5F1cv9qg92PA07tQ32pSOxS4zQB9YsU38Z
DLSES8G2aOgZAQabfnX0OALHUTyixSVIS6SSGJKj8oQx0xTag0P0lJQJcHCxcrcM
fTfafl89hwR8BDPRm1KeD5K+A1AGeYxQJ/zkx/u1RucMTMxnjMMkMQFNc9aP0D6O
C2PQGozG7ZwP67GmSWEMQemuCmYpY/okQQ1xZWuLgcbdJeeI321R6RFHJ4hbfpFQ
fNWinZtN2D8nnSW1kchLtm8DO6NJ+yKl1JjxLqAgfDXRYBWm0kjsRyxYpZyuWTc+
Q8sS3nuujQBWThXPemfHMvwtQtixXu3sSbjl+XitqUlawGqvupEjBr/rmzDnFLdm
2pMSoXudw37WhN+CseB6xpC1t06i+osPW4VjGSgbgxJ1J/4bYAyQB5cZg0XFZmZA
gZi3aziIrI2B83KqEyMXHavp6KfGOtN5CbZk4xXG13BEahN1/rgVsm3XoiVAxleV
r6dnM8hkwp4+pWL/0zy/8MM3jByflXFTAW55B+A5h+18vR6sVcA=
=DhtR
-----END PGP SIGNATURE-----
--==-=-=--

