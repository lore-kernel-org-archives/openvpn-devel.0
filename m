From: Selva Nair <selva.nair@...277...>
Date: Thu, 26 Nov 2015 00:15:32 -0500
Message-Id: <1448514932-13023-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH take2] Unbreak read username password from
	management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Commit 6e9373c846.. introduced a bug by which auth-user-pass
input falls back to read-from-stdin after successfully reading
from management.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/misc.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index b6c8854..d4c6f6c 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1020,6 +1020,9 @@ get_user_pass_cr (struct user_pass *up,
 	{
 	  const char *sc = NULL;
 
+          username_from_stdin = false;
+          password_from_stdin = false;
+
 	  if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	    management_auth_failure (management, prefix, "previous auth credentials failed");
 
-- 
1.7.10.4


