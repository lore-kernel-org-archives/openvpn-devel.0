From: Gert Doering <gert@...1296...>
Date: Tue, 23 Sep 2025 12:34:23 +0200
Message-ID: <20250923103429.1257-1-gert@...1296...>
In-Reply-To: <gerrit.1755793268000.Id7a5b2d8dea01bd532f5bcc8abea0e52b00d1169@...2715...>
References: <gerrit.1755793268000.Id7a5b2d8dea01bd532f5bcc8abea0e52b00d1169@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Clean up conversion warnings related to
 base64_{en, de}code
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

From: Frank Lichtenheld <frank@...2641...>

It seems unlikely that we can change the API at this point,
especially with the integration into the plugin API.

So
 - clean up the functions internally to not throw -Wconversion
   warnings
 - clean up any warnings on the caller side

Change-Id: Id7a5b2d8dea01bd532f5bcc8abea0e52b00d1169
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1148
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1148
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index 54d5b79..7af8976 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -50,32 +50,32 @@
 int
 openvpn_base64_encode(const void *data, int size, char **str)
 {
-    char *s, *p;
-    int i;
-    int c;
-    const unsigned char *q;
-
     if (size < 0)
     {
         return -1;
     }
-    p = s = (char *)malloc(size * 4 / 3 + 4);
+    size_t out_size = (size_t)size * 4 / 3 + 4;
+    if (out_size > INT_MAX)
+    {
+        return -1;
+    }
+    char *p = (char *)malloc(out_size);
+    char *start = p;
     if (p == NULL)
     {
         return -1;
     }
-    q = (const unsigned char *)data;
-    i = 0;
-    for (i = 0; i < size;)
+    const unsigned char *q = (const unsigned char *)data;
+    for (int i = 0; i < size;)
     {
-        c = q[i++];
-        c *= 256;
+        unsigned int c = q[i++];
+        c <<= 8;
         if (i < size)
         {
             c += q[i];
         }
         i++;
-        c *= 256;
+        c <<= 8;
         if (i < size)
         {
             c += q[i];
@@ -96,19 +96,18 @@
         p += 4;
     }
     *p = 0;
-    *str = s;
-    return strlen(s);
+    *str = start;
+    return (int)strlen(start);
 }
 
 static int
 pos(char c)
 {
-    char *p;
-    for (p = base64_chars; *p; p++)
+    for (char *p = base64_chars; *p; p++)
     {
         if (*p == c)
         {
-            return p - base64_chars;
+            return (int)(p - base64_chars);
         }
     }
     return -1;
@@ -119,16 +118,15 @@
 static unsigned int
 token_decode(const char *token)
 {
-    int i;
     unsigned int val = 0;
-    int marker = 0;
+    unsigned int marker = 0;
     if (!token[0] || !token[1] || !token[2] || !token[3])
     {
         return DECODE_ERROR;
     }
-    for (i = 0; i < 4; i++)
+    for (unsigned int i = 0; i < 4; i++)
     {
-        val *= 64;
+        val <<= 6;
         if (token[i] == '=')
         {
             marker++;
@@ -139,7 +137,12 @@
         }
         else
         {
-            val += pos(token[i]);
+            int char_pos = pos(token[i]);
+            if (unlikely(char_pos < 0)) /* caller should check */
+            {
+                return DECODE_ERROR;
+            }
+            val += (unsigned int)char_pos;
         }
     }
     if (marker > 2)
@@ -195,5 +198,5 @@
             *q++ = val & 0xff;
         }
     }
-    return q - (unsigned char *)data;
+    return (int)(q - (unsigned char *)data);
 }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 59bf52b..e0b5da1 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -420,8 +420,8 @@
                     }
                     if (!(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT))
                     {
-                        if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
-                            || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
+                        if (openvpn_base64_encode(up->password, (int)strlen(up->password), &pw64) == -1
+                            || openvpn_base64_encode(response, (int)strlen(response), &resp64) == -1)
                         {
                             msg(M_FATAL, "ERROR: could not base64-encode password/static_response");
                         }
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 054cc79..9d8fe75 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -229,7 +229,7 @@
 uint8_t *
 make_base64_string(const uint8_t *str, struct gc_arena *gc)
 {
-    return make_base64_string2(str, strlen((const char *)str), gc);
+    return make_base64_string2(str, (int)strlen((const char *)str), gc);
 }
 
 static const char *
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 635b53c..23c1e78 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -754,7 +754,7 @@
     char *src_b64 = NULL;
     char *dst_b64 = NULL;
 
-    if (!management || (openvpn_base64_encode(src, src_len, &src_b64) <= 0))
+    if (!management || (openvpn_base64_encode(src, (int)src_len, &src_b64) <= 0))
     {
         goto cleanup;
     }
@@ -768,7 +768,7 @@
         goto cleanup;
     }
 
-    if (openvpn_base64_decode(dst_b64, dst, dst_len) != dst_len)
+    if (openvpn_base64_decode(dst_b64, dst, (int)dst_len) != dst_len)
     {
         goto cleanup;
     }

