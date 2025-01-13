From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 13 Jan 2025 11:43:27 +0000
In-Reply-To: <gerrit.1736765057000.I0391f30a1e962ee242e9bcdec4f605bf7e831cca@...2715...>
References: <gerrit.1736765057000.I0391f30a1e962ee242e9bcdec4f605bf7e831cca@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <c3217362ef30ccabca3d84ad26f0fd3baa1ef5be-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="02Vag9pjios="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--02Vag9pjios=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/858?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by ordex


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/858/2

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
Gerrit-MessageType: newpatchset

--02Vag9pjios=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/858?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix &#39;uninitialized pointer read&#39; in openvpn_=
decrypt_aead<br><br>Coverity complains that if we error out in the first<br=
>error condition we try to free gc without initializing<br>it.<br><br>While=
 here move the declaration of outlen to the first<br>usage.<br><br>Change-I=
d: I0391f30a1e962ee242e9bcdec4f605bf7e831cca<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>Acked-by: Antonio Quartulli &lt;a@...2588...=
...&gt;<br>Message-Id: &lt;20250113112226.17728-1-gert@...1296...&gt;<br>UR=
L: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3042=
1.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M s=
rc/openvpn/crypto.c<br>1 file changed, 5 insertions(+), 5 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/858/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br=
><span>index 84ec436..dbd95a8 100644</span><br><span>--- a/src/openvpn/cryp=
to.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -406,17 =
+406,15 @@</span><br><span>     static const char error_prefix[] =3D &quot;=
AEAD Decrypt error&quot;;</span><br><span>     struct packet_id_net pin =3D=
 { 0 };</span><br><span>     struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_b=
i.decrypt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_init(&amp;gc);</s=
pan><br><span> </span><br><span>     if (cipher_decrypt_verify_fail_exceede=
d(ctx))</span><br><span>     {</span><br><span>         CRYPT_DROP(&quot;De=
cryption failed verification limit reached.&quot;);</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int outlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 gc_arena gc;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_init(&amp;gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(=
opt);</span><br><span>     ASSERT(frame);</span><br><span>     ASSERT(buf-&=
gt;len &gt; 0);</span><br><span>@@ -506,6 +504,8 @@</span><br><span>     dm=
sg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;,</span><br><span>          =
format_hex(ad_start, ad_size, 0, &amp;gc));</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int outlen;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Decrypt and =
authenticate packet */</span><br><span>     if (!cipher_ctx_update(ctx-&gt;=
cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf),</span><br><span>          =
                  data_len))</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/858?usp=3Demail">chan=
ge 858</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/858?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--02Vag9pjios=--

