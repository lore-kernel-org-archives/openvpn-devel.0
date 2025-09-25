From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 25 Sep 2025 15:37:26 +0000
In-Reply-To: <gerrit.1758811182000.Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080@...2715...>
References: <gerrit.1758811182000.Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4120cb7364d1a1f81029c38019789a7ac77dfeb9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w2cqQTsKVLY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: support for
 epoch data channel
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

--w2cqQTsKVLY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail

to look at the new patch set (#2).


Change subject: dco-win: support for epoch data channel
......................................................................

dco-win: support for epoch data channel

Starting from 2.8.0, dco-win driver supports
epoch data channel. This adds missing userspace part.

Change-Id: Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/ovpn_dco_win.h
7 files changed, 66 insertions(+), 30 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1219/2

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 2cf90af..3a8eea9 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -56,8 +56,9 @@
                 const char *ciphername)

 {
-    msg(D_DCO_DEBUG, "%s: peer_id=3D%d keyid=3D%d, currently %d keys insta=
lled", __func__,
-        multi->dco_peer_id, ks->key_id, multi->dco_keys_installed);
+    bool epoch =3D ks->crypto_options.flags & CO_EPOCH_DATA_KEY_FORMAT;
+    msg(D_DCO_DEBUG, "%s: peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d=
 keys installed", __func__,
+        multi->dco_peer_id, ks->key_id, multi->dco_keys_installed, epoch);

     /* Install a key in the PRIMARY slot only when no other key exist.
      * From that moment on, any new key will be installed in the SECONDARY
@@ -71,7 +72,7 @@
     }

     int ret =3D dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, sl=
ot, encrypt_key, encrypt_iv,
-                          decrypt_key, decrypt_iv, ciphername);
+                          decrypt_key, decrypt_iv, ciphername, epoch);
     if ((ret =3D=3D 0) && (multi->dco_keys_installed < 2))
     {
         multi->dco_keys_installed++;
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index a362977..e5e8709 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -251,11 +251,8 @@
  * Return whether the dco implementation supports the new protocol feature=
s of
  * a 64 bit packet counter and AEAD tag at the end.
  */
-static inline bool
-dco_supports_epoch_data(struct context *c)
-{
-    return false;
-}
+bool
+dco_supports_epoch_data(struct context *c);
 #else  /* if defined(ENABLE_DCO) */

 typedef void *dco_context_t;
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b9f6bc7..947a769 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -487,14 +487,14 @@
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_sl=
ot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const u=
int8_t *decrypt_key,
-            const uint8_t *decrypt_iv, const char *ciphername)
+            const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
     struct ifdrv drv;
     nvlist_t *nvl, *encrypt_nvl, *decrypt_nvl;
     int ret;

-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __fu=
nc__, slot, keyid, peerid,
-        ciphername);
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch=
 %d", __func__, slot, keyid, peerid,
+        ciphername, epoch);

     nvl =3D nvlist_create(0);

@@ -876,4 +876,10 @@
     return "none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305";
 }

+bool
+dco_supports_epoch_data(struct context *c)
+{
+    return false;
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 83013ef..d1d5e2d 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -66,7 +66,7 @@

 int dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_ke=
y_slot_t slot,
                 const uint8_t *encrypt_key, const uint8_t *encrypt_iv, con=
st uint8_t *decrypt_key,
-                const uint8_t *decrypt_iv, const char *ciphername);
+                const uint8_t *decrypt_iv, const char *ciphername, bool ep=
och);

 int dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t sl=
ot);

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 395a38f..c349ab2 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -601,10 +601,10 @@
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_sl=
ot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const u=
int8_t *decrypt_key,
-            const uint8_t *decrypt_iv, const char *ciphername)
+            const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __fu=
nc__, slot, keyid, peerid,
-        ciphername);
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch=
 %d", __func__, slot, keyid, peerid,
+        ciphername, epoch);

     const size_t key_len =3D cipher_kt_key_size(ciphername);
     const int nonce_tail_len =3D 8;
@@ -1303,6 +1303,12 @@
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }

+bool
+dco_supports_epoch_data(struct context *c)
+{
+    return false;
+}
+
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9e52859..389cd38 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -533,7 +533,7 @@
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_sl=
ot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const u=
int8_t *decrypt_key,
-            const uint8_t *decrypt_iv, const char *ciphername)
+            const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
     msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __fu=
nc__, slot, keyid, peerid,
         ciphername);
@@ -541,28 +541,40 @@
     const int nonce_len =3D 8;
     size_t key_len =3D cipher_kt_key_size(ciphername);

-    OVPN_CRYPTO_DATA crypto_data;
+    OVPN_CRYPTO_DATA_V2 crypto_data;
     ZeroMemory(&crypto_data, sizeof(crypto_data));

-    crypto_data.CipherAlg =3D dco_get_cipher(ciphername);
-    crypto_data.KeyId =3D keyid;
-    crypto_data.PeerId =3D peerid;
-    crypto_data.KeySlot =3D slot;
+    OVPN_CRYPTO_DATA *v1 =3D &crypto_data.V1;

-    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
-    crypto_data.Encrypt.KeyLen =3D (char)key_len;
-    CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
+    v1->CipherAlg =3D dco_get_cipher(ciphername);
+    v1->KeyId =3D keyid;
+    v1->PeerId =3D peerid;
+    v1->KeySlot =3D slot;

-    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
-    crypto_data.Decrypt.KeyLen =3D (char)key_len;
-    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
+    CopyMemory(v1->Encrypt.Key, encrypt_key, key_len);
+    v1->Encrypt.KeyLen =3D (char)key_len;
+    CopyMemory(v1->Encrypt.NonceTail, encrypt_iv, nonce_len);

-    ASSERT(crypto_data.CipherAlg > 0);
+    CopyMemory(v1->Decrypt.Key, decrypt_key, key_len);
+    v1->Decrypt.KeyLen =3D (char)key_len;
+    CopyMemory(v1->Decrypt.NonceTail, decrypt_iv, nonce_len);
+
+    ASSERT(v1->CipherAlg > 0);
+
+    DWORD ioctl =3D OVPN_IOCTL_NEW_KEY;
+    VOID *buf =3D &crypto_data.V1;
+    DWORD bufSize =3D sizeof(crypto_data.V1);
+    if (epoch)
+    {
+        ioctl =3D OVPN_IOCTL_NEW_KEY_V2;
+        crypto_data.CryptoOptions |=3D CRYPTO_OPTIONS_EPOCH;
+        buf =3D &crypto_data;
+        bufSize =3D sizeof(crypto_data);
+    }

     DWORD bytes_returned =3D 0;

-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NEW_KEY, &crypto_data, =
sizeof(crypto_data), NULL,
-                         0, &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, ioctl, buf, bufSize, NULL, 0, &byt=
es_returned, NULL))
     {
         msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
         return -1;
@@ -1083,4 +1095,11 @@
     gc_free(&gc);
 }

+bool
+dco_supports_epoch_data(struct context *c)
+{
+    OVPN_VERSION ver =3D { 0 };
+    return dco_get_version(&ver) && ((ver.Major =3D=3D 2 && ver.Minor >=3D=
 8) || (ver.Major > 2));
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index 9e1378a..e76770b 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -118,6 +118,13 @@
 	int PeerId;
 } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;

+#define CRYPTO_OPTIONS_EPOCH (1<<1)
+
+typedef struct _OVPN_CRYPTO_DATA_V2 {
+    OVPN_CRYPTO_DATA V1;
+    UINT32 CryptoOptions;
+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;
+
 typedef struct _OVPN_MP_SET_PEER {
     int PeerId;
     LONG KeepaliveInterval;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080
Gerrit-Change-Number: 1219
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--w2cqQTsKVLY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, stipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">dco-win: support for epoch data channel<br><br>Starting from 2.8.0, dco-=
win driver supports<br>epoch data channel. This adds missing userspace part=
.<br><br>Change-Id: Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080<br>Signed-off=
-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco.c<br>M =
src/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_inter=
nal.h<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M src/open=
vpn/ovpn_dco_win.h<br>7 files changed, 66 insertions(+), 30 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/121=
9/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><s=
pan>index 2cf90af..3a8eea9 100644</span><br><span>--- a/src/openvpn/dco.c</=
span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -56,8 +56,9 @@</s=
pan><br><span>                 const char *ciphername)</span><br><span> </s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(D_DCO_DEBUG, &quot;%s: peer_id=3D%d keyid=3D%d, currently %d keys instal=
led&quot;, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       multi-&gt;dco_peer_id, ks-&gt;key_id, multi-&gt;dco_keys_installed);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool epoch =3D =
ks-&gt;crypto_options.flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer=
_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys installed&quot;, __func__=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;=
dco_peer_id, ks-&gt;key_id, multi-&gt;dco_keys_installed, epoch);</span><br=
><span> </span><br><span>     /* Install a key in the PRIMARY slot only whe=
n no other key exist.</span><br><span>      * From that moment on, any new =
key will be installed in the SECONDARY</span><br><span>@@ -71,7 +72,7 @@</s=
pan><br><span>     }</span><br><span> </span><br><span>     int ret =3D dco=
_new_key(multi-&gt;dco, multi-&gt;dco_peer_id, ks-&gt;key_id, slot, encrypt=
_key, encrypt_iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                      decrypt_key, decrypt_iv, ciphername);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                          decrypt_k=
ey, decrypt_iv, ciphername, epoch);</span><br><span>     if ((ret =3D=3D 0)=
 &amp;&amp; (multi-&gt;dco_keys_installed &lt; 2))</span><br><span>     {</=
span><br><span>         multi-&gt;dco_keys_installed++;</span><br><span>dif=
f --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index a3629=
77..e5e8709 100644</span><br><span>--- a/src/openvpn/dco.h</span><br><span>=
+++ b/src/openvpn/dco.h</span><br><span>@@ -251,11 +251,8 @@</span><br><spa=
n>  * Return whether the dco implementation supports the new protocol featu=
res of</span><br><span>  * a 64 bit packet counter and AEAD tag at the end.=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco=
_supports_epoch_data(struct context *c)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(struct context =
*c);</span><br><span> #else  /* if defined(ENABLE_DCO) */</span><br><span> =
</span><br><span> typedef void *dco_context_t;</span><br><span>diff --git a=
/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>inde=
x b9f6bc7..947a769 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</=
span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -487,14 +=
487,14 @@</span><br><span> int</span><br><span> dco_new_key(dco_context_t *=
dco, unsigned int peerid, int keyid, dco_key_slot_t slot,</span><br><span> =
            const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const ui=
nt8_t *decrypt_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          const uint8_t *decrypt_iv, const char *ciphername)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            const uint8_t *decrypt=
_iv, const char *ciphername, bool epoch)</span><br><span> {</span><br><span=
>     struct ifdrv drv;</span><br><span>     nvlist_t *nvl, *encrypt_nvl, *=
decrypt_nvl;</span><br><span>     int ret;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: slot =
%d, key-id %d, peer-id %d, cipher %s&quot;, __func__, slot, keyid, peerid,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ciphername);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, =
&quot;%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d&quot;, __func=
__, slot, keyid, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ciphername, epoch);</span><br><span> </span><br><span>     nvl=
 =3D nvlist_create(0);</span><br><span> </span><br><span>@@ -876,4 +876,10 =
@@</span><br><span>     return &quot;none:AES-256-GCM:AES-192-GCM:AES-128-G=
CM:CHACHA20-POLY1305&quot;;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(struct context *c)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #endif /* defined(ENABLE_DCO) &amp;&amp; =
defined(TARGET_FREEBSD) */</span><br><span>diff --git a/src/openvpn/dco_int=
ernal.h b/src/openvpn/dco_internal.h</span><br><span>index 83013ef..d1d5e2d=
 100644</span><br><span>--- a/src/openvpn/dco_internal.h</span><br><span>++=
+ b/src/openvpn/dco_internal.h</span><br><span>@@ -66,7 +66,7 @@</span><br>=
<span> </span><br><span> int dco_new_key(dco_context_t *dco, unsigned int p=
eerid, int keyid, dco_key_slot_t slot,</span><br><span>                 con=
st uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_=
key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c=
onst uint8_t *decrypt_iv, const char *ciphername);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                const uint8_t *decrypt_iv, c=
onst char *ciphername, bool epoch);</span><br><span> </span><br><span> int =
dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot);<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/dco_linux.c b/sr=
c/openvpn/dco_linux.c</span><br><span>index 395a38f..c349ab2 100644</span><=
br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dc=
o_linux.c</span><br><span>@@ -601,10 +601,10 @@</span><br><span> int</span>=
<br><span> dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, =
dco_key_slot_t slot,</span><br><span>             const uint8_t *encrypt_ke=
y, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            const uint8_t *decrypt_iv, =
const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            const uint8_t *decrypt_iv, const char *ciphername, bool epo=
ch)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s&q=
uot;, __func__, slot, keyid, peerid,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        ciphername);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id =
%d, cipher %s, epoch %d&quot;, __func__, slot, keyid, peerid,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ciphername, epoch);</span=
><br><span> </span><br><span>     const size_t key_len =3D cipher_kt_key_si=
ze(ciphername);</span><br><span>     const int nonce_tail_len =3D 8;</span>=
<br><span>@@ -1303,6 +1303,12 @@</span><br><span>     return &quot;AES-128-=
GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305&quot;;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_d=
ata(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(__GNU=
C__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic pop</spa=
n><br><span> #endif</span><br><span>diff --git a/src/openvpn/dco_win.c b/sr=
c/openvpn/dco_win.c</span><br><span>index 9e52859..389cd38 100644</span><br=
><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_wi=
n.c</span><br><span>@@ -533,7 +533,7 @@</span><br><span> int</span><br><spa=
n> dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_=
slot_t slot,</span><br><span>             const uint8_t *encrypt_key, const=
 uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            const uint8_t *decrypt_iv, const ch=
ar *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        const uint8_t *decrypt_iv, const char *ciphername, bool epoch)</spa=
n><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: slot %d, key=
-id %d, peer-id %d, cipher %s&quot;, __func__, slot, keyid, peerid,</span><=
br><span>         ciphername);</span><br><span>@@ -541,28 +541,40 @@</span>=
<br><span>     const int nonce_len =3D 8;</span><br><span>     size_t key_l=
en =3D cipher_kt_key_size(ciphername);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    OVPN_CRYPTO_DATA crypto_data;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CRYPTO_DATA_V2 cr=
ypto_data;</span><br><span>     ZeroMemory(&amp;crypto_data, sizeof(crypto_=
data));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    crypto_data.CipherAlg =3D dco_get_cipher(ciphername);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    crypto_data.KeyId =3D keyid;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_data.PeerId =
=3D peerid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto=
_data.KeySlot =3D slot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVPN_CRYPTO_DATA *v1 =3D &amp;crypto_data.V1;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    CopyMemory(crypto_dat=
a.Encrypt.Key, encrypt_key, key_len);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    crypto_data.Encrypt.KeyLen =3D (char)key_len;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    CopyMemory(crypto_data.Encr=
ypt.NonceTail, encrypt_iv, nonce_len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    v1-&gt;CipherAlg =3D dco_get_cipher(ciphername);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    v1-&gt;KeyId =3D ke=
yid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    v1-&gt;Peer=
Id =3D peerid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    v=
1-&gt;KeySlot =3D slot;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, ke=
y_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_dat=
a.Decrypt.KeyLen =3D (char)key_len;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, non=
ce_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CopyMem=
ory(v1-&gt;Encrypt.Key, encrypt_key, key_len);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    v1-&gt;Encrypt.KeyLen =3D (char)key_len;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CopyMemory(v1-&gt;E=
ncrypt.NonceTail, encrypt_iv, nonce_len);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(crypto_data.CipherAlg &gt;=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CopyMemory(=
v1-&gt;Decrypt.Key, decrypt_key, key_len);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    v1-&gt;Decrypt.KeyLen =3D (char)key_len;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    CopyMemory(v1-&gt;Decry=
pt.NonceTail, decrypt_iv, nonce_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(v1-&gt;CipherAlg &gt; 0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 DWORD ioctl =3D OVPN_IOCTL_NEW_KEY;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    VOID *buf =3D &amp;crypto_data.V1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    DWORD bufSize =3D sizeof(crypto_dat=
a.V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ioctl =3D OVPN_IOCTL_NEW=
_KEY_V2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cry=
pto_data.CryptoOptions |=3D CRYPTO_OPTIONS_EPOCH;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        buf =3D &amp;crypto_data;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        bufSize =3D sizeof(cryp=
to_data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> </span><br><span>     DWORD bytes_returned =3D 0;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceI=
oControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_NEW_KEY, &amp;crypto_data, sizeof(=
crypto_data), NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                       0, &amp;bytes_returned, NULL))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;h=
and, ioctl, buf, bufSize, NULL, 0, &amp;bytes_returned, NULL))</span><br><s=
pan>     {</span><br><span>         msg(M_ERR, &quot;DeviceIoControl(OVPN_I=
OCTL_NEW_KEY) failed&quot;);</span><br><span>         return -1;</span><br>=
<span>@@ -1083,4 +1095,11 @@</span><br><span>     gc_free(&amp;gc);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_s=
upports_epoch_data(struct context *c)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    OVPN_VERSION ver =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return dco_get_version(&amp;ver) &amp;&amp; ((ver.Major =3D=
=3D 2 &amp;&amp; ver.Minor &gt;=3D 8) || (ver.Major &gt; 2));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(_WIN32) */</spa=
n><br><span>diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_=
win.h</span><br><span>index 9e1378a..e76770b 100644</span><br><span>--- a/s=
rc/openvpn/ovpn_dco_win.h</span><br><span>+++ b/src/openvpn/ovpn_dco_win.h<=
/span><br><span>@@ -118,6 +118,13 @@</span><br><span> 	int PeerId;</span><b=
r><span> } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define CRYPTO_OPTIONS_EPOC=
H (1&lt;&lt;1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_CRY=
PTO_DATA_V2 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_CRYPTO_DATA V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   UINT32 CryptoOptions;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef struct _OVPN_MP=
_SET_PEER {</span><br><span>     int PeerId;</span><br><span>     LONG Keep=
aliveInterval;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail">change 1219</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1219?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5ed5969dcd405a47e34ed8479b=
7ffaaa5c43080 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1219 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--w2cqQTsKVLY=--

