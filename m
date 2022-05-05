From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  5 May 2022 13:43:22 +0200
Message-Id: <20220505114322.6460-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Introduce macros for the returns values of
 key_state_*
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

I think that makes the code slightly more readable.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/ssl.c         | 20 +++++++++---------
 src/openvpn/ssl_backend.h | 35 ++++++++++++++++++-------------
 src/openvpn/ssl_mbedtls.c | 44 +++++++++++++++++++--------------------
 3 files changed, 52 insertions(+), 47 deletions(-)

Might conflict with some of Arne's handshake patches.

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5b0cdcaa..b174b723 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2599,7 +2599,7 @@ tls_process_state(struct tls_multi *multi,
         if (buf->len)
         {
             status = key_state_write_ciphertext(&ks->ks_ssl, buf);
-            if (status == -1)
+            if (status == KS_IO_ERROR)
             {
                 msg(D_TLS_ERRORS,
                     "TLS Error: Incoming Ciphertext -> TLS object write error");
@@ -2608,9 +2608,9 @@ tls_process_state(struct tls_multi *multi,
         }
         else
         {
-            status = 1;
+            status = KS_IO_SUCCESS;
         }
-        if (status == 1)
+        if (status == KS_IO_SUCCESS)
         {
             reliable_mark_deleted(ks->rec_reliable, buf);
             state_change = true;
@@ -2627,12 +2627,12 @@ tls_process_state(struct tls_multi *multi,
         ASSERT(buf_init(buf, 0));
         status = key_state_read_plaintext(&ks->ks_ssl, buf, TLS_CHANNEL_BUF_SIZE);
         update_time();
-        if (status == -1)
+        if (status == KS_IO_ERROR)
         {
             msg(D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext read error");
             goto error;
         }
-        if (status == 1)
+        if (status == KS_IO_SUCCESS)
         {
             state_change = true;
             dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");
@@ -2678,13 +2678,13 @@ tls_process_state(struct tls_multi *multi,
     if (buf->len)
     {
         int status = key_state_write_plaintext(&ks->ks_ssl, buf);
-        if (status == -1)
+        if (status == KS_IO_ERROR)
         {
             msg(D_TLS_ERRORS,
                 "TLS ERROR: Outgoing Plaintext -> TLS object write error");
             goto error;
         }
-        if (status == 1)
+        if (status == KS_IO_SUCCESS)
         {
             state_change = true;
             dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
@@ -2699,13 +2699,13 @@ tls_process_state(struct tls_multi *multi,
         {
             int status = key_state_read_ciphertext(&ks->ks_ssl, buf, multi->opt.frame.tun_mtu);
 
-            if (status == -1)
+            if (status == KS_IO_ERROR)
             {
                 msg(D_TLS_ERRORS,
                     "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
                 goto error;
             }
-            if (status == 1)
+            if (status == KS_IO_SUCCESS)
             {
                 reliable_mark_active_outgoing(ks->send_reliable, buf, P_CONTROL_V1);
                 INCR_GENERATED;
@@ -3689,7 +3689,7 @@ tls_send_payload(struct tls_multi *multi,
 
     if (ks->state >= S_ACTIVE)
     {
-        if (key_state_write_plaintext_const(&ks->ks_ssl, data, size) == 1)
+        if (key_state_write_plaintext_const(&ks->ks_ssl, data, size) == KS_IO_SUCCESS)
         {
             ret = true;
         }
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 1bd33699..d68f02aa 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -32,6 +32,11 @@
 
 #include "buffer.h"
 
+/* key_state_{read,write}_* return values */
+#define KS_IO_SUCCESS 1
+#define KS_IO_RETRY   0
+#define KS_IO_ERROR  -1
+
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_openssl.h"
 #include "ssl_verify_openssl.h"
@@ -427,10 +432,10 @@ key_state_export_keying_material(struct tls_session *session,
  *
  * @return The return value indicates whether the data was successfully
  *     processed:
- * - \c 1: All the data was processed successfully.
- * - \c 0: The data was not processed, this function should be called
+ * - \c KS_IO_SUCCESS: All the data was processed successfully.
+ * - \c KS_IO_RETRY: The data was not processed, this function should be called
  *   again later to retry.
- * - \c -1: An error occurred.
+ * - \c KS_IO_ERROR: An error occurred.
  */
 int key_state_write_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf);
 
@@ -444,10 +449,10 @@ int key_state_write_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf);
  *
  * @return The return value indicates whether the data was successfully
  *     processed:
- * - \c 1: All the data was processed successfully.
- * - \c 0: The data was not processed, this function should be called
+ * - \c KS_IO_SUCCESS: All the data was processed successfully.
+ * - \c KS_IO_RETRY: The data was not processed, this function should be called
  *   again later to retry.
- * - \c -1: An error occurred.
+ * - \c KS_IO_ERROR: An error occurred.
  */
 int key_state_write_plaintext_const(struct key_state_ssl *ks_ssl,
                                     const uint8_t *data, int len);
@@ -465,10 +470,10 @@ int key_state_write_plaintext_const(struct key_state_ssl *ks_ssl,
  *
  * @return The return value indicates whether the data was successfully
  *     processed:
- * - \c 1: Data was extracted successfully.
- * - \c 0: No data was extracted, this function should be called again
+ * - \c KS_IO_SUCCESS: Data was extracted successfully.
+ * - \c KS_IO_RETRY: No data was extracted, this function should be called again
  *   later to retry.
- * - \c -1: An error occurred.
+ * - \c KS_IO_ERROR: An error occurred.
  */
 int key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf,
                               int maxlen);
@@ -491,10 +496,10 @@ int key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf,
  *
  * @return The return value indicates whether the data was successfully
  *     processed:
- * - \c 1: All the data was processed successfully.
- * - \c 0: The data was not processed, this function should be called
+ * - \c KS_IO_SUCCESS: All the data was processed successfully.
+ * - \c KS_IO_RETRY: The data was not processed, this function should be called
  *   again later to retry.
- * - \c -1: An error occurred.
+ * - \c KS_IO_ERROR: An error occurred.
  */
 int key_state_write_ciphertext(struct key_state_ssl *ks_ssl,
                                struct buffer *buf);
@@ -512,10 +517,10 @@ int key_state_write_ciphertext(struct key_state_ssl *ks_ssl,
  *
  * @return The return value indicates whether the data was successfully
  *     processed:
- * - \c 1: Data was extracted successfully.
- * - \c 0: No data was extracted, this function should be called again
+ * - \c KS_IO_SUCCESS: Data was extracted successfully.
+ * - \c KS_IO_RETRY: No data was extracted, this function should be called again
  *   later to retry.
- * - \c -1: An error occurred.
+ * - \c KS_IO_ERROR: An error occurred.
  */
 int key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf,
                              int maxlen);
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b0785bae..cbaebba4 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1222,13 +1222,13 @@ key_state_ssl_free(struct key_state_ssl *ks_ssl)
 int
 key_state_write_plaintext(struct key_state_ssl *ks, struct buffer *buf)
 {
-    int retval = 0;
+    int retval = KS_IO_RETRY;
 
     ASSERT(buf);
 
     retval = key_state_write_plaintext_const(ks, BPTR(buf), BLEN(buf));
 
-    if (1 == retval)
+    if (KS_IO_SUCCESS == retval)
     {
         memset(BPTR(buf), 0, BLEN(buf));  /* erase data just written */
         buf->len = 0;
@@ -1249,7 +1249,7 @@ key_state_write_plaintext_const(struct key_state_ssl *ks, const uint8_t *data, i
     if (0 == len)
     {
         perf_pop();
-        return 0;
+        return KS_IO_RETRY;
     }
 
     ASSERT(data);
@@ -1261,11 +1261,11 @@ key_state_write_plaintext_const(struct key_state_ssl *ks, const uint8_t *data, i
         perf_pop();
         if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
         {
-            return 0;
+            return KS_IO_RETRY;
         }
         mbed_log_err(D_TLS_ERRORS, retval,
                      "TLS ERROR: write tls_write_plaintext_const error");
-        return -1;
+        return KS_IO_ERROR;
     }
 
     if (retval != len)
@@ -1274,14 +1274,14 @@ key_state_write_plaintext_const(struct key_state_ssl *ks, const uint8_t *data, i
             "TLS ERROR: write tls_write_plaintext_const incomplete %d/%d",
             retval, len);
         perf_pop();
-        return -1;
+        return KS_IO_ERROR;
     }
 
     /* successful write */
     dmsg(D_HANDSHAKE_VERBOSE, "write tls_write_plaintext_const %d bytes", retval);
 
     perf_pop();
-    return 1;
+    return KS_IO_SUCCESS;
 }
 
 int
@@ -1300,7 +1300,7 @@ key_state_read_ciphertext(struct key_state_ssl *ks, struct buffer *buf,
     if (buf->len)
     {
         perf_pop();
-        return 0;
+        return KS_IO_RETRY;
     }
 
     len = buf_forward_capacity(buf);
@@ -1317,25 +1317,25 @@ key_state_read_ciphertext(struct key_state_ssl *ks, struct buffer *buf,
         perf_pop();
         if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
         {
-            return 0;
+            return KS_IO_RETRY;
         }
         mbed_log_err(D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_ciphertext error");
         buf->len = 0;
-        return -1;
+        return KS_IO_ERROR;
     }
     /* Nothing read, try again */
     if (0 == retval)
     {
         buf->len = 0;
         perf_pop();
-        return 0;
+        return KS_IO_RETRY;
     }
 
     /* successful read */
     dmsg(D_HANDSHAKE_VERBOSE, "read tls_read_ciphertext %d bytes", retval);
     buf->len = retval;
     perf_pop();
-    return 1;
+    return KS_IO_SUCCESS;
 }
 
 int
@@ -1351,7 +1351,7 @@ key_state_write_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
     if (0 == buf->len)
     {
         perf_pop();
-        return 0;
+        return KS_IO_RETRY;
     }
 
     retval = endless_buf_write(&ks->bio_ctx->in, BPTR(buf), buf->len);
@@ -1362,11 +1362,11 @@ key_state_write_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
 
         if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
         {
-            return 0;
+            return KS_IO_RETRY;
         }
         mbed_log_err(D_TLS_ERRORS, retval,
                      "TLS ERROR: write tls_write_ciphertext error");
-        return -1;
+        return KS_IO_ERROR;
     }
 
     if (retval != buf->len)
@@ -1374,7 +1374,7 @@ key_state_write_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
         msg(D_TLS_ERRORS, "TLS ERROR: write tls_write_ciphertext incomplete %d/%d",
             retval, buf->len);
         perf_pop();
-        return -1;
+        return KS_IO_ERROR;
     }
 
     /* successful write */
@@ -1384,7 +1384,7 @@ key_state_write_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
     buf->len = 0;
 
     perf_pop();
-    return 1;
+    return KS_IO_SUCCESS;
 }
 
 int
@@ -1403,7 +1403,7 @@ key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf,
     if (buf->len)
     {
         perf_pop();
-        return 0;
+        return KS_IO_RETRY;
     }
 
     len = buf_forward_capacity(buf);
@@ -1419,19 +1419,19 @@ key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf,
     {
         if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
         {
-            return 0;
+            return KS_IO_RETRY;
         }
         mbed_log_err(D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plaintext error");
         buf->len = 0;
         perf_pop();
-        return -1;
+        return KS_IO_ERROR;
     }
     /* Nothing read, try again */
     if (0 == retval)
     {
         buf->len = 0;
         perf_pop();
-        return 0;
+        return KS_IO_RETRY;
     }
 
     /* successful read */
@@ -1439,7 +1439,7 @@ key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf,
     buf->len = retval;
 
     perf_pop();
-    return 1;
+    return KS_IO_SUCCESS;
 }
 
 /* **************************************
-- 
2.30.2


