Date: Sat, 26 Dec 2015 10:19:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151226091900.GU24952@...1296...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
	<567AB995.70204@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eEr8UG3A/ICzP5bu"
Content-Disposition: inline
In-Reply-To: <567AB995.70204@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
 expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eEr8UG3A/ICzP5bu
Content-Type: multipart/mixed; boundary="CkhAErW6G7GaSd4D"
Content-Disposition: inline

--CkhAErW6G7GaSd4D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 23, 2015 at 04:11:17PM +0100, Jan Just Keijser wrote:
> I justed wanted to get back to this one one more time: attached is a=20
> patch to ssl_openssl.c that works in combination with Steffan's patch to=
=20
> check for expired certificates. This new patch-patch works on my CentOS=20
> 6 (openssl 1.0.1e) box :)  This patch was done against the v2.3.9 code=20
> base and I have no clue how to get it into proper git formatting ;)

Great discovery :-) - and it nicely works for me:

Sat Dec 26 10:11:14 2015 OpenVPN 2.3_git [git:ssl-expire/0f7319906a9dff58+]=
 amd64-unknown-freebsd7.4 [SSL (OpenSSL)] [LZO] [LZ4] [MH] [IPv6] built on =
Dec 26 2015
Sat Dec 26 10:11:14 2015 library versions: OpenSSL 0.9.8q 2 Dec 2010, LZO 2=
.04
Sat Dec 26 10:11:16 2015 WARNING: Your certificate has expired!

this is about as old as it gets - thanks a lot.  Mogrified into a patch
against git master with the SSL_free() moved to the right place attached
below, for Steffan to ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CkhAErW6G7GaSd4D
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Make-certificate-expiry-warning-patch-091edd8e299686.patch"
Content-Transfer-Encoding: quoted-printable

=46rom cc94bfe47840f3b4815e3ab1f0b65267d992bd08 Mon Sep 17 00:00:00 2001
=46rom: Jan Just Keijser <janjust@...1147...>
Date: Sat, 26 Dec 2015 10:15:04 +0100
Subject: [PATCH] Make certificate expiry warning patch (091edd8e299686) wor=
k on OpenSSL 1.0.1 and earlier.

Integrating feedback from Steffan Karger, tested by Gert Doering on
FreeBSD 7.4 / OpenSSL 0.9.8.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl_openssl.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 4792b08..0a7f14b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -353,9 +353,17 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, con=
st char *ciphers)
 void
 tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
 {
-#if OPENSSL_VERSION_NUMBER >=3D 0x10002000L
   int ret;
-  const X509 *cert =3D SSL_CTX_get0_certificate(ctx->ctx);
+  const X509 *cert;
+
+#if OPENSSL_VERSION_NUMBER >=3D 0x10002000L
+  /* OpenSSL 1.0.2 and up */
+  cert =3D SSL_CTX_get0_certificate(ctx->ctx);
+#else
+  /* OpenSSL 1.0.1 and earlier need an SSL object to get at the certificat=
e */
+  SSL *ssl =3D SSL_new(ctx->ctx);
+  cert =3D SSL_get_certificate(ssl);
+#endif
=20
   ret =3D X509_cmp_time (X509_get_notBefore (cert), NULL);
   if (ret =3D=3D 0)
@@ -376,6 +384,8 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
     {
       msg (M_WARN, "WARNING: Your certificate has expired!");
     }
+#if OPENSSL_VERSION_NUMBER < 0x10002000L
+  SSL_free(ssl);
 #endif
 }
=20
--=20
1.7.3.5


--CkhAErW6G7GaSd4D--

--eEr8UG3A/ICzP5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVn5bg6kuBuNlUUl1AQLkagP/ePXzdi2dAczcJ67vSsmoAN1uHaOg8iED
RxlgK+lzOfLeex2Aw8IsZxwTKFpQiGHQnNwosiyA2qZve84hb8mYFg/6F4XB9VrO
LXWly2VQSlOs6ffjpRncSDZKwm/yRl5QkbqX7wAPIPR0EId2wvdxwU/9JlP5aTpf
20WL0LpVpzw=
=DJ2C
-----END PGP SIGNATURE-----

--eEr8UG3A/ICzP5bu--

