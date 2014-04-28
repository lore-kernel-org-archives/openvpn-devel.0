Message-ID: <535EC5FE.6060302@...1856...>
Date: Mon, 28 Apr 2014 23:19:58 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>	<1398064204-26476-4-git-send-email-james@...515...>
	<20140427175312.GJ16637@...1296...>
	<535D6431.5000308@...1856...>
In-Reply-To: <535D6431.5000308@...1856...>
Content-Type: multipart/mixed; boundary="------------000401080108020700090302"
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
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000401080108020700090302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

On 27-04-14 22:10, Steffan Karger wrote:
> On 27-04-14 19:53, Gert Doering wrote:
>> On Mon, Apr 21, 2014 at 01:10:04AM -0600, James Yonan wrote: The
>> attached patch is what I intend to commit to release/2.3 *only*,
>> not to master - as agreed at the IRC meeting.  "Please ACK" :-)
> 
> Sorry, but NAK.

On a more constructive note: attached a new proposal for this patch.

> The OpenSSL bits look fine

On a closer look, the wrapping "if (tls_version_min > TLS_VER_UNSPEC)"
in tls_ctx_set_options() seems redundant, because TLS_VER_UNSPEC <
TLS_VER_1_0 < TLS_VER_1_1 < TLS_VER_1_2 and the ifs are checking for
"tls_version_min > TLS_VER_1_x". I've removed these changes in the
attached patch proposal.

> the PolarSSL bits
> would also allow for SSL_MINOR_VERSION_0, which is SSLv3 and thus a
> reduction in security (and actually increases the handshake complexity).

To elaborate a bit: The naming is a bit confusing, but
SSL_MAJOR_VERSION_3 + SSL_MINOR_VERSION_O means SSLv3, ... +
SSL_MINOR_VERSION_1 means TLSv1.0, ... + SSL_MINOR_VERSION_2 means
TLSv1.1, etc. If none are given (what would happen in the previous
version of the patch), PolarSSL defaults the minimum version to SSLv3
and maximum to TLSv1.2. The attached patch thus removes the wrapping "if
(tls_version_min > TLS_VER_UNSPEC)" and sets the default to TLSv1.0 to
TLSv1.2 again. That is equal to the behaviour prior to the TLS
versioning patch.

-Steffan

--------------000401080108020700090302
Content-Type: text/x-patch;
	name="0001-When-tls-version-min-is-unspecified-revert-to-origin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-When-tls-version-min-is-unspecified-revert-to-origin.pa";
	filename*1="tch"

From 558fdb6142f4d5b0c039437a001b13110a910e5b Mon Sep 17 00:00:00 2001
From: James Yonan <james@...515...>
Date: Mon, 28 Apr 2014 22:52:11 +0200
Subject: [PATCH] When tls-version-min is unspecified, revert to original
 versioning approach.

For OpenSSL, this means to use TLSv1_(client|server)_method rather
than SSLv23_(client|server)_method combined with SSL_OP_NO_x flags
for specific TLS versions to disable.

For PolarSSL, this means to implicitly control the TLS version via allowed
ciphersuites.

Point out off-by-default-now setting in the openvpn(8) man page.

This patch is only included in the release/2.3 branch, because it's a
stopgap measure.  2.4 will have it on-by-default, when the remaining
handshake problems are fully debugged and solved.

Signed-off-by: James Yonan <james@...515...>
Signed-off-by: Gert Doering <gert@...1296...>
Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8              |  8 +++++++-
 src/openvpn/ssl.c          |  4 ++--
 src/openvpn/ssl_backend.h  | 15 +++++++++------
 src/openvpn/ssl_openssl.c  | 18 ++++++++++++++----
 src/openvpn/ssl_polarssl.c |  4 ++--
 5 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 585751b..c9c82ac 100644
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
+the beaviour to what OpenVPN versions up to 2.3.2 did, as it turned 
+out that TLS version negotiation can lead to handshake problems due
+to new signature algorithms in TLS 1.2.
 .\"*********************************************************
 .TP
 .B \-\-pkcs12 file
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 93d81e2..ac6818e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -486,12 +486,12 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
 
   if (options->tls_server)
     {
-      tls_ctx_server_new(new_ctx);
+      tls_ctx_server_new(new_ctx, options->ssl_flags);
       tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
     }
   else				/* if client */
     {
-      tls_ctx_client_new(new_ctx);
+      tls_ctx_client_new(new_ctx, options->ssl_flags);
     }
 
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
 
 /**
@@ -127,15 +128,17 @@ int tls_version_max(void);
  * Initialise a library-specific TLS context for a server.
  *
  * @param ctx		TLS context to initialise
+ * @param ssl_flags     SSLF_x flags from ssl_common.h
  */
-void tls_ctx_server_new(struct tls_root_ctx *ctx);
+void tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags);
 
 /**
  * Initialises a library-specific TLS context for a client.
  *
  * @param ctx		TLS context to initialise
+ * @param ssl_flags     SSLF_x flags from ssl_common.h
  */
-void tls_ctx_client_new(struct tls_root_ctx *ctx);
+void tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags);
 
 /**
  * Frees the library-specific TLSv1 context
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 08e3592..481600a 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -119,11 +119,16 @@ tmp_rsa_cb (SSL * s, int is_export, int keylength)
 }
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
+  const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+
   ASSERT(NULL != ctx);
 
-  ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
+  if (tls_version_min > TLS_VER_UNSPEC)
+    ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
+  else
+    ctx->ctx = SSL_CTX_new (TLSv1_server_method ());
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
@@ -132,11 +137,16 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 }
 
 void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
+tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
+  const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+
   ASSERT(NULL != ctx);
 
-  ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
+  if (tls_version_min > TLS_VER_UNSPEC)
+    ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
+  else
+    ctx->ctx = SSL_CTX_new (TLSv1_client_method ());
 
   if (ctx->ctx == NULL)
     msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 6334783..0dfffd6 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -67,7 +67,7 @@ tls_clear_error()
 }
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
@@ -84,7 +84,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 }
 
 void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
+tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
-- 
1.9.1


--------------000401080108020700090302--

