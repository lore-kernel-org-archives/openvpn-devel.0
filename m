From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 17:05:46 +0000
In-Reply-To: <gerrit.1758731785000.Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564@...2715...>
References: <gerrit.1758731785000.Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <71a50457772349a280e9d36a29836382e28689bb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+jocSz7nEsI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: comp-lz4: Fix types
 in call to LZ4_decompress_safe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+jocSz7nEsI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1215?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: comp-lz4: Fix types in call to LZ4_decompress_safe
......................................................................

comp-lz4: Fix types in call to LZ4_decompress_safe

This is ints all around but we uselessly threw some
size_t conversions in there.

Change-Id: Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1215
Message-Id: <20250926164845.1215-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
228.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/comp-lz4.c
1 file changed, 5 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1215/2

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index a78c664..53a5b3f 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -88,19 +88,13 @@
     compv2_escape_data_ifneeded(buf);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
-do_lz4_decompress(size_t zlen_max, struct buffer *work, struct buffer *buf,
+do_lz4_decompress(int zlen_max, struct buffer *work, struct buffer *buf,
                   struct compress_context *compctx)
 {
-    int uncomp_len;
     ASSERT(buf_safe(work, zlen_max));
-    uncomp_len =3D LZ4_decompress_safe((const char *)BPTR(buf), (char *)BP=
TR(work), (size_t)BLEN(buf),
-                                     zlen_max);
+    int uncomp_len =3D LZ4_decompress_safe((const char *)BPTR(buf), (char =
*)BPTR(work), BLEN(buf),
+                                         zlen_max);
     if (uncomp_len <=3D 0)
     {
         dmsg(D_COMP_ERRORS, "LZ4 decompression error: %d", uncomp_len);
@@ -118,15 +112,11 @@
     *buf =3D *work;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 lz4_decompress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,
                const struct frame *frame)
 {
-    size_t zlen_max =3D frame->buf.payload_size;
+    int zlen_max =3D frame->buf.payload_size;
     uint8_t c; /* flag indicating whether or not our peer compressed */

     if (buf->len <=3D 0)
@@ -163,7 +153,7 @@
 lz4v2_decompress(struct buffer *buf, struct buffer work, struct compress_c=
ontext *compctx,
                  const struct frame *frame)
 {
-    size_t zlen_max =3D frame->buf.payload_size;
+    int zlen_max =3D frame->buf.payload_size;
     uint8_t c; /* flag indicating whether or not our peer compressed */

     if (buf->len <=3D 0)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1215?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564
Gerrit-Change-Number: 1215
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--+jocSz7nEsI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1215?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">comp-lz4: Fix types in call to LZ4_decompress_safe<br=
><br>This is ints all around but we uselessly threw some<br>size_t conversi=
ons in there.<br><br>Change-Id: Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Ma=
xF &lt;max@...2606...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openv=
pn/+/1215<br>Message-Id: &lt;20250926164845.1215-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg332=
28.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/comp-lz4.c<br>1 file changed, 5 insertions(+), 15 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1=
215/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c<=
/span><br><span>index a78c664..53a5b3f 100644</span><br><span>--- a/src/ope=
nvpn/comp-lz4.c</span><br><span>+++ b/src/openvpn/comp-lz4.c</span><br><spa=
n>@@ -88,19 +88,13 @@</span><br><span>     compv2_escape_data_ifneeded(buf)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored=
 &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_=
lz4_decompress(size_t zlen_max, struct buffer *work, struct buffer *buf,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+do_lz4_decompress(int =
zlen_max, struct buffer *work, struct buffer *buf,</span><br><span>        =
           struct compress_context *compctx)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int uncomp_len;</span><br><sp=
an>     ASSERT(buf_safe(work, zlen_max));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    uncomp_len =3D LZ4_decompress_safe((const char *)BP=
TR(buf), (char *)BPTR(work), (size_t)BLEN(buf),</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                     zlen_max);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int uncomp_len =
=3D LZ4_decompress_safe((const char *)BPTR(buf), (char *)BPTR(work), BLEN(b=
uf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                          zlen_max);</span><br><span>     if (uncomp_len &l=
t;=3D 0)</span><br><span>     {</span><br><span>         dmsg(D_COMP_ERRORS=
, &quot;LZ4 decompression error: %d&quot;, uncomp_len);</span><br><span>@@ =
-118,15 +112,11 @@</span><br><span>     *buf =3D *work;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> static void</span><br><span> lz4_decompress(struc=
t buffer *buf, struct buffer work, struct compress_context *compctx,</span>=
<br><span>                const struct frame *frame)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t zlen_max =3D f=
rame-&gt;buf.payload_size;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int zlen_max =3D frame-&gt;buf.payload_size;</span><br><span>   =
  uint8_t c; /* flag indicating whether or not our peer compressed */</span=
><br><span> </span><br><span>     if (buf-&gt;len &lt;=3D 0)</span><br><spa=
n>@@ -163,7 +153,7 @@</span><br><span> lz4v2_decompress(struct buffer *buf,=
 struct buffer work, struct compress_context *compctx,</span><br><span>    =
              const struct frame *frame)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    size_t zlen_max =3D frame-&gt;buf=
.payload_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt zlen_max =3D frame-&gt;buf.payload_size;</span><br><span>     uint8_t c;=
 /* flag indicating whether or not our peer compressed */</span><br><span> =
</span><br><span>     if (buf-&gt;len &lt;=3D 0)</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
215?usp=3Demail">change 1215</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1215?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie550dd4df65dc4fc13c839c3e74=
5ba96e0c5c564 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1215 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+jocSz7nEsI=--

