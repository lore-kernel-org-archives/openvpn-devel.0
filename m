From: "kallisti5 (Code Review)" <gerrit@...515...>
Date: Tue, 26 Nov 2024 17:45:25 +0000
In-Reply-To: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
References: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
Reply-To: alex@...2837..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7bedcc71ee31cf5ef90b73f4bed3c9e1cf08e418-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZrwIOYBDHbg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZrwIOYBDHbg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, kallisti5, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Haiku: Add calls to manage routing table
......................................................................

Haiku: Add calls to manage routing table

Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd
---
M src/openvpn/route.c
M src/openvpn/syshead.h
2 files changed, 118 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/688/5

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2e584c7..8625967 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1853,7 +1853,23 @@
         status =3D ret ? RTA_SUCCESS : RTA_ERROR;
     }

-#else  /* if defined(TARGET_LINUX) */
+#elif defined(TARGET_HAIKU)
+
+    {
+        /* ex: route add /dev/net/ipro1000/0 0.0.0.0 gw 192.168.1.1 netmas=
k 128.0.0.0 */
+        argv_printf(&argv, "%s add %s inet %s gw %s netmask %s",
+                    ROUTE_PATH,
+                    rgi->iface,
+                    network,
+                    gateway,
+                    netmask);
+        argv_msg(D_ROUTE, &argv);
+        bool ret =3D openvpn_execve_check(&argv, es, 0,
+                                        "ERROR: Haiku inet route add comma=
nd failed");
+        status =3D ret ? RTA_SUCCESS : RTA_ERROR;
+    }
+
+#else /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route' commands on th=
is operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */

@@ -2329,6 +2345,20 @@
         openvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete comman=
d failed");
     }

+#elif defined(TARGET_HAIKU)
+
+    {
+        /* ex: route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1=
.1 netmask 255.255.0.0 */
+        argv_printf(&argv, "%s del %s inet %s gw %s netmask %s",
+                    ROUTE_PATH,
+                    rgi->iface,
+                    network,
+                    gateway,
+                    netmask);
+        argv_msg(D_ROUTE, &argv);
+        openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route delete=
 command failed");
+    }
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route' commands on th=
is operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
@@ -2504,10 +2534,23 @@
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
+    {
+        /* ex: route del /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefix=
len 64 */
+        argv_printf(&argv, "%s del %s inet6 %s gw %s prefixlen %d",
+                    ROUTE_PATH,
+                    r6->iface,
+                    network,
+                    gateway,
+                    r6->netbits);
+        argv_msg(D_ROUTE, &argv);
+        openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet6 route delet=
e command failed");
+    }
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands =
on this operating system.  Try putting your routes in a --route-down script=
");
 #endif /* if defined(TARGET_LINUX) */
@@ -3886,6 +3929,74 @@

 #undef max

+#elif defined(TARGET_HAIKU)
+
+void
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+{
+    CLEAR(*rgi);
+
+    int sockfd =3D -1;
+    sockfd =3D socket(AF_INET, SOCK_DGRAM, 0);
+    if (sockfd < 0) {
+        msg(M_INFO, "%s: Error opening socket for AF_INET", __func__);
+        return;
+    }
+
+    struct ifconf config;
+    config.ifc_len =3D sizeof(config.ifc_value);
+    if (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct ifconf)) < 0) {
+        msg(M_INFO, "%s: Error getting routing table size", __func__);
+        return;
+    }
+
+    uint32 size =3D (uint32)config.ifc_value;
+    if (size =3D=3D 0)
+        return;
+
+    void *buffer =3D malloc(size);
+    if (buffer =3D=3D NULL) {
+        fprintf(stderr, "%s: Out of memory.\n", __func__);
+        return;
+    }
+
+    config.ifc_len =3D size;
+    config.ifc_buf =3D buffer;
+    if (ioctl(sockfd, SIOCGRTTABLE, &config, sizeof(struct ifconf)) < 0)
+        return;
+
+    struct ifreq *interface =3D (struct ifreq*)buffer;
+    struct ifreq *end =3D (struct ifreq*)((uint8*)buffer + size);
+
+    while (interface < end) {
+        struct route_entry route =3D interface->ifr_route;
+        if ((route.flags & RTF_GATEWAY) !=3D 0 && (route.flags & RTF_DEFAU=
LT) !=3D 0) {
+            rgi->gateway.addr =3D ntohl(((struct sockaddr_in *)route.gatew=
ay)->sin_addr.s_addr);
+            rgi->flags =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+            strcpy(rgi->iface, interface->ifr_name);
+        }
+
+        int32 addressSize =3D 0;
+        if (route.destination !=3D NULL)
+            addressSize +=3D route.destination->sa_len;
+        if (route.mask !=3D NULL)
+            addressSize +=3D route.mask->sa_len;
+        if (route.gateway !=3D NULL)
+            addressSize +=3D route.gateway->sa_len;
+
+        interface =3D (struct ifreq*)((addr_t)interface + IF_NAMESIZE
+            + sizeof(struct route_entry) + addressSize);
+    }
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
Gerrit-PatchSet: 5
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: kallisti5 <alex@...2837...>
Gerrit-MessageType: newpatchset

--ZrwIOYBDHbg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, kallisti5, plaistho=
s. </p>
<p>kallisti5 <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Haiku: Add calls to manage routing table<br><=
br>Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd<br>---<br>M src/ope=
nvpn/route.c<br>M src/openvpn/syshead.h<br>2 files changed, 118 insertions(=
+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/88/688/5</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/route.c b/src/openv=
pn/route.c</span><br><span>index 2e584c7..8625967 100644</span><br><span>--=
- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br=
><span>@@ -1853,7 +1853,23 @@</span><br><span>         status =3D ret ? RTA=
_SUCCESS : RTA_ERROR;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGET_LINUX)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TA=
RGET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* ex: route add /dev/net/ipro100=
0/0 0.0.0.0 gw 192.168.1.1 netmask 128.0.0.0 */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s add %s =
inet %s gw %s netmask %s&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    ROUTE_PATH,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    rgi-&gt;iface,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    network,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    gateway=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        bool ret =3D openvpn_execve_check(&amp;argv, es, 0,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
               &quot;ERROR: Haiku inet route add command failed&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D ret =
? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* if defined(TARGET=
_LINUX) */</span><br><span>     msg(M_FATAL, &quot;Sorry, but I don&#39;t k=
now how to do &#39;route&#39; commands on this operating system.  Try putti=
ng your routes in a --route-up script&quot;);</span><br><span> #endif /* if=
 defined(TARGET_LINUX) */</span><br><span> </span><br><span>@@ -2329,6 +234=
5,20 @@</span><br><span>         openvpn_execve_check(&amp;argv, es, 0, &qu=
ot;ERROR: AIX route delete command failed&quot;);</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#eli=
f defined(TARGET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* ex: route del /dev=
/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0.0 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp=
;argv, &quot;%s del %s inet %s gw %s netmask %s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    ROUTE_PATH,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    rgi-&gt;=
iface,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    netmask);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        argv_msg(D_ROUTE, &amp;argv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        openvpn_execve_check(&amp;argv, e=
s, 0, &quot;ERROR: Haiku inet route delete command failed&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #else  /* if defined(TA=
RGET_LINUX) */</span><br><span>     msg(M_FATAL, &quot;Sorry, but I don&#39=
;t know how to do &#39;route&#39; commands on this operating system.  Try p=
utting your routes in a --route-up script&quot;);</span><br><span> #endif /=
* if defined(TARGET_LINUX) */</span><br><span>@@ -2504,10 +2534,23 @@</span=
><br><span>                 network, r6-&gt;netbits, gateway);</span><br><s=
pan>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_=
check(&amp;argv, es, 0, &quot;ERROR: AIX route add command failed&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #el=
if defined(TARGET_ANDROID)</span><br><span>     msg(D_ROUTE_DEBUG, &quot;De=
leting routes on Android is not possible/not &quot;</span><br><span>       =
  &quot;needed. The VpnService API allows routes to be set &quot;</span><br=
><span>         &quot;on connect only and will clean up automatically.&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TA=
RGET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* ex: route d=
el /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &q=
uot;%s del %s inet6 %s gw %s prefixlen %d&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    ROUTE_PATH,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    r6-&gt;iface,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  r6-&gt;netbits);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        argv_msg(D_ROUTE, &amp;argv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        openvpn_execve_check(&amp;argv, e=
s, 0, &quot;ERROR: Haiku inet6 route delete command failed&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #else=
  /* if defined(TARGET_LINUX) */</span><br><span>     msg(M_FATAL, &quot;So=
rry, but I don&#39;t know how to do &#39;route ipv6&#39; commands on this o=
perating system.  Try putting your routes in a --route-down script&quot;);<=
/span><br><span> #endif /* if defined(TARGET_LINUX) */</span><br><span>@@ -=
3886,6 +3929,74 @@</span><br><span> </span><br><span> #undef max</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif define=
d(TARGET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+get_default_gateway(struct route_gatew=
ay_info *rgi, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    CLEAR(*rgi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int sockfd =3D -1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sockfd =3D sock=
et(AF_INET, SOCK_DGRAM, 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (sockfd &lt; 0) {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_INFO, &quot;%s: Error opening socket for AF_INET=
&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct ifconf config;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    config.ifc_len =3D sizeof(co=
nfig.ifc_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (ioctl(sockfd, SIOCGRTSIZE, &amp;config, sizeof(struct ifconf)) &lt; 0)=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INF=
O, &quot;%s: Error getting routing table size&quot;, __func__);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint32 size =3D (uint32)config.ifc_value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (size =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    void *buffer =3D malloc(size);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (buffer =3D=3D NULL) {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        fprintf(stderr, &quot;%s: O=
ut of memory.\n&quot;, __func__);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    config.ifc_len =3D =
size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    config.ifc=
_buf =3D buffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (ioctl(sockfd, SIOCGRTTABLE, &amp;config, sizeof(struct ifconf)) &lt; 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ifreq *interface =3D (struct i=
freq*)buffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct ifreq *end =3D (struct ifreq*)((uint8*)buffer + size);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    while (interface &lt; end) {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct route_entry route =3D inte=
rface-&gt;ifr_route;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if ((route.flags &amp; RTF_GATEWAY) !=3D 0 &amp;&amp; (route.flags=
 &amp; RTF_DEFAULT) !=3D 0) {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            rgi-&gt;gateway.addr =3D ntohl(((struct sockaddr_in *=
)route.gateway)-&gt;sin_addr.s_addr);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            rgi-&gt;flags =3D RGI_ADDR_DEFINED | RGI_IFAC=
E_DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   strcpy(rgi-&gt;iface, interface-&gt;ifr_name);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        int32 addressSize =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (route.destination !=3D NULL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            addressSize +=3D route.desti=
nation-&gt;sa_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (route.mask !=3D NULL)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            addressSize +=3D route.mask-&gt;sa_len;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (route.gateway !=3D=
 NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            a=
ddressSize +=3D route.gateway-&gt;sa_len;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        interface =3D (struct ifreq*)((addr_t)interface + IF_NAMESIZE</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            + sizeof(s=
truct route_entry) + addressSize);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+get_default_gateway_ipv6(struct route_ipv6_gateway_=
info *rgi6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                 const struct in6_addr *dest, openvpn_net_ctx_t *ctx)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* TODO: Same for ipv6 with AF_INET6 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*rgi6);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #else  /* if define=
d(_WIN32) */</span><br><span> </span><br><span> /*</span><br><span>diff --g=
it a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span><br><span>index 33=
a90c1..844e47a 100644</span><br><span>--- a/src/openvpn/syshead.h</span><br=
><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -166,6 +166,12 @@</sp=
an><br><span> #include &lt;string.h&gt;</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(T=
ARGET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;SupportDefs.h&gt;   /* uint32, etc */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;net/if.h&gt;        /* ifconf etc */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/sock=
io.h&gt;    /* SIOCGRTTABLE, etc */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif /* TARGET_HAIKU */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #ifdef HAVE_ARPA_INET_H</span><br><=
span> #include &lt;arpa/inet.h&gt;</span><br><span> #endif</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/688?usp=3Demail">change 688</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f=
44087d7c2b6fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 688 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
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
<div style=3D"display:none"> Gerrit-Attention: kallisti5 &lt;alex@...2839...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ZrwIOYBDHbg=--

