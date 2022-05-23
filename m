From: Arne Schwabe <arne@...1227...>
Date: Mon, 23 May 2022 11:17:24 +0200
Message-Id: <20220523091724.3418887-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix client-pending-auth error message to
 say ERROR instead of SUCCESS
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

---
 src/openvpn/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index aeea5f9ff..9c07bf298 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -989,7 +989,7 @@ man_client_pending_auth(struct management *man, const char *cid_str,
             }
             else
             {
-                msg(M_CLIENT, "SUCCESS: client-pending-auth command failed."
+                msg(M_CLIENT, "ERROR: client-pending-auth command failed."
                     " Extra paramter might be too long");
             }
         }
-- 
2.32.0 (Apple Git-132)


