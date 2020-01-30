From: selva.nair@...277...
Date: Thu, 30 Jan 2020 07:43:28 -0500
Message-Id: <1580388208-26594-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Swap the order of checks for validating
 interactive service user
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

Check the config file location and command line options first
and membership in OpenVPNAdministrators group after that as
the latter could be a slow process for active directory users.

When connection to domain controllers is poor or unavailable, checking
the group membership is slow and causes timeouts in the GUI (Trac
1051). However, in cases where the config is in the global directory,
no group membership check should be required. The re-ordering here
avoids the redundant check in such cases.

In addition to this, its also proposed to improve the timeout handling
in the GUI, but this change is still useful as it should completely
eliminate the timeout issue for many users.

Also see: https://github.com/OpenVPN/openvpn-gui/issues/332

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 6e72a14..dafd5c6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1581,8 +1581,8 @@ RunOpenvpn(LPVOID p)
     }
 
     /* Check user is authorized or options are white-listed */
-    if (!IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn_admin_group)
-        && !ValidateOptions(pipe, sud.directory, sud.options))
+    if (!ValidateOptions(pipe, sud.directory, sud.options)
+        && !IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn_admin_group)
     {
         goto out;
     }
-- 
2.1.4


