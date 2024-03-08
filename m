From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 8 Mar 2024 11:25:26 +0000
In-Reply-To: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <62646442463d8a7b5fd0126468b3bb07c9e1394e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F+97Bx7bgPc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Minor fix to
 process_ip_header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--F+97Bx7bgPc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review+2 by plaisthos


Change subject: Minor fix to process_ip_header
......................................................................

Minor fix to process_ip_header

Removed if-guard checking if any feature is
enabled before performing per-feature check.
It doesn't save us much but instead introduces
uneeded complexity.

While at it, fixed a typo IMCP -> ICMP for defined
PIPV6_ICMP_NOHOST_CLIENT and PIPV6_ICMP_NOHOST_SERVER
macros.

Fixes: Trac https://community.openvpn.net/openvpn/ticket/269
Change-Id: I4b5e8357d872c920efdb64632e9bce72cebee202
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240307124616.16358-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
345.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/multi.c
3 files changed, 49 insertions(+), 61 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/525/6

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0443ca0..556c465 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1460,7 +1460,7 @@
          * us to examine the IP header (IPv4 or IPv6).
          */
         unsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_N=
AT
-                             | PIPV6_IMCP_NOHOST_CLIENT;
+                             | PIPV6_ICMP_NOHOST_CLIENT;
         process_ip_header(c, flags, &c->c2.buf);

 #ifdef PACKET_TRUNCATION_CHECK
@@ -1644,73 +1644,60 @@
     }
     if (!c->options.block_ipv6)
     {
-        flags &=3D ~(PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NOHOST_SERVER);
+        flags &=3D ~(PIPV6_ICMP_NOHOST_CLIENT | PIPV6_ICMP_NOHOST_SERVER);
     }

     if (buf->len > 0)
     {
-        /*
-         * The --passtos and --mssfix options require
-         * us to examine the IPv4 header.
-         */
-
-        if (flags & (PIP_MSSFIX
-#if PASSTOS_CAPABILITY
-                     | PIPV4_PASSTOS
-#endif
-                     | PIPV4_CLIENT_NAT
-                     ))
+        struct buffer ipbuf =3D *buf;
+        if (is_ipv4(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
         {
-            struct buffer ipbuf =3D *buf;
-            if (is_ipv4(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
-            {
 #if PASSTOS_CAPABILITY
-                /* extract TOS from IP header */
-                if (flags & PIPV4_PASSTOS)
-                {
-                    link_socket_extract_tos(c->c2.link_socket, &ipbuf);
-                }
+            /* extract TOS from IP header */
+            if (flags & PIPV4_PASSTOS)
+            {
+                link_socket_extract_tos(c->c2.link_socket, &ipbuf);
+            }
 #endif

-                /* possibly alter the TCP MSS */
-                if (flags & PIP_MSSFIX)
-                {
-                    mss_fixup_ipv4(&ipbuf, c->c2.frame.mss_fix);
-                }
-
-                /* possibly do NAT on packet */
-                if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
-                {
-                    const int direction =3D (flags & PIP_OUTGOING) ? CN_IN=
COMING : CN_OUTGOING;
-                    client_nat_transform(c->options.client_nat, &ipbuf, di=
rection);
-                }
-                /* possibly extract a DHCP router message */
-                if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
-                {
-                    const in_addr_t dhcp_router =3D dhcp_extract_router_ms=
g(&ipbuf);
-                    if (dhcp_router)
-                    {
-                        route_list_add_vpn_gateway(c->c1.route_list, c->c2=
.es, dhcp_router);
-                    }
-                }
-            }
-            else if (is_ipv6(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
+            /* possibly alter the TCP MSS */
+            if (flags & PIP_MSSFIX)
             {
-                /* possibly alter the TCP MSS */
-                if (flags & PIP_MSSFIX)
-                {
-                    mss_fixup_ipv6(&ipbuf, c->c2.frame.mss_fix);
-                }
-                if (!(flags & PIP_OUTGOING) && (flags
-                                                &(PIPV6_IMCP_NOHOST_CLIENT=
 | PIPV6_IMCP_NOHOST_SERVER)))
-                {
-                    ipv6_send_icmp_unreachable(c, buf,
-                                               (bool)(flags & PIPV6_IMCP_N=
OHOST_CLIENT));
-                    /* Drop the IPv6 packet */
-                    buf->len =3D 0;
-                }
-
+                mss_fixup_ipv4(&ipbuf, c->c2.frame.mss_fix);
             }
+
+            /* possibly do NAT on packet */
+            if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
+            {
+                const int direction =3D (flags & PIP_OUTGOING) ? CN_INCOMI=
NG : CN_OUTGOING;
+                client_nat_transform(c->options.client_nat, &ipbuf, direct=
ion);
+            }
+            /* possibly extract a DHCP router message */
+            if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
+            {
+                const in_addr_t dhcp_router =3D dhcp_extract_router_msg(&i=
pbuf);
+                if (dhcp_router)
+                {
+                    route_list_add_vpn_gateway(c->c1.route_list, c->c2.es,=
 dhcp_router);
+                }
+            }
+        }
+        else if (is_ipv6(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
+        {
+            /* possibly alter the TCP MSS */
+            if (flags & PIP_MSSFIX)
+            {
+                mss_fixup_ipv6(&ipbuf, c->c2.frame.mss_fix);
+            }
+            if (!(flags & PIP_OUTGOING) && (flags
+                                            &(PIPV6_ICMP_NOHOST_CLIENT | P=
IPV6_ICMP_NOHOST_SERVER)))
+            {
+                ipv6_send_icmp_unreachable(c, buf,
+                                           (bool)(flags & PIPV6_ICMP_NOHOS=
T_CLIENT));
+                /* Drop the IPv6 packet */
+                buf->len =3D 0;
+            }
+
         }
     }
 }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index e19115e..bc00ba5 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -297,8 +297,9 @@
 #define PIP_OUTGOING                    (1<<2)
 #define PIPV4_EXTRACT_DHCP_ROUTER       (1<<3)
 #define PIPV4_CLIENT_NAT                (1<<4)
-#define PIPV6_IMCP_NOHOST_CLIENT        (1<<5)
-#define PIPV6_IMCP_NOHOST_SERVER        (1<<6)
+#define PIPV6_ICMP_NOHOST_CLIENT        (1<<5)
+#define PIPV6_ICMP_NOHOST_SERVER        (1<<6)
+

 void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf);

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4344126..712456c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3645,7 +3645,7 @@

     if (mbuf_extract_item(ms, &item)) /* cleartext IP packet */
     {
-        unsigned int pip_flags =3D PIPV4_PASSTOS | PIPV6_IMCP_NOHOST_SERVE=
R;
+        unsigned int pip_flags =3D PIPV4_PASSTOS | PIPV6_ICMP_NOHOST_SERVE=
R;

         set_prefix(item.instance);
         item.instance->context.c2.buf =3D item.buffer->buf;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4b5e8357d872c920efdb64632e9bce72cebee202
Gerrit-Change-Number: 525
Gerrit-PatchSet: 6
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--F+97Bx7bgPc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
525?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld, Code-Review+2 by plaisthos</p><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">Minor fix to proc=
ess_ip_header<br><br>Removed if-guard checking if any feature is<br>enabled=
 before performing per-feature check.<br>It doesn&#39;t save us much but in=
stead introduces<br>uneeded complexity.<br><br>While at it, fixed a typo IM=
CP -&gt; ICMP for defined<br>PIPV6_ICMP_NOHOST_CLIENT and PIPV6_ICMP_NOHOST=
_SERVER<br>macros.<br><br>Fixes: Trac https://community.openvpn.net/openvpn=
/ticket/269<br>Change-Id: I4b5e8357d872c920efdb64632e9bce72cebee202<br>Sign=
ed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: A=
rne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Message-Id: &lt;20240307124616.16358-1-gert@...493...=
1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg28345.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/o=
penvpn/multi.c<br>3 files changed, 49 insertions(+), 61 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/525/6</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br=
><span>index 0443ca0..556c465 100644</span><br><span>--- a/src/openvpn/forw=
ard.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1460,=
7 +1460,7 @@</span><br><span>          * us to examine the IP header (IPv4 =
or IPv6).</span><br><span>          */</span><br><span>         unsigned in=
t flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                             | PIPV6_IM=
CP_NOHOST_CLIENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                           | PIPV6_ICMP_NOHOST_CLIENT;</span><br><span>    =
     process_ip_header(c, flags, &amp;c-&gt;c2.buf);</span><br><span> </spa=
n><br><span> #ifdef PACKET_TRUNCATION_CHECK</span><br><span>@@ -1644,73 +16=
44,60 @@</span><br><span>     }</span><br><span>     if (!c-&gt;options.blo=
ck_ipv6)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        flags &amp;=3D ~(PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NO=
HOST_SERVER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  flags &amp;=3D ~(PIPV6_ICMP_NOHOST_CLIENT | PIPV6_ICMP_NOHOST_SERVER);</s=
pan><br><span>     }</span><br><span> </span><br><span>     if (buf-&gt;len=
 &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * The --passtos and --mssfix options require</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * us to examine the IPv4 header.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (flags &amp; (PIP_MSSFIX</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if PASSTOS_CAPABILITY</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                     | PIPV4_PASSTOS</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                     | PIPV4_CLIENT_NAT=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct bu=
ffer ipbuf =3D *buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (is_ipv4(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;ipbuf))</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      struct buffer ipbuf =3D *buf;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (is_ipv4(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;ip=
buf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span> #if PASSTOS_CAPABILITY</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                /* extract TOS from IP header */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                if (flags &amp; =
PIPV4_PASSTOS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         link_socket_extract_tos(c-&gt;c2.link_socket, &amp;ipbuf);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* extract TOS from=
 IP header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (flags &amp; PIPV4_PASSTOS)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                link_socket_extract_tos(c-&gt;c2.link_socket, &a=
mp;ipbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span> #endif</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                /* possibly alter the TCP MSS */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (fla=
gs &amp; PIP_MSSFIX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               mss_fixup_ipv4(&amp;ipbuf, c-&gt;c2.frame.mss_fix);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                /* possibly do NAT on packet */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                if ((flags &a=
mp; PIPV4_CLIENT_NAT) &amp;&amp; c-&gt;options.client_nat)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    const int direction =
=3D (flags &amp; PIP_OUTGOING) ? CN_INCOMING : CN_OUTGOING;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    client_nat_transf=
orm(c-&gt;options.client_nat, &amp;ipbuf, direction);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                /* possibly extract a DHCP rout=
er message */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        if (flags &amp; PIPV4_EXTRACT_DHCP_ROUTER)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    const in_addr_t dhcp_router =
=3D dhcp_extract_router_msg(&amp;ipbuf);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    if (dhcp_router)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        route_list_add_vp=
n_gateway(c-&gt;c1.route_list, c-&gt;c2.es, dhcp_router);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            else if (is_ipv6(TUNNEL_TYPE(c-&gt;c1.t=
untap), &amp;ipbuf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* possibly alter the TCP MSS */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (flags &amp; PIP_MSSFIX)</span><br=
><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                /* possibly alter the TCP MSS */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                if (flags &amp; PIP_MSSFIX)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    mss_fixup_=
ipv6(&amp;ipbuf, c-&gt;c2.frame.mss_fix);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                if (!(flags &amp; PIP_OUTGOING) &amp;&amp; =
(flags</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                                 &amp;(PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMC=
P_NOHOST_SERVER)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             ipv6_send_icmp_unreachable(c, buf,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                               (b=
ool)(flags &amp; PIPV6_IMCP_NOHOST_CLIENT));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    /* Drop the IPv6 packet */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    buf-&gt=
;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                mss_fixup_ipv4(&a=
mp;ipbuf, c-&gt;c2.frame.mss_fix);</span><br><span>             }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* possibly do NAT on packet */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((flags &=
amp; PIPV4_CLIENT_NAT) &amp;&amp; c-&gt;options.client_nat)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const int direction =3D (=
flags &amp; PIP_OUTGOING) ? CN_INCOMING : CN_OUTGOING;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                client_nat_transform(c-&=
gt;options.client_nat, &amp;ipbuf, direction);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* possibly extract a DHCP router message =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (f=
lags &amp; PIPV4_EXTRACT_DHCP_ROUTER)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                const in_addr_t dhcp_router =3D dhcp_extract_ro=
uter_msg(&amp;ipbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if (dhcp_router)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    route_list_add_vpn_gateway(c-&gt;c1.route_=
list, c-&gt;c2.es, dhcp_router);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else if (is_ipv6(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;ipbuf))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* possibly alter the TCP MSS=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
flags &amp; PIP_MSSFIX)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              mss_fixup_ipv6(&amp;ipbuf, c-&gt;c2.frame.mss_fix);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (!(flags &amp; PIP_O=
UTGOING) &amp;&amp; (flags</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                            &amp;(PIPV6_ICMP_NOHOST_=
CLIENT | PIPV6_ICMP_NOHOST_SERVER)))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                ipv6_send_icmp_unreachable(c, buf,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
          (bool)(flags &amp; PIPV6_ICMP_NOHOST_CLIENT));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                /* Drop the IPv6 packe=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>         }</span><br><span>     }</span><br><span> }</span><br><=
span>diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><=
span>index e19115e..bc00ba5 100644</span><br><span>--- a/src/openvpn/forwar=
d.h</span><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -297,8 +=
297,9 @@</span><br><span> #define PIP_OUTGOING                    (1&lt;&lt=
;2)</span><br><span> #define PIPV4_EXTRACT_DHCP_ROUTER       (1&lt;&lt;3)</=
span><br><span> #define PIPV4_CLIENT_NAT                (1&lt;&lt;4)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define PIPV6_IMCP_NOHOST_CL=
IENT        (1&lt;&lt;5)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define PIPV6_IMCP_NOHOST_SERVER        (1&lt;&lt;6)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define PIPV6_ICMP_NOHOST_CLIENT       =
 (1&lt;&lt;5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e PIPV6_ICMP_NOHOST_SERVER        (1&lt;&lt;6)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> void process=
_ip_header(struct context *c, unsigned int flags, struct buffer *buf);</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/multi.c b/src/openvp=
n/multi.c</span><br><span>index 4344126..712456c 100644</span><br><span>---=
 a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br>=
<span>@@ -3645,7 +3645,7 @@</span><br><span> </span><br><span>     if (mbuf=
_extract_item(ms, &amp;item)) /* cleartext IP packet */</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        unsigned i=
nt pip_flags =3D PIPV4_PASSTOS | PIPV6_IMCP_NOHOST_SERVER;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        unsigned int pip_flags =3D P=
IPV4_PASSTOS | PIPV6_ICMP_NOHOST_SERVER;</span><br><span> </span><br><span>=
         set_prefix(item.instance);</span><br><span>         item.instance-=
&gt;context.c2.buf =3D item.buffer-&gt;buf;</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/525?us=
p=3Demail">change 525</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4b5e8357d872c920efdb64632e9=
bce72cebee202 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 525 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--F+97Bx7bgPc=--

