From: Gert Doering <gert@...1296...>
Date: Mon, 19 Oct 2015 20:06:19 +0200
Message-Id: <1445277979-21591-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
	sending IPv6 info to clients.
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

Workaround option for servers that have IPv6 working just fine, but
need to turn it off for individual clients - in that case, set this
option in the --client-config-dir file for a particular user, or
via --client-connect script/plugin hook for a particular platform
(like IOS 9.0.2)

Trac #614

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8         |  8 ++++++++
 src/openvpn/options.c |  6 ++++++
 src/openvpn/options.h |  1 +
 src/openvpn/push.c    | 33 +++++++++++++++++++++++++--------
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3a86409..4cfc796 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5704,6 +5704,14 @@ for more details how to setup and use this, and how
 and
 .B \-\-route
 interact.
+.TP
+.B \-\-push\-suppress\-ipv6
+remove all IPv6 related options from the list of options that the
+server will send to a client.  Only needed if the server has IPv6 in
+general, but one particular client (or client OS) is known to have 
+problems with IPv6 - so this can be sent from a \-\-client\-config\-dir
+file (for a particular user), or a \-\-client\-connect script (evaluating
+peer-info variables, like IV_PLAT=)
 
 .\"*********************************************************
 .SH SCRIPTING AND ENVIRONMENTAL VARIABLES
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5654830..ee2615a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -409,6 +409,7 @@ static const char usage_message[] =
   "                  execution.  Peer must specify --pull in its config file.\n"
   "--push-reset    : Don't inherit global push list for specific\n"
   "                  client instance.\n"
+  "--push-suppress-ipv6 : do not send IPv6 config to client instance.\n"
   "--ifconfig-pool start-IP end-IP [netmask] : Set aside a pool of subnets\n"
   "                  to be dynamically allocated to connecting clients.\n"
   "--ifconfig-pool-linear : Use individual addresses rather than /30 subnets\n"
@@ -5881,6 +5882,11 @@ add_option (struct options *options,
       options->push_ifconfig_ipv6_netbits = netbits;
       options->push_ifconfig_ipv6_remote = remote;
     }
+  else if (streq (p[0], "push-suppress-ipv6") && !p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_INSTANCE);
+      options->push_suppress_ipv6 = true;
+    }
   else if (streq (p[0], "disable") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_INSTANCE);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c642aa0..dee5994 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -434,6 +434,7 @@ struct options
   struct in6_addr push_ifconfig_ipv6_local;		/* IPv6 */
   int 		  push_ifconfig_ipv6_netbits;		/* IPv6 */
   struct in6_addr push_ifconfig_ipv6_remote;		/* IPv6 */
+  bool push_suppress_ipv6;				/* no-IPv6 */
   bool enable_c2c;
   bool duplicate_cn;
   int cf_max;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a4cb726..cdfafe4 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -251,15 +251,22 @@ send_push_reply (struct context *c)
 
   if ( c->c2.push_ifconfig_ipv6_defined )
     {
-      /* IPv6 is put into buffer first, could be lengthy */
-      buf_printf( &buf, ",ifconfig-ipv6 %s/%d %s",
-		    print_in6_addr( c->c2.push_ifconfig_ipv6_local, 0, &gc),
-		    c->c2.push_ifconfig_ipv6_netbits,
-		    print_in6_addr( c->c2.push_ifconfig_ipv6_remote, 0, &gc) );
-      if (BLEN (&buf) >= safe_cap)
+      if ( c->options.push_suppress_ipv6 )
 	{
-	  msg (M_WARN, "--push ifconfig-ipv6 option is too long");
-	  goto fail;
+	  msg( M_INFO, "send_push_reply(): suppress sending ifconfig-ipv6" );
+	}
+      else
+	{
+	  /* IPv6 is put into buffer first, could be lengthy */
+	  buf_printf( &buf, ",ifconfig-ipv6 %s/%d %s",
+			print_in6_addr( c->c2.push_ifconfig_ipv6_local, 0, &gc),
+			c->c2.push_ifconfig_ipv6_netbits,
+			print_in6_addr( c->c2.push_ifconfig_ipv6_remote, 0, &gc) );
+	  if (BLEN (&buf) >= safe_cap)
+	    {
+	      msg (M_WARN, "--push ifconfig-ipv6 option is too long");
+	      goto fail;
+	    }
 	}
     }
 
@@ -268,6 +275,15 @@ send_push_reply (struct context *c)
       if (e->enable)
 	{
 	  const int l = strlen (e->option);
+
+	  if ( c->options.push_suppress_ipv6 &&
+		( strncmp( e->option, "tun-ipv6", 8 ) == 0 ||
+		  strncmp( e->option, "route-ipv6", 10 ) == 0 ) )
+	    {
+	      msg( M_INFO, "send_push_reply(): suppress sending '%s'", e->option );
+	      goto next;
+	    }
+
 	  if (BLEN (&buf) + l >= safe_cap)
 	    {
 	      buf_printf (&buf, ",push-continuation 2");
@@ -288,6 +304,7 @@ send_push_reply (struct context *c)
 	    }
 	  buf_printf (&buf, ",%s", e->option);
 	}
+next:
       e = e->next;
     }
 
-- 
2.4.6


