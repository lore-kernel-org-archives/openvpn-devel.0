From: Tim Small <tim@...2042...>
Date: Mon, 13 Jul 2015 16:57:55 +0100
Message-Id: <1436803076-22008-6-git-send-email-tim@...2042...>
In-Reply-To: <1436803076-22008-1-git-send-email-tim@...2042...>
References: <1436803076-22008-1-git-send-email-tim@...2042...>
In-Reply-To: <1436391455-4671-1-git-send-email-tim@...2042...>
References: <1436391455-4671-1-git-send-email-tim@...2042...>
Subject: [Openvpn-devel] [PATCH v2 5/6] Allow administrator to supply a user
	to pam_start
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

If the user doesn't supply any arguments to the plugin in the OpenVPN
configuration file, then it defaults to setting the second argument to
the pam_start() function with the username that the other end of the
vpn supplied.  The pam libraries use this as the initial value for the
PAM_USER pam 'item'.

If the administrator supplies one or more arguments to the auth-pam
plugin, then this default behaviour is abandoned, and the user argument
is set to NULL.  The administrator must then supply a match for the
message text content which the pam module will (hopefully) supply in
order to try to discover the message (some pam modules will just give
up at this stage, and fail the authentication e.g. Google Authenticator
will fail if PAM_USER is set to NULL).

The message text which the pam module supplies is intended to be read
by a human, not parsed by other code (as is the current behaviour of
the plugin), and as such may be subject to change (e.g. because of
localisation changes etc.).

This patch allows the user to supply a value for the second argument of
pam_start, if they have supplied any arguments (by using the special
value of 'PAM_USER' as the question message).  This allows operation
with inflexible pam modules, and also decreases the likelihood that
other system changes (e.g. localisation changes, package updates etc.)
will break an existing OpenVPN setup.

Signed-off-by: Tim Small <tim@...2042...>
---
 src/plugins/auth-pam/auth-pam.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 48279cd..2d0f4d0 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -699,11 +699,27 @@ pam_auth (const char *service, const struct user_pass *up)
   int status;
   int ret = 0;
   const int name_value_list_provided = (up->name_value_list && up->name_value_list->len > 0);
+  char *pam_user = NULL;
+  if (name_value_list_provided)
+    {
+      if (get_value_with_subst (up, "PAM_USER", &pam_user))
+        {
+          if (DEBUG (up->verb))
+            fprintf (stderr, "Passing user '%s' in pam_start\n", pam_user);
+        }
+      else
+        {
+          if (DEBUG (up->verb))
+            fprintf (stderr, "User didn't specify value for user argument to pam_start()\n");
+        }
+    }
 
   /* Initialize PAM */
   conv.conv = my_conv;
   conv.appdata_ptr = (void *)up;
-  status = pam_start (service, name_value_list_provided ? NULL : up->username, &conv, &pamh);
+  status = pam_start (service, name_value_list_provided ? pam_user : up->username, &conv, &pamh);
+  if (pam_user)
+    free(pam_user);
   if (status != PAM_SUCCESS)
     {
       fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' / commonname '%s' "
-- 
2.1.4


