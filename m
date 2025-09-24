From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 16:36:33 +0000
References: <gerrit.1758731785000.I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ea5405e644a1be6d44f6cc28496eee558337e676-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FYASo4lBK4I="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto: Make some
 casts to int explicit
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

--FYASo4lBK4I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1217?usp=3Demail

to review the following change.


Change subject: crypto: Make some casts to int explicit
......................................................................

crypto: Make some casts to int explicit

In all of these cases the cast is safe to do
since we have limits imposed in other ways.

And we want those values as int, so no
alternative to casting.

Change-Id: I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.c
1 file changed, 3 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1217/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6376c11..13635fb 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -186,11 +186,6 @@
     return;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 openvpn_encrypt_v1(struct buffer *buf, struct buffer work, struct crypto_o=
ptions *opt)
 {
@@ -302,7 +297,7 @@
         if (ctx->hmac)
         {
             hmac_ctx_reset(ctx->hmac);
-            hmac_ctx_update(ctx->hmac, hmac_start, BEND(&work) - hmac_star=
t);
+            hmac_ctx_update(ctx->hmac, hmac_start, (int)(BEND(&work) - hma=
c_start));
             hmac_ctx_final(ctx->hmac, mac_out);
             dmsg(D_PACKET_CONTENT, "ENCRYPT HMAC: %s",
                  format_hex(mac_out, hmac_ctx_size(ctx->hmac), 80, &gc));
@@ -533,7 +528,7 @@
         }
     }

-    const int ad_size =3D BPTR(buf) - ad_start;
+    const int ad_size =3D (int)(BPTR(buf) - ad_start);

     uint8_t *tag_ptr =3D NULL;
     int data_len =3D 0;
@@ -1378,7 +1373,7 @@
      */
     if (flags & RKF_INLINE) /* 'file' is a string containing ascii represe=
ntation of key */
     {
-        size =3D strlen(file) + 1;
+        size =3D (int)(strlen(file) + 1);
         buf_set_read(&in, (const uint8_t *)file, size);
     }
     else /* 'file' is a filename which refers to a file containing the asc=
ii key */
@@ -1537,10 +1532,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 write_key_file(const int nkeys, const char *filename)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1217?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88
Gerrit-Change-Number: 1217
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--FYASo4lBK4I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1217?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">crypto: Make some casts to int explicit<br><br>In all of the=
se cases the cast is safe to do<br>since we have limits imposed in other wa=
ys.<br><br>And we want those values as int, so no<br>alternative to casting=
.<br><br>Change-Id: I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/cry=
pto.c<br>1 file changed, 3 insertions(+), 12 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1217/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index=
 6376c11..13635fb 100644</span><br><span>--- a/src/openvpn/crypto.c</span><=
br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -186,11 +186,6 @@</s=
pan><br><span>     return;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> static void</span><br><span> openvpn_encryp=
t_v1(struct buffer *buf, struct buffer work, struct crypto_options *opt)</s=
pan><br><span> {</span><br><span>@@ -302,7 +297,7 @@</span><br><span>      =
   if (ctx-&gt;hmac)</span><br><span>         {</span><br><span>           =
  hmac_ctx_reset(ctx-&gt;hmac);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            hmac_ctx_update(ctx-&gt;hmac, hmac_start, BEND(&amp;w=
ork) - hmac_start);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            hmac_ctx_update(ctx-&gt;hmac, hmac_start, (int)(BEND(&amp;work)=
 - hmac_start));</span><br><span>             hmac_ctx_final(ctx-&gt;hmac, =
mac_out);</span><br><span>             dmsg(D_PACKET_CONTENT, &quot;ENCRYPT=
 HMAC: %s&quot;,</span><br><span>                  format_hex(mac_out, hmac=
_ctx_size(ctx-&gt;hmac), 80, &amp;gc));</span><br><span>@@ -533,7 +528,7 @@=
</span><br><span>         }</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ad_size =3D BP=
TR(buf) - ad_start;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const int ad_size =3D (int)(BPTR(buf) - ad_start);</span><br><span> </s=
pan><br><span>     uint8_t *tag_ptr =3D NULL;</span><br><span>     int data=
_len =3D 0;</span><br><span>@@ -1378,7 +1373,7 @@</span><br><span>      */<=
/span><br><span>     if (flags &amp; RKF_INLINE) /* &#39;file&#39; is a str=
ing containing ascii representation of key */</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        size =3D strlen(file=
) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size =
=3D (int)(strlen(file) + 1);</span><br><span>         buf_set_read(&amp;in,=
 (const uint8_t *)file, size);</span><br><span>     }</span><br><span>     =
else /* &#39;file&#39; is a filename which refers to a file containing the =
ascii key */</span><br><span>@@ -1537,10 +1532,6 @@</span><br><span>     gc=
_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br=
><span> write_key_file(const int nkeys, const char *filename)</span><br><sp=
an> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1217?usp=3Demail">change 1217</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1217?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b8dd8d5671e31dba2a23a0a78f=
36d9dda034b88 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1217 </div>
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


--FYASo4lBK4I=--

