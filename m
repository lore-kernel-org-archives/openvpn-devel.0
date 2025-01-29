From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 10:53:58 +0000
In-Reply-To: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
References: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <84455fc8243faed77bcbcd76464c7d85b05c6cd2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FZ+PBliwQts="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mroute/management:
 fix uninitialized variable (UNINIT)
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

--FZ+PBliwQts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, ordex=
, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: mroute/management: fix uninitialized variable (UNINIT)
......................................................................

mroute/management: fix uninitialized variable (UNINIT)

Fix issue reported by Coverity:
CID 1641564: Uninitialized variables (UNINIT)
Using unitialized value "maddr.proto" when
calling "mroute_addr_equal()".

Fix this by passing the proto along with
IP:port.

While at it, changed the
mroute_addr_print_ex() format to display
the protocol only in case of MR_WITH_PROTO
avoid doing it on virtual addresses when
MR_WITH_PORT is not specified.

Change-Id: I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M Changes.rst
M doc/management-notes.txt
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/multi.c
8 files changed, 49 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/880/4

diff --git a/Changes.rst b/Changes.rst
index 16ae6fc..d01816b 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -317,6 +317,9 @@
   settings will contradict the setting of allow-compression as this almost
   always results in a non-working connection.

+- The "kill" by addr management command now requires also the protocol
+  as string e.g. "udp", "tcp".
+
 Common errors with OpenSSL 3.0 and OpenVPN 2.6
 ----------------------------------------------
 Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable, so some
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index b55135a..f1d2930 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -205,8 +205,12 @@

   kill Test-Client -- kill the client instance having a
                       common name of "Test-Client".
-  kill 1.2.3.4:4000 -- kill the client instance having a
-                       source address and port of 1.2.3.4:4000
+  kill tcp:1.2.3.4:4000 -- kill the client instance having a
+                           source address, port and proto of
+                           tcp:1.2.3.4:4000
+
+  Note that kill by address won't work for IPv6-connected
+  clients yet, so rely on kill by CN or CID instead.

 Use the "status" command to see which clients are connected.

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0c77f85..a796dbe 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -544,45 +544,52 @@
         struct buffer buf;
         char p1[128];
         char p2[128];
+        char p3[128];
         int n_killed;

         buf_set_read(&buf, (uint8_t *) victim, strlen(victim) + 1);
         buf_parse(&buf, ':', p1, sizeof(p1));
         buf_parse(&buf, ':', p2, sizeof(p2));
+        buf_parse(&buf, ':', p3, sizeof(p3));

-        if (strlen(p1) && strlen(p2))
+        if (strlen(p1) && strlen(p2) && strlen(p3))
         {
             /* IP:port specified */
             bool status;
-            const in_addr_t addr =3D getaddr(GETADDR_HOST_ORDER|GETADDR_MS=
G_VIRT_OUT, p1, 0, &status, NULL);
+            const in_addr_t addr =3D getaddr(GETADDR_HOST_ORDER|GETADDR_MS=
G_VIRT_OUT, p2, 0, &status, NULL);
             if (status)
             {
-                const int port =3D atoi(p2);
-                if (port > 0 && port < 65536)
+                const int port =3D atoi(p3);
+                const int proto =3D (streq(p1, "tcp")) ? PROTO_TCP_SERVER :
+                                  (streq(p1, "udp")) ? PROTO_UDP : PROTO_N=
ONE;
+
+                if ((port > 0 && port < 65536) && (proto !=3D PROTO_NONE))
                 {
-                    n_killed =3D (*man->persist.callback.kill_by_addr)(man=
->persist.callback.arg, addr, port);
+                    n_killed =3D (*man->persist.callback.kill_by_addr)(man=
->persist.callback.arg, addr, port, proto);
                     if (n_killed > 0)
                     {
-                        msg(M_CLIENT, "SUCCESS: %d client(s) at address %s=
:%d killed",
+                        msg(M_CLIENT, "SUCCESS: %d client(s) at address %s=
:%s:%d killed",
                             n_killed,
+                            proto2ascii(proto, AF_INET, true),
                             print_in_addr_t(addr, 0, &gc),
                             port);
                     }
                     else
                     {
-                        msg(M_CLIENT, "ERROR: client at address %s:%d not =
found",
+                        msg(M_CLIENT, "ERROR: client at address %s:%s:%d n=
ot found",
+                            proto2ascii(proto, AF_INET, true),
                             print_in_addr_t(addr, 0, &gc),
                             port);
                     }
                 }
                 else
                 {
-                    msg(M_CLIENT, "ERROR: port number is out of range: %s"=
, p2);
+                    msg(M_CLIENT, "ERROR: port number or protocol out of r=
ange: %s %s", p3, p1);
                 }
             }
             else
             {
-                msg(M_CLIENT, "ERROR: error parsing IP address: %s", p1);
+                msg(M_CLIENT, "ERROR: error parsing IP address: %s", p2);
             }
         }
         else if (strlen(p1))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f501543..02ceb82 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -180,7 +180,7 @@
     void (*status) (void *arg, const int version, struct status_output *so=
);
     void (*show_net) (void *arg, const int msglevel);
     int (*kill_by_cn) (void *arg, const char *common_name);
-    int (*kill_by_addr) (void *arg, const in_addr_t addr, const int port);
+    int (*kill_by_addr) (void *arg, const in_addr_t addr, const int port, =
const int proto);
     void (*delete_event) (void *arg, event_t event);
     int (*n_clients) (void *arg);
     bool (*send_cc_message) (void *arg, const char *message, const char *p=
arameter);
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 74923cf..24b9543 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -276,6 +276,10 @@
                 addr->len =3D 6;
                 addr->v4.addr =3D osaddr->addr.in4.sin_addr.s_addr;
                 addr->v4.port =3D osaddr->addr.in4.sin_port;
+                if (addr->proto !=3D PROTO_NONE)
+                {
+                    addr->type |=3D MR_WITH_PROTO;
+                }
             }
             else
             {
@@ -295,6 +299,10 @@
                 addr->len =3D 18;
                 addr->v6.addr =3D osaddr->addr.in6.sin6_addr;
                 addr->v6.port =3D osaddr->addr.in6.sin6_port;
+                if (addr->proto !=3D PROTO_NONE)
+                {
+                    addr->type |=3D MR_WITH_PROTO;
+                }
             }
             else
             {
@@ -403,6 +411,10 @@
                 {
                     buf_printf(&out, "ARP/");
                 }
+                if (maddr.type & MR_WITH_PROTO)
+                {
+                    buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_IN=
ET, false));
+                }
                 buf_printf(&out, "%s", print_in_addr_t(ntohl(maddr.v4.addr=
),
                                                        (flags & MAPF_IA_EM=
PTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));
                 if (maddr.type & MR_WITH_NETBITS)
@@ -426,6 +438,10 @@

             case MR_ADDR_IPV6:
             {
+                if (maddr.type & MR_WITH_PROTO)
+                {
+                    buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_IN=
ET6, false));
+                }
                 if (IN6_IS_ADDR_V4MAPPED( &maddr.v6.addr ) )
                 {
                     buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappedv=
6.addr,
@@ -454,7 +470,6 @@
                 buf_printf(&out, "UNKNOWN");
                 break;
         }
-        buf_printf(&out, "|%d", maddr.proto);
         return BSTR(&out);
     }
     else
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 2659695..fbe102a 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -72,6 +72,9 @@
 /* Indicates than IPv4 addr was extracted from ARP packet */
 #define MR_ARP                   16

+/* Address type mask indicating that proto # is part of address */
+#define MR_WITH_PROTO            32
+
 struct mroute_addr {
     uint8_t len;    /* length of address */
     uint8_t proto;
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 62ed044..9a8b1cb 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -111,6 +111,7 @@
     ASSERT(mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.sa.s=
a_family =3D=3D AF_INET
            || mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.s=
a.sa_family =3D=3D AF_INET6
            );
+    mi->real.proto =3D mi->context.c2.link_sockets[0]->info.proto;
     if (!mroute_extract_openvpn_sockaddr(&mi->real,
                                          &mi->context.c2.link_sockets[0]->=
info.lsa->actual.dest,
                                          true))
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9c8c014..b0e1941 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -794,7 +794,6 @@
         {
             goto err;
         }
-        mi->real.proto =3D ls->info.proto;
         generate_prefix(mi);
     }

@@ -3942,7 +3941,8 @@
 }

 static int
-management_callback_kill_by_addr(void *arg, const in_addr_t addr, const in=
t port)
+management_callback_kill_by_addr(void *arg, const in_addr_t addr,
+                                 const int port, const int proto)
 {
     struct multi_context *m =3D (struct multi_context *) arg;
     struct hash_iterator hi;
@@ -3957,6 +3957,7 @@
     saddr.addr.in4.sin_port =3D htons(port);
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
+        maddr.proto =3D proto;
         hash_iterator_init(m->iter, &hi);
         while ((he =3D hash_iterator_next(&hi)))
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1
Gerrit-Change-Number: 880
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--FZ+PBliwQts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, its_Giaan, o=
rdex, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">mroute/management: fix uninitialized variable (UNINI=
T)<br><br>Fix issue reported by Coverity:<br>CID 1641564: Uninitialized var=
iables (UNINIT)<br>Using unitialized value &quot;maddr.proto&quot; when<br>=
calling &quot;mroute_addr_equal()&quot;.<br><br>Fix this by passing the pro=
to along with<br>IP:port.<br><br>While at it, changed the<br>mroute_addr_pr=
int_ex() format to display<br>the protocol only in case of MR_WITH_PROTO<br=
>avoid doing it on virtual addresses when<br>MR_WITH_PORT is not specified.=
<br><br>Change-Id: I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1<br>Signed-off-=
by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M Changes.r=
st<br>M doc/management-notes.txt<br>M src/openvpn/manage.c<br>M src/openvpn=
/manage.h<br>M src/openvpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/open=
vpn/mtcp.c<br>M src/openvpn/multi.c<br>8 files changed, 49 insertions(+), 1=
5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/80/880/4</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst</span><b=
r><span>index 16ae6fc..d01816b 100644</span><br><span>--- a/Changes.rst</sp=
an><br><span>+++ b/Changes.rst</span><br><span>@@ -317,6 +317,9 @@</span><b=
r><span>   settings will contradict the setting of allow-compression as thi=
s almost</span><br><span>   always results in a non-working connection.</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The=
 &quot;kill&quot; by addr management command now requires also the protocol=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as string e.g. &q=
uot;udp&quot;, &quot;tcp&quot;.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> Common errors with OpenSSL 3.0 and OpenVPN 2.=
6</span><br><span> ----------------------------------------------</span><br=
><span> Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable,=
 so some</span><br><span>diff --git a/doc/management-notes.txt b/doc/manage=
ment-notes.txt</span><br><span>index b55135a..f1d2930 100644</span><br><spa=
n>--- a/doc/management-notes.txt</span><br><span>+++ b/doc/management-notes=
.txt</span><br><span>@@ -205,8 +205,12 @@</span><br><span> </span><br><span=
>   kill Test-Client -- kill the client instance having a</span><br><span> =
                      common name of &quot;Test-Client&quot;.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  kill 1.2.3.4:4000 -- kill the cli=
ent instance having a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                       source address and port of 1.2.3.4:4000</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  kill tcp:1.2.3.4:4000 -- kill =
the client instance having a</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                           source address, port and proto of</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  tcp:1.2.3.4:4000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Note that kill by =
address won&#39;t work for IPv6-connected</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  clients yet, so rely on kill by CN or CID instead.<=
/span><br><span> </span><br><span> Use the &quot;status&quot; command to se=
e which clients are connected.</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 0c77f8=
5..a796dbe 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><spa=
n>+++ b/src/openvpn/manage.c</span><br><span>@@ -544,45 +544,52 @@</span><b=
r><span>         struct buffer buf;</span><br><span>         char p1[128];<=
/span><br><span>         char p2[128];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        char p3[128];</span><br><span>         int n_kil=
led;</span><br><span> </span><br><span>         buf_set_read(&amp;buf, (uin=
t8_t *) victim, strlen(victim) + 1);</span><br><span>         buf_parse(&am=
p;buf, &#39;:&#39;, p1, sizeof(p1));</span><br><span>         buf_parse(&am=
p;buf, &#39;:&#39;, p2, sizeof(p2));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        buf_parse(&amp;buf, &#39;:&#39;, p3, sizeof(p3));<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (strlen(p1) &amp;&amp; strlen(p2))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (strlen(p1) &amp;&amp; strlen(p2) &amp;&am=
p; strlen(p3))</span><br><span>         {</span><br><span>             /* I=
P:port specified */</span><br><span>             bool status;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            const in_addr_t addr =
=3D getaddr(GETADDR_HOST_ORDER|GETADDR_MSG_VIRT_OUT, p1, 0, &amp;status, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
st in_addr_t addr =3D getaddr(GETADDR_HOST_ORDER|GETADDR_MSG_VIRT_OUT, p2, =
0, &amp;status, NULL);</span><br><span>             if (status)</span><br><=
span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              const int port =3D atoi(p2);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (port &gt; 0 &amp;&amp; port &lt; 6=
5536)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  const int port =3D atoi(p3);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                const int proto =3D (streq(p1, &quot;tcp&quot;))=
 ? PROTO_TCP_SERVER :</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                  (streq(p1, &quot;udp&quot;)) ? PROTO_UD=
P : PROTO_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                if ((po=
rt &gt; 0 &amp;&amp; port &lt; 65536) &amp;&amp; (proto !=3D PROTO_NONE))</=
span><br><span>                 {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    n_killed =3D (*man-&gt;persist.callback.kil=
l_by_addr)(man-&gt;persist.callback.arg, addr, port);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    n_killed =3D (*man-&g=
t;persist.callback.kill_by_addr)(man-&gt;persist.callback.arg, addr, port, =
proto);</span><br><span>                     if (n_killed &gt; 0)</span><br=
><span>                     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        msg(M_CLIENT, &quot;SUCCESS: %d client(s) a=
t address %s:%d killed&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        msg(M_CLIENT, &quot;SUCCESS: %d client(s)=
 at address %s:%s:%d killed&quot;,</span><br><span>                        =
     n_killed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       proto2ascii(proto, AF_INET, true),</span><br><span> =
                            print_in_addr_t(addr, 0, &amp;gc),</span><br><s=
pan>                             port);</span><br><span>                   =
  }</span><br><span>                     else</span><br><span>             =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            msg(M_CLIENT, &quot;ERROR: client at address %s:%d not found&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         msg(M_CLIENT, &quot;ERROR: client at address %s:%s:%d not found&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
             proto2ascii(proto, AF_INET, true),</span><br><span>           =
                  print_in_addr_t(addr, 0, &amp;gc),</span><br><span>      =
                       port);</span><br><span>                     }</span>=
<br><span>                 }</span><br><span>                 else</span><b=
r><span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    msg(M_CLIENT, &quot;ERROR: port number is out of r=
ange: %s&quot;, p2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    msg(M_CLIENT, &quot;ERROR: port number or protocol out=
 of range: %s %s&quot;, p3, p1);</span><br><span>                 }</span><=
br><span>             }</span><br><span>             else</span><br><span> =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        msg(M_CLIENT, &quot;ERROR: error parsing IP address: %s&quot;, p1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg=
(M_CLIENT, &quot;ERROR: error parsing IP address: %s&quot;, p2);</span><br>=
<span>             }</span><br><span>         }</span><br><span>         el=
se if (strlen(p1))</span><br><span>diff --git a/src/openvpn/manage.h b/src/=
openvpn/manage.h</span><br><span>index f501543..02ceb82 100644</span><br><s=
pan>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h</=
span><br><span>@@ -180,7 +180,7 @@</span><br><span>     void (*status) (voi=
d *arg, const int version, struct status_output *so);</span><br><span>     =
void (*show_net) (void *arg, const int msglevel);</span><br><span>     int =
(*kill_by_cn) (void *arg, const char *common_name);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int (*kill_by_addr) (void *arg, const i=
n_addr_t addr, const int port);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int (*kill_by_addr) (void *arg, const in_addr_t addr, const=
 int port, const int proto);</span><br><span>     void (*delete_event) (voi=
d *arg, event_t event);</span><br><span>     int (*n_clients) (void *arg);<=
/span><br><span>     bool (*send_cc_message) (void *arg, const char *messag=
e, const char *parameter);</span><br><span>diff --git a/src/openvpn/mroute.=
c b/src/openvpn/mroute.c</span><br><span>index 74923cf..24b9543 100644</spa=
n><br><span>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mr=
oute.c</span><br><span>@@ -276,6 +276,10 @@</span><br><span>               =
  addr-&gt;len =3D 6;</span><br><span>                 addr-&gt;v4.addr =3D=
 osaddr-&gt;addr.in4.sin_addr.s_addr;</span><br><span>                 addr=
-&gt;v4.port =3D osaddr-&gt;addr.in4.sin_port;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                if (addr-&gt;proto !=3D PROTO_NO=
NE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  addr-&gt;type |=3D MR_WITH_PROTO;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                }</span><br><span>             }</span><br>=
<span>             else</span><br><span>             {</span><br><span>@@ -=
295,6 +299,10 @@</span><br><span>                 addr-&gt;len =3D 18;</spa=
n><br><span>                 addr-&gt;v6.addr =3D osaddr-&gt;addr.in6.sin6_=
addr;</span><br><span>                 addr-&gt;v6.port =3D osaddr-&gt;addr=
.in6.sin6_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            if (addr-&gt;proto !=3D PROTO_NONE)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    addr-&gt;type |=3D MR_WITH_PR=
OTO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 }</span><br><span>             }</span><br><span>             else</span><=
br><span>             {</span><br><span>@@ -403,6 +411,10 @@</span><br><spa=
n>                 {</span><br><span>                     buf_printf(&amp;o=
ut, &quot;ARP/&quot;);</span><br><span>                 }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if (maddr.type &amp; =
MR_WITH_PROTO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             buf_printf(&amp;out, &quot;%s:&quot;, proto2ascii(maddr.proto,=
 AF_INET, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span>                 buf_printf(&amp;out, &quo=
t;%s&quot;, print_in_addr_t(ntohl(maddr.v4.addr),</span><br><span>         =
                                               (flags &amp; MAPF_IA_EMPTY_I=
F_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));</span><br><span>                 if=
 (maddr.type &amp; MR_WITH_NETBITS)</span><br><span>@@ -426,6 +438,10 @@</s=
pan><br><span> </span><br><span>             case MR_ADDR_IPV6:</span><br><=
span>             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if (maddr.type &amp; MR_WITH_PROTO)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    buf_printf(&amp;out, =
&quot;%s:&quot;, proto2ascii(maddr.proto, AF_INET6, false));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span>=
                 if (IN6_IS_ADDR_V4MAPPED( &amp;maddr.v6.addr ) )</span><br=
><span>                 {</span><br><span>                     buf_printf(&=
amp;out, &quot;%s&quot;, print_in_addr_t(maddr.v4mappedv6.addr,</span><br><=
span>@@ -454,7 +470,6 @@</span><br><span>                 buf_printf(&amp;o=
ut, &quot;UNKNOWN&quot;);</span><br><span>                 break;</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    buf_printf(&amp;out, &quot;|%d&quot;, maddr.proto);</span><br><span>   =
      return BSTR(&amp;out);</span><br><span>     }</span><br><span>     el=
se</span><br><span>diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h=
</span><br><span>index 2659695..fbe102a 100644</span><br><span>--- a/src/op=
envpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h</span><br><span>@=
@ -72,6 +72,9 @@</span><br><span> /* Indicates than IPv4 addr was extracted=
 from ARP packet */</span><br><span> #define MR_ARP                   16</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A=
ddress type mask indicating that proto # is part of address */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define MR_WITH_PROTO           =
 32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> struct mroute_addr {</span><br><span>     uint8_t len;    /* length of ad=
dress */</span><br><span>     uint8_t proto;</span><br><span>diff --git a/s=
rc/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 62ed044..9a8b1=
cb 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/sr=
c/openvpn/mtcp.c</span><br><span>@@ -111,6 +111,7 @@</span><br><span>     A=
SSERT(mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest.addr.s=
a.sa_family =3D=3D AF_INET</span><br><span>            || mi-&gt;context.c2=
.link_sockets[0]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_I=
NET6</span><br><span>            );</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    mi-&gt;real.proto =3D mi-&gt;context.c2.link_sockets[0]=
-&gt;info.proto;</span><br><span>     if (!mroute_extract_openvpn_sockaddr(=
&amp;mi-&gt;real,</span><br><span>                                         =
 &amp;mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest,</span=
><br><span>                                          true))</span><br><span=
>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>ind=
ex 9c8c014..b0e1941 100644</span><br><span>--- a/src/openvpn/multi.c</span>=
<br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -794,7 +794,6 @@</sp=
an><br><span>         {</span><br><span>             goto err;</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 mi-&gt;real.proto =3D ls-&gt;info.proto;</span><br><span>         generate=
_prefix(mi);</span><br><span>     }</span><br><span> </span><br><span>@@ -3=
942,7 +3941,8 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_call=
back_kill_by_addr(void *arg, const in_addr_t addr, const int port)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+management_callback_kill_by_=
addr(void *arg, const in_addr_t addr,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                 const int port, const in=
t proto)</span><br><span> {</span><br><span>     struct multi_context *m =
=3D (struct multi_context *) arg;</span><br><span>     struct hash_iterator=
 hi;</span><br><span>@@ -3957,6 +3957,7 @@</span><br><span>     saddr.addr.=
in4.sin_port =3D htons(port);</span><br><span>     if (mroute_extract_openv=
pn_sockaddr(&amp;maddr, &amp;saddr, true))</span><br><span>     {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        maddr.proto =3D proto=
;</span><br><span>         hash_iterator_init(m-&gt;iter, &amp;hi);</span><=
br><span>         while ((he =3D hash_iterator_next(&amp;hi)))</span><br><s=
pan>         {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail">change 880</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/880?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd31=
78eee1f60fff1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 880 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FZ+PBliwQts=--

