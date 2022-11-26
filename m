From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Sat, 26 Nov 2022 17:26:48 +0100
Message-ID: <20221126162648.150678-2-maximilian.fillinger@...2507...>
In-Reply-To: <20221126162648.150678-1-maximilian.fillinger@...2507...>
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Fix message for too long tls-crypt-v2
 metadata
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

The current code only checks if the base64-encoded metadata is at most
980 characters. However, that can encode up to 735 bytes of data, while
only up to 733 bytes are allowed. When passing 734 or 735 bytes, openvpn
prints a misleading error message saying that the base64 cannot be
decoded.

This patch checks the decoded length to show an accurate error message.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/base64.h    |  4 ++++
 src/openvpn/tls_crypt.c | 18 +++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/base64.h b/src/openvpn/base64.h
index f49860fc..7b4224a5 100644
--- a/src/openvpn/base64.h
+++ b/src/openvpn/base64.h
@@ -38,6 +38,10 @@
 #define OPENVPN_BASE64_LENGTH(binary_length) \
     ((((8 * binary_length) / 6) + 3) & ~3)
 
+/** Compute the maximal number of bytes encoded in a base64 string. */
+#define OPENVPN_BASE64_DECODED_LENGTH(base64_length) \
+    ((base64_length / 4) * 3)
+
 int openvpn_base64_encode(const void *data, int size, char **str);
 
 int openvpn_base64_decode(const char *str, void *data, int size);
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2fc79111..5d247b84 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -627,15 +627,11 @@ tls_crypt_v2_write_client_key_file(const char *filename,
     }
     ASSERT(buf_write(&dst, client_key.keys, sizeof(client_key.keys)));
 
-    struct buffer metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
+    struct buffer metadata;
     if (b64_metadata)
     {
-        if (TLS_CRYPT_V2_MAX_B64_METADATA_LEN < strlen(b64_metadata))
-        {
-            msg(M_FATAL,
-                "ERROR: metadata too long (%d bytes, max %u bytes)",
-                (int)strlen(b64_metadata), TLS_CRYPT_V2_MAX_B64_METADATA_LEN);
-        }
+        size_t b64_length = strlen(b64_metadata);
+        metadata = alloc_buf_gc(OPENVPN_BASE64_DECODED_LENGTH(b64_length) + 1, &gc);
         ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_USER, 1));
         int decoded_len = openvpn_base64_decode(b64_metadata, BEND(&metadata),
                                                 BCAP(&metadata));
@@ -644,10 +640,18 @@ tls_crypt_v2_write_client_key_file(const char *filename,
             msg(M_FATAL, "ERROR: failed to base64 decode provided metadata");
             goto cleanup;
         }
+        if (decoded_len > TLS_CRYPT_V2_MAX_METADATA_LEN)
+        {
+            msg(M_FATAL,
+                "ERROR: metadata too long (%d bytes, max %u bytes)",
+                decoded_len, TLS_CRYPT_V2_MAX_METADATA_LEN - 1);
+            goto cleanup;
+        }
         ASSERT(buf_inc_len(&metadata, decoded_len));
     }
     else
     {
+        metadata = alloc_buf_gc(1 + sizeof(int64_t), &gc);
         int64_t timestamp = htonll((uint64_t)now);
         ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_TIMESTAMP, 1));
         ASSERT(buf_write(&metadata, &timestamp, sizeof(timestamp)));
-- 
2.30.2


