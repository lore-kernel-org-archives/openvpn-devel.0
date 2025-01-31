From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Jan 2025 15:57:16 +0000
In-Reply-To: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
References: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <9699580a65dcec31c6ca0684aba5ef4ee6e0c6c3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BtYp7/4JXX8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route.c: improve
 get_default_gateway() logic on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BtYp7/4JXX8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/87=
9?usp=3Demail )

Change subject: route.c: improve get_default_gateway() logic on Windows
......................................................................

route.c: improve get_default_gateway() logic on Windows

When adding host route for IPv4, we use the default gateway. There are
cases, however, when this does not work - for example when remote
is not accessible via default gateway but via dedicated route.

Factor out code to look for the best gateway to reach the host from
get_default_gateway_ipv6() and generalize is for IPv4/6.

Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250131154135.32169-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
769.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
M src/openvpn/route.h
2 files changed, 101 insertions(+), 50 deletions(-)




diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index dd37fb9..d895e1c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2732,40 +2732,105 @@
     return ret;
 }

+/**
+ * @brief Determines the best route to a destination for both IPv4 and IPv=
6.
+ *
+ * Uses `GetBestInterfaceEx` and `GetBestRoute2` to find the optimal route
+ * and network interface for the specified destination address.
+ *
+ * @param gc Pointer to struct gc_arena for internal string allocation.
+ * @param dest The destination IP address (IPv4 or IPv6).
+ * @param best_route Pointer to a `MIB_IPFORWARD_ROW2` structure to store =
the best route.
+ * @return DWORD `NO_ERROR` on success, or an error code.
+ */
+static DWORD
+get_best_route(struct gc_arena *gc, SOCKADDR_INET *dest, MIB_IPFORWARD_ROW=
2 *best_route)
+{
+    DWORD best_if_index;
+    DWORD status;
+
+    CLEAR(*best_route);
+
+    /* get the best interface index to reach dest */
+    status =3D GetBestInterfaceEx((struct sockaddr *)dest, &best_if_index);
+    if (status !=3D NO_ERROR)
+    {
+        msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=3D=
%u)",
+            strerror_win32(status, gc),
+            (unsigned int)status);
+        goto done;
+    }
+
+    msg(D_ROUTE_DEBUG, "GetBestInterfaceEx() returned if=3D%d", (int)best_=
if_index);
+
+    /* get the routing information (such as NextHop) for the destination a=
nd interface */
+    NET_LUID luid;
+    CLEAR(luid);
+    SOCKADDR_INET best_src;
+    CLEAR(best_src);
+    status =3D GetBestRoute2(&luid, best_if_index, NULL,
+                           dest, 0, best_route, &best_src);
+    if (status !=3D NO_ERROR)
+    {
+        msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=3D=
%u)",
+            strerror_win32(status, gc),
+            (unsigned int)status);
+        goto done;
+    }
+
+done:
+    return status;
+}
+
 void
 get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
 {
-    struct gc_arena gc =3D gc_new();
-
-    const IP_ADAPTER_INFO *adapters =3D get_adapter_info_list(&gc);
-    const MIB_IPFORWARDTABLE *routes =3D get_windows_routing_table(&gc);
-    const MIB_IPFORWARDROW *row =3D get_default_gateway_row(routes);
-    DWORD a_index;
-    const IP_ADAPTER_INFO *ai;
-
     CLEAR(*rgi);

-    if (row)
+    struct gc_arena gc =3D gc_new();
+
+    /* convert in_addr_t into SOCKADDR_INET */
+    SOCKADDR_INET sa;
+    CLEAR(sa);
+    sa.si_family =3D AF_INET;
+    sa.Ipv4.sin_addr.s_addr =3D htonl(dest);
+
+    /* get the best route to the destination */
+    MIB_IPFORWARD_ROW2 best_route;
+    CLEAR(best_route);
+    DWORD status =3D get_best_route(&gc, &sa, &best_route);
+    if (status !=3D NO_ERROR)
     {
-        rgi->gateway.addr =3D ntohl(row->dwForwardNextHop);
-        if (rgi->gateway.addr)
+        goto done;
+    }
+
+    rgi->flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+    rgi->gateway.addr =3D ntohl(best_route.NextHop.Ipv4.sin_addr.S_un.S_ad=
dr);
+    rgi->adapter_index =3D best_route.InterfaceIndex;
+
+    if (rgi->gateway.addr =3D=3D INADDR_ANY)
+    {
+        rgi->flags |=3D RGI_ON_LINK;
+    }
+
+    /* get netmask and MAC address */
+    const IP_ADAPTER_INFO *adapters =3D get_adapter_info_list(&gc);
+    const IP_ADAPTER_INFO *ai =3D get_adapter(adapters, rgi->adapter_index=
);
+    if (ai)
+    {
+        memcpy(rgi->hwaddr, ai->Address, 6);
+        rgi->flags |=3D RGI_HWADDR_DEFINED;
+
+        /* get netmask for non-onlink routes */
+        in_addr_t nm =3D inet_addr(ai->IpAddressList.IpMask.String);
+        if (!(rgi->flags & RGI_ON_LINK) && (nm !=3D INADDR_NONE))
         {
-            rgi->flags |=3D RGI_ADDR_DEFINED;
-            a_index =3D adapter_index_of_ip(adapters, rgi->gateway.addr, N=
ULL, &rgi->gateway.netmask);
-            if (a_index !=3D TUN_ADAPTER_INDEX_INVALID)
-            {
-                rgi->adapter_index =3D a_index;
-                rgi->flags |=3D (RGI_IFACE_DEFINED|RGI_NETMASK_DEFINED);
-                ai =3D get_adapter(adapters, a_index);
-                if (ai)
-                {
-                    memcpy(rgi->hwaddr, ai->Address, 6);
-                    rgi->flags |=3D RGI_HWADDR_DEFINED;
-                }
-            }
+            rgi->gateway.netmask =3D ntohl(nm);
+            rgi->flags |=3D RGI_NETMASK_DEFINED;
         }
     }

+done:
     gc_free(&gc);
 }

@@ -2823,43 +2888,22 @@
                          const struct in6_addr *dest, openvpn_net_ctx_t *c=
tx)
 {
     struct gc_arena gc =3D gc_new();
-    MIB_IPFORWARD_ROW2 BestRoute;
-    SOCKADDR_INET DestinationAddress, BestSourceAddress;
-    DWORD BestIfIndex;
-    DWORD status;
-    NET_LUID InterfaceLuid;
-
     CLEAR(*rgi6);
-    CLEAR(InterfaceLuid);               /* cleared =3D not used for lookup=
 */
-    CLEAR(DestinationAddress);

+    SOCKADDR_INET DestinationAddress;
+    CLEAR(DestinationAddress);
     DestinationAddress.si_family =3D AF_INET6;
     if (dest)
     {
         DestinationAddress.Ipv6.sin6_addr =3D *dest;
     }

-    status =3D GetBestInterfaceEx( (struct sockaddr *)&DestinationAddress,=
 &BestIfIndex );
+    MIB_IPFORWARD_ROW2 BestRoute;
+    CLEAR(BestRoute);
+    DWORD status =3D get_best_route(&gc, &DestinationAddress, &BestRoute);

     if (status !=3D NO_ERROR)
     {
-        msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=3D=
%u)",
-            strerror_win32(status, &gc),
-            (unsigned int)status);
-        goto done;
-    }
-
-    msg( D_ROUTE, "GetBestInterfaceEx() returned if=3D%d", (int) BestIfInd=
ex );
-
-    status =3D GetBestRoute2( &InterfaceLuid, BestIfIndex, NULL,
-                            &DestinationAddress, 0,
-                            &BestRoute, &BestSourceAddress );
-
-    if (status !=3D NO_ERROR)
-    {
-        msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=3D=
%u)",
-            strerror_win32(status, &gc),
-            (unsigned int)status);
         goto done;
     }

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 0bbedbb..98ea79e 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -334,6 +334,13 @@

 bool is_special_addr(const char *addr_str);

+/**
+ * @brief Retrieves the best gateway for a given destination based on the =
routing table.
+ *
+ * @param rgi  Pointer to a struct to store the gateway information.
+ * @param dest Destination IP address in host byte order.
+ * @param ctx  Pointer to a platform-specific network context struct.
+ */
 void get_default_gateway(struct route_gateway_info *rgi,
                          in_addr_t dest,
                          openvpn_net_ctx_t *ctx);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb
Gerrit-Change-Number: 879
Gerrit-PatchSet: 6
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--BtYp7/4JXX8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/879?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">route.c: improve get_default_gateway() logic o=
n Windows<br><br>When adding host route for IPv4, we use the default gatewa=
y. There are<br>cases, however, when this does not work - for example when =
remote<br>is not accessible via default gateway but via dedicated route.<br=
><br>Factor out code to look for the best gateway to reach the host from<br=
>get_default_gateway_ipv6() and generalize is for IPv4/6.<br><br>Change-Id:=
 I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb<br>Signed-off-by: Lev Stipakov &=
lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>M=
essage-Id: &lt;20250131154135.32169-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30769.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/r=
oute.c<br>M src/openvpn/route.h<br>2 files changed, 101 insertions(+), 50 d=
eletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex dd37fb9..d895e1c 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -2732,40 +2732,105=
 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @brief Determines the best route t=
o a destination for both IPv4 and IPv6.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Uses `GetBestInterfaceEx` and `GetBestRoute2` to find the optimal rou=
te</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and network in=
terface for the specified destination address.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param gc Pointer to struct gc_arena for internal string alloc=
ation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param des=
t The destination IP address (IPv4 or IPv6).</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param best_route Pointer to a `MIB_IPFORWARD_R=
OW2` structure to store the best route.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return DWORD `NO_ERROR` on success, or an error cod=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+get_best_route(struct gc_arena *gc, SOCK=
ADDR_INET *dest, MIB_IPFORWARD_ROW2 *best_route)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    DWORD best_if_index;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    DWORD status;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    C=
LEAR(*best_route);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* get the best =
interface index to reach dest */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    status =3D GetBestInterfaceEx((struct sockaddr *)dest, &am=
p;best_if_index);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (status !=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(D_ROUTE, &quot;NOTE: GetBestInterfaceEx returned error: %s (code=3D%u=
)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 strerror_win32(status, gc),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            (unsigned int)status);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        goto done;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_=
ROUTE_DEBUG, &quot;GetBestInterfaceEx() returned if=3D%d&quot;, (int)best_i=
f_index);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* get the routing inform=
ation (such as NextHop) for the destination and interface */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    NET_LUID luid;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(luid);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    SOCKADDR_INET best_src;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(best_src);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D GetBestRoute2(=
&amp;luid, best_if_index, NULL,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                           dest, 0, best_route, &amp;best_src);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D=
 NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &q=
uot;NOTE: GetIpForwardEntry2 returned error: %s (code=3D%u)&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            strerror_win32(s=
tatus, gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    (unsigned int)status);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return status;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> void</span><br><span> get_default_gateway=
(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const I=
P_ADAPTER_INFO *adapters =3D get_adapter_info_list(&amp;gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const MIB_IPFORWARDTABLE *routes=
 =3D get_windows_routing_table(&amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const MIB_IPFORWARDROW *row =3D get_default_gateway_=
row(routes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD=
 a_index;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const IP=
_ADAPTER_INFO *ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>     CLEAR(*rgi);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (row)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* convert in_addr_t into SOCKADDR_INET */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SOCKADDR_INET sa;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(sa);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    sa.si_family =3D AF_INET;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    sa.Ipv4.sin_addr.s=
_addr =3D htonl(dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* get the b=
est route to the destination */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    MIB_IPFORWARD_ROW2 best_route;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CLEAR(best_route);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    DWORD status =3D get_best_route(&amp;gc, =
&amp;sa, &amp;best_route);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (status !=3D NO_ERROR)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        rgi-&gt;gateway.addr =3D ntoh=
l(row-&gt;dwForwardNextHop);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (rgi-&gt;gateway.addr)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto done;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rgi-&gt;f=
lags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    rgi-&gt;gateway.addr =3D ntohl(best_route.Ne=
xtHop.Ipv4.sin_addr.S_un.S_addr);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    rgi-&gt;adapter_index =3D best_route.InterfaceIndex;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (rgi-&gt;gateway.addr =3D=3D INADD=
R_ANY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        rgi-&gt;flags |=3D =
RGI_ON_LINK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* get netmask and MAC address */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const IP_ADAPTER_I=
NFO *adapters =3D get_adapter_info_list(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const IP_ADAPTER_INFO *ai =3D get_adapter=
(adapters, rgi-&gt;adapter_index);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (ai)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 memcpy(rgi-&gt;hwaddr, ai-&gt;Address, 6);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        rgi-&gt;flags |=3D RGI_HWADDR_DEFINED;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* get netmask for non-onlink rou=
tes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in_ad=
dr_t nm =3D inet_addr(ai-&gt;IpAddressList.IpMask.String);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!(rgi-&gt;flags &amp; RG=
I_ON_LINK) &amp;&amp; (nm !=3D INADDR_NONE))</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            rgi-&gt;flags=
 |=3D RGI_ADDR_DEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            a_index =3D adapter_index_of_ip(adapters, rgi-&gt;gateway.add=
r, NULL, &amp;rgi-&gt;gateway.netmask);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (a_index !=3D TUN_ADAPTER_INDEX_INVALID)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                rgi-&gt;adapter=
_index =3D a_index;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              rgi-&gt;flags |=3D (RGI_IFACE_DEFINED|RGI_NETMASK_DEFINED);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ai =3D =
get_adapter(adapters, a_index);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                if (ai)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    memcpy(rgi-&gt;hwaddr, ai-&gt;Address, 6);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    rgi-&g=
t;flags |=3D RGI_HWADDR_DEFINED;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            rgi-&gt;gateway.netmask =3D ntohl(nm);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            rgi-&gt;flags |=3D RGI_NETMAS=
K_DEFINED;</span><br><span>         }</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br>=
<span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br=
><span>@@ -2823,43 +2888,22 @@</span><br><span>                          co=
nst struct in6_addr *dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    MIB_IPFORWARD_ROW2 BestRoute;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SOCKADDR_INET DestinationAddress=
, BestSourceAddress;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   DWORD BestIfIndex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    DWORD status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
NET_LUID InterfaceLuid;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span>     CLEAR(*rgi6);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    CLEAR(InterfaceLuid);               /* cleared =3D not =
used for lookup */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 CLEAR(DestinationAddress);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SOCKADDR_INET DestinationAddress;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(DestinationAddress);<=
/span><br><span>     DestinationAddress.si_family =3D AF_INET6;</span><br><=
span>     if (dest)</span><br><span>     {</span><br><span>         Destina=
tionAddress.Ipv6.sin6_addr =3D *dest;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D Get=
BestInterfaceEx( (struct sockaddr *)&amp;DestinationAddress, &amp;BestIfInd=
ex );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MIB_IPFORW=
ARD_ROW2 BestRoute;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    CLEAR(BestRoute);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    DWORD status =3D get_best_route(&amp;gc, &amp;DestinationAddress, &am=
p;BestRoute);</span><br><span> </span><br><span>     if (status !=3D NO_ERR=
OR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(D_ROUTE, &quot;NOTE: GetBestInterfaceEx returned error: %s=
 (code=3D%u)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          strerror_win32(status, &amp;gc),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            (unsigned int)status);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        goto done;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg( D_ROUTE, &quot;GetBestInterfaceEx() returned if=3D%d&quot;, (int) BestI=
fIndex );</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    status =3D GetBestRoute2( &am=
p;InterfaceLuid, BestIfIndex, NULL,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                            &amp;DestinationAddress, 0,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 &amp;BestRoute, &amp;BestSourceAddress );</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (status !=3D NO_ERROR)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(D_ROUTE, &quot;NOTE: GetIpForwardEntry2 returned error: %s (code=3D%u)&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            str=
error_win32(status, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            (unsigned int)status);</span><br><span>         goto do=
ne;</span><br><span>     }</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/route.h b/src/openvpn/route.h</span><br><span>index 0bbedbb..98e=
a79e 100644</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b=
/src/openvpn/route.h</span><br><span>@@ -334,6 +334,13 @@</span><br><span> =
</span><br><span> bool is_special_addr(const char *addr_str);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Retrieves the best ga=
teway for a given destination based on the routing table.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param rgi  Pointer to a struct to store the gatewa=
y information.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram dest Destination IP address in host byte order.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param ctx  Pointer to a platform-spec=
ific network context struct.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span> void get_default_gateway(struct route_gateway=
_info *rgi,</span><br><span>                          in_addr_t dest,</span=
><br><span>                          openvpn_net_ctx_t *ctx);</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/879?usp=3Demail">change 879</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/879?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb=
2c65599cd86fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 879 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--BtYp7/4JXX8=--

