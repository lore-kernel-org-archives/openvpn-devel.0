From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 13 Jan 2025 10:44:19 +0000
References: <gerrit.1736765057000.I0391f30a1e962ee242e9bcdec4f605bf7e831cca@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <045ab59d11284a222e6ce5681d20fa7cb52ae84b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IJvbQXbumEQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix "uninitialized
 pointer read" in openvpn_decrypt_aead
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

--IJvbQXbumEQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/858?usp=3Demail

to review the following change.


Change subject: Fix "uninitialized pointer read" in openvpn_decrypt_aead
......................................................................

Fix "uninitialized pointer read" in openvpn_decrypt_aead

Coverity complains that if we error out in the first
error condition we try to free gc without initializing
it.

While here move the declaration of outlen to the first
usage.

Change-Id: I0391f30a1e962ee242e9bcdec4f605bf7e831cca
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.c
1 file changed, 5 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/858/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 84ec436..dbd95a8 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -406,17 +406,15 @@
     static const char error_prefix[] =3D "AEAD Decrypt error";
     struct packet_id_net pin =3D { 0 };
     struct key_ctx *ctx =3D &opt->key_ctx_bi.decrypt;
+    struct gc_arena gc;
+
+    gc_init(&gc);

     if (cipher_decrypt_verify_fail_exceeded(ctx))
     {
         CRYPT_DROP("Decryption failed verification limit reached.");
     }

-    int outlen;
-    struct gc_arena gc;
-
-    gc_init(&gc);
-
     ASSERT(opt);
     ASSERT(frame);
     ASSERT(buf->len > 0);
@@ -506,6 +504,8 @@
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",
          format_hex(ad_start, ad_size, 0, &gc));

+    int outlen;
+
     /* Decrypt and authenticate packet */
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
                            data_len))

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/858?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0391f30a1e962ee242e9bcdec4f605bf7e831cca
Gerrit-Change-Number: 858
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--IJvbQXbumEQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/858?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix &quot;uninitialized pointer read&quot; in openvpn_decrypt=
_aead<br><br>Coverity complains that if we error out in the first<br>error =
condition we try to free gc without initializing<br>it.<br><br>While here m=
ove the declaration of outlen to the first<br>usage.<br><br>Change-Id: I039=
1f30a1e962ee242e9bcdec4f605bf7e831cca<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@...2641...&gt;<br>---<br>M src/openvpn/crypto.c<br>1 file changed,=
 5 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/58/858/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cryp=
to.c b/src/openvpn/crypto.c</span><br><span>index 84ec436..dbd95a8 100644</=
span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn=
/crypto.c</span><br><span>@@ -406,17 +406,15 @@</span><br><span>     static=
 const char error_prefix[] =3D &quot;AEAD Decrypt error&quot;;</span><br><s=
pan>     struct packet_id_net pin =3D { 0 };</span><br><span>     struct ke=
y_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.decrypt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_init(&amp;gc);</span><br><span> </span><br><span>    =
 if (cipher_decrypt_verify_fail_exceeded(ctx))</span><br><span>     {</span=
><br><span>         CRYPT_DROP(&quot;Decryption failed verification limit r=
eached.&quot;);</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int outlen;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct gc_arena gc;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_init(&amp;gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span>     ASSERT(opt);</span><br><span>     ASSERT(f=
rame);</span><br><span>     ASSERT(buf-&gt;len &gt; 0);</span><br><span>@@ =
-506,6 +504,8 @@</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT =
AD: %s&quot;,</span><br><span>          format_hex(ad_start, ad_size, 0, &a=
mp;gc));</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int outlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     /* Decrypt and authenticate packet */</span><br><s=
pan>     if (!cipher_ctx_update(ctx-&gt;cipher, BPTR(&amp;work), &amp;outle=
n, BPTR(buf),</span><br><span>                            data_len))</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/858?usp=3Demail">change 858</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0391f30a1e962ee242e9bcdec4f=
605bf7e831cca </div>
<div style=3D"display:none"> Gerrit-Change-Number: 858 </div>
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


--IJvbQXbumEQ=--

