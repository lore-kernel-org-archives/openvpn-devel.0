From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 16:30:56 +0000
References: <gerrit.1756830653000.I1474d232278433d097baf85352dfc9a79853bad1@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9ad8de35b31ba42d39d6f2ff5b5bbb30b6c6c576-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dwqEtkaZUFk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dwqEtkaZUFk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1167?usp=3Demail

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

Change-Id: I1474d232278433d097baf85352dfc9a79853bad1
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/manage.c
1 file changed, 9 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1167/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--dwqEtkaZUFk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1167?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">management: stop bytecount on client disconnection<br><br>Wh=
en a management interface client requests periodic bytecount<br>notificatio=
ns, openvpn continues to emit them even after the client has<br>disconnecte=
d. Additionally, upon reconnecting, the client starts<br>receiving these no=
tifications without having issued a new bytecount<br>command.<br><br>Stop t=
he periodic bytecount operation when the management interface<br>client dis=
connects, preventing unnecessary stats polling when using DCO<br>and ensuri=
ng that clients only receive notifications they have<br>explicitly requeste=
d.<br><br>Change-Id: I1474d232278433d097baf85352dfc9a79853bad1<br>Signed-of=
f-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/manage.c<br=
>1 file changed, 9 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/67/1167/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 422aa0b.=
.5b2a7de 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>=
+++ b/src/openvpn/manage.c</span><br><span>@@ -501,6 +501,13 @@</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+man_bytecount_stop(struct management *ma=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    man-&gt;connection.bytecount_up=
date_seconds =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    event_timeout_clear(&amp;man-&gt;connection.bytecount_update_interval);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span> man_bytecount(struct manage=
ment *man, const int update_seconds)</span><br><span> {</span><br><span>   =
  if (update_seconds &gt; 0)</span><br><span>@@ -511,8 +518,7 @@</span><br>=
<span>     }</span><br><span>     else</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        man-&gt;connection.bytecoun=
t_update_seconds =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        event_timeout_clear(&amp;man-&gt;connection.bytecount_update_inte=
rval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_b=
ytecount_stop(man);</span><br><span>     }</span><br><span> </span><br><spa=
n>     /* The newly received bytecount interval may be sooner than the exis=
ting</span><br><span>@@ -1992,6 +1998,7 @@</span><br><span> {</span><br><sp=
an>     if (socket_defined(man-&gt;connection.sd_cli))</span><br><span>    =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_bytec=
ount_stop(man);</span><br><span> #ifdef _WIN32</span><br><span>         man=
_stop_ne32(man);</span><br><span> #endif</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1167?usp=
=3Demail">change 1167</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1167?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1474d232278433d097baf85352d=
fc9a79853bad1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1167 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--dwqEtkaZUFk=--

