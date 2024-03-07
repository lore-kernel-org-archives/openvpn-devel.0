From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 7 Mar 2024 12:23:12 +0000
In-Reply-To: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <f40e2ace3b980d32f953069e7aafd34d14a43674-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="46GQCMxs/wc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--46GQCMxs/wc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail

to look at the new patch set (#5).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/multi.c
3 files changed, 49 insertions(+), 61 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/525/5

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
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--46GQCMxs/wc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/525?usp=3Demail">View Chang=
e</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is=
 unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">Minor fix to process_ip_header<br><br>Removed if-guard ch=
ecking if any feature is<br>enabled before performing per-feature check.<br=
>It doesn&#39;t save us much but instead introduces<br>uneeded complexity.<=
br><br>While at it, fixed a typo IMCP -&gt; ICMP for defined<br>PIPV6_ICMP_=
NOHOST_CLIENT and PIPV6_ICMP_NOHOST_SERVER<br>macros.<br><br>Fixes: Trac ht=
tps://community.openvpn.net/openvpn/ticket/269<br>Change-Id: I4b5e8357d872c=
920efdb64632e9bce72cebee202<br>Signed-off-by: Gianmarco De Gregori &lt;gian=
marco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/for=
ward.h<br>M src/openvpn/multi.c<br>3 files changed, 49 insertions(+), 61 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/25/525/5</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/fo=
rward.c</span><br><span>index 0443ca0..556c465 100644</span><br><span>--- a=
/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><b=
r><span>@@ -1460,7 +1460,7 @@</span><br><span>          * us to examine the=
 IP header (IPv4 or IPv6).</span><br><span>          */</span><br><span>   =
      unsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
       | PIPV6_IMCP_NOHOST_CLIENT;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                             | PIPV6_ICMP_NOHOST_CLIENT;</sp=
an><br><span>         process_ip_header(c, flags, &amp;c-&gt;c2.buf);</span=
><br><span> </span><br><span> #ifdef PACKET_TRUNCATION_CHECK</span><br><spa=
n>@@ -1644,73 +1644,60 @@</span><br><span>     }</span><br><span>     if (!=
c-&gt;options.block_ipv6)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        flags &amp;=3D ~(PIPV6_IMCP_NOHOST_CLIEN=
T | PIPV6_IMCP_NOHOST_SERVER);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        flags &amp;=3D ~(PIPV6_ICMP_NOHOST_CLIENT | PIPV6_ICMP_N=
OHOST_SERVER);</span><br><span>     }</span><br><span> </span><br><span>   =
  if (buf-&gt;len &gt; 0)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         * The --passtos and --mssfix options require</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         * us to examine th=
e IPv4 header.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; (PIP_MSSFIX</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if PASSTOS_CAPABILITY</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     | =
PIPV4_PASSTOS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     | =
PIPV4_CLIENT_NAT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct buffer ipbuf =3D *buf;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (is_ipv4(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;ipb=
uf))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            struct buffer ipbuf =3D *buf;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (is_ipv4(TUNNEL_TYPE(c-&gt;c=
1.tuntap), &amp;ipbuf))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span> #if PASSTOS_CAPABILITY</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                /* extract TOS from IP he=
ader */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  if (flags &amp; PIPV4_PASSTOS)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    link_socket_extract_tos(c-&gt;c2.link_socket, &a=
mp;ipbuf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* extract TOS from IP header */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (flags &amp; PIPV4_PASSTOS)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                link_socket_extract_tos(c-&gt;=
c2.link_socket, &amp;ipbuf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span> #endif</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                /* possibly alte=
r the TCP MSS */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           if (flags &amp; PIP_MSSFIX)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    mss_fixup_ipv4(&amp;ipbuf, c-&gt;c2.frame.=
mss_fix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                /* possibly do NAT on=
 packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     if ((flags &amp; PIPV4_CLIENT_NAT) &amp;&amp; c-&gt;options.client_nat=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    cons=
t int direction =3D (flags &amp; PIP_OUTGOING) ? CN_INCOMING : CN_OUTGOING;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    c=
lient_nat_transform(c-&gt;options.client_nat, &amp;ipbuf, direction);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                /* possibly ext=
ract a DHCP router message */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                if (flags &amp; PIPV4_EXTRACT_DHCP_ROUTER)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    const in_addr_=
t dhcp_router =3D dhcp_extract_router_msg(&amp;ipbuf);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    if (dhcp_router)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        rou=
te_list_add_vpn_gateway(c-&gt;c1.route_list, c-&gt;c2.es, dhcp_router);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            else if (is_ipv6(TUNNEL_T=
YPE(c-&gt;c1.tuntap), &amp;ipbuf))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* possibly alter the TCP MSS */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (flags &amp; PIP_MSS=
FIX)</span><br><span>             {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                /* possibly alter the TCP MSS */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                if (flags &amp; PI=
P_MSSFIX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    mss_fixup_ipv6(&amp;ipbuf, c-&gt;c2.frame.mss_fix);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (!(flags &amp; PIP_OUTGO=
ING) &amp;&amp; (flags</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                                &amp;(PIPV6_IMCP_NOHOST_CL=
IENT | PIPV6_IMCP_NOHOST_SERVER)))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    ipv6_send_icmp_unreachable(c, buf,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
              (bool)(flags &amp; PIPV6_IMCP_NOHOST_CLIENT));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    /* Drop the IPv6=
 packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
ss_fixup_ipv4(&amp;ipbuf, c-&gt;c2.frame.mss_fix);</span><br><span>        =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            /* possibly do NAT o=
n packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if ((flags &amp; PIPV4_CLIENT_NAT) &amp;&amp; c-&gt;options.client_nat)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                const int=
 direction =3D (flags &amp; PIP_OUTGOING) ? CN_INCOMING : CN_OUTGOING;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                client_n=
at_transform(c-&gt;options.client_nat, &amp;ipbuf, direction);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* possibly extract a DHCP=
 router message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (flags &amp; PIPV4_EXTRACT_DHCP_ROUTER)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                const in_addr_t dhcp_router =3D=
 dhcp_extract_router_msg(&amp;ipbuf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                if (dhcp_router)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    route_list_add_vpn_gateway=
(c-&gt;c1.route_list, c-&gt;c2.es, dhcp_router);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        else if (is_ipv6(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;ipbu=
f))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* possibly al=
ter the TCP MSS */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (flags &amp; PIP_MSSFIX)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                mss_fixup_ipv6(&amp;ipbuf, c-&gt;c2.frame.mss_=
fix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!(fl=
ags &amp; PIP_OUTGOING) &amp;&amp; (flags</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                            &amp;(PIP=
V6_ICMP_NOHOST_CLIENT | PIPV6_ICMP_NOHOST_SERVER)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                ipv6_send_icmp_unreachable(c, b=
uf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                           (bool)(flags &amp; PIPV6_ICMP_NOHOST_CLIENT));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Dr=
op the IPv6 packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>         }</span><br><span>     }</span><br><sp=
an> }</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/forw=
ard.h</span><br><span>index e19115e..bc00ba5 100644</span><br><span>--- a/s=
rc/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span><br>=
<span>@@ -297,8 +297,9 @@</span><br><span> #define PIP_OUTGOING            =
        (1&lt;&lt;2)</span><br><span> #define PIPV4_EXTRACT_DHCP_ROUTER    =
   (1&lt;&lt;3)</span><br><span> #define PIPV4_CLIENT_NAT                (1=
&lt;&lt;4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PIP=
V6_IMCP_NOHOST_CLIENT        (1&lt;&lt;5)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define PIPV6_IMCP_NOHOST_SERVER        (1&lt;&lt;6)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PIPV6_ICMP_NOH=
OST_CLIENT        (1&lt;&lt;5)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define PIPV6_ICMP_NOHOST_SERVER        (1&lt;&lt;6)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><s=
pan> void process_ip_header(struct context *c, unsigned int flags, struct b=
uffer *buf);</span><br><span> </span><br><span>diff --git a/src/openvpn/mul=
ti.c b/src/openvpn/multi.c</span><br><span>index 4344126..712456c 100644</s=
pan><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/m=
ulti.c</span><br><span>@@ -3645,7 +3645,7 @@</span><br><span> </span><br><s=
pan>     if (mbuf_extract_item(ms, &amp;item)) /* cleartext IP packet */</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       unsigned int pip_flags =3D PIPV4_PASSTOS | PIPV6_IMCP_NOHOST_SERVER;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned in=
t pip_flags =3D PIPV4_PASSTOS | PIPV6_ICMP_NOHOST_SERVER;</span><br><span> =
</span><br><span>         set_prefix(item.instance);</span><br><span>      =
   item.instance-&gt;context.c2.buf =3D item.buffer-&gt;buf;</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/525?usp=3Demail">change 525</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/525?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4b5e8357d872c920efdb64632e9=
bce72cebee202 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 525 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--46GQCMxs/wc=--

