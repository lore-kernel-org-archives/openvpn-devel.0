From: Gert Doering <gert@...1296...>
Date: Sun, 23 Nov 2025 13:00:23 +0100
Message-ID: <20251123120029.19736-1-gert@...1296...>
In-Reply-To: <gerrit.1763880426000.Icd7c7b08e317aefd91a60bfc62e92cd8707b6fac@...2715...>
References: <gerrit.1763880426000.Icd7c7b08e317aefd91a60bfc62e92cd8707b6fac@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] iservice: check for NULL pointer
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

Check if the list argument to ListContainsDomain() is NULL. Otherwise
the call to wcsstr() will bail out.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: Icd7c7b08e317aefd91a60bfc62e92cd8707b6fac
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1393
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1393
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ec80a30..006f748 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2106,7 +2106,7 @@
 ListContainsDomain(PCWSTR list, PCWSTR domain, size_t len)
 {
     PCWSTR match = list;
-    while (TRUE)
+    while (match)
     {
         match = wcsstr(match, domain);
         if (!match)

