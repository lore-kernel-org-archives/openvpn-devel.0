From: Antonio Quartulli <a@...2181...>
Date: Sun, 30 Dec 2018 21:29:00 +1000
Message-Id: <20181230112901.29241-4-a@...2181...>
In-Reply-To: <20181230112901.29241-1-a@...2181...>
References: <20181230112901.29241-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] options: add support for
 --transport-plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: antonio@...515..., Robin Tarsiger <rtt@...2484...>

From: Robin Tarsiger <rtt@...2484...>

Add a new config option to allow the user to specify a transport plugin
implementing the new API. This plugin can be used to manipulate traffic
in any way, as designed by the plugin developer.

The fondamental advantage of this plugin is that the core codebase does
not need to know anything about its implementation, as soon as it
implements the transport API properly.

A plugin specified with --transport-plugin must be already loaded via
--plugin. --transport-plugin is a per-connection-block option and
specifies which plugin to use for this particular connection.
It can take additional arguments, if required by the specific plugin.

The manpage has been extended accordingly.

Signed-off-by: Robin Tarsiger <rtt@...2484...>
[antonio@...515...: refactored commits, restyled code]
---
 doc/openvpn.8         | 40 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/init.c    |  1 +
 src/openvpn/options.c | 31 +++++++++++++++++++++++++++++++
 src/openvpn/options.h |  1 +
 src/openvpn/socket.c  |  2 ++
 src/openvpn/socket.h  |  1 +
 6 files changed, 76 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7abcaf1e..9325dabd 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2847,6 +2847,46 @@ every module and script must return success (0) in order for
 the connection to be authenticated.
 .\"*********************************************************
 .TP
+.B \-\-transport-plugin module-pathname [connection-args]
+Use the loaded plugin module identified by
+.B module-pathname
+to provide a transport layer for the connection. The
+.B module-pathname
+must be exactly equivalent to a pathname supplied to a
+.B \-\-plugin
+option. The same transport plugin may be used for
+multiple connections, in which case the
+.B \-\-plugin
+option which loads it should only occur once. However,
+only one transport plugin may be specified per
+connection.
+
+If
+.B connection-args
+are present, these arguments are passed to the transport
+plugin when establishing this connection specifically; this
+is distinct from any per-plugin arguments which may have
+been specified using the
+.B \-\-plugin
+option. Documentation for possible
+.B connection-args
+may be provided along with the plugin in use.
+
+When a transport plugin is in use, the
+.B \-\-proto
+option should not normally be used and will usually result in
+an error, as the transport plugin takes over from the native
+transport protocol that would otherwise be specified. The
+rest of OpenVPN will operate in a manner similar to that of
+UDP mode, using the pseudo-protocol "indirect". There is one
+remaining rare use for
+.B \-\-proto
+in this case, which is to force a specific address family for
+transport plugins for which this is still meaningful. This can
+be done by specifying "indirect4" or "indirect6" as the
+protocol.
+.\"*********************************************************
+.TP
 .B \-\-keying\-material\-exporter label len
 Save Exported Keying Material [RFC5705] of len bytes (must be
 between 16 and 4095 bytes) using label in environment
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 560d87db..9f7b5fdd 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3335,6 +3335,7 @@ do_init_socket_1(struct context *c, const int mode)
                             &c->c1.link_socket_addr,
                             c->options.ipchange,
                             c->plugins,
+                            c->options.ce.transport_plugin_argv,
                             c->options.resolve_retry_seconds,
                             c->options.ce.mtu_discover_type,
                             c->options.rcvbuf,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0cf8db76..7e905532 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -403,6 +403,9 @@ static const char usage_message[] =
 #ifdef ENABLE_PLUGIN
     "--plugin m [str]: Load plug-in module m passing str as an argument\n"
     "                  to its initialization function.\n"
+    "--transport-plugin m [args]: Use plug-in module m to provide the transport\n"
+    "                             layer, with optional per-connection args. The\n"
+    "                             module must already be loaded with --plugin.\n"
 #endif
 #if P2MP
 #if P2MP_SERVER
@@ -2005,6 +2008,22 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "--proto tcp is ambiguous in this context.  Please specify --proto tcp-server or --proto tcp-client");
     }
 
+#ifdef ENABLE_PLUGIN
+    /*
+     * "proto indirect" may not be specified directly without a
+     * transport-plugin, and vice versa.
+     */
+    if (ce->proto == PROTO_INDIRECT && !ce->transport_plugin_argv)
+    {
+        msg(M_USAGE, "--proto indirect may not be used without a transport-plugin line");
+    }
+
+    if (ce->transport_plugin_argv && ce->proto != PROTO_INDIRECT)
+    {
+        msg(M_USAGE, "--transport-plugin must be used with --proto indirect");
+    }
+#endif
+
     /*
      * Sanity check on daemon/inetd modes
      */
@@ -5190,6 +5209,18 @@ add_option(struct options *options,
             goto err;
         }
     }
+    else if (streq(p[0], "transport-plugin") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_PLUGIN|OPT_P_CONNECTION);
+
+        /* p[1] is the shared object name, which becomes
+         * argv[0]. p[2..] are connection-specific transport
+         * parameters, which become argv[1..].
+         */
+        options->ce.transport_plugin_argv = make_extended_arg_array(&p[1],
+                                                                    &options->gc);
+        options->ce.proto = PROTO_INDIRECT;
+    }
 #endif
     else if (streq(p[0], "mode") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index e2b38939..c2d0e9ac 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -85,6 +85,7 @@ struct options_pre_pull
 
 struct connection_entry
 {
+    const char **transport_plugin_argv;
     int proto;
     sa_family_t af;
     const char *local_port;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b548ab7a..e8f790ea 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1916,6 +1916,7 @@ link_socket_init_phase1(struct link_socket *sock,
                         struct link_socket_addr *lsa,
                         const char *ipchange_command,
                         const struct plugin_list *plugins,
+                        const char **transport_plugin_argv,
                         int resolve_retry_seconds,
                         int mtu_discover_type,
                         int rcvbuf,
@@ -1955,6 +1956,7 @@ link_socket_init_phase1(struct link_socket *sock,
     sock->info.bind_ipv6_only = bind_ipv6_only;
     sock->info.ipchange_command = ipchange_command;
     sock->info.plugins = plugins;
+    sock->info.transport_plugin_argv = transport_plugin_argv;
     sock->server_poll_timeout = server_poll_timeout;
 
     sock->mode = mode;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 73a4ab6f..eb0b2a73 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -327,6 +327,7 @@ link_socket_init_phase1(struct link_socket *sock,
                         struct link_socket_addr *lsa,
                         const char *ipchange_command,
                         const struct plugin_list *plugins,
+                        const char **transport_plugin_argv,
                         int resolve_retry_seconds,
                         int mtu_discover_type,
                         int rcvbuf,
-- 
2.19.2


