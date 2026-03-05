From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 5 Mar 2026 09:18:55 +0000
In-Reply-To: <gerrit.1771250081000.I6bdded6c70596b69428e6a00a405ac3cedc405fa@...2715...>
References: <gerrit.1771250081000.I6bdded6c70596b69428e6a00a405ac3cedc405fa@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <e13cebf7a746e7b9efb57b0b2aa6887ed245c70b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B2lce4ZGPIo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: management:
 stop bytecount on client disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--B2lce4ZGPIo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1533?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: management: stop bytecount on client disconnection
......................................................................

management: stop bytecount on client disconnection

When a management interface client requests periodic bytecount
notifications, openvpn continues to emit them even after the client has
disconnected. Additionally, upon reconnecting, the client starts
receiving these notifications without having issued a new bytecount
command.

Stop the periodic bytecount operation when the management interface
client disconnects, preventing unnecessary stats polling when using DCO
and ensuring that clients only receive notifications they have
explicitly requested.

Change-Id: I6bdded6c70596b69428e6a00a405ac3cedc405fa
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1533
Message-Id: <20260302163557.18358-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
825.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry-picked from fccdb21733d2826bcdc080fdfa93b0283b5231b8)
---
M src/openvpn/manage.c
1 file changed, 9 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1533/2

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0e4afa2..3a2e84e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -471,6 +471,13 @@
 }

 static void
+man_bytecount_stop(struct management *man)
+{
+    man->connection.bytecount_update_seconds =3D 0;
+    event_timeout_clear(&man->connection.bytecount_update_interval);
+}
+
+static void
 man_bytecount(struct management *man, const int update_seconds)
 {
     if (update_seconds > 0)
@@ -482,8 +489,7 @@
     }
     else
     {
-        man->connection.bytecount_update_seconds =3D 0;
-        event_timeout_clear(&man->connection.bytecount_update_interval);
+        man_bytecount_stop(man);
     }
     msg(M_CLIENT, "SUCCESS: bytecount interval changed");
 }
@@ -1992,6 +1998,7 @@
 {
     if (socket_defined(man->connection.sd_cli))
     {
+        man_bytecount_stop(man);
 #ifdef _WIN32
         man_stop_ne32(man);
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1533?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I6bdded6c70596b69428e6a00a405ac3cedc405fa
Gerrit-Change-Number: 1533
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--B2lce4ZGPIo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ralf_lici.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1533?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">management: stop bytecount on c=
lient disconnection<br><br>When a management interface client requests peri=
odic bytecount<br>notifications, openvpn continues to emit them even after =
the client has<br>disconnected. Additionally, upon reconnecting, the client=
 starts<br>receiving these notifications without having issued a new byteco=
unt<br>command.<br><br>Stop the periodic bytecount operation when the manag=
ement interface<br>client disconnects, preventing unnecessary stats polling=
 when using DCO<br>and ensuring that clients only receive notifications the=
y have<br>explicitly requested.<br><br>Change-Id: I6bdded6c70596b69428e6a00=
a405ac3cedc405fa<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Ack=
ed-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1533<br>Message-Id: &lt;20260302163557.18358=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg35825.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>(cherry-picked from fccdb21733d2826bcdc080fdfa93b0283b523=
1b8)<br>---<br>M src/openvpn/manage.c<br>1 file changed, 9 insertions(+), 2=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/33/1533/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manag=
e.c b/src/openvpn/manage.c</span><br><span>index 0e4afa2..3a2e84e 100644</s=
pan><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/=
manage.c</span><br><span>@@ -471,6 +471,13 @@</span><br><span> }</span><br>=
<span> </span><br><span> static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+man_bytecount_stop(struct management *man)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    man-&gt;connection.bytecount_update_seconds =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    event_timeout_=
clear(&amp;man-&gt;connection.bytecount_update_interval);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span> man_bytecount(struct management *man, const i=
nt update_seconds)</span><br><span> {</span><br><span>     if (update_secon=
ds &gt; 0)</span><br><span>@@ -482,8 +489,7 @@</span><br><span>     }</span=
><br><span>     else</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        man-&gt;connection.bytecount_update_seconds =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_t=
imeout_clear(&amp;man-&gt;connection.bytecount_update_interval);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        man_bytecount_stop(man=
);</span><br><span>     }</span><br><span>     msg(M_CLIENT, &quot;SUCCESS:=
 bytecount interval changed&quot;);</span><br><span> }</span><br><span>@@ -=
1992,6 +1998,7 @@</span><br><span> {</span><br><span>     if (socket_define=
d(man-&gt;connection.sd_cli))</span><br><span>     {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        man_bytecount_stop(man);</span><b=
r><span> #ifdef _WIN32</span><br><span>         man_stop_ne32(man);</span><=
br><span> #endif</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1533?usp=3Demail">change 1533</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1533?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6bdded6c70596b69428e6a00a40=
5ac3cedc405fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1533 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--B2lce4ZGPIo=--

