From: Steffan Karger <steffan@...1856...>
Date: Thu,  3 Dec 2020 16:49:51 +0100
Message-Id: <20201203154951.29382-2-steffan@...1856...>
In-Reply-To: <20201203154951.29382-1-steffan@...1856...>
References: <20201203154951.29382-1-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] tls-crypt-v2: also preload tls-crypt-v2
 keys (if --persist-key)
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

This allows tls-crypt-v2 servers to drop privileges after reading the
keys. Without it, the server would try to read the key file for each
connecting client. (And clients for each reconnect.)

As with the previous patch, the pre-loading was developed in parallel
with tls-crypt-v2, and the tls-crypt-v2 patches were never amended to
implement the pre-loading.

Also as with the previous patch, it would be nicer if servers would not
reload the tls-crypt-v2 server key for each connecting client. But let's
first fix the issue, and see if we can improve later.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 52 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 21f8d494..599f534c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1980,6 +1980,23 @@ connection_entry_load_re(struct connection_entry *ce, const struct remote_entry
     }
 }
 
+static void
+connection_entry_preload_key(const char **key_file, bool *key_inline,
+                             struct gc_arena *gc)
+{
+    if (key_file && *key_file && !(*key_inline))
+    {
+        struct buffer in = buffer_read_from_file(*key_file, gc);
+        if (!buf_valid(&in))
+        {
+            msg(M_FATAL, "Cannot pre-load keyfile (%s)", *key_file);
+        }
+
+        *key_file = (const char *) in.data;
+        *key_inline = true;
+    }
+}
+
 static void
 options_postprocess_verify_ce(const struct options *options,
                               const struct connection_entry *ce)
@@ -2931,36 +2948,17 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         ce->tls_crypt_v2_file_inline = o->tls_crypt_v2_file_inline;
     }
 
-    /* pre-cache tls-auth/crypt key file if persist-key was specified and keys
-     * were not already embedded in the config file
+    /* Pre-cache tls-auth/crypt(-v2) key file if persist-key was specified and
+     * keys were not already embedded in the config file.
      */
     if (o->persist_key)
     {
-        if (ce->tls_auth_file && !ce->tls_auth_file_inline)
-        {
-            struct buffer in = buffer_read_from_file(ce->tls_auth_file, &o->gc);
-            if (!buf_valid(&in))
-            {
-                msg(M_FATAL, "Cannot pre-load tls-auth keyfile (%s)",
-                    ce->tls_auth_file);
-            }
-
-            ce->tls_auth_file = (char *)in.data;
-            ce->tls_auth_file_inline = true;
-        }
-
-        if (ce->tls_crypt_file && !ce->tls_crypt_file_inline)
-        {
-            struct buffer in = buffer_read_from_file(ce->tls_crypt_file, &o->gc);
-            if (!buf_valid(&in))
-            {
-                msg(M_FATAL, "Cannot pre-load tls-crypt keyfile (%s)",
-                    ce->tls_crypt_file);
-            }
-
-            ce->tls_crypt_file = (char *)in.data;
-            ce->tls_crypt_file_inline = true;
-        }
+        connection_entry_preload_key(&ce->tls_auth_file,
+                                     &ce->tls_auth_file_inline, &o->gc);
+        connection_entry_preload_key(&ce->tls_crypt_file,
+                                     &ce->tls_crypt_file_inline, &o->gc);
+        connection_entry_preload_key(&ce->tls_crypt_v2_file,
+                                     &ce->tls_crypt_v2_file_inline, &o->gc);
     }
 }
 
-- 
2.25.1


