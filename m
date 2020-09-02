From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  2 Sep 2020 16:37:55 +0300
Message-Id: <20200902133755.308-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] openvpnmsica: make adapter renaming
 non-fatal
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

For some users renaming adapter mysteriously fails
(https://github.com/OpenVPN/openvpn-build/issues/187),

Since renaming is just a a "nice to have", make it not fatail.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/openvpnmsica.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 31e90bd2..d5b3f09e 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -1100,7 +1100,8 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
                 dwResult = tap_set_adapter_name(&guidAdapter, szName);
                 if (dwResult != ERROR_SUCCESS)
                 {
-                    tap_delete_adapter(NULL, &guidAdapter, &bRebootRequired);
+                    /* failed renaming is not a fatal error, continue */
+                    dwResult = ERROR_SUCCESS;
                 }
             }
         }
-- 
2.17.1


