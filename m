From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Jun 2023 12:25:06 +0200
Message-Id: <20230601102506.4068185-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove key_type argument from
 generate_key_random
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

This part of the function is not used by any part of
our source code. It looks also broken if called with kt!=NULL
The function cipher_kt_key_size expects its argument to be not
NULL and would break. So remove the unused code instead of fixing
it.

Found by Coverity.

Change-Id: Id56628cfb3dfd2f306bd9bdcca2e567ac0ca9ab2
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c | 38 +++++++++++---------------------------
 src/openvpn/crypto.h |  2 --
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index b5ae17ec8..930f15a42 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -957,41 +957,25 @@ check_replay_consistency(const struct key_type *kt, bool packet_id)
 }
 
 /*
- * Generate a random key.  If key_type is provided, make
- * sure generated key is valid for key_type.
+ * Generate a random key.
  */
-void
-generate_key_random(struct key *key, const struct key_type *kt)
+static void
+generate_key_random(struct key *key)
 {
     int cipher_len = MAX_CIPHER_KEY_LENGTH;
     int hmac_len = MAX_HMAC_KEY_LENGTH;
 
     struct gc_arena gc = gc_new();
 
-    do
+    CLEAR(*key);
+    if (!rand_bytes(key->cipher, cipher_len)
+        || !rand_bytes(key->hmac, hmac_len))
     {
-        CLEAR(*key);
-        if (kt)
-        {
-            cipher_len = cipher_kt_key_size(kt->cipher);
-
-            int kt_hmac_length = md_kt_size(kt->digest);
-
-            if (kt->digest && kt_hmac_length > 0 && kt_hmac_length <= hmac_len)
-            {
-                hmac_len = kt_hmac_length;
-            }
-        }
-        if (!rand_bytes(key->cipher, cipher_len)
-            || !rand_bytes(key->hmac, hmac_len))
-        {
-            msg(M_FATAL, "ERROR: Random number generator cannot obtain entropy for key generation");
-        }
-
-        dmsg(D_SHOW_KEY_SOURCE, "Cipher source entropy: %s", format_hex(key->cipher, cipher_len, 0, &gc));
-        dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex(key->hmac, hmac_len, 0, &gc));
+        msg(M_FATAL, "ERROR: Random number generator cannot obtain entropy for key generation");
+    }
 
-    } while (kt && !check_key(key, kt));
+    dmsg(D_SHOW_KEY_SOURCE, "Cipher source entropy: %s", format_hex(key->cipher, cipher_len, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex(key->hmac, hmac_len, 0, &gc));
 
     gc_free(&gc);
 }
@@ -1398,7 +1382,7 @@ write_key_file(const int nkeys, const char *filename)
         char *fmt;
 
         /* generate random bits */
-        generate_key_random(&key, NULL);
+        generate_key_random(&key);
 
         /* format key as ascii */
         fmt = format_hex_ex((const uint8_t *)&key,
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 229a4eb1c..88f8f4472 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -304,8 +304,6 @@ void read_key_file(struct key2 *key2, const char *file, const unsigned int flags
  */
 int write_key_file(const int nkeys, const char *filename);
 
-void generate_key_random(struct key *key, const struct key_type *kt);
-
 void check_replay_consistency(const struct key_type *kt, bool packet_id);
 
 bool check_key(struct key *key, const struct key_type *kt);
-- 
2.39.2 (Apple Git-143)


