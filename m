From: selva.nair@...277...
Date: Wed, 19 Oct 2022 18:46:42 -0400
Message-Id: <20221019224642.11178-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH for 2.5/2.6] Purge auth-token as well while
 purging passwords
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

Starting from commit e61b401a auth-token is saved in a separate struct
from auth-user-pass and is not cleared when ssl_purge_auth() is called.
This makes "forget-passwords" sent to the management
interface or "--management-forget-disconnect" option not to work
as expected.

Purging caused by --auth-nocache is not affected
(auth-token is retained in that case as it should be).

Use case:
For Pre-Logon access and persistent connections on Windows, use of
"forget-passwords" before disconnect is probably the only way to
ensure that no credentials are left behind. Note that openvpn.exe
continues to run after disconnect in these cases.

Also, the original intent of "forget-passwords" appears to be to
clear all "passwords" that can be used to reconnect.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/ssl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d9b21819..4c0d78a1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -492,6 +492,7 @@ ssl_purge_auth(const bool auth_user_pass_only)
         purge_user_pass(&passbuf, true);
     }
     purge_user_pass(&auth_user_pass, true);
+    purge_user_pass(&auth_token, true);
 #ifdef ENABLE_MANAGEMENT
     ssl_purge_auth_challenge();
 #endif
-- 
2.30.2


