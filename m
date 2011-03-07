MIME-Version: 1.0
From: Joe Patterson <j.m.patterson@...277...>
Date: Mon, 7 Mar 2011 11:44:50 -0500
Message-ID: <AANLkTinSNNNtmS78KquJbmA81eZdxubr1rdZcKHD0Y0n@...278...>
Subject: [Openvpn-devel] [PATCH] common_name passing in auth_pam plugin
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
To: openvpn-devel@lists.sourceforge.net

I had wanted to have the capability of forcing users to match their
username with their cert common name.  It's possible to do this using
the environment variables passed to an auth script, but I figured it
would be useful to add the capability to the auth_pam plugin.  It
would be nice to be able to pass arbitrary strings from envp to pam so
that you could, for instance, use an OU to hold a domain or realm name
or some such, but for now I'm just passing the common_name and using
it to replace "COMMONNAME", much as the USERNAME and PASSWORD strings
get replaced in the pam auth dialog.  Here's the patch for the 2.1.3i
source I pulled from svn (apologies if this format isn't as it should
be, I seldom submit code anywhere):

Index: openvpn/plugin/auth-pam/README
===================================================================
--- openvpn/plugin/auth-pam/README    (revision 7003)
+++ openvpn/plugin/auth-pam/README    (working copy)
@@ -48,7 +48,7 @@

   plugin openvpn-auth-pam.so "test name USERNAME password PASSWORD"

-While "USERNAME" and "PASSWORD" are special strings which substitute
+While "USERNAME" "COMMONNAME" and "PASSWORD" are special strings
which substitute
 to client-supplied values, it is also possible to name literal values
 to use as PAM module query responses.  For example, suppose that the
 login module queried for a third parameter, "domain" which
Index: openvpn/plugin/auth-pam/auth-pam.c
===================================================================
--- openvpn/plugin/auth-pam/auth-pam.c    (revision 7003)
+++ openvpn/plugin/auth-pam/auth-pam.c    (working copy)
@@ -81,6 +81,7 @@
  *
  *  "USERNAME" -- substitute client-supplied username
  *  "PASSWORD" -- substitute client-specified password
+ *  "COMMONNAME" -- substitute client certificate common name
  */

 #define N_NAME_VALUE 16
@@ -104,6 +105,7 @@

   char username[128];
   char password[128];
+  char common_name[128];

   const struct name_value_list *name_value_list;
 };
@@ -441,12 +443,14 @@
       /* get username/password from envp string array */
       const char *username = get_env ("username", envp);
       const char *password = get_env ("password", envp);
+      const char *common_name = get_env ("common_name", envp) ?
get_env ("common_name", envp) : "";

       if (username && strlen (username) > 0 && password)
     {
       if (send_control (context->foreground_fd, COMMAND_VERIFY) == -1
           || send_string (context->foreground_fd, username) == -1
-          || send_string (context->foreground_fd, password) == -1)
+          || send_string (context->foreground_fd, password) == -1
+          || send_string (context->foreground_fd, common_name) == -1)
         {
           fprintf (stderr, "AUTH-PAM: Error sending auth info to
background process\n");
         }
@@ -563,6 +567,8 @@
             return_value = up->username;
           else if (!strcmp (match_value, "PASSWORD"))
             return_value = up->password;
+                  else if (!strcmp (match_value, "COMMONNAME"))
+                    return_value = up->common_name;
           else
             return_value = match_value;

@@ -709,7 +715,8 @@
     {
     case COMMAND_VERIFY:
       if (recv_string (fd, up.username, sizeof (up.username)) == -1
-          || recv_string (fd, up.password, sizeof (up.password)) == -1)
+          || recv_string (fd, up.password, sizeof (up.password)) == -1
+        || recv_string (fd, up.common_name, sizeof (up.common_name)) == -1)
         {
           fprintf (stderr, "AUTH-PAM: BACKGROUND: read error on
command channel: code=%d, exiting\n",
                command);

