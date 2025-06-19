From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 19 Jun 2025 16:03:50 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <3b73bdfdcb5fabb2b0853a562829f50705c66939-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vJyEkrEG3d0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vJyEkrEG3d0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, plais=
thos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail

to look at the new patch set (#9).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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
---
M doc/man-sections/vpn-network-options.rst
M src/openvpn/helper.c
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/route.c
M src/openvpn/route.h
7 files changed, 68 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/524/9

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
Gerrit-PatchSet: 9
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--vJyEkrEG3d0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, its_Giaan, p=
laisthos. </p>
<p>its_Giaan <strong>uploaded patch set #9</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Route: add support for user defined routing table<br=
><br>Add the ability for users to specify a custom<br>routing table where r=
outes should be installed in.<br>As of now routes are always installed in t=
he main<br>routing table of the operating system, however,<br>with the new =
--route-table option it is possibile<br>to specify the ID of the default ro=
uting table<br>to be used by --route(-ipv6).<br><br>Please note: this featu=
re is currently supported<br>only by Linux/SITNL.<br>Support for other plat=
forms should be added in related backends.<br><br>Trac #1399<br>Change-Id: =
I3e4ebef484d2a04a383a65ede5617ee98bf218a7<br>Signed-off-by: Gianmarco De Gr=
egori &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/vpn-network=
-options.rst<br>M src/openvpn/helper.c<br>M src/openvpn/init.c<br>M src/ope=
nvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/route.c<br>M src=
/openvpn/route.h<br>7 files changed, 68 insertions(+), 20 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/524/9=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-se=
ctions/vpn-network-options.rst</span><br><span>index 40b8c19..4a64e8d 10064=
4</span><br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br>=
<span>+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -38=
9,6 +389,14 @@</span><br><span>   Like ``--redirect-gateway``, but omit act=
ually changing the default gateway.</span><br><span>   Useful when pushing =
private subnets.</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+--route-table id</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  Specify a default table id for use with --route.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  By default, OpenVPN installs r=
outes in the main routing</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  table of the operating system, but with this option,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  a user defined routing table can=
 be used instead.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (Supported on Linux=
 only, on other platforms this is a no-op).</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> --route args</span><br><span>   A=
dd route to routing table after connection is established. Multiple</span><=
br><span>   routes can be specified. Routes will be automatically torn down=
 in</span><br><span>@@ -463,14 +471,20 @@</span><br><span>   Setup IPv6 rou=
ting in the system to send the specified IPv6 network into</span><br><span>=
   OpenVPN&#39;s *tun*.</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  Valid syntax:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  Valid syntaxes:</span><br><span>   ::</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     route-ipv6 ipv6add=
r/bits [gateway] [metric]</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     route-ipv6 ipv6addr/bits</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     route-ipv6 ipv6addr/bits gateway</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     route-ipv6 ipv6addr/bits gateway met=
ric</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  The gateway parameter is only used for IPv6 routes across *tap* devices,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  and if missing, the =
``ipv6remote`` field from ``--ifconfig-ipv6`` or</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  ``--route-ipv6-gateway`` is used.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  ``gateway``</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        Only used for IPv6 routes acro=
ss *tap* devices,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ``--route-ip=
v6-gateway`` is used.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``metric``</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        default taken fr=
om ``--route-metric`` if set, otherwise :code:`0`.</span><br><span> </span>=
<br><span> --route-gateway arg</span><br><span>   Specify a default *gatewa=
y* for use with ``--route``.</span><br><span>diff --git a/src/openvpn/helpe=
r.c b/src/openvpn/helper.c</span><br><span>index 8761826..7cef9db 100644</s=
pan><br><span>--- a/src/openvpn/helper.c</span><br><span>+++ b/src/openvpn/=
helper.c</span><br><span>@@ -118,7 +118,8 @@</span><br><span>              =
                print_in_addr_t(network, 0, &amp;o-&gt;gc),</span><br><span=
>                              print_in_addr_t(netmask, 0, &amp;o-&gt;gc),<=
/span><br><span>                              NULL,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                             NULL);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
  NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                 o-&gt;route_default_table_id);</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span>diff --git a/src/ope=
nvpn/init.c b/src/openvpn/init.c</span><br><span>index 7d4eb85..77747a2 100=
644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/open=
vpn/init.c</span><br><span>@@ -1566,7 +1566,7 @@</span><br><span>         {=
</span><br><span>             add_route_ipv6_to_option_list( options-&gt;ro=
utes_ipv6,</span><br><span>                                            stri=
ng_alloc(opt_list[i], options-&gt;routes_ipv6-&gt;gc),</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                          =
 NULL, NULL );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                      NULL, NULL, options-&gt;route_default=
_table_id);</span><br><span>         }</span><br><span>     }</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/optio=
ns.c</span><br><span>index 3cf8c2a..7e26069 100644</span><br><span>--- a/sr=
c/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><=
span>@@ -213,6 +213,10 @@</span><br><span>     &quot;                    pa=
ss --ifconfig parms by environment to scripts.\n&quot;</span><br><span>    =
 &quot;--ifconfig-nowarn : Don&#39;t warn if the --ifconfig option on this =
side of the\n&quot;</span><br><span>     &quot;                    connecti=
on doesn&#39;t match the remote side.\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifdef TARGET_LINUX</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;--route-table table_id : Specify a cust=
om routing table for use with --route(-ipv6).\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;                           If n=
ot specified, the id of the default routing table will be used.\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
     &quot;--route network [netmask] [gateway] [metric] :\n&quot;</span><br=
><span>     &quot;                  Add route to routing table after connec=
tion\n&quot;</span><br><span>     &quot;                  is established.  =
Multiple routes can be specified.\n&quot;</span><br><span>@@ -829,6 +833,7 =
@@</span><br><span>     o-&gt;ce.mssfix =3D 0;</span><br><span>     o-&gt;c=
e.mssfix_default =3D true;</span><br><span>     o-&gt;ce.mssfix_encap =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;route=
_default_table_id =3D 0;</span><br><span>     o-&gt;route_delay_window =3D =
30;</span><br><span>     o-&gt;resolve_retry_seconds =3D RESOLV_RETRY_INFIN=
ITE;</span><br><span>     o-&gt;resolve_in_advance =3D false;</span><br><sp=
an>@@ -1799,6 +1804,7 @@</span><br><span>     SHOW_STR(route_script);</span=
><br><span>     SHOW_STR(route_default_gateway);</span><br><span>     SHOW_=
INT(route_default_metric);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SHOW_INT(route_default_table_id);</span><br><span>     SHOW_BOOL=
(route_noexec);</span><br><span>     SHOW_INT(route_delay);</span><br><span=
>     SHOW_INT(route_delay_window);</span><br><span>@@ -7064,6 +7070,14 @@<=
/span><br><span>         cnol_check_alloc(options);</span><br><span>       =
  add_client_nat_to_option_list(options-&gt;client_nat, p[1], p[2], p[3], p=
[4], msglevel);</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    else if (streq(p[0], &quot;route-table&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_WARN, &quot;NOTE: --route-table is supported only on Linux when SI=
TNL is built-in&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        V=
ERIFY_PERMISSION(OPT_P_ROUTE_TABLE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        options-&gt;route_default_table_id =3D positive_at=
oi(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span>     else if (streq(p[0], &quot;route&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[5])</span><br><span>     {</span><br><span>         V=
ERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span>@@ -7085,8 +7099,9 @@</span>=
<br><span>                 msg(msglevel, &quot;route parameter gateway &#39=
;%s&#39; must be a valid address&quot;, p[3]);</span><br><span>            =
     goto err;</span><br><span>             }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* p[4] is metric, if specified */</s=
pan><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        add_route_to_option_list(options-&gt;routes, p[1], p[2], p[3], p=
[4]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_ro=
ute_to_option_list(options-&gt;routes, p[1], p[2], p[3], p[4], options-&gt;=
route_default_table_id);</span><br><span>     }</span><br><span>     else i=
f (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</s=
pan><br><span>     {</span><br><span>@@ -7104,9 +7119,9 @@</span><br><span>=
                 msg(msglevel, &quot;route-ipv6 parameter gateway &#39;%s&#=
39; must be a valid address&quot;, p[2]);</span><br><span>                 =
goto err;</span><br><span>             }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            /* p[3] is metric, if present */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* p[3] is metric, =
if specified */</span><br><span>         }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        add_route_ipv6_to_option_list(options-&gt;rout=
es_ipv6, p[1], p[2], p[3]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        add_route_ipv6_to_option_list(options-&gt;routes_ipv6, p[1]=
, p[2], p[3], options-&gt;route_default_table_id);</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;max-routes&quot;) &amp;&amp;=
 !p[2])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/opt=
ions.h b/src/openvpn/options.h</span><br><span>index 46ec32b..56e85d7 10064=
4</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/ope=
nvpn/options.h</span><br><span>@@ -427,6 +427,7 @@</span><br><span>     con=
st char *route_predown_script;</span><br><span>     const char *route_defau=
lt_gateway;</span><br><span>     const char *route_ipv6_default_gateway;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int route_default_=
table_id;</span><br><span>     int route_default_metric;</span><br><span>  =
   bool route_noexec;</span><br><span>     int route_delay;</span><br><span=
>@@ -758,6 +759,7 @@</span><br><span> #define OPT_P_PEER_ID         (1&lt;&=
lt;28)</span><br><span> #define OPT_P_INLINE          (1&lt;&lt;29)</span><=
br><span> #define OPT_P_PUSH_MTU        (1&lt;&lt;30)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ROUTE_TABLE     (1&lt;&lt;3=
1)</span><br><span> </span><br><span> #define OPT_P_DEFAULT   (~(OPT_P_INST=
ANCE|OPT_P_PULL_MODE))</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/route.c b/src/openvpn/route.c</span><br><span>index bd79a28..156262a=
 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src=
/openvpn/route.c</span><br><span>@@ -330,13 +330,11 @@</span><br><span>    =
 r-&gt;option =3D ro;</span><br><span> </span><br><span>     /* network */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
if (!is_route_parm_defined(ro-&gt;network))</span><br><span>     {</span><b=
r><span>         goto fail;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* get=
_special_addr replaces specialaddr with a special ip addr</span><br><span> =
     * like gw. getaddrinfo is called to convert a a addrinfo struct */</sp=
an><br><span> </span><br><span>@@ -442,6 +440,9 @@</span><br><span> </span>=
<br><span>     r-&gt;flags |=3D RT_DEFINED;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* routing table id */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;table_id =3D ro-=
&gt;table_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     return true;</span><br><span> </span><br><span> fail:</span=
><br><span>@@ -498,6 +499,9 @@</span><br><span> </span><br><span>     r6-&g=
t;flags |=3D RT_DEFINED;</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* routing table id */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    r6-&gt;table_id =3D r6o-&gt;table_id;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     r=
eturn true;</span><br><span> </span><br><span> fail:</span><br><span>@@ -51=
1,7 +515,8 @@</span><br><span>                          const char *network=
,</span><br><span>                          const char *netmask,</span><br>=
<span>                          const char *gateway,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         const char *metric=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
       const char *metric,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                         int table_id)</span><br><span> {</span><br>=
<span>     struct route_option *ro;</span><br><span>     ALLOC_OBJ_GC(ro, s=
truct route_option, l-&gt;gc);</span><br><span>@@ -519,6 +524,7 @@</span><b=
r><span>     ro-&gt;netmask =3D netmask;</span><br><span>     ro-&gt;gatewa=
y =3D gateway;</span><br><span>     ro-&gt;metric =3D metric;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ro-&gt;table_id =3D table_id;=
</span><br><span>     ro-&gt;next =3D l-&gt;routes;</span><br><span>     l-=
&gt;routes =3D ro;</span><br><span> </span><br><span>@@ -528,13 +534,15 @@<=
/span><br><span> add_route_ipv6_to_option_list(struct route_ipv6_option_lis=
t *l,</span><br><span>                               const char *prefix,</s=
pan><br><span>                               const char *gateway,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                              c=
onst char *metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                             const char *metric,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                              int table_id)</s=
pan><br><span> {</span><br><span>     struct route_ipv6_option *ro;</span><=
br><span>     ALLOC_OBJ_GC(ro, struct route_ipv6_option, l-&gt;gc);</span><=
br><span>     ro-&gt;prefix =3D prefix;</span><br><span>     ro-&gt;gateway=
 =3D gateway;</span><br><span>     ro-&gt;metric =3D metric;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ro-&gt;table_id =3D table_id;<=
/span><br><span>     ro-&gt;next =3D l-&gt;routes_ipv6;</span><br><span>   =
  l-&gt;routes_ipv6 =3D ro;</span><br><span> }</span><br><span>@@ -1610,9 +=
1618,10 @@</span><br><span>         metric =3D r-&gt;metric;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     status =3D RTA_SUCCESS;</span><br><span>     i=
nt ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-=
&gt;netmask),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                       &amp;r-&gt;gateway, iface, 0, metric);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                               &a=
mp;r-&gt;gateway, iface, r-&gt;table_id, metric);</span><br><span>     if (=
ret =3D=3D -EEXIST)</span><br><span>     {</span><br><span>         msg(D_R=
OUTE, &quot;NOTE: Linux route add command failed because route exists&quot;=
);</span><br><span>@@ -2007,7 +2016,7 @@</span><br><span>     status =3D RT=
A_SUCCESS;</span><br><span>     int ret =3D net_route_v6_add(ctx, &amp;r6-&=
gt;network, r6-&gt;netbits,</span><br><span>                               =
 gateway_needed ? &amp;r6-&gt;gateway : NULL,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                               device, 0, metric);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
           device, r6-&gt;table_id, metric);</span><br><span>     if (ret =
=3D=3D -EEXIST)</span><br><span>     {</span><br><span>         msg(D_ROUTE=
, &quot;NOTE: Linux route add command failed because route exists&quot;);</=
span><br><span>@@ -2227,7 +2236,7 @@</span><br><span>     }</span><br><span=
> </span><br><span>     if (net_route_v4_del(ctx, &amp;r-&gt;network, netma=
sk_to_netbits2(r-&gt;netmask),</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                         &amp;r-&gt;gateway, NULL, 0, metric) &lt;=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
         &amp;r-&gt;gateway, NULL, r-&gt;table_id, metric) &lt; 0)</span><b=
r><span>     {</span><br><span>         msg(M_WARN, &quot;ERROR: Linux rout=
e delete command failed&quot;);</span><br><span>     }</span><br><span>@@ -=
2452,7 +2461,7 @@</span><br><span>     }</span><br><span> </span><br><span>=
     if (net_route_v6_del(ctx, &amp;r6-&gt;network, r6-&gt;netbits,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                         gate=
way_needed ? &amp;r6-&gt;gateway : NULL, device, 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         gateway_needed ?=
 &amp;r6-&gt;gateway : NULL, device, r6-&gt;table_id,</span><br><span>     =
                     metric) &lt; 0)</span><br><span>     {</span><br><span=
>         msg(M_WARN, &quot;ERROR: Linux route v6 delete command failed&quo=
t;);</span><br><span>diff --git a/src/openvpn/route.h b/src/openvpn/route.h=
</span><br><span>index aa3114c..237375c 100644</span><br><span>--- a/src/op=
envpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><br><span>@@ =
-69,6 +69,7 @@</span><br><span>     in_addr_t remote_host;</span><br><span>=
     int remote_host_local; /* TLA_x value */</span><br><span>     struct r=
oute_bypass bypass;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int table_id;</span><br><span>     int default_metric;</span><br><span>=
 };</span><br><span> </span><br><span>@@ -77,6 +78,7 @@</span><br><span>   =
  const char *network;</span><br><span>     const char *netmask;</span><br>=
<span>     const char *gateway;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int table_id;</span><br><span>     const char *metric;</spa=
n><br><span> };</span><br><span> </span><br><span>@@ -101,6 +103,7 @@</span=
><br><span>     const char *prefix;         /* e.g. &quot;2001:db8:1::/64&q=
uot; */</span><br><span>     const char *gateway;        /* e.g. &quot;2001=
:db8:0::2&quot; */</span><br><span>     const char *metric;         /* e.g.=
 &quot;5&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int table_id;</span><br><span> };</span><br><span> </span><br><span> stru=
ct route_ipv6_option_list {</span><br><span>@@ -119,6 +122,7 @@</span><br><=
span>     in_addr_t network;</span><br><span>     in_addr_t netmask;</span>=
<br><span>     in_addr_t gateway;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int table_id;</span><br><span>     int metric;</span><br>=
<span> };</span><br><span> </span><br><span>@@ -129,6 +133,7 @@</span><br><=
span>     unsigned int netbits;</span><br><span>     struct in6_addr gatewa=
y;</span><br><span>     int metric;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int table_id;</span><br><span>     /* gateway interface=
 */</span><br><span> #ifdef _WIN32</span><br><span>     DWORD adapter_index=
;        /* interface or ~0 if undefined */</span><br><span>@@ -290,12 +295=
,14 @@</span><br><span>                               const char *network,<=
/span><br><span>                               const char *netmask,</span><=
br><span>                               const char *gateway,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                              const =
char *metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                         const char *metric,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                              int table_id);</span=
><br><span> </span><br><span> void add_route_ipv6_to_option_list(struct rou=
te_ipv6_option_list *l,</span><br><span>                                   =
 const char *prefix,</span><br><span>                                    co=
nst char *gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                const char *metric);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   const =
char *metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                             int table_id);</span><br><span> </span><br><sp=
an> bool init_route_list(struct route_list *rl,</span><br><span>           =
           const struct route_option_list *opt,</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/52=
4?usp=3Demail">change 524</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--vJyEkrEG3d0=--

