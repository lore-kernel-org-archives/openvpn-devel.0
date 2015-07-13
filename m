From: Tim Small <tim@...2042...>
Date: Mon, 13 Jul 2015 16:57:51 +0100
Message-Id: <1436803076-22008-2-git-send-email-tim@...2042...>
In-Reply-To: <1436803076-22008-1-git-send-email-tim@...2042...>
References: <1436803076-22008-1-git-send-email-tim@...2042...>
In-Reply-To: <1436391455-4671-1-git-send-email-tim@...2042...>
References: <1436391455-4671-1-git-send-email-tim@...2042...>
Subject: [Openvpn-devel] [PATCH v2 1/6] Separate error logging for pam auth
	and account
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

The plugin carries out separate checks on authorisation and account
validity, but only prints a single "user X failed to authenticate"
message, even if the PAM authenticate tests pass, but the PAM account
check fails.

Print separate error messages if failure occurs in either step.

Signed-off-by: Tim Small <tim@...2042...>
---
 src/plugins/auth-pam/auth-pam.c | 42 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index bd71792..1fa73c1 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -655,7 +655,7 @@ pam_auth (const char *service, const struct user_pass *up)
 {
   struct pam_conv conv;
   pam_handle_t *pamh = NULL;
-  int status = PAM_SUCCESS;
+  int status;
   int ret = 0;
   const int name_value_list_provided = (up->name_value_list && up->name_value_list->len > 0);
 
@@ -663,23 +663,35 @@ pam_auth (const char *service, const struct user_pass *up)
   conv.conv = my_conv;
   conv.appdata_ptr = (void *)up;
   status = pam_start (service, name_value_list_provided ? NULL : up->username, &conv, &pamh);
-  if (status == PAM_SUCCESS)
+  if (status != PAM_SUCCESS)
     {
-      /* Call PAM to verify username/password */
+      fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' / commonname '%s' "
+          "call to pam_start() didn't return PAM_SUCCESS\n",
+          up->username, up->common_name);
+    }
+  else
+    {
+      /* Call PAM to authenticate the username */
       status = pam_authenticate(pamh, 0);
-      if (status == PAM_SUCCESS)
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
+      if (status != PAM_SUCCESS)
+        {
+          fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' / commonname '%s' "
+                   "failed to authenticate: %s\n"
+                   "... check system auth log for details.\n",
+                   up->username, up->common_name, pam_strerror (pamh, status));
 	}
-
+      else
+        {
+          /* Call PAM to check user's account is valid */
+          status = pam_acct_mgmt (pamh, 0);
+          if (status != PAM_SUCCESS)
+            fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' / commonname '%s' "
+                     "passed pam credential authentication, but failed account validation: %s\n"
+                     "... check system auth log for details.\n",
+                     up->username, up->common_name, pam_strerror (pamh, status));
+          else
+            ret = 1; /* Passed pam authenticate and account management steps */
+        }
       /* Close PAM */
       pam_end (pamh, status);      
     }
-- 
2.1.4


