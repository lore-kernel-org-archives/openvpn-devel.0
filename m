From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 1 May 2024 20:13:12 +0000
In-Reply-To: <gerrit.1713372754000.Iefd209c0856ef395ab74055496130de00b86ead0@...2715...>
References: <gerrit.1713372754000.Iefd209c0856ef395ab74055496130de00b86ead0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <59df77c56417ff628031c26f35ede0bc5045f56e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dtBiXnIF8Dg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Use topology default
 of "subnet" only for server mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dtBiXnIF8Dg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/55=
4?usp=3Demail )

Change subject: Use topology default of "subnet" only for server mode
......................................................................

Use topology default of "subnet" only for server mode

The setting of --topology changes the syntax of --ifconfig.
So changing the default of --topology breaks all existing
configs that use --ifconfig but not --topology.

For P2P setups that is probably a signification percentage.
For server setups the percentage is hopefully lower since
--ifconfig is implicitly set by --server. Also more people
might have set their topology explicitly since it makes a
much bigger difference. Clients will usually get the
topology and the IP config pushed by the server.

So we decided to not switch the default for everyone to
not affect P2P setups. What we care about is to change
the default for --mode server, so we only do that now. For
people using --server this should be transparent except
for a pool reset.

Github: Openvpn/openvpn#529
Change-Id: Iefd209c0856ef395ab74055496130de00b86ead0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240501124254.29114-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
592.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M src/openvpn/helper.c
M src/openvpn/helper.h
M src/openvpn/options.c
4 files changed, 49 insertions(+), 16 deletions(-)




diff --git a/Changes.rst b/Changes.rst
index b2278ab..fa0fb22 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -23,11 +23,12 @@
 ``persist-key`` option has been enabled by default.
     All the keys will be kept in memory across restart.

-Default for ``--topology`` changed to ``subnet``
-    Previous releases used ``net30`` as default. This only affects
-    configs with ``--dev tun`` and only IPv4. Note that this
-    changes the semantics of ``--ifconfig``, so if you have manual
-    settings for that in your config but not set ``--topology``
+Default for ``--topology`` changed to ``subnet`` for ``--mode server``
+    Previous releases always used ``net30`` as default. This only affects
+    configs with ``--mode server`` or ``--server`` (the latter implies the
+    former), and ``--dev tun``, and only if IPv4 is enabled.
+    Note that this changes the semantics of ``--ifconfig``, so if you have
+    manual settings for that in your config but not set ``--topology``
     your config might fail to parse with the new version. Just adding
     ``--topology net30`` to the config should fix the problem.
     By default ``--topology`` is pushed from server to client.
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 1bab84c..5681718 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -137,6 +137,32 @@
 }


+/**
+ * Set --topology default depending on --mode
+ */
+void
+helper_setdefault_topology(struct options *o)
+{
+    if (o->topology !=3D TOP_UNDEF)
+    {
+        return;
+    }
+    int dev =3D dev_type_enum(o->dev, o->dev_type);
+    if (dev !=3D DEV_TYPE_TUN)
+    {
+        return;
+    }
+    if (o->mode =3D=3D MODE_SERVER)
+    {
+        o->topology =3D TOP_SUBNET;
+    }
+    else
+    {
+        o->topology =3D TOP_NET30;
+    }
+}
+
+
 /*
  * Process server, server-bridge, and client helper
  * directives after the parameters themselves have been
@@ -151,7 +177,6 @@
      * Get tun/tap/null device type
      */
     const int dev =3D dev_type_enum(o->dev, o->dev_type);
-    const int topology =3D o->topology;

     /*
      *
@@ -177,11 +202,11 @@

         if (o->server_flags & SF_NOPOOL)
         {
-            msg( M_USAGE, "--server-ipv6 is incompatible with 'nopool' opt=
ion" );
+            msg(M_USAGE, "--server-ipv6 is incompatible with 'nopool' opti=
on");
         }
         if (o->ifconfig_ipv6_pool_defined)
         {
-            msg( M_USAGE, "--server-ipv6 already defines an ifconfig-ipv6-=
pool, so you can't also specify --ifconfig-pool explicitly");
+            msg(M_USAGE, "--server-ipv6 already defines an ifconfig-ipv6-p=
ool, so you can't also specify --ifconfig-pool explicitly");
         }

         o->mode =3D MODE_SERVER;
@@ -207,7 +232,7 @@
                                                   o->server_netbits_ipv6 <=
 112 ? 0x1000 : 2);
         o->ifconfig_ipv6_pool_netbits =3D o->server_netbits_ipv6;

-        push_option( o, "tun-ipv6", M_USAGE );
+        push_option(o, "tun-ipv6", M_USAGE);
     }

     /*
@@ -305,8 +330,10 @@

             o->mode =3D MODE_SERVER;
             o->tls_server =3D true;
+            /* Need to know topology now */
+            helper_setdefault_topology(o);

-            if (topology =3D=3D TOP_NET30 || topology =3D=3D TOP_P2P)
+            if (o->topology =3D=3D TOP_NET30 || o->topology =3D=3D TOP_P2P)
             {
                 o->ifconfig_local =3D print_in_addr_t(o->server_network + =
1, 0, &o->gc);
                 o->ifconfig_remote_netmask =3D print_in_addr_t(o->server_n=
etwork + 2, 0, &o->gc);
@@ -324,12 +351,12 @@
                 {
                     push_option(o, print_opt_route(o->server_network, o->s=
erver_netmask, &o->gc), M_USAGE);
                 }
-                else if (topology =3D=3D TOP_NET30)
+                else if (o->topology =3D=3D TOP_NET30)
                 {
                     push_option(o, print_opt_route(o->server_network + 1, =
0, &o->gc), M_USAGE);
                 }
             }
-            else if (topology =3D=3D TOP_SUBNET)
+            else if (o->topology =3D=3D TOP_SUBNET)
             {
                 o->ifconfig_local =3D print_in_addr_t(o->server_network + =
1, 0, &o->gc);
                 o->ifconfig_remote_netmask =3D print_in_addr_t(o->server_n=
etmask, 0, &o->gc);
@@ -354,9 +381,9 @@
                 ASSERT(0);
             }

-            push_option(o, print_opt_topology(topology, &o->gc), M_USAGE);
+            push_option(o, print_opt_topology(o->topology, &o->gc), M_USAG=
E);

-            if (topology =3D=3D TOP_NET30 && !(o->server_flags & SF_NOPOOL=
))
+            if (o->topology =3D=3D TOP_NET30 && !(o->server_flags & SF_NOP=
OOL))
             {
                 msg(M_WARN, "WARNING: --topology net30 support for server "
                     "configs with IPv4 pools will be removed in a future "
@@ -394,7 +421,7 @@
         }

         /* set push-ifconfig-constraint directive */
-        if ((dev =3D=3D DEV_TYPE_TAP || topology =3D=3D TOP_SUBNET))
+        if ((dev =3D=3D DEV_TYPE_TAP || o->topology =3D=3D TOP_SUBNET))
         {
             o->push_ifconfig_constraint_defined =3D true;
             o->push_ifconfig_constraint_network =3D o->server_network;
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index d0fd17d..6b42e13 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -30,6 +30,8 @@

 #include "options.h"

+void helper_setdefault_topology(struct options *o);
+
 void helper_keepalive(struct options *o);

 void helper_client_server(struct options *o);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e2bfe0e..07387cd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -796,7 +796,7 @@
         o->gc_owned =3D true;
     }
     o->mode =3D MODE_POINT_TO_POINT;
-    o->topology =3D TOP_SUBNET;
+    o->topology =3D TOP_UNDEF;
     o->ce.proto =3D PROTO_UDP;
     o->ce.af =3D AF_UNSPEC;
     o->ce.bind_ipv6_only =3D false;
@@ -3478,6 +3478,7 @@
     }
 }

+
 /**
  * Checks for availibility of Chacha20-Poly1305 and sets
  * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
@@ -3680,6 +3681,8 @@
      * sequences of options.
      */
     helper_client_server(o);
+    /* must be called after helpers that might set --mode */
+    helper_setdefault_topology(o);
     helper_keepalive(o);
     helper_tcp_nodelay(o);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/554?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iefd209c0856ef395ab74055496130de00b86ead0
Gerrit-Change-Number: 554
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--dtBiXnIF8Dg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/554?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Use topology default of &quot;subnet&quot; onl=
y for server mode<br><br>The setting of --topology changes the syntax of --=
ifconfig.<br>So changing the default of --topology breaks all existing<br>c=
onfigs that use --ifconfig but not --topology.<br><br>For P2P setups that i=
s probably a signification percentage.<br>For server setups the percentage =
is hopefully lower since<br>--ifconfig is implicitly set by --server. Also =
more people<br>might have set their topology explicitly since it makes a<br=
>much bigger difference. Clients will usually get the<br>topology and the I=
P config pushed by the server.<br><br>So we decided to not switch the defau=
lt for everyone to<br>not affect P2P setups. What we care about is to chang=
e<br>the default for --mode server, so we only do that now. For<br>people u=
sing --server this should be transparent except<br>for a pool reset.<br><br=
>Github: Openvpn/openvpn#529<br>Change-Id: Iefd209c0856ef395ab74055496130de=
00b86ead0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>A=
cked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20=
240501124254.29114-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg28592.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>M src/openvpn/h=
elper.c<br>M src/openvpn/helper.h<br>M src/openvpn/options.c<br>4 files cha=
nged, 49 insertions(+), 16 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index b2278ab..fa=
0fb22 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -23,11 +23,12 @@</span><br><span> ``persist-key`` =
option has been enabled by default.</span><br><span>     All the keys will =
be kept in memory across restart.</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Default for ``--topology`` changed to ``sub=
net``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Previous rel=
eases used ``net30`` as default. This only affects</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    configs with ``--dev tun`` and only IPv4. =
Note that this</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cha=
nges the semantics of ``--ifconfig``, so if you have manual</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    settings for that in your config =
but not set ``--topology``</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+Default for ``--topology`` changed to ``subnet`` for ``--mode server=
``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Previous rele=
ases always used ``net30`` as default. This only affects</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    configs with ``--mode server`` or =
``--server`` (the latter implies the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    former), and ``--dev tun``, and only if IPv4 is enable=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Note that thi=
s changes the semantics of ``--ifconfig``, so if you have</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    manual settings for that in your =
config but not set ``--topology``</span><br><span>     your config might fa=
il to parse with the new version. Just adding</span><br><span>     ``--topo=
logy net30`` to the config should fix the problem.</span><br><span>     By =
default ``--topology`` is pushed from server to client.</span><br><span>dif=
f --git a/src/openvpn/helper.c b/src/openvpn/helper.c</span><br><span>index=
 1bab84c..5681718 100644</span><br><span>--- a/src/openvpn/helper.c</span><=
br><span>+++ b/src/openvpn/helper.c</span><br><span>@@ -137,6 +137,32 @@</s=
pan><br><span> }</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Set --topology default depending on --mode</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+helper_setdefault_topology(struct options *o)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (o-&gt;topology !=3D TOP_UNDEF)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int dev =3D dev_type_enum(o-&gt;dev, o-&gt;dev_type);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (dev !=3D DEV_TYPE_TUN=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        o-&gt;topology =3D TOP_SUBNET;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        o-&gt;topology =3D TOP_NET30;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</s=
pan><br><span>  * Process server, server-bridge, and client helper</span><b=
r><span>  * directives after the parameters themselves have been</span><br>=
<span>@@ -151,7 +177,6 @@</span><br><span>      * Get tun/tap/null device t=
ype</span><br><span>      */</span><br><span>     const int dev =3D dev_typ=
e_enum(o-&gt;dev, o-&gt;dev_type);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const int topology =3D o-&gt;topology;</span><br><span> </=
span><br><span>     /*</span><br><span>      *</span><br><span>@@ -177,11 +=
202,11 @@</span><br><span> </span><br><span>         if (o-&gt;server_flags=
 &amp; SF_NOPOOL)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg( M_USAGE, &quot;--server-ipv6 is inc=
ompatible with &#39;nopool&#39; option&quot; );</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_USAGE, &quot;--server-ipv6 is=
 incompatible with &#39;nopool&#39; option&quot;);</span><br><span>        =
 }</span><br><span>         if (o-&gt;ifconfig_ipv6_pool_defined)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg( M_USAGE, &quot;--server-ipv6 already defines an ifconfig-ipv6-=
pool, so you can&#39;t also specify --ifconfig-pool explicitly&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE,=
 &quot;--server-ipv6 already defines an ifconfig-ipv6-pool, so you can&#39;=
t also specify --ifconfig-pool explicitly&quot;);</span><br><span>         =
}</span><br><span> </span><br><span>         o-&gt;mode =3D MODE_SERVER;</s=
pan><br><span>@@ -207,7 +232,7 @@</span><br><span>                         =
                          o-&gt;server_netbits_ipv6 &lt; 112 ? 0x1000 : 2);=
</span><br><span>         o-&gt;ifconfig_ipv6_pool_netbits =3D o-&gt;server=
_netbits_ipv6;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        push_option( o, &quot;tun-ipv6&quot;, M_USAGE );</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        push_option(o, &quo=
t;tun-ipv6&quot;, M_USAGE);</span><br><span>     }</span><br><span> </span>=
<br><span>     /*</span><br><span>@@ -305,8 +330,10 @@</span><br><span> </s=
pan><br><span>             o-&gt;mode =3D MODE_SERVER;</span><br><span>    =
         o-&gt;tls_server =3D true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            /* Need to know topology now */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            helper_setdefault_topol=
ogy(o);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (topology =3D=3D TOP_NET30 || topology =3D=3D TOP_P2P)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (o-&gt=
;topology =3D=3D TOP_NET30 || o-&gt;topology =3D=3D TOP_P2P)</span><br><spa=
n>             {</span><br><span>                 o-&gt;ifconfig_local =3D =
print_in_addr_t(o-&gt;server_network + 1, 0, &amp;o-&gt;gc);</span><br><spa=
n>                 o-&gt;ifconfig_remote_netmask =3D print_in_addr_t(o-&gt;=
server_network + 2, 0, &amp;o-&gt;gc);</span><br><span>@@ -324,12 +351,12 @=
@</span><br><span>                 {</span><br><span>                     p=
ush_option(o, print_opt_route(o-&gt;server_network, o-&gt;server_netmask, &=
amp;o-&gt;gc), M_USAGE);</span><br><span>                 }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                else if (topology =3D=
=3D TOP_NET30)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           else if (o-&gt;topology =3D=3D TOP_NET30)</span><br><span>      =
           {</span><br><span>                     push_option(o, print_opt_=
route(o-&gt;server_network + 1, 0, &amp;o-&gt;gc), M_USAGE);</span><br><spa=
n>                 }</span><br><span>             }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else if (topology =3D=3D TOP_SU=
BNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            el=
se if (o-&gt;topology =3D=3D TOP_SUBNET)</span><br><span>             {</sp=
an><br><span>                 o-&gt;ifconfig_local =3D print_in_addr_t(o-&g=
t;server_network + 1, 0, &amp;o-&gt;gc);</span><br><span>                 o=
-&gt;ifconfig_remote_netmask =3D print_in_addr_t(o-&gt;server_netmask, 0, &=
amp;o-&gt;gc);</span><br><span>@@ -354,9 +381,9 @@</span><br><span>        =
         ASSERT(0);</span><br><span>             }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            push_option(o, p=
rint_opt_topology(topology, &amp;o-&gt;gc), M_USAGE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            push_option(o, print_opt_topo=
logy(o-&gt;topology, &amp;o-&gt;gc), M_USAGE);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (topology =3D=3D =
TOP_NET30 &amp;&amp; !(o-&gt;server_flags &amp; SF_NOPOOL))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (o-&gt;topology =3D=
=3D TOP_NET30 &amp;&amp; !(o-&gt;server_flags &amp; SF_NOPOOL))</span><br><=
span>             {</span><br><span>                 msg(M_WARN, &quot;WARN=
ING: --topology net30 support for server &quot;</span><br><span>           =
          &quot;configs with IPv4 pools will be removed in a future &quot;<=
/span><br><span>@@ -394,7 +421,7 @@</span><br><span>         }</span><br><s=
pan> </span><br><span>         /* set push-ifconfig-constraint directive */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((dev =3D=
=3D DEV_TYPE_TAP || topology =3D=3D TOP_SUBNET))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if ((dev =3D=3D DEV_TYPE_TAP || o-&gt;=
topology =3D=3D TOP_SUBNET))</span><br><span>         {</span><br><span>   =
          o-&gt;push_ifconfig_constraint_defined =3D true;</span><br><span>=
             o-&gt;push_ifconfig_constraint_network =3D o-&gt;server_networ=
k;</span><br><span>diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h=
</span><br><span>index d0fd17d..6b42e13 100644</span><br><span>--- a/src/op=
envpn/helper.h</span><br><span>+++ b/src/openvpn/helper.h</span><br><span>@=
@ -30,6 +30,8 @@</span><br><span> </span><br><span> #include &quot;options.=
h&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void helper_setdefault_topology(struct options *o);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void helper_keepali=
ve(struct options *o);</span><br><span> </span><br><span> void helper_clien=
t_server(struct options *o);</span><br><span>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</span><br><span>index e2bfe0e..07387cd 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -796,7 +796,7 @@</span><br><span>         o=
-&gt;gc_owned =3D true;</span><br><span>     }</span><br><span>     o-&gt;m=
ode =3D MODE_POINT_TO_POINT;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    o-&gt;topology =3D TOP_SUBNET;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    o-&gt;topology =3D TOP_UNDEF;</span><br><span>   =
  o-&gt;ce.proto =3D PROTO_UDP;</span><br><span>     o-&gt;ce.af =3D AF_UNS=
PEC;</span><br><span>     o-&gt;ce.bind_ipv6_only =3D false;</span><br><spa=
n>@@ -3478,6 +3478,7 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /**</span><br><span>  * Checks for availibility of Chacha20-Poly1305=
 and sets</span><br><span>  * the ncp_cipher to either AES-256-GCM:AES-128-=
GCM or</span><br><span>@@ -3680,6 +3681,8 @@</span><br><span>      * sequen=
ces of options.</span><br><span>      */</span><br><span>     helper_client=
_server(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* m=
ust be called after helpers that might set --mode */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    helper_setdefault_topology(o);</span>=
<br><span>     helper_keepalive(o);</span><br><span>     helper_tcp_nodelay=
(o);</span><br><span> </span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/554?usp=3Demail">change 554=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/554?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefd209c0856ef395ab740554961=
30de00b86ead0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 554 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--dtBiXnIF8Dg=--

