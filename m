From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 14 Sep 2025 12:08:46 +0000
In-Reply-To: <gerrit.1757406065000.I74e2b6aed3c7454e897db57f777e6a191be3d87f@...2715...>
References: <gerrit.1757406065000.I74e2b6aed3c7454e897db57f777e6a191be3d87f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <cdb29251e9575d04870f2dff04b2d30db0259021-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EpmMEL+bTQg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix multi-socket
 and dco-win interaction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EpmMEL+bTQg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
73?usp=3Demail )

Change subject: Fix multi-socket and dco-win interaction
......................................................................

Fix multi-socket and dco-win interaction

The dco_check_option_ce(), for dco_win, checked only
the global protocol of the current connection entry,
but now it should be extended to the local_list
and since dco_win does not support more than 1
socket, checking the first entry of the local_list
will be enough.

Change-Id: I74e2b6aed3c7454e897db57f777e6a191be3d87f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20250912131056.42342-1-frank@...2641...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59232442/
URL: https://gerrit.openvpn.net/c/openvpn/+/1173
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 1abebbb..70a8c0a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -268,7 +268,7 @@
 #endif

 #if defined(_WIN32)
-    if (!proto_is_udp(ce->proto) && mode =3D=3D MODE_SERVER)
+    if (!proto_is_udp(ce->local_list->array[0]->proto) && mode =3D=3D MODE=
_SERVER)
     {
         msg(msglevel,
             "NOTE: TCP transport disables data channel offload on Windows =
in server mode.");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1173?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74e2b6aed3c7454e897db57f777e6a191be3d87f
Gerrit-Change-Number: 1173
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--EpmMEL+bTQg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1173?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix multi-socket and dco-win interaction<br><=
br>The dco_check_option_ce(), for dco_win, checked only<br>the global proto=
col of the current connection entry,<br>but now it should be extended to th=
e local_list<br>and since dco_win does not support more than 1<br>socket, c=
hecking the first entry of the local_list<br>will be enough.<br><br>Change-=
Id: I74e2b6aed3c7454e897db57f777e6a191be3d87f<br>Signed-off-by: Gianmarco D=
e Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Lev Stipakov &lt;lstipa=
kov@...277...&gt;<br>Message-Id: &lt;20250912131056.42342-1-frank@...2723...=
.&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59232442/<b=
r>URL: https://gerrit.openvpn.net/c/openvpn/+/1173<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco.c<br>1 file chan=
ged, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 1abebbb..70a8c0a 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -268,7 +268,7 @@</span><br=
><span> #endif</span><br><span> </span><br><span> #if defined(_WIN32)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!proto_is_udp(ce-&g=
t;proto) &amp;&amp; mode =3D=3D MODE_SERVER)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!proto_is_udp(ce-&gt;local_list-&gt;array[=
0]-&gt;proto) &amp;&amp; mode =3D=3D MODE_SERVER)</span><br><span>     {</s=
pan><br><span>         msg(msglevel,</span><br><span>             &quot;NOT=
E: TCP transport disables data channel offload on Windows in server mode.&q=
uot;);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1173?usp=3Demail">change 1173</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1173?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74e2b6aed3c7454e897db57f777=
e6a191be3d87f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1173 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--EpmMEL+bTQg=--

