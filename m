From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Jun 2025 17:01:57 +0000
In-Reply-To: <gerrit.1751292607000.I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c@...2715...>
References: <gerrit.1751292607000.I3bed9c7aafee8e62ddae14c0d3e21cf4c146a37c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e909c991967e9c61c4e8712e062554b3385a2128-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A3ec7BOYzGE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--A3ec7BOYzGE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1071?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1071/2

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
Gerrit-MessageType: newpatchset

--A3ec7BOYzGE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1071?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">packet_id: Fix build with --disable-debug<br><br>Bro=
ken since commit<br>bc62a9a02cb7365a678bcd3f2faf537a420cc5a0<br>&quot;Add m=
ethods to read/write packet ids for epoch data&quot;<br><br>Change-Id: I3be=
d9c7aafee8e62ddae14c0d3e21cf4c146a37c<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>Message-Id: &lt;20250630164207.10477-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32013.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/packet_id.c<br>1 file changed, 2 insertions(+), 3 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1071/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c</span><b=
r><span>index c8dae32..76a81c6 100644</span><br><span>--- a/src/openvpn/pac=
ket_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</span><br><span>@@ -=
673,6 +673,8 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* ifdef ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> uint16_t</span><br><span> packet_id_read_epoch(s=
truct packet_id_net *pin, struct buffer *buf)</span><br><span> {</span><br>=
<span>@@ -711,6 +713,3 @@</span><br><span> </span><br><span>     return buf=
_write(buf, &amp;net_id, sizeof(net_id));</span><br><span> }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif /* ifdef ENABLE_DEBUG */</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1071?usp=3Demail">cha=
nge 1071</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1071?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--A3ec7BOYzGE=--

