From: selva.nair@...277...
Date: Fri,  3 Feb 2023 19:43:22 -0500
Message-Id: <20230204004322.250210-1-selva.nair@...277...>
In-Reply-To: <20230128223421.2207802-5-selva.nair@...277...>
References: <20230128223421.2207802-5-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 4/4] cryptoapi.c: simplify parsing of
 thumbprint hex string
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

From: Selva Nair <selva.nair@...277...>

v2: Moved the "parse_hexstring" chunk to a function for clarity
and to permit unit-testing.

A test is submitted as a follow up patch.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 77 ++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index eafef1b1..136c6ffc 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -180,6 +180,39 @@ err:
     return NULL;
 }
 
+/**
+ * Parse a hex string with optional embedded spaces into
+ * a byte array.
+ * @param p         pointer to the input string
+ * @param arr       on output contains the parsed bytes
+ * @param capacity  capacity of the byte array arr
+ * @returns the number of bytes parsed or 0 on error
+ */
+int
+parse_hexstring(const char *p, unsigned char *arr, size_t capacity)
+{
+    int i = 0;
+    for ( ; *p && i < capacity; p += 2)
+    {
+        /* skip spaces */
+        while (*p == ' ')
+        {
+            p++;
+        }
+        if (!*p) /* ending with spaces is not an error */
+        {
+            break;
+        }
+
+        if (!isxdigit(p[0]) || !isxdigit(p[1])
+            || sscanf(p, "%2hhx", &arr[i++]) != 1)
+        {
+            return 0;
+        }
+    }
+    return i;
+}
+
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 {
@@ -210,51 +243,15 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
     }
     else if (!strncmp(cert_prop, "THUMB:", 6))
     {
-        const char *p;
-        int i, x = 0;
         find_type = CERT_FIND_HASH;
         find_param = &blob;
 
-        /* skip the tag */
-        cert_prop += 6;
-        for (p = cert_prop, i = 0; *p && i < sizeof(hash); i++)
+        blob.cbData = parse_hexstring(cert_prop + 6, hash, sizeof(hash));
+        if (blob.cbData == 0)
         {
-            if (*p >= '0' && *p <= '9')
-            {
-                x = (*p - '0') << 4;
-            }
-            else if (*p >= 'A' && *p <= 'F')
-            {
-                x = (*p - 'A' + 10) << 4;
-            }
-            else if (*p >= 'a' && *p <= 'f')
-            {
-                x = (*p - 'a' + 10) << 4;
-            }
-            if (!*++p)  /* unexpected end of string */
-            {
-                msg(M_WARN|M_INFO, "WARNING: cryptoapicert: error parsing <THUMB:%s>.", cert_prop);
-                goto out;
-            }
-            if (*p >= '0' && *p <= '9')
-            {
-                x += *p - '0';
-            }
-            else if (*p >= 'A' && *p <= 'F')
-            {
-                x += *p - 'A' + 10;
-            }
-            else if (*p >= 'a' && *p <= 'f')
-            {
-                x += *p - 'a' + 10;
-            }
-            hash[i] = x;
-            /* skip any space(s) between hex numbers */
-            for (p++; *p && *p == ' '; p++)
-            {
-            }
+            msg(M_WARN|M_INFO, "WARNING: cryptoapicert: error parsing <%s>.", cert_prop);
+            goto out;
         }
-        blob.cbData = i;
     }
     else
     {
-- 
2.34.1


