From: Tim Small <tim@...2042...>
Date: Mon, 13 Jul 2015 16:57:53 +0100
Message-Id: <1436803076-22008-4-git-send-email-tim@...2042...>
In-Reply-To: <1436803076-22008-1-git-send-email-tim@...2042...>
References: <1436803076-22008-1-git-send-email-tim@...2042...>
In-Reply-To: <1436391455-4671-1-git-send-email-tim@...2042...>
References: <1436391455-4671-1-git-send-email-tim@...2042...>
Subject: [Openvpn-devel] [PATCH v2 3/6] Refactor name/value list search and
	substitution code.
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

Pull out the code which searches the name_value_list for a matching
prompt, and also substitutes keywords (USERNAME etc.) into a separate
function, for clarity and to support forthcoming changes.

Signed-off-by: Tim Small <tim@...2042...>
---
 src/plugins/auth-pam/auth-pam.c | 96 +++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 37 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index d6fcda9..722d0cf 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -538,6 +538,58 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
 }
 
 /*
+ * Key value pair list search with USERNAME/COMMONNAME/PASSWORD
+ * substitution.
+ *
+ * Returns 1 if match (with/without substitution) and the first
+ * match (substituted if necessary) in the list is returned in
+ * response. The callee must arrange to free() the response.
+ *
+ * Returns 0 if no match for search_term found in the user_pass
+ * name_value_list, in this case response is left unmodified.
+ */
+
+int
+get_value_with_subst (struct user_pass const *up, const char * const search_term, char **response)
+{
+  int ret = 0;
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
+	    ret = 1;
+	  break;
+	}
+    }
+  return ret;
+}
+
+/*
  * PAM conversation function
  */
 static int
@@ -574,47 +626,17 @@ my_conv (int n, const struct pam_message **msg_array,
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
-		}
+          if (!get_value_with_subst (up, msg->msg, &(aresp[i].resp)))
+            {
+              ret = PAM_CONV_ERR;
+              if (DEBUG (up->verb))
+                fprintf (stderr, "AUTH-PAM: BACKGROUND: Didn't find a match for prompt "
+                             "'%s' which was requested by pam module.\n", msg->msg);
 	    }
-
-	  if (j == list->len)
-	    ret = PAM_CONV_ERR;
 	}
       else
 	{
-	  /* use PAM_PROMPT_ECHO_x hints */
+          /* no name/value list provided, rely on PAM_PROMPT_ECHO_x hints alone */
 	  switch (msg->msg_style)
 	    {
 	    case PAM_PROMPT_ECHO_OFF:
-- 
2.1.4


