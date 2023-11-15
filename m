From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:13 +0000
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <13d3eb64cbd8db5e2a30be372713eb8710bfa4ea-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g9BEIKiCE1g="; charset=UTF-8
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

--g9BEIKiCE1g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail

to review the following change.


Change subject: allow user to specify 'local' multiple times in config files
......................................................................

allow user to specify 'local' multiple times in config files

It is now possible to specify 'local' multiple times in a server
config to let it listen on multiple sockets (address:port) of
the same protocol.

Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/socket.c
4 files changed, 171 insertions(+), 39 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/436/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8dd01f..659c9e3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -745,7 +745,7 @@

     init_connection_list(c);

-    c->c1.link_sockets_num =3D 1;
+    c->c1.link_sockets_num =3D c->options.ce.local_list->len;

     do_link_socket_addr_new(c);

@@ -3821,8 +3821,8 @@

         /* init each socket with its specific port */
         link_socket_init_phase1(c->c2.link_sockets[i],
-                                c->options.ce.local,
-                                c->options.ce.local_port,
+                                c->options.ce.local_list->array[i]->local,
+                                c->options.ce.local_list->array[i]->port,
                                 c->options.ce.remote,
                                 c->options.ce.remote_port,
                                 c->c1.dns_cache,
@@ -3836,7 +3836,7 @@
 #ifdef ENABLE_DEBUG
                                 c->options.gremlin,
 #endif
-                                c->options.ce.bind_local,
+                                c->options.ce.local_list->array[i]->bind_l=
ocal,
                                 c->options.ce.remote_float,
                                 &c->c1.link_socket_addrs[i],
                                 c->options.ipchange,
@@ -4978,6 +4978,7 @@
     if (dest->mode =3D=3D CM_CHILD_UDP)
     {
         ASSERT(!dest->c2.link_sockets);
+        ASSERT(dest->options.ce.local_list);

         /* inherit buffers */
         dest->c2.buffers =3D src->c2.buffers;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b88fea9..9611423 100644
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
@@ -982,8 +988,9 @@
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

@@ -1701,8 +1708,12 @@
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
@@ -2151,6 +2162,37 @@

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
@@ -2343,6 +2385,15 @@
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
@@ -2368,13 +2419,6 @@
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
@@ -2383,13 +2427,6 @@
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
@@ -2402,12 +2439,6 @@
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
@@ -2419,6 +2450,29 @@
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
@@ -3112,7 +3166,7 @@
     }

     /* an option is present that requires local bind to enabled */
-    bool need_bind =3D ce->local || ce->local_port_defined || ce->bind_def=
ined;
+    bool need_bind =3D ce->local_port_defined || ce->bind_defined;

     /* socks proxy is enabled */
     bool uses_socks =3D ce->proto =3D=3D PROTO_UDP && ce->socks_proxy_serv=
er;
@@ -3125,6 +3179,11 @@
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
@@ -3245,6 +3304,16 @@
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
@@ -3691,6 +3760,29 @@
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
+        e->bind_local =3D o->ce.bind_local;
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
@@ -6072,10 +6164,29 @@
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
index 5a37316..747ed56 100644
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
index 17bd263..5d9e111 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -342,7 +342,7 @@
 void
 do_preresolve(struct context *c)
 {
-    int i;
+    int i, j;
     struct connection_list *l =3D c->options.connection_list;
     const unsigned int preresolve_flags =3D GETADDR_RESOLVE
                                           |GETADDR_UPDATE_MANAGEMENT_STATE
@@ -416,12 +416,19 @@
             }
         }

-        if (ce->bind_local)
+        flags |=3D GETADDR_PASSIVE;
+        flags &=3D ~GETADDR_RANDOMIZE;
+
+        for (j =3D 0; j < ce->local_list->len; j++)
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
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--g9BEIKiCE1g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">allow user to specify &#39;local&#39; multiple times in confi=
g files<br><br>It is now possible to specify &#39;local&#39; multiple times=
 in a server<br>config to let it listen on multiple sockets (address:port) =
of<br>the same protocol.<br><br>Change-Id: I4d1c96662c5a8c750d883e3b20adde0=
9529e2764<br>Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>---<b=
r>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M src/openvpn/options.=
h<br>M src/openvpn/socket.c<br>4 files changed, 171 insertions(+), 39 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/36/436/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</=
span><br><span>index f8dd01f..659c9e3 100644</span><br><span>--- a/src/open=
vpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -745=
,7 +745,7 @@</span><br><span> </span><br><span>     init_connection_list(c)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  c-&gt;c1.link_sockets_num =3D 1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    c-&gt;c1.link_sockets_num =3D c-&gt;options.ce.local_lis=
t-&gt;len;</span><br><span> </span><br><span>     do_link_socket_addr_new(c=
);</span><br><span> </span><br><span>@@ -3821,8 +3821,8 @@</span><br><span>=
 </span><br><span>         /* init each socket with its specific port */</s=
pan><br><span>         link_socket_init_phase1(c-&gt;c2.link_sockets[i],</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
        c-&gt;options.ce.local,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                c-&gt;options.ce.local_port,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
        c-&gt;options.ce.local_list-&gt;array[i]-&gt;local,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                c-&=
gt;options.ce.local_list-&gt;array[i]-&gt;port,</span><br><span>           =
                      c-&gt;options.ce.remote,</span><br><span>            =
                     c-&gt;options.ce.remote_port,</span><br><span>        =
                         c-&gt;c1.dns_cache,</span><br><span>@@ -3836,7 +38=
36,7 @@</span><br><span> #ifdef ENABLE_DEBUG</span><br><span>              =
                   c-&gt;options.gremlin,</span><br><span> #endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
 c-&gt;options.ce.bind_local,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                c-&gt;options.ce.local_list-&gt;a=
rray[i]-&gt;bind_local,</span><br><span>                                 c-=
&gt;options.ce.remote_float,</span><br><span>                              =
   &amp;c-&gt;c1.link_socket_addrs[i],</span><br><span>                    =
             c-&gt;options.ipchange,</span><br><span>@@ -4978,6 +4978,7 @@<=
/span><br><span>     if (dest-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span=
>     {</span><br><span>         ASSERT(!dest-&gt;c2.link_sockets);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(dest-&gt;opt=
ions.ce.local_list);</span><br><span> </span><br><span>         /* inherit =
buffers */</span><br><span>         dest-&gt;c2.buffers =3D src-&gt;c2.buff=
ers;</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/optio=
ns.c</span><br><span>index b88fea9..9611423 100644</span><br><span>--- a/sr=
c/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><=
span>@@ -124,7 +124,13 @@</span><br><span>     &quot;--version       : Show=
 copyright and version information.\n&quot;</span><br><span>     &quot;\n&q=
uot;</span><br><span>     &quot;Tunnel Options:\n&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &quot;--local host    : Local host na=
me or ip address. Implies --bind.\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;--local host|* [port] : Local host name or =
ip address and port. &#39;*&#39; can be used\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;                        as host=
name and means &#39;any host&#39; (openvpn will listen on\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                   =
     what is returned by the OS). Implies --bind.\n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;                        0.0=
.0.0 or :: can be used to specifically open a socket\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;                        =
listening on any IPv4 or IPv6 address respectively.\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;                        T=
he user can specify multiple --local entries to have\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;                        =
a server listen on multiple sockets at the same time.\n&quot;</span><br><sp=
an>     &quot;--remote host [port] : Remote host name or ip address.\n&quot=
;</span><br><span>     &quot;--remote-random : If multiple --remote options=
 specified, choose one randomly.\n&quot;</span><br><span>     &quot;--remot=
e-random-hostname : Add a random string to remote DNS name.\n&quot;</span><=
br><span>@@ -982,8 +988,9 @@</span><br><span>                         const=
 int i)</span><br><span> {</span><br><span>     setenv_str_i(es, &quot;prot=
o&quot;, proto2ascii(e-&gt;proto, e-&gt;af, false), i);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local&quot;, e=
-&gt;local, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    se=
tenv_str_i(es, &quot;local_port&quot;, e-&gt;local_port, i);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* expected to befor single so=
cket contexts only */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    setenv_str_i(es, &quot;local&quot;, e-&gt;local_list-&gt;array[0]-&gt=
;local, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sete=
nv_str_i(es, &quot;local_port&quot;, e-&gt;local_list-&gt;array[0]-&gt;port=
, i);</span><br><span>     setenv_str_i(es, &quot;remote&quot;, e-&gt;remot=
e, i);</span><br><span>     setenv_str_i(es, &quot;remote_port&quot;, e-&gt=
;remote_port, i);</span><br><span> </span><br><span>@@ -1701,8 +1708,12 @@<=
/span><br><span> show_connection_entry(const struct connection_entry *o)</s=
pan><br><span> {</span><br><span>     msg(D_SHOW_PARMS, &quot;  proto =3D %=
s&quot;, proto2ascii(o-&gt;proto, o-&gt;af, false));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(local);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(local_port);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot;  Local S=
ockets:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int i =3D 0; i &lt; o-&gt;local_list-&gt;len; i++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;    [%s]:%s&quot;, o-=
&gt;local_list-&gt;array[i]-&gt;local,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            o-&gt;local_list-&gt;array[i]-&gt;port);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
    SHOW_STR(remote);</span><br><span>     SHOW_STR(remote_port);</span><br=
><span>     SHOW_BOOL(remote_float);</span><br><span>@@ -2151,6 +2162,37 @@=
</span><br><span> </span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic struct local_list *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+alloc_local_list_if_undef(struct connection_entry *ce, struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!ce-&gt;local_list)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR_GC(ce-&gt;local_=
list, struct local_list, gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return ce-&gt;local_list;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static struct local_entry *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_local_entry(struc=
t connection_entry *ce, const int msglevel,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                  struct gc_arena *gc)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct local_list *l =3D alloc_local_list_if_u=
ndef(ce, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct local_entry *e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (l-&gt;len =
&gt;=3D CONNECTION_LIST_SIZE)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(msglevel, &quot;Maximum number of &#39;local&#39; options (%d) exce=
eded&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    CONNECTION_LIST_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(e, struct local_entry=
, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    l-&gt;arr=
ay[l-&gt;len++] =3D e;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return e;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static struct connecti=
on_list *</span><br><span> alloc_connection_list_if_undef(struct options *o=
ptions)</span><br><span> {</span><br><span>@@ -2343,6 +2385,15 @@</span><br=
><span>             &quot;--proto tcp-server or --proto tcp-client&quot;);<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * Sanity check on daemon mode</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ce-&gt;remote &amp;&amp; ce-&gt;local_list-&gt;len &gt; 1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;multiple --local do not=
 make sense in Client mode&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     if (options-&gt;lladdr &amp;&amp; dev !=3D DEV_TYPE_=
TAP)</span><br><span>     {</span><br><span>         msg(M_USAGE, &quot;--l=
laddr can only be used in --dev tap mode&quot;);</span><br><span>@@ -2368,1=
3 +2419,6 @@</span><br><span>      * Sanity check on --local, --remote, and=
 --ifconfig</span><br><span>      */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_net(ce-&gt;proto)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; string_def=
ined_equal(ce-&gt;local, ce-&gt;remote)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        &amp;&amp; string_defined_equal(ce-&gt;local_port=
, ce-&gt;remote_port))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_U=
SAGE, &quot;--remote and --local addresses are the same&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     if (string_defined_equal(ce=
-&gt;remote, options-&gt;ifconfig_local)</span><br><span>         || string=
_defined_equal(ce-&gt;remote, options-&gt;ifconfig_remote_netmask))</span><=
br><span>     {</span><br><span>@@ -2383,13 +2427,6 @@</span><br><span>    =
         &quot;addresses&quot;);</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (string_defined_=
equal(ce-&gt;local, options-&gt;ifconfig_local)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        || string_defined_equal(ce-&gt;local, opt=
ions-&gt;ifconfig_remote_netmask))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &quot;--local addresses must be distinct from --ifconfig addresses&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (stri=
ng_defined_equal(options-&gt;ifconfig_local,</span><br><span>              =
                options-&gt;ifconfig_remote_netmask))</span><br><span>     =
{</span><br><span>@@ -2402,12 +2439,6 @@</span><br><span>         msg(M_USA=
GE, &quot;--bind and --nobind can&#39;t be used together&quot;);</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (ce-&gt;local &amp;&amp; !ce-&gt;bind_local)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_USAGE,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            &quot;--local and --nobind don&#39;t make=
 sense when used together&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     if (ce-&gt;local_port_defined &amp;&amp; !ce-&gt;bind_loc=
al)</span><br><span>     {</span><br><span>         msg(M_USAGE,</span><br>=
<span>@@ -2419,6 +2450,29 @@</span><br><span>         msg(M_USAGE, &quot;--=
nobind doesn&#39;t make sense unless used with --remote&quot;);</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int i =3D 0; i &lt; ce-&gt;local_list-&gt;len; i++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct local_entry *le =3D ce-=
&gt;local_list-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (proto_is_net(ce-&gt;proto)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &amp;&amp; string_defined_equal(le-&gt;local, ce-&gt;r=
emote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
amp;&amp; string_defined_equal(le-&gt;port, ce-&gt;remote_port))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE, &quot;--remote =
and a --local addresses are the same&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (string_defined_equal(le-&gt;local, options-&gt;ifconfig_local)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            || string_de=
fined_equal(le-&gt;local, options-&gt;ifconfig_remote_netmask))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE, &quot;--local ad=
dresses must be distinct from --ifconfig addresses&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (le-&gt;local &amp;&amp; !ce-&gt;bind_local)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE, &quot;--local =
and --nobind don&#39;t make sense when used together&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     /*</span><br><span>      * Check for=
 consistency of management options</span><br><span>      */</span><br><span=
>@@ -3112,7 +3166,7 @@</span><br><span>     }</span><br><span> </span><br><=
span>     /* an option is present that requires local bind to enabled */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool need_bind =3D c=
e-&gt;local || ce-&gt;local_port_defined || ce-&gt;bind_defined;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool need_bind =3D ce-&gt;=
local_port_defined || ce-&gt;bind_defined;</span><br><span> </span><br><spa=
n>     /* socks proxy is enabled */</span><br><span>     bool uses_socks =
=3D ce-&gt;proto =3D=3D PROTO_UDP &amp;&amp; ce-&gt;socks_proxy_server;</sp=
an><br><span>@@ -3125,6 +3179,11 @@</span><br><span>         ce-&gt;bind_lo=
cal =3D false;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;proto =3D=3D PROTO_UDP &=
amp;&amp; ce-&gt;socks_proxy_server &amp;&amp; !ce-&gt;local_list &amp;&amp=
; !ce-&gt;local_port_defined &amp;&amp; !ce-&gt;bind_defined)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ce-&gt;bind_local =3D false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!ce-&gt;bind_local=
)</span><br><span>     {</span><br><span>         ce-&gt;local_port =3D NUL=
L;</span><br><span>@@ -3245,6 +3304,16 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
ptions_postprocess_mutate_le(struct options *o, struct local_entry *le)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* use the global port if none is spe=
cified */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!l=
e-&gt;port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        le-&gt;port =
=3D o-&gt;ce.local_port;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _W=
IN32</span><br><span> /* If iservice is in use, we need def1 method for red=
irect-gateway */</span><br><span> static void</span><br><span>@@ -3691,6 +3=
760,29 @@</span><br><span>         options_postprocess_mutate_ce(o, o-&gt;c=
onnection_list-&gt;array[i]);</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;ce.local_l=
ist)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; =
o-&gt;ce.local_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            options_postprocess_mutate_le(o, o-&gt;ce.local_list-&gt;ar=
ray[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* if no &#39;local&#39; directive was specified, co=
nvert the global port</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * setting to a listen entry */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct local_entry *e =3D alloc_local_entry(&=
amp;o-&gt;ce, M_USAGE, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ASSERT(e);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        e-&gt;port =3D o-&gt;ce.local_port;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        e-&gt;bind_local =3D o-&g=
t;ce.bind_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* use the same listen list for =
every outgoing connection */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        o-&gt;connection_list-&gt;array=
[i]-&gt;local_list =3D o-&gt;ce.local_list;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     if (o-&gt;tls_server)</span><br><span>     =
{</span><br><span>         /* Check that DH file is specified, or explicitl=
y disabled */</span><br><span>@@ -6072,10 +6164,29 @@</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_UP);</span><br><span>         options-&gt;ifcon=
fig_nowarn =3D true;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;local&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (streq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&amp;=
 !p[3])</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct local_entry *e;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>         VERIFY_PERMISSION(OPT_P_GEN=
ERAL|OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        options-&gt;ce.local =3D p[1];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        e =3D alloc_local_entry(&amp;options-&gt;ce, M_USAGE, &amp;option=
s-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        A=
SSERT(e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* &#39;*&#39; is tre=
ated as &#39;ask the system to get some socket&#39;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * therefore force binding on a p=
articular address only when</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * actually specified. */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (strcmp(p[1], &quot;*&quot;) !=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            e-&gt;local =3D p[1];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e-&gt;bin=
d_local =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (p[2])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            e-&gt;port =3D p[2];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            e-&gt;bind_local=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;rem=
ote-random&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>=
index 5a37316..747ed56 100644</span><br><span>--- a/src/openvpn/options.h</=
span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -94,14 +94,21=
 @@</span><br><span> #error &quot;At least one of OpenSSL or mbed TLS needs=
 to be defined.&quot;</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+struct local_entry</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *local;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *port;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool bind_local;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> struct connection_entry</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct local_lis=
t *local_list;</span><br><span>     int proto;</span><br><span>     sa_fami=
ly_t af;</span><br><span>     const char *local_port;</span><br><span>     =
bool local_port_defined;</span><br><span>     const char *remote_port;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *local;</sp=
an><br><span>     const char *remote;</span><br><span>     bool remote_floa=
t;</span><br><span>     bool bind_defined;</span><br><span>@@ -179,6 +186,1=
2 @@</span><br><span> </span><br><span> #define CONNECTION_LIST_SIZE 64</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+struc=
t local_list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int len;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct local_entry *array[CO=
NNECTION_LIST_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> struct connection_list</span><br><span> {</span><br><span>     int capaci=
ty;</span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.=
c</span><br><span>index 17bd263..5d9e111 100644</span><br><span>--- a/src/o=
penvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>=
@@ -342,7 +342,7 @@</span><br><span> void</span><br><span> do_preresolve(st=
ruct context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int i, j;</span><br><span>     struct connection_list *l =3D c-&gt=
;options.connection_list;</span><br><span>     const unsigned int preresolv=
e_flags =3D GETADDR_RESOLVE</span><br><span>                               =
            |GETADDR_UPDATE_MANAGEMENT_STATE</span><br><span>@@ -416,12 +41=
6,19 @@</span><br><span>             }</span><br><span>         }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c=
e-&gt;bind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      flags |=3D GETADDR_PASSIVE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        flags &amp;=3D ~GETADDR_RANDOMIZE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        for (j =3D 0; j &lt; ce-&gt;local_list-&gt;len; j=
++)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            flags |=3D GETADDR_PASSIVE;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            flags &amp;=3D ~GETADDR_RANDOMIZE;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            status =3D =
do_preresolve_host(c, ce-&gt;local, ce-&gt;local_port,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                        ce=
-&gt;af, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         struct local_entry *le =3D ce-&gt;local_list-&gt;array[j];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!le-&gt;local)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            status =3D do_preresolve_host(c, le-&gt;local, l=
e-&gt;port, ce-&gt;af, flags);</span><br><span>             if (status !=3D=
 0)</span><br><span>             {</span><br><span>                 goto er=
r;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/436?usp=3Demail">change 436</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/436?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--g9BEIKiCE1g=--

