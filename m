From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:09 +0100
Message-Id: <1385064495-25877-8-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 08/14] Remove the ip-remote-hint option.
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

The ip-remote-hint option overrides the remote hostname of every remote/connection entry unless management-query-remote is also defined and the management interfaces overrides the option with remote MOD … The remote name is even overridden when when management interface issues remote ACCEPT after being presented with the non overridden remote.

Overriding all remote options can also be done by  management-query-remote  and issuing remote MOD or by changing alll remote statements in the configuration.

Also: remove unused variable newcycle

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    |   17 ++---------------
 src/openvpn/options.c |    5 -----
 src/openvpn/options.h |    1 -
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 676a7fe..2076aad 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -245,7 +245,7 @@ management_callback_remote_cmd (void *arg, const char **p)
 }
 
 static bool
-ce_management_query_remote (struct context *c, const char *remote_ip_hint)
+ce_management_query_remote (struct context *c)
 {
   struct gc_arena gc = gc_new ();
   volatile struct connection_entry *ce = &c->options.ce;
@@ -270,8 +270,6 @@ ce_management_query_remote (struct context *c, const char *remote_ip_hint)
     }
   {
     const int flags = ((ce->flags>>CE_MAN_QUERY_REMOTE_SHIFT) & CE_MAN_QUERY_REMOTE_MASK);
-    if (flags == CE_MAN_QUERY_REMOTE_ACCEPT && remote_ip_hint)
-      ce->remote = remote_ip_hint;
     ret = (flags != CE_MAN_QUERY_REMOTE_SKIP);
   }
   gc_free (&gc);
@@ -321,9 +319,6 @@ next_connection_entry (struct context *c)
       int n_cycles = 0;
 
       do {
-	const char *remote_ip_hint = NULL;
-	bool newcycle = false;
-
 	ce_defined = true;
 	if (l->no_advance && l->current >= 0)
 	  {
@@ -338,16 +333,10 @@ next_connection_entry (struct context *c)
 		if (++n_cycles >= 2)
 		  msg (M_FATAL, "No usable connection profiles are present");
 	      }
-
-	    if (l->current == 0)
-	      newcycle = true;
 	  }
 
 	ce = l->array[l->current];
 
-	if (c->options.remote_ip_hint && !l->n_cycles)
-	  remote_ip_hint = c->options.remote_ip_hint;
-
 	if (ce->flags & CE_DISABLED)
 	  ce_defined = false;
 
@@ -356,14 +345,12 @@ next_connection_entry (struct context *c)
 	if (ce_defined && management && management_query_remote_enabled(management))
 	  {
 	    /* allow management interface to override connection entry details */
-	    ce_defined = ce_management_query_remote(c, remote_ip_hint);
+	    ce_defined = ce_management_query_remote(c);
 	    if (IS_SIG (c))
 	      break;
 	  }
         else
 #endif
-	if (remote_ip_hint)
-	  c->options.ce.remote = remote_ip_hint;
 
 #ifdef ENABLE_MANAGEMENT
         if (ce_defined && management && management_query_proxy_enabled (management))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6906ea1..01ccf1a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4435,11 +4435,6 @@ add_option (struct options *options,
 
       options->ignore_unknown_option[i] = NULL;
     }
-  else if (streq (p[0], "remote-ip-hint") && p[1])
-    {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->remote_ip_hint = p[1];
-    }
 #if HTTP_PROXY_OVERRIDE
   else if (streq (p[0], "http-proxy-override") && p[1] && p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 659d05b..b320ca1 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -210,7 +210,6 @@ struct options
 
   /* Networking parms */
   struct connection_entry ce;
-  char *remote_ip_hint;
   struct connection_list *connection_list;
   struct remote_list *remote_list;
   bool force_connection_list;
-- 
1.7.9.5


