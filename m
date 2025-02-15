From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 15 Feb 2025 15:36:37 +0000
In-Reply-To: <gerrit.1739361204000.Id4febcceecab33ee5189cd67b249a15d12b84799@...2715...>
References: <gerrit.1739361204000.Id4febcceecab33ee5189cd67b249a15d12b84799@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <716fd2b5919d4a49cae46289f5b0cba3b3765aff-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pyJqsRJTlr4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reconnect when TCP
 is on use on network-change management command
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

--pyJqsRJTlr4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/891?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Reconnect when TCP is on use on network-change management c=
ommand
......................................................................

Reconnect when TCP is on use on network-change management command

On some newer Android handsets, changing to a different network
often does not trigger a TCP reset but continues using the old
connection (e.g. using mobile connection when WiFi becomes available)

Force a reconnect in these situation to have a more expected beheaviour.

Change-Id: Id4febcceecab33ee5189cd67b249a15d12b84799
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250215152456.5691-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
908.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
1 file changed, 9 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/891/2

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index da20241..920f8d7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4412,6 +4412,15 @@
         return -1;
     }

+    /* On some newer Android handsets, changing to a different network
+     * often does not trigger a TCP reset but continue using the old
+     * connection (e.g. using mobile connection when WiFi becomes availabl=
e */
+    struct link_socket_info *lsi =3D get_link_socket_info(c);
+    if (lsi && proto_is_tcp(lsi->proto) && !samenetwork)
+    {
+        return -2;
+    }
+
     socketfd =3D c->c2.link_sockets[0]->sd;
     if (!c->options.pull || c->c2.tls_multi->use_peer_id || samenetwork)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/891?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id4febcceecab33ee5189cd67b249a15d12b84799
Gerrit-Change-Number: 891
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--pyJqsRJTlr4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
891?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Reconnect when TCP is on use on network-change manag=
ement command<br><br>On some newer Android handsets, changing to a differen=
t network<br>often does not trigger a TCP reset but continues using the old=
<br>connection (e.g. using mobile connection when WiFi becomes available)<b=
r><br>Force a reconnect in these situation to have a more expected beheavio=
ur.<br><br>Change-Id: Id4febcceecab33ee5189cd67b249a15d12b84799<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>Message-Id: &lt;20250215152456.5691-1-gert@...1296...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg30908.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M src/openvpn/init.c<br>1 file changed, 9 insertions(+), 0 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
91/891/2</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span=
><br><span>index da20241..920f8d7 100644</span><br><span>--- a/src/openvpn/=
init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -4412,6 =
+4412,15 @@</span><br><span>         return -1;</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 On some newer Android handsets, changing to a different network</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * often does not trigger =
a TCP reset but continue using the old</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * connection (e.g. using mobile connection when WiF=
i becomes available */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct link_socket_info *lsi =3D get_link_socket_info(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (lsi &amp;&amp; proto_i=
s_tcp(lsi-&gt;proto) &amp;&amp; !samenetwork)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return -2;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     socketfd =3D c-&gt;c2.link_sockets[0]-&gt;sd;</span><br>=
<span>     if (!c-&gt;options.pull || c-&gt;c2.tls_multi-&gt;use_peer_id ||=
 samenetwork)</span><br><span>     {</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/891?usp=3Dema=
il">change 891</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/891?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id4febcceecab33ee5189cd67b24=
9a15d12b84799 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 891 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pyJqsRJTlr4=--

