From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 16:36:32 +0000
References: <gerrit.1758731785000.Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1b35141259651c7e3e33288dfd7eed5026694634-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rIK0igZ3Kzc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rIK0igZ3Kzc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1215?usp=3Demail

to review the following change.


Change subject: comp-lz4: Fix types in call to LZ4_decompress_safe
......................................................................

comp-lz4: Fix types in call to LZ4_decompress_safe

This is ints all around but we uselessly threw some
size_t conversions in there.

Change-Id: Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/comp-lz4.c
1 file changed, 5 insertions(+), 15 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1215/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--rIK0igZ3Kzc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1215?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">comp-lz4: Fix types in call to LZ4_decompress_safe<br><br>Th=
is is ints all around but we uselessly threw some<br>size_t conversions in =
there.<br><br>Change-Id: Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvp=
n/comp-lz4.c<br>1 file changed, 5 insertions(+), 15 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1215/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c</span><br>=
<span>index a78c664..53a5b3f 100644</span><br><span>--- a/src/openvpn/comp-=
lz4.c</span><br><span>+++ b/src/openvpn/comp-lz4.c</span><br><span>@@ -88,1=
9 +88,13 @@</span><br><span>     compv2_escape_data_ifneeded(buf);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wc=
onversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_lz4_decomp=
ress(size_t zlen_max, struct buffer *work, struct buffer *buf,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+do_lz4_decompress(int zlen_max, =
struct buffer *work, struct buffer *buf,</span><br><span>                  =
 struct compress_context *compctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int uncomp_len;</span><br><span>     AS=
SERT(buf_safe(work, zlen_max));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    uncomp_len =3D LZ4_decompress_safe((const char *)BPTR(buf), (=
char *)BPTR(work), (size_t)BLEN(buf),</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                     zlen_max);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int uncomp_len =3D LZ4_deco=
mpress_safe((const char *)BPTR(buf), (char *)BPTR(work), BLEN(buf),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
              zlen_max);</span><br><span>     if (uncomp_len &lt;=3D 0)</sp=
an><br><span>     {</span><br><span>         dmsg(D_COMP_ERRORS, &quot;LZ4 =
decompression error: %d&quot;, uncomp_len);</span><br><span>@@ -118,15 +112=
,11 @@</span><br><span>     *buf =3D *work;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> static void</span><br><span> lz4_decompress(struct buffer *bu=
f, struct buffer work, struct compress_context *compctx,</span><br><span>  =
              const struct frame *frame)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    size_t zlen_max =3D frame-&gt;buf=
.payload_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt zlen_max =3D frame-&gt;buf.payload_size;</span><br><span>     uint8_t c;=
 /* flag indicating whether or not our peer compressed */</span><br><span> =
</span><br><span>     if (buf-&gt;len &lt;=3D 0)</span><br><span>@@ -163,7 =
+153,7 @@</span><br><span> lz4v2_decompress(struct buffer *buf, struct buff=
er work, struct compress_context *compctx,</span><br><span>                =
  const struct frame *frame)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    size_t zlen_max =3D frame-&gt;buf.payload_siz=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int zlen_max =
=3D frame-&gt;buf.payload_size;</span><br><span>     uint8_t c; /* flag ind=
icating whether or not our peer compressed */</span><br><span> </span><br><=
span>     if (buf-&gt;len &lt;=3D 0)</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1215?usp=3Dem=
ail">change 1215</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1215?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie550dd4df65dc4fc13c839c3e74=
5ba96e0c5c564 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1215 </div>
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


--rIK0igZ3Kzc=--

