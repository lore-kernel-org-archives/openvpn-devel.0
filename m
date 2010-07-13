From: David Sommerseth <dazo@...384...>
Date: Tue, 13 Jul 2010 15:32:09 +0200
Message-Id: <1279027929-28958-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Fix multiple configured scripts conflicts
	issue
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
Cc: David Sommerseth <dazo@...384...>

This is a fix for trac ticket #20,
<https://community.openvpn.net/openvpn/ticket/20>
which was started in the sf.net bug tracker:
<http://sourceforge.net/tracker/?func=detail&aid=2078470&group_id=48978&atid=454719>

The implemented solution is to give a warning for each of the different script hooks
available.  The last configured script will override any earlier configured scripts,
to ensure that the command line can override the configuration file.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 options.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index b78158e..9bbb51e 100644
--- a/options.c
+++ b/options.c
@@ -3877,6 +3877,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
+      if (options->ipchange) {
+	msg (M_WARN, "Multiple --ipchange scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->ipchange = string_substitute (p[1], ',', ' ', &options->gc);
     }
   else if (streq (p[0], "float"))
@@ -3923,6 +3927,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
+      if (options->up_script) {
+	msg (M_WARN, "Multiple --up scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->up_script = p[1];
     }
   else if (streq (p[0], "down") && p[1])
@@ -3930,6 +3938,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
+      if (options->down_script) {
+	msg (M_WARN, "Multiple --down scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->down_script = p[1];
     }
   else if (streq (p[0], "down-pre"))
@@ -4598,6 +4610,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
+      if (options->route_script) {
+	msg (M_WARN, "Multiple --route-up scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->route_script = p[1];
     }
   else if (streq (p[0], "route-noexec"))
@@ -4927,6 +4943,10 @@ add_option (struct options *options,
 	  msg (msglevel, "--auth-user-pass-verify requires a second parameter ('via-env' or 'via-file')");
 	  goto err;
 	}
+      if (options->auth_user_pass_verify_script) {
+	msg (M_WARN, "Multiple --auth-user-pass-verify scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->auth_user_pass_verify_script = p[1];
     }
   else if (streq (p[0], "client-connect") && p[1])
@@ -4934,6 +4954,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
+      if (options->client_connect_script) {
+	msg (M_WARN, "Multiple --client-connect scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->client_connect_script = p[1];
     }
   else if (streq (p[0], "client-disconnect") && p[1])
@@ -4941,6 +4965,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
+      if (options->client_disconnect_script) {
+	msg (M_WARN, "Multiple --client-disconnect scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->client_disconnect_script = p[1];
     }
   else if (streq (p[0], "learn-address") && p[1])
@@ -4948,6 +4976,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
+      if (options->learn_address_script) {
+	msg (M_WARN, "Multiple --learn-address scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->learn_address_script = p[1];
     }
   else if (streq (p[0], "tmp-dir") && p[1])
@@ -5708,6 +5740,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
+      if (options->tls_verify) {
+	msg (M_WARN, "Multiple --tls-verify scripts defined.  "
+	     "The previously configured script is overridden.");
+      }
       options->tls_verify = string_substitute (p[1], ',', ' ', &options->gc);
     }
   else if (streq (p[0], "tls-remote") && p[1])
-- 
1.7.1.1


