From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 14 Jul 2023 14:18:02 +0300
Message-Id: <20230714111802.1773-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] manage.c: document missing KID parameter
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commit a261e173 ("Make sending plain text control message session
aware") added KID parameter to "client-pending-auth" management command,
but forgot to mention it in the output of management help.

Change-Id: I201bdaa5fe4020d15a9dd1674aba5e0c45170731
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index d80f9ffd..739ed40f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -106,7 +106,7 @@ man_help(void)
     msg(M_CLIENT, "client-auth-nt CID KID : Authenticate client-id/key-id CID/KID");
     msg(M_CLIENT, "client-deny CID KID R [CR] : Deny auth client-id/key-id CID/KID with log reason");
     msg(M_CLIENT, "                             text R and optional client reason text CR");
-    msg(M_CLIENT, "client-pending-auth CID MSG timeout : Instruct OpenVPN to send AUTH_PENDING and INFO_PRE msg");
+    msg(M_CLIENT, "client-pending-auth CID KID MSG timeout : Instruct OpenVPN to send AUTH_PENDING and INFO_PRE msg");
     msg(M_CLIENT, "                                      to the client and wait for a final client-auth/client-deny");
     msg(M_CLIENT, "client-kill CID [M]    : Kill client instance CID with message M (def=RESTART)");
     msg(M_CLIENT, "env-filter [level]     : Set env-var filter level");
-- 
2.38.1.windows.1


