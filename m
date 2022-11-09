From: Arne Schwabe <arne@...1227...>
Date: Wed,  9 Nov 2022 13:35:01 +0100
Message-Id: <20221109123501.1252554-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add algorithm and bits used in key_print2
 method and refactor method
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

This adds the the algorithm that is being used. This does not avoid the
empty hmac key output but makes it more obvious, why there is no output.

Master Decrypt (cipher, AES-256-GCM, 256 bits): 705923be f6e44923 a4920a64 434e575c 6ff8d2db d8e74f07 86c010cf 2cf3923e
Master Decrypt (hmac, [null-digest], 0 bits):

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 4a8f514cd..d7e882ae0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -996,8 +996,22 @@ generate_key_random(struct key *key, const struct key_type *kt)
     gc_free(&gc);
 }
 
-/*
- * Print key material
+static void
+key_print(const struct key *key,
+          const struct key_type *kt,
+          const char *prefix)
+{
+    struct gc_arena gc = gc_new();
+    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher, %s, %d bits): %s",
+         prefix, cipher_kt_name(kt->cipher), cipher_kt_key_size(kt->cipher) * 8,
+         format_hex(key->cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "%s (hmac, %s, %d bits): %s",
+         prefix, md_kt_name(kt->digest), md_kt_size(kt->digest) * 8,
+         format_hex(key->hmac, md_kt_size(kt->digest), 0, &gc));
+    gc_free(&gc);
+}
+/**
+ * Prints the keys in a key2 structure.
  */
 void
 key2_print(const struct key2 *k,
@@ -1005,21 +1019,9 @@ key2_print(const struct key2 *k,
            const char *prefix0,
            const char *prefix1)
 {
-    struct gc_arena gc = gc_new();
     ASSERT(k->n == 2);
-    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s",
-         prefix0,
-         format_hex(k->keys[0].cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s",
-         prefix0,
-         format_hex(k->keys[0].hmac, md_kt_size(kt->digest), 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s",
-         prefix1,
-         format_hex(k->keys[1].cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s",
-         prefix1,
-         format_hex(k->keys[1].hmac, md_kt_size(kt->digest), 0, &gc));
-    gc_free(&gc);
+    key_print(&k->keys[0], kt, prefix0);
+    key_print(&k->keys[1], kt, prefix1);
 }
 
 void
-- 
2.37.0 (Apple Git-136)


