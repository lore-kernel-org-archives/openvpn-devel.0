From: Jeremie Courreges-Anglas <jca@...2272...>
References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
 <20171119213837.GA80839@...1296...>
 <8760a6kjwc.fsf@...2274...>
 <87vai5kj4z.fsf@...2274...>
 <551aeb2a-1ea1-9c3b-06dd-ead9fc809340@...1856...>
Date: Sun, 04 Mar 2018 19:59:42 +0100
In-Reply-To: <551aeb2a-1ea1-9c3b-06dd-ead9fc809340@...1856...> (Steffan
 Karger's message of "Thu, 14 Dec 2017 09:21:26 +0100")
Message-ID: <87muzn650h.fsf@...2274...>
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14 2017, Steffan Karger <steffan@...1856...> wrote:

[...]

> NAK.
>
> Looking at this patch again I realize I have misunderstood the
> intentions when first looking at it.  I thought LibreSSL *did* have an
> SSL_CTX_get0_certificate() and this patch would make us use it (instead
> of the workaround in the #else).  But this is just about replacing the
> version check with a configure check.

Are you still opposed to such a diff (updated version attached), now
that LibreSSL HEAD provides SSL_CTX_get0_certificate?

> I oppose that change because it
> hides information I want to have:  "what code can be purged when we drop
> support for openssl 1.0 and libressl?".

Maybe there's another way to encode that information?  Like,
consistently formatted comments describing the first OpenSSL (and
LibreSSL) releases that provided a function?

--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-Detect-availability-of-SSL_CTX_get0_certificate.patch
Content-Transfer-Encoding: quoted-printable

From=20e6d80207bf7f1323670d0bc1102fa51309b1aa14 Mon Sep 17 00:00:00 2001
From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Sun, 4 Mar 2018 19:24:36 +0100
Subject: [PATCH] Detect availability of SSL_CTX_get0_certificate

instead of relying on simpler version checks.  This allows using
SSL_CTX_get0_certificate with LibreSSL.
=2D--
 configure.ac              | 1 +
 src/openvpn/ssl_openssl.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 626b4dd4..e4525b09 100644
=2D-- a/configure.ac
+++ b/configure.ac
@@ -918,6 +918,7 @@ if test "${with_crypto_library}" =3D "openssl"; then
 			EVP_MD_CTX_new \
 			EVP_MD_CTX_free \
 			EVP_MD_CTX_reset \
+			SSL_CTX_get0_certificate \
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
 			SSL_CTX_set_security_level \
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8ef68ebd..19580312 100644
=2D-- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -459,8 +459,8 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
=20
     ASSERT(ctx);
=20
=2D#if OPENSSL_VERSION_NUMBER >=3D 0x10002000L && !defined(LIBRESSL_VERSION=
_NUMBER)
=2D    /* OpenSSL 1.0.2 and up */
+#ifdef HAVE_SSL_CTX_GET0_CERTIFICATE
+    /* OpenSSL 1.0.2 and up, LibreSSL 2.7.0 and up */
     cert =3D SSL_CTX_get0_certificate(ctx->ctx);
 #else
     /* OpenSSL 1.0.1 and earlier need an SSL object to get at the certific=
ate */
@@ -494,7 +494,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
     }
=20
 cleanup:
=2D#if OPENSSL_VERSION_NUMBER < 0x10002000L || defined(LIBRESSL_VERSION_NUM=
BER)
+#ifndef HAVE_SSL_CTX_GET0_CERTIFICATE
     SSL_free(ssl);
 #endif
     return;
=2D-=20
2.16.0


--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlqcQh4ACgkQDfp0rhUk
5+6hqA/9FwBqiwcr2FxIUSDs/TuI+kjq+Hu1H9b87RyIhQPeVVcie35vy7eOFTcE
XoOUQ3S/j11ZKjrTdBYqF66Nh7IK+8oI3ZnNO5SplSwHH9Tfhpss0av8G8FxI60T
JaOsS8+SLR3qnLdwOQpqLcRv2KS7QzD94P6hSi0USS/Fc2v9YZDE8yGEnJY3keYa
jogpFPgCY6lBmgbjpUHaWwS8u9NrxBOUVcgR2GkzyrdMp14ucFkWnXb63/P0pUhu
l2C2Dss1kVgM3eDI2YLyxSeH9j2ViM1pTJOSgHq1YWjLzayxkFyaL2mqofxaN8AE
Ls0C9Vu+IkZwyvktNP5Sm4wZwcmhwG+sUyWKceR91E0g3UoXo06/Gs43hnmWBMsc
250eYrj32esfvR4bJZAlC00TZ+ZosD5BsPFoCd2pum6obYBU7G3/Qeg0pJ1/B+yr
5D0QnE5aSTMW2HcX/dgDIrjAWE9GPYwDgkqInbuIvv64gCs7RYNuFBk26k8xMSk4
Bo5YDVS4LbjU+763QxtWshzaH+KtYJB+7EM3fXtAOQN4wzfHNXIHBzCeJis9+39+
TszjW1OacakR0hBQ62KwOrCSaCMDxBacsPvrdgJN8aayJLQOIT/K7Oft5qqevqGs
D4VfGxLDHIfqhIZxOOKBOrXwysyu+pLwcbMcGwvJz9OzAYlt6JE=
=Dl23
-----END PGP SIGNATURE-----
--==-=-=--

