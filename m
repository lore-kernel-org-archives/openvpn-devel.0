From: Gert Doering <gert@...1296...>
Date: Thu, 23 Jan 2025 16:51:11 +0100
Message-ID: <20250123155111.23371-1-gert@...1296...>
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v12] allow user to specify 'local' multiple
 times in config files
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

From: Antonio Quartulli <a@...2181...>

It is now possible to specify 'local' multiple times in a server
config to let it listen on multiple sockets (address:port) of
the same protocol.

Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/436
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index ca192c3..2667b93 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -106,13 +106,22 @@
   is not reliable. It is recommended to set tun-mtu with enough headroom
   instead.
 
---local host
-  Local host name or IP address for bind. If specified, OpenVPN will bind
-  to this address only. If unspecified, OpenVPN will bind to all
-  interfaces.
+--local host|* [port]
+  Local host name or IP address and port for bind. If specified, OpenVPN will bind
+  to this address. If unspecified, OpenVPN will bind to all interfaces.
+  '*' can be used as hostname and means 'any host' (OpenVPN will listen on what
+  is returned by the OS). 
+  On a client, or in point-to-point mode, this can only be specified once (1 socket).
+  
+  On an OpenVPN setup running as ``--server``, this can be specified multiple times
+  to open multiple listening sockets on different addresses and/or different ports.
+  In order to specify multiple listen ports without specifying an address, use '*'
+  to signal "use what the operating system gives you as default", for
+  "all IPv4 addresses" use "0.0.0.0", for "all IPv6 addresses" use '::'.
+  ``--local`` implies ``--bind``.
 
 --lport port
-  Set local TCP/UDP port number or name. Cannot be used together with
+  Set default TCP/UDP port number. Cannot be used together with
   ``--nobind`` option.
 
 --mark value
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9d1048c..4014517 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -751,7 +751,7 @@
 
     init_connection_list(c);
 
-    c->c1.link_sockets_num = 1;
+    c->c1.link_sockets_num = c->options.ce.local_list->len;
 
     do_link_socket_addr_new(c);
 
@@ -4978,6 +4978,7 @@
     if (dest->mode == CM_CHILD_UDP)
     {
         ASSERT(!dest->c2.link_sockets);
+        ASSERT(dest->options.ce.local_list);
 
         /* inherit buffers */
         dest->c2.buffers = src->c2.buffers;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ef4d78..c938999 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -124,7 +124,17 @@
     "--version       : Show copyright and version information.\n"
     "\n"
     "Tunnel Options:\n"
-    "--local host    : Local host name or ip address. Implies --bind.\n"
+    "--local host|* [port]: Local host name or IP address and port for bind.\n"
+    "                        If specified, OpenVPN will bindto this address. If unspecified,\n"
+    "                        OpenVPN will bind to all interfaces. '*' can be used as hostname\n"
+    "                        and means 'any host' (OpenVPN will listen on what is returned by the OS).\n"
+    "                        On a client, or in point-to-point mode, this can only be specified once (1 socket).\n"
+    "                        On an OpenVPN setup running as ``--server``, this can be specified multiple times\n"
+    "                        to open multiple listening sockets on different addresses and/or different ports.\n"
+    "                        In order to specify multiple listen ports without specifying an address, use '*'\n"
+    "                        to signal 'use what the operating system gives you as default', for\n"
+    "                        'all IPv4 addresses' use '0.0.0.0', for 'all IPv6 addresses' use '::'.\n"
+    "                        ``--local`` implies ``--bind``.\n"
     "--remote host [port] : Remote host name or ip address.\n"
     "--remote-random : If multiple --remote options specified, choose one randomly.\n"
     "--remote-random-hostname : Add a random string to remote DNS name.\n"
@@ -988,8 +998,9 @@
                         const int i)
 {
     setenv_str_i(es, "proto", proto2ascii(e->proto, e->af, false), i);
-    setenv_str_i(es, "local", e->local, i);
-    setenv_str_i(es, "local_port", e->local_port, i);
+    /* expected to be for single socket contexts only */
+    setenv_str_i(es, "local", e->local_list->array[0]->local, i);
+    setenv_str_i(es, "local_port", e->local_list->array[0]->port, i);
     setenv_str_i(es, "remote", e->remote, i);
     setenv_str_i(es, "remote_port", e->remote_port, i);
 
@@ -1713,8 +1724,12 @@
 show_connection_entry(const struct connection_entry *o)
 {
     msg(D_SHOW_PARMS, "  proto = %s", proto2ascii(o->proto, o->af, false));
-    SHOW_STR(local);
-    SHOW_STR(local_port);
+    msg(D_SHOW_PARMS, "  Local Sockets:");
+    for (int i = 0; i < o->local_list->len; i++)
+    {
+        msg(D_SHOW_PARMS, "    [%s]:%s", o->local_list->array[i]->local,
+            o->local_list->array[i]->port);
+    }
     SHOW_STR(remote);
     SHOW_STR(remote_port);
     SHOW_BOOL(remote_float);
@@ -2162,6 +2177,37 @@
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
+static struct local_list *
+alloc_local_list_if_undef(struct connection_entry *ce, struct gc_arena *gc)
+{
+    if (!ce->local_list)
+    {
+        ALLOC_OBJ_CLEAR_GC(ce->local_list, struct local_list, gc);
+    }
+    return ce->local_list;
+}
+
+static struct local_entry *
+alloc_local_entry(struct connection_entry *ce, const int msglevel,
+                  struct gc_arena *gc)
+{
+    struct local_list *l = alloc_local_list_if_undef(ce, gc);
+    struct local_entry *e;
+
+    if (l->len >= CONNECTION_LIST_SIZE)
+    {
+        msg(msglevel, "Maximum number of 'local' options (%d) exceeded",
+            CONNECTION_LIST_SIZE);
+
+        return NULL;
+    }
+
+    ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    l->array[l->len++] = e;
+
+    return e;
+}
+
 static struct connection_list *
 alloc_connection_list_if_undef(struct options *options)
 {
@@ -2354,6 +2400,15 @@
             "--proto tcp-server or --proto tcp-client");
     }
 
+    /*
+     * Sanity check on Client mode
+     */
+
+    if (options->mode != MODE_SERVER && ce->local_list->len > 1)
+    {
+        msg(M_USAGE, "multiple --local statements only allowed in --server mode");
+    }
+
     if (options->lladdr && dev != DEV_TYPE_TAP)
     {
         msg(M_USAGE, "--lladdr can only be used in --dev tap mode");
@@ -2379,13 +2434,6 @@
      * Sanity check on --local, --remote, and --ifconfig
      */
 
-    if (proto_is_net(ce->proto)
-        && string_defined_equal(ce->local, ce->remote)
-        && string_defined_equal(ce->local_port, ce->remote_port))
-    {
-        msg(M_USAGE, "--remote and --local addresses are the same");
-    }
-
     if (string_defined_equal(ce->remote, options->ifconfig_local)
         || string_defined_equal(ce->remote, options->ifconfig_remote_netmask))
     {
@@ -2394,13 +2442,6 @@
             "addresses");
     }
 
-    if (string_defined_equal(ce->local, options->ifconfig_local)
-        || string_defined_equal(ce->local, options->ifconfig_remote_netmask))
-    {
-        msg(M_USAGE,
-            "--local addresses must be distinct from --ifconfig addresses");
-    }
-
     if (string_defined_equal(options->ifconfig_local,
                              options->ifconfig_remote_netmask))
     {
@@ -2413,12 +2454,6 @@
         msg(M_USAGE, "--bind and --nobind can't be used together");
     }
 
-    if (ce->local && !ce->bind_local)
-    {
-        msg(M_USAGE,
-            "--local and --nobind don't make sense when used together");
-    }
-
     if (ce->local_port_defined && !ce->bind_local)
     {
         msg(M_USAGE,
@@ -2430,6 +2465,29 @@
         msg(M_USAGE, "--nobind doesn't make sense unless used with --remote");
     }
 
+    for (int i = 0; i < ce->local_list->len; i++)
+    {
+        struct local_entry *le = ce->local_list->array[i];
+
+        if (proto_is_net(ce->proto)
+            && string_defined_equal(le->local, ce->remote)
+            && string_defined_equal(le->port, ce->remote_port))
+        {
+            msg(M_USAGE, "--remote and one of the --local addresses are the same");
+        }
+
+        if (string_defined_equal(le->local, options->ifconfig_local)
+            || string_defined_equal(le->local, options->ifconfig_remote_netmask))
+        {
+            msg(M_USAGE, "--local addresses must be distinct from --ifconfig addresses");
+        }
+
+        if (le->local && !ce->bind_local)
+        {
+            msg(M_USAGE, "--local and --nobind don't make sense when used together");
+        }
+    }
+
     /*
      * Check for consistency of management options
      */
@@ -3128,7 +3186,7 @@
     }
 
     /* an option is present that requires local bind to enabled */
-    bool need_bind = ce->local || ce->local_port_defined || ce->bind_defined;
+    bool need_bind = ce->local_port_defined || ce->bind_defined || ce->local_list;
 
     /* socks proxy is enabled */
     bool uses_socks = ce->proto == PROTO_UDP && ce->socks_proxy_server;
@@ -3264,6 +3322,16 @@
     }
 }
 
+static void
+options_postprocess_mutate_le(struct connection_entry ce, struct local_entry *le)
+{
+    /* use the global port if none is specified */
+    if (!le->port)
+    {
+        le->port = ce.local_port;
+    }
+}
+
 #ifdef _WIN32
 /* If iservice is in use, we need def1 method for redirect-gateway */
 static void
@@ -3705,6 +3773,28 @@
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
     }
 
+    if (o->ce.local_list)
+    {
+        for (i = 0; i < o->ce.local_list->len; i++)
+        {
+            options_postprocess_mutate_le(o->ce, o->ce.local_list->array[i]);
+        }
+    }
+    else
+    {
+        /* if no 'local' directive was specified, convert the global port
+         * setting to a listen entry */
+        struct local_entry *e = alloc_local_entry(&o->ce, M_USAGE, &o->gc);
+        ASSERT(e);
+        e->port = o->ce.local_port;
+    }
+
+    /* use the same listen list for every outgoing connection */
+    for (i = 0; i < o->connection_list->len; ++i)
+    {
+        o->connection_list->array[i]->local_list = o->ce.local_list;
+    }
+
     if (o->tls_server)
     {
         /* Check that DH file is specified, or explicitly disabled */
@@ -6100,10 +6190,27 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn = true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[2])
+    else if (streq(p[0], "local") && p[1] && !p[3])
     {
+        struct local_entry *e;
+
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.local = p[1];
+
+        e = alloc_local_entry(&options->ce, M_USAGE, &options->gc);
+        ASSERT(e);
+
+        /* '*' is treated as 'ask the system to get some socket',
+         * therefore force binding on a particular address only when
+         * actually specified. */
+        if (strcmp(p[1], "*") != 0)
+        {
+            e->local = p[1];
+        }
+
+        if (p[2])
+        {
+            e->port = p[2];
+        }
     }
     else if (streq(p[0], "remote-random") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 55f12dd..3f4cb90 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -94,14 +94,20 @@
 #error "At least one of OpenSSL or mbed TLS needs to be defined."
 #endif
 
+struct local_entry
+{
+    const char *local;
+    const char *port;
+};
+
 struct connection_entry
 {
+    struct local_list *local_list;
     int proto;
     sa_family_t af;
     const char *local_port;
     bool local_port_defined;
     const char *remote_port;
-    const char *local;
     const char *remote;
     bool remote_float;
     bool bind_defined;
@@ -179,6 +185,12 @@
 
 #define CONNECTION_LIST_SIZE 64
 
+struct local_list
+{
+    int len;
+    struct local_entry *array[CONNECTION_LIST_SIZE];
+};
+
 struct connection_list
 {
     int capacity;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0c4a7bc..97dce02 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -342,7 +342,6 @@
 void
 do_preresolve(struct context *c)
 {
-    int i;
     struct connection_list *l = c->options.connection_list;
     const unsigned int preresolve_flags = GETADDR_RESOLVE
                                           |GETADDR_UPDATE_MANAGEMENT_STATE
@@ -350,13 +349,13 @@
                                           |GETADDR_FATAL;
 
 
-    for (i = 0; i < l->len; ++i)
+    for (int i = 0; i < l->len; ++i)
     {
         int status;
         const char *remote;
         int flags = preresolve_flags;
 
-        struct connection_entry *ce = c->options.connection_list->array[i];
+        struct connection_entry *ce = l->array[i];
 
         if (proto_is_dgram(ce->proto))
         {
@@ -420,13 +419,23 @@
         {
             flags |= GETADDR_PASSIVE;
             flags &= ~GETADDR_RANDOMIZE;
-            status = do_preresolve_host(c, ce->local, ce->local_port,
-                                        ce->af, flags);
-            if (status != 0)
-            {
-                goto err;
-            }
 
+            for (int j = 0; j < ce->local_list->len; j++)
+            {
+                struct local_entry *le = ce->local_list->array[j];
+
+                if (!le->local)
+                {
+                    continue;
+                }
+
+                status = do_preresolve_host(c, le->local, le->port, ce->af, flags);
+                if (status != 0)
+                {
+                    goto err;
+                }
+
+            }
         }
 
     }
@@ -1882,8 +1891,8 @@
     const char *remote_host = o->ce.remote;
     const char *remote_port = o->ce.remote_port;
 
-    sock->local_host = o->ce.local;
-    sock->local_port = o->ce.local_port;
+    sock->local_host = o->ce.local_list->array[sock_index]->local;
+    sock->local_port = o->ce.local_list->array[sock_index]->port;
     sock->remote_host = remote_host;
     sock->remote_port = remote_port;
     sock->dns_cache = c->c1.dns_cache;

