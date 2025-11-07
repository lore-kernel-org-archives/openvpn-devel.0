From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 12:44:40 +0000
References: <gerrit.1762519477000.I429d768fb33ef2c58484287d4091440ad8599053@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <fa73515f02aa8ac1d11e9536df727411885d7a71-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mpZt/PoukgU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mpZt/PoukgU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail

to review the following change.


Change subject: Do not underestimate number of encrypted/decrypted  AEAD bl=
ocks
......................................................................

Do not underestimate number of encrypted/decrypted  AEAD blocks

Even thought the current code typically counts all the encrypted/decrypted
traffic, this is only the case because of the specific implementation
of OpenSSL at the moment.

Instead of counting the length returned by one call only, count all
the encrypted/decrypted bytes.

Other implementations that AES-GCM (like IPSec, MacSEC, TLS 1.2) currently
do not honour these usage limits at all. So this currently not something
that I consider to be security vulnerability since currently this something
that enhances security but is not yet required so to say.

Reported by: <stephan@...2953...>

Change-Id: I429d768fb33ef2c58484287d4091440ad8599053
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
1 file changed, 6 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/1358/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I429d768fb33ef2c58484287d4091440ad8599053
Gerrit-Change-Number: 1358
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--mpZt/PoukgU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Do not underestimate number of encrypted/de=
crypted  AEAD blocks<br><br>Even thought the current code typically counts =
all the encrypted/decrypted<br>traffic, this is only the case because of th=
e specific implementation<br>of OpenSSL at the moment.<br><br>Instead of co=
unting the length returned by one call only, count all<br>the encrypted/dec=
rypted bytes.<br><br>Other implementations that AES-GCM (like IPSec, MacSEC=
, TLS 1.2) currently<br>do not honour these usage limits at all. So this cu=
rrently not something<br>that I consider to be security vulnerability since=
 currently this something<br>that enhances security but is not yet required=
 so to say.<br><br>Reported by: &lt;stephan@...2953...&gt;<br><br>Change-Id=
: I429d768fb33ef2c58484287d4091440ad8599053<br>Signed-off-by: Arne Schwabe =
&lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>1 file changed,=
 6 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/58/1358/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index 307=
d1ee..8049b3a 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><=
span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -152,15 +152,15 @@</span=
><br><span>     ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(&amp;work), &=
amp;outlen, BPTR(buf), BLEN(buf)));</span><br><span>     ASSERT(buf_inc_len=
(&amp;work, outlen));</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* update number of plaintext blocks encrypted. Use t=
he (x + (n-1))/n trick</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * to round up the result to the number of blocks used */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const int blocksize =3D AEAD_L=
IMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    op=
t-&gt;key_ctx_bi.encrypt.plaintext_blocks +=3D (outlen + (blocksize - 1)) /=
 blocksize;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     /* Flush the encryption buffer */</span><br><span>     ASSERT(c=
ipher_ctx_final(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen));</span><br><=
span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* update number of pla=
intext blocks encrypted. Use the (x + (n-1))/n trick</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * to round up the result to the numb=
er of blocks used */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_bi.encrypt.plaintext_blo=
cks +=3D (BLEN(&amp;work) + (blocksize - 1)) / blocksize;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* if the tag i=
s at end the end, allocate it now */</span><br><span>     if (use_epoch_dat=
a_format)</span><br><span>     {</span><br><span>@@ -580,11 +580,10 @@</spa=
n><br><span>         goto error_exit;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
    /* update number of plaintext blocks decrypted. Use the (x + (n-1))/n t=
rick</span><br><span>      * to round up the result to the number of blocks=
 used. */</span><br><span>     const int blocksize =3D AEAD_LIMIT_BLOCKSIZE=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opt-&gt;key_ctx_=
bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize - 1)) / blocksize;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_bi=
.decrypt.plaintext_blocks +=3D (BLEN(&amp;work) + (blocksize - 1)) / blocks=
ize;</span><br><span> </span><br><span>     *buf =3D work;</span><br><span>=
 </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1358?usp=3Demail">change 1358</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1358?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I429d768fb33ef2c58484287d409=
1440ad8599053 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1358 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--mpZt/PoukgU=--

