From: Gert Doering <gert@...1296...>
Date: Wed, 26 Nov 2025 11:47:01 +0100
Message-ID: <20251126104706.5378-1-gert@...1296...>
In-Reply-To: <gerrit.1763880426000.I02e2c7b27b5a39b11556e4753c648baa05344ffc@...2715...>
References: <gerrit.1763880426000.I02e2c7b27b5a39b11556e4753c648baa05344ffc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] iservice: handle ignoring itf domains
 correctly
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

GetItfDnsDomains() does ignore domains, which are in the search domains
list. Handling of this was done wrong if there was more than one
interface domain. In any case the size returned to the caller was
calculated wrong.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: I02e2c7b27b5a39b11556e4753c648baa05344ffc
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1394
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1394
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5fb7f2b..31a7ffa 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2190,14 +2190,16 @@
                 {
                     if (comma)
                     {
-                        pos = comma + 1;
+                        /* Overwrite the ignored domain with remaining one(s) */
+                        memmove(pos, comma + 1, buf_size - converted_size);
+                        *size -= domain_size + one_glyph;
                         continue;
                     }
                     else
                     {
                         /* This was the last domain */
                         *pos = '\0';
-                        *size += one_glyph;
+                        *size -= domain_size;
                         return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
                     }
                 }

