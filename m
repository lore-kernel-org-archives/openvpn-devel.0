From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:21 +0800
Message-Id: <20180425195722.20744-8-a@...2181...>
In-Reply-To: <20180425195722.20744-1-a@...2181...>
References: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 7/8] allow user to specify 'local' multiple
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
Cc: Antonio Quartulli <a@...2181...>

It is now possible to specify 'local' multiple times in a server
config to let it listen on multiple sockets (address:port) of
the same protocol.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 doc/openvpn.8         |  10 ++-
 src/openvpn/init.c    |   9 +--
 src/openvpn/options.c | 162 ++++++++++++++++++++++++++++++++++--------
 src/openvpn/options.h |  15 +++-
 src/openvpn/socket.c  |  18 +++--
 5 files changed, 174 insertions(+), 40 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 4114f408..658bda23 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -201,10 +201,16 @@ a new mode ("server") which implements a multi\-client
 server capability.
 .\"*********************************************************
 .TP
-.B \-\-local host
-Local host name or IP address for bind.
+.B \-\-local host|* [port]
+Local host name or IP address  and port for bind.
 If specified, OpenVPN will bind to this address only.
 If unspecified, OpenVPN will bind to all interfaces.
+Multiple occurrencies of this option are allowed on
+a server, where it will listen on all the configured
+ip:port couples. 'ip' can also be '*', where it will
+just be treated as 'any host'.
+To listen on IPv4 or IPv6 only, it is possible to use
+0.0.0.0 or :: respectivaly.
 .\"*********************************************************
 .TP
 .B \-\-remote host [port] [proto]
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a2b474c8..41bc5094 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -627,7 +627,7 @@ context_init_1(struct context *c)
 
     init_connection_list(c);
 
-    c->c1.link_sockets_num = 1;
+    c->c1.link_sockets_num = c->options.ce.local_list->len;
 
     do_link_socket_addr_new(c);
 
@@ -3248,8 +3248,8 @@ do_init_socket_1(struct context *c, const int mode)
     {
         /* init each socket with its specific port */
         link_socket_init_phase1(c->c2.link_sockets[i],
-                                c->options.ce.local,
-                                c->options.ce.local_port,
+                                c->options.ce.local_list->array[i]->local,
+                                c->options.ce.local_list->array[i]->port,
                                 c->options.ce.remote,
                                 c->options.ce.remote_port,
                                 c->c1.dns_cache,
@@ -3263,7 +3263,7 @@ do_init_socket_1(struct context *c, const int mode)
 #ifdef ENABLE_DEBUG
                                 c->options.gremlin,
 #endif
-                                c->options.ce.bind_local,
+                                c->options.ce.local_list->array[i]->bind_local,
                                 c->options.ce.remote_float,
                                 c->options.inetd,
                                 &c->c1.link_socket_addrs[i],
@@ -4422,6 +4422,7 @@ inherit_context_child(struct context *dest,
     if (dest->mode == CM_CHILD_UDP)
     {
         ASSERT(!dest->c2.link_sockets);
+        ASSERT(dest->options.ce.local_list);
 
         /* inherit buffers */
         dest->c2.buffers = src->c2.buffers;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 426057ab..884a8f35 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -118,7 +118,13 @@ static const char usage_message[] =
     "--version       : Show copyright and version information.\n"
     "\n"
     "Tunnel Options:\n"
-    "--local host    : Local host name or ip address. Implies --bind.\n"
+    "--local host|* [port] : Local host name or ip address and port. '*' can be used\n"
+    "                        as hostname and means 'any host' (openvpn will listen on\n"
+    "                        what is returned by the OS). Implies --bind.\n"
+    "                        0.0.0.0 or :: can be used to specifically open a socket\n"
+    "                        listening on any IPv4 or IPv6 address respectively.\n"
+    "                        The user can specify multiple --local entries to have\n"
+    "                        a server listen on multiple sockets at the same time.\n"
     "--remote host [port] : Remote host name or ip address.\n"
     "--remote-random : If multiple --remote options specified, choose one randomly.\n"
     "--remote-random-hostname : Add a random string to remote DNS name.\n"
@@ -963,8 +969,9 @@ setenv_connection_entry(struct env_set *es,
                         const int i)
 {
     setenv_str_i(es, "proto", proto2ascii(e->proto, e->af, false), i);
-    setenv_str_i(es, "local", e->local, i);
-    setenv_str_i(es, "local_port", e->local_port, i);
+    /* expected to befor single socket contexts only */
+    setenv_str_i(es, "local", e->local_list->array[0]->local, i);
+    setenv_str_i(es, "local_port", e->local_list->array[0]->port, i);
     setenv_str_i(es, "remote", e->remote, i);
     setenv_str_i(es, "remote_port", e->remote_port, i);
 
@@ -1472,8 +1479,12 @@ static void
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
@@ -1908,6 +1919,37 @@ options_postprocess_http_proxy_override(struct options *o)
 
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
@@ -2053,11 +2095,19 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "only one of --daemon or --inetd may be specified");
     }
 
-    if (options->inetd && (ce->local || ce->remote))
+    if (options->inetd && (ce->local_list->len > 1
+                           || ce->local_list->array[0]->local
+                           || strcmp(ce->local_list->array[0]->local, "*")
+                           || ce->remote))
     {
         msg(M_USAGE, "--local or --remote cannot be used with --inetd");
     }
 
+    if (ce->remote && ce->local_list->len > 1)
+    {
+        msg(M_USAGE, "multiple --local do not make sense in Client mode");
+    }
+
     if (options->inetd && ce->proto == PROTO_TCP_CLIENT)
     {
         msg(M_USAGE, "--proto tcp-client cannot be used with --inetd");
@@ -2109,25 +2159,12 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
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
         msg(M_USAGE, "--local and --remote addresses must be distinct from --ifconfig addresses");
     }
 
-    if (string_defined_equal(ce->local, options->ifconfig_local)
-        || string_defined_equal(ce->local, options->ifconfig_remote_netmask))
-    {
-        msg(M_USAGE, "--local addresses must be distinct from --ifconfig addresses");
-    }
-
     if (string_defined_equal(options->ifconfig_local, options->ifconfig_remote_netmask))
     {
         msg(M_USAGE, "local and remote/netmask --ifconfig addresses must be different");
@@ -2138,11 +2175,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "--bind and --nobind can't be used together");
     }
 
-    if (ce->local && !ce->bind_local)
-    {
-        msg(M_USAGE, "--local and --nobind don't make sense when used together");
-    }
-
     if (ce->local_port_defined && !ce->bind_local)
     {
         msg(M_USAGE, "--lport and --nobind don't make sense when used together");
@@ -2153,6 +2185,29 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
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
+            msg(M_USAGE, "--remote and a --local addresses are the same");
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
@@ -2817,12 +2872,12 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
     }
 #endif
 
-    if (ce->proto == PROTO_TCP_CLIENT && !ce->local && !ce->local_port_defined && !ce->bind_defined)
+    if (ce->proto == PROTO_TCP_CLIENT && !ce->local_list && !ce->local_port_defined && !ce->bind_defined)
     {
         ce->bind_local = false;
     }
 
-    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local && !ce->local_port_defined && !ce->bind_defined)
+    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local_list && !ce->local_port_defined && !ce->bind_defined)
     {
         ce->bind_local = false;
     }
@@ -2868,7 +2923,16 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
             ce->tun_mtu_extra = TAP_MTU_EXTRA_DEFAULT;
         }
     }
+}
 
+static void
+options_postprocess_mutate_le(struct options *o, struct local_entry *le)
+{
+    /* use the global port if none is specified */
+    if (!le->port)
+    {
+        le->port = o->ce.local_port;
+    }
 }
 
 #ifdef _WIN32
@@ -3019,6 +3083,29 @@ options_postprocess_mutate(struct options *o)
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
     }
 
+    if (o->ce.local_list)
+    {
+        for (i = 0; i < o->ce.local_list->len; i++)
+        {
+            options_postprocess_mutate_le(o, o->ce.local_list->array[i]);
+        }
+    }
+    else
+    {
+        /* if no 'local' directive was specified, convert the global port
+         * setting to a listen entry */
+        struct local_entry *e = alloc_local_entry(&o->ce, M_USAGE, &o->gc);
+        ASSERT(e);
+        e->port = o->ce.local_port;
+        e->bind_local = o->ce.bind_local;
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
@@ -5267,10 +5354,29 @@ add_option(struct options *options,
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
+            e->bind_local = true;
+        }
+
+        if (p[2])
+        {
+            e->port = p[2];
+            e->bind_local = true;
+        }
     }
     else if (streq(p[0], "remote-random") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f7d0145a..fb8c32fd 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -83,14 +83,21 @@ struct options_pre_pull
 #error "At least one of OpenSSL or mbed TLS needs to be defined."
 #endif
 
+struct local_entry
+{
+    const char *local;
+    const char *port;
+    bool bind_local;
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
@@ -142,6 +149,12 @@ struct remote_entry
 
 #define CONNECTION_LIST_SIZE 64
 
+struct local_list
+{
+    int len;
+    struct local_entry *array[CONNECTION_LIST_SIZE];
+};
+
 struct connection_list
 {
     int len;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 79fbc6a8..9d961347 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -232,7 +232,7 @@ do_preresolve_host(struct context *c,
 void
 do_preresolve(struct context *c)
 {
-    int i;
+    int i, j;
     struct connection_list *l = c->options.connection_list;
     const unsigned int preresolve_flags = GETADDR_RESOLVE
                                           |GETADDR_UPDATE_MANAGEMENT_STATE
@@ -305,11 +305,19 @@ do_preresolve(struct context *c)
             }
         }
 
-        if (ce->bind_local)
+        flags |= GETADDR_PASSIVE;
+        flags &= ~GETADDR_RANDOMIZE;
+
+        for (j = 0; j < ce->local_list->len; j++)
         {
-            flags |= GETADDR_PASSIVE;
-            flags &= ~GETADDR_RANDOMIZE;
-            status = do_preresolve_host(c, ce->local, ce->local_port, ce->af, flags);
+            struct local_entry *le = ce->local_list->array[j];
+
+            if (!le->local)
+            {
+                continue;
+            }
+
+            status = do_preresolve_host(c, le->local, le->port, ce->af, flags);
             if (status != 0)
             {
                 goto err;
-- 
2.17.0


