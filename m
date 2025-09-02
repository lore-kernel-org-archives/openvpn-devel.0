From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 17:07:15 +0000
In-Reply-To: <gerrit.1756830653000.I1474d232278433d097baf85352dfc9a79853bad1@...2715...>
References: <gerrit.1756830653000.I1474d232278433d097baf85352dfc9a79853bad1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <e7022f26bda53890e8176b72349dd586d4b26e65-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bcfrum3ZSco="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Bcfrum3ZSco=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1167?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1167/2

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
Gerrit-MessageType: newpatchset

--Bcfrum3ZSco=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by ralf_lici.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1167?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">management: stop bytecount on client disconnection<b=
r><br>When a management interface client requests periodic bytecount<br>not=
ifications, openvpn continues to emit them even after the client has<br>dis=
connected. Additionally, upon reconnecting, the client starts<br>receiving =
these notifications without having issued a new bytecount<br>command.<br><b=
r>Stop the periodic bytecount operation when the management interface<br>cl=
ient disconnects, preventing unnecessary stats polling when using DCO<br>an=
d ensuring that clients only receive notifications they have<br>explicitly =
requested.<br><br>Change-Id: I1474d232278433d097baf85352dfc9a79853bad1<br>S=
igned-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-by: Gert Doering &=
lt;gert@...1296...&gt;<br>Message-Id: &lt;20250902163514.22339-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg32765.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M src/openvpn/manage.c<br>1 file changed, 9 insertions(+), 2 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/67/1167/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openvpn/ma=
nage.c</span><br><span>index 422aa0b..5b2a7de 100644</span><br><span>--- a/=
src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><=
span>@@ -501,6 +501,13 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man=
_bytecount_stop(struct management *man)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    man-&gt;connection.bytecount_update_seconds =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    event_timeout_clear(&amp;man-&gt;c=
onnection.bytecount_update_interval);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span> man_bytecount(struct management *man, const int update_seconds)</=
span><br><span> {</span><br><span>     if (update_seconds &gt; 0)</span><br=
><span>@@ -511,8 +518,7 @@</span><br><span>     }</span><br><span>     else=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        man-&gt;connection.bytecount_update_seconds =3D 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        event_timeout_clear(&amp;man=
-&gt;connection.bytecount_update_interval);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        man_bytecount_stop(man);</span><br><span>  =
   }</span><br><span> </span><br><span>     /* The newly received bytecount=
 interval may be sooner than the existing</span><br><span>@@ -1992,6 +1998,=
7 @@</span><br><span> {</span><br><span>     if (socket_defined(man-&gt;con=
nection.sd_cli))</span><br><span>     {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        man_bytecount_stop(man);</span><br><span> #ifde=
f _WIN32</span><br><span>         man_stop_ne32(man);</span><br><span> #end=
if</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1167?usp=3Demail">change 1167</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1167?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Bcfrum3ZSco=--

