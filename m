From: Arne Schwabe <arne@...1227...>
Date: Tue, 25 Aug 2020 06:16:47 +0200
Message-Id: <20200825041647.26235-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix compilation with older mbed TLS
 versions (mbedtls_tls_prf_types undefined)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The usage of the new keying material methods was not properly guarded.

To avoid a number of ifdefs this commit uses a dummy struct and function.
When we eventually drop support for non-EKM mbed TLS version we can remove
these.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_mbedtls.c | 10 ++++++++++
 src/openvpn/ssl_mbedtls.h |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4287b59e..4ec355a9 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -253,6 +253,16 @@ key_state_export_keying_material(struct tls_session *session,
         return  NULL;
     }
 }
+#else
+unsigned char*
+key_state_export_keying_material(struct tls_session *session,
+                                 const char* label, size_t label_size,
+                                 size_t ekm_size,
+                                 struct gc_arena *gc)
+{
+    /* Dummy function to avoid ifdefs in the common code */
+    return NULL;
+}
 #endif /* HAVE_EXPORT_KEYING_MATERIAL */
 
 bool
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 17aae551..ff64e17c 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -82,6 +82,7 @@ struct external_context {
     void *sign_ctx;
 };
 
+#ifdef HAVE_EXPORT_KEYING_MATERIAL
 /** struct to cache TLS secrets for keying material exporter (RFC 5705).
  * The constants (64 and 48) are inherent to TLS version and
  * the whole keying material export will likely change when they change */
@@ -90,6 +91,9 @@ struct tls_key_cache {
     mbedtls_tls_prf_types tls_prf_type;
     unsigned char master_secret[48];
 };
+#else
+struct tls_key_cache { };
+#endif
 
 /**
  * Structure that wraps the TLS context. Contents differ depending on the
@@ -124,7 +128,6 @@ struct key_state_ssl {
     bio_ctx *bio_ctx;
 
     struct tls_key_cache tls_key_cache;
-
 };
 
 /**
-- 
2.26.2


