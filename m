From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Jun 2025 11:36:22 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <e7952558a7909515c82943d94128d69fc0a25c08-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Djs4vVSj9Cg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Route: add support
 for user defined routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Djs4vVSj9Cg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/52=
4?usp=3Demail )

Change subject: Route: add support for user defined routing table
......................................................................

Route: add support for user defined routing table

Add the ability for users to specify a custom
routing table where routes should be installed in.
As of now routes are always installed in the main
routing table of the operating system, however,
with the new --route-table option it is possibile
to specify the ID of the default routing table
to be used by --route(-ipv6).

Please note: this feature is currently supported
only by Linux/SITNL.
Support for other platforms should be added in related backends.

Trac #1399
Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250622110311.1140-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
946.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/vpn-network-options.rst
M src/openvpn/helper.c
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/route.c
M src/openvpn/route.h
7 files changed, 68 insertions(+), 20 deletions(-)




diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 40b8c19..4a64e8d 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -389,6 +389,14 @@
   Like ``--redirect-gateway``, but omit actually changing the default gate=
way.
   Useful when pushing private subnets.

+--route-table id
+  Specify a default table id for use with --route.
+  By default, OpenVPN installs routes in the main routing
+  table of the operating system, but with this option,
+  a user defined routing table can be used instead.
+
+  (Supported on Linux only, on other platforms this is a no-op).
+
 --route args
   Add route to routing table after connection is established. Multiple
   routes can be specified. Routes will be automatically torn down in
@@ -463,14 +471,20 @@
   Setup IPv6 routing in the system to send the specified IPv6 network into
   OpenVPN's *tun*.

-  Valid syntax:
+  Valid syntaxes:
   ::

-     route-ipv6 ipv6addr/bits [gateway] [metric]
+     route-ipv6 ipv6addr/bits
+     route-ipv6 ipv6addr/bits gateway
+     route-ipv6 ipv6addr/bits gateway metric

-  The gateway parameter is only used for IPv6 routes across *tap* devices,
-  and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or
-  ``--route-ipv6-gateway`` is used.
+  ``gateway``
+        Only used for IPv6 routes across *tap* devices,
+        and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` =
or
+        ``--route-ipv6-gateway`` is used.
+
+  ``metric``
+        default taken from ``--route-metric`` if set, otherwise :code:`0`.

 --route-gateway arg
   Specify a default *gateway* for use with ``--route``.
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 8761826..7cef9db 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -118,7 +118,8 @@
                              print_in_addr_t(network, 0, &o->gc),
                              print_in_addr_t(netmask, 0, &o->gc),
                              NULL,
-                             NULL);
+                             NULL,
+                             o->route_default_table_id);
 }

 static void
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7d4eb85..77747a2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1566,7 +1566,7 @@
         {
             add_route_ipv6_to_option_list( options->routes_ipv6,
                                            string_alloc(opt_list[i], optio=
ns->routes_ipv6->gc),
-                                           NULL, NULL );
+                                           NULL, NULL, options->route_defa=
ult_table_id);
         }
     }

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3cf8c2a..7e26069 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -213,6 +213,10 @@
     "                    pass --ifconfig parms by environment to scripts.\=
n"
     "--ifconfig-nowarn : Don't warn if the --ifconfig option on this side =
of the\n"
     "                    connection doesn't match the remote side.\n"
+#ifdef TARGET_LINUX
+    "--route-table table_id : Specify a custom routing table for use with =
--route(-ipv6).\n"
+    "                           If not specified, the id of the default ro=
uting table will be used.\n"
+#endif
     "--route network [netmask] [gateway] [metric] :\n"
     "                  Add route to routing table after connection\n"
     "                  is established.  Multiple routes can be specified.\=
n"
@@ -829,6 +833,7 @@
     o->ce.mssfix =3D 0;
     o->ce.mssfix_default =3D true;
     o->ce.mssfix_encap =3D true;
+    o->route_default_table_id =3D 0;
     o->route_delay_window =3D 30;
     o->resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;
     o->resolve_in_advance =3D false;
@@ -1799,6 +1804,7 @@
     SHOW_STR(route_script);
     SHOW_STR(route_default_gateway);
     SHOW_INT(route_default_metric);
+    SHOW_INT(route_default_table_id);
     SHOW_BOOL(route_noexec);
     SHOW_INT(route_delay);
     SHOW_INT(route_delay_window);
@@ -7064,6 +7070,14 @@
         cnol_check_alloc(options);
         add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3=
], p[4], msglevel);
     }
+    else if (streq(p[0], "route-table") && p[1] && !p[2])
+    {
+#ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --route-table is supported only on Linux when S=
ITNL is built-in");
+#endif
+        VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);
+        options->route_default_table_id =3D positive_atoi(p[1], msglevel);
+    }
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
@@ -7085,8 +7099,9 @@
                 msg(msglevel, "route parameter gateway '%s' must be a vali=
d address", p[3]);
                 goto err;
             }
+            /* p[4] is metric, if specified */
         }
-        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4]);
+        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4], =
options->route_default_table_id);
     }
     else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
     {
@@ -7104,9 +7119,9 @@
                 msg(msglevel, "route-ipv6 parameter gateway '%s' must be a=
 valid address", p[2]);
                 goto err;
             }
-            /* p[3] is metric, if present */
+            /* p[3] is metric, if specified */
         }
-        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[=
3]);
+        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[=
3], options->route_default_table_id);
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 46ec32b..56e85d7 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -427,6 +427,7 @@
     const char *route_predown_script;
     const char *route_default_gateway;
     const char *route_ipv6_default_gateway;
+    int route_default_table_id;
     int route_default_metric;
     bool route_noexec;
     int route_delay;
@@ -758,6 +759,7 @@
 #define OPT_P_PEER_ID         (1<<28)
 #define OPT_P_INLINE          (1<<29)
 #define OPT_P_PUSH_MTU        (1<<30)
+#define OPT_P_ROUTE_TABLE     (1<<31)

 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bd79a28..156262a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -330,13 +330,11 @@
     r->option =3D ro;

     /* network */
-
     if (!is_route_parm_defined(ro->network))
     {
         goto fail;
     }

-
     /* get_special_addr replaces specialaddr with a special ip addr
      * like gw. getaddrinfo is called to convert a a addrinfo struct */

@@ -442,6 +440,9 @@

     r->flags |=3D RT_DEFINED;

+    /* routing table id */
+    r->table_id =3D ro->table_id;
+
     return true;

 fail:
@@ -498,6 +499,9 @@

     r6->flags |=3D RT_DEFINED;

+    /* routing table id */
+    r6->table_id =3D r6o->table_id;
+
     return true;

 fail:
@@ -511,7 +515,8 @@
                          const char *network,
                          const char *netmask,
                          const char *gateway,
-                         const char *metric)
+                         const char *metric,
+                         int table_id)
 {
     struct route_option *ro;
     ALLOC_OBJ_GC(ro, struct route_option, l->gc);
@@ -519,6 +524,7 @@
     ro->netmask =3D netmask;
     ro->gateway =3D gateway;
     ro->metric =3D metric;
+    ro->table_id =3D table_id;
     ro->next =3D l->routes;
     l->routes =3D ro;

@@ -528,13 +534,15 @@
 add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
                               const char *prefix,
                               const char *gateway,
-                              const char *metric)
+                              const char *metric,
+                              int table_id)
 {
     struct route_ipv6_option *ro;
     ALLOC_OBJ_GC(ro, struct route_ipv6_option, l->gc);
     ro->prefix =3D prefix;
     ro->gateway =3D gateway;
     ro->metric =3D metric;
+    ro->table_id =3D table_id;
     ro->next =3D l->routes_ipv6;
     l->routes_ipv6 =3D ro;
 }
@@ -1610,9 +1618,10 @@
         metric =3D r->metric;
     }

+
     status =3D RTA_SUCCESS;
     int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->=
netmask),
-                               &r->gateway, iface, 0, metric);
+                               &r->gateway, iface, r->table_id, metric);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route e=
xists");
@@ -2007,7 +2016,7 @@
     status =3D RTA_SUCCESS;
     int ret =3D net_route_v6_add(ctx, &r6->network, r6->netbits,
                                gateway_needed ? &r6->gateway : NULL,
-                               device, 0, metric);
+                               device, r6->table_id, metric);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route e=
xists");
@@ -2227,7 +2236,7 @@
     }

     if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask),
-                         &r->gateway, NULL, 0, metric) < 0)
+                         &r->gateway, NULL, r->table_id, metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route delete command failed");
     }
@@ -2452,7 +2461,7 @@
     }

     if (net_route_v6_del(ctx, &r6->network, r6->netbits,
-                         gateway_needed ? &r6->gateway : NULL, device, 0,
+                         gateway_needed ? &r6->gateway : NULL, device, r6-=
>table_id,
                          metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route v6 delete command failed");
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index aa3114c..237375c 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -69,6 +69,7 @@
     in_addr_t remote_host;
     int remote_host_local; /* TLA_x value */
     struct route_bypass bypass;
+    int table_id;
     int default_metric;
 };

@@ -77,6 +78,7 @@
     const char *network;
     const char *netmask;
     const char *gateway;
+    int table_id;
     const char *metric;
 };

@@ -101,6 +103,7 @@
     const char *prefix;         /* e.g. "2001:db8:1::/64" */
     const char *gateway;        /* e.g. "2001:db8:0::2" */
     const char *metric;         /* e.g. "5" */
+    int table_id;
 };

 struct route_ipv6_option_list {
@@ -119,6 +122,7 @@
     in_addr_t network;
     in_addr_t netmask;
     in_addr_t gateway;
+    int table_id;
     int metric;
 };

@@ -129,6 +133,7 @@
     unsigned int netbits;
     struct in6_addr gateway;
     int metric;
+    int table_id;
     /* gateway interface */
 #ifdef _WIN32
     DWORD adapter_index;        /* interface or ~0 if undefined */
@@ -290,12 +295,14 @@
                               const char *network,
                               const char *netmask,
                               const char *gateway,
-                              const char *metric);
+                              const char *metric,
+                              int table_id);

 void add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
                                    const char *prefix,
                                    const char *gateway,
-                                   const char *metric);
+                                   const char *metric,
+                                   int table_id);

 bool init_route_list(struct route_list *rl,
                      const struct route_option_list *opt,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Gerrit-Change-Number: 524
Gerrit-PatchSet: 10
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Djs4vVSj9Cg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/524?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Route: add support for user defined routing ta=
ble<br><br>Add the ability for users to specify a custom<br>routing table w=
here routes should be installed in.<br>As of now routes are always installe=
d in the main<br>routing table of the operating system, however,<br>with th=
e new --route-table option it is possibile<br>to specify the ID of the defa=
ult routing table<br>to be used by --route(-ipv6).<br><br>Please note: this=
 feature is currently supported<br>only by Linux/SITNL.<br>Support for othe=
r platforms should be added in related backends.<br><br>Trac #1399<br>Chang=
e-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7<br>Signed-off-by: Gianmarco=
 De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert=
@...1296...&gt;<br>Message-Id: &lt;20250622110311.1140-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg31946.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M doc/man-sections/vpn-network-options.rst<br>M src/openvpn/helper.c<br=
>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h=
<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>7 files changed, 68 i=
nsertions(+), 20 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections=
/vpn-network-options.rst</span><br><span>index 40b8c19..4a64e8d 100644</spa=
n><br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br><span>=
+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -389,6 +3=
89,14 @@</span><br><span>   Like ``--redirect-gateway``, but omit actually =
changing the default gateway.</span><br><span>   Useful when pushing privat=
e subnets.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+--route-table id</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Specify a default table id for use with --route.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  By default, OpenVPN installs routes =
in the main routing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  table of the operating system, but with this option,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  a user defined routing table can be us=
ed instead.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  (Supported on Linux only,=
 on other platforms this is a no-op).</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> --route args</span><br><span>   Add rou=
te to routing table after connection is established. Multiple</span><br><sp=
an>   routes can be specified. Routes will be automatically torn down in</s=
pan><br><span>@@ -463,14 +471,20 @@</span><br><span>   Setup IPv6 routing i=
n the system to send the specified IPv6 network into</span><br><span>   Ope=
nVPN&#39;s *tun*.</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  Valid syntax:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  Valid syntaxes:</span><br><span>   ::</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-     route-ipv6 ipv6addr/bits=
 [gateway] [metric]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     route-ipv6 ipv6addr/bits</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     route-ipv6 ipv6addr/bits gateway</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     route-ipv6 ipv6addr/bits gateway metric</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The =
gateway parameter is only used for IPv6 routes across *tap* devices,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  and if missing, the ``ipv6=
remote`` field from ``--ifconfig-ipv6`` or</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  ``--route-ipv6-gateway`` is used.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  ``gateway``</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        Only used for IPv6 routes across *ta=
p* devices,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        ``--route-ipv6-gat=
eway`` is used.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``metric``</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        default taken from ``-=
-route-metric`` if set, otherwise :code:`0`.</span><br><span> </span><br><s=
pan> --route-gateway arg</span><br><span>   Specify a default *gateway* for=
 use with ``--route``.</span><br><span>diff --git a/src/openvpn/helper.c b/=
src/openvpn/helper.c</span><br><span>index 8761826..7cef9db 100644</span><b=
r><span>--- a/src/openvpn/helper.c</span><br><span>+++ b/src/openvpn/helper=
.c</span><br><span>@@ -118,7 +118,8 @@</span><br><span>                    =
          print_in_addr_t(network, 0, &amp;o-&gt;gc),</span><br><span>     =
                         print_in_addr_t(netmask, 0, &amp;o-&gt;gc),</span>=
<br><span>                              NULL,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                             NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                             NULL,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
         o-&gt;route_default_table_id);</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span>diff --git a/src/openvpn/ini=
t.c b/src/openvpn/init.c</span><br><span>index 7d4eb85..77747a2 100644</spa=
n><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init=
.c</span><br><span>@@ -1566,7 +1566,7 @@</span><br><span>         {</span><=
br><span>             add_route_ipv6_to_option_list( options-&gt;routes_ipv=
6,</span><br><span>                                            string_alloc=
(opt_list[i], options-&gt;routes_ipv6-&gt;gc),</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                           NULL, N=
ULL );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                              NULL, NULL, options-&gt;route_default_table_i=
d);</span><br><span>         }</span><br><span>     }</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</sp=
an><br><span>index 3cf8c2a..7e26069 100644</span><br><span>--- a/src/openvp=
n/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ =
-213,6 +213,10 @@</span><br><span>     &quot;                    pass --ifc=
onfig parms by environment to scripts.\n&quot;</span><br><span>     &quot;-=
-ifconfig-nowarn : Don&#39;t warn if the --ifconfig option on this side of =
the\n&quot;</span><br><span>     &quot;                    connection doesn=
&#39;t match the remote side.\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef TARGET_LINUX</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;--route-table table_id : Specify a custom routi=
ng table for use with --route(-ipv6).\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;                           If not speci=
fied, the id of the default routing table will be used.\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     &qu=
ot;--route network [netmask] [gateway] [metric] :\n&quot;</span><br><span> =
    &quot;                  Add route to routing table after connection\n&q=
uot;</span><br><span>     &quot;                  is established.  Multiple=
 routes can be specified.\n&quot;</span><br><span>@@ -829,6 +833,7 @@</span=
><br><span>     o-&gt;ce.mssfix =3D 0;</span><br><span>     o-&gt;ce.mssfix=
_default =3D true;</span><br><span>     o-&gt;ce.mssfix_encap =3D true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;route_default=
_table_id =3D 0;</span><br><span>     o-&gt;route_delay_window =3D 30;</spa=
n><br><span>     o-&gt;resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;</sp=
an><br><span>     o-&gt;resolve_in_advance =3D false;</span><br><span>@@ -1=
799,6 +1804,7 @@</span><br><span>     SHOW_STR(route_script);</span><br><sp=
an>     SHOW_STR(route_default_gateway);</span><br><span>     SHOW_INT(rout=
e_default_metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SHOW_INT(route_default_table_id);</span><br><span>     SHOW_BOOL(route_n=
oexec);</span><br><span>     SHOW_INT(route_delay);</span><br><span>     SH=
OW_INT(route_delay_window);</span><br><span>@@ -7064,6 +7070,14 @@</span><b=
r><span>         cnol_check_alloc(options);</span><br><span>         add_cl=
ient_nat_to_option_list(options-&gt;client_nat, p[1], p[2], p[3], p[4], msg=
level);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (streq(p[0], &quot;route-table&quot;) &amp;&amp; p[1=
] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE=
_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_WARN, &quot;NOTE: --route-table is supported only on Linux when SITNL is b=
uilt-in&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PE=
RMISSION(OPT_P_ROUTE_TABLE);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;route_default_table_id =3D positive_atoi(p[1],=
 msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span>     else if (streq(p[0], &quot;route&quot;) &amp;&amp; p[1] =
&amp;&amp; !p[5])</span><br><span>     {</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_ROUTE);</span><br><span>@@ -7085,8 +7099,9 @@</span><br><spa=
n>                 msg(msglevel, &quot;route parameter gateway &#39;%s&#39;=
 must be a valid address&quot;, p[3]);</span><br><span>                 got=
o err;</span><br><span>             }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            /* p[4] is metric, if specified */</span><br>=
<span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   add_route_to_option_list(options-&gt;routes, p[1], p[2], p[3], p[4]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_route_to_o=
ption_list(options-&gt;routes, p[1], p[2], p[3], p[4], options-&gt;route_de=
fault_table_id);</span><br><span>     }</span><br><span>     else if (streq=
(p[0], &quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br>=
<span>     {</span><br><span>@@ -7104,9 +7119,9 @@</span><br><span>        =
         msg(msglevel, &quot;route-ipv6 parameter gateway &#39;%s&#39; must=
 be a valid address&quot;, p[2]);</span><br><span>                 goto err=
;</span><br><span>             }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            /* p[3] is metric, if present */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            /* p[3] is metric, if speci=
fied */</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        add_route_ipv6_to_option_list(options-&gt;routes_ipv6,=
 p[1], p[2], p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        add_route_ipv6_to_option_list(options-&gt;routes_ipv6, p[1], p[2], =
p[3], options-&gt;route_default_table_id);</span><br><span>     }</span><br=
><span>     else if (streq(p[0], &quot;max-routes&quot;) &amp;&amp; !p[2])<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/options.h b=
/src/openvpn/options.h</span><br><span>index 46ec32b..56e85d7 100644</span>=
<br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/opt=
ions.h</span><br><span>@@ -427,6 +427,7 @@</span><br><span>     const char =
*route_predown_script;</span><br><span>     const char *route_default_gatew=
ay;</span><br><span>     const char *route_ipv6_default_gateway;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int route_default_table_id=
;</span><br><span>     int route_default_metric;</span><br><span>     bool =
route_noexec;</span><br><span>     int route_delay;</span><br><span>@@ -758=
,6 +759,7 @@</span><br><span> #define OPT_P_PEER_ID         (1&lt;&lt;28)</=
span><br><span> #define OPT_P_INLINE          (1&lt;&lt;29)</span><br><span=
> #define OPT_P_PUSH_MTU        (1&lt;&lt;30)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define OPT_P_ROUTE_TABLE     (1&lt;&lt;31)</span=
><br><span> </span><br><span> #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT=
_P_PULL_MODE))</span><br><span> </span><br><span>diff --git a/src/openvpn/r=
oute.c b/src/openvpn/route.c</span><br><span>index bd79a28..156262a 100644<=
/span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn=
/route.c</span><br><span>@@ -330,13 +330,11 @@</span><br><span>     r-&gt;o=
ption =3D ro;</span><br><span> </span><br><span>     /* network */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!is_=
route_parm_defined(ro-&gt;network))</span><br><span>     {</span><br><span>=
         goto fail;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* get_special=
_addr replaces specialaddr with a special ip addr</span><br><span>      * l=
ike gw. getaddrinfo is called to convert a a addrinfo struct */</span><br><=
span> </span><br><span>@@ -442,6 +440,9 @@</span><br><span> </span><br><spa=
n>     r-&gt;flags |=3D RT_DEFINED;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* routing table id */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;table_id =3D ro-&gt;tabl=
e_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     return true;</span><br><span> </span><br><span> fail:</span><br><sp=
an>@@ -498,6 +499,9 @@</span><br><span> </span><br><span>     r6-&gt;flags =
|=3D RT_DEFINED;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* routing table id */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    r6-&gt;table_id =3D r6o-&gt;table_id;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return tr=
ue;</span><br><span> </span><br><span> fail:</span><br><span>@@ -511,7 +515=
,8 @@</span><br><span>                          const char *network,</span>=
<br><span>                          const char *netmask,</span><br><span>  =
                        const char *gateway,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                         const char *metric)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                         co=
nst char *metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       int table_id)</span><br><span> {</span><br><span>   =
  struct route_option *ro;</span><br><span>     ALLOC_OBJ_GC(ro, struct rou=
te_option, l-&gt;gc);</span><br><span>@@ -519,6 +524,7 @@</span><br><span> =
    ro-&gt;netmask =3D netmask;</span><br><span>     ro-&gt;gateway =3D gat=
eway;</span><br><span>     ro-&gt;metric =3D metric;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ro-&gt;table_id =3D table_id;</span><=
br><span>     ro-&gt;next =3D l-&gt;routes;</span><br><span>     l-&gt;rout=
es =3D ro;</span><br><span> </span><br><span>@@ -528,13 +534,15 @@</span><b=
r><span> add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,</s=
pan><br><span>                               const char *prefix,</span><br>=
<span>                               const char *gateway,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                              const cha=
r *metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                     const char *metric,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              int table_id)</span><br>=
<span> {</span><br><span>     struct route_ipv6_option *ro;</span><br><span=
>     ALLOC_OBJ_GC(ro, struct route_ipv6_option, l-&gt;gc);</span><br><span=
>     ro-&gt;prefix =3D prefix;</span><br><span>     ro-&gt;gateway =3D gat=
eway;</span><br><span>     ro-&gt;metric =3D metric;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ro-&gt;table_id =3D table_id;</span><=
br><span>     ro-&gt;next =3D l-&gt;routes_ipv6;</span><br><span>     l-&gt=
;routes_ipv6 =3D ro;</span><br><span> }</span><br><span>@@ -1610,9 +1618,10=
 @@</span><br><span>         metric =3D r-&gt;metric;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>     status =3D RTA_SUCCESS;</span><br><span>     int ret =
=3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;net=
mask),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                &amp;r-&gt;gateway, iface, 0, metric);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                               &amp;r-&g=
t;gateway, iface, r-&gt;table_id, metric);</span><br><span>     if (ret =3D=
=3D -EEXIST)</span><br><span>     {</span><br><span>         msg(D_ROUTE, &=
quot;NOTE: Linux route add command failed because route exists&quot;);</spa=
n><br><span>@@ -2007,7 +2016,7 @@</span><br><span>     status =3D RTA_SUCCE=
SS;</span><br><span>     int ret =3D net_route_v6_add(ctx, &amp;r6-&gt;netw=
ork, r6-&gt;netbits,</span><br><span>                                gatewa=
y_needed ? &amp;r6-&gt;gateway : NULL,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                               device, 0, metric);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
    device, r6-&gt;table_id, metric);</span><br><span>     if (ret =3D=3D -=
EEXIST)</span><br><span>     {</span><br><span>         msg(D_ROUTE, &quot;=
NOTE: Linux route add command failed because route exists&quot;);</span><br=
><span>@@ -2227,7 +2236,7 @@</span><br><span>     }</span><br><span> </span=
><br><span>     if (net_route_v4_del(ctx, &amp;r-&gt;network, netmask_to_ne=
tbits2(r-&gt;netmask),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                         &amp;r-&gt;gateway, NULL, 0, metric) &lt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
 &amp;r-&gt;gateway, NULL, r-&gt;table_id, metric) &lt; 0)</span><br><span>=
     {</span><br><span>         msg(M_WARN, &quot;ERROR: Linux route delete=
 command failed&quot;);</span><br><span>     }</span><br><span>@@ -2452,7 +=
2461,7 @@</span><br><span>     }</span><br><span> </span><br><span>     if =
(net_route_v6_del(ctx, &amp;r6-&gt;network, r6-&gt;netbits,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                         gateway_need=
ed ? &amp;r6-&gt;gateway : NULL, device, 0,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                         gateway_needed ? &amp;r6-&=
gt;gateway : NULL, device, r6-&gt;table_id,</span><br><span>               =
           metric) &lt; 0)</span><br><span>     {</span><br><span>         =
msg(M_WARN, &quot;ERROR: Linux route v6 delete command failed&quot;);</span=
><br><span>diff --git a/src/openvpn/route.h b/src/openvpn/route.h</span><br=
><span>index aa3114c..237375c 100644</span><br><span>--- a/src/openvpn/rout=
e.h</span><br><span>+++ b/src/openvpn/route.h</span><br><span>@@ -69,6 +69,=
7 @@</span><br><span>     in_addr_t remote_host;</span><br><span>     int r=
emote_host_local; /* TLA_x value */</span><br><span>     struct route_bypas=
s bypass;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ta=
ble_id;</span><br><span>     int default_metric;</span><br><span> };</span>=
<br><span> </span><br><span>@@ -77,6 +78,7 @@</span><br><span>     const ch=
ar *network;</span><br><span>     const char *netmask;</span><br><span>    =
 const char *gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int table_id;</span><br><span>     const char *metric;</span><br><spa=
n> };</span><br><span> </span><br><span>@@ -101,6 +103,7 @@</span><br><span=
>     const char *prefix;         /* e.g. &quot;2001:db8:1::/64&quot; */</s=
pan><br><span>     const char *gateway;        /* e.g. &quot;2001:db8:0::2&=
quot; */</span><br><span>     const char *metric;         /* e.g. &quot;5&q=
uot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int tabl=
e_id;</span><br><span> };</span><br><span> </span><br><span> struct route_i=
pv6_option_list {</span><br><span>@@ -119,6 +122,7 @@</span><br><span>     =
in_addr_t network;</span><br><span>     in_addr_t netmask;</span><br><span>=
     in_addr_t gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int table_id;</span><br><span>     int metric;</span><br><span> };<=
/span><br><span> </span><br><span>@@ -129,6 +133,7 @@</span><br><span>     =
unsigned int netbits;</span><br><span>     struct in6_addr gateway;</span><=
br><span>     int metric;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int table_id;</span><br><span>     /* gateway interface */</span>=
<br><span> #ifdef _WIN32</span><br><span>     DWORD adapter_index;        /=
* interface or ~0 if undefined */</span><br><span>@@ -290,12 +295,14 @@</sp=
an><br><span>                               const char *network,</span><br>=
<span>                               const char *netmask,</span><br><span> =
                              const char *gateway,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                              const char *metr=
ic);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
               const char *metric,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                              int table_id);</span><br><span=
> </span><br><span> void add_route_ipv6_to_option_list(struct route_ipv6_op=
tion_list *l,</span><br><span>                                    const cha=
r *prefix,</span><br><span>                                    const char *=
gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                      const char *metric);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                   const char *metri=
c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                  int table_id);</span><br><span> </span><br><span> bool in=
it_route_list(struct route_list *rl,</span><br><span>                      =
const struct route_option_list *opt,</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Dema=
il">change 524</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Djs4vVSj9Cg=--

