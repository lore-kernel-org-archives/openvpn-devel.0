From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 12:45:31 +0000
References: <gerrit.1758890729000.I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fa8498f6f3c30d67c59f9a86d7a6527ad4ccb7ba-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CiFh8bj5i0A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_win: In
 dco_new_key, document size assumptions for the integer casts
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

--CiFh8bj5i0A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1221?usp=3Demail

to review the following change.


Change subject: dco_win: In dco_new_key, document size assumptions for the =
integer casts
......................................................................

dco_win: In dco_new_key, document size assumptions for the integer casts

And make all casts explicit so that compiler doesn't complain.

Change-Id: I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/dco_win.c
1 file changed, 5 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1221/1

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9e52859..7dd43d6 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -525,11 +525,6 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_sl=
ot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const u=
int8_t *decrypt_key,
@@ -540,21 +535,23 @@

     const int nonce_len =3D 8;
     size_t key_len =3D cipher_kt_key_size(ciphername);
+    ASSERT(key_len <=3D 32);

     OVPN_CRYPTO_DATA crypto_data;
     ZeroMemory(&crypto_data, sizeof(crypto_data));

     crypto_data.CipherAlg =3D dco_get_cipher(ciphername);
-    crypto_data.KeyId =3D keyid;
+    ASSERT(keyid > 0 && keyid <=3D UCHAR_MAX);
+    crypto_data.KeyId =3D (unsigned char)keyid;
     crypto_data.PeerId =3D peerid;
     crypto_data.KeySlot =3D slot;

     CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
-    crypto_data.Encrypt.KeyLen =3D (char)key_len;
+    crypto_data.Encrypt.KeyLen =3D (unsigned char)key_len;
     CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);

     CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
-    crypto_data.Decrypt.KeyLen =3D (char)key_len;
+    crypto_data.Decrypt.KeyLen =3D (unsigned char)key_len;
     CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);

     ASSERT(crypto_data.CipherAlg > 0);
@@ -570,10 +567,6 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1221?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258
Gerrit-Change-Number: 1221
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--CiFh8bj5i0A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1221?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_win: In dco_new_key, document size assumptions for the i=
nteger casts<br><br>And make all casts explicit so that compiler doesn&#39;=
t complain.<br><br>Change-Id: I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/o=
penvpn/dco_win.c<br>1 file changed, 5 insertions(+), 12 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1221/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><b=
r><span>index 9e52859..7dd43d6 100644</span><br><span>--- a/src/openvpn/dco=
_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -525,=
11 +525,6 @@</span><br><span>     return 0;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> dco_=
new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t =
slot,</span><br><span>             const uint8_t *encrypt_key, const uint8_=
t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span>@@ -540,21 +535,=
23 @@</span><br><span> </span><br><span>     const int nonce_len =3D 8;</sp=
an><br><span>     size_t key_len =3D cipher_kt_key_size(ciphername);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(key_len &lt;=3D=
 32);</span><br><span> </span><br><span>     OVPN_CRYPTO_DATA crypto_data;<=
/span><br><span>     ZeroMemory(&amp;crypto_data, sizeof(crypto_data));</sp=
an><br><span> </span><br><span>     crypto_data.CipherAlg =3D dco_get_ciphe=
r(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cry=
pto_data.KeyId =3D keyid;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(keyid &gt; 0 &amp;&amp; keyid &lt;=3D UCHAR_MAX);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    crypto_data.KeyId =3D (u=
nsigned char)keyid;</span><br><span>     crypto_data.PeerId =3D peerid;</sp=
an><br><span>     crypto_data.KeySlot =3D slot;</span><br><span> </span><br=
><span>     CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_data.Encrypt.Ke=
yLen =3D (char)key_len;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    crypto_data.Encrypt.KeyLen =3D (unsigned char)key_len;</span><br><s=
pan>     CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);<=
/span><br><span> </span><br><span>     CopyMemory(crypto_data.Decrypt.Key, =
decrypt_key, key_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    crypto_data.Decrypt.KeyLen =3D (char)key_len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    crypto_data.Decrypt.KeyLen =3D (unsigned=
 char)key_len;</span><br><span>     CopyMemory(crypto_data.Decrypt.NonceTai=
l, decrypt_iv, nonce_len);</span><br><span> </span><br><span>     ASSERT(cr=
ypto_data.CipherAlg &gt; 0);</span><br><span>@@ -570,10 +567,6 @@</span><br=
><span>     return 0;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</spa=
n><br><span> dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_s=
lot_t slot)</span><br><span> {</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1221?usp=3Demail">c=
hange 1221</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1221?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I612bf3b1c56d70a89fc04fad6fe=
36fd9fadfd258 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1221 </div>
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


--CiFh8bj5i0A=--

