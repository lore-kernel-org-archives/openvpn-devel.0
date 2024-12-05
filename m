From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 5 Dec 2024 18:38:06 +0000
In-Reply-To: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
References: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., alex@...2837...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1d056af53150e3274782b02de7a38bbcf193b287-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gOBSEQrymxU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Haiku: Add calls to
 manage routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kallisti5 <alex@...2837...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gOBSEQrymxU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: kallisti5.

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/68=
8?usp=3Demail )

Change subject: Haiku: Add calls to manage routing table
......................................................................

Haiku: Add calls to manage routing table

Note: the full functionality of these changes depends on
      https://review.haiku-os.org/c/haiku/+/8592

Signed-off-by: Alexander von Gluck <alex@...2837...>
Acked-by: Gert Doering <gert@...1296...>
Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd
Message-Id: <20241205172459.4783-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
023.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
M src/openvpn/syshead.h
2 files changed, 140 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2e584c7..df06fdf 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1853,7 +1853,21 @@
         status =3D ret ? RTA_SUCCESS : RTA_ERROR;
     }

-#else  /* if defined(TARGET_LINUX) */
+#elif defined(TARGET_HAIKU)
+
+    /* ex: route add /dev/net/ipro1000/0 0.0.0.0 gw 192.168.1.1 netmask 12=
8.0.0.0 */
+    argv_printf(&argv, "%s add %s inet %s gw %s netmask %s",
+                ROUTE_PATH,
+                rgi->iface,
+                network,
+                gateway,
+                netmask);
+    argv_msg(D_ROUTE, &argv);
+    bool ret =3D openvpn_execve_check(&argv, es, 0,
+                                    "ERROR: Haiku inet route add command f=
ailed");
+    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+
+#else /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route' commands on th=
is operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
=20
@@ -2126,6 +2140,20 @@
                                     "ERROR: AIX route add command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

+#elif defined(TARGET_HAIKU)
+
+    /* ex: route add /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen =
64 */
+    argv_printf(&argv, "%s add %s inet6 %s gw %s prefixlen %d",
+                ROUTE_PATH,
+                r6->iface,
+                network,
+                gateway,
+                r6->netbits);
+    argv_msg(D_ROUTE, &argv);
+    bool ret =3D openvpn_execve_check(&argv, es, 0,
+                                    "ERROR: Haiku inet6 route add command =
failed");
+    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands =
on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
@@ -2329,6 +2357,18 @@
         openvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete comman=
d failed");
     }

+#elif defined(TARGET_HAIKU)
+
+    /* ex: route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 n=
etmask 255.255.0.0 */
+    argv_printf(&argv, "%s del %s inet %s gw %s netmask %s",
+                ROUTE_PATH,
+                rgi->iface,
+                network,
+                gateway,
+                netmask);
+    argv_msg(D_ROUTE, &argv);
+    openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route delete com=
mand failed");
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route' commands on th=
is operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
@@ -2504,10 +2544,23 @@
                 network, r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command faile=
d");
+
 #elif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
         "needed. The VpnService API allows routes to be set "
         "on connect only and will clean up automatically.");
+#elif defined(TARGET_HAIKU)
+
+    /* ex: route del /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen =
64 */
+    argv_printf(&argv, "%s del %s inet6 %s gw %s prefixlen %d",
+                ROUTE_PATH,
+                r6->iface,
+                network,
+                gateway,
+                r6->netbits);
+    argv_msg(D_ROUTE, &argv);
+    openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet6 route delete co=
mmand failed");
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands =
on this operating system.  Try putting your routes in a --route-down script=
");
 #endif /* if defined(TARGET_LINUX) */
@@ -3886,6 +3939,86 @@

 #undef max

+#elif defined(TARGET_HAIKU)
+
+void
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+{
+    CLEAR(*rgi);
+
+    int sockfd =3D socket(AF_INET, SOCK_DGRAM, 0);
+    if (sockfd < 0)
+    {
+        msg(M_ERRNO, "%s: Error opening socket for AF_INET", __func__);
+        return;
+    }
+
+    struct ifconf config;
+    config.ifc_len =3D sizeof(config.ifc_value);
+    if (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct ifconf)) < 0)
+    {
+        msg(M_ERRNO, "%s: Error getting routing table size", __func__);
+        return;
+    }
+
+    uint32 size =3D (uint32)config.ifc_value;
+    if (size =3D=3D 0)
+    {
+        return;
+    }
+
+    void *buffer =3D malloc(size);
+    check_malloc_return(buffer);
+
+    config.ifc_len =3D size;
+    config.ifc_buf =3D buffer;
+    if (ioctl(sockfd, SIOCGRTTABLE, &config, sizeof(struct ifconf)) < 0)
+    {
+        free(buffer);
+        return;
+    }
+
+    struct ifreq *interface =3D (struct ifreq *)buffer;
+    struct ifreq *end =3D (struct ifreq *)((uint8 *)buffer + size);
+
+    while (interface < end)
+    {
+        struct route_entry route =3D interface->ifr_route;
+        if ((route.flags & RTF_GATEWAY) !=3D 0 && (route.flags & RTF_DEFAU=
LT) !=3D 0)
+        {
+            rgi->gateway.addr =3D ntohl(((struct sockaddr_in *)route.gatew=
ay)->sin_addr.s_addr);
+            rgi->flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+            strncpy(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
+        }
+
+        int32 address_size =3D 0;
+        if (route.destination !=3D NULL)
+        {
+            address_size +=3D route.destination->sa_len;
+        }
+        if (route.mask !=3D NULL)
+        {
+            address_size +=3D route.mask->sa_len;
+        }
+        if (route.gateway !=3D NULL)
+        {
+            address_size +=3D route.gateway->sa_len;
+        }
+
+        interface =3D (struct ifreq *)((addr_t)interface + IF_NAMESIZE
+                                     + sizeof(struct route_entry) + addres=
s_size);
+    }
+    free(buffer);
+}
+
+void
+get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
+                         const struct in6_addr *dest, openvpn_net_ctx_t *c=
tx)
+{
+    /* TODO: Same for ipv6 with AF_INET6 */
+    CLEAR(*rgi6);
+}
+
 #else  /* if defined(_WIN32) */

 /*
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 33a90c1..844e47a 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -166,6 +166,12 @@
 #include <string.h>
 #endif

+#if defined(TARGET_HAIKU)
+#include <SupportDefs.h>   /* uint32, etc */
+#include <net/if.h>        /* ifconf etc */
+#include <sys/sockio.h>    /* SIOCGRTTABLE, etc */
+#endif /* TARGET_HAIKU */
+
 #ifdef HAVE_ARPA_INET_H
 #include <arpa/inet.h>
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd
Gerrit-Change-Number: 688
Gerrit-PatchSet: 12
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: kallisti5 <alex@...2837...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: kallisti5 <alex@...2837...>
Gerrit-MessageType: merged

--gOBSEQrymxU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: kallisti5. </p>
<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/688?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Haiku: Add calls to manage routing table<br><b=
r>Note: the full functionality of these changes depends on<br>      https:/=
/review.haiku-os.org/c/haiku/+/8592<br><br>Signed-off-by: Alexander von Glu=
ck &lt;alex@...2837...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt=
;<br>Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd<br>Message-Id: &l=
t;20241205172459.4783-1-gert@...1296...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg30023.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>M sr=
c/openvpn/syshead.h<br>2 files changed, 140 insertions(+), 1 deletion(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex 2e584c7..df06fdf 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -1853,7 +1853,21 @=
@</span><br><span>         status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#else  /* if defined(TARGET_LINUX) */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_HAIKU)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* ex: route add /dev/net/ipro1000/0 0.0.0.0 gw 192=
.168.1.1 netmask 128.0.0.0 */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    argv_printf(&amp;argv, &quot;%s add %s inet %s gw %s netmask =
%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      ROUTE_PATH,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              rgi-&gt;iface,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                network,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                gateway,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                netmask);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    argv_msg(D_ROUTE, &amp;argv);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D openvpn_execve_chec=
k(&amp;argv, es, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                    &quot;ERROR: Haiku inet route add comma=
nd failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else /* if defined(TARGET_LINUX) */</span><br><span>     msg(M_FATAL,=
 &quot;Sorry, but I don&#39;t know how to do &#39;route&#39; commands on th=
is operating system.  Try putting your routes in a --route-up script&quot;)=
;</span><br><span> #endif /* if defined(TARGET_LINUX) */</span><br><span> <=
/span><br><span>@@ -2126,6 +2140,20 @@</span><br><span>                    =
                 &quot;ERROR: AIX route add command failed&quot;);</span><b=
r><span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_H=
AIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* ex: route add /dev/net/ipr=
o1000/0 inet6 :: gw beef::cafe prefixlen 64 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s add %s inet6=
 %s gw %s prefixlen %d&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                ROUTE_PATH,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                r6-&gt;iface,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                network,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                gateway,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                r6-&gt;netbits);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(D_ROUTE, &=
amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
ret =3D openvpn_execve_check(&amp;argv, es, 0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                    &quot;ERROR:=
 Haiku inet6 route add command failed&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #else=
  /* if defined(TARGET_LINUX) */</span><br><span>     msg(M_FATAL, &quot;So=
rry, but I don&#39;t know how to do &#39;route ipv6&#39; commands on this o=
perating system.  Try putting your routes in a --route-up script&quot;);</s=
pan><br><span> #endif /* if defined(TARGET_LINUX) */</span><br><span>@@ -23=
29,6 +2357,18 @@</span><br><span>         openvpn_execve_check(&amp;argv, e=
s, 0, &quot;ERROR: AIX route delete command failed&quot;);</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#elif defined(TARGET_HAIKU)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 ex: route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask =
255.255.0.0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
rgv_printf(&amp;argv, &quot;%s del %s inet %s gw %s netmask %s&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                ROUTE_PAT=
H,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r=
gi-&gt;iface,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                netmask);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;argv, es, 0, &quot;ER=
ROR: Haiku inet route delete command failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #else  /* if defined(TA=
RGET_LINUX) */</span><br><span>     msg(M_FATAL, &quot;Sorry, but I don&#39=
;t know how to do &#39;route&#39; commands on this operating system.  Try p=
utting your routes in a --route-up script&quot;);</span><br><span> #endif /=
* if defined(TARGET_LINUX) */</span><br><span>@@ -2504,10 +2544,23 @@</span=
><br><span>                 network, r6-&gt;netbits, gateway);</span><br><s=
pan>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_=
check(&amp;argv, es, 0, &quot;ERROR: AIX route add command failed&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #el=
if defined(TARGET_ANDROID)</span><br><span>     msg(D_ROUTE_DEBUG, &quot;De=
leting routes on Android is not possible/not &quot;</span><br><span>       =
  &quot;needed. The VpnService API allows routes to be set &quot;</span><br=
><span>         &quot;on connect only and will clean up automatically.&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TA=
RGET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ex: route del /dev/n=
et/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s del %=
s inet6 %s gw %s prefixlen %d&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                ROUTE_PATH,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                r6-&gt;iface,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                network,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                gateway,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                r6-&gt;netbits=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(D_RO=
UTE, &amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Haiku inet6 route dele=
te command failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> #else  /* if defined(TARGET_LINUX) */</span><br><sp=
an>     msg(M_FATAL, &quot;Sorry, but I don&#39;t know how to do &#39;route=
 ipv6&#39; commands on this operating system.  Try putting your routes in a=
 --route-down script&quot;);</span><br><span> #endif /* if defined(TARGET_L=
INUX) */</span><br><span>@@ -3886,6 +3939,86 @@</span><br><span> </span><br=
><span> #undef max</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#elif defined(TARGET_HAIKU)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_defau=
lt_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    CLEAR(*rgi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int sockfd =3D socket(AF_INET, SOCK_DGRAM, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (sockfd &lt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(M_ERRNO, &quot;%s: Error opening soc=
ket for AF_INET&quot;, __func__);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconf confi=
g;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    config.ifc_le=
n =3D sizeof(config.ifc_value);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (ioctl(sockfd, SIOCGRTSIZE, &amp;config, sizeof(struct i=
fconf)) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERRN=
O, &quot;%s: Error getting routing table size&quot;, __func__);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint32 size =3D (uint32)config.ifc_value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (size =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *buff=
er =3D malloc(size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    check_malloc_return(buffer);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onfig.ifc_len =3D size;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    config.ifc_buf =3D buffer;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (ioctl(sockfd, SIOCGRTTABLE, &amp;config, sizeof(stru=
ct ifconf)) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(b=
uffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct ifreq *interface =3D (struct ifreq *)b=
uffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct if=
req *end =3D (struct ifreq *)((uint8 *)buffer + size);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    while (interface &lt; end)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct route_entry route =3D interface-&gt;ifr_route;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((route.f=
lags &amp; RTF_GATEWAY) !=3D 0 &amp;&amp; (route.flags &amp; RTF_DEFAULT) !=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            rgi-&gt;gat=
eway.addr =3D ntohl(((struct sockaddr_in *)route.gateway)-&gt;sin_addr.s_ad=
dr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            rgi=
-&gt;flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            strncpy(rgi-&gt;iface, interf=
ace-&gt;ifr_name, sizeof(rgi-&gt;iface));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 int32 address_size =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (route.destination !=3D NULL)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            address_size +=3D route.destination-&gt;sa_le=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (route.mask !=3D=
 NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            address_siz=
e +=3D route.mask-&gt;sa_len;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (route.gateway !=3D NULL)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            address_size +=3D route.gateway-&gt;sa_len;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        interface =3D (struct ifreq *)((addr_t)interface + I=
F_NAMESIZE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                            + sizeof(struct route_entry) + address_size);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free(buffer);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_default_ga=
teway_ipv6(struct route_ipv6_gateway_info *rgi6,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                         const struct in6_addr=
 *dest, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 TODO: Same for ipv6 with AF_INET6 */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    CLEAR(*rgi6);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> #else  /* if defined(_WIN32) */</span><br><span> </span><br=
><span> /*</span><br><span>diff --git a/src/openvpn/syshead.h b/src/openvpn=
/syshead.h</span><br><span>index 33a90c1..844e47a 100644</span><br><span>--=
- a/src/openvpn/syshead.h</span><br><span>+++ b/src/openvpn/syshead.h</span=
><br><span>@@ -166,6 +166,12 @@</span><br><span> #include &lt;string.h&gt;<=
/span><br><span> #endif</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(TARGET_HAIKU)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;SupportDefs.h&gt;   /* uint32, etc=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;net=
/if.h&gt;        /* ifconf etc */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &lt;sys/sockio.h&gt;    /* SIOCGRTTABLE, etc */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* TARGET_HAIKU *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
#ifdef HAVE_ARPA_INET_H</span><br><span> #include &lt;arpa/inet.h&gt;</span=
><br><span> #endif</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail">change 688</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/688?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f=
44087d7c2b6fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 688 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: kallisti5 &lt;alex@...2837...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: kallisti5 &lt;alex@...2839...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--gOBSEQrymxU=--

