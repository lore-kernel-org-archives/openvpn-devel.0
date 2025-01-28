From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 13:17:56 +0000
References: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2f5e78a5c6ac0839c6bd09dc2a9236db9ba83057-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4ZAZSK6jaHU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4ZAZSK6jaHU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail

to review the following change.


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
1 file changed, 91 insertions(+), 52 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/879/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 640b0dc..dc98f78 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2732,40 +2732,100 @@
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
-        {
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
-        }
+        goto done;
     }

+    rgi->flags =3D RGI_ADDR_DEFINED;
+    rgi->gateway.addr =3D ntohl(best_route.NextHop.Ipv4.sin_addr.S_un.S_ad=
dr);
+
+    /* get netmask and adapter index */
+    const IP_ADAPTER_INFO *adapters =3D get_adapter_info_list(&gc);
+    DWORD a_index =3D adapter_index_of_ip(adapters, rgi->gateway.addr, NUL=
L, &rgi->gateway.netmask);
+    if (a_index =3D=3D TUN_ADAPTER_INDEX_INVALID)
+    {
+        goto done;
+    }
+    rgi->adapter_index =3D a_index;
+    rgi->flags |=3D (RGI_IFACE_DEFINED | RGI_NETMASK_DEFINED);
+
+    /* get MAC address */
+    const IP_ADAPTER_INFO *ai =3D get_adapter(adapters, rgi->adapter_index=
);
+    if (ai)
+    {
+        memcpy(rgi->hwaddr, ai->Address, 6);
+        rgi->flags |=3D RGI_HWADDR_DEFINED;
+    }
+
+done:
     gc_free(&gc);
 }

@@ -2823,43 +2883,22 @@
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


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb
Gerrit-Change-Number: 879
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--4ZAZSK6jaHU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">route.c: improve get_default_gateway() logic on Windows<br><b=
r>When adding host route for IPv4, we use the default gateway. There are<br=
>cases, however, when this does not work - for example when remote<br>is no=
t accessible via default gateway but via dedicated route.<br><br>Factor out=
 code to look for the best gateway to reach the host from<br>get_default_ga=
teway_ipv6() and generalize is for IPv4/6.<br><br>Change-Id: I6c7e1cef637fe=
9fb3f3bc6ff4fb2c65599cd86fb<br>Signed-off-by: Lev Stipakov &lt;lev@...1699...=
.&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed, 91 insertions(+), =
52 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/79/879/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/route.c b/src/openvpn=
/route.c</span><br><span>index 640b0dc..dc98f78 100644</span><br><span>--- =
a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><=
span>@@ -2732,40 +2732,100 @@</span><br><span>     return ret;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief D=
etermines the best route to a destination for both IPv4 and IPv6.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Uses `GetBestInterfaceEx` and `GetBestRoute=
2` to find the optimal route</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * and network interface for the specified destination address.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param gc Pointer to struct gc_arena=
 for internal string allocation.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param dest The destination IP address (IPv4 or IPv6).</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param best_route Poi=
nter to a `MIB_IPFORWARD_ROW2` structure to store the best route.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return DWORD `NO_ERROR` o=
n success, or an error code.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_best_route=
(struct gc_arena *gc, SOCKADDR_INET *dest, MIB_IPFORWARD_ROW2 *best_route)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    DWORD best_if_index;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    DWORD status;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    CLEAR(*best_route);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* get the best interface index to reach dest */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    status =3D GetBestInterfaceEx((s=
truct sockaddr *)dest, &amp;best_if_index);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (status !=3D NO_ERROR)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_ROUTE, &quot;NOTE: GetBestInterfaceEx ret=
urned error: %s (code=3D%u)&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            strerror_win32(status, gc),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            (unsigned int)status);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_ROUTE_DEBUG, &quot;GetBestInterfaceEx() returned =
if=3D%d&quot;, (int)best_if_index);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* get the routing information (such as NextHop) for the destination and i=
nterface */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NET_=
LUID luid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(luid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SOCKADDR=
_INET best_src;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(best_src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 status =3D GetBestRoute2(&amp;luid, best_if_index, NULL,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                           dest, 0, b=
est_route, &amp;best_src);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (status !=3D NO_ERROR)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(D_ROUTE, &quot;NOTE: GetIpForwardEntry2 returned error: %s (=
code=3D%u)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          strerror_win32(status, gc),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            (unsigned int)status);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return st=
atus;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br=
><span> get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest,=
 openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    const IP_ADAPTER_INFO *adapters =3D get_adapter_info_li=
st(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 MIB_IPFORWARDTABLE *routes =3D get_windows_routing_table(&amp;gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const MIB_IPFORWARDROW *r=
ow =3D get_default_gateway_row(routes);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    DWORD a_index;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const IP_ADAPTER_INFO *ai;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>     CLEAR(*rgi);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (row)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* convert in_addr_t into=
 SOCKADDR_INET */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SOCKADDR_INET sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    CLEAR(sa);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
a.si_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    sa.Ipv4.sin_addr.s_addr =3D htonl(dest);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* get the best route to the destination */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    MIB_IPFORWARD_ROW2 best_route;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(best_route)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD status =
=3D get_best_route(&amp;gc, &amp;sa, &amp;best_route);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D NO_ERROR)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
gi-&gt;gateway.addr =3D ntohl(row-&gt;dwForwardNextHop);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (rgi-&gt;gateway.addr)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            rgi-&gt;flags |=3D RGI_ADDR_=
DEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            a=
_index =3D adapter_index_of_ip(adapters, rgi-&gt;gateway.addr, NULL, &amp;r=
gi-&gt;gateway.netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (a_index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                rgi-&gt;adapter_index =3D a_in=
dex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                r=
gi-&gt;flags |=3D (RGI_IFACE_DEFINED|RGI_NETMASK_DEFINED);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                ai =3D get_adapter(ada=
pters, a_index);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           if (ai)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             memcpy(rgi-&gt;hwaddr, ai-&gt;Address, 6);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    rgi-&gt;flags |=3D RG=
I_HWADDR_DEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    rgi-&gt;flags =3D RGI_ADDR_DEFINED;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rgi-&gt;gateway.addr =3D ntohl(best_r=
oute.NextHop.Ipv4.sin_addr.S_un.S_addr);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* get netmask and adapter index */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const IP_ADAPTER_INFO *adapters =3D get_adapter_i=
nfo_list(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   DWORD a_index =3D adapter_index_of_ip(adapters, rgi-&gt;gateway.addr, NU=
LL, &amp;rgi-&gt;gateway.netmask);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (a_index =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    rgi-&gt;adapter_index =3D a_index;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    rgi-&gt;flags |=3D (RGI_IFACE_DEFINE=
D | RGI_NETMASK_DEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* get MA=
C address */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st IP_ADAPTER_INFO *ai =3D get_adapter(adapters, rgi-&gt;adapter_index);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ai)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        memcpy(rgi-&gt;hwaddr, ai-&gt;Addres=
s, 6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rgi-&=
gt;flags |=3D RGI_HWADDR_DEFINED;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><sp=
an>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><s=
pan>@@ -2823,43 +2883,22 @@</span><br><span>                          const=
 struct in6_addr *dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    MIB_IPFORWARD_ROW2 BestRoute;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SOCKADDR_INET DestinationAddress, B=
estSourceAddress;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
DWORD BestIfIndex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 DWORD status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NET=
_LUID InterfaceLuid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>     CLEAR(*rgi6);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    CLEAR(InterfaceLuid);               /* cleared =3D not use=
d for lookup */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CL=
EAR(DestinationAddress);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    SOCKADDR_INET DestinationAddress;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(DestinationAddress);</sp=
an><br><span>     DestinationAddress.si_family =3D AF_INET6;</span><br><spa=
n>     if (dest)</span><br><span>     {</span><br><span>         Destinatio=
nAddress.Ipv6.sin6_addr =3D *dest;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D GetBes=
tInterfaceEx( (struct sockaddr *)&amp;DestinationAddress, &amp;BestIfIndex =
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MIB_IPFORWARD=
_ROW2 BestRoute;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 CLEAR(BestRoute);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   DWORD status =3D get_best_route(&amp;gc, &amp;DestinationAddress, &amp;B=
estRoute);</span><br><span> </span><br><span>     if (status !=3D NO_ERROR)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(D_ROUTE, &quot;NOTE: GetBestInterfaceEx returned error: %s (c=
ode=3D%u)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       strerror_win32(status, &amp;gc),</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            (unsigned int)status);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        goto done;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
 D_ROUTE, &quot;GetBestInterfaceEx() returned if=3D%d&quot;, (int) BestIfIn=
dex );</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    status =3D GetBestRoute2( &amp;I=
nterfaceLuid, BestIfIndex, NULL,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                            &amp;DestinationAddress, 0,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                            &a=
mp;BestRoute, &amp;BestSourceAddress );</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (status !=3D NO_ERROR)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(D_ROUTE, &quot;NOTE: GetIpForwardEntry2 returned error: %s (code=3D%u)&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            strerr=
or_win32(status, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            (unsigned int)status);</span><br><span>         goto done;=
</span><br><span>     }</span><br><span> </span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/879?usp=
=3Demail">change 879</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb=
2c65599cd86fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 879 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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


--4ZAZSK6jaHU=--

