From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 13 Jan 2025 11:43:31 +0000
In-Reply-To: <gerrit.1736765057000.I0391f30a1e962ee242e9bcdec4f605bf7e831cca@...2715...>
References: <gerrit.1736765057000.I0391f30a1e962ee242e9bcdec4f605bf7e831cca@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <c3217362ef30ccabca3d84ad26f0fd3baa1ef5be-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M49KLgwjwQc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix 'uninitialized
 pointer read' in openvpn_decrypt_aead
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--M49KLgwjwQc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/85=
8?usp=3Demail )

Change subject: Fix 'uninitialized pointer read' in openvpn_decrypt_aead
......................................................................

Fix 'uninitialized pointer read' in openvpn_decrypt_aead

Coverity complains that if we error out in the first
error condition we try to free gc without initializing
it.

While here move the declaration of outlen to the first
usage.

Change-Id: I0391f30a1e962ee242e9bcdec4f605bf7e831cca
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <a@...2181...>
Message-Id: <20250113112226.17728-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
421.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
1 file changed, 5 insertions(+), 5 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--M49KLgwjwQc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/858?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix &#39;uninitialized pointer read&#39; in op=
envpn_decrypt_aead<br><br>Coverity complains that if we error out in the fi=
rst<br>error condition we try to free gc without initializing<br>it.<br><br=
>While here move the declaration of outlen to the first<br>usage.<br><br>Ch=
ange-Id: I0391f30a1e962ee242e9bcdec4f605bf7e831cca<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Antonio Quartulli &lt;a@...220...=
..2181...&gt;<br>Message-Id: &lt;20250113112226.17728-1-gert@...1296...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg30421.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M src/openvpn/crypto.c<br>1 file changed, 5 insertions(+), 5 deletions(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span=
>index 84ec436..dbd95a8 100644</span><br><span>--- a/src/openvpn/crypto.c</=
span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -406,17 +406,1=
5 @@</span><br><span>     static const char error_prefix[] =3D &quot;AEAD D=
ecrypt error&quot;;</span><br><span>     struct packet_id_net pin =3D { 0 }=
;</span><br><span>     struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.decr=
ypt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_init(&amp;gc);</span><b=
r><span> </span><br><span>     if (cipher_decrypt_verify_fail_exceeded(ctx)=
)</span><br><span>     {</span><br><span>         CRYPT_DROP(&quot;Decrypti=
on failed verification limit reached.&quot;);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ou=
tlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_ar=
ena gc;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    gc_init(&amp;gc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(opt);<=
/span><br><span>     ASSERT(frame);</span><br><span>     ASSERT(buf-&gt;len=
 &gt; 0);</span><br><span>@@ -506,6 +504,8 @@</span><br><span>     dmsg(D_P=
ACKET_CONTENT, &quot;DECRYPT AD: %s&quot;,</span><br><span>          format=
_hex(ad_start, ad_size, 0, &amp;gc));</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int outlen;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Decrypt and auth=
enticate packet */</span><br><span>     if (!cipher_ctx_update(ctx-&gt;ciph=
er, BPTR(&amp;work), &amp;outlen, BPTR(buf),</span><br><span>              =
              data_len))</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/858?usp=3Demail">change 8=
58</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/858?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0391f30a1e962ee242e9bcdec4f=
605bf7e831cca </div>
<div style=3D"display:none"> Gerrit-Change-Number: 858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--M49KLgwjwQc=--

