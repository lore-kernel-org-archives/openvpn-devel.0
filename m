From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 1 Oct 2024 15:30:04 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <3358afcb6e7cd3afb837c6237e2fa3a71ea9f1cf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x0Vr4hMnXYM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: allow user to
 specify 'local' multiple times in config files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x0Vr4hMnXYM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

its_Giaan has uploaded a new patch set (#3) to the change originally create=
d by ordex. ( http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: allow user to specify 'local' multiple times in config files
......................................................................

allow user to specify 'local' multiple times in config files

It is now possible to specify 'local' multiple times in a server
config to let it listen on multiple sockets (address:port) of
the same protocol.

Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M doc/man-sections/link-options.rst
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/socket.c
5 files changed, 177 insertions(+), 44 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/436/3

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index ca192c3..05909ca 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -106,10 +106,12 @@
   is not reliable. It is recommended to set tun-mtu with enough headroom
   instead.

---local host
-  Local host name or IP address for bind. If specified, OpenVPN will bind
-  to this address only. If unspecified, OpenVPN will bind to all
-  interfaces.
+--local host|* [port]
+  Local host name or IP address and port for bind. If specified, OpenVPN w=
ill bind
+  to this address. If unspecified, OpenVPN will bind to all interfaces.
+  '*' can be used as hostname and means 'any host' (OpenVPN will listen on=
 what
+  is returned by the OS). Implies --bind.
+  0.0.0.0 or :: can be used to specifically open a socket.

 --lport port
   Set local TCP/UDP port number or name. Cannot be used together with
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f406c0f..575b4d2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -742,7 +742,7 @@

     init_connection_list(c);

-    c->c1.link_sockets_num =3D 1;
+    c->c1.link_sockets_num =3D c->options.ce.local_list->len;

     do_link_socket_addr_new(c);

@@ -3859,8 +3859,8 @@

         /* init each socket with its specific port */
         link_socket_init_phase1(c->c2.link_sockets[i],
-                                c->options.ce.local,
-                                c->options.ce.local_port,
+                                c->options.ce.local_list->array[i]->local,
+                                c->options.ce.local_list->array[i]->port,
                                 c->options.ce.remote,
                                 c->options.ce.remote_port,
                                 c->c1.dns_cache,
@@ -3874,7 +3874,7 @@
 #ifdef ENABLE_DEBUG
                                 c->options.gremlin,
 #endif
-                                c->options.ce.bind_local,
+                                c->options.ce.local_list->array[i]->bind_l=
ocal,
                                 c->options.ce.remote_float,
                                 &c->c1.link_socket_addrs[i],
                                 c->options.ipchange,
@@ -5008,6 +5008,7 @@
     if (dest->mode =3D=3D CM_CHILD_UDP)
     {
         ASSERT(!dest->c2.link_sockets);
+        ASSERT(dest->options.ce.local_list);

         /* inherit buffers */
         dest->c2.buffers =3D src->c2.buffers;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61f6285..f216456 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -124,7 +124,13 @@
     "--version       : Show copyright and version information.\n"
     "\n"
     "Tunnel Options:\n"
-    "--local host    : Local host name or ip address. Implies --bind.\n"
+    "--local host|* [port] : Local host name or ip address and port. '*' c=
an be used\n"
+    "                        as hostname and means 'any host' (openvpn wil=
l listen on\n"
+    "                        what is returned by the OS). Implies --bind.\=
n"
+    "                        0.0.0.0 or :: can be used to specifically ope=
n a socket\n"
+    "                        listening on any IPv4 or IPv6 address respect=
ively.\n"
+    "                        The user can specify multiple --local entries=
 to have\n"
+    "                        a server listen on multiple sockets at the sa=
me time.\n"
     "--remote host [port] : Remote host name or ip address.\n"
     "--remote-random : If multiple --remote options specified, choose one =
randomly.\n"
     "--remote-random-hostname : Add a random string to remote DNS name.\n"
@@ -988,8 +994,9 @@
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

@@ -1713,8 +1720,12 @@
 show_connection_entry(const struct connection_entry *o)
 {
     msg(D_SHOW_PARMS, "  proto =3D %s", proto2ascii(o->proto, o->af, false=
));
-    SHOW_STR(local);
-    SHOW_STR(local_port);
+    msg(D_SHOW_PARMS, "  Local Sockets:");
+    for (int i =3D 0; i < o->local_list->len; i++)
+    {
+        msg(D_SHOW_PARMS, "    [%s]:%s", o->local_list->array[i]->local,
+            o->local_list->array[i]->port);
+    }
     SHOW_STR(remote);
     SHOW_STR(remote_port);
     SHOW_BOOL(remote_float);
@@ -2162,6 +2173,37 @@

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
+    struct local_list *l =3D alloc_local_list_if_undef(ce, gc);
+    struct local_entry *e;
+
+    if (l->len >=3D CONNECTION_LIST_SIZE)
+    {
+        msg(msglevel, "Maximum number of 'local' options (%d) exceeded",
+            CONNECTION_LIST_SIZE);
+
+        return NULL;
+    }
+
+    ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    l->array[l->len++] =3D e;
+
+    return e;
+}
+
 static struct connection_list *
 alloc_connection_list_if_undef(struct options *options)
 {
@@ -2354,6 +2396,15 @@
             "--proto tcp-server or --proto tcp-client");
     }

+    /*
+     * Sanity check on daemon mode
+     */
+
+    if (ce->remote && ce->local_list->len > 1)
+    {
+        msg(M_USAGE, "multiple --local do not make sense in Client mode");
+    }
+
     if (options->lladdr && dev !=3D DEV_TYPE_TAP)
     {
         msg(M_USAGE, "--lladdr can only be used in --dev tap mode");
@@ -2379,13 +2430,6 @@
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
         || string_defined_equal(ce->remote, options->ifconfig_remote_netma=
sk))
     {
@@ -2394,13 +2438,6 @@
             "addresses");
     }

-    if (string_defined_equal(ce->local, options->ifconfig_local)
-        || string_defined_equal(ce->local, options->ifconfig_remote_netmas=
k))
-    {
-        msg(M_USAGE,
-            "--local addresses must be distinct from --ifconfig addresses"=
);
-    }
-
     if (string_defined_equal(options->ifconfig_local,
                              options->ifconfig_remote_netmask))
     {
@@ -2413,12 +2450,6 @@
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
@@ -2430,6 +2461,29 @@
         msg(M_USAGE, "--nobind doesn't make sense unless used with --remot=
e");
     }

+    for (int i =3D 0; i < ce->local_list->len; i++)
+    {
+        struct local_entry *le =3D ce->local_list->array[i];
+
+        if (proto_is_net(ce->proto)
+            && string_defined_equal(le->local, ce->remote)
+            && string_defined_equal(le->port, ce->remote_port))
+        {
+            msg(M_USAGE, "--remote and a --local addresses are the same");
+        }
+
+        if (string_defined_equal(le->local, options->ifconfig_local)
+            || string_defined_equal(le->local, options->ifconfig_remote_ne=
tmask))
+        {
+            msg(M_USAGE, "--local addresses must be distinct from --ifconf=
ig addresses");
+        }
+
+        if (le->local && !ce->bind_local)
+        {
+            msg(M_USAGE, "--local and --nobind don't make sense when used =
together");
+        }
+    }
+
     /*
      * Check for consistency of management options
      */
@@ -3128,7 +3182,7 @@
     }

     /* an option is present that requires local bind to enabled */
-    bool need_bind =3D ce->local || ce->local_port_defined || ce->bind_def=
ined;
+    bool need_bind =3D ce->local_port_defined || ce->bind_defined;

     /* socks proxy is enabled */
     bool uses_socks =3D ce->proto =3D=3D PROTO_UDP && ce->socks_proxy_serv=
er;
@@ -3141,6 +3195,11 @@
         ce->bind_local =3D false;
     }

+    if (ce->proto =3D=3D PROTO_UDP && ce->socks_proxy_server && !ce->local=
_list && !ce->local_port_defined && !ce->bind_defined)
+    {
+        ce->bind_local =3D false;
+    }
+
     if (!ce->bind_local)
     {
         ce->local_port =3D NULL;
@@ -3264,6 +3323,16 @@
     }
 }

+static void
+options_postprocess_mutate_le(struct options *o, struct local_entry *le)
+{
+    /* use the global port if none is specified */
+    if (!le->port)
+    {
+        le->port =3D o->ce.local_port;
+    }
+}
+
 #ifdef _WIN32
 /* If iservice is in use, we need def1 method for redirect-gateway */
 static void
@@ -3738,6 +3807,29 @@
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
     }

+    if (o->ce.local_list)
+    {
+        for (i =3D 0; i < o->ce.local_list->len; i++)
+        {
+            options_postprocess_mutate_le(o, o->ce.local_list->array[i]);
+        }
+    }
+    else
+    {
+        /* if no 'local' directive was specified, convert the global port
+         * setting to a listen entry */
+        struct local_entry *e =3D alloc_local_entry(&o->ce, M_USAGE, &o->g=
c);
+        ASSERT(e);
+        e->port =3D o->ce.local_port;
+        e->bind_local =3D o->connection_list->array[0]->bind_local;
+    }
+
+    /* use the same listen list for every outgoing connection */
+    for (i =3D 0; i < o->connection_list->len; ++i)
+    {
+        o->connection_list->array[i]->local_list =3D o->ce.local_list;
+    }
+
     if (o->tls_server)
     {
         /* Check that DH file is specified, or explicitly disabled */
@@ -6140,10 +6232,29 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[2])
+    else if (streq(p[0], "local") && p[1] && !p[3])
     {
+        struct local_entry *e;
+
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.local =3D p[1];
+
+        e =3D alloc_local_entry(&options->ce, M_USAGE, &options->gc);
+        ASSERT(e);
+
+        /* '*' is treated as 'ask the system to get some socket',
+         * therefore force binding on a particular address only when
+         * actually specified. */
+        if (strcmp(p[1], "*") !=3D 0)
+        {
+            e->local =3D p[1];
+            e->bind_local =3D true;
+        }
+
+        if (p[2])
+        {
+            e->port =3D p[2];
+            e->bind_local =3D true;
+        }
     }
     else if (streq(p[0], "remote-random") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ee39dbb..6942455 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -94,14 +94,21 @@
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
@@ -179,6 +186,12 @@

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
index 8677472..8051a97 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -342,7 +342,6 @@
 void
 do_preresolve(struct context *c)
 {
-    int i;
     struct connection_list *l =3D c->options.connection_list;
     const unsigned int preresolve_flags =3D GETADDR_RESOLVE
                                           |GETADDR_UPDATE_MANAGEMENT_STATE
@@ -350,7 +349,7 @@
                                           |GETADDR_FATAL;


-    for (i =3D 0; i < l->len; ++i)
+    for (int i =3D 0; i < l->len; ++i)
     {
         int status;
         const char *remote;
@@ -416,12 +415,19 @@
             }
         }

-        if (ce->bind_local)
+        flags |=3D GETADDR_PASSIVE;
+        flags &=3D ~GETADDR_RANDOMIZE;
+
+        for (int j =3D 0; j < ce->local_list->len; j++)
         {
-            flags |=3D GETADDR_PASSIVE;
-            flags &=3D ~GETADDR_RANDOMIZE;
-            status =3D do_preresolve_host(c, ce->local, ce->local_port,
-                                        ce->af, flags);
+            struct local_entry *le =3D ce->local_list->array[j];
+
+            if (!le->local)
+            {
+                continue;
+            }
+
+            status =3D do_preresolve_host(c, le->local, le->port, ce->af, =
flags);
             if (status !=3D 0)
             {
                 goto err;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--x0Vr4hMnXYM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to the change originall=
y created by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
436?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">allow user to specify &#39;local&#39; multipl=
e times in config files<br><br>It is now possible to specify &#39;local&#39=
; multiple times in a server<br>config to let it listen on multiple sockets=
 (address:port) of<br>the same protocol.<br><br>Change-Id: I4d1c96662c5a8c7=
50d883e3b20adde09529e2764<br>Signed-off-by: Antonio Quartulli &lt;a@...2588...=
...&gt;<br>---<br>M doc/man-sections/link-options.rst<br>M src/openvpn/init=
.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/s=
ocket.c<br>5 files changed, 177 insertions(+), 44 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/436/3</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opt=
ions.rst</span><br><span>index ca192c3..05909ca 100644</span><br><span>--- =
a/doc/man-sections/link-options.rst</span><br><span>+++ b/doc/man-sections/=
link-options.rst</span><br><span>@@ -106,10 +106,12 @@</span><br><span>   i=
s not reliable. It is recommended to set tun-mtu with enough headroom</span=
><br><span>   instead.</span><br><span> </span><br><span>---local host</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  Local host name or IP ad=
dress for bind. If specified, OpenVPN will bind</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  to this address only. If unspecified, OpenVPN w=
ill bind to all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  inte=
rfaces.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--local host=
|* [port]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Local ho=
st name or IP address and port for bind. If specified, OpenVPN will bind</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  to this address. If =
unspecified, OpenVPN will bind to all interfaces.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &#39;*&#39; can be used as hostname and mea=
ns &#39;any host&#39; (OpenVPN will listen on what</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  is returned by the OS). Implies --bind.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  0.0.0.0 or :: can be=
 used to specifically open a socket.</span><br><span> </span><br><span> --l=
port port</span><br><span>   Set local TCP/UDP port number or name. Cannot =
be used together with</span><br><span>diff --git a/src/openvpn/init.c b/src=
/openvpn/init.c</span><br><span>index f406c0f..575b4d2 100644</span><br><sp=
an>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span>=
<br><span>@@ -742,7 +742,7 @@</span><br><span> </span><br><span>     init_c=
onnection_list(c);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    c-&gt;c1.link_sockets_num =3D 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c1.link_sockets_num =3D c-&gt;o=
ptions.ce.local_list-&gt;len;</span><br><span> </span><br><span>     do_lin=
k_socket_addr_new(c);</span><br><span> </span><br><span>@@ -3859,8 +3859,8 =
@@</span><br><span> </span><br><span>         /* init each socket with its =
specific port */</span><br><span>         link_socket_init_phase1(c-&gt;c2.=
link_sockets[i],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                           c-&gt;options.ce.local,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                c-&gt;options.=
ce.local_port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                           c-&gt;options.ce.local_list-&gt;array[i]-&gt;loc=
al,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                c-&gt;options.ce.local_list-&gt;array[i]-&gt;port,</span><b=
r><span>                                 c-&gt;options.ce.remote,</span><br=
><span>                                 c-&gt;options.ce.remote_port,</span=
><br><span>                                 c-&gt;c1.dns_cache,</span><br><=
span>@@ -3874,7 +3874,7 @@</span><br><span> #ifdef ENABLE_DEBUG</span><br><=
span>                                 c-&gt;options.gremlin,</span><br><spa=
n> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                    c-&gt;options.ce.bind_local,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                c-&gt;options.=
ce.local_list-&gt;array[i]-&gt;bind_local,</span><br><span>                =
                 c-&gt;options.ce.remote_float,</span><br><span>           =
                      &amp;c-&gt;c1.link_socket_addrs[i],</span><br><span> =
                                c-&gt;options.ipchange,</span><br><span>@@ =
-5008,6 +5008,7 @@</span><br><span>     if (dest-&gt;mode =3D=3D CM_CHILD_U=
DP)</span><br><span>     {</span><br><span>         ASSERT(!dest-&gt;c2.lin=
k_sockets);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ASSERT(dest-&gt;options.ce.local_list);</span><br><span> </span><br><span> =
        /* inherit buffers */</span><br><span>         dest-&gt;c2.buffers =
=3D src-&gt;c2.buffers;</span><br><span>diff --git a/src/openvpn/options.c =
b/src/openvpn/options.c</span><br><span>index 61f6285..f216456 100644</span=
><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/op=
tions.c</span><br><span>@@ -124,7 +124,13 @@</span><br><span>     &quot;--v=
ersion       : Show copyright and version information.\n&quot;</span><br><s=
pan>     &quot;\n&quot;</span><br><span>     &quot;Tunnel Options:\n&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--local host=
    : Local host name or ip address. Implies --bind.\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;--local host|* [port] : =
Local host name or ip address and port. &#39;*&#39; can be used\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;             =
           as hostname and means &#39;any host&#39; (openvpn will listen on=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot; =
                       what is returned by the OS). Implies --bind.\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;         =
               0.0.0.0 or :: can be used to specifically open a socket\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;      =
                  listening on any IPv4 or IPv6 address respectively.\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;       =
                 The user can specify multiple --local entries to have\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;      =
                  a server listen on multiple sockets at the same time.\n&q=
uot;</span><br><span>     &quot;--remote host [port] : Remote host name or =
ip address.\n&quot;</span><br><span>     &quot;--remote-random : If multipl=
e --remote options specified, choose one randomly.\n&quot;</span><br><span>=
     &quot;--remote-random-hostname : Add a random string to remote DNS nam=
e.\n&quot;</span><br><span>@@ -988,8 +994,9 @@</span><br><span>            =
             const int i)</span><br><span> {</span><br><span>     setenv_st=
r_i(es, &quot;proto&quot;, proto2ascii(e-&gt;proto, e-&gt;af, false), i);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &q=
uot;local&quot;, e-&gt;local, i);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    setenv_str_i(es, &quot;local_port&quot;, e-&gt;local_port, =
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* expected =
to be for single socket contexts only */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    setenv_str_i(es, &quot;local&quot;, e-&gt;local_li=
st-&gt;array[0]-&gt;local, i);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    setenv_str_i(es, &quot;local_port&quot;, e-&gt;local_list-&g=
t;array[0]-&gt;port, i);</span><br><span>     setenv_str_i(es, &quot;remote=
&quot;, e-&gt;remote, i);</span><br><span>     setenv_str_i(es, &quot;remot=
e_port&quot;, e-&gt;remote_port, i);</span><br><span> </span><br><span>@@ -=
1713,8 +1720,12 @@</span><br><span> show_connection_entry(const struct conn=
ection_entry *o)</span><br><span> {</span><br><span>     msg(D_SHOW_PARMS, =
&quot;  proto =3D %s&quot;, proto2ascii(o-&gt;proto, o-&gt;af, false));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(local);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(local_port);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS=
, &quot;  Local Sockets:&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; o-&gt;local_list-&gt;len; i++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;    =
[%s]:%s&quot;, o-&gt;local_list-&gt;array[i]-&gt;local,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            o-&gt;local_list-&gt;array[=
i]-&gt;port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span>     SHOW_STR(remote);</span><br><span>     SHOW_STR(remote=
_port);</span><br><span>     SHOW_BOOL(remote_float);</span><br><span>@@ -2=
162,6 +2173,37 @@</span><br><span> </span><br><span> #endif /* ifdef ENABLE=
_MANAGEMENT */</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static struct local_list *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+alloc_local_list_if_undef(struct connection_entry *ce, =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ce-&gt;l=
ocal_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR=
_GC(ce-&gt;local_list, struct local_list, gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return ce-&gt;local_list;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct =
local_entry *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_=
local_entry(struct connection_entry *ce, const int msglevel,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                  struct gc_arena =
*gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct local_list *l =3D allo=
c_local_list_if_undef(ce, gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct local_entry *e;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (l-&gt;len &gt;=3D CONNECTION_LIST_SIZE)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(msglevel, &quot;Maximum number of &#39;local&#39; =
options (%d) exceeded&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            CONNECTION_LIST_SIZE);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(e, s=
truct local_entry, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    l-&gt;array[l-&gt;len++] =3D e;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stati=
c struct connection_list *</span><br><span> alloc_connection_list_if_undef(=
struct options *options)</span><br><span> {</span><br><span>@@ -2354,6 +239=
6,15 @@</span><br><span>             &quot;--proto tcp-server or --proto tc=
p-client&quot;);</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * Sanity check on daemon mode</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ce-&gt;remote &amp;&amp; ce-&gt;local_list-&gt;len &gt; 1)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;multip=
le --local do not make sense in Client mode&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     if (options-&gt;lladdr &amp;&amp;=
 dev !=3D DEV_TYPE_TAP)</span><br><span>     {</span><br><span>         msg=
(M_USAGE, &quot;--lladdr can only be used in --dev tap mode&quot;);</span><=
br><span>@@ -2379,13 +2430,6 @@</span><br><span>      * Sanity check on --l=
ocal, --remote, and --ifconfig</span><br><span>      */</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_net(ce=
-&gt;proto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &a=
mp;&amp; string_defined_equal(ce-&gt;local, ce-&gt;remote)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; string_defined_equa=
l(ce-&gt;local_port, ce-&gt;remote_port))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(M_USAGE, &quot;--remote and --local addresses are the same&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (stri=
ng_defined_equal(ce-&gt;remote, options-&gt;ifconfig_local)</span><br><span=
>         || string_defined_equal(ce-&gt;remote, options-&gt;ifconfig_remot=
e_netmask))</span><br><span>     {</span><br><span>@@ -2394,13 +2438,6 @@</=
span><br><span>             &quot;addresses&quot;);</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (string_defined_equal(ce-&gt;local, options-&gt;ifconfig_local)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        || string_defined_equa=
l(ce-&gt;local, options-&gt;ifconfig_remote_netmask))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_USAGE,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            &quot;--local addresses must be distinct from --=
ifconfig addresses&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>     if (string_defined_equal(options-&gt;ifconfig_local,</span><br><=
span>                              options-&gt;ifconfig_remote_netmask))</s=
pan><br><span>     {</span><br><span>@@ -2413,12 +2450,6 @@</span><br><span=
>         msg(M_USAGE, &quot;--bind and --nobind can&#39;t be used together=
&quot;);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (ce-&gt;local &amp;&amp; !ce-&gt;bind_lo=
cal)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            &quot;--local and --no=
bind don&#39;t make sense when used together&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     if (ce-&gt;local_port_defined &amp;&a=
mp; !ce-&gt;bind_local)</span><br><span>     {</span><br><span>         msg=
(M_USAGE,</span><br><span>@@ -2430,6 +2461,29 @@</span><br><span>         m=
sg(M_USAGE, &quot;--nobind doesn&#39;t make sense unless used with --remote=
&quot;);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; ce-&gt;local_lis=
t-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct loc=
al_entry *le =3D ce-&gt;local_list-&gt;array[i];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (proto_is_net(ce-&gt;proto)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &amp;&amp; string_defined_equal(le=
-&gt;local, ce-&gt;remote)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &amp;&amp; string_defined_equal(le-&gt;port, ce-&gt;remo=
te_port))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_US=
AGE, &quot;--remote and a --local addresses are the same&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (string_defined_equal(le-&gt;local, options-&gt;=
ifconfig_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        || string_defined_equal(le-&gt;local, options-&gt;ifconfig_remote_n=
etmask))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_USA=
GE, &quot;--local addresses must be distinct from --ifconfig addresses&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (le-&gt;local &amp;&amp; !ce-&gt;b=
ind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_U=
SAGE, &quot;--local and --nobind don&#39;t make sense when used together&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><sp=
an>      * Check for consistency of management options</span><br><span>    =
  */</span><br><span>@@ -3128,7 +3182,7 @@</span><br><span>     }</span><br=
><span> </span><br><span>     /* an option is present that requires local b=
ind to enabled */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
bool need_bind =3D ce-&gt;local || ce-&gt;local_port_defined || ce-&gt;bind=
_defined;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool n=
eed_bind =3D ce-&gt;local_port_defined || ce-&gt;bind_defined;</span><br><s=
pan> </span><br><span>     /* socks proxy is enabled */</span><br><span>   =
  bool uses_socks =3D ce-&gt;proto =3D=3D PROTO_UDP &amp;&amp; ce-&gt;socks=
_proxy_server;</span><br><span>@@ -3141,6 +3195,11 @@</span><br><span>     =
    ce-&gt;bind_local =3D false;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;proto =
=3D=3D PROTO_UDP &amp;&amp; ce-&gt;socks_proxy_server &amp;&amp; !ce-&gt;lo=
cal_list &amp;&amp; !ce-&gt;local_port_defined &amp;&amp; !ce-&gt;bind_defi=
ned)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ce-&gt;bind_local =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (=
!ce-&gt;bind_local)</span><br><span>     {</span><br><span>         ce-&gt;=
local_port =3D NULL;</span><br><span>@@ -3264,6 +3323,16 @@</span><br><span=
>     }</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+options_postprocess_mutate_le(struct options *o, struct lo=
cal_entry *le)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* use the global p=
ort if none is specified */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!le-&gt;port)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    le-&gt;port =3D o-&gt;ce.local_port;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> #ifdef _WIN32</span><br><span> /* If iservice is in use, we need def=
1 method for redirect-gateway */</span><br><span> static void</span><br><sp=
an>@@ -3738,6 +3807,29 @@</span><br><span>         options_postprocess_muta=
te_ce(o, o-&gt;connection_list-&gt;array[i]);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
o-&gt;ce.local_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (=
i =3D 0; i &lt; o-&gt;ce.local_list-&gt;len; i++)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            options_postprocess_mutate_le(o, o-&gt;ce.l=
ocal_list-&gt;array[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* if no &#39;local&#39; directive w=
as specified, convert the global port</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * setting to a listen entry */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct local_entry *e =3D all=
oc_local_entry(&amp;o-&gt;ce, M_USAGE, &amp;o-&gt;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ASSERT(e);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        e-&gt;port =3D o-&gt;ce.local_por=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e-&gt;bin=
d_local =3D o-&gt;connection_list-&gt;array[0]-&gt;bind_local;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* use the same listen list for every outgoing connection */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i =
&lt; o-&gt;connection_list-&gt;len; ++i)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        o-&gt;connection_list-&gt;array[i]-&gt;local_list =3D o-&gt;=
ce.local_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   if (o-&gt;tls_server)</span><br><span>     {</span><br><span>         /*=
 Check that DH file is specified, or explicitly disabled */</span><br><span=
>@@ -6140,10 +6232,29 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_U=
P);</span><br><span>         options-&gt;ifconfig_nowarn =3D true;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e if (streq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0],=
 &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct loc=
al_entry *e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.loca=
l =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        e =3D alloc_local_e=
ntry(&amp;options-&gt;ce, M_USAGE, &amp;options-&gt;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(e);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* &#39;*&#39; is treated as &#39;ask the system t=
o get some socket&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         * therefore force binding on a particular address only when</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * actually sp=
ecified. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (strcmp(p[1], &quot;*&quot;) !=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            e-&gt;local =3D p[1];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            e-&gt;bind_local =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (p[2])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            e-&gt;port =3D p[2];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            e-&gt;bind_local =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><=
br><span>     else if (streq(p[0], &quot;remote-random&quot;) &amp;&amp; !p=
[1])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/option=
s.h b/src/openvpn/options.h</span><br><span>index ee39dbb..6942455 100644</=
span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvp=
n/options.h</span><br><span>@@ -94,14 +94,21 @@</span><br><span> #error &qu=
ot;At least one of OpenSSL or mbed TLS needs to be defined.&quot;</span><br=
><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+struct local_entry</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool bind_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 struct connection_entry</span><br><span> {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct local_list *local_list;</span><br><span>=
     int proto;</span><br><span>     sa_family_t af;</span><br><span>     c=
onst char *local_port;</span><br><span>     bool local_port_defined;</span>=
<br><span>     const char *remote_port;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const char *local;</span><br><span>     const char *r=
emote;</span><br><span>     bool remote_float;</span><br><span>     bool bi=
nd_defined;</span><br><span>@@ -179,6 +186,12 @@</span><br><span> </span><b=
r><span> #define CONNECTION_LIST_SIZE 64</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+struct local_list</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int len;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct local_entry *array[CONNECTION_LIST_SIZE];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> struct connection_list</span>=
<br><span> {</span><br><span>     int capacity;</span><br><span>diff --git =
a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 8677472=
..8051a97 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span=
>+++ b/src/openvpn/socket.c</span><br><span>@@ -342,7 +342,6 @@</span><br><=
span> void</span><br><span> do_preresolve(struct context *c)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span>=
<br><span>     struct connection_list *l =3D c-&gt;options.connection_list;=
</span><br><span>     const unsigned int preresolve_flags =3D GETADDR_RESOL=
VE</span><br><span>                                           |GETADDR_UPDA=
TE_MANAGEMENT_STATE</span><br><span>@@ -350,7 +349,7 @@</span><br><span>   =
                                        |GETADDR_FATAL;</span><br><span> </=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    f=
or (i =3D 0; i &lt; l-&gt;len; ++i)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; ++i)</span><br><spa=
n>     {</span><br><span>         int status;</span><br><span>         cons=
t char *remote;</span><br><span>@@ -416,12 +415,19 @@</span><br><span>     =
        }</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (ce-&gt;bind_local)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D GETADDR_PASS=
IVE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags &=
amp;=3D ~GETADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
 (int j =3D 0; j &lt; ce-&gt;local_list-&gt;len; j++)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            flag=
s |=3D GETADDR_PASSIVE;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            flags &amp;=3D ~GETADDR_RANDOMIZE;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            status =3D do_preresolve_host(c, ce-=
&gt;local, ce-&gt;local_port,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                        ce-&gt;af, flags);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            struct local_ent=
ry *le =3D ce-&gt;local_list-&gt;array[j];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!le-&gt;local)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                continue;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  status =3D do_preresolve_host(c, le-&gt;local, le-&gt;port, ce-&gt;af, fl=
ags);</span><br><span>             if (status !=3D 0)</span><br><span>     =
        {</span><br><span>                 goto err;</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/436?usp=3Demail">change 436</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--x0Vr4hMnXYM=--

