From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 24 Oct 2025 16:52:49 +0000
References: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ab10c6afa280bb3e4ca8c44f2df571b86b2dcc44-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o48IpnH5sCg="; charset=UTF-8
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

--o48IpnH5sCg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail

to review the following change.


Change subject: ssl: Fix conversion warning in tls_prepend_opcode_v1
......................................................................

ssl: Fix conversion warning in tls_prepend_opcode_v1

Document assumption with ASSERT.

Change-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl.c
1 file changed, 6 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1298/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index dfbbbc6..54b69ea 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3974,24 +3974,24 @@
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
+    ASSERT(ks->key_id <=3D 1 << P_OPCODE_SHIFT);

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d
Gerrit-Change-Number: 1298
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--o48IpnH5sCg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl: Fix conversion warning in tls_prepend_=
opcode_v1<br><br>Document assumption with ASSERT.<br><br>Change-Id: I34584f=
695ddca3b3e1f2bbcb4380ac91b09c1c8d<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 6 ins=
ertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/98/1298/1</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index dfbbbc6..54b69ea 10=
0644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/open=
vpn/ssl.c</span><br><span>@@ -3974,24 +3974,24 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> t=
ls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf)</sp=
an><br><span> {</span><br><span>     struct key_state *ks =3D multi-&gt;sav=
e_ks;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t op;<=
/span><br><span> </span><br><span>     msg(D_TLS_DEBUG, __func__);</span><b=
r><span> </span><br><span>     ASSERT(ks);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(ks-&gt;key_id &lt;=3D 1 &lt;&lt; P_OPCODE=
_SHIFT);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    op =3D (P_DATA_V1 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D (P_DATA=
_V1 &lt;&lt; P_OPCODE_SHIFT) | (uint8_t)ks-&gt;key_id;</span><br><span>    =
 ASSERT(buf_write_prepend(buf, &amp;op, 1));</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> void</span><br><span> tls_prepend_opcode_v2(const struct tls=
_multi *multi, struct buffer *buf)</span><br><span> {</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1298?usp=3Demail">change 1298</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1298?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb438=
0ac91b09c1c8d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1298 </div>
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

--o48IpnH5sCg=--

