From: Tim Small <tim@...2042...>
Date: Mon, 13 Jul 2015 16:57:52 +0100
Message-Id: <1436803076-22008-3-git-send-email-tim@...2042...>
In-Reply-To: <1436803076-22008-1-git-send-email-tim@...2042...>
References: <1436803076-22008-1-git-send-email-tim@...2042...>
In-Reply-To: <1436391455-4671-1-git-send-email-tim@...2042...>
References: <1436391455-4671-1-git-send-email-tim@...2042...>
Subject: [Openvpn-devel] [PATCH v2 2/6] Log common name as well as username
	for pam auth
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
Cc: tim@...2043...

Improve debugability by logging the common name as well as the user
name.

Signed-off-by: Tim Small <tim@...2042...>
---
 src/plugins/auth-pam/auth-pam.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 1fa73c1..d6fcda9 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -768,10 +768,11 @@ pam_server (int fd, const char *service, int verb, const struct name_value_list
 	  if (DEBUG (verb))
 	    {
 #if 0
-	      fprintf (stderr, "AUTH-PAM: BACKGROUND: USER/PASS: %s/%s\n",
-		       up.username, up.password);
+	      fprintf (stderr, "AUTH-PAM: BACKGROUND: USER/COMMON_NAME/PASS: %s/%s/%s\n",
+		       up.username, up.common_name, up.password);
 #else
-	      fprintf (stderr, "AUTH-PAM: BACKGROUND: USER: %s\n", up.username);
+	      fprintf (stderr, "AUTH-PAM: BACKGROUND: USER/COMMON_NAME: %s/%s\n",
+		       up.username, up.common_name);
 #endif
 	    }
 
-- 
2.1.4


