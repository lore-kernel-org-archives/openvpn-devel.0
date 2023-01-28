From: selva.nair@...277...
Date: Sat, 28 Jan 2023 17:34:21 -0500
Message-Id: <20230128223421.2207802-5-selva.nair@...277...>
In-Reply-To: <20230128223421.2207802-1-selva.nair@...277...>
References: <20230128223421.2207802-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] cryptoapi.c: simplify parsing of
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 44 +++++++++++------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 6ff4fcb5..9fd5aea9 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -210,49 +210,29 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
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
+        int i = 0;
+
+        for (const char *p = cert_prop + 6; *p && i < sizeof(hash); p += 2)
         {
-            if (*p >= '0' && *p <= '9')
-            {
-                x = (*p - '0') << 4;
-            }
-            else if (*p >= 'A' && *p <= 'F')
+            /* skip spaces */
+            while (*p == ' ')
             {
-                x = (*p - 'A' + 10) << 4;
+                p++;
             }
-            else if (*p >= 'a' && *p <= 'f')
+            if (!*p) /* ending with spaces is not an error */
             {
-                x = (*p - 'a' + 10) << 4;
+                break;
             }
-            if (!*++p)  /* unexpected end of string */
+
+            if (!isxdigit(p[0]) || !isxdigit(p[1])
+                || sscanf(p, "%2hhx", &hash[i++]) != 1)
             {
-                msg(M_WARN|M_INFO, "WARNING: cryptoapicert: error parsing <THUMB:%s>.", cert_prop);
+                msg(M_WARN|M_INFO, "WARNING: cryptoapicert: error parsing <%s>.", cert_prop);
                 goto out;
             }
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
         }
         blob.cbData = i;
     }
-- 
2.34.1


