From: Gert Doering <gert@...1296...>
Date: Tue, 27 Apr 2021 13:03:00 +0200
Message-Id: <20210427110300.6911-1-gert@...1296...>
In-Reply-To: <20210426174436.26210-1-gert@...1296...>
References: <20210426174436.26210-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] rewrite parse_hash_fingerprint()
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

The existing code was doing far too much work for too little
gain - copying the string segment for scanf(), checking extra
for spaces, making the result quite unreadable.

Verify each segment with (short-circuited) isxdigit() checks,
then feed directly to scanf(), which will stop parsing on ':'
or end-of-string.

Rewrite error message to differentiate "hash too short" (including
number of bytes read) and "hash too long" (it did not terminate when
we had enough bytes).

While at it, add an option printer for the resulting o->verify_hash
list to show_settings().

v2:
   fix typo in commit message
   appease whitespace dragon
   add printing of verify_hash_algo and verify_hash_depth
   print correct hash length for SHA1 certs
   fix incorrect assignment to options->verify_hash_algo in c3a7065d5

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 69 ++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2a5b1393..795a8fc7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1082,56 +1082,43 @@ string_substitute(const char *src, int from, int to, struct gc_arena *gc)
 static struct verify_hash_list *
 parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
 {
-    int i;
+    int i = 0;
     const char *cp = str;
 
     struct verify_hash_list *ret;
     ALLOC_OBJ_CLEAR_GC(ret, struct verify_hash_list, gc);
 
-    char term = 1;
+    char term = 0;
     int byte;
-    char bs[3];
 
-    for (i = 0; i < nbytes; ++i)
+    while (*cp && i < nbytes)
     {
-        if (strlen(cp) < 2)
+        /* valid segments consist of exactly two hex digits, then ':' or EOS */
+        if (!isxdigit(cp[0])
+            || !isxdigit(cp[1])
+            || (cp[2] != ':' && cp[2] != '\0')
+            || sscanf(cp, "%x", &byte) != 1)
         {
             msg(msglevel, "format error in hash fingerprint: %s", str);
+            break;
         }
-        bs[0] = *cp++;
-        bs[1] = *cp++;
-        bs[2] = 0;
 
-        /* the format string "%x" passed to sscanf will ignore any space and
-         * will still try to parse the other character. However, this is not
-         * expected format for a fingerprint, therefore explictly check for
-         * blanks in the string and error out if any is found
-         */
-        if (bs[0] == ' ' || bs[1] == ' ')
-        {
-            msg(msglevel, "format error in hash fingerprint unexpected blank: %s",
-                str);
-        }
+        ret->hash[i++] = (uint8_t)byte;
 
-        byte = 0;
-        if (sscanf(bs, "%x", &byte) != 1)
-        {
-            msg(msglevel, "format error in hash fingerprint hex byte: %s", str);
-        }
-        ret->hash[i] = (uint8_t)byte;
-        term = *cp++;
-        if (term != ':' && term != 0)
-        {
-            msg(msglevel, "format error in hash fingerprint delimiter: %s", str);
-        }
-        if (term == 0)
+        term = cp[2];
+        if (term == '\0')
         {
             break;
         }
+        cp += 3;
     }
-    if (term != 0 || i != nbytes-1)
+    if (i < nbytes)
     {
-        msg(msglevel, "hash fingerprint is different length than expected (%d bytes): %s", nbytes, str);
+        msg(msglevel, "hash fingerprint is wrong length - expected %d bytes, got %d: %s", nbytes, i, str);
+    }
+    else if (term != '\0')
+    {
+        msg(msglevel, "hash fingerprint too long - expected only %d bytes: %s", nbytes, str);
     }
     return ret;
 }
@@ -1791,6 +1778,23 @@ show_settings(const struct options *o)
         }
     }
     SHOW_STR(remote_cert_eku);
+    if (o->verify_hash)
+    {
+        SHOW_INT(verify_hash_algo);
+        SHOW_INT(verify_hash_depth);
+        struct gc_arena gc = gc_new();
+        struct verify_hash_list *hl = o->verify_hash;
+        int digest_len = (o->verify_hash_algo == MD_SHA1) ? SHA_DIGEST_LENGTH :
+                         SHA256_DIGEST_LENGTH;
+        while (hl)
+        {
+            char *s = format_hex_ex(hl->hash, digest_len, 0,
+                                    1, ":", &gc);
+            SHOW_PARM(verify_hash, s, "%s");
+            hl = hl->next;
+        }
+        gc_free(&gc);
+    }
     SHOW_INT(ssl_flags);
 
     SHOW_INT(tls_timeout);
@@ -8190,7 +8194,6 @@ add_option(struct options *options,
             if ((!p[2] && !is_inline) || (p[2] && streq(p[2], "SHA1")))
             {
                 options->verify_hash_algo = MD_SHA1;
-                options->verify_hash_algo = SHA_DIGEST_LENGTH;
                 digest_len = SHA_DIGEST_LENGTH;
             }
             else if (p[2] && !streq(p[2], "SHA256"))
-- 
2.26.3


