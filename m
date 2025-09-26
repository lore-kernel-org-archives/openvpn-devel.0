From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 17:12:07 +0000
In-Reply-To: <gerrit.1758890729000.I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258@...2715...>
References: <gerrit.1758890729000.I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <14a852f7444b9bab2451a9a91b1c797f2240d47b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C7UpHlL2Hjs="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--C7UpHlL2Hjs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1221?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: dco_win: In dco_new_key, document size assumptions for the =
integer casts
......................................................................

dco_win: In dco_new_key, document size assumptions for the integer casts

And make all casts explicit so that compiler doesn't complain.

Change-Id: I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1221
Message-Id: <20250926165151.1502-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
229.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_win.c
1 file changed, 5 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1221/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--C7UpHlL2Hjs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1221?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">dco_win: In dco_new_key, document size assumptions fo=
r the integer casts<br><br>And make all casts explicit so that compiler doe=
sn&#39;t complain.<br><br>Change-Id: I612bf3b1c56d70a89fc04fad6fe36fd9fadfd=
258<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-b=
y: MaxF &lt;max@...2606...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/=
openvpn/+/1221<br>Message-Id: &lt;20250926165151.1502-1-gert@...1296...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg33229.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M src/openvpn/dco_win.c<br>1 file changed, 5 insertions(+), 12 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
21/1221/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.=
c</span><br><span>index 9e52859..7dd43d6 100644</span><br><span>--- a/src/o=
penvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><spa=
n>@@ -525,11 +525,6 @@</span><br><span>     return 0;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><s=
pan> dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_ke=
y_slot_t slot,</span><br><span>             const uint8_t *encrypt_key, con=
st uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span>@@ -540=
,21 +535,23 @@</span><br><span> </span><br><span>     const int nonce_len =
=3D 8;</span><br><span>     size_t key_len =3D cipher_kt_key_size(ciphernam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(key_l=
en &lt;=3D 32);</span><br><span> </span><br><span>     OVPN_CRYPTO_DATA cry=
pto_data;</span><br><span>     ZeroMemory(&amp;crypto_data, sizeof(crypto_d=
ata));</span><br><span> </span><br><span>     crypto_data.CipherAlg =3D dco=
_get_cipher(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    crypto_data.KeyId =3D keyid;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(keyid &gt; 0 &amp;&amp; keyid &lt;=3D UCHAR_MAX)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    crypto_data.Ke=
yId =3D (unsigned char)keyid;</span><br><span>     crypto_data.PeerId =3D p=
eerid;</span><br><span>     crypto_data.KeySlot =3D slot;</span><br><span> =
</span><br><span>     CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_=
len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_data.=
Encrypt.KeyLen =3D (char)key_len;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    crypto_data.Encrypt.KeyLen =3D (unsigned char)key_len;</s=
pan><br><span>     CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, no=
nce_len);</span><br><span> </span><br><span>     CopyMemory(crypto_data.Dec=
rypt.Key, decrypt_key, key_len);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    crypto_data.Decrypt.KeyLen =3D (char)key_len;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    crypto_data.Decrypt.KeyLen =3D=
 (unsigned char)key_len;</span><br><span>     CopyMemory(crypto_data.Decryp=
t.NonceTail, decrypt_iv, nonce_len);</span><br><span> </span><br><span>    =
 ASSERT(crypto_data.CipherAlg &gt; 0);</span><br><span>@@ -570,10 +567,6 @@=
</span><br><span>     return 0;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> int</span><br><span> dco_del_key(dco_context_t *dco, unsigned int peerid,=
 dco_key_slot_t slot)</span><br><span> {</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1221?usp=
=3Demail">change 1221</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1221?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I612bf3b1c56d70a89fc04fad6fe=
36fd9fadfd258 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1221 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--C7UpHlL2Hjs=--

