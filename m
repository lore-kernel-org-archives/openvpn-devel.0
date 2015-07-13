From: Tim Small <tim@...2042...>
Date: Mon, 13 Jul 2015 16:57:54 +0100
Message-Id: <1436803076-22008-5-git-send-email-tim@...2042...>
In-Reply-To: <1436803076-22008-1-git-send-email-tim@...2042...>
References: <1436803076-22008-1-git-send-email-tim@...2042...>
In-Reply-To: <1436391455-4671-1-git-send-email-tim@...2042...>
References: <1436391455-4671-1-git-send-email-tim@...2042...>
Subject: [Openvpn-devel] [PATCH v2 4/6] Add default password reply with
	name_value_list
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
configuration file, then it defaults to answering any PAM conversation
'questions' where the pam module sets the message style to
PAM_PROMPT_ECHO_OFF with the password, and where the style is set to
PAM_PROMPT_ECHO_ON with the username.

If the administrator supplies one or more arguments to the auth-pam
plugin, then this simple but robust default behaviour is abandoned,
and the user must supply a match for the message text content (NOT the
message style) for ALL messages.  Non-matching messages are answered
with a NULL.

This patch returns the password for PAM_PROMPT_ECHO_OFF style questions,
if no prior match has been found from the explicit list which the
administrator specified.  The aim is to make the default behaviour less
surprising for the user, and also to make deployments less likely to
break from changes in what are indended to be human-readable messages
(and which may change due to e.g. localisation coverage improvements).

Signed-off-by: Tim Small <tim@...2042...>
---
 src/plugins/auth-pam/auth-pam.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 722d0cf..48279cd 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -628,10 +628,29 @@ my_conv (int n, const struct pam_message **msg_array,
 	  /* use name/value list match method */
           if (!get_value_with_subst (up, msg->msg, &(aresp[i].resp)))
             {
-              ret = PAM_CONV_ERR;
               if (DEBUG (up->verb))
                 fprintf (stderr, "AUTH-PAM: BACKGROUND: Didn't find a match for prompt "
                              "'%s' which was requested by pam module.\n", msg->msg);
+              /*
+               * No match, fall back to responding with the password if the caller is
+               * prompting for a value, and has requested that the user's answer
+               * should be displayed.  Won't happen if the system defines an explicit
+               * match for the pam message in question.
+               */
+              if (msg->msg_style != PAM_PROMPT_ECHO_OFF)
+                {
+                  ret = PAM_CONV_ERR;
+                }
+              else
+                {
+                  aresp[i].resp = strdup (up->password);
+                  if (aresp[i].resp == NULL)
+                    ret = PAM_CONV_ERR;
+                  if (DEBUG (up->verb))
+                    fprintf (stderr, "AUTH-PAM: BACKGROUND: ...but the prompt style "
+                             "was set to PAM_PROMPT_ECHO_OFF - so responding with "
+                             "password.\n");
+                }
 	    }
 	}
       else
-- 
2.1.4


