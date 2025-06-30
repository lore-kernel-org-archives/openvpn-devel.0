From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Jun 2025 17:01:59 +0000
In-Reply-To: <gerrit.1751292607000.I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c@...2715...>
References: <gerrit.1751292607000.I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e909c991967e9c61c4e8712e062554b3385a2128-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cApmzPlXcZQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: packet_id: Fix
 build with --disable-debug
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

--cApmzPlXcZQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
71?usp=3Demail )

Change subject: packet_id: Fix build with --disable-debug
......................................................................

packet_id: Fix build with --disable-debug

Broken since commit
bc62a9a02cb7365a678bcd3f2faf537a420cc5a0
"Add methods to read/write packet ids for epoch data"

Change-Id: I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250630164207.10477-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
013.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/packet_id.c
1 file changed, 2 insertions(+), 3 deletions(-)




diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index c8dae32..76a81c6 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -673,6 +673,8 @@
     gc_free(&gc);
 }

+#endif /* ifdef ENABLE_DEBUG */
+
 uint16_t
 packet_id_read_epoch(struct packet_id_net *pin, struct buffer *buf)
 {
@@ -711,6 +713,3 @@

     return buf_write(buf, &net_id, sizeof(net_id));
 }
-
-
-#endif /* ifdef ENABLE_DEBUG */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1071?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c
Gerrit-Change-Number: 1071
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--cApmzPlXcZQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1071?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">packet_id: Fix build with --disable-debug<br>=
<br>Broken since commit<br>bc62a9a02cb7365a678bcd3f2faf537a420cc5a0<br>&quo=
t;Add methods to read/write packet ids for epoch data&quot;<br><br>Change-I=
d: I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>Message-Id: &lt;20250630164207.10477-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32013.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src=
/openvpn/packet_id.c<br>1 file changed, 2 insertions(+), 3 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c</span><br=
><span>index c8dae32..76a81c6 100644</span><br><span>--- a/src/openvpn/pack=
et_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</span><br><span>@@ -6=
73,6 +673,8 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if /* ifdef ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> uint16_t</span><br><span> packet_id_read_epoch(st=
ruct packet_id_net *pin, struct buffer *buf)</span><br><span> {</span><br><=
span>@@ -711,6 +713,3 @@</span><br><span> </span><br><span>     return buf_=
write(buf, &amp;net_id, sizeof(net_id));</span><br><span> }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* ifdef ENABLE_DEBUG */</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1071?usp=3Demail">chan=
ge 1071</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1071?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3bed9c7aafee8e62ddae14c0d3e=
21cf4c146a37c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1071 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--cApmzPlXcZQ=--

