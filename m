From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 21:58:28 +0000
In-Reply-To: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
References: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <167cb5a8d1263f68061dbe37a846877f70715abf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gy4kPwxguKE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Gy4kPwxguKE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: ssl: Fix conversion warning in tls_prepend_opcode_v1
......................................................................

ssl: Fix conversion warning in tls_prepend_opcode_v1

Document assumption with ASSERT.

Change-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1298
Message-Id: <20251116183336.11447-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
480.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 6 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1298/5

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 896fd65..2d24f5e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3962,24 +3962,24 @@
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
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Gy4kPwxguKE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">ssl: Fix conversion warning in tls_=
prepend_opcode_v1<br><br>Document assumption with ASSERT.<br><br>Change-Id:=
 I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1298<br>Message-I=
d: &lt;20251116183336.11447-1-gert@...1296...&gt;<br>URL: https://www.mail-=
archive.com/openvpn-devel@lists.sourceforge.net/msg34480.html<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<br>=
1 file changed, 6 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1298/5</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>inde=
x 896fd65..2d24f5e 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br=
><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -3962,24 +3962,24 @@</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> voi=
d</span><br><span> tls_prepend_opcode_v1(const struct tls_multi *multi, str=
uct buffer *buf)</span><br><span> {</span><br><span>     struct key_state *=
ks =3D multi-&gt;save_ks;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    uint8_t op;</span><br><span> </span><br><span>     msg(D_TLS_DEBUG,=
 __func__);</span><br><span> </span><br><span>     ASSERT(ks);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ks-&gt;key_id &lt;=3D=
 P_KEY_ID_MASK);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    op =3D (P_DATA_V1 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D=
 (P_DATA_V1 &lt;&lt; P_OPCODE_SHIFT) | (uint8_t)ks-&gt;key_id;</span><br><s=
pan>     ASSERT(buf_write_prepend(buf, &amp;op, 1));</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> void</span><br><span> tls_prepend_opcode_v2(const st=
ruct tls_multi *multi, struct buffer *buf)</span><br><span> {</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1298?usp=3Demail">change 1298</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1298?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb438=
0ac91b09c1c8d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1298 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Gy4kPwxguKE=--

