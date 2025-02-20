From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 20 Feb 2025 13:24:24 +0000
In-Reply-To: <gerrit.1736759998000.I36a5442c0a5667628f419bc64efe5fb562ad3b57@...2715...>
References: <gerrit.1736759998000.I36a5442c0a5667628f419bc64efe5fb562ad3b57@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <838b53c307b64484a91587f811614456e0555ca4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nWXScud4Qs8="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nWXScud4Qs8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#16) to the change originally created b=
y stipa. ( http://gerrit.openvpn.net/c/openvpn/+/857?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250220124205.27502-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
958.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/ovpn_dco_win.h
4 files changed, 127 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/857/16

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index c65aece..02fae81 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -649,7 +649,7 @@
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
                    struct mroute_addr *addr)
 {
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top.options))
     {
         return;
@@ -665,28 +665,34 @@
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
@@ -694,7 +700,6 @@
     ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) =3D=3D DEV_TYPE_TUN);

     struct context *c =3D &mi->context;
-    const char *dev =3D c->c1.tuntap->actual_name;

     if (mi->context.c2.push_ifconfig_defined)
     {
@@ -702,9 +707,13 @@
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

@@ -714,12 +723,16 @@
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
index f46c93d..45cb919 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -823,4 +823,80 @@
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
index 309badf..95c95c8 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -24,6 +24,8 @@

 #if defined(ENABLE_DCO) && defined(_WIN32)

+#include <in6addr.h>
+
 #include "buffer.h"
 #include "ovpn_dco_win.h"
 #include "sig.h"
@@ -69,6 +71,18 @@
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
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index bfe939d..f6d745c 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -174,6 +174,16 @@
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
@@ -193,3 +203,6 @@

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
Gerrit-PatchSet: 16
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--nWXScud4Qs8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #16</strong> to the change originally c=
reated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/857=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: support for iroutes<br><br>Unlike Linux/Fre=
eBSD, dco-win doesn&#39;t have access to a<br>system routing table, so we h=
ave to maintain internal routing<br>table in the driver. For that, we have =
4 ioctls to add/delete<br>IPv4/IPv6 iroutes. When adding iroute, we pass pe=
er-id, so that<br>the driver is able to associate a subnet with a peer cont=
ext.<br><br>Change-Id: I36a5442c0a5667628f419bc64efe5fb562ad3b57<br>Signed-=
off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Message-Id: &lt;20250220124205.27502-1-gert@...1296...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg30958.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M src/openvpn/dco.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/dco_=
win.h<br>M src/openvpn/ovpn_dco_win.h<br>4 files changed, 127 insertions(+)=
, 11 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/57/857/16</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/openvp=
n/dco.c</span><br><span>index c65aece..02fae81 100644</span><br><span>--- a=
/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>=
@@ -649,7 +649,7 @@</span><br><span> dco_install_iroute(struct multi_contex=
t *m, struct multi_instance *mi,</span><br><span>                    struct=
 mroute_addr *addr)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)=
 || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span>     if (!dc=
o_enabled(&amp;m-&gt;top.options))</span><br><span>     {</span><br><span> =
        return;</span><br><span>@@ -665,28 +665,34 @@</span><br><span>     =
}</span><br><span> </span><br><span>     struct context *c =3D &amp;mi-&gt;=
context;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *dev =3D c-&gt;c1.tuntap-&gt;actual_name;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>     if (addrtype =3D=3D MR_ADDR_IPV=
6)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        dco_win_add_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&g=
t;v6.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt;peer_id);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>         ne=
t_route_v6_add(&amp;m-&gt;top.net_ctx, &amp;addr-&gt;v6.addr, addr-&gt;netb=
its,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
        &amp;mi-&gt;context.c2.push_ifconfig_ipv6_local, dev, 0,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                         &amp;=
mi-&gt;context.c2.push_ifconfig_ipv6_local, c-&gt;c1.tuntap-&gt;actual_name=
, 0,</span><br><span>                          DCO_IROUTE_METRIC);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     =
}</span><br><span>     else if (addrtype =3D=3D MR_ADDR_IPV4)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dc=
o_win_add_iroute_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v4.addr, addr-=
&gt;netbits, c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#else</span><br><span>         in_addr_t dest =3D=
 htonl(addr-&gt;v4.addr);</span><br><span>         net_route_v4_add(&amp;m-=
&gt;top.net_ctx, &amp;dest, addr-&gt;netbits,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                         &amp;mi-&gt;context.c2.pus=
h_ifconfig_local, dev, 0,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                         &amp;mi-&gt;context.c2.push_ifconfig_local, =
c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span>                       =
   DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if define=
d(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */</span><br>=
<span> }</span><br><span> </span><br><span> void</span><br><span> dco_delet=
e_iroutes(struct multi_context *m, struct multi_instance *mi)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARG=
ET_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || de=
fined(_WIN32)</span><br><span>     if (!dco_enabled(&amp;m-&gt;top.options)=
)</span><br><span>     {</span><br><span>         return;</span><br><span>@=
@ -694,7 +700,6 @@</span><br><span>     ASSERT(TUNNEL_TYPE(mi-&gt;context.c=
1.tuntap) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span>     stru=
ct context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const char *dev =3D c-&gt;c1.tuntap-&gt;actual_name;</=
span><br><span> </span><br><span>     if (mi-&gt;context.c2.push_ifconfig_d=
efined)</span><br><span>     {</span><br><span>@@ -702,9 +707,13 @@</span><=
br><span>              ir;</span><br><span>              ir =3D ir-&gt;next=
)</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            dco_win_del_iroute_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, =
htonl(ir-&gt;network), ir-&gt;netbits);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#else</span><br><span>             net_route_v4_del(&am=
p;m-&gt;top.net_ctx, &amp;ir-&gt;network, ir-&gt;netbits,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                             &amp;mi-&g=
t;context.c2.push_ifconfig_local, dev,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                             &amp;mi-&gt;context.c2.push=
_ifconfig_local, c-&gt;c1.tuntap-&gt;actual_name,</span><br><span>         =
                     0, DCO_IROUTE_METRIC);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span>         }</span><br><span> =
    }</span><br><span> </span><br><span>@@ -714,12 +723,16 @@</span><br><sp=
an>              ir6;</span><br><span>              ir6 =3D ir6-&gt;next)</=
span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            dco_win_del_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, ir6=
-&gt;network, ir6-&gt;netbits);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#else</span><br><span>             net_route_v6_del(&amp;m-&gt;=
top.net_ctx, &amp;ir6-&gt;network, ir6-&gt;netbits,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                             &amp;mi-&gt;co=
ntext.c2.push_ifconfig_ipv6_local, dev,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                             &amp;mi-&gt;context.c2.pus=
h_ifconfig_ipv6_local, c-&gt;c1.tuntap-&gt;actual_name,</span><br><span>   =
                           0, DCO_IROUTE_METRIC);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span>         }</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_LINUX) || de=
fined(TARGET_FREEBSD) || defined(_WIN32) */</span><br><span> }</span><br><s=
pan> </span><br><span> #endif /* defined(ENABLE_DCO) */</span><br><span>dif=
f --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>ind=
ex f46c93d..45cb919 100644</span><br><span>--- a/src/openvpn/dco_win.c</spa=
n><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -823,4 +823,80 @=
@</span><br><span>     return dco_get_version(&amp;ver) &amp;&amp; ver.Majo=
r &gt;=3D 2;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, u=
nsigned int netbits, unsigned int peer_id)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_MP_IROUTE route =3D {.Addr.Addr4.S_un.S_addr =3D dst, .Netbits =
=3D netbits, .PeerId =3D peer_id, .IPv6 =3D 0};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%d -&gt; peer %d&quot;, __func__=
, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc), netbits, peer_id);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-=
&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                         sizeof(route), NULL, 0=
, &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) f=
ailed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_win_add_ir=
oute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits, un=
signed int peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_IROUTE r=
oute =3D { .Addr.Addr6 =3D dst, .Netbits =3D netbits, .PeerId =3D peer_id, =
.IPv6 =3D 1 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &qu=
ot;%s: %s/%d -&gt; peer %d&quot;, __func__, print_in6_addr(dst, IA_NET_ORDE=
R, &amp;gc), netbits, peer_id);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWO=
RD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE=
, &amp;route,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                   sizeof(route), NULL, 0, &amp;bytes_returned, NULL))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;De=
viceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_win_del_iroute_ipv4(dco_context_t *dco, in_a=
ddr_t dst, unsigned int netbits)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_MP_IROUTE route =3D { .Addr.Addr4.S_un.S_addr =3D dst, .Netbits =3D netbi=
ts, .PeerId =3D -1, .IPv6 =3D 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(D_DCO_DEBUG, &quot;%s: %s/%d&quot;, __func__, print_in_addr_t(dst, IA_N=
ET_ORDER, &amp;gc), netbits);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD=
 bytes_returned =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IROUTE, =
&amp;route,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                 sizeof(route), NULL, 0, &amp;bytes_returned, NULL))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;Devi=
ceIoControl(OVPN_IOCTL_MP_DEL_IROUTE) failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_win_del_iroute_ipv6(dco_context_t *dco, struc=
t in6_addr dst, unsigned int netbits)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OVPN_MP_IROUTE route =3D { .Addr.Addr6 =3D dst, .Netbits =3D netbits, .Pe=
erId =3D -1, .IPv6 =3D 1 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_D=
CO_DEBUG, &quot;%s: %s/%d&quot;, __func__, print_in6_addr(dst, IA_NET_ORDER=
, &amp;gc), netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_r=
eturned =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IROUTE, &amp;rou=
te,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
         sizeof(route), NULL, 0, &amp;bytes_returned, NULL))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoCont=
rol(OVPN_IOCTL_MP_DEL_IROUTE) failed&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif=
 /* defined(_WIN32) */</span><br><span>diff --git a/src/openvpn/dco_win.h b=
/src/openvpn/dco_win.h</span><br><span>index 309badf..95c95c8 100644</span>=
<br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco=
_win.h</span><br><span>@@ -24,6 +24,8 @@</span><br><span> </span><br><span>=
 #if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32)</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;in6addr.h&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
#include &quot;buffer.h&quot;</span><br><span> #include &quot;ovpn_dco_win.=
h&quot;</span><br><span> #include &quot;sig.h&quot;</span><br><span>@@ -69,=
6 +71,18 @@</span><br><span> bool</span><br><span> dco_win_supports_multipe=
er(void);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_win=
_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits, u=
nsigned int peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dco_win_add_iroute_ipv6(dco_cont=
ext_t *dco, struct in6_addr dst, unsigned int netbits, unsigned int peer_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr=
_t dst, unsigned int netbits);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_win_del_iroute_ipv6=
(dco_context_t *dco, struct in6_addr dst, unsigned int netbits);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #else /* if =
defined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */</span><br><span> </span><=
br><span> static inline void</span><br><span>diff --git a/src/openvpn/ovpn_=
dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br><span>index bfe939d..f6d74=
5c 100644</span><br><span>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>=
+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>@@ -174,6 +174,16 @@</span=
><br><span>     int PeerId;</span><br><span> } OVPN_MP_SWAP_KEYS, * POVPN_M=
P_SWAP_KEYS;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+typedef struct _OVPN_MP_IROUTE {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    union {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        IN_ADDR Addr4;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        IN6_ADDR Addr6;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    } Addr;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int Netbits;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int PeerId;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int IPv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+} OVPN_MP_IROUTE, * POVPN_MP_IROUTE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> #define OVPN_IOCTL_NEW_PEER     CTL_CO=
DE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><spa=
n> #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_=
BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_NEW_KEY     =
 CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><=
br><span>@@ -193,3 +203,6 @@</span><br><span> </span><br><span> #define OVP=
N_IOCTL_MP_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD_BUFFERED, F=
ILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE=
(FILE_DEVICE_UNKNOWN, 16, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define OVPN_IOCTL_MP_ADD_IROUTE CTL_CODE(FILE_DEVICE_=
UNKNOWN, 17, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_MP_DEL_IROUTE CTL_CODE(FILE_D=
EVICE_UNKNOWN, 18, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/857?usp=3Demail">change 857</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/857?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I36a5442c0a5667628f419bc64ef=
e5fb562ad3b57 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 857 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--nWXScud4Qs8=--

