From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 16 Oct 2025 10:47:00 +0000
In-Reply-To: <gerrit.1760441637000.Ia713a2ecfcad7032863867630a0c306ff9f90385@...2715...>
References: <gerrit.1760441637000.Ia713a2ecfcad7032863867630a0c306ff9f90385@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f14369bbd9bb237204d30544d77c1a47e7a4a2e0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lB1s0pwl0o8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lB1s0pwl0o8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
73?usp=3Demail )

Change subject: init: Fix datav2_enabled check in options import
......................................................................

init: Fix datav2_enabled check in options import

peer_id is unsigned, so the previous check was partly
useless. Instead check use_peer_id.

Change-Id: Ia713a2ecfcad7032863867630a0c306ff9f90385
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1273
Message-Id: <20251016103308.4685-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
365.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
1 file changed, 2 insertions(+), 2 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia713a2ecfcad7032863867630a0c306ff9f90385
Gerrit-Change-Number: 1273
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lB1s0pwl0o8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1273?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">init: Fix datav2_enabled check in options import=
<br><br>peer_id is unsigned, so the previous check was partly<br>useless. I=
nstead check use_peer_id.<br><br>Change-Id: Ia713a2ecfcad7032863867630a0c30=
6ff9f90385<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https=
://gerrit.openvpn.net/c/openvpn/+/1273<br>Message-Id: &lt;20251016103308.46=
85-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg33365.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M src/openvpn/init.c<br>1 file changed, 2 insert=
ions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex aaa0573..aa2611d 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2728,8 +2728,8 @@</sp=
an><br><span> </span><br><span>     /* Ensure that for epoch data format is=
 only enabled if also data v2</span><br><span>      * is enabled */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool epoch_data =3D (c-&g=
t;options.imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    bool datav2_enabled =3D (c=
-&gt;options.peer_id &gt;=3D 0 &amp;&amp; c-&gt;options.peer_id &lt; MAX_PE=
ER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool epo=
ch_data =3D c-&gt;options.imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_F=
ORMAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool data=
v2_enabled =3D c-&gt;options.use_peer_id &amp;&amp; c-&gt;options.peer_id &=
lt; MAX_PEER_ID;</span><br><span> </span><br><span>     if (epoch_data &amp=
;&amp; !datav2_enabled)</span><br><span>     {</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/127=
3?usp=3Demail">change 1273</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1273?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia713a2ecfcad7032863867630a0=
c306ff9f90385 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1273 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--lB1s0pwl0o8=--

