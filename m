MIME-Version: 1.0
In-Reply-To: <4D87C556.3000606@...1114...>
References: <AANLkTinSNNNtmS78KquJbmA81eZdxubr1rdZcKHD0Y0n@...278...>
	<4D87C556.3000606@...1114...>
From: Joe Patterson <j.m.patterson@...277...>
Date: Mon, 21 Mar 2011 18:07:19 -0400
Message-ID: <AANLkTi=_QkRWUYO5R_NDhAUty+Q1ckPdTrB=9bsUUUD9@...278...>
Subject: Re: [Openvpn-devel] [PATCH] common_name passing in auth_pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

[PATCH] -added the ability to have "COMMONNAME" replaced
  with certificate common name in pam conversation

Signed-off-by: Joe Patterson <j.m.patterson@...277...>
---
 plugin/auth-pam/README     |    2 +-
 plugin/auth-pam/auth-pam.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/plugin/auth-pam/README b/plugin/auth-pam/README
index c957c02..e123690 100644
--- a/plugin/auth-pam/README
+++ b/plugin/auth-pam/README
@@ -48,7 +48,7 @@ For example, suppose you were using a PAM module called

   plugin openvpn-auth-pam.so "test name USERNAME password PASSWORD"

-While "USERNAME" and "PASSWORD" are special strings which substitute
+While "USERNAME" "COMMONNAME" and "PASSWORD" are special strings
which substitute
 to client-supplied values, it is also possible to name literal values
 to use as PAM module query responses.  For example, suppose that the
 login module queried for a third parameter, "domain" which
diff --git a/plugin/auth-pam/auth-pam.c b/plugin/auth-pam/auth-pam.c
index 5a8e269..8719c30 100644
--- a/plugin/auth-pam/auth-pam.c
+++ b/plugin/auth-pam/auth-pam.c
@@ -81,6 +81,7 @@ struct auth_pam_context
  *
  *  "USERNAME" -- substitute client-supplied username
  *  "PASSWORD" -- substitute client-specified password
+ *  "COMMONNAME" -- substitute client certificate common name
  */

 #define N_NAME_VALUE 16
@@ -104,6 +105,7 @@ struct user_pass {

   char username[128];
   char password[128];
+  char common_name[128];

   const struct name_value_list *name_value_list;
 };
@@ -470,12 +472,14 @@ openvpn_plugin_func_v1 (openvpn_plugin_handle_t
handle, const int type, const ch
       /* get username/password from envp string array */
       const char *username = get_env ("username", envp);
       const char *password = get_env ("password", envp);
+      const char *common_name = get_env ("common_name", envp) ?
get_env ("common_name", envp) : "";

       if (username && strlen (username) > 0 && password)
 	{
 	  if (send_control (context->foreground_fd, COMMAND_VERIFY) == -1
 	      || send_string (context->foreground_fd, username) == -1
-	      || send_string (context->foreground_fd, password) == -1)
+	      || send_string (context->foreground_fd, password) == -1
+              || send_string (context->foreground_fd, common_name) == -1)
 	    {
 	      fprintf (stderr, "AUTH-PAM: Error sending auth info to
background process\n");
 	    }
@@ -592,6 +596,8 @@ my_conv (int n, const struct pam_message **msg_array,
 		    aresp[i].resp = searchandreplace(match_value, "USERNAME", up->username);
 		  else if (strstr(match_value, "PASSWORD"))
 		    aresp[i].resp = searchandreplace(match_value, "PASSWORD", up->password);
+		  else if (strstr(match_value, "COMMONNAME"))
+		    aresp[i].resp = searchandreplace(match_value, "COMMONNAME",
up->common_name);
 		  else
 		    aresp[i].resp = strdup (match_value);

@@ -737,7 +743,8 @@ pam_server (int fd, const char *service, int verb,
const struct name_value_list
 	{
 	case COMMAND_VERIFY:
 	  if (recv_string (fd, up.username, sizeof (up.username)) == -1
-	      || recv_string (fd, up.password, sizeof (up.password)) == -1)
+	      || recv_string (fd, up.password, sizeof (up.password)) == -1
+	      || recv_string (fd, up.common_name, sizeof (up.common_name)) == -1)
 	    {
 	      fprintf (stderr, "AUTH-PAM: BACKGROUND: read error on command
channel: code=%d, exiting\n",
 		       command);
-- 
1.6.0.4

