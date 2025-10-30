From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 18:47:29 +0000
In-Reply-To: <gerrit.1761570487000.I750a0b8107baa77fb14558d0c8e4ef8020d62efd@...2715...>
References: <gerrit.1761570487000.I750a0b8107baa77fb14558d0c8e4ef8020d62efd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0633ceb6c439f653b5d2236baae31b75ae8dd99d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZMa3AyjBpME="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZMa3AyjBpME=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1310/4

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I750a0b8107baa77fb14558d0c8e4ef8020d62efd
Gerrit-Change-Number: 1310
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZMa3AyjBpME=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">manage: Change kill_by_addr to use =
better types for port/proto<br><br>Change-Id: I750a0b8107baa77fb14558d0c8e4=
ef8020d62efd<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://ger=
rit.openvpn.net/c/openvpn/+/1310<br>Message-Id: &lt;20251030182922.26448-1-=
gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg34054.html<br>Signed-off-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>---<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M=
 src/openvpn/multi.c<br>M src/openvpn/socket.h<br>4 files changed, 8 insert=
ions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/10/1310/4</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 685b137..e46b5f2=
 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/sr=
c/openvpn/manage.c</span><br><span>@@ -608,14 +608,14 @@</span><br><span>  =
           if (status)</span><br><span>             {</span><br><span>     =
            const int port =3D atoi(p3);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                const int proto =3D (streq(p1, &quot;tcp=
&quot;))   ? PROTO_TCP_SERVER</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                  : (streq(p1, &quot;udp&quot;)) ? =
PROTO_UDP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                                           : PROTO_NONE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                const uint8_t proto =
=3D (streq(p1, &quot;tcp&quot;))   ? PROTO_TCP_SERVER</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                      : (=
streq(p1, &quot;udp&quot;)) ? PROTO_UDP</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                                       =
    : PROTO_NONE;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                if ((port &gt; 0 &amp;&amp; port &lt; 65536) =
&amp;&amp; (proto !=3D PROTO_NONE))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                if ((port &gt; 0 &amp;&amp; port &lt; UINT1=
6_MAX) &amp;&amp; (proto !=3D PROTO_NONE))</span><br><span>                =
 {</span><br><span>                     n_killed =3D (*man-&gt;persist.call=
back.kill_by_addr)(man-&gt;persist.callback.arg,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                                =
                     addr, port, proto);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                                      =
               addr, (uint16_t)port, proto);</span><br><span>              =
       if (n_killed &gt; 0)</span><br><span>                     {</span><b=
r><span>                         msg(M_CLIENT, &quot;SUCCESS: %d client(s) =
at address %s:%s:%d killed&quot;, n_killed,</span><br><span>diff --git a/sr=
c/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>index fe460bf..de=
dcc15 100644</span><br><span>--- a/src/openvpn/manage.h</span><br><span>+++=
 b/src/openvpn/manage.h</span><br><span>@@ -178,7 +178,7 @@</span><br><span=
>     void (*status)(void *arg, const int version, struct status_output *so=
);</span><br><span>     void (*show_net)(void *arg, const msglvl_t msglevel=
);</span><br><span>     int (*kill_by_cn)(void *arg, const char *common_nam=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int (*kill_by_=
addr)(void *arg, const in_addr_t addr, const int port, const int proto);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int (*kill_by_addr=
)(void *arg, const in_addr_t addr, const uint16_t port, const uint8_t proto=
);</span><br><span>     void (*delete_event)(void *arg, event_t event);</sp=
an><br><span>     int (*n_clients)(void *arg);</span><br><span>     bool (*=
send_cc_message)(void *arg, const char *message, const char *parameter);</s=
pan><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span>=
<br><span>index e243843..261209d 100644</span><br><span>--- a/src/openvpn/m=
ulti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3937,7=
 +3937,7 @@</span><br><span> }</span><br><span> </span><br><span> static in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_callback_=
kill_by_addr(void *arg, const in_addr_t addr, const int port, const int pro=
to)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_callb=
ack_kill_by_addr(void *arg, const in_addr_t addr, const uint16_t port, cons=
t uint8_t proto)</span><br><span> {</span><br><span>     struct multi_conte=
xt *m =3D (struct multi_context *)arg;</span><br><span>     struct hash_ite=
rator hi;</span><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/s=
ocket.h</span><br><span>index e986c9c..832d62e 100644</span><br><span>--- a=
/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br>=
<span>@@ -89,7 +89,7 @@</span><br><span>     const char *ipchange_command;<=
/span><br><span>     const struct plugin_list *plugins;</span><br><span>   =
  bool remote_float;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int proto;       /* Protocol (PROTO_x defined below) */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint8_t proto;   /* Protocol (PR=
OTO_x defined below) */</span><br><span>     sa_family_t af;  /* Address fa=
mily like AF_INET, AF_INET6 or AF_UNSPEC*/</span><br><span>     bool bind_i=
pv6_only;</span><br><span>     int mtu_changed; /* Set to true when mtu val=
ue is changed */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3Demail">change 1310</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--ZMa3AyjBpME=--

