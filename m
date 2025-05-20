From: Gert Doering <gert@...1296...>
Date: Tue, 20 May 2025 10:55:06 +0200
Message-ID: <20250520085513.28213-1-gert@...1296...>
In-Reply-To: <gerrit.1747725275000.Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1@...2715...>
References: <gerrit.1747725275000.Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] win: fix collecting DNS exclude data
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

The size of the returned MULTI_SZ wide domains string was calculated
wrongly. Instead of adding the size of a WCHAR, only the size of a char
was used. As a result, the domains string was stored too short and was
missing the final string terminator.

DHCP assigned DNS server addresses are separated by space, not comma.
These spaces were not replaced by semicolon, as the spec requires.

Fixes: OpenVPN/openvpn#747
Change-Id: Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1028
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a1581a6..bea8277 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2226,7 +2226,7 @@
                     {
                         /* This was the last domain */
                         *pos = '\0';
-                        *size += 1;
+                        *size += one_glyph;
                         return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
                     }
                 }
@@ -2248,13 +2248,13 @@
                 memmove(pos + 1, pos, buf_size - converted_size - one_glyph);
                 domains[buf_len - 1] = '\0';
                 *pos = '.';
-                *size += 1;
+                *size += one_glyph;
 
                 if (!comma)
                 {
                     /* Conversion is done */
                     *(pos + domain_len) = '\0';
-                    *size += 1;
+                    *size += one_glyph;
                     return NO_ERROR;
                 }
 
@@ -2409,10 +2409,10 @@
 
         if (v4_addrs_size || v6_addrs_size)
         {
-            /* Replace comma-delimters with semicolons, as required by NRPT */
+            /* Replace delimters with semicolons, as required by NRPT */
             for (int j = 0; j < sizeof(data[0].addresses) && data[i].addresses[j]; j++)
             {
-                if (data[i].addresses[j] == ',')
+                if (data[i].addresses[j] == ',' || data[i].addresses[j] == ' ')
                 {
                     data[i].addresses[j] = ';';
                 }

