Date: Sun, 27 Apr 2014 19:53:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140427175312.GJ16637@...1296...>
References: <1398064204-26476-1-git-send-email-james@...515...>
	<1398064204-26476-4-git-send-email-james@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zjuIARBJda4xDNxl"
Content-Disposition: inline
In-Reply-To: <1398064204-26476-4-git-send-email-james@...515...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] When tls-version-min is unspecified,
	revert to original versioning approach.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--zjuIARBJda4xDNxl
Content-Type: multipart/mixed; boundary="v/tXFPUBDfIG5bcU"
Content-Disposition: inline

--v/tXFPUBDfIG5bcU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 21, 2014 at 01:10:04AM -0600, James Yonan wrote:
> For OpenSSL, this means to use TLSv1_(client|server)_method rather
> than SSLv23_(client|server)_method combined with SSL_OP_NO_x flags
> for specific TLS versions to disable.
>=20
> For PolarSSL, this means to avoid calling ssl_set_min_version and
> instead implicitly control the TLS version via allowed ciphersuites.

As per the discussion on IRC, I've adapted the patch to 2.3 only (some
small incompatibilities in ssl_polarssl.c), and added a section in the
openvpn.8 man page.

I have tested OpenSSL and PolarSSL builds, talking to a git master server.

With OpenSSL:

  no --tls-version-min in config --> TLSv1 is used
  --tls-version-min 1.0 or 1.2   --> TLSv1.2 is used

(clearly visible in both server and client logs)

With PolarSSL, I always get TLSv1.2, and can't really see whether or not
it makes a difference.  But given James' comments, this seems to be=20
expected (I didn't play with --tls-cipher settings).

The attached patch is what I intend to commit to release/2.3 *only*, not
to master - as agreed at the IRC meeting.  "Please ACK" :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v/tXFPUBDfIG5bcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-When-tls-version-min-is-unspecified-revert-to-origin.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 986a3382de536a3ca530429f985f9989783d5996 Mon Sep 17 00:00:00 2001
From: James Yonan <james@...515...>
Date: Mon, 21 Apr 2014 01:10:04 -0600
Subject: [PATCH] When tls-version-min is unspecified, revert to original
 versioning approach.

For OpenSSL, this means to use TLSv1_(client|server)_method rather
than SSLv23_(client|server)_method combined with SSL_OP_NO_x flags
for specific TLS versions to disable.

For PolarSSL, this means to avoid calling ssl_set_min_version and
instead implicitly control the TLS version via allowed ciphersuites.

Point out off-by-default-now setting in the openvpn(8) man page.

This patch is only included in the release/2.3 branch, because it's a
stopgap measure.  2.4 will have it on-by-default, when the remaining
handshake problems are fully debugged and solved.

Signed-off-by: James Yonan <james@...515...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8              |  8 +++++++-
 src/openvpn/ssl.c          |  4 ++--
 src/openvpn/ssl_backend.h  | 15 +++++++++------
 src/openvpn/ssl_openssl.c  | 33 +++++++++++++++++++++++----------
 src/openvpn/ssl_polarssl.c | 41 ++++++++++++++++++++++-------------------
 5 files changed, 63 insertions(+), 38 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7a33f8a..10ec1f5 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4275,12 +4275,18 @@ above).
 .\"*********************************************************
 .TP
 .B \-\-tls-version-min version ['or-highest']
-Sets the minimum
+Enable TLS version negotiation, and set the minimum
 TLS version we will accept from the peer (default is "1.0").
 Examples for version
 include "1.0", "1.1", or "1.2".  If 'or-highest' is specified
 and version is not recognized, we will only accept the highest TLS
 version supported by the local SSL implementation.
+
+If this options is not set, the code in OpenVPN 2.3.4 will default
+to using TLS 1.0 only, without any version negotiation.  This reverts
+the beaviour to what OpenVPN versions up to 2.3.2 did, as it turned=20
+out that TLS version negotiation can lead to handshake problems due
+to new signature algorithms in TLS 1.2.
 .\"*********************************************************
 .TP
 .B \-\-pkcs12 file
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 93d81e2..ac6818e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -486,12 +486,12 @@ init_ssl (const struct options *options, struct tls_r=
oot_ctx *new_ctx)
=20
   if (options->tls_server)
     {
-      tls_ctx_server_new(new_ctx);
+      tls_ctx_server_new(new_ctx, options->ssl_flags);
       tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_i=
nline);
     }
   else				/* if client */
     {
-      tls_ctx_client_new(new_ctx);
+      tls_ctx_client_new(new_ctx, options->ssl_flags);
     }
=20
   tls_ctx_set_options(new_ctx, options->ssl_flags);
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 9777242..b37b1e5 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -109,10 +109,11 @@ void tls_clear_error();
  * @return 		One of the TLS_VER_x constants or TLS_VER_BAD
  *                      if a parse error should be flagged.
  */
-#define TLS_VER_BAD   -1
-#define TLS_VER_1_0    0 /* default */
-#define TLS_VER_1_1    1
-#define TLS_VER_1_2    2
+#define TLS_VER_BAD    -1
+#define TLS_VER_UNSPEC  0 /* default */
+#define TLS_VER_1_0     1
+#define TLS_VER_1_1     2
+#define TLS_VER_1_2     3
 int tls_version_min_parse(const char *vstr, const char *extra);
=20
 /**
@@ -127,15 +128,17 @@ int tls_version_max(void);
  * Initialise a library-specific TLS context for a server.
  *
  * @param ctx		TLS context to initialise
+ * @param ssl_flags     SSLF_x flags from ssl_common.h
  */
-void tls_ctx_server_new(struct tls_root_ctx *ctx);
+void tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags);
=20
 /**
  * Initialises a library-specific TLS context for a client.
  *
  * @param ctx		TLS context to initialise
+ * @param ssl_flags     SSLF_x flags from ssl_common.h
  */
-void tls_ctx_client_new(struct tls_root_ctx *ctx);
+void tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags);
=20
 /**
  * Frees the library-specific TLSv1 context
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 08e3592..0bc403d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -119,11 +119,16 @@ tmp_rsa_cb (SSL * s, int is_export, int keylength)
 }
=20
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
+  const int tls_version_min =3D (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SS=
LF_TLS_VERSION_MASK;
+
   ASSERT(NULL !=3D ctx);
=20
-  ctx->ctx =3D SSL_CTX_new (SSLv23_server_method ());
+  if (tls_version_min > TLS_VER_UNSPEC)
+    ctx->ctx =3D SSL_CTX_new (SSLv23_server_method ());
+  else
+    ctx->ctx =3D SSL_CTX_new (TLSv1_server_method ());
=20
   if (ctx->ctx =3D=3D NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
@@ -132,11 +137,16 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 }
=20
 void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
+tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
+  const int tls_version_min =3D (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SS=
LF_TLS_VERSION_MASK;
+
   ASSERT(NULL !=3D ctx);
=20
-  ctx->ctx =3D SSL_CTX_new (SSLv23_client_method ());
+  if (tls_version_min > TLS_VER_UNSPEC)
+    ctx->ctx =3D SSL_CTX_new (SSLv23_client_method ());
+  else
+    ctx->ctx =3D SSL_CTX_new (TLSv1_client_method ());
=20
   if (ctx->ctx =3D=3D NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
@@ -209,16 +219,19 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsign=
ed int ssl_flags)
   {
     long sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET | SSL_OP_NO_SS=
Lv2 | SSL_OP_NO_SSLv3;
     const int tls_version_min =3D (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & =
SSLF_TLS_VERSION_MASK;
-    if (tls_version_min > TLS_VER_1_0)
-      sslopt |=3D SSL_OP_NO_TLSv1;
+    if (tls_version_min > TLS_VER_UNSPEC)
+      {
+	if (tls_version_min > TLS_VER_1_0)
+	  sslopt |=3D SSL_OP_NO_TLSv1;
 #ifdef SSL_OP_NO_TLSv1_1
-    if (tls_version_min > TLS_VER_1_1)
-      sslopt |=3D SSL_OP_NO_TLSv1_1;
+	if (tls_version_min > TLS_VER_1_1)
+	  sslopt |=3D SSL_OP_NO_TLSv1_1;
 #endif
 #ifdef SSL_OP_NO_TLSv1_2
-    if (tls_version_min > TLS_VER_1_2)
-      sslopt |=3D SSL_OP_NO_TLSv1_2;
+	if (tls_version_min > TLS_VER_1_2)
+	  sslopt |=3D SSL_OP_NO_TLSv1_2;
 #endif
+      }
     SSL_CTX_set_options (ctx->ctx, sslopt);
   }
=20
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 6334783..f4712c2 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -67,7 +67,7 @@ tls_clear_error()
 }
=20
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
   ASSERT(NULL !=3D ctx);
   CLEAR(*ctx);
@@ -84,7 +84,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 }
=20
 void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
+tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
   ASSERT(NULL !=3D ctx);
   CLEAR(*ctx);
@@ -707,29 +707,32 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       /* Initialize minimum TLS version */
       {
 	const int tls_version_min =3D (session->opt->ssl_flags >> SSLF_TLS_VERSIO=
N_SHIFT) & SSLF_TLS_VERSION_MASK;
-	int polar_major;
-	int polar_minor;
-	switch (tls_version_min)
+	if (tls_version_min > TLS_VER_UNSPEC)
 	  {
-	  case TLS_VER_1_0:
-	  default:
-	    polar_major =3D SSL_MAJOR_VERSION_3;
-	    polar_minor =3D SSL_MINOR_VERSION_1;
-	    break;
+	    int polar_major;
+	    int polar_minor;
+	    switch (tls_version_min)
+	      {
+	      case TLS_VER_1_0:
+	      default:
+		polar_major =3D SSL_MAJOR_VERSION_3;
+		polar_minor =3D SSL_MINOR_VERSION_1;
+		break;
 #if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
-	  case TLS_VER_1_1:
-	    polar_major =3D SSL_MAJOR_VERSION_3;
-	    polar_minor =3D SSL_MINOR_VERSION_2;
-	    break;
+	      case TLS_VER_1_1:
+		polar_major =3D SSL_MAJOR_VERSION_3;
+		polar_minor =3D SSL_MINOR_VERSION_2;
+		break;
 #endif
 #if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
-	  case TLS_VER_1_2:
-	    polar_major =3D SSL_MAJOR_VERSION_3;
-	    polar_minor =3D SSL_MINOR_VERSION_3;
-	    break;
+	      case TLS_VER_1_2:
+		polar_major =3D SSL_MAJOR_VERSION_3;
+		polar_minor =3D SSL_MINOR_VERSION_3;
+		break;
 #endif
+	      }
+	    ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
 	  }
-	ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
       }
=20
       /* Initialise BIOs */
--=20
1.8.3.2


--v/tXFPUBDfIG5bcU--

--zjuIARBJda4xDNxl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU11ECKkuBuNlUUl1AQJc2wP9FPnj8kNy++l4IFyqnwyArokDEBIOHPsF
Xq7ZBmGDxgRQT8eO8mLpvYa8ExyYt0jGMic5Kom+yT5rddTFvPtGFGZcCPAHJkrR
MQ8qFXdtv0er753rWYwFn1JYQ99pffu0SXrfyZlCMHxZ/VnxwCF8ACIMZlIxFl6Q
HU00xEP0MOU=
=0WDf
-----END PGP SIGNATURE-----

--zjuIARBJda4xDNxl--

