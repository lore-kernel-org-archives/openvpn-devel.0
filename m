From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 12:38:04 +0000
In-Reply-To: <gerrit.1736759998000.I36a5442c0a5667628f419bc64efe5fb562ad3b57@...2715...>
References: <gerrit.1736759998000.I36a5442c0a5667628f419bc64efe5fb562ad3b57@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <840bd7732576dd0875fd7ff819fb320e796a0c28-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1Du3MwN/4AM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: support for
 iroutes
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

--1Du3MwN/4AM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/857?usp=3Demail

to look at the new patch set (#2).


Change subject: dco-win: support for iroutes
......................................................................

dco-win: support for iroutes

Unlike Linux/FreeBSD, dco-win doesn't have access to a
system routing table, so we have to maintain internal routing
table in the driver. For that, we have 4 ioctls to add/delete
IPv4/IPv6 iroutes. When adding iroute, we pass peer-id, so that
the driver is able to associate a subnet with a peer context.

Change-Id: I36a5442c0a5667628f419bc64efe5fb562ad3b57
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco.c
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/multi.c
M src/openvpn/ovpn_dco_win.h
5 files changed, 132 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/857/2

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b5a2136..55fe40a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -637,7 +637,7 @@
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
                    struct mroute_addr *addr)
 {
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top.options))
     {
         return;
@@ -653,28 +653,34 @@
     }

     struct context *c =3D &mi->context;
-    const char *dev =3D c->c1.tuntap->actual_name;
-
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
+#if defined(_WIN32)
+        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->n=
etbits, c->c2.tls_multi->peer_id);
+#else
         net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
-                         &mi->context.c2.push_ifconfig_ipv6_local, dev, 0,
+                         &mi->context.c2.push_ifconfig_ipv6_local, c->c1.t=
untap->actual_name, 0,
                          DCO_IROUTE_METRIC);
+#endif
     }
     else if (addrtype =3D=3D MR_ADDR_IPV4)
     {
+#if defined(_WIN32)
+        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->n=
etbits, c->c2.tls_multi->peer_id);
+#else
         in_addr_t dest =3D htonl(addr->v4.addr);
         net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits,
-                         &mi->context.c2.push_ifconfig_local, dev, 0,
+                         &mi->context.c2.push_ifconfig_local, c->c1.tuntap=
->actual_name, 0,
                          DCO_IROUTE_METRIC);
+#endif
     }
-#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) */
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_=
WIN32) */
 }

 void
 dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
 {
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top.options))
     {
         return;
@@ -682,7 +688,6 @@
     ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) =3D=3D DEV_TYPE_TUN);

     struct context *c =3D &mi->context;
-    const char *dev =3D c->c1.tuntap->actual_name;

     if (mi->context.c2.push_ifconfig_defined)
     {
@@ -690,9 +695,13 @@
              ir;
              ir =3D ir->next)
         {
+#if defined(_WIN32)
+            dco_win_del_iroute_ipv4(&c->c1.tuntap->dco, htonl(ir->network)=
, ir->netbits);
+#else
             net_route_v4_del(&m->top.net_ctx, &ir->network, ir->netbits,
-                             &mi->context.c2.push_ifconfig_local, dev,
+                             &mi->context.c2.push_ifconfig_local, c->c1.tu=
ntap->actual_name,
                              0, DCO_IROUTE_METRIC);
+#endif
         }
     }

@@ -702,12 +711,16 @@
              ir6;
              ir6 =3D ir6->next)
         {
+#if defined(_WIN32)
+            dco_win_del_iroute_ipv6(&c->c1.tuntap->dco, ir6->network, ir6-=
>netbits);
+#else
             net_route_v6_del(&m->top.net_ctx, &ir6->network, ir6->netbits,
-                             &mi->context.c2.push_ifconfig_ipv6_local, dev,
+                             &mi->context.c2.push_ifconfig_ipv6_local, c->=
c1.tuntap->actual_name,
                              0, DCO_IROUTE_METRIC);
+#endif
         }
     }
-#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) */
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_=
WIN32) */
 }

 #endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 14220b6..db2adac 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -873,4 +873,80 @@
     return dco_get_version(&ver) && ver.Major >=3D 2;
 }

+void
+dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int ne=
tbits, unsigned int peer_id)
+{
+    struct gc_arena gc =3D gc_new();
+
+    OVPN_MP_IROUTE route =3D {.Addr.Addr4.S_un.S_addr =3D dst, .Netbits =
=3D netbits, .PeerId =3D peer_id, .IPv6 =3D 0};
+
+    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, print_in_addr_t(dst=
, IA_NET_ORDER, &gc), netbits, peer_id);
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route,
+                         sizeof(route), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) f=
ailed");
+    }
+
+    gc_free(&gc);
+}
+
+void
+dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned =
int netbits, unsigned int peer_id)
+{
+    struct gc_arena gc =3D gc_new();
+
+    OVPN_MP_IROUTE route =3D { .Addr.Addr6 =3D dst, .Netbits =3D netbits, =
.PeerId =3D peer_id, .IPv6 =3D 1 };
+
+    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, print_in6_addr(dst,=
 IA_NET_ORDER, &gc), netbits, peer_id);
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route,
+                         sizeof(route), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) f=
ailed");
+    }
+
+    gc_free(&gc);
+}
+
+void
+dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int ne=
tbits)
+{
+    struct gc_arena gc =3D gc_new();
+
+    OVPN_MP_IROUTE route =3D { .Addr.Addr4.S_un.S_addr =3D dst, .Netbits =
=3D netbits, .PeerId =3D -1, .IPv6 =3D 0 };
+
+    msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in_addr_t(dst, IA_NET_OR=
DER, &gc), netbits);
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route,
+                         sizeof(route), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_DEL_IROUTE) f=
ailed");
+    }
+
+    gc_free(&gc);
+}
+
+void
+dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned =
int netbits)
+{
+    struct gc_arena gc =3D gc_new();
+
+    OVPN_MP_IROUTE route =3D { .Addr.Addr6 =3D dst, .Netbits =3D netbits, =
.PeerId =3D -1, .IPv6 =3D 1 };
+
+    msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in6_addr(dst, IA_NET_ORD=
ER, &gc), netbits);
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route,
+                         sizeof(route), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_DEL_IROUTE) f=
ailed");
+    }
+
+    gc_free(&gc);
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 2c2309f..21cb1de 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -24,6 +24,8 @@

 #if defined(ENABLE_DCO) && defined(_WIN32)

+#include <in6addr.h>
+
 #include "buffer.h"
 #include "ovpn_dco_win.h"
 #include "sig.h"
@@ -72,6 +74,18 @@
 bool
 dco_win_supports_multipeer(void);

+void
+dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int ne=
tbits, unsigned int peer_id);
+
+void
+dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned =
int netbits, unsigned int peer_id);
+
+void
+dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int ne=
tbits);
+
+void
+dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned =
int netbits);
+
 #else /* if defined(ENABLE_DCO) && defined(_WIN32) */

 static inline void
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 196174c..82fcf17 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2448,6 +2448,9 @@
     /* set context-level authentication flag */
     mi->context.c2.tls_multi->multi_state =3D CAS_CONNECT_DONE;

+    /* Since dco-win maintains iroute routing table (subnet -> peer),
+     * peer must be added before iroutes. For other platforms it doesn't m=
atter. */
+
     /* authentication complete, calculate dynamic client specific options =
*/
     if (!multi_client_set_protocol_options(&mi->context))
     {
@@ -2465,6 +2468,8 @@
         mi->context.c2.tls_multi->multi_state =3D CAS_FAILED;
     }

+    /* dco peer has been added, it is now safe for Windows to add iroutes =
*/
+
     /*
      * For routed tunnels, set up internal route to endpoint
      * plus add all iroute routes.
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index 8003ace..f798c5a 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -182,6 +182,16 @@
     int PeerId;
 } OVPN_MP_SWAP_KEYS, * POVPN_MP_SWAP_KEYS;

+typedef struct _OVPN_MP_IROUTE {
+    union {
+        IN_ADDR Addr4;
+        IN6_ADDR Addr6;
+    } Addr;
+    int Netbits;
+    int PeerId;
+    int IPv6;
+} OVPN_MP_IROUTE, * POVPN_MP_IROUTE;
+
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
@@ -201,3 +211,6 @@

 #define OVPN_IOCTL_MP_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD=
_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE(FILE_DEVICE_UNKNOWN, 16, METHOD=
_BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_MP_ADD_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 17, METHOD_=
BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_MP_DEL_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 18, METHOD_=
BUFFERED, FILE_ANY_ACCESS)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/857?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I36a5442c0a5667628f419bc64efe5fb562ad3b57
Gerrit-Change-Number: 857
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--1Du3MwN/4AM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/857?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dco-win: support for iroutes<br><br>Unlike Linux/FreeBSD, dco-win doesn&#=
39;t have access to a<br>system routing table, so we have to maintain inter=
nal routing<br>table in the driver. For that, we have 4 ioctls to add/delet=
e<br>IPv4/IPv6 iroutes. When adding iroute, we pass peer-id, so that<br>the=
 driver is able to associate a subnet with a peer context.<br><br>Change-Id=
: I36a5442c0a5667628f419bc64efe5fb562ad3b57<br>Signed-off-by: Lev Stipakov =
&lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/dco_wi=
n.c<br>M src/openvpn/dco_win.h<br>M src/openvpn/multi.c<br>M src/openvpn/ov=
pn_dco_win.h<br>5 files changed, 132 insertions(+), 11 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/857/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>in=
dex b5a2136..55fe40a 100644</span><br><span>--- a/src/openvpn/dco.c</span><=
br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -637,7 +637,7 @@</span>=
<br><span> dco_install_iroute(struct multi_context *m, struct multi_instanc=
e *mi,</span><br><span>                    struct mroute_addr *addr)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
) || defined(_WIN32)</span><br><span>     if (!dco_enabled(&amp;m-&gt;top.o=
ptions))</span><br><span>     {</span><br><span>         return;</span><br>=
<span>@@ -653,28 +653,34 @@</span><br><span>     }</span><br><span> </span>=
<br><span>     struct context *c =3D &amp;mi-&gt;context;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *dev =3D c-&gt;c1.tuntap=
-&gt;actual_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     if (addrtype =3D=3D MR_ADDR_IPV6)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_=
iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;netbit=
s, c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#else</span><br><span>         net_route_v6_add(&amp;m-&gt;=
top.net_ctx, &amp;addr-&gt;v6.addr, addr-&gt;netbits,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         &amp;mi-&gt;contex=
t.c2.push_ifconfig_ipv6_local, dev, 0,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                         &amp;mi-&gt;context.c2.push_ifc=
onfig_ipv6_local, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span>     =
                     DCO_IROUTE_METRIC);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span>     }</span><br><span>     els=
e if (addrtype =3D=3D MR_ADDR_IPV4)</span><br><span>     {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv4(&amp=
;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v4.addr, addr-&gt;netbits, c-&gt;c2.tls_=
multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#else</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4.addr);<=
/span><br><span>         net_route_v4_add(&amp;m-&gt;top.net_ctx, &amp;dest=
, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                       &amp;mi-&gt;context.c2.push_ifconfig_local, dev, 0,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
     &amp;mi-&gt;context.c2.push_ifconfig_local, c-&gt;c1.tuntap-&gt;actual=
_name, 0,</span><br><span>                          DCO_IROUTE_METRIC);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if de=
fined(TARGET_LINUX) || defined(TARGET_FREEBSD) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_LINUX) || defined=
(TARGET_FREEBSD) || defined(_WIN32) */</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span> dco_delete_iroutes(struct multi_con=
text *m, struct multi_instance *mi)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(TARGE=
T_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><s=
pan>     if (!dco_enabled(&amp;m-&gt;top.options))</span><br><span>     {</=
span><br><span>         return;</span><br><span>@@ -682,7 +688,6 @@</span><=
br><span>     ASSERT(TUNNEL_TYPE(mi-&gt;context.c1.tuntap) =3D=3D DEV_TYPE_=
TUN);</span><br><span> </span><br><span>     struct context *c =3D &amp;mi-=
&gt;context;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 char *dev =3D c-&gt;c1.tuntap-&gt;actual_name;</span><br><span> </span><br=
><span>     if (mi-&gt;context.c2.push_ifconfig_defined)</span><br><span>  =
   {</span><br><span>@@ -690,9 +695,13 @@</span><br><span>              ir;=
</span><br><span>              ir =3D ir-&gt;next)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN3=
2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_w=
in_del_iroute_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, htonl(ir-&gt;network), ir-=
&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else<=
/span><br><span>             net_route_v4_del(&amp;m-&gt;top.net_ctx, &amp;=
ir-&gt;network, ir-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                             &amp;mi-&gt;context.c2.push_ifconfig=
_local, dev,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                      &amp;mi-&gt;context.c2.push_ifconfig_local, c-&gt;c1.=
tuntap-&gt;actual_name,</span><br><span>                              0, DC=
O_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span>         }</span><br><span>     }</span><br><span> </s=
pan><br><span>@@ -702,12 +711,16 @@</span><br><span>              ir6;</spa=
n><br><span>              ir6 =3D ir6-&gt;next)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_win_=
del_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, ir6-&gt;network, ir6-&gt;netb=
its);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><b=
r><span>             net_route_v6_del(&amp;m-&gt;top.net_ctx, &amp;ir6-&gt;=
network, ir6-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                             &amp;mi-&gt;context.c2.push_ifconfig_ipv6_=
local, dev,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                     &amp;mi-&gt;context.c2.push_ifconfig_ipv6_local, c-&gt=
;c1.tuntap-&gt;actual_name,</span><br><span>                              0=
, DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span>         }</span><br><span>     }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_LINUX) || =
defined(TARGET_FREEBSD) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || def=
ined(_WIN32) */</span><br><span> }</span><br><span> </span><br><span> #endi=
f /* defined(ENABLE_DCO) */</span><br><span>diff --git a/src/openvpn/dco_wi=
n.c b/src/openvpn/dco_win.c</span><br><span>index 14220b6..db2adac 100644</=
span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvp=
n/dco_win.c</span><br><span>@@ -873,4 +873,80 @@</span><br><span>     retur=
n dco_get_version(&amp;ver) &amp;&amp; ver.Major &gt;=3D 2;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_win_add_i=
route_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits, unsigne=
d int peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_IROUTE route =
=3D {.Addr.Addr4.S_un.S_addr =3D dst, .Netbits =3D netbits, .PeerId =3D pee=
r_id, .IPv6 =3D 0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG=
, &quot;%s: %s/%d -&gt; peer %d&quot;, __func__, print_in_addr_t(dst, IA_NE=
T_ORDER, &amp;gc), netbits, peer_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   DWORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_=
IROUTE, &amp;route,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                         sizeof(route), NULL, 0, &amp;bytes_returned, NULL)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &q=
uot;DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_win_add_iroute_ipv6(dco_context_t *dc=
o, struct in6_addr dst, unsigned int netbits, unsigned int peer_id)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_MP_IROUTE route =3D { .Addr.Addr6 =3D =
dst, .Netbits =3D netbits, .PeerId =3D peer_id, .IPv6 =3D 1 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%d -&gt; peer %d&=
quot;, __func__, print_in6_addr(dst, IA_NET_ORDER, &amp;gc), netbits, peer_=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoContr=
ol(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                         sizeof(r=
oute), NULL, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP=
_ADD_IROUTE) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int net=
bits)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_IROUTE route =3D { .Ad=
dr.Addr4.S_un.S_addr =3D dst, .Netbits =3D netbits, .PeerId =3D -1, .IPv6 =
=3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s:=
 %s/%d&quot;, __func__, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc), netbit=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoContro=
l(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IROUTE, &amp;route,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                         sizeof(ro=
ute), NULL, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_=
DEL_IROUTE) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned i=
nt netbits)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_IROUTE route =3D=
 { .Addr.Addr6 =3D dst, .Netbits =3D netbits, .PeerId =3D -1, .IPv6 =3D 1 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%d&=
quot;, __func__, print_in6_addr(dst, IA_NET_ORDER, &amp;gc), netbits);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-=
&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IROUTE, &amp;route,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                         sizeof(route), =
NULL, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_DEL_IR=
OUTE) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(_WIN32) */</=
span><br><span>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</=
span><br><span>index 2c2309f..21cb1de 100644</span><br><span>--- a/src/open=
vpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><br><span>@=
@ -24,6 +24,8 @@</span><br><span> </span><br><span> #if defined(ENABLE_DCO)=
 &amp;&amp; defined(_WIN32)</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;in6addr.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;buffer.h=
&quot;</span><br><span> #include &quot;ovpn_dco_win.h&quot;</span><br><span=
> #include &quot;sig.h&quot;</span><br><span>@@ -72,6 +74,18 @@</span><br><=
span> bool</span><br><span> dco_win_supports_multipeer(void);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_win_add_iroute_ipv4(dco_co=
ntext_t *dco, in_addr_t dst, unsigned int netbits, unsigned int peer_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_=
addr dst, unsigned int netbits, unsigned int peer_id);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int ne=
tbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dco_win_del_iroute_ipv6(dco_context_t *dco, st=
ruct in6_addr dst, unsigned int netbits);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #else /* if defined(ENABLE_DCO) &am=
p;&amp; defined(_WIN32) */</span><br><span> </span><br><span> static inline=
 void</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.=
c</span><br><span>index 196174c..82fcf17 100644</span><br><span>--- a/src/o=
penvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@=
 -2448,6 +2448,9 @@</span><br><span>     /* set context-level authenticatio=
n flag */</span><br><span>     mi-&gt;context.c2.tls_multi-&gt;multi_state =
=3D CAS_CONNECT_DONE;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Since dco-win maintains iroute routing table (su=
bnet -&gt; peer),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * peer must be added before iroutes. For other platforms it doesn&#39;t =
matter. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     /* authentication complete, calculate dynamic client specific =
options */</span><br><span>     if (!multi_client_set_protocol_options(&amp=
;mi-&gt;context))</span><br><span>     {</span><br><span>@@ -2465,6 +2468,8=
 @@</span><br><span>         mi-&gt;context.c2.tls_multi-&gt;multi_state =
=3D CAS_FAILED;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* dco peer has been added, it is =
now safe for Windows to add iroutes */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     /*</span><br><span>      * For rou=
ted tunnels, set up internal route to endpoint</span><br><span>      * plus=
 add all iroute routes.</span><br><span>diff --git a/src/openvpn/ovpn_dco_w=
in.h b/src/openvpn/ovpn_dco_win.h</span><br><span>index 8003ace..f798c5a 10=
0644</span><br><span>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>+++ b=
/src/openvpn/ovpn_dco_win.h</span><br><span>@@ -182,6 +182,16 @@</span><br>=
<span>     int PeerId;</span><br><span> } OVPN_MP_SWAP_KEYS, * POVPN_MP_SWA=
P_KEYS;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+typedef struct _OVPN_MP_IROUTE {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    union {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        IN_ADDR Addr4;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        IN6_ADDR Addr6;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    } Addr;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int Netbits;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int PeerId;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int IPv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} O=
VPN_MP_IROUTE, * POVPN_MP_IROUTE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FI=
LE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #d=
efine OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFE=
RED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_NEW_KEY      CTL_=
CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><s=
pan>@@ -201,3 +211,6 @@</span><br><span> </span><br><span> #define OVPN_IOC=
TL_MP_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD_BUFFERED, FILE_A=
NY_ACCESS)</span><br><span> #define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE(FILE=
_DEVICE_UNKNOWN, 16, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define OVPN_IOCTL_MP_ADD_IROUTE CTL_CODE(FILE_DEVICE_UNKNO=
WN, 17, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define OVPN_IOCTL_MP_DEL_IROUTE CTL_CODE(FILE_DEVICE=
_UNKNOWN, 18, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/85=
7?usp=3Demail">change 857</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/857?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I36a5442c0a5667628f419bc64ef=
e5fb562ad3b57 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 857 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--1Du3MwN/4AM=--

