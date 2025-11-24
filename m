From: Gert Doering <gert@...1296...>
Date: Mon, 24 Nov 2025 18:00:50 +0100
Message-ID: <20251124170055.16034-1-gert@...1296...>
In-Reply-To: <gerrit.1763928247000.I69a6ab59d995fb4a511f57c8535b5ffa4048673c@...2715...>
References: <gerrit.1763928247000.I69a6ab59d995fb4a511f57c8535b5ffa4048673c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] iservice: rename one_glyph to glyph_size
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

From: Heiko Hund <heiko@...2662...>

Throughout the function variables which deal with byte counts have a
_size postfix. one_glyph is the number of bytes in one character.
Reading the code is easier and more consistent this way.

Change-Id: I69a6ab59d995fb4a511f57c8535b5ffa4048673c
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1398
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1398
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 23d18aa..3d5f305 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2156,14 +2156,14 @@
 
     LSTATUS err = ERROR_FILE_NOT_FOUND;
     const DWORD buf_size = *size;
-    const size_t one_glyph = sizeof(*domains);
+    const size_t glyph_size = sizeof(*domains);
     PWSTR values[] = { L"SearchList", L"Domain", L"DhcpDomainSearchList", L"DhcpDomain", NULL };
 
     for (int i = 0; values[i]; i++)
     {
         *size = buf_size;
         err = RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (PBYTE)domains, size);
-        if (!err && *size > one_glyph && domains[(*size / one_glyph) - 1] == '\0' && wcschr(domains, '.'))
+        if (!err && *size > glyph_size && domains[(*size / glyph_size) - 1] == '\0' && wcschr(domains, '.'))
         {
             /*
              * Found domain(s), now convert them:
@@ -2171,7 +2171,7 @@
              *   - convert comma separated list to MULTI_SZ
              */
             PWCHAR pos = domains;
-            const DWORD buf_len = buf_size / one_glyph;
+            const DWORD buf_len = buf_size / glyph_size;
             while (TRUE)
             {
                 /* Terminate the domain at the next comma */
@@ -2182,8 +2182,8 @@
                 }
 
                 size_t domain_len = wcslen(pos);
-                size_t domain_size = domain_len * one_glyph;
-                size_t converted_size = (pos - domains) * one_glyph;
+                size_t domain_size = domain_len * glyph_size;
+                size_t converted_size = (pos - domains) * glyph_size;
 
                 /* Ignore itf domains which match a pushed search domain */
                 if (ListContainsDomain(search_domains, pos, domain_len))
@@ -2192,7 +2192,7 @@
                     {
                         /* Overwrite the ignored domain with remaining one(s) */
                         memmove(pos, comma + 1, buf_size - converted_size);
-                        *size -= domain_size + one_glyph;
+                        *size -= domain_size + glyph_size;
                         continue;
                     }
                     else
@@ -2206,31 +2206,31 @@
 
                 /* Add space for the leading dot */
                 domain_len += 1;
-                domain_size += one_glyph;
+                domain_size += glyph_size;
 
                 /* Space for the terminating zeros */
-                size_t extra_size = 2 * one_glyph;
+                size_t extra_size = 2 * glyph_size;
 
                 /* Check for enough space to convert this domain */
                 if (converted_size + domain_size + extra_size > buf_size)
                 {
                     /* Domain doesn't fit, bad luck if it's the first one */
                     *pos = '\0';
-                    *size = converted_size == 0 ? 0 : converted_size + one_glyph;
+                    *size = converted_size == 0 ? 0 : converted_size + glyph_size;
                     return ERROR_MORE_DATA;
                 }
 
                 /* Prefix domain at pos with the dot */
-                memmove(pos + 1, pos, buf_size - converted_size - one_glyph);
+                memmove(pos + 1, pos, buf_size - converted_size - glyph_size);
                 domains[buf_len - 1] = '\0';
                 *pos = '.';
-                *size += one_glyph;
+                *size += glyph_size;
 
                 if (!comma)
                 {
                     /* Conversion is done */
                     *(pos + domain_len) = '\0';
-                    *size += one_glyph;
+                    *size += glyph_size;
                     return NO_ERROR;
                 }
 

