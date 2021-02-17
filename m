From: selva.nair@...277...
Date: Tue, 16 Feb 2021 19:04:35 -0500
Message-Id: <1613520275-28637-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Quote the domain name argument passed to
 the wmic command
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

It appears wmic needs domain names containing hyphens to
be quoted.

Trac #1375

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 65bb106..5d5cbfe 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1104,7 +1104,7 @@ wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
     }
     else
     {
-       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %s %s";
+       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %s \"%s\"";
     }
 
     size_t ncmdline = wcslen(fmt) + 20 + wcslen(action) /* max 20 for ifindex */
-- 
2.1.4


