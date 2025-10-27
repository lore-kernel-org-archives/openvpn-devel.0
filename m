From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 13:08:16 +0000
References: <gerrit.1761570487000.I750a0b8107baa77fb14558d0c8e4ef8020d62efd@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <65ded91f0a93b6bdedfdd9f06eb9f6fbf8c539ea-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ECWQYjTYCJk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ECWQYjTYCJk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3Demail

to review the following change.


Change subject: manage: Change kill_by_addr to use better types for port/pr=
oto
......................................................................

manage: Change kill_by_addr to use better types for port/proto

Change-Id: I750a0b8107baa77fb14558d0c8e4ef8020d62efd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/socket.h
4 files changed, 8 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1310/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1cb5c63..823e46a 100644
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
index a31eb06..1a14c9d 100644
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
index fa9c654..ad5004e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3952,7 +3952,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I750a0b8107baa77fb14558d0c8e4ef8020d62efd
Gerrit-Change-Number: 1310
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ECWQYjTYCJk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1310?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">manage: Change kill_by_addr to use better t=
ypes for port/proto<br><br>Change-Id: I750a0b8107baa77fb14558d0c8e4ef8020d6=
2efd<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br=
>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/multi.c<=
br>M src/openvpn/socket.h<br>4 files changed, 8 insertions(+), 8 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/10/1310/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/o=
penvpn/manage.c</span><br><span>index 1cb5c63..823e46a 100644</span><br><sp=
an>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</s=
pan><br><span>@@ -608,14 +608,14 @@</span><br><span>             if (status=
)</span><br><span>             {</span><br><span>                 const int=
 port =3D atoi(p3);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              const int proto =3D (streq(p1, &quot;tcp&quot;))   ? PROTO_TC=
P_SERVER</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                     : (streq(p1, &quot;udp&quot;)) ? PROTO_UDP</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
                      : PROTO_NONE;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                const uint8_t proto =3D (streq(p1, &quot;tc=
p&quot;))   ? PROTO_TCP_SERVER</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                      : (streq(p1, &quot;udp&quo=
t;)) ? PROTO_UDP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                                        : PROTO_NONE;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       if ((port &gt; 0 &amp;&amp; port &lt; 65536) &amp;&amp; (proto !=3D =
PROTO_NONE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         if ((port &gt; 0 &amp;&amp; port &lt; UINT16_MAX) &amp;&amp; (prot=
o !=3D PROTO_NONE))</span><br><span>                 {</span><br><span>    =
                 n_killed =3D (*man-&gt;persist.callback.kill_by_addr)(man-=
&gt;persist.callback.arg,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                                                     ad=
dr, port, proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                                                   addr, (u=
int16_t)port, proto);</span><br><span>                     if (n_killed &gt=
; 0)</span><br><span>                     {</span><br><span>               =
          msg(M_CLIENT, &quot;SUCCESS: %d client(s) at address %s:%s:%d kil=
led&quot;, n_killed,</span><br><span>diff --git a/src/openvpn/manage.h b/sr=
c/openvpn/manage.h</span><br><span>index a31eb06..1a14c9d 100644</span><br>=
<span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h=
</span><br><span>@@ -178,7 +178,7 @@</span><br><span>     void (*status)(vo=
id *arg, const int version, struct status_output *so);</span><br><span>    =
 void (*show_net)(void *arg, const msglvl_t msglevel);</span><br><span>    =
 int (*kill_by_cn)(void *arg, const char *common_name);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int (*kill_by_addr)(void *arg, const =
in_addr_t addr, const int port, const int proto);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int (*kill_by_addr)(void *arg, const in_a=
ddr_t addr, const uint16_t port, const uint8_t proto);</span><br><span>    =
 void (*delete_event)(void *arg, event_t event);</span><br><span>     int (=
*n_clients)(void *arg);</span><br><span>     bool (*send_cc_message)(void *=
arg, const char *message, const char *parameter);</span><br><span>diff --gi=
t a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index fa9c654=
..ad5004e 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>=
+++ b/src/openvpn/multi.c</span><br><span>@@ -3952,7 +3952,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-management_callback_kill_by_addr(void *arg,=
 const in_addr_t addr, const int port, const int proto)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+management_callback_kill_by_addr(void *=
arg, const in_addr_t addr, const uint16_t port, const uint8_t proto)</span>=
<br><span> {</span><br><span>     struct multi_context *m =3D (struct multi=
_context *)arg;</span><br><span>     struct hash_iterator hi;</span><br><sp=
an>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span=
>index e986c9c..832d62e 100644</span><br><span>--- a/src/openvpn/socket.h</=
span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -89,7 +89,7 @@=
</span><br><span>     const char *ipchange_command;</span><br><span>     co=
nst struct plugin_list *plugins;</span><br><span>     bool remote_float;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int proto;       /* =
Protocol (PROTO_x defined below) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint8_t proto;   /* Protocol (PROTO_x defined below) */=
</span><br><span>     sa_family_t af;  /* Address family like AF_INET, AF_I=
NET6 or AF_UNSPEC*/</span><br><span>     bool bind_ipv6_only;</span><br><sp=
an>     int mtu_changed; /* Set to true when mtu value is changed */</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1310?usp=3Demail">change 1310</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1310?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I750a0b8107baa77fb14558d0c8e=
4ef8020d62efd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1310 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ECWQYjTYCJk=--

