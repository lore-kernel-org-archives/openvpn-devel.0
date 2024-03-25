From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 25 Mar 2024 17:23:01 +0000
In-Reply-To: <gerrit.1704798536000.I8ef199463d46303129a3f563fd9eace780a58b8a@...2715...>
References: <gerrit.1704798536000.I8ef199463d46303129a3f563fd9eace780a58b8a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d1a421e0ab281465dd63bc94495af79c40badb68-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OZ3KarlTi0g="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: phase2_tcp_server:
 fix Coverity issue 'Dereference after null check'
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

--OZ3KarlTi0g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/49=
0?usp=3Demail )

Change subject: phase2_tcp_server: fix Coverity issue 'Dereference after nu=
ll check'
......................................................................

phase2_tcp_server: fix Coverity issue 'Dereference after null check'

As Coverity says:
Either the check against null is unnecessary, or there may be a null
pointer dereference.
In phase2_tcp_server: Pointer is checked against null but then
dereferenced anyway

There is only one caller (link_socket_init_phase2) and it already has
an ASSERT(sig_info). So use that here was well.

v2:
 - fix cleanly by actually asserting that sig_info is defined

Change-Id: I8ef199463d46303129a3f563fd9eace780a58b8a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240325071448.12143-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
452.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 3 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 57eaee2..d2b82d5 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2005,7 +2005,8 @@
 phase2_tcp_server(struct link_socket *sock, const char *remote_dynamic,
                   struct signal_info *sig_info)
 {
-    volatile int *signal_received =3D sig_info ? &sig_info->signal_receive=
d : NULL;
+    ASSERT(sig_info);
+    volatile int *signal_received =3D &sig_info->signal_received;
     switch (sock->mode)
     {
         case LS_MODE_DEFAULT:
@@ -2031,7 +2032,7 @@
                                         false);
             if (!socket_defined(sock->sd))
             {
-                register_signal(sig_info, SIGTERM, "socket-undefiled");
+                register_signal(sig_info, SIGTERM, "socket-undefined");
                 return;
             }
             tcp_connection_established(&sock->info.lsa->actual);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/490?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8ef199463d46303129a3f563fd9eace780a58b8a
Gerrit-Change-Number: 490
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--OZ3KarlTi0g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/490?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">phase2_tcp_server: fix Coverity issue &#39;Der=
eference after null check&#39;<br><br>As Coverity says:<br>Either the check=
 against null is unnecessary, or there may be a null<br>pointer dereference=
.<br>In phase2_tcp_server: Pointer is checked against null but then<br>dere=
ferenced anyway<br><br>There is only one caller (link_socket_init_phase2) a=
nd it already has<br>an ASSERT(sig_info). So use that here was well.<br><br=
>v2:<br> - fix cleanly by actually asserting that sig_info is defined<br><b=
r>Change-Id: I8ef199463d46303129a3f563fd9eace780a58b8a<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne=
-openvpn@...1227...&gt;<br>Message-Id: &lt;20240325071448.12143-1-gert@...1386...=
296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg28452.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 3 insertions(+), 2 d=
eletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 57eaee2..d2b82d5 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2005,7 +2005,=
8 @@</span><br><span> phase2_tcp_server(struct link_socket *sock, const cha=
r *remote_dynamic,</span><br><span>                   struct signal_info *s=
ig_info)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    volatile int *signal_received =3D sig_info ? &amp;sig_info-&gt;si=
gnal_received : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT(sig_info);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    volatile int *signal_received =3D &amp;sig_info-&gt;signal_received=
;</span><br><span>     switch (sock-&gt;mode)</span><br><span>     {</span>=
<br><span>         case LS_MODE_DEFAULT:</span><br><span>@@ -2031,7 +2032,7=
 @@</span><br><span>                                         false);</span>=
<br><span>             if (!socket_defined(sock-&gt;sd))</span><br><span>  =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       register_signal(sig_info, SIGTERM, &quot;socket-undefiled&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                regist=
er_signal(sig_info, SIGTERM, &quot;socket-undefined&quot;);</span><br><span=
>                 return;</span><br><span>             }</span><br><span>  =
           tcp_connection_established(&amp;sock-&gt;info.lsa-&gt;actual);</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/490?usp=3Demail">change 490</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/490?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8ef199463d46303129a3f563fd9=
eace780a58b8a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 490 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--OZ3KarlTi0g=--

