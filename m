From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 13:57:52 +0000
References: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e4c4a200aa5e5ed61e748d4d5fbc7c0ecf8bbdfb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E8nRXA9THms="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute/management:
 fix unitialized variable (UNINIT)
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

--E8nRXA9THms=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail

to review the following change.


Change subject: mroute/management: fix unitialized variable (UNINIT)
......................................................................

mroute/management: fix unitialized variable (UNINIT)

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
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/multi.c
7 files changed, 37 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/880/1

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
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0c77f85..037945c 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -544,13 +544,15 @@
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
@@ -558,21 +560,23 @@
             if (status)
             {
                 const int port =3D atoi(p2);
+                const int proto =3D (streq(p3, "tcp")) ? PROTO_TCP_SERVER =
: ascii2proto(p3);
+
                 if (port > 0 && port < 65536)
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
:%d:%s killed",
                             n_killed,
                             print_in_addr_t(addr, 0, &gc),
-                            port);
+                            port, p3);
                     }
                     else
                     {
-                        msg(M_CLIENT, "ERROR: client at address %s:%d not =
found",
+                        msg(M_CLIENT, "ERROR: client at address %s:%d:%s n=
ot found",
                             print_in_addr_t(addr, 0, &gc),
-                            port);
+                            port, p3);
                     }
                 }
                 else
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
index 74923cf..45777e4 100644
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
+                if ((maddr.type & MR_WITH_PROTO))
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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--E8nRXA9THms=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">mroute/management: fix unitialized variable (UNINIT)<br><br>F=
ix issue reported by Coverity:<br>CID 1641564: Uninitialized variables (UNI=
NIT)<br>Using unitialized value &quot;maddr.proto&quot; when<br>calling &qu=
ot;mroute_addr_equal()&quot;.<br><br>Fix this by passing the proto along wi=
th<br>IP:port.<br><br>While at it, changed the<br>mroute_addr_print_ex() fo=
rmat to display<br>the protocol only in case of MR_WITH_PROTO<br>avoid doin=
g it on virtual addresses when<br>MR_WITH_PORT is not specified.<br><br>Cha=
nge-Id: I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1<br>Signed-off-by: Gianmar=
co De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M Changes.rst<br>M src=
/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/mroute.c<br>M =
src/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/multi.c<br>7 =
files changed, 37 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/80/880/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
Changes.rst b/Changes.rst</span><br><span>index 16ae6fc..d01816b 100644</sp=
an><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br>=
<span>@@ -317,6 +317,9 @@</span><br><span>   settings will contradict the s=
etting of allow-compression as this almost</span><br><span>   always result=
s in a non-working connection.</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+- The &quot;kill&quot; by addr management comm=
and now requires also the protocol</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  as string e.g. &quot;udp&quot;, &quot;tcp&quot;.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Common erro=
rs with OpenSSL 3.0 and OpenVPN 2.6</span><br><span> ----------------------=
------------------------</span><br><span> Both OpenVPN 2.6 and OpenSSL 3.0 =
tighten the security considerable, so some</span><br><span>diff --git a/src=
/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 0c77f85..037=
945c 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ =
b/src/openvpn/manage.c</span><br><span>@@ -544,13 +544,15 @@</span><br><spa=
n>         struct buffer buf;</span><br><span>         char p1[128];</span>=
<br><span>         char p2[128];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        char p3[128];</span><br><span>         int n_killed;</=
span><br><span> </span><br><span>         buf_set_read(&amp;buf, (uint8_t *=
) victim, strlen(victim) + 1);</span><br><span>         buf_parse(&amp;buf,=
 &#39;:&#39;, p1, sizeof(p1));</span><br><span>         buf_parse(&amp;buf,=
 &#39;:&#39;, p2, sizeof(p2));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_parse(&amp;buf, &#39;:&#39;, p3, sizeof(p3));</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (strlen(p1) &amp;&amp; strlen(p2))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (strlen(p1) &amp;&amp; strlen(p2) &amp;&amp; str=
len(p3))</span><br><span>         {</span><br><span>             /* IP:port=
 specified */</span><br><span>             bool status;</span><br><span>@@ =
-558,21 +560,23 @@</span><br><span>             if (status)</span><br><span=
>             {</span><br><span>                 const int port =3D atoi(p2=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c=
onst int proto =3D (streq(p3, &quot;tcp&quot;)) ? PROTO_TCP_SERVER : ascii2=
proto(p3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>                 if (port &gt; 0 &amp;&amp; port &lt; 65536)</span>=
<br><span>                 {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    n_killed =3D (*man-&gt;persist.callback.kill_by_=
addr)(man-&gt;persist.callback.arg, addr, port);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    n_killed =3D (*man-&gt;per=
sist.callback.kill_by_addr)(man-&gt;persist.callback.arg, addr, port, proto=
);</span><br><span>                     if (n_killed &gt; 0)</span><br><spa=
n>                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        msg(M_CLIENT, &quot;SUCCESS: %d client(s) at add=
ress %s:%d killed&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        msg(M_CLIENT, &quot;SUCCESS: %d client(s) at a=
ddress %s:%d:%s killed&quot;,</span><br><span>                             =
n_killed,</span><br><span>                             print_in_addr_t(addr=
, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                     port);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            port, p3);</span><br><span>            =
         }</span><br><span>                     else</span><br><span>      =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   msg(M_CLIENT, &quot;ERROR: client at address %s:%d not f=
ound&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                msg(M_CLIENT, &quot;ERROR: client at address %s:%d:%s not f=
ound&quot;,</span><br><span>                             print_in_addr_t(ad=
dr, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                       port);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            port, p3);</span><br><span>          =
           }</span><br><span>                 }</span><br><span>           =
      else</span><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/=
manage.h</span><br><span>index f501543..02ceb82 100644</span><br><span>--- =
a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br=
><span>@@ -180,7 +180,7 @@</span><br><span>     void (*status) (void *arg, =
const int version, struct status_output *so);</span><br><span>     void (*s=
how_net) (void *arg, const int msglevel);</span><br><span>     int (*kill_b=
y_cn) (void *arg, const char *common_name);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int (*kill_by_addr) (void *arg, const in_addr_t a=
ddr, const int port);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int (*kill_by_addr) (void *arg, const in_addr_t addr, const int port,=
 const int proto);</span><br><span>     void (*delete_event) (void *arg, ev=
ent_t event);</span><br><span>     int (*n_clients) (void *arg);</span><br>=
<span>     bool (*send_cc_message) (void *arg, const char *message, const c=
har *parameter);</span><br><span>diff --git a/src/openvpn/mroute.c b/src/op=
envpn/mroute.c</span><br><span>index 74923cf..45777e4 100644</span><br><spa=
n>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</sp=
an><br><span>@@ -276,6 +276,10 @@</span><br><span>                 addr-&gt=
;len =3D 6;</span><br><span>                 addr-&gt;v4.addr =3D osaddr-&g=
t;addr.in4.sin_addr.s_addr;</span><br><span>                 addr-&gt;v4.po=
rt =3D osaddr-&gt;addr.in4.sin_port;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                if (addr-&gt;proto !=3D PROTO_NONE)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    addr-&gt=
;type |=3D MR_WITH_PROTO;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                }</span><br><span>             }</span><br><span>    =
         else</span><br><span>             {</span><br><span>@@ -295,6 +299=
,10 @@</span><br><span>                 addr-&gt;len =3D 18;</span><br><spa=
n>                 addr-&gt;v6.addr =3D osaddr-&gt;addr.in6.sin6_addr;</spa=
n><br><span>                 addr-&gt;v6.port =3D osaddr-&gt;addr.in6.sin6_=
port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  if (addr-&gt;proto !=3D PROTO_NONE)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    addr-&gt;type |=3D MR_WITH_PROTO;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><=
br><span>             }</span><br><span>             else</span><br><span> =
            {</span><br><span>@@ -403,6 +411,10 @@</span><br><span>        =
         {</span><br><span>                     buf_printf(&amp;out, &quot;=
ARP/&quot;);</span><br><span>                 }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                if (maddr.type &amp; MR_WITH_PR=
OTO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   buf_printf(&amp;out, &quot;%s:&quot;, proto2ascii(maddr.proto, AF_INET, =
false));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     }</span><br><span>                 buf_printf(&amp;out, &quot;%s&quot;=
, print_in_addr_t(ntohl(maddr.v4.addr),</span><br><span>                   =
                                     (flags &amp; MAPF_IA_EMPTY_IF_UNDEF) ?=
 IA_EMPTY_IF_UNDEF : 0, gc));</span><br><span>                 if (maddr.ty=
pe &amp; MR_WITH_NETBITS)</span><br><span>@@ -426,6 +438,10 @@</span><br><s=
pan> </span><br><span>             case MR_ADDR_IPV6:</span><br><span>     =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      if ((maddr.type &amp; MR_WITH_PROTO))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    buf_printf(&amp;out, &quot;%s:&qu=
ot;, proto2ascii(maddr.proto, AF_INET6, false));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                }</span><br><span>            =
     if (IN6_IS_ADDR_V4MAPPED( &amp;maddr.v6.addr ) )</span><br><span>     =
            {</span><br><span>                     buf_printf(&amp;out, &qu=
ot;%s&quot;, print_in_addr_t(maddr.v4mappedv6.addr,</span><br><span>@@ -454=
,7 +470,6 @@</span><br><span>                 buf_printf(&amp;out, &quot;UN=
KNOWN&quot;);</span><br><span>                 break;</span><br><span>     =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_prin=
tf(&amp;out, &quot;|%d&quot;, maddr.proto);</span><br><span>         return=
 BSTR(&amp;out);</span><br><span>     }</span><br><span>     else</span><br=
><span>diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><=
span>index 2659695..fbe102a 100644</span><br><span>--- a/src/openvpn/mroute=
.h</span><br><span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -72,6 +72,=
9 @@</span><br><span> /* Indicates than IPv4 addr was extracted from ARP pa=
cket */</span><br><span> #define MR_ARP                   16</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Address type =
mask indicating that proto # is part of address */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define MR_WITH_PROTO            32</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct mro=
ute_addr {</span><br><span>     uint8_t len;    /* length of address */</sp=
an><br><span>     uint8_t proto;</span><br><span>diff --git a/src/openvpn/m=
tcp.c b/src/openvpn/mtcp.c</span><br><span>index 62ed044..9a8b1cb 100644</s=
pan><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mt=
cp.c</span><br><span>@@ -111,6 +111,7 @@</span><br><span>     ASSERT(mi-&gt=
;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =
=3D=3D AF_INET</span><br><span>            || mi-&gt;context.c2.link_socket=
s[0]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_INET6</span><=
br><span>            );</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    mi-&gt;real.proto =3D mi-&gt;context.c2.link_sockets[0]-&gt;info.pr=
oto;</span><br><span>     if (!mroute_extract_openvpn_sockaddr(&amp;mi-&gt;=
real,</span><br><span>                                          &amp;mi-&gt=
;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest,</span><br><span> =
                                         true))</span><br><span>diff --git =
a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 9c8c014..=
b0e1941 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>++=
+ b/src/openvpn/multi.c</span><br><span>@@ -794,7 +794,6 @@</span><br><span=
>         {</span><br><span>             goto err;</span><br><span>        =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;real=
.proto =3D ls-&gt;info.proto;</span><br><span>         generate_prefix(mi);=
</span><br><span>     }</span><br><span> </span><br><span>@@ -3942,7 +3941,=
8 @@</span><br><span> }</span><br><span> </span><br><span> static int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-management_callback_kill_by=
_addr(void *arg, const in_addr_t addr, const int port)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+management_callback_kill_by_addr(void *a=
rg, const in_addr_t addr,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 const int port, const int proto)</sp=
an><br><span> {</span><br><span>     struct multi_context *m =3D (struct mu=
lti_context *) arg;</span><br><span>     struct hash_iterator hi;</span><br=
><span>@@ -3957,6 +3957,7 @@</span><br><span>     saddr.addr.in4.sin_port =
=3D htons(port);</span><br><span>     if (mroute_extract_openvpn_sockaddr(&=
amp;maddr, &amp;saddr, true))</span><br><span>     {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        maddr.proto =3D proto;</span><br>=
<span>         hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><span>   =
      while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span>        =
 {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/880?usp=3Demail">change 880</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/880?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd31=
78eee1f60fff1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 880 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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


--E8nRXA9THms=--

