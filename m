From: Gert Doering <gert@...1296...>
Date: Mon, 16 May 2016 12:13:04 +0200
Message-Id: <1463393584-8318-1-git-send-email-gert@...1296...>
In-Reply-To: <56BB454C.3050006@...1227...>
References: <56BB454C.3050006@...1227...>
Subject: [Openvpn-devel] [PATCH v3] Implement push-remove option to
	selectively remove pushed options.
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

With this option, the server can remove individual options from the
set pushed to a client (call from --client-config-dir file, or from
--client-connect script or plugin).  Options are removed at parse
time, so it is possible to do stuff like:

  push-remove route-ipv6
  push "route-ipv6 fd00::/8"

to first remove all IPv6 route options set so far, then add something
specific (what "push-reset" does to all the options).

Arguments to push-remove are strncmp()'ed to option string, so partial
matches like

  push-remove "route-ipv6 2001:"

are possible ("remove all IPv6 routes starting with 2001:").

Implementation of remove_iroutes_from_push_route_list() had to be changed
slightly to stop it from re-enabling all disabled options again.

v2: documentation (Changes.rst, doc/openvpn.8)
    remove surplus gc_arena
    implement filtering of "ifconfig-ipv6"

v3: correct quoting in commit message
    only handle a single argument per push-remove statement - if multiple
    options are to be removed, just use multiple push-remove statements

Trac #29, #614

Signed-off-by: Gert Doering <gert@...1296...>
---
 Changes.rst           |  4 ++++
 doc/openvpn.8         | 35 ++++++++++++++++++++++++++++++++++-
 src/openvpn/options.c |  6 ++++++
 src/openvpn/options.h |  1 +
 src/openvpn/push.c    | 47 ++++++++++++++++++++++++++++++++++++++++-------
 src/openvpn/push.h    |  1 +
 6 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index dc9131b..a6bb2a5 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -5,6 +5,10 @@ Version 2.4.0
 New features
 ------------
 
+push-remove
+    new option to remove options on a per-client basis from the "push" list
+    (more fine-grained than "push-reset")
+
 keying-material-exporter
     Keying Material Exporter [RFC-5705] allow additional keying material to be
     derived from existing TLS channel.
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7d5dc5b..8d1b062 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2965,6 +2965,39 @@ as with a
 configuration file.  This option will ignore
 .B \-\-push
 options at the global config file level.
+.\"*********************************************************
+.TP
+.B \-\-push\-remove opt
+selectively remove all
+.B \-\-push
+options matching "opt" from the option list for a client.  "opt" is matched
+as a substring against the whole option string to-be-pushed to the client, so
+.B \-\-push\-remove route
+would remove all
+.B \-\-push route ...
+and
+.B \-\-push route-ipv6 ...
+statements, while
+.B \-\-push\-remove 'route-ipv6 2001:'
+would only remove IPv6 routes for 2001:... networks.
+
+.B \-\-push\-remove
+can only be used in a client-specific context, like in a
+.B \-\-client\-config\-dir
+file, or
+.B \-\-client\-connect
+script or plugin -- similar to
+.B \-\-push\-reset,
+just more selective.
+
+NOTE: to
+.I change
+an option,
+.B \-\-push\-remove
+can be used to first remove the old value, and then add a new
+.B \-\-push
+option with the new value.
+.\"*********************************************************
 .TP
 .B \-\-push\-peer\-info
 Push additional information about the client to server.  The additional information
@@ -3289,7 +3322,7 @@ without needing to restart the server.
 
 The following
 options are legal in a client-specific context:
-.B \-\-push, \-\-push\-reset, \-\-iroute, \-\-ifconfig\-push,
+.B \-\-push, \-\-push\-reset, \-\-push\-remove, \-\-iroute, \-\-ifconfig\-push,
 and
 .B \-\-config.
 .\"*********************************************************
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 764ca74..55630c7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5582,6 +5582,11 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_INSTANCE);
       push_reset (options);
     }
+  else if (streq (p[0], "push-remove") && p[1] && !p[2])
+    {
+      VERIFY_PERMISSION (OPT_P_INSTANCE);
+      push_remove_option (options,p[1]);
+    }
   else if (streq (p[0], "ifconfig-pool") && p[1] && p[2] && !p[4])
     {
       const int lev = M_WARN;
@@ -5930,6 +5935,7 @@ add_option (struct options *options,
       options->push_ifconfig_ipv6_local = local;
       options->push_ifconfig_ipv6_netbits = netbits;
       options->push_ifconfig_ipv6_remote = remote;
+      options->push_ifconfig_ipv6_blocked = false;
     }
   else if (streq (p[0], "disable") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 18d8376..2fa375f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -432,6 +432,7 @@ struct options
   struct in6_addr push_ifconfig_ipv6_local;		/* IPv6 */
   int 		  push_ifconfig_ipv6_netbits;		/* IPv6 */
   struct in6_addr push_ifconfig_ipv6_remote;		/* IPv6 */
+  bool            push_ifconfig_ipv6_blocked;		/* IPv6 */
   bool enable_c2c;
   bool duplicate_cn;
   int cf_max;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index be4daa1..38ac59e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -322,7 +322,8 @@ send_push_reply (struct context *c)
 
   buf_printf (&buf, "%s", cmd);
 
-  if ( c->c2.push_ifconfig_ipv6_defined )
+  if ( c->c2.push_ifconfig_ipv6_defined &&
+          !c->options.push_ifconfig_ipv6_blocked )
     {
       /* IPv6 is put into buffer first, could be lengthy */
       buf_printf( &buf, ",ifconfig-ipv6 %s/%d %s",
@@ -483,6 +484,37 @@ push_reset (struct options *o)
 {
   CLEAR (o->push_list);
 }
+
+void
+push_remove_option (struct options *o, const char *p)
+{
+  msg( D_PUSH, "PUSH_REMOVE '%s'", p );
+
+  /* ifconfig-ipv6 is special, as not part of the push list */
+  if ( streq( p, "ifconfig-ipv6" ))
+    {
+      o->push_ifconfig_ipv6_blocked = true;
+      return;
+    }
+
+  if (o && o->push_list.head )
+    {
+      struct push_entry *e = o->push_list.head;
+
+      /* cycle through the push list */
+      while (e)
+	{
+	  if ( e->enable &&
+               strncmp( e->option, p, strlen(p) ) == 0 )
+	    {
+	      msg (D_PUSH, "PUSH_REMOVE removing: '%s'", e->option);
+	      e->enable = false;
+	    }
+
+	  e = e->next;
+	}
+    }
+}
 #endif
 
 #if P2MP_SERVER
@@ -613,7 +645,8 @@ remove_iroutes_from_push_route_list (struct options *o)
 
 	  /* parse the push item */
 	  CLEAR (p);
-	  if (parse_line (e->option, p, SIZE (p), "[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG, &gc))
+	  if ( e->enable &&
+               parse_line (e->option, p, SIZE (p), "[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG, &gc))
 	    {
 	      /* is the push item a route directive? */
 	      if (p[0] && !strcmp (p[0], "route") && !p[3])
@@ -639,12 +672,12 @@ remove_iroutes_from_push_route_list (struct options *o)
 			}
 		    }
 		}
-	    }
 
-	  /* should we copy the push item? */
-	  e->enable = enable;
-	  if (!enable)
-	    msg (D_PUSH, "REMOVE PUSH ROUTE: '%s'", e->option);
+	      /* should we copy the push item? */
+	      e->enable = enable;
+	      if (!enable)
+		msg (D_PUSH, "REMOVE PUSH ROUTE: '%s'", e->option);
+	    }
 
 	  e = e->next;
 	}
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 19bbf5e..d6cb4b1 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -61,6 +61,7 @@ void push_option (struct options *o, const char *opt, int msglevel);
 void push_options (struct options *o, char **p, int msglevel, struct gc_arena *gc);
 
 void push_reset (struct options *o);
+void push_remove_option (struct options *o, const char *p);
 
 void remove_iroutes_from_push_route_list (struct options *o);
 
-- 
2.7.3


