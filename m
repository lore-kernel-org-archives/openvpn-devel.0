From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 5 Mar 2026 09:18:57 +0000
In-Reply-To: <gerrit.1771250081000.I6bdded6c70596b69428e6a00a405ac3cedc405fa@...2715...>
References: <gerrit.1771250081000.I6bdded6c70596b69428e6a00a405ac3cedc405fa@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <e13cebf7a746e7b9efb57b0b2aa6887ed245c70b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hiJXesJmmiM="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hiJXesJmmiM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
33?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I6bdded6c70596b69428e6a00a405ac3cedc405fa
Gerrit-Change-Number: 1533
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hiJXesJmmiM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1533?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">management: stop bytecount on client disconnecti=
on<br><br>When a management interface client requests periodic bytecount<br=
>notifications, openvpn continues to emit them even after the client has<br=
>disconnected. Additionally, upon reconnecting, the client starts<br>receiv=
ing these notifications without having issued a new bytecount<br>command.<b=
r><br>Stop the periodic bytecount operation when the management interface<b=
r>client disconnects, preventing unnecessary stats polling when using DCO<b=
r>and ensuring that clients only receive notifications they have<br>explici=
tly requested.<br><br>Change-Id: I6bdded6c70596b69428e6a00a405ac3cedc405fa<=
br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-by: Arne Schwa=
be &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.ne=
t/c/openvpn/+/1533<br>Message-Id: &lt;20260302163557.18358-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg35825.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>(cherry-picked from fccdb21733d2826bcdc080fdfa93b0283b5231b8)<br>---<br>M =
src/openvpn/manage.c<br>1 file changed, 9 insertions(+), 2 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 0e4afa2..3a2e84e 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -471,6 +471,13=
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
n><br><span>     if (update_seconds &gt; 0)</span><br><span>@@ -482,8 +489,=
7 @@</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man-&gt;conn=
ection.bytecount_update_seconds =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        event_timeout_clear(&amp;man-&gt;connection.byteco=
unt_update_interval);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        man_bytecount_stop(man);</span><br><span>     }</span><br><span> =
    msg(M_CLIENT, &quot;SUCCESS: bytecount interval changed&quot;);</span><=
br><span> }</span><br><span>@@ -1992,6 +1998,7 @@</span><br><span> {</span>=
<br><span>     if (socket_defined(man-&gt;connection.sd_cli))</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ma=
n_bytecount_stop(man);</span><br><span> #ifdef _WIN32</span><br><span>     =
    man_stop_ne32(man);</span><br><span> #endif</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/15=
33?usp=3Demail">change 1533</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1533?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--hiJXesJmmiM=--

