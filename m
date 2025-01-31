From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 31 Jan 2025 13:31:08 +0000
In-Reply-To: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
References: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <ac41ea0829a1561f0624e770eb631a89a68d213b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nDuM7LRL8tk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nDuM7LRL8tk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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
---
M src/openvpn/route.c
M src/openvpn/route.h
2 files changed, 104 insertions(+), 50 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/879/3

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index dd37fb9..023feaf 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2732,40 +2732,108 @@
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
+    rgi->flags =3D RGI_ADDR_DEFINED;
+    rgi->gateway.addr =3D ntohl(best_route.NextHop.Ipv4.sin_addr.S_un.S_ad=
dr);
+
+    if (rgi->gateway.addr =3D=3D 0)
+    {
+        rgi->flags |=3D (RGI_ON_LINK | RGI_IFACE_DEFINED);
+        rgi->adapter_index =3D best_route.InterfaceIndex;
+    }
+    else
+    {
+        /* get netmask and adapter index */
+        const IP_ADAPTER_INFO *adapters =3D get_adapter_info_list(&gc);
+        DWORD a_index =3D adapter_index_of_ip(adapters, rgi->gateway.addr,=
 NULL, &rgi->gateway.netmask);
+        if (a_index =3D=3D TUN_ADAPTER_INDEX_INVALID)
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
+            goto done;
+        }
+        rgi->adapter_index =3D a_index;
+        rgi->flags |=3D (RGI_IFACE_DEFINED | RGI_NETMASK_DEFINED);
+
+        /* get MAC address */
+        const IP_ADAPTER_INFO *ai =3D get_adapter(adapters, rgi->adapter_i=
ndex);
+        if (ai)
+        {
+            memcpy(rgi->hwaddr, ai->Address, 6);
+            rgi->flags |=3D RGI_HWADDR_DEFINED;
         }
     }

+done:
     gc_free(&gc);
 }

@@ -2823,43 +2891,22 @@
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
=20
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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--nDuM7LRL8tk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">route.c: improve get_default_gateway() logic on Wind=
ows<br><br>When adding host route for IPv4, we use the default gateway. The=
re are<br>cases, however, when this does not work - for example when remote=
<br>is not accessible via default gateway but via dedicated route.<br><br>F=
actor out code to look for the best gateway to reach the host from<br>get_d=
efault_gateway_ipv6() and generalize is for IPv4/6.<br><br>Change-Id: I6c7e=
1cef637fe9fb3f3bc6ff4fb2c65599cd86fb<br>Signed-off-by: Lev Stipakov &lt;lev=
@...515...&gt;<br>---<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>=
2 files changed, 104 insertions(+), 50 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/79/879/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index dd37fb9.=
.023feaf 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+=
++ b/src/openvpn/route.c</span><br><span>@@ -2732,40 +2732,108 @@</span><br=
><span>     return ret;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @brief Determines the best route to a destinati=
on for both IPv4 and IPv6.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Uses `G=
etBestInterfaceEx` and `GetBestRoute2` to find the optimal route</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * and network interface for t=
he specified destination address.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param gc Pointer to struct gc_arena for internal string allocation.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest The destina=
tion IP address (IPv4 or IPv6).</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param best_route Pointer to a `MIB_IPFORWARD_ROW2` structur=
e to store the best route.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return DWORD `NO_ERROR` on success, or an error code.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+get_best_route(struct gc_arena *gc, SOCKADDR_INET *de=
st, MIB_IPFORWARD_ROW2 *best_route)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  DWORD best_if_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    DWORD status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*best_ro=
ute);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* get the best interface ind=
ex to reach dest */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    status =3D GetBestInterfaceEx((struct sockaddr *)dest, &amp;best_if_ind=
ex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (status =
!=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE=
, &quot;NOTE: GetBestInterfaceEx returned error: %s (code=3D%u)&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            strerror_win=
32(status, gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        (unsigned int)status);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE_DEBUG, =
&quot;GetBestInterfaceEx() returned if=3D%d&quot;, (int)best_if_index);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* get the routing information (such =
as NextHop) for the destination and interface */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    NET_LUID luid;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    CLEAR(luid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SOCKADDR_INET best_src;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(best_src);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    status =3D GetBestRoute2(&amp;luid, =
best_if_index, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           dest, 0, best_route, &amp;best_src);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D NO_ERROR)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;NOTE: G=
etIpForwardEntry2 returned error: %s (code=3D%u)&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            strerror_win32(status, gc),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (unsign=
ed int)status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return status;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> void</span><br><span> get_default_gateway(struct rout=
e_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const IP_ADAPTER_IN=
FO *adapters =3D get_adapter_info_list(&amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const MIB_IPFORWARDTABLE *routes =3D get_win=
dows_routing_table(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const MIB_IPFORWARDROW *row =3D get_default_gateway_row(routes);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD a_index;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const IP_ADAPTER_INF=
O *ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n>     CLEAR(*rgi);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (row)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* convert in_addr_t into SOCKADDR_INET */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SOCKADDR_INET sa;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    CLEAR(sa);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    sa.si_family =3D AF_INET;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    sa.Ipv4.sin_addr.s_addr =3D ht=
onl(dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* get the best route to=
 the destination */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    MIB_IPFORWARD_ROW2 best_route;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(best_route);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    DWORD status =3D get_best_route(&amp;gc, &amp;sa, &am=
p;best_route);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (status !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        rgi-&gt;gateway.addr =3D ntohl(row-&gt;dw=
ForwardNextHop);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (rgi-&gt;gateway.addr)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    rgi-&gt;flags =3D RGI=
_ADDR_DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
gi-&gt;gateway.addr =3D ntohl(best_route.NextHop.Ipv4.sin_addr.S_un.S_addr)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (rgi-&gt;gateway.addr =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        rgi-&gt;flags |=3D (RGI_=
ON_LINK | RGI_IFACE_DEFINED);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        rgi-&gt;adapter_index =3D best_route.InterfaceIndex;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* get netmask and adapter index */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const IP_ADAPTER_INFO *adapters=
 =3D get_adapter_info_list(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        DWORD a_index =3D adapter_index_of_ip(adapters, rg=
i-&gt;gateway.addr, NULL, &amp;rgi-&gt;gateway.netmask);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (a_index =3D=3D TUN_ADAPTER=
_INDEX_INVALID)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            rgi-&gt;flags |=3D RGI_ADDR_DEFINED;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            a_index =3D ada=
pter_index_of_ip(adapters, rgi-&gt;gateway.addr, NULL, &amp;rgi-&gt;gateway=
.netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (a_index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                rgi-&gt;adapter_index =3D a_index;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                rgi-&gt;flags |=
=3D (RGI_IFACE_DEFINED|RGI_NETMASK_DEFINED);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                ai =3D get_adapter(adapters, a_index=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if =
(ai)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    m=
emcpy(rgi-&gt;hwaddr, ai-&gt;Address, 6);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    rgi-&gt;flags |=3D RGI_HWADDR_DEFIN=
ED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        rgi-&gt;adapter_index =3D a=
_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rgi-=
&gt;flags |=3D (RGI_IFACE_DEFINED | RGI_NETMASK_DEFINED);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* get MAC address */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const IP_ADAPTER_INFO *ai =3D get_adap=
ter(adapters, rgi-&gt;adapter_index);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (ai)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            memcpy(rgi-&gt;hwaddr, ai-&gt;Address, 6);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            rgi-&gt;flags |=3D RGI_H=
WADDR_DEFINED;</span><br><span>         }</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span>=
<br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span=
><br><span>@@ -2823,43 +2891,22 @@</span><br><span>                        =
  const struct in6_addr *dest, openvpn_net_ctx_t *ctx)</span><br><span> {</=
span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    MIB_IPFORWARD_ROW2 BestRoute;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    SOCKADDR_INET DestinationAd=
dress, BestSourceAddress;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    DWORD BestIfIndex;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    DWORD status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    NET_LUID InterfaceLuid;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     CLEAR(*rgi6);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    CLEAR(InterfaceLuid);               /* cleared =3D=
 not used for lookup */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    CLEAR(DestinationAddress);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    SOCKADDR_INET DestinationAddress;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(DestinationAddre=
ss);</span><br><span>     DestinationAddress.si_family =3D AF_INET6;</span>=
<br><span>     if (dest)</span><br><span>     {</span><br><span>         De=
stinationAddress.Ipv6.sin6_addr =3D *dest;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =
=3D GetBestInterfaceEx( (struct sockaddr *)&amp;DestinationAddress, &amp;Be=
stIfIndex );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MIB=
_IPFORWARD_ROW2 BestRoute;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    CLEAR(BestRoute);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    DWORD status =3D get_best_route(&amp;gc, &amp;DestinationAddre=
ss, &amp;BestRoute);</span><br><span> </span><br><span>     if (status !=3D=
 NO_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(D_ROUTE, &quot;NOTE: GetBestInterfaceEx returned er=
ror: %s (code=3D%u)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            strerror_win32(status, &amp;gc),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            (unsigned int)status);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        goto done;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg( D_ROUTE, &quot;GetBestInterfaceEx() returned if=3D%d&quot;, (int)=
 BestIfIndex );</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D GetBestRoute=
2( &amp;InterfaceLuid, BestIfIndex, NULL,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                            &amp;DestinationAddress, 0,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
       &amp;BestRoute, &amp;BestSourceAddress );</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (status !=3D NO_ERROR)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(D_ROUTE, &quot;NOTE: GetIpForwardEntry2 returned error: %s (code=
=3D%u)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    strerror_win32(status, &amp;gc),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            (unsigned int)status);</span><br><span>         =
goto done;</span><br><span>     }</span><br><span> </span><br><span>diff --=
git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index 0bbed=
bb..98ea79e 100644</span><br><span>--- a/src/openvpn/route.h</span><br><spa=
n>+++ b/src/openvpn/route.h</span><br><span>@@ -334,6 +334,13 @@</span><br>=
<span> </span><br><span> bool is_special_addr(const char *addr_str);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Retrieves the =
best gateway for a given destination based on the routing table.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param rgi  Pointer to a struct to store the=
 gateway information.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param dest Destination IP address in host byte order.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx  Pointer to a platfor=
m-specific network context struct.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span> void get_default_gateway(struct route_g=
ateway_info *rgi,</span><br><span>                          in_addr_t dest,=
</span><br><span>                          openvpn_net_ctx_t *ctx);</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/879?usp=3Demail">change 879</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/879?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb=
2c65599cd86fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 879 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--nDuM7LRL8tk=--

