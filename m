From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 14 Oct 2025 11:34:01 +0000
References: <gerrit.1760441637000.Ia713a2ecfcad7032863867630a0c306ff9f90385@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6a6d9422beb71ba935a1ef5f9dc09d4855036a60-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="npqmLaIDxBY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: Fix
 datav2_enabled check in options import
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

--npqmLaIDxBY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1273?usp=3Demail

to review the following change.


Change subject: init: Fix datav2_enabled check in options import
......................................................................

init: Fix datav2_enabled check in options import

peer_id is unsigned, so the previous check was partly
useless. Instead check use_peer_id.

Change-Id: Ia713a2ecfcad7032863867630a0c306ff9f90385
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/init.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/1273/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index aaa0573..aa2611d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2728,8 +2728,8 @@

     /* Ensure that for epoch data format is only enabled if also data v2
      * is enabled */
-    bool epoch_data =3D (c->options.imported_protocol_flags & CO_EPOCH_DAT=
A_KEY_FORMAT);
-    bool datav2_enabled =3D (c->options.peer_id >=3D 0 && c->options.peer_=
id < MAX_PEER_ID);
+    bool epoch_data =3D c->options.imported_protocol_flags & CO_EPOCH_DATA=
_KEY_FORMAT;
+    bool datav2_enabled =3D c->options.use_peer_id && c->options.peer_id <=
 MAX_PEER_ID;

     if (epoch_data && !datav2_enabled)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1273?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia713a2ecfcad7032863867630a0c306ff9f90385
Gerrit-Change-Number: 1273
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--npqmLaIDxBY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1273?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">init: Fix datav2_enabled check in options i=
mport<br><br>peer_id is unsigned, so the previous check was partly<br>usele=
ss. Instead check use_peer_id.<br><br>Change-Id: Ia713a2ecfcad7032863867630=
a0c306ff9f90385<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>---<br>M src/openvpn/init.c<br>1 file changed, 2 insertions(+), 2 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/73/1273/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/s=
rc/openvpn/init.c</span><br><span>index aaa0573..aa2611d 100644</span><br><=
span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</spa=
n><br><span>@@ -2728,8 +2728,8 @@</span><br><span> </span><br><span>     /*=
 Ensure that for epoch data format is only enabled if also data v2</span><b=
r><span>      * is enabled */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    bool epoch_data =3D (c-&gt;options.imported_protocol_flags &amp=
; CO_EPOCH_DATA_KEY_FORMAT);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    bool datav2_enabled =3D (c-&gt;options.peer_id &gt;=3D 0 &amp;&a=
mp; c-&gt;options.peer_id &lt; MAX_PEER_ID);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool epoch_data =3D c-&gt;options.imported_pro=
tocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    bool datav2_enabled =3D c-&gt;options.use_peer_=
id &amp;&amp; c-&gt;options.peer_id &lt; MAX_PEER_ID;</span><br><span> </sp=
an><br><span>     if (epoch_data &amp;&amp; !datav2_enabled)</span><br><spa=
n>     {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1273?usp=3Demail">change 1273</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1273?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia713a2ecfcad7032863867630a0=
c306ff9f90385 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1273 </div>
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

--npqmLaIDxBY=--

