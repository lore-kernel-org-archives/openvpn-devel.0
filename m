Message-ID: <51B1DBEF.1090705@...1435...>
Date: Fri, 7 Jun 2013 15:11:11 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090908070908090102090804"
Subject: [Openvpn-devel] [PATCH] Do not pass struct tls_session* as void*
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--------------090908070908090102090804
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

The attached patch changes the key_state_ssl_init() function to take the
TLS session as a 'struct tls_session *', instead of a 'void *' that has
to be cast back later. This patch prepares for a patch from Tamas Tevesz
that actually uses the TLS session inside key_state_ssl_init().

-Steffan

--------------090908070908090102090804
Content-Type: text/x-patch;
	name="0001-Do-not-pass-struct-tls_session-as-void-in-key_state_.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Do-not-pass-struct-tls_session-as-void-in-key_state_.pa";
	filename*1="tch"

From fcae4846ed642386be8ae985f0b8ff29d3b738ba Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan.karger@...1435...>
Date: Sun, 19 May 2013 10:01:29 +0200
Subject: [PATCH 1/2] Do not pass struct tls_session* as void* in
 key_state_ssl_init().

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_backend.h  |    6 +++++-
 src/openvpn/ssl_openssl.c  |    2 +-
 src/openvpn/ssl_polarssl.c |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index f61580c..72235ae 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -42,6 +42,10 @@
 #include "ssl_verify_polarssl.h"
 #endif
 
+/**
+ *  prototype for struct tls_session from ssl_common.h
+ */
+struct tls_session;
 
 /**
  * Get a tls_cipher_name_pair containing OpenSSL and IANA names for supplied TLS cipher name
@@ -291,7 +295,7 @@ void tls_ctx_personalise_random(struct tls_root_ctx *ctx);
  * @param session	The session associated with the given key_state
  */
 void key_state_ssl_init(struct key_state_ssl *ks_ssl,
-    const struct tls_root_ctx *ssl_ctx, bool is_server, void *session);
+    const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session);
 
 /**
  * Free the SSL channel part of the given key state.
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 79cc056..2e40ebd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1015,7 +1015,7 @@ bio_read (BIO *bio, struct buffer *buf, int maxlen, const char *desc)
 }
 
 void
-key_state_ssl_init(struct key_state_ssl *ks_ssl, const struct tls_root_ctx *ssl_ctx, bool is_server, void *session)
+key_state_ssl_init(struct key_state_ssl *ks_ssl, const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
 {
   ASSERT(NULL != ssl_ctx);
   ASSERT(ks_ssl);
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 2b5b37b..a82b233 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -502,7 +502,7 @@ void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 }
 
 void key_state_ssl_init(struct key_state_ssl *ks_ssl,
-    const struct tls_root_ctx *ssl_ctx, bool is_server, void *session)
+    const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
 {
   ASSERT(NULL != ssl_ctx);
   ASSERT(ks_ssl);
-- 
1.7.9.5


--------------090908070908090102090804--

