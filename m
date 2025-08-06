From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Aug 2025 14:29:39 +0000
References: <gerrit.1754490554000.I71981e39932cafe3fd68b475fdb81a8f20a3a547@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <eab9f3ae7befdc4ce2247dbd79eae3bcc81526b3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nKlbdWb12/I="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nKlbdWb12/I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1134?usp=3Demail

to review the following change.


Change subject: buffer: remove unused function buf_write_alloc_prepend
......................................................................

buffer: remove unused function buf_write_alloc_prepend

Change-Id: I71981e39932cafe3fd68b475fdb81a8f20a3a547
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.h
1 file changed, 0 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/1134/1

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8d6bb64..6f15115 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -644,12 +644,6 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--nKlbdWb12/I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1134?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">buffer: remove unused function buf_write_alloc_prepend<br><b=
r>Change-Id: I71981e39932cafe3fd68b475fdb81a8f20a3a547<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/buffer.h<b=
r>1 file changed, 0 insertions(+), 6 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/34/1134/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index 8d6=
bb64..6f15115 100644</span><br><span>--- a/src/openvpn/buffer.h</span><br><=
span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -644,12 +644,6 @@</span>=
<br><span> }</span><br><span> </span><br><span> static inline uint8_t *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_write_alloc_prepend(s=
truct buffer *buf, int size, bool prepend)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return prepend ? buf_prepend(buf, size) : buf_write_alloc(buf, size);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static inline uint8_t *</span><br><span> buf_read_alloc(struct =
buffer *buf, int size)</span><br><span> {</span><br><span>     uint8_t *ret=
;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1134?usp=3Demail">change 1134</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1134?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I71981e39932cafe3fd68b475fdb=
81a8f20a3a547 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1134 </div>
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


--nKlbdWb12/I=--

