From: Gert Doering <gert@...1296...>
Date: Sun, 23 Nov 2025 12:37:42 +0100
Message-ID: <20251123113747.17739-1-gert@...1296...>
In-Reply-To: <gerrit.1763880426000.I8b26c65415f5a751f416d80a22cbb7ff14aa27c0@...2715...>
References: <gerrit.1763880426000.I8b26c65415f5a751f416d80a22cbb7ff14aa27c0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] iservice: make sure buffer size is not
 zero
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

GetItfDnsDomains expects a non-zero size buffer to return the domains
in. Check for the size as well, not just for a valid pointer.

Change-Id: I8b26c65415f5a751f416d80a22cbb7ff14aa27c0
Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1389
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1389
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index f64c247..d778e89 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2149,7 +2149,7 @@
 static LSTATUS
 GetItfDnsDomains(HKEY itf, PCWSTR search_domains, PWSTR domains, PDWORD size)
 {
-    if (domains == NULL || size == 0)
+    if (domains == NULL || size == NULL || *size == 0)
     {
         return ERROR_INVALID_PARAMETER;
     }

