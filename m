From: Tim Small <tim@...2042...>
Date: Wed,  8 Jul 2015 22:37:33 +0100
Message-Id: <1436391455-4671-3-git-send-email-tim@...2042...>
In-Reply-To: <1436391455-4671-1-git-send-email-tim@...2042...>
References: <1436391455-4671-1-git-send-email-tim@...2042...>
Subject: [Openvpn-devel] [PATCH 2/4] Factor out name/val list walk,
	add default password reply.
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

If the user doesn't supply any arguments to the plugin in the OpenVPN
configuration file, then it defaults to answering any PAM conversation
'questions' where the pam module sets the message style to
PAM_PROMPT_ECHO_OFF with the password, and where the style is set to
PAM_PROMPT_ECHO_ON with the username.

If the administrator supplies one or more arguments to the auth-pam
plugin, then this simple but robust default behaviour is abandoned,
and the user must supply a match for the message text content (NOT the
message style) for ALL messages.  Non-matching messages are answered
with a NULL.

This patch restores the default behaviour for PAM_PROMPT_ECHO_OFF
style questions, and returns the password if no prior match has been
found from the explicit list which the administrator specified.  The
aim is to make the default behaviour less surprising for the user, and
also to make deployments less likely to break from changes in what are
indended to be human-readable messages (and which may change due to
e.g. localisation coverage improvements).

Signed-off-by: Tim Small <tim@...2042...>
---
 src/plugins/auth-pam/auth-pam.c | 107 ++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 36 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index fd46b99..e0dc029 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -538,6 +538,53 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
 }
 
 /*
+ * Key value pair list search with USERNAME/COMMONNAME/PASSWORD
+ * substitution.  Callee must arrange to free() the response.
+ */
+
+int
+get_value_with_subst (struct user_pass const *up, const char * const search_term, char **response)
+{
+  int ret = PAM_CONV_ERR;
+  int j;
+  const struct name_value_list *list = up->name_value_list;
+  /* loop through name/value pairs */
+  for (j = 0; j < list->len; ++j)
+    {
+      const char *item_key = list->data[j].name;
+      const char *item_value = list->data[j].value;
+
+      if (name_value_match (search_term, item_key))
+	{
+	  /* found name/value match */
+	  *response = NULL;
+
+	  if (DEBUG (up->verb))
+	    fprintf (stderr, "AUTH-PAM: BACKGROUND: name match found, query/match-string ['%s', '%s'] = '%s'\n",
+		     search_term,
+		     item_key,
+		     item_value);
+
+	  if (strstr(item_value, "USERNAME"))
+	    *response = searchandreplace(item_value, "USERNAME", up->username);
+	  else if (strstr(item_value, "PASSWORD"))
+	    *response = searchandreplace(item_value, "PASSWORD", up->password);
+	  else if (strstr(item_value, "COMMONNAME"))
+	    *response = searchandreplace(item_value, "COMMONNAME", up->common_name);
+	  else
+	    *response = strdup (item_value);
+
+	  if (*response != NULL)
+	    ret = PAM_SUCCESS;
+	  break;
+	}
+    }
+  return ret;
+}
+
+
+
+/*
  * PAM conversation function
  */
 static int
@@ -574,47 +621,35 @@ my_conv (int n, const struct pam_message **msg_array,
       if (up->name_value_list && up->name_value_list->len > 0)
 	{
 	  /* use name/value list match method */
-	  const struct name_value_list *list = up->name_value_list;
-	  int j;
-
-	  /* loop through name/value pairs */
-	  for (j = 0; j < list->len; ++j)
-	    {
-	      const char *match_name = list->data[j].name;
-	      const char *match_value = list->data[j].value;
-
-	      if (name_value_match (msg->msg, match_name))
-		{
-		  /* found name/value match */
-		  aresp[i].resp = NULL;
-
-		  if (DEBUG (up->verb))
-		    fprintf (stderr, "AUTH-PAM: BACKGROUND: name match found, query/match-string ['%s', '%s'] = '%s'\n",
-			     msg->msg,
-			     match_name,
-			     match_value);
-
-		  if (strstr(match_value, "USERNAME"))
-		    aresp[i].resp = searchandreplace(match_value, "USERNAME", up->username);
-		  else if (strstr(match_value, "PASSWORD"))
-		    aresp[i].resp = searchandreplace(match_value, "PASSWORD", up->password);
-		  else if (strstr(match_value, "COMMONNAME"))
-		    aresp[i].resp = searchandreplace(match_value, "COMMONNAME", up->common_name);
-		  else
-		    aresp[i].resp = strdup (match_value);
-
-		  if (aresp[i].resp == NULL)
-		    ret = PAM_CONV_ERR;
-		  break;
+	  ret = get_value_with_subst (up, msg->msg, &(aresp[i].resp));
+	  if (ret == PAM_CONV_ERR)
+            {
+	      /*
+	       * No match for requested message, but the pam module asked
+	       * that the user-entered-data for this response shouldn't be
+	       * displayed, so we will provide the password.  If the user
+	       * doesn't want this behaviour they can add an explicit
+	       * match for this pam message, and return something else.
+	       */
+	      if (msg->msg_style == PAM_PROMPT_ECHO_OFF)
+	        {
+                  if (DEBUG (up->verb))
+                    fprintf (stderr, "AUTH-PAM: BACKGROUND: Got non-matching request for "
+			     "'%s' with style set to PAM_PROMPT_ECHO_OFF - "
+			     "sending password...\n", msg->msg);
+                  aresp[i].resp = strdup (up->password);
+		  if (aresp[i].resp != NULL)
+		    ret = PAM_SUCCESS;
+		} else {
+                  if (DEBUG (up->verb))
+	            fprintf (stderr, "AUTH-PAM: BACKGROUND: Failed to find a match for "
+			     "'%s' which was requested by pam module.\n", msg->msg);
 		}
 	    }
-
-	  if (j == list->len)
-	    ret = PAM_CONV_ERR;
 	}
       else
 	{
-	  /* use PAM_PROMPT_ECHO_x hints */
+	  /* no name/value list provided, rely on PAM_PROMPT_ECHO_x hints */
 	  switch (msg->msg_style)
 	    {
 	    case PAM_PROMPT_ECHO_OFF:
-- 
2.1.4


