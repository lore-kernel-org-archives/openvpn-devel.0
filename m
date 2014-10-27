Message-ID: <544EC052.3080809@...1435...>
Date: Mon, 27 Oct 2014 22:59:46 +0100
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080301040806070808070100"
Subject: [Openvpn-devel] [PATCH] Add --tls-version-max option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--------------080301040806070808070100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

Since I had to miss the most recent IRC meeting, I'll just put this on
the mailinglist.

OpenVPN has used TLSv1.0 exclusively for a long time. A few months ago,
TLS version negotiation was added for OpenSSL builds (PolarSSL builds
already had version negotiation), but that triggered quite some problems
at our users. For example, our cryptoapi implementation doesn't support
TLSv1.2 and some external PKCS#11 libraries and tokens refuse to create
TLSv1.2 signatures (which we can't fix ourselves).

To ease the transition, while we and external vendors fix the various
problems, I propose to add an option '--tls-version-max', similar to the
current '--tls-version-min'. That will enable users to e.g. use TLSv1.1
on the clients that won't work with 1.2. At least for one of the
problematic setups I encountered, this was a nice way out.

Attached are two patches that do just that for the 2.3 and master branches.

Of course this should not stop us from fixing problems with TLSv1.2 (at
least the problems we actually can fix...).

Regards,
-Steffan

--------------080301040806070808070100
Content-Type: text/x-patch; name="2.3-Add-tls-version-max.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.3-Add-tls-version-max.patch"

From 281776265d21d989391a5354018bf4d3ec74e46f Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 5 Sep 2014 12:38:04 +0200
Subject: [PATCH] Add --tls-version-max

Because using TLS 1.2 breaks certain setups, a user might want to enforce
a maximum TLS version to use. This patch adds that option.

This patch removes a number of #ifdefs from ssl_polarssl.c, because the
polarssl versions we currently support (polar 1.2 for openvpn 2.3, and
polar 1.3 for openvpn-master) have all versions unconditionally enabled.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/openvpn.8              |  5 +++
 src/openvpn/options.c      | 22 +++++++++++--
 src/openvpn/ssl.c          |  2 +-
 src/openvpn/ssl_backend.h  |  2 +-
 src/openvpn/ssl_common.h   |  6 ++--
 src/openvpn/ssl_openssl.c  | 21 ++++++++----
 src/openvpn/ssl_polarssl.c | 80 +++++++++++++++++++++++++++++++++-------------
 7 files changed, 103 insertions(+), 35 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e4b0bc1..7f6bcdd 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4317,6 +4317,11 @@ out that TLS version negotiation can lead to handshake problems due
 to new signature algorithms in TLS 1.2.
 .\"*********************************************************
 .TP
+.B \-\-tls-version-max version
+Set the maximum TLS version we will use (default is the highest version
+supported).  Examples for version include "1.0", "1.1", or "1.2".
+.\"*********************************************************
+.TP
 .B \-\-pkcs12 file
 Specify a PKCS #12 file containing local private key,
 local certificate, and root CA certificate.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9980daf..0f1959d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -574,6 +574,7 @@ static const char usage_message[] =
   "--tls-version-min <version> ['or-highest'] : sets the minimum TLS version we\n"
   "    will accept from the peer.  If version is unrecognized and 'or-highest'\n"
   "    is specified, require max TLS version supported by SSL implementation.\n"
+  "--tls-version-max <version> : sets the maximum TLS version we will use.\n"
 #ifndef ENABLE_CRYPTO_POLARSSL
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
@@ -6577,14 +6578,29 @@ add_option (struct options *options,
     {
       int ver;
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      ver = tls_version_min_parse(p[1], p[2]);
+      ver = tls_version_parse(p[1], p[2]);
       if (ver == TLS_VER_BAD)
 	{
 	  msg (msglevel, "unknown tls-version-min parameter: %s", p[1]);
           goto err;
 	}
-      options->ssl_flags &= ~(SSLF_TLS_VERSION_MASK << SSLF_TLS_VERSION_SHIFT);
-      options->ssl_flags |= (ver << SSLF_TLS_VERSION_SHIFT);
+      options->ssl_flags &=
+	  ~(SSLF_TLS_VERSION_MIN_MASK << SSLF_TLS_VERSION_MIN_SHIFT);
+      options->ssl_flags |= (ver << SSLF_TLS_VERSION_MIN_SHIFT);
+    }
+  else if (streq (p[0], "tls-version-max") && p[1])
+    {
+      int ver;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      ver = tls_version_parse(p[1], NULL);
+      if (ver == TLS_VER_BAD)
+	{
+	  msg (msglevel, "unknown tls-version-max parameter: %s", p[1]);
+          goto err;
+	}
+      options->ssl_flags &=
+	  ~(SSLF_TLS_VERSION_MAX_MASK << SSLF_TLS_VERSION_MAX_SHIFT);
+      options->ssl_flags |= (ver << SSLF_TLS_VERSION_MAX_SHIFT);
     }
 #ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "pkcs12") && p[1])
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ace3d86..cde2d0d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -459,7 +459,7 @@ ssl_put_auth_challenge (const char *cr_str)
  * return tls_version_max().
  */
 int
-tls_version_min_parse(const char *vstr, const char *extra)
+tls_version_parse(const char *vstr, const char *extra)
 {
   const int max_version = tls_version_max();
   if (!strcmp(vstr, "1.0") && TLS_VER_1_0 <= max_version)
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 8a812e5..dc7010b 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -114,7 +114,7 @@ void tls_clear_error();
 #define TLS_VER_1_0     1
 #define TLS_VER_1_1     2
 #define TLS_VER_1_2     3
-int tls_version_min_parse(const char *vstr, const char *extra);
+int tls_version_parse(const char *vstr, const char *extra);
 
 /**
  * Return the maximum TLS version (as a TLS_VER_x constant)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 6d56c57..a0ea4dc 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -291,8 +291,10 @@ struct tls_options
 # define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<2)
 # define SSLF_OPT_VERIFY               (1<<4)
 # define SSLF_CRL_VERIFY_DIR           (1<<5)
-# define SSLF_TLS_VERSION_SHIFT        6
-# define SSLF_TLS_VERSION_MASK         0xF /* (uses bit positions 6 to 9) */
+# define SSLF_TLS_VERSION_MIN_SHIFT    6
+# define SSLF_TLS_VERSION_MIN_MASK     0xF /* (uses bit positions 6 to 9) */
+# define SSLF_TLS_VERSION_MAX_SHIFT    10
+# define SSLF_TLS_VERSION_MAX_MASK     0xF /* (uses bit positions 10 to 13) */
   unsigned int ssl_flags;
 
 #ifdef MANAGEMENT_DEF_AUTH
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index cfedcc6..773f529 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -121,7 +121,8 @@ tmp_rsa_cb (SSL * s, int is_export, int keylength)
 void
 tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
-  const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+  const int tls_version_min =
+      (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
 
   ASSERT(NULL != ctx);
 
@@ -139,7 +140,8 @@ tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 void
 tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
-  const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+  const int tls_version_min =
+      (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
 
   ASSERT(NULL != ctx);
 
@@ -218,15 +220,22 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
   /* process SSL options including minimum TLS version we will accept from peer */
   {
     long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
-    const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
-    if (tls_version_min > TLS_VER_1_0)
+    const int tls_ver_min =
+	(ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
+    int tls_ver_max =
+	(ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
+
+    if (tls_ver_max <= TLS_VER_UNSPEC)
+	tls_ver_max = tls_version_max();
+
+    if (tls_ver_min > TLS_VER_1_0 || tls_ver_max < TLS_VER_1_0)
       sslopt |= SSL_OP_NO_TLSv1;
 #ifdef SSL_OP_NO_TLSv1_1
-    if (tls_version_min > TLS_VER_1_1)
+    if (tls_ver_min > TLS_VER_1_1 || tls_ver_max < TLS_VER_1_1)
       sslopt |= SSL_OP_NO_TLSv1_1;
 #endif
 #ifdef SSL_OP_NO_TLSv1_2
-    if (tls_version_min > TLS_VER_1_2)
+    if (tls_ver_min > TLS_VER_1_2 || tls_ver_max < TLS_VER_1_2)
       sslopt |= SSL_OP_NO_TLSv1_2;
 #endif
     SSL_CTX_set_options (ctx->ctx, sslopt);
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 1817a6c..69d0cf4 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -637,6 +637,40 @@ tls_version_max(void)
 #endif
 }
 
+/**
+ * Convert an OpenVPN tls-version variable to PolarSSl format (i.e. a major and
+ * minor ssl version number).
+ *
+ * @param tls_ver	The tls-version variable to convert.
+ * @param major		Returns the TLS major version in polarssl format.
+ * 			Must be a valid pointer.
+ * @param minor		Returns the TLS minor version in polarssl format.
+ * 			Must be a valid pointer.
+ */
+static void tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
+  ASSERT(major);
+  ASSERT(minor);
+
+  switch (tls_ver)
+  {
+    case TLS_VER_1_0:
+      *major = SSL_MAJOR_VERSION_3;
+      *minor = SSL_MINOR_VERSION_1;
+      break;
+    case TLS_VER_1_1:
+      *major = SSL_MAJOR_VERSION_3;
+      *minor = SSL_MINOR_VERSION_2;
+      break;
+    case TLS_VER_1_2:
+      *major = SSL_MAJOR_VERSION_3;
+      *minor = SSL_MINOR_VERSION_3;
+      break;
+    default:
+      msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
+      break;
+  }
+}
+
 void key_state_ssl_init(struct key_state_ssl *ks_ssl,
     const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
 {
@@ -694,30 +728,32 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
 
       /* Initialize minimum TLS version */
       {
-	const int tls_version_min = (session->opt->ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
-	int polar_major;
-	int polar_minor;
-	switch (tls_version_min)
+	const int tls_version_min =
+	    (session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
+	    SSLF_TLS_VERSION_MIN_MASK;
+
+	/* default to TLS 1.0 */
+	int major = SSL_MAJOR_VERSION_3;
+	int minor = SSL_MINOR_VERSION_1;
+
+	if (tls_version_min > TLS_VER_UNSPEC)
+	  tls_version_to_major_minor(tls_version_min, &major, &minor);
+
+	ssl_set_min_version(ks_ssl->ctx, major, minor);
+      }
+
+      /* Initialize maximum TLS version */
+      {
+	const int tls_version_max =
+	    (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
+	    SSLF_TLS_VERSION_MAX_MASK;
+
+	if (tls_version_max > TLS_VER_UNSPEC)
 	  {
-	  case TLS_VER_1_0:
-	  default:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_1;
-	    break;
-#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
-	  case TLS_VER_1_1:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_2;
-	    break;
-#endif
-#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
-	  case TLS_VER_1_2:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_3;
-	    break;
-#endif
+	    int major, minor;
+	    tls_version_to_major_minor(tls_version_max, &major, &minor);
+	    ssl_set_max_version(ks_ssl->ctx, major, minor);
 	  }
-	ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
       }
 
       /* Initialise BIOs */
-- 
1.9.1


--------------080301040806070808070100
Content-Type: text/x-patch; name="master-Add-tls-version-max.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="master-Add-tls-version-max.patch"

From 80545f17040fb2a5819193e48607d76e7e50b876 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 26 Aug 2014 00:03:23 +0200
Subject: [PATCH] Add --tls-version-max

Because using TLS 1.2 breaks certain setups, a user might want to enforce
a maximum TLS version to use. This patch adds that option.

This patch removes a number of #ifdefs from ssl_polarssl.c, because the
polarssl versions we currently support (polar 1.2 for openvpn 2.3, and
polar 1.3 for openvpn-master) have all versions unconditionally enabled.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/openvpn.8              |  5 +++
 src/openvpn/options.c      | 22 ++++++++++--
 src/openvpn/ssl.c          |  2 +-
 src/openvpn/ssl_backend.h  | 11 +++---
 src/openvpn/ssl_common.h   |  6 ++--
 src/openvpn/ssl_openssl.c  | 16 ++++++---
 src/openvpn/ssl_polarssl.c | 84 +++++++++++++++++++++++++++++++++-------------
 7 files changed, 107 insertions(+), 39 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f2911c0..8fca9aa 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4330,6 +4330,11 @@ and version is not recognized, we will only accept the highest TLS
 version supported by the local SSL implementation.
 .\"*********************************************************
 .TP
+.B \-\-tls-version-max version
+Set the maximum TLS version we will use (default is the highest version
+supported).  Examples for version include "1.0", "1.1", or "1.2".
+.\"*********************************************************
+.TP
 .B \-\-pkcs12 file
 Specify a PKCS #12 file containing local private key,
 local certificate, and root CA certificate.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 84eb6ed..64ded09 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -572,6 +572,7 @@ static const char usage_message[] =
   "--tls-version-min <version> ['or-highest'] : sets the minimum TLS version we\n"
   "    will accept from the peer.  If version is unrecognized and 'or-highest'\n"
   "    is specified, require max TLS version supported by SSL implementation.\n"
+  "--tls-version-max <version> : sets the maximum TLS version we will use.\n"
 #ifndef ENABLE_CRYPTO_POLARSSL
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
@@ -6577,14 +6578,29 @@ add_option (struct options *options,
     {
       int ver;
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      ver = tls_version_min_parse(p[1], p[2]);
+      ver = tls_version_parse(p[1], p[2]);
       if (ver == TLS_VER_BAD)
 	{
 	  msg (msglevel, "unknown tls-version-min parameter: %s", p[1]);
           goto err;
 	}
-      options->ssl_flags &= ~(SSLF_TLS_VERSION_MASK << SSLF_TLS_VERSION_SHIFT);
-      options->ssl_flags |= (ver << SSLF_TLS_VERSION_SHIFT);
+      options->ssl_flags &=
+	  ~(SSLF_TLS_VERSION_MIN_MASK << SSLF_TLS_VERSION_MIN_SHIFT);
+      options->ssl_flags |= (ver << SSLF_TLS_VERSION_MIN_SHIFT);
+    }
+  else if (streq (p[0], "tls-version-max") && p[1])
+    {
+      int ver;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      ver = tls_version_parse(p[1], NULL);
+      if (ver == TLS_VER_BAD)
+	{
+	  msg (msglevel, "unknown tls-version-max parameter: %s", p[1]);
+          goto err;
+	}
+      options->ssl_flags &=
+	  ~(SSLF_TLS_VERSION_MAX_MASK << SSLF_TLS_VERSION_MAX_SHIFT);
+      options->ssl_flags |= (ver << SSLF_TLS_VERSION_MAX_SHIFT);
     }
 #ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "pkcs12") && p[1])
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3ce1f60..c81659f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -454,7 +454,7 @@ ssl_put_auth_challenge (const char *cr_str)
  * return tls_version_max().
  */
 int
-tls_version_min_parse(const char *vstr, const char *extra)
+tls_version_parse(const char *vstr, const char *extra)
 {
   const int max_version = tls_version_max();
   if (!strcmp(vstr, "1.0") && TLS_VER_1_0 <= max_version)
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index bfd1549..b0777bf 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -109,11 +109,12 @@ void tls_clear_error();
  * @return 		One of the TLS_VER_x constants or TLS_VER_BAD
  *                      if a parse error should be flagged.
  */
-#define TLS_VER_BAD   -1
-#define TLS_VER_1_0    0 /* default */
-#define TLS_VER_1_1    1
-#define TLS_VER_1_2    2
-int tls_version_min_parse(const char *vstr, const char *extra);
+#define TLS_VER_BAD    -1
+#define TLS_VER_UNSPEC  0 /* default */
+#define TLS_VER_1_0     1
+#define TLS_VER_1_1     2
+#define TLS_VER_1_2     3
+int tls_version_parse(const char *vstr, const char *extra);
 
 /**
  * Return the maximum TLS version (as a TLS_VER_x constant)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 04ba789..2719b41 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -296,8 +296,10 @@ struct tls_options
 # define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<2)
 # define SSLF_OPT_VERIFY               (1<<4)
 # define SSLF_CRL_VERIFY_DIR           (1<<5)
-# define SSLF_TLS_VERSION_SHIFT        6
-# define SSLF_TLS_VERSION_MASK         0xF /* (uses bit positions 6 to 9) */
+# define SSLF_TLS_VERSION_MIN_SHIFT    6
+# define SSLF_TLS_VERSION_MIN_MASK     0xF /* (uses bit positions 6 to 9) */
+# define SSLF_TLS_VERSION_MAX_SHIFT    10
+# define SSLF_TLS_VERSION_MAX_MASK     0xF /* (uses bit positions 10 to 13) */
   unsigned int ssl_flags;
 
 #ifdef MANAGEMENT_DEF_AUTH
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index adf3ae6..6782a95 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -184,15 +184,23 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
   /* process SSL options including minimum TLS version we will accept from peer */
   {
     long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
-    const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
-    if (tls_version_min > TLS_VER_1_0)
+    int tls_ver_max = TLS_VER_UNSPEC;
+    const int tls_ver_min =
+	(ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
+
+    tls_ver_max =
+	(ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
+    if (tls_ver_max <= TLS_VER_UNSPEC)
+	tls_ver_max = tls_version_max();
+
+    if (tls_ver_min > TLS_VER_1_0 || tls_ver_max < TLS_VER_1_0)
       sslopt |= SSL_OP_NO_TLSv1;
 #ifdef SSL_OP_NO_TLSv1_1
-    if (tls_version_min > TLS_VER_1_1)
+    if (tls_ver_min > TLS_VER_1_1 || tls_ver_max < TLS_VER_1_1)
       sslopt |= SSL_OP_NO_TLSv1_1;
 #endif
 #ifdef SSL_OP_NO_TLSv1_2
-    if (tls_version_min > TLS_VER_1_2)
+    if (tls_ver_min > TLS_VER_1_2 || tls_ver_max < TLS_VER_1_2)
       sslopt |= SSL_OP_NO_TLSv1_2;
 #endif
     SSL_CTX_set_options (ctx->ctx, sslopt);
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 387e636..94ae4c3 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -685,6 +685,40 @@ tls_version_max(void)
 #endif
 }
 
+/**
+ * Convert an OpenVPN tls-version variable to PolarSSl format (i.e. a major and
+ * minor ssl version number).
+ *
+ * @param tls_ver	The tls-version variable to convert.
+ * @param major		Returns the TLS major version in polarssl format.
+ * 			Must be a valid pointer.
+ * @param minor		Returns the TLS minor version in polarssl format.
+ * 			Must be a valid pointer.
+ */
+static void tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
+  ASSERT(major);
+  ASSERT(minor);
+
+  switch (tls_ver)
+  {
+    case TLS_VER_1_0:
+      *major = SSL_MAJOR_VERSION_3;
+      *minor = SSL_MINOR_VERSION_1;
+      break;
+    case TLS_VER_1_1:
+      *major = SSL_MAJOR_VERSION_3;
+      *minor = SSL_MINOR_VERSION_2;
+      break;
+    case TLS_VER_1_2:
+      *major = SSL_MAJOR_VERSION_3;
+      *minor = SSL_MINOR_VERSION_3;
+      break;
+    default:
+      msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
+      break;
+  }
+}
+
 void key_state_ssl_init(struct key_state_ssl *ks_ssl,
     const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
 {
@@ -743,30 +777,32 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
 
       /* Initialize minimum TLS version */
       {
-	const int tls_version_min = (session->opt->ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
-	int polar_major;
-	int polar_minor;
-	switch (tls_version_min)
+	const int tls_version_min =
+	    (session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
+	    SSLF_TLS_VERSION_MIN_MASK;
+
+	/* default to TLS 1.0 */
+	int major = SSL_MAJOR_VERSION_3;
+	int minor = SSL_MINOR_VERSION_1;
+
+	if (tls_version_min > TLS_VER_UNSPEC)
+	  tls_version_to_major_minor(tls_version_min, &major, &minor);
+
+	ssl_set_min_version(ks_ssl->ctx, major, minor);
+      }
+
+      /* Initialize maximum TLS version */
+      {
+	const int tls_version_max =
+	    (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
+	    SSLF_TLS_VERSION_MAX_MASK;
+
+	if (tls_version_max > TLS_VER_UNSPEC)
 	  {
-	  case TLS_VER_1_0:
-	  default:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_1;
-	    break;
-#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
-	  case TLS_VER_1_1:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_2;
-	    break;
-#endif
-#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
-	  case TLS_VER_1_2:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_3;
-	    break;
-#endif
+	    int major, minor;
+	    tls_version_to_major_minor(tls_version_max, &major, &minor);
+	    ssl_set_max_version(ks_ssl->ctx, major, minor);
 	  }
-	ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
       }
 
       /* Initialise BIOs */
-- 
1.9.1


--------------080301040806070808070100--

