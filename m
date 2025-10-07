From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 11:15:05 +0000
In-Reply-To: <gerrit.1758731785000.I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88@...2715...>
References: <gerrit.1758731785000.I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...,
 gert@...1296...
Message-ID: <0727375528d9e63fb8581afed52eab7489663909-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K9R7pnmEZtk="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, MaxF <max@...2606...>

--K9R7pnmEZtk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1217?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by cron2, Code-Review-1 by flichtenheld


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
1 file changed, 7 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1217/4

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6376c11..307d1ee 100644
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
@@ -1366,8 +1361,8 @@
     int state =3D PARSE_INITIAL;

     /* constants */
-    const int hlen =3D strlen(static_key_head);
-    const int flen =3D strlen(static_key_foot);
+    const int hlen =3D (int)strlen(static_key_head);
+    const int flen =3D (int)strlen(static_key_foot);
     const int onekeylen =3D sizeof(key2->keys[0]);

     CLEAR(*key2);
@@ -1378,7 +1373,9 @@
      */
     if (flags & RKF_INLINE) /* 'file' is a string containing ascii represe=
ntation of key */
     {
-        size =3D strlen(file) + 1;
+        size_t buf_size =3D strlen(file) + 1;
+        ASSERT(buf_size <=3D INT_MAX);
+        size =3D (int)buf_size;
         buf_set_read(&in, (const uint8_t *)file, size);
     }
     else /* 'file' is a filename which refers to a file containing the asc=
ii key */
@@ -1537,10 +1534,6 @@
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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88
Gerrit-Change-Number: 1217
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>

--K9R7pnmEZtk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2, flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1217?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2, Code-Review-1 by flichtenheld</p><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">cryp=
to: Make some casts to int explicit<br><br>In all of these cases the cast i=
s safe to do<br>since we have limits imposed in other ways.<br><br>And we w=
ant those values as int, so no<br>alternative to casting.<br><br>Change-Id:=
 I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/crypto.c<br>1 file cha=
nged, 7 insertions(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1217/4</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index 6=
376c11..307d1ee 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br=
><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -186,11 +186,6 @@</spa=
n><br><span>     return;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static void</span><br><span> openvpn_encrypt_=
v1(struct buffer *buf, struct buffer work, struct crypto_options *opt)</spa=
n><br><span> {</span><br><span>@@ -302,7 +297,7 @@</span><br><span>        =
 if (ctx-&gt;hmac)</span><br><span>         {</span><br><span>             =
hmac_ctx_reset(ctx-&gt;hmac);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            hmac_ctx_update(ctx-&gt;hmac, hmac_start, BEND(&amp;wor=
k) - hmac_start);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          hmac_ctx_update(ctx-&gt;hmac, hmac_start, (int)(BEND(&amp;work) -=
 hmac_start));</span><br><span>             hmac_ctx_final(ctx-&gt;hmac, ma=
c_out);</span><br><span>             dmsg(D_PACKET_CONTENT, &quot;ENCRYPT H=
MAC: %s&quot;,</span><br><span>                  format_hex(mac_out, hmac_c=
tx_size(ctx-&gt;hmac), 80, &amp;gc));</span><br><span>@@ -533,7 +528,7 @@</=
span><br><span>         }</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const int ad_size =3D BPTR=
(buf) - ad_start;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const int ad_size =3D (int)(BPTR(buf) - ad_start);</span><br><span> </spa=
n><br><span>     uint8_t *tag_ptr =3D NULL;</span><br><span>     int data_l=
en =3D 0;</span><br><span>@@ -1366,8 +1361,8 @@</span><br><span>     int st=
ate =3D PARSE_INITIAL;</span><br><span> </span><br><span>     /* constants =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int hlen =
=3D strlen(static_key_head);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const int flen =3D strlen(static_key_foot);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const int hlen =3D (int)strlen(stati=
c_key_head);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st int flen =3D (int)strlen(static_key_foot);</span><br><span>     const in=
t onekeylen =3D sizeof(key2-&gt;keys[0]);</span><br><span> </span><br><span=
>     CLEAR(*key2);</span><br><span>@@ -1378,7 +1373,9 @@</span><br><span> =
     */</span><br><span>     if (flags &amp; RKF_INLINE) /* &#39;file&#39; =
is a string containing ascii representation of key */</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        size =3D str=
len(file) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   size_t buf_size =3D strlen(file) + 1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ASSERT(buf_size &lt;=3D INT_MAX);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        size =3D (int)buf_size;<=
/span><br><span>         buf_set_read(&amp;in, (const uint8_t *)file, size)=
;</span><br><span>     }</span><br><span>     else /* &#39;file&#39; is a f=
ilename which refers to a file containing the ascii key */</span><br><span>=
@@ -1537,10 +1534,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> int</span><br><span> write_key_file(const i=
nt nkeys, const char *filename)</span><br><span> {</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1217?usp=3Demail">change 1217</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
17?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b8dd8d5671e31dba2a23a0a78f=
36d9dda034b88 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1217 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>

</body></html>=

--K9R7pnmEZtk=--

