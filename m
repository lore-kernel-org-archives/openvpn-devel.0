From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 30 Jun 2025 14:10:09 +0000
References: <gerrit.1751292607000.I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1e8b05165ddd92853e2ecdd67063aabcb989199d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P57V4h9XdD0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--P57V4h9XdD0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1071?usp=3Demail

to review the following change.


Change subject: packet_id: Fix build with --disable-debug
......................................................................

packet_id: Fix build with --disable-debug

Broken since commit
bc62a9a02cb7365a678bcd3f2faf537a420cc5a0
"Add methods to read/write packet ids for epoch data"

Change-Id: I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/packet_id.c
1 file changed, 2 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1071/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--P57V4h9XdD0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1071?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">packet_id: Fix build with --disable-debug<br><br>Broken sinc=
e commit<br>bc62a9a02cb7365a678bcd3f2faf537a420cc5a0<br>&quot;Add methods t=
o read/write packet ids for epoch data&quot;<br><br>Change-Id: I3bed9c7aafe=
e8e62ddae14c0d3e21cf4c146a37c<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@...2641...&gt;<br>---<br>M src/openvpn/packet_id.c<br>1 file changed, 2 in=
sertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/71/1071/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/packet_i=
d.c b/src/openvpn/packet_id.c</span><br><span>index c8dae32..76a81c6 100644=
</span><br><span>--- a/src/openvpn/packet_id.c</span><br><span>+++ b/src/op=
envpn/packet_id.c</span><br><span>@@ -673,6 +673,8 @@</span><br><span>     =
gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_DEBUG */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> uint16_t</=
span><br><span> packet_id_read_epoch(struct packet_id_net *pin, struct buff=
er *buf)</span><br><span> {</span><br><span>@@ -711,6 +713,3 @@</span><br><=
span> </span><br><span>     return buf_write(buf, &amp;net_id, sizeof(net_i=
d));</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1071?usp=3Demail">change 1071</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1071?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3bed9c7aafee8e62ddae14c0d3e=
21cf4c146a37c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1071 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--P57V4h9XdD0=--

