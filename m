From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 14:26:54 +0000
In-Reply-To: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
References: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a02b90023977b87d22fb1c1572dc8618e217d320-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iTNE7wPnsB4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Fix conversion
 warning in tls_prepend_opcode_v1
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

--iTNE7wPnsB4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


Change subject: ssl: Fix conversion warning in tls_prepend_opcode_v1
......................................................................

ssl: Fix conversion warning in tls_prepend_opcode_v1

Document assumption with ASSERT.

Change-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl.c
1 file changed, 6 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1298/4

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index eb5c4fc..7b93ebc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3970,24 +3970,24 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf)
 {
     struct key_state *ks =3D multi->save_ks;
-    uint8_t op;

     msg(D_TLS_DEBUG, __func__);

     ASSERT(ks);
+    ASSERT(ks->key_id <=3D P_KEY_ID_MASK);

-    op =3D (P_DATA_V1 << P_OPCODE_SHIFT) | ks->key_id;
+    uint8_t op =3D (P_DATA_V1 << P_OPCODE_SHIFT) | (uint8_t)ks->key_id;
     ASSERT(buf_write_prepend(buf, &op, 1));
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d
Gerrit-Change-Number: 1298
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--iTNE7wPnsB4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl: Fix conversion warning in =
tls_prepend_opcode_v1<br><br>Document assumption with ASSERT.<br><br>Change=
-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file ch=
anged, 6 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1298/4</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index eb5c4fc=
..7b93ebc 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>++=
+ b/src/openvpn/ssl.c</span><br><span>@@ -3970,24 +3970,24 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><=
br><span> tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffe=
r *buf)</span><br><span> {</span><br><span>     struct key_state *ks =3D mu=
lti-&gt;save_ks;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
int8_t op;</span><br><span> </span><br><span>     msg(D_TLS_DEBUG, __func__=
);</span><br><span> </span><br><span>     ASSERT(ks);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ks-&gt;key_id &lt;=3D P_KEY_ID=
_MASK);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    op =3D (P_DATA_V1 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D (P_DATA_=
V1 &lt;&lt; P_OPCODE_SHIFT) | (uint8_t)ks-&gt;key_id;</span><br><span>     =
ASSERT(buf_write_prepend(buf, &amp;op, 1));</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> void</span><br><span> tls_prepend_opcode_v2(const struct tls_=
multi *multi, struct buffer *buf)</span><br><span> {</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1298?usp=3Demail">change 1298</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1298?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb438=
0ac91b09c1c8d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1298 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--iTNE7wPnsB4=--

