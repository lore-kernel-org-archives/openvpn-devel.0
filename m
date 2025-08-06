From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 6 Aug 2025 18:05:50 +0000
In-Reply-To: <gerrit.1754490554000.I71981e39932cafe3fd68b475fdb81a8f20a3a547@...2715...>
References: <gerrit.1754490554000.I71981e39932cafe3fd68b475fdb81a8f20a3a547@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ce9334bea82597852b2d9838429bcbd0951627f5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6QTmBo6gt3M="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: buffer: remove
 unused function buf_write_alloc_prepend
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

--6QTmBo6gt3M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1134?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: buffer: remove unused function buf_write_alloc_prepend
......................................................................

buffer: remove unused function buf_write_alloc_prepend

Change-Id: I71981e39932cafe3fd68b475fdb81a8f20a3a547
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250806144238.11332-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
565.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.h
1 file changed, 0 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/1134/2

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index ae783c6..1405667 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -643,12 +643,6 @@
 }

 static inline uint8_t *
-buf_write_alloc_prepend(struct buffer *buf, int size, bool prepend)
-{
-    return prepend ? buf_prepend(buf, size) : buf_write_alloc(buf, size);
-}
-
-static inline uint8_t *
 buf_read_alloc(struct buffer *buf, int size)
 {
     uint8_t *ret;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1134?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I71981e39932cafe3fd68b475fdb81a8f20a3a547
Gerrit-Change-Number: 1134
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--6QTmBo6gt3M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1134?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">buffer: remove unused function buf_write_alloc_prepe=
nd<br><br>Change-Id: I71981e39932cafe3fd68b475fdb81a8f20a3a547<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering =
&lt;gert@...1296...&gt;<br>Message-Id: &lt;20250806144238.11332-1-gert@...1386...=
296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg32565.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M src/openvpn/buffer.h<br>1 file changed, 0 insertions(+), 6 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/34/1134/2</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/b=
uffer.h</span><br><span>index ae783c6..1405667 100644</span><br><span>--- a=
/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br>=
<span>@@ -643,12 +643,6 @@</span><br><span> }</span><br><span> </span><br><=
span> static inline uint8_t *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-buf_write_alloc_prepend(struct buffer *buf, int size, bool prepend)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return prepend ? buf_prepend(buf, siz=
e) : buf_write_alloc(buf, size);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline uint8_t *</span>=
<br><span> buf_read_alloc(struct buffer *buf, int size)</span><br><span> {<=
/span><br><span>     uint8_t *ret;</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1134?usp=3Demai=
l">change 1134</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1134?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I71981e39932cafe3fd68b475fdb=
81a8f20a3a547 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1134 </div>
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


--6QTmBo6gt3M=--

