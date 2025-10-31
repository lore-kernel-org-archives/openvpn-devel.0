From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Oct 2025 11:19:22 +0000
In-Reply-To: <gerrit.1761580588000.Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c@...2715...>
References: <gerrit.1761580588000.Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <56e6cbc34744b2efe990b08c006724a4275183b6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ARQUZZ1TviM="; charset=UTF-8
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
To: MaxF <max@...2606...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ARQUZZ1TviM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
15?usp=3Demail )

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

Reported-By: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c
Signed-off-by: Max Fillinger <max@...2606...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1315
Message-Id: <20251031100819.24855-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
103.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_pkt.c
M src/openvpn/tls_crypt.c
2 files changed, 7 insertions(+), 5 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c
Gerrit-Change-Number: 1315
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ARQUZZ1TviM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1315?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Zeroize tls-crypt-v2 client keys<br><br>Joshua R=
ogers sent in a bug report generated with ZeroPath that the<br>tls-crypt-v2=
 client key is loaded before running the verify script. If<br>the verify sc=
ript fails, the key is not zeroized.<br><br>While investigating this report=
, I found that free_tls_pre_decrypt_state<br>never zeroizes tls_wrap_tmp.or=
iginal_wrap_keydata. So also when the<br>check is successful, key data will=
 remain in memory when it is no longer<br>needed.<br><br>This commit moves =
the tls-crypt-v2-verify check before loading the key.<br>If it fails, origi=
nal_wrap_keydata is zeroized. Also, in<br>free_tls_pre_decrypt_state, if a =
key has been loaded,<br>original_wrap_keydata is zeroized.<br><br>Reported-=
By: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https:/=
/zeropath.com/)<br><br>Change-Id: Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c=
<br>Signed-off-by: Max Fillinger &lt;max@...2606...&gt;<br>Acked-by: Arne S=
chwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvp=
n.net/c/openvpn/+/1315<br>Message-Id: &lt;20251031100819.24855-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg34103.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M src/openvpn/ssl_pkt.c<br>M src/openvpn/tls_crypt.c<br>2 files=
 changed, 7 insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><sp=
an>index 825719c..d7f7ac3 100644</span><br><span>--- a/src/openvpn/ssl_pkt.=
c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ -280,6 +28=
0,7 @@</span><br><span>     if (state-&gt;tls_wrap_tmp.cleanup_key_ctx)</sp=
an><br><span>     {</span><br><span>         free_key_ctx_bi(&amp;state-&gt=
;tls_wrap_tmp.opt.key_ctx_bi);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        secure_memzero(&amp;state-&gt;tls_wrap_tmp.original_wrap=
_keydata, sizeof(state-&gt;tls_wrap_tmp.original_wrap_keydata));</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index=
 51b4eb3..a808de3 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</spa=
n><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -642,6 +642,12=
 @@</span><br><span>         return false;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt=
 &amp;&amp; opt-&gt;tls_crypt_v2_verify_script &amp;&amp; !tls_crypt_v2_ver=
ify_metadata(ctx, opt))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        se=
cure_memzero(&amp;ctx-&gt;original_wrap_keydata, sizeof(ctx-&gt;original_wr=
ap_keydata));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    /* Load the decrypted key */</span><br><span>     ctx-&gt;mode =3D TLS_=
WRAP_CRYPT;</span><br><span>     ctx-&gt;cleanup_key_ctx =3D true;</span><b=
r><span>@@ -652,11 +658,6 @@</span><br><span>     /* Remove client key from=
 buffer so tls-crypt code can unwrap message */</span><br><span>     ASSERT=
(buf_inc_len(buf, -(BLEN(&amp;wrapped_client_key))));</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (opt &amp;&amp; op=
t-&gt;tls_crypt_v2_verify_script)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return tls_crypt_v2_verify_metadata(ctx, opt);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>     return true;</span><br><span> }</span><b=
r><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1315?usp=3Demail">change 1315</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1315?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfcbf8ee20c1c0016eb98b570f2=
4b9325b157c5c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1315 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ARQUZZ1TviM=--

