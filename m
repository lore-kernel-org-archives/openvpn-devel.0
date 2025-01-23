From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 23 Jan 2025 15:44:29 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <0076c6acc2ed80a7af0e56e3f5e5b9ba9cd3d7a3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3cUZNG08w8E="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3cUZNG08w8E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

its_Giaan has uploaded a new patch set (#12) to the change originally creat=
ed by ordex. ( http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail )


Change subject: allow user to specify 'local' multiple times in config files
......................................................................

allow user to specify 'local' multiple times in config files

It is now possible to specify 'local' multiple times in a server
config to let it listen on multiple sockets (address:port) of
the same protocol.

Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M doc/man-sections/link-options.rst
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/socket.c
5 files changed, 184 insertions(+), 46 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/436/12

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index ca192c3..2667b93 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -106,13 +106,22 @@
   is not reliable. It is recommended to set tun-mtu with enough headroom
   instead.
=20
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
+  is returned by the OS).
+  On a client, or in point-to-point mode, this can only be specified once =
(1 socket).
+
+  On an OpenVPN setup running as ``--server``, this can be specified multi=
ple times
+  to open multiple listening sockets on different addresses and/or differe=
nt ports.
+  In order to specify multiple listen ports without specifying an address,=
 use '*'
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

-    c->c1.link_sockets_num =3D 1;
+    c->c1.link_sockets_num =3D c->options.ce.local_list->len;

     do_link_socket_addr_new(c);

@@ -4978,6 +4978,7 @@
     if (dest->mode =3D=3D CM_CHILD_UDP)
     {
         ASSERT(!dest->c2.link_sockets);
+        ASSERT(dest->options.ce.local_list);

         /* inherit buffers */
         dest->c2.buffers =3D src->c2.buffers;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ef4d78..c938999 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -124,7 +124,17 @@
     "--version       : Show copyright and version information.\n"
     "\n"
     "Tunnel Options:\n"
-    "--local host    : Local host name or ip address. Implies --bind.\n"
+    "--local host|* [port]: Local host name or IP address and port for bin=
d.\n"
+    "                        If specified, OpenVPN will bindto this addres=
s. If unspecified,\n"
+    "                        OpenVPN will bind to all interfaces. '*' can =
be used as hostname\n"
+    "                        and means 'any host' (OpenVPN will listen on =
what is returned by the OS).\n"
+    "                        On a client, or in point-to-point mode, this =
can only be specified once (1 socket).\n"
+    "                        On an OpenVPN setup running as ``--server``, =
this can be specified multiple times\n"
+    "                        to open multiple listening sockets on differe=
nt addresses and/or different ports.\n"
+    "                        In order to specify multiple listen ports wit=
hout specifying an address, use '*'\n"
+    "                        to signal 'use what the operating system give=
s you as default', for\n"
+    "                        'all IPv4 addresses' use '0.0.0.0', for 'all =
IPv6 addresses' use '::'.\n"
+    "                        ``--local`` implies ``--bind``.\n"
     "--remote host [port] : Remote host name or ip address.\n"
     "--remote-random : If multiple --remote options specified, choose one =
randomly.\n"
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
@@ -2354,6 +2400,15 @@
             "--proto tcp-server or --proto tcp-client");
     }

+    /*
+     * Sanity check on Client mode
+     */
+
+    if (options->mode !=3D MODE_SERVER && ce->local_list->len > 1)
+    {
+        msg(M_USAGE, "multiple --local statements only allowed in --server=
 mode");
+    }
+
     if (options->lladdr && dev !=3D DEV_TYPE_TAP)
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
         || string_defined_equal(ce->remote, options->ifconfig_remote_netma=
sk))
     {
@@ -2394,13 +2442,6 @@
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
+            msg(M_USAGE, "--remote and one of the --local addresses are th=
e same");
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
@@ -3128,7 +3186,7 @@
     }

     /* an option is present that requires local bind to enabled */
-    bool need_bind =3D ce->local || ce->local_port_defined || ce->bind_def=
ined;
+    bool need_bind =3D ce->local_port_defined || ce->bind_defined || ce->l=
ocal_list;

     /* socks proxy is enabled */
     bool uses_socks =3D ce->proto =3D=3D PROTO_UDP && ce->socks_proxy_serv=
er;
@@ -3264,6 +3322,16 @@
     }
 }

+static void
+options_postprocess_mutate_le(struct connection_entry ce, struct local_ent=
ry *le)
+{
+    /* use the global port if none is specified */
+    if (!le->port)
+    {
+        le->port =3D ce.local_port;
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
+        for (i =3D 0; i < o->ce.local_list->len; i++)
+        {
+            options_postprocess_mutate_le(o->ce, o->ce.local_list->array[i=
]);
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
@@ -6100,10 +6190,27 @@
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
+        }
+
+        if (p[2])
+        {
+            e->port =3D p[2];
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
     struct connection_list *l =3D c->options.connection_list;
     const unsigned int preresolve_flags =3D GETADDR_RESOLVE
                                           |GETADDR_UPDATE_MANAGEMENT_STATE
@@ -350,13 +349,13 @@
                                           |GETADDR_FATAL;


-    for (i =3D 0; i < l->len; ++i)
+    for (int i =3D 0; i < l->len; ++i)
     {
         int status;
         const char *remote;
         int flags =3D preresolve_flags;

-        struct connection_entry *ce =3D c->options.connection_list->array[=
i];
+        struct connection_entry *ce =3D l->array[i];

         if (proto_is_dgram(ce->proto))
         {
@@ -420,13 +419,23 @@
         {
             flags |=3D GETADDR_PASSIVE;
             flags &=3D ~GETADDR_RANDOMIZE;
-            status =3D do_preresolve_host(c, ce->local, ce->local_port,
-                                        ce->af, flags);
-            if (status !=3D 0)
-            {
-                goto err;
-            }

+            for (int j =3D 0; j < ce->local_list->len; j++)
+            {
+                struct local_entry *le =3D ce->local_list->array[j];
+
+                if (!le->local)
+                {
+                    continue;
+                }
+
+                status =3D do_preresolve_host(c, le->local, le->port, ce->=
af, flags);
+                if (status !=3D 0)
+                {
+                    goto err;
+                }
+
+            }
         }

     }
@@ -1882,8 +1891,8 @@
     const char *remote_host =3D o->ce.remote;
     const char *remote_port =3D o->ce.remote_port;

-    sock->local_host =3D o->ce.local;
-    sock->local_port =3D o->ce.local_port;
+    sock->local_host =3D o->ce.local_list->array[sock_index]->local;
+    sock->local_port =3D o->ce.local_list->array[sock_index]->port;
     sock->remote_host =3D remote_host;
     sock->remote_port =3D remote_port;
     sock->dns_cache =3D c->c1.dns_cache;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 12
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--3cUZNG08w8E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>its_Giaan <strong>uploaded patch set #12</strong> to the change original=
ly created by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/436?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">allow user to specify &#39;local&#39; mul=
tiple times in config files<br><br>It is now possible to specify &#39;local=
&#39; multiple times in a server<br>config to let it listen on multiple soc=
kets (address:port) of<br>the same protocol.<br><br>Change-Id: I4d1c96662c5=
a8c750d883e3b20adde09529e2764<br>Signed-off-by: Antonio Quartulli &lt;a@...493...=
2181...&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...=
&gt;<br>---<br>M doc/man-sections/link-options.rst<br>M src/openvpn/init.c<=
br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/sock=
et.c<br>5 files changed, 184 insertions(+), 46 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/436/12</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-optio=
ns.rst</span><br><span>index ca192c3..2667b93 100644</span><br><span>--- a/=
doc/man-sections/link-options.rst</span><br><span>+++ b/doc/man-sections/li=
nk-options.rst</span><br><span>@@ -106,13 +106,22 @@</span><br><span>   is =
not reliable. It is recommended to set tun-mtu with enough headroom</span><=
br><span>   instead.</span><br><span> </span><br><span>---local host</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  Local host name or IP addr=
ess for bind. If specified, OpenVPN will bind</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  to this address only. If unspecified, OpenVPN wil=
l bind to all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  interf=
aces.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--local host|*=
 [port]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Local host=
 name or IP address and port for bind. If specified, OpenVPN will bind</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  to this address. If un=
specified, OpenVPN will bind to all interfaces.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &#39;*&#39; can be used as hostname and means=
 &#39;any host&#39; (OpenVPN will listen on what</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  is returned by the OS). </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  On a client, or in point-to-point mod=
e, this can only be specified once (1 socket).</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  On an OpenVPN setup running as ``--server``, this can be specif=
ied multiple times</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 to open multiple listening sockets on different addresses and/or different=
 ports.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  In order t=
o specify multiple listen ports without specifying an address, use &#39;*&#=
39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to signal &quo=
t;use what the operating system gives you as default&quot;, for</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &quot;all IPv4 addresses&quot=
; use &quot;0.0.0.0&quot;, for &quot;all IPv6 addresses&quot; use &#39;::&#=
39;.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--local`` i=
mplies ``--bind``.</span><br><span> </span><br><span> --lport port</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  Set local TCP/UDP port numbe=
r or name. Cannot be used together with</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  Set default TCP/UDP port number. Cannot be used toget=
her with</span><br><span>   ``--nobind`` option.</span><br><span> </span><b=
r><span> --mark value</span><br><span>diff --git a/src/openvpn/init.c b/src=
/openvpn/init.c</span><br><span>index 9d1048c..4014517 100644</span><br><sp=
an>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span>=
<br><span>@@ -751,7 +751,7 @@</span><br><span> </span><br><span>     init_c=
onnection_list(c);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    c-&gt;c1.link_sockets_num =3D 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c1.link_sockets_num =3D c-&gt;o=
ptions.ce.local_list-&gt;len;</span><br><span> </span><br><span>     do_lin=
k_socket_addr_new(c);</span><br><span> </span><br><span>@@ -4978,6 +4978,7 =
@@</span><br><span>     if (dest-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><s=
pan>     {</span><br><span>         ASSERT(!dest-&gt;c2.link_sockets);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(dest-&gt;=
options.ce.local_list);</span><br><span> </span><br><span>         /* inher=
it buffers */</span><br><span>         dest-&gt;c2.buffers =3D src-&gt;c2.b=
uffers;</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/op=
tions.c</span><br><span>index 3ef4d78..c938999 100644</span><br><span>--- a=
/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><b=
r><span>@@ -124,7 +124,17 @@</span><br><span>     &quot;--version       : S=
how copyright and version information.\n&quot;</span><br><span>     &quot;\=
n&quot;</span><br><span>     &quot;Tunnel Options:\n&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &quot;--local host    : Local host=
 name or ip address. Implies --bind.\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;--local host|* [port]: Local host name o=
r IP address and port for bind.\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &quot;                        If specified, OpenVPN=
 will bindto this address. If unspecified,\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;                        OpenVPN wi=
ll bind to all interfaces. &#39;*&#39; can be used as hostname\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;              =
          and means &#39;any host&#39; (OpenVPN will listen on what is retu=
rned by the OS).\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;                        On a client, or in point-to-point mo=
de, this can only be specified once (1 socket).\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;                        On an=
 OpenVPN setup running as ``--server``, this can be specified multiple time=
s\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
                        to open multiple listening sockets on different add=
resses and/or different ports.\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;                        In order to specify mu=
ltiple listen ports without specifying an address, use &#39;*&#39;\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;          =
              to signal &#39;use what the operating system gives you as def=
ault&#39;, for\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;                        &#39;all IPv4 addresses&#39; use &#39;=
0.0.0.0&#39;, for &#39;all IPv6 addresses&#39; use &#39;::&#39;.\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;            =
            ``--local`` implies ``--bind``.\n&quot;</span><br><span>     &q=
uot;--remote host [port] : Remote host name or ip address.\n&quot;</span><b=
r><span>     &quot;--remote-random : If multiple --remote options specified=
, choose one randomly.\n&quot;</span><br><span>     &quot;--remote-random-h=
ostname : Add a random string to remote DNS name.\n&quot;</span><br><span>@=
@ -988,8 +998,9 @@</span><br><span>                         const int i)</s=
pan><br><span> {</span><br><span>     setenv_str_i(es, &quot;proto&quot;, p=
roto2ascii(e-&gt;proto, e-&gt;af, false), i);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local&quot;, e-&gt;local=
, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i=
(es, &quot;local_port&quot;, e-&gt;local_port, i);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* expected to be for single socket cont=
exts only */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set=
env_str_i(es, &quot;local&quot;, e-&gt;local_list-&gt;array[0]-&gt;local, i=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str_i(=
es, &quot;local_port&quot;, e-&gt;local_list-&gt;array[0]-&gt;port, i);</sp=
an><br><span>     setenv_str_i(es, &quot;remote&quot;, e-&gt;remote, i);</s=
pan><br><span>     setenv_str_i(es, &quot;remote_port&quot;, e-&gt;remote_p=
ort, i);</span><br><span> </span><br><span>@@ -1713,8 +1724,12 @@</span><br=
><span> show_connection_entry(const struct connection_entry *o)</span><br><=
span> {</span><br><span>     msg(D_SHOW_PARMS, &quot;  proto =3D %s&quot;, =
proto2ascii(o-&gt;proto, o-&gt;af, false));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_STR(local);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SHOW_STR(local_port);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  Local Sockets:&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; o-&gt;local_list-&gt;len; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(D_SHOW_PARMS, &quot;    [%s]:%s&quot;, o-&gt;local_l=
ist-&gt;array[i]-&gt;local,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            o-&gt;local_list-&gt;array[i]-&gt;port);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     SHOW_ST=
R(remote);</span><br><span>     SHOW_STR(remote_port);</span><br><span>    =
 SHOW_BOOL(remote_float);</span><br><span>@@ -2162,6 +2177,37 @@</span><br>=
<span> </span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct l=
ocal_list *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_lo=
cal_list_if_undef(struct connection_entry *ce, struct gc_arena *gc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!ce-&gt;local_list)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR_GC(ce-&gt;local_list, struc=
t local_list, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ce-&=
gt;local_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static struct local_entry *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+alloc_local_entry(struct connecti=
on_entry *ce, const int msglevel,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                  struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct local_list *l =3D alloc_local_list_if_undef(ce, =
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct loca=
l_entry *e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (l-&gt;len &gt;=3D C=
ONNECTION_LIST_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(m=
sglevel, &quot;Maximum number of &#39;local&#39; options (%d) exceeded&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CONNE=
CTION_LIST_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    l-&gt;array[l-&gt;=
len++] =3D e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return e;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> static struct connection_list *=
</span><br><span> alloc_connection_list_if_undef(struct options *options)</=
span><br><span> {</span><br><span>@@ -2354,6 +2400,15 @@</span><br><span>  =
           &quot;--proto tcp-server or --proto tcp-client&quot;);</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * Sanity check on Client mode</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&=
gt;mode !=3D MODE_SERVER &amp;&amp; ce-&gt;local_list-&gt;len &gt; 1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;multiple --l=
ocal statements only allowed in --server mode&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     if (options-&gt;lladdr &amp;&amp;=
 dev !=3D DEV_TYPE_TAP)</span><br><span>     {</span><br><span>         msg=
(M_USAGE, &quot;--lladdr can only be used in --dev tap mode&quot;);</span><=
br><span>@@ -2379,13 +2434,6 @@</span><br><span>      * Sanity check on --l=
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
e_netmask))</span><br><span>     {</span><br><span>@@ -2394,13 +2442,6 @@</=
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
pan><br><span>     {</span><br><span>@@ -2413,12 +2454,6 @@</span><br><span=
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
(M_USAGE,</span><br><span>@@ -2430,6 +2465,29 @@</span><br><span>         m=
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
AGE, &quot;--remote and one of the --local addresses are the same&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (string_defined_equal(le-&gt;local, opt=
ions-&gt;ifconfig_local)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            || string_defined_equal(le-&gt;local, options-&gt;ifconfig=
_remote_netmask))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(M_USAGE, &quot;--local addresses must be distinct from --ifconfig addre=
sses&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (le-&gt;local &amp;&amp; =
!ce-&gt;bind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(M_USAGE, &quot;--local and --nobind don&#39;t make sense when used to=
gether&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</spa=
n><br><span>      * Check for consistency of management options</span><br><=
span>      */</span><br><span>@@ -3128,7 +3186,7 @@</span><br><span>     }<=
/span><br><span> </span><br><span>     /* an option is present that require=
s local bind to enabled */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bool need_bind =3D ce-&gt;local || ce-&gt;local_port_defined || ce=
-&gt;bind_defined;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool need_bind =3D ce-&gt;local_port_defined || ce-&gt;bind_defined || c=
e-&gt;local_list;</span><br><span> </span><br><span>     /* socks proxy is =
enabled */</span><br><span>     bool uses_socks =3D ce-&gt;proto =3D=3D PRO=
TO_UDP &amp;&amp; ce-&gt;socks_proxy_server;</span><br><span>@@ -3264,6 +33=
22,16 @@</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+options_postprocess_mutate_le(stru=
ct connection_entry ce, struct local_entry *le)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* use the global port if none is specified */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!le-&gt;port)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        le-&gt;port =3D ce.local_port;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span> /* If iser=
vice is in use, we need def1 method for redirect-gateway */</span><br><span=
> static void</span><br><span>@@ -3705,6 +3773,28 @@</span><br><span>      =
   options_postprocess_mutate_ce(o, o-&gt;connection_list-&gt;array[i]);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (o-&gt;ce.local_list)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        for (i =3D 0; i &lt; o-&gt;ce.local_list-&gt;len; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            options_postproc=
ess_mutate_le(o-&gt;ce, o-&gt;ce.local_list-&gt;array[i]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 if no &#39;local&#39; directive was specified, convert the global port</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * setting to a=
 listen entry */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct local_entry *e =3D alloc_local_entry(&amp;o-&gt;ce, M_USAGE, &a=
mp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  ASSERT(e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 e-&gt;port =3D o-&gt;ce.local_port;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* use the s=
ame listen list for every outgoing connection */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; o-&gt;connection_list=
-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;conne=
ction_list-&gt;array[i]-&gt;local_list =3D o-&gt;ce.local_list;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     if (o-&gt;tls_server)</=
span><br><span>     {</span><br><span>         /* Check that DH file is spe=
cified, or explicitly disabled */</span><br><span>@@ -6100,10 +6190,27 @@</=
span><br><span>         VERIFY_PERMISSION(OPT_P_UP);</span><br><span>      =
   options-&gt;ifconfig_nowarn =3D true;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;lo=
cal&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;local&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct local_entry *e;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         VERIFY_=
PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        options-&gt;ce.local =3D p[1];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        e =3D alloc_local_entry(&amp;options-&gt;ce, =
M_USAGE, &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ASSERT(e);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* &#39;*&#39; is treated as &#39;ask the system to get some socket&#39;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * therefore f=
orce binding on a particular address only when</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * actually specified. */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (strcmp(p[1], &quot;*&q=
uot;) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e-&g=
t;local =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (p[2])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            e-&gt;port =3D p[2];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>  =
   }</span><br><span>     else if (streq(p[0], &quot;remote-random&quot;) &=
amp;&amp; !p[1])</span><br><span>     {</span><br><span>diff --git a/src/op=
envpn/options.h b/src/openvpn/options.h</span><br><span>index 55f12dd..3f4c=
b90 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ =
b/src/openvpn/options.h</span><br><span>@@ -94,14 +94,20 @@</span><br><span=
> #error &quot;At least one of OpenSSL or mbed TLS needs to be defined.&quo=
t;</span><br><span> #endif</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct local_entry</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *local;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *port;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> struct connection_entry</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct local_list *local_list;</span=
><br><span>     int proto;</span><br><span>     sa_family_t af;</span><br><=
span>     const char *local_port;</span><br><span>     bool local_port_defi=
ned;</span><br><span>     const char *remote_port;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const char *local;</span><br><span>     co=
nst char *remote;</span><br><span>     bool remote_float;</span><br><span> =
    bool bind_defined;</span><br><span>@@ -179,6 +185,12 @@</span><br><span=
> </span><br><span> #define CONNECTION_LIST_SIZE 64</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+struct local_list</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int len;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct local_entry *array[CONNECTION_LIST_SIZE];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct connection_=
list</span><br><span> {</span><br><span>     int capacity;</span><br><span>=
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>in=
dex 0c4a7bc..97dce02 100644</span><br><span>--- a/src/openvpn/socket.c</spa=
n><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -342,7 +342,6 @@<=
/span><br><span> void</span><br><span> do_preresolve(struct context *c)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t i;</span><br><span>     struct connection_list *l =3D c-&gt;options.conne=
ction_list;</span><br><span>     const unsigned int preresolve_flags =3D GE=
TADDR_RESOLVE</span><br><span>                                           |G=
ETADDR_UPDATE_MANAGEMENT_STATE</span><br><span>@@ -350,13 +349,13 @@</span>=
<br><span>                                           |GETADDR_FATAL;</span>=
<br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    for (i =3D 0; i &lt; l-&gt;len; ++i)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; ++i)</=
span><br><span>     {</span><br><span>         int status;</span><br><span>=
         const char *remote;</span><br><span>         int flags =3D prereso=
lve_flags;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        struct connection_entry *ce =3D c-&gt;options.connection_lis=
t-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct connection_entry *ce =3D l-&gt;array[i];</span><br><span> </span=
><br><span>         if (proto_is_dgram(ce-&gt;proto))</span><br><span>     =
    {</span><br><span>@@ -420,13 +419,23 @@</span><br><span>         {</spa=
n><br><span>             flags |=3D GETADDR_PASSIVE;</span><br><span>      =
       flags &amp;=3D ~GETADDR_RANDOMIZE;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            status =3D do_preresolve_host(c, ce-&gt;loc=
al, ce-&gt;local_port,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                        ce-&gt;af, flags);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (status !=3D 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (int=
 j =3D 0; j &lt; ce-&gt;local_list-&gt;len; j++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                struct local_entry *le =3D ce-&gt;lo=
cal_list-&gt;array[j];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
if (!le-&gt;local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 continue;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  status =3D do_preresolve_host(c, le-&gt;local, le-&gt;port, ce-&gt;af, fl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  if (status !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   goto err;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span>         }</span><br><span> </span><br><span>     }</span=
><br><span>@@ -1882,8 +1891,8 @@</span><br><span>     const char *remote_ho=
st =3D o-&gt;ce.remote;</span><br><span>     const char *remote_port =3D o-=
&gt;ce.remote_port;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    sock-&gt;local_host =3D o-&gt;ce.local;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;local_port =3D o-&gt;ce.=
local_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock=
-&gt;local_host =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;local;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;local_por=
t =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;port;</span><br><span> =
    sock-&gt;remote_host =3D remote_host;</span><br><span>     sock-&gt;rem=
ote_port =3D remote_port;</span><br><span>     sock-&gt;dns_cache =3D c-&gt=
;c1.dns_cache;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">change 436</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/436?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
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


--3cUZNG08w8E=--

