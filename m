From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 18:47:31 +0000
In-Reply-To: <gerrit.1761570487000.I750a0b8107baa77fb14558d0c8e4ef8020d62efd@...2715...>
References: <gerrit.1761570487000.I750a0b8107baa77fb14558d0c8e4ef8020d62efd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0633ceb6c439f653b5d2236baae31b75ae8dd99d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sPyaT3OSKNw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Change
 kill_by_addr to use better types for port/proto
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sPyaT3OSKNw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
10?usp=3Demail )

Change subject: manage: Change kill_by_addr to use better types for port/pr=
oto
......................................................................

manage: Change kill_by_addr to use better types for port/proto

Change-Id: I750a0b8107baa77fb14558d0c8e4ef8020d62efd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1310
Message-Id: <20251030182922.26448-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
054.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/socket.h
4 files changed, 8 insertions(+), 8 deletions(-)




diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 685b137..e46b5f2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -608,14 +608,14 @@
             if (status)
             {
                 const int port =3D atoi(p3);
-                const int proto =3D (streq(p1, "tcp"))   ? PROTO_TCP_SERVER
-                                  : (streq(p1, "udp")) ? PROTO_UDP
-                                                       : PROTO_NONE;
+                const uint8_t proto =3D (streq(p1, "tcp"))   ? PROTO_TCP_S=
ERVER
+                                      : (streq(p1, "udp")) ? PROTO_UDP
+                                                           : PROTO_NONE;

-                if ((port > 0 && port < 65536) && (proto !=3D PROTO_NONE))
+                if ((port > 0 && port < UINT16_MAX) && (proto !=3D PROTO_N=
ONE))
                 {
                     n_killed =3D (*man->persist.callback.kill_by_addr)(man=
->persist.callback.arg,
-                                                                     addr,=
 port, proto);
+                                                                     addr,=
 (uint16_t)port, proto);
                     if (n_killed > 0)
                     {
                         msg(M_CLIENT, "SUCCESS: %d client(s) at address %s=
:%s:%d killed", n_killed,
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index fe460bf..dedcc15 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -178,7 +178,7 @@
     void (*status)(void *arg, const int version, struct status_output *so);
     void (*show_net)(void *arg, const msglvl_t msglevel);
     int (*kill_by_cn)(void *arg, const char *common_name);
-    int (*kill_by_addr)(void *arg, const in_addr_t addr, const int port, c=
onst int proto);
+    int (*kill_by_addr)(void *arg, const in_addr_t addr, const uint16_t po=
rt, const uint8_t proto);
     void (*delete_event)(void *arg, event_t event);
     int (*n_clients)(void *arg);
     bool (*send_cc_message)(void *arg, const char *message, const char *pa=
rameter);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e243843..261209d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3937,7 +3937,7 @@
 }

 static int
-management_callback_kill_by_addr(void *arg, const in_addr_t addr, const in=
t port, const int proto)
+management_callback_kill_by_addr(void *arg, const in_addr_t addr, const ui=
nt16_t port, const uint8_t proto)
 {
     struct multi_context *m =3D (struct multi_context *)arg;
     struct hash_iterator hi;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e986c9c..832d62e 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -89,7 +89,7 @@
     const char *ipchange_command;
     const struct plugin_list *plugins;
     bool remote_float;
-    int proto;       /* Protocol (PROTO_x defined below) */
+    uint8_t proto;   /* Protocol (PROTO_x defined below) */
     sa_family_t af;  /* Address family like AF_INET, AF_INET6 or AF_UNSPEC=
*/
     bool bind_ipv6_only;
     int mtu_changed; /* Set to true when mtu value is changed */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I750a0b8107baa77fb14558d0c8e4ef8020d62efd
Gerrit-Change-Number: 1310
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sPyaT3OSKNw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1310?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">manage: Change kill_by_addr to use better types =
for port/proto<br><br>Change-Id: I750a0b8107baa77fb14558d0c8e4ef8020d62efd<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: G=
ert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.n=
et/c/openvpn/+/1310<br>Message-Id: &lt;20251030182922.26448-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg34054.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/=
multi.c<br>M src/openvpn/socket.h<br>4 files changed, 8 insertions(+), 8 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 685b137..e46b5f2 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -608,14 +608,1=
4 @@</span><br><span>             if (status)</span><br><span>             =
{</span><br><span>                 const int port =3D atoi(p3);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                const int proto =
=3D (streq(p1, &quot;tcp&quot;))   ? PROTO_TCP_SERVER</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                  : (streq(=
p1, &quot;udp&quot;)) ? PROTO_UDP</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                                       : PROTO_=
NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  const uint8_t proto =3D (streq(p1, &quot;tcp&quot;))   ? PROTO_TCP_SERVER=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                   : (streq(p1, &quot;udp&quot;)) ? PROTO_UDP</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
                          : PROTO_NONE;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                if ((port &gt; 0 &amp;&=
amp; port &lt; 65536) &amp;&amp; (proto !=3D PROTO_NONE))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if ((port &gt; 0 &amp=
;&amp; port &lt; UINT16_MAX) &amp;&amp; (proto !=3D PROTO_NONE))</span><br>=
<span>                 {</span><br><span>                     n_killed =3D =
(*man-&gt;persist.callback.kill_by_addr)(man-&gt;persist.callback.arg,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
                                           addr, port, proto);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
                                     addr, (uint16_t)port, proto);</span><b=
r><span>                     if (n_killed &gt; 0)</span><br><span>         =
            {</span><br><span>                         msg(M_CLIENT, &quot;=
SUCCESS: %d client(s) at address %s:%s:%d killed&quot;, n_killed,</span><br=
><span>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h</span><br><=
span>index fe460bf..dedcc15 100644</span><br><span>--- a/src/openvpn/manage=
.h</span><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@ -178,7 +17=
8,7 @@</span><br><span>     void (*status)(void *arg, const int version, st=
ruct status_output *so);</span><br><span>     void (*show_net)(void *arg, c=
onst msglvl_t msglevel);</span><br><span>     int (*kill_by_cn)(void *arg, =
const char *common_name);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int (*kill_by_addr)(void *arg, const in_addr_t addr, const int port=
, const int proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int (*kill_by_addr)(void *arg, const in_addr_t addr, const uint16_t por=
t, const uint8_t proto);</span><br><span>     void (*delete_event)(void *ar=
g, event_t event);</span><br><span>     int (*n_clients)(void *arg);</span>=
<br><span>     bool (*send_cc_message)(void *arg, const char *message, cons=
t char *parameter);</span><br><span>diff --git a/src/openvpn/multi.c b/src/=
openvpn/multi.c</span><br><span>index e243843..261209d 100644</span><br><sp=
an>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</spa=
n><br><span>@@ -3937,7 +3937,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-management_callback_kill_by_addr(void *arg, const in_addr_t addr, const i=
nt port, const int proto)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+management_callback_kill_by_addr(void *arg, const in_addr_t addr, con=
st uint16_t port, const uint8_t proto)</span><br><span> {</span><br><span> =
    struct multi_context *m =3D (struct multi_context *)arg;</span><br><spa=
n>     struct hash_iterator hi;</span><br><span>diff --git a/src/openvpn/so=
cket.h b/src/openvpn/socket.h</span><br><span>index e986c9c..832d62e 100644=
</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openv=
pn/socket.h</span><br><span>@@ -89,7 +89,7 @@</span><br><span>     const ch=
ar *ipchange_command;</span><br><span>     const struct plugin_list *plugin=
s;</span><br><span>     bool remote_float;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int proto;       /* Protocol (PROTO_x defined belo=
w) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t pr=
oto;   /* Protocol (PROTO_x defined below) */</span><br><span>     sa_famil=
y_t af;  /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/</span><br>=
<span>     bool bind_ipv6_only;</span><br><span>     int mtu_changed; /* Se=
t to true when mtu value is changed */</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3D=
email">change 1310</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I750a0b8107baa77fb14558d0c8e=
4ef8020d62efd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1310 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--sPyaT3OSKNw=--

