From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 13:03:07 +0000
In-Reply-To: <gerrit.1762519477000.I429d768fb33ef2c58484287d4091440ad8599053@...2715...>
References: <gerrit.1762519477000.I429d768fb33ef2c58484287d4091440ad8599053@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <867319a2c4c4d9047084685783047307fdb92616-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZvvVGoye3jM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not underestimate
 number of encrypted/decrypted AEAD blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZvvVGoye3jM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
58?usp=3Demail )

Change subject: Do not underestimate number of encrypted/decrypted AEAD blo=
cks
......................................................................

Do not underestimate number of encrypted/decrypted AEAD blocks

Even though the current code typically counts all the encrypted/decrypted
traffic, this is only the case because of the specific implementation
of OpenSSL at the moment.

Instead of counting the length returned by one call only, count all
the encrypted/decrypted bytes.

Other implementations that use AES-GCM (like IPSec, MacSEC, TLS 1.2)
(currently) do not honour these usage limits at all. This is the reason that
I also currently do not consider the lack/improper validation in our code
to be a security vulnerability. In the current state implementations/protoc=
ol
that lack this feature altogether are not considered vulnerable.

Reported by: <stephan@...2953...>

Change-Id: I429d768fb33ef2c58484287d4091440ad8599053
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1358
Message-Id: <20251112112133.1325-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
1 file changed, 6 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 307d1ee..8049b3a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -152,15 +152,15 @@
     ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf),=
 BLEN(buf)));
     ASSERT(buf_inc_len(&work, outlen));

-    /* update number of plaintext blocks encrypted. Use the (x + (n-1))/n =
trick
-     * to round up the result to the number of blocks used */
-    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi.encrypt.plaintext_blocks +=3D (outlen + (blocksize - 1=
)) / blocksize;
-
     /* Flush the encryption buffer */
     ASSERT(cipher_ctx_final(ctx->cipher, BEND(&work), &outlen));
     ASSERT(buf_inc_len(&work, outlen));

+    /* update number of plaintext blocks encrypted. Use the (x + (n-1))/n =
trick
+     * to round up the result to the number of blocks used */
+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.encrypt.plaintext_blocks +=3D (BLEN(&work) + (blocksiz=
e - 1)) / blocksize;
+
     /* if the tag is at end the end, allocate it now */
     if (use_epoch_data_format)
     {
@@ -580,11 +580,10 @@
         goto error_exit;
     }

-
     /* update number of plaintext blocks decrypted. Use the (x + (n-1))/n =
trick
      * to round up the result to the number of blocks used. */
     const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize - 1=
)) / blocksize;
+    opt->key_ctx_bi.decrypt.plaintext_blocks +=3D (BLEN(&work) + (blocksiz=
e - 1)) / blocksize;

     *buf =3D work;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I429d768fb33ef2c58484287d4091440ad8599053
Gerrit-Change-Number: 1358
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZvvVGoye3jM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1358?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Do not underestimate number of encrypted/decrypt=
ed AEAD blocks<br><br>Even though the current code typically counts all the=
 encrypted/decrypted<br>traffic, this is only the case because of the speci=
fic implementation<br>of OpenSSL at the moment.<br><br>Instead of counting =
the length returned by one call only, count all<br>the encrypted/decrypted =
bytes.<br><br>Other implementations that use AES-GCM (like IPSec, MacSEC, T=
LS 1.2)<br>(currently) do not honour these usage limits at all. This is the=
 reason that<br>I also currently do not consider the lack/improper validati=
on in our code<br>to be a security vulnerability. In the current state impl=
ementations/protocol<br>that lack this feature altogether are not considere=
d vulnerable.<br><br>Reported by: &lt;stephan@...2953...&gt;<br><br>Change-=
Id: I429d768fb33ef2c58484287d4091440ad8599053<br>Signed-off-by: Arne Schwab=
e &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1358<br>Message-Id: =
&lt;20251112112133.1325-1-gert@...1296...&gt;<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/crypto.c<br>1 file change=
d, 6 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span=
>index 307d1ee..8049b3a 100644</span><br><span>--- a/src/openvpn/crypto.c</=
span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -152,15 +152,1=
5 @@</span><br><span>     ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(&am=
p;work), &amp;outlen, BPTR(buf), BLEN(buf)));</span><br><span>     ASSERT(b=
uf_inc_len(&amp;work, outlen));</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* update number of plaintext blocks encryp=
ted. Use the (x + (n-1))/n trick</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * to round up the result to the number of blocks used */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int blocksize =
=3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    opt-&gt;key_ctx_bi.encrypt.plaintext_blocks +=3D (outlen + (blocksi=
ze - 1)) / blocksize;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     /* Flush the encryption buffer */</span><br><span>   =
  ASSERT(cipher_ctx_final(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen));</=
span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* update num=
ber of plaintext blocks encrypted. Use the (x + (n-1))/n trick</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * to round up the result to=
 the number of blocks used */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_bi.encrypt.plai=
ntext_blocks +=3D (BLEN(&amp;work) + (blocksize - 1)) / blocksize;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* if =
the tag is at end the end, allocate it now */</span><br><span>     if (use_=
epoch_data_format)</span><br><span>     {</span><br><span>@@ -580,11 +580,1=
0 @@</span><br><span>         goto error_exit;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span>     /* update number of plaintext blocks decrypted. Use the (x + (=
n-1))/n trick</span><br><span>      * to round up the result to the number =
of blocks used. */</span><br><span>     const int blocksize =3D AEAD_LIMIT_=
BLOCKSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opt-&gt=
;key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize - 1)) / bloc=
ksize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;k=
ey_ctx_bi.decrypt.plaintext_blocks +=3D (BLEN(&amp;work) + (blocksize - 1))=
 / blocksize;</span><br><span> </span><br><span>     *buf =3D work;</span><=
br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail">change 1358</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I429d768fb33ef2c58484287d409=
1440ad8599053 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1358 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ZvvVGoye3jM=--

