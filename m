From: selva.nair@...277...
Date: Wed, 26 Oct 2022 14:55:43 -0400
Message-Id: <20221026185543.5378-1-selva.nair@...277...>
In-Reply-To: <20221019224642.11178-1-selva.nair@...277...>
References: <20221019224642.11178-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 for 2.5/2.6] Purge auth-token as well
 while purging passwords
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

v2:
- call ssl_clean_auth_token() directly from manage.c instead
  of amending ssl_purge_auth()
- Add a comment that ssl_purge_auth() does not clear auth-token

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/manage.c | 2 ++
 src/openvpn/ssl.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5670e594..5b288eab 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -762,6 +762,7 @@ static void
 man_forget_passwords(struct management *man)
 {
     ssl_purge_auth(false);
+    (void)ssl_clean_auth_token();
     msg(M_CLIENT, "SUCCESS: Passwords were forgotten");
 }
 
@@ -1922,6 +1923,7 @@ man_reset_client_socket(struct management *man, const bool exiting)
         if (man->settings.flags & MF_FORGET_DISCONNECT)
         {
             ssl_purge_auth(false);
+            (void)ssl_clean_auth_token();
         }
 
         if (man->settings.flags & MF_SIGNAL)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 9ae6ae8f..94137b23 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -390,6 +390,7 @@ void ssl_set_auth_nocache(void);
 /*
  * Purge any stored authentication information, both for key files and tunnel
  * authentication. If PCKS #11 is enabled, purge authentication for that too.
+ * Note that auth_token is not cleared.
  */
 void ssl_purge_auth(const bool auth_user_pass_only);
 
-- 
2.30.2


