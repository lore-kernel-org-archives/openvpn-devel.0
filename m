From: David Sommerseth <davids@...515...>
Date: Thu, 13 Oct 2016 21:59:27 +0200
Message-Id: <1476388771-16492-2-git-send-email-davids@...515...>
In-Reply-To: <1476388771-16492-1-git-send-email-davids@...515...>
References: <1476388771-16492-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 1/5] Move memcmp_constant_time() to crypto.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This function is quite useful other places, so make it generally
accessible.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/crypto.c | 18 ------------------
 src/openvpn/crypto.h | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 3dd4a9e..026d9ae 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -66,24 +66,6 @@
 #define CRYPT_ERROR(format) \
   do { msg (D_CRYPT_ERRORS, "%s: " format, error_prefix); goto error_exit; } while (false)
 
-/**
- * As memcmp(), but constant-time.
- * Returns 0 when data is equal, non-zero otherwise.
- */
-static int
-memcmp_constant_time (const void *a, const void *b, size_t size) {
-  const uint8_t * a1 = a;
-  const uint8_t * b1 = b;
-  int ret = 0;
-  size_t i;
-
-  for (i = 0; i < size; i++) {
-      ret |= *a1++ ^ *b1++;
-  }
-
-  return ret;
-}
-
 static void
 openvpn_encrypt_aead (struct buffer *buf, struct buffer work,
 	 struct crypto_options *opt) {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 3b6bb98..9ae0610 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -476,6 +476,24 @@ void get_tls_handshake_key (const struct key_type *key_type,
  * Inline functions
  */
 
+/**
+ * As memcmp(), but constant-time.
+ * Returns 0 when data is equal, non-zero otherwise.
+ */
+static int
+memcmp_constant_time (const void *a, const void *b, size_t size) {
+  const uint8_t * a1 = a;
+  const uint8_t * b1 = b;
+  int ret = 0;
+  size_t i;
+
+  for (i = 0; i < size; i++) {
+      ret |= *a1++ ^ *b1++;
+  }
+
+  return ret;
+}
+
 static inline bool
 key_ctx_bi_defined(const struct key_ctx_bi* key)
 {
-- 
1.8.3.1


