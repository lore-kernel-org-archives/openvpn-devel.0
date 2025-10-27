From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 15:56:30 +0000
References: <gerrit.1761580588000.Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ddf0232213c32dbdcfa1cb235a4f6ec59fe3f95a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RvMextVcS+k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Zeroize tls-crypt-v2
 client keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RvMextVcS+k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1315?usp=3Demail

to review the following change.


Change subject: Zeroize tls-crypt-v2 client keys
......................................................................

Zeroize tls-crypt-v2 client keys

Joshua Rogers sent in a bug report generated with ZeroPath that the
tls-crypt-v2 client key is loaded before running the verify script. If
the verify script fails, the key is not zeroized.

While investigating this report, I found that free_tls_pre_decrypt_state
never zeroizes tls_wrap_tmp.original_wrap_keydata. So also when the
check is successful, key data will remain in memory when it is no longer
needed.

This commit moves the tls-crypt-v2-verify check before loading the key.
If it fails, original_wrap_keydata is zeroized. Also, in
free_tls_pre_decrypt_state, if a key has been loaded,
original_wrap_keydata is zeroized.

Change-Id: Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c
Signed-off-by: Max Fillinger <max@...2606...>
---
M src/openvpn/ssl_pkt.c
M src/openvpn/tls_crypt.c
2 files changed, 7 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1315/1

diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 825719c..d7f7ac3 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -280,6 +280,7 @@
     if (state->tls_wrap_tmp.cleanup_key_ctx)
     {
         free_key_ctx_bi(&state->tls_wrap_tmp.opt.key_ctx_bi);
+        secure_memzero(&state->tls_wrap_tmp.original_wrap_keydata, sizeof(=
state->tls_wrap_tmp.original_wrap_keydata));
     }
 }

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 51b4eb3..a808de3 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -642,6 +642,12 @@
         return false;
     }

+    if (opt && opt->tls_crypt_v2_verify_script && !tls_crypt_v2_verify_met=
adata(ctx, opt))
+    {
+        secure_memzero(&ctx->original_wrap_keydata, sizeof(ctx->original_w=
rap_keydata));
+        return false;
+    }
+
     /* Load the decrypted key */
     ctx->mode =3D TLS_WRAP_CRYPT;
     ctx->cleanup_key_ctx =3D true;
@@ -652,11 +658,6 @@
     /* Remove client key from buffer so tls-crypt code can unwrap message =
*/
     ASSERT(buf_inc_len(buf, -(BLEN(&wrapped_client_key))));

-    if (opt && opt->tls_crypt_v2_verify_script)
-    {
-        return tls_crypt_v2_verify_metadata(ctx, opt);
-    }
-
     return true;
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1315?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c
Gerrit-Change-Number: 1315
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--RvMextVcS+k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1315?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Zeroize tls-crypt-v2 client keys<br><br>Jos=
hua Rogers sent in a bug report generated with ZeroPath that the<br>tls-cry=
pt-v2 client key is loaded before running the verify script. If<br>the veri=
fy script fails, the key is not zeroized.<br><br>While investigating this r=
eport, I found that free_tls_pre_decrypt_state<br>never zeroizes tls_wrap_t=
mp.original_wrap_keydata. So also when the<br>check is successful, key data=
 will remain in memory when it is no longer<br>needed.<br><br>This commit m=
oves the tls-crypt-v2-verify check before loading the key.<br>If it fails, =
original_wrap_keydata is zeroized. Also, in<br>free_tls_pre_decrypt_state, =
if a key has been loaded,<br>original_wrap_keydata is zeroized.<br><br>Chan=
ge-Id: Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c<br>Signed-off-by: Max Fill=
inger &lt;max@...2606...&gt;<br>---<br>M src/openvpn/ssl_pkt.c<br>M src/ope=
nvpn/tls_crypt.c<br>2 files changed, 7 insertions(+), 5 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/15/1315/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/s=
sl_pkt.c</span><br><span>index 825719c..d7f7ac3 100644</span><br><span>--- =
a/src/openvpn/ssl_pkt.c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span><=
br><span>@@ -280,6 +280,7 @@</span><br><span>     if (state-&gt;tls_wrap_tm=
p.cleanup_key_ctx)</span><br><span>     {</span><br><span>         free_key=
_ctx_bi(&amp;state-&gt;tls_wrap_tmp.opt.key_ctx_bi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        secure_memzero(&amp;state-&gt;tls=
_wrap_tmp.original_wrap_keydata, sizeof(state-&gt;tls_wrap_tmp.original_wra=
p_keydata));</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.=
c</span><br><span>index 51b4eb3..a808de3 100644</span><br><span>--- a/src/o=
penvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br>=
<span>@@ -642,6 +642,12 @@</span><br><span>         return false;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (opt &amp;&amp; opt-&gt;tls_crypt_v2_verify_script &amp;=
&amp; !tls_crypt_v2_verify_metadata(ctx, opt))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        secure_memzero(&amp;ctx-&gt;original_wrap_keydata, siz=
eof(ctx-&gt;original_wrap_keydata));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     /* Load the decrypted key */</span><br><span>   =
  ctx-&gt;mode =3D TLS_WRAP_CRYPT;</span><br><span>     ctx-&gt;cleanup_key=
_ctx =3D true;</span><br><span>@@ -652,11 +658,6 @@</span><br><span>     /*=
 Remove client key from buffer so tls-crypt code can unwrap message */</spa=
n><br><span>     ASSERT(buf_inc_len(buf, -(BLEN(&amp;wrapped_client_key))))=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (opt &amp;&amp; opt-&gt;tls_crypt_v2_verify_script)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return tls_crypt_v2_verify_metadata(ctx, opt);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return true;</spa=
n><br><span> }</span><br><span> </span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1315?usp=3Demail"=
>change 1315</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1315?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfcbf8ee20c1c0016eb98b570f2=
4b9325b157c5c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1315 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--RvMextVcS+k=--

