From: Gert Doering <gert@...1296...>
Date: Wed, 26 Nov 2025 11:43:07 +0100
Message-ID: <20251126104315.4776-1-gert@...1296...>
In-Reply-To: <gerrit.1763880426000.Iabad046c930dd0f38ec50d1c43d8b3288816df7d@...2715...>
References: <gerrit.1763880426000.Iabad046c930dd0f38ec50d1c43d8b3288816df7d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] iservice: return correct size when
 domains are truncated
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

In case not all domains can be converted in the available buffer, return
the size of the already converted domains size plus the second terminating
zero for the MULTI_SZ.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: Iabad046c930dd0f38ec50d1c43d8b3288816df7d
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1391
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1391
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 9c533c1..5fb7f2b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2214,7 +2214,7 @@
                 {
                     /* Domain doesn't fit, bad luck if it's the first one */
                     *pos = '\0';
-                    *size = converted_size == 0 ? 0 : *size + 1;
+                    *size = converted_size == 0 ? 0 : converted_size + one_glyph;
                     return ERROR_MORE_DATA;
                 }
 

