From: Tim Small <tim@...2042...>
Date: Wed,  8 Jul 2015 22:37:32 +0100
Message-Id: <1436391455-4671-2-git-send-email-tim@...2042...>
In-Reply-To: <1436391455-4671-1-git-send-email-tim@...2042...>
References: <1436391455-4671-1-git-send-email-tim@...2042...>
Subject: [Openvpn-devel] [PATCH 1/4] Add explicit debug statements for pam
	auth and account steps.
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

The plugin carries out separate checks on authorisation and account
validity, but only prints a single "user X failed to authenticate"
message, even if the PAM authenticate tests pass, but the PAM account
check fails.

Also log common name as well as user name.

Signed-off-by: Tim Small <tim@...2042...>
---
 src/plugins/auth-pam/auth-pam.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index bd71792..fd46b99 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -668,16 +668,22 @@ pam_auth (const char *service, const struct user_pass *up)
       /* Call PAM to verify username/password */
       status = pam_authenticate(pamh, 0);
       if (status == PAM_SUCCESS)
-	status = pam_acct_mgmt (pamh, 0);
-      if (status == PAM_SUCCESS)
-	ret = 1;
-
-      /* Output error message if failed */
-      if (!ret)
-	{
-	  fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' failed to authenticate: %s\n",
-		   up->username,
-		   pam_strerror (pamh, status));
+        {
+          status = pam_acct_mgmt (pamh, 0);
+          if (status == PAM_SUCCESS)
+            ret = 1; /* Passed pam authenticate and account management steps */
+	  else
+            fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' / commonname '%s' "
+                     "passed pam credential authentication, but failed account validation: %s\n"
+                     "... check system auth log for details?\n" ,
+                     up->username, up->common_name, pam_strerror (pamh, status));
+        }
+      else
+        {
+          fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' / commonname '%s' "
+                   "failed to authenticate: %s\n"
+		   "... check system auth log for details?\n" ,
+		   up->username, up->common_name, pam_strerror (pamh, status));
 	}
 
       /* Close PAM */
@@ -756,10 +762,11 @@ pam_server (int fd, const char *service, int verb, const struct name_value_list
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


