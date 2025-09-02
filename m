From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 17:07:17 +0000
In-Reply-To: <gerrit.1756830653000.I1474d232278433d097baf85352dfc9a79853bad1@...2715...>
References: <gerrit.1756830653000.I1474d232278433d097baf85352dfc9a79853bad1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <e7022f26bda53890e8176b72349dd586d4b26e65-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eF+VjRD62J4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: management: stop
 bytecount on client disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eF+VjRD62J4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
67?usp=3Demail )

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

Change-Id: I1474d232278433d097baf85352dfc9a79853bad1
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250902163514.22339-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
765.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
1 file changed, 9 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 422aa0b..5b2a7de 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -501,6 +501,13 @@
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
@@ -511,8 +518,7 @@
     }
     else
     {
-        man->connection.bytecount_update_seconds =3D 0;
-        event_timeout_clear(&man->connection.bytecount_update_interval);
+        man_bytecount_stop(man);
     }

     /* The newly received bytecount interval may be sooner than the existi=
ng
@@ -1992,6 +1998,7 @@
 {
     if (socket_defined(man->connection.sd_cli))
     {
+        man_bytecount_stop(man);
 #ifdef _WIN32
         man_stop_ne32(man);
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1167?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1474d232278433d097baf85352dfc9a79853bad1
Gerrit-Change-Number: 1167
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--eF+VjRD62J4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1167?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">management: stop bytecount on client disconne=
ction<br><br>When a management interface client requests periodic bytecount=
<br>notifications, openvpn continues to emit them even after the client has=
<br>disconnected. Additionally, upon reconnecting, the client starts<br>rec=
eiving these notifications without having issued a new bytecount<br>command=
.<br><br>Stop the periodic bytecount operation when the management interfac=
e<br>client disconnects, preventing unnecessary stats polling when using DC=
O<br>and ensuring that clients only receive notifications they have<br>expl=
icitly requested.<br><br>Change-Id: I1474d232278433d097baf85352dfc9a79853ba=
d1<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250902163514.22339-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg32765.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/manage.c<br>1 file changed, 9 insertions(+=
), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 422aa0b..5b2a7de 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -501,6 +501,13=
 @@</span><br><span> }</span><br><span> </span><br><span> static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+man_bytecount_stop(struct=
 management *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man-&gt;connecti=
on.bytecount_update_seconds =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    event_timeout_clear(&amp;man-&gt;connection.bytecount_up=
date_interval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> man_bytecoun=
t(struct management *man, const int update_seconds)</span><br><span> {</spa=
n><br><span>     if (update_seconds &gt; 0)</span><br><span>@@ -511,8 +518,=
7 @@</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man-&gt;conn=
ection.bytecount_update_seconds =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        event_timeout_clear(&amp;man-&gt;connection.byteco=
unt_update_interval);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        man_bytecount_stop(man);</span><br><span>     }</span><br><span> =
</span><br><span>     /* The newly received bytecount interval may be soone=
r than the existing</span><br><span>@@ -1992,6 +1998,7 @@</span><br><span> =
{</span><br><span>     if (socket_defined(man-&gt;connection.sd_cli))</span=
><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      man_bytecount_stop(man);</span><br><span> #ifdef _WIN32</span><br><sp=
an>         man_stop_ne32(man);</span><br><span> #endif</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1167?usp=3Demail">change 1167</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1167?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1474d232278433d097baf85352d=
fc9a79853bad1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1167 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--eF+VjRD62J4=--

