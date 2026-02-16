From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 13:54:50 +0000
References: <gerrit.1771250081000.I6bdded6c70596b69428e6a00a405ac3cedc405fa@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6a9f6be850824757c2abc7ca55d4b74f6b3e5b92-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qGzKclIV4DM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qGzKclIV4DM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1533?usp=3Demail

to review the following change.


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
---
M src/openvpn/manage.c
1 file changed, 9 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1533/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 4ed0393..48b87e9 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -472,6 +472,13 @@
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
@@ -483,8 +490,7 @@
     }
     else
     {
-        man->connection.bytecount_update_seconds =3D 0;
-        event_timeout_clear(&man->connection.bytecount_update_interval);
+        man_bytecount_stop(man);
     }

     /* The newly received bytecount interval may be sooner than the existi=
ng
@@ -2011,6 +2017,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I6bdded6c70596b69428e6a00a405ac3cedc405fa
Gerrit-Change-Number: 1533
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--qGzKclIV4DM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1533?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">management: stop bytecount on client discon=
nection<br><br>When a management interface client requests periodic bytecou=
nt<br>notifications, openvpn continues to emit them even after the client h=
as<br>disconnected. Additionally, upon reconnecting, the client starts<br>r=
eceiving these notifications without having issued a new bytecount<br>comma=
nd.<br><br>Stop the periodic bytecount operation when the management interf=
ace<br>client disconnects, preventing unnecessary stats polling when using =
DCO<br>and ensuring that clients only receive notifications they have<br>ex=
plicitly requested.<br><br>Change-Id: I6bdded6c70596b69428e6a00a405ac3cedc4=
05fa<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/op=
envpn/manage.c<br>1 file changed, 9 insertions(+), 2 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/33/1533/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openvpn/manag=
e.c</span><br><span>index 4ed0393..48b87e9 100644</span><br><span>--- a/src=
/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><spa=
n>@@ -472,6 +472,13 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_by=
tecount_stop(struct management *man)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   man-&gt;connection.bytecount_update_seconds =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    event_timeout_clear(&amp;man-&gt;conn=
ection.bytecount_update_interval);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span> man_bytecount(struct management *man, const int update_seconds)</spa=
n><br><span> {</span><br><span>     if (update_seconds &gt; 0)</span><br><s=
pan>@@ -483,8 +490,7 @@</span><br><span>     }</span><br><span>     else</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       man-&gt;connection.bytecount_update_seconds =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        event_timeout_clear(&amp;man-&g=
t;connection.bytecount_update_interval);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        man_bytecount_stop(man);</span><br><span>     =
}</span><br><span> </span><br><span>     /* The newly received bytecount in=
terval may be sooner than the existing</span><br><span>@@ -2011,6 +2017,7 @=
@</span><br><span> {</span><br><span>     if (socket_defined(man-&gt;connec=
tion.sd_cli))</span><br><span>     {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        man_bytecount_stop(man);</span><br><span> #ifdef _=
WIN32</span><br><span>         man_stop_ne32(man);</span><br><span> #endif<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1533?usp=3Demail">change 1533</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1533?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6bdded6c70596b69428e6a00a40=
5ac3cedc405fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1533 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--qGzKclIV4DM=--

