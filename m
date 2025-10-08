From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 13:05:02 +0000
In-Reply-To: <gerrit.1758811182000.Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080@...2715...>
References: <gerrit.1758811182000.Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <742488388bcb181ac61963712fa9ebc850b47feb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5UipeI+aKD4="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5UipeI+aKD4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: dco-win: support for epoch data channel
......................................................................

dco-win: support for epoch data channel

Starting from 2.8.0, dco-win driver supports epoch data channel.

This commit adds missing userspace part to query DCO drivers for epoch
data format support (always "false" for now for Linux and FreeBSD, true
if Win-DCO driver is 2.8 or later), and pass "CRYPTO_OPTIONS_EPOCH"
flag via a new OVPN_IOCTL_NEW_KEY_V2 ioctl() to windows driver to turn
it on, if negotiated.

Change-Id: Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1219
Message-Id: <20251008123757.18670-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243920/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/ovpn_dco_win.h
7 files changed, 67 insertions(+), 30 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1219/6

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6afc680..8fb4662 100644
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
index 86af003..97a7048 100644
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
index d46fa46..0ae30b1 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -596,10 +596,10 @@
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

     const int key_len =3D cipher_kt_key_size(ciphername);
     const int nonce_tail_len =3D 8;
@@ -1298,4 +1298,10 @@
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }

+bool
+dco_supports_epoch_data(struct context *c)
+{
+    return false;
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 30307de..ca5eedf 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -528,7 +528,7 @@
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
@@ -537,29 +537,42 @@
     size_t key_len =3D cipher_kt_key_size(ciphername);
     ASSERT(key_len <=3D 32);

-    OVPN_CRYPTO_DATA crypto_data;
+    OVPN_CRYPTO_DATA_V2 crypto_data;
     ZeroMemory(&crypto_data, sizeof(crypto_data));

-    crypto_data.CipherAlg =3D dco_get_cipher(ciphername);
+    OVPN_CRYPTO_DATA *v1 =3D &crypto_data.V1;
+
+    v1->CipherAlg =3D dco_get_cipher(ciphername);
     ASSERT(keyid >=3D 0 && keyid <=3D UCHAR_MAX);
-    crypto_data.KeyId =3D (unsigned char)keyid;
-    crypto_data.PeerId =3D peerid;
-    crypto_data.KeySlot =3D slot;
+    v1->KeyId =3D (unsigned char)keyid;
+    v1->PeerId =3D peerid;
+    v1->KeySlot =3D slot;

-    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
-    crypto_data.Encrypt.KeyLen =3D (unsigned char)key_len;
-    CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
+    /* for epoch we use key material as a seed, no as actual key */
+    CopyMemory(v1->Encrypt.Key, encrypt_key, epoch ? 32 : key_len);
+    v1->Encrypt.KeyLen =3D (unsigned char)key_len;
+    CopyMemory(v1->Encrypt.NonceTail, encrypt_iv, nonce_len);

-    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
-    crypto_data.Decrypt.KeyLen =3D (unsigned char)key_len;
-    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
+    CopyMemory(v1->Decrypt.Key, decrypt_key, epoch ? 32 : key_len);
+    v1->Decrypt.KeyLen =3D (unsigned char)key_len;
+    CopyMemory(v1->Decrypt.NonceTail, decrypt_iv, nonce_len);

-    ASSERT(crypto_data.CipherAlg > 0);
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
@@ -1076,4 +1089,11 @@
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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080
Gerrit-Change-Number: 1219
Gerrit-PatchSet: 6
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5UipeI+aKD4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by stipa.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">dco-win: support for epoch data=
 channel<br><br>Starting from 2.8.0, dco-win driver supports epoch data cha=
nnel.<br><br>This commit adds missing userspace part to query DCO drivers f=
or epoch<br>data format support (always &quot;false&quot; for now for Linux=
 and FreeBSD, true<br>if Win-DCO driver is 2.8 or later), and pass &quot;CR=
YPTO_OPTIONS_EPOCH&quot;<br>flag via a new OVPN_IOCTL_NEW_KEY_V2 ioctl() to=
 windows driver to turn<br>it on, if negotiated.<br><br>Change-Id: Ib5ed596=
9dcd405a47e34ed8479b7ffaaa5c43080<br>Signed-off-by: Lev Stipakov &lt;lev@...1186...=
.515...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Ge=
rrit URL: https://gerrit.openvpn.net/c/openvpn/+/1219<br>Message-Id: &lt;20=
251008123757.18670-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/=
openvpn/mailman/message/59243920/<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/dco.h<br>M src=
/openvpn/dco_freebsd.c<br>M src/openvpn/dco_internal.h<br>M src/openvpn/dco=
_linux.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/ovpn_dco_win.h<br>7 fi=
les changed, 67 insertions(+), 30 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1219/6</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 6afc680..8fb4662 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -56,8 +56,9 @@</span><br><=
span>                 const char *ciphername)</span><br><span> </span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_=
DEBUG, &quot;%s: peer_id=3D%d keyid=3D%d, currently %d keys installed&quot;=
, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mu=
lti-&gt;dco_peer_id, ks-&gt;key_id, multi-&gt;dco_keys_installed);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool epoch =3D ks-&gt;cr=
ypto_options.flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer_id=3D%d =
keyid=3D%d epoch=3D%d, currently %d keys installed&quot;, __func__,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;dco_peer_=
id, ks-&gt;key_id, multi-&gt;dco_keys_installed, epoch);</span><br><span> <=
/span><br><span>     /* Install a key in the PRIMARY slot only when no othe=
r key exist.</span><br><span>      * From that moment on, any new key will =
be installed in the SECONDARY</span><br><span>@@ -71,7 +72,7 @@</span><br><=
span>     }</span><br><span> </span><br><span>     int ret =3D dco_new_key(=
multi-&gt;dco, multi-&gt;dco_peer_id, ks-&gt;key_id, slot, encrypt_key, enc=
rypt_iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
             decrypt_key, decrypt_iv, ciphername);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                          decrypt_key, decry=
pt_iv, ciphername, epoch);</span><br><span>     if ((ret =3D=3D 0) &amp;&am=
p; (multi-&gt;dco_keys_installed &lt; 2))</span><br><span>     {</span><br>=
<span>         multi-&gt;dco_keys_installed++;</span><br><span>diff --git a=
/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index a362977..e5e87=
09 100644</span><br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src=
/openvpn/dco.h</span><br><span>@@ -251,11 +251,8 @@</span><br><span>  * Ret=
urn whether the dco implementation supports the new protocol features of</s=
pan><br><span>  * a 64 bit packet counter and AEAD tag at the end.</span><b=
r><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
line bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports=
_epoch_data(struct context *c)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_supports_epoch_data(struct context *c);</spa=
n><br><span> #else  /* if defined(ENABLE_DCO) */</span><br><span> </span><b=
r><span> typedef void *dco_context_t;</span><br><span>diff --git a/src/open=
vpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index b9f6bc7=
..947a769 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br>=
<span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -487,14 +487,14 @@=
</span><br><span> int</span><br><span> dco_new_key(dco_context_t *dco, unsi=
gned int peerid, int keyid, dco_key_slot_t slot,</span><br><span>          =
   const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *de=
crypt_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 const uint8_t *decrypt_iv, const char *ciphername)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const uint8_t *decrypt_iv, co=
nst char *ciphername, bool epoch)</span><br><span> {</span><br><span>     s=
truct ifdrv drv;</span><br><span>     nvlist_t *nvl, *encrypt_nvl, *decrypt=
_nvl;</span><br><span>     int ret;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: slot %d, key=
-id %d, peer-id %d, cipher %s&quot;, __func__, slot, keyid, peerid,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        ciphername);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%=
s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d&quot;, __func__, slo=
t, keyid, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ciphername, epoch);</span><br><span> </span><br><span>     nvl =3D nv=
list_create(0);</span><br><span> </span><br><span>@@ -876,4 +876,10 @@</spa=
n><br><span>     return &quot;none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHAC=
HA20-POLY1305&quot;;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+dco_supports_epoch_data(struct context *c)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #endif /* defined(ENABLE_DCO) &amp;&amp; defined(=
TARGET_FREEBSD) */</span><br><span>diff --git a/src/openvpn/dco_internal.h =
b/src/openvpn/dco_internal.h</span><br><span>index 86af003..97a7048 100644<=
/span><br><span>--- a/src/openvpn/dco_internal.h</span><br><span>+++ b/src/=
openvpn/dco_internal.h</span><br><span>@@ -66,7 +66,7 @@</span><br><span> <=
/span><br><span> int dco_new_key(dco_context_t *dco, unsigned int peerid, i=
nt keyid, dco_key_slot_t slot,</span><br><span>                 const uint8=
_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                const uin=
t8_t *decrypt_iv, const char *ciphername);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                const uint8_t *decrypt_iv, const cha=
r *ciphername, bool epoch);</span><br><span> </span><br><span> int dco_del_=
key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot);</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvp=
n/dco_linux.c</span><br><span>index d46fa46..0ae30b1 100644</span><br><span=
>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.=
c</span><br><span>@@ -596,10 +596,10 @@</span><br><span> int</span><br><spa=
n> dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_=
slot_t slot,</span><br><span>             const uint8_t *encrypt_key, const=
 uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            const uint8_t *decrypt_iv, const ch=
ar *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        const uint8_t *decrypt_iv, const char *ciphername, bool epoch)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s&quot;, __=
func__, slot, keyid, peerid,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        ciphername);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, ciph=
er %s, epoch %d&quot;, __func__, slot, keyid, peerid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ciphername, epoch);</span><br><sp=
an> </span><br><span>     const int key_len =3D cipher_kt_key_size(cipherna=
me);</span><br><span>     const int nonce_tail_len =3D 8;</span><br><span>@=
@ -1298,4 +1298,10 @@</span><br><span>     return &quot;AES-128-GCM:AES-256=
-GCM:AES-192-GCM:CHACHA20-POLY1305&quot;;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(struct =
context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(ENABLE_DCO=
) &amp;&amp; defined(TARGET_LINUX) */</span><br><span>diff --git a/src/open=
vpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 30307de..ca5eed=
f 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/=
src/openvpn/dco_win.c</span><br><span>@@ -528,7 +528,7 @@</span><br><span> =
int</span><br><span> dco_new_key(dco_context_t *dco, unsigned int peerid, i=
nt keyid, dco_key_slot_t slot,</span><br><span>             const uint8_t *=
encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            const uint8_t *de=
crypt_iv, const char *ciphername)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            const uint8_t *decrypt_iv, const char *ciphername=
, bool epoch)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quo=
t;%s: slot %d, key-id %d, peer-id %d, cipher %s&quot;, __func__, slot, keyi=
d, peerid,</span><br><span>         ciphername);</span><br><span>@@ -537,29=
 +537,42 @@</span><br><span>     size_t key_len =3D cipher_kt_key_size(ciph=
ername);</span><br><span>     ASSERT(key_len &lt;=3D 32);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_CRYPTO_DATA =
crypto_data;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_CRYPTO_DATA_V2 crypto_data;</span><br><span>     ZeroMemory(&amp;crypto_d=
ata, sizeof(crypto_data));</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    crypto_data.CipherAlg =3D dco_get_cipher(ciphern=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CRYPT=
O_DATA *v1 =3D &amp;crypto_data.V1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 v1-&gt;CipherAlg =3D dco_get_cipher(ciphername);</span><br><span>     ASSE=
RT(keyid &gt;=3D 0 &amp;&amp; keyid &lt;=3D UCHAR_MAX);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    crypto_data.KeyId =3D (unsigned char)=
keyid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_data=
.PeerId =3D peerid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  crypto_data.KeySlot =3D slot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    v1-&gt;KeyId =3D (unsigned char)keyid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    v1-&gt;PeerId =3D peerid;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    v1-&gt;KeySlot =3D slot;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    C=
opyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    crypto_data.Encrypt.KeyLen =3D (uns=
igned char)key_len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* for epoch we use key=
 material as a seed, no as actual key */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    CopyMemory(v1-&gt;Encrypt.Key, encrypt_key, epoch =
? 32 : key_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 v1-&gt;Encrypt.KeyLen =3D (unsigned char)key_len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    CopyMemory(v1-&gt;Encrypt.NonceTail, enc=
rypt_iv, nonce_len);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_l=
en);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_data.D=
ecrypt.KeyLen =3D (unsigned char)key_len;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_i=
v, nonce_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    C=
opyMemory(v1-&gt;Decrypt.Key, decrypt_key, epoch ? 32 : key_len);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    v1-&gt;Decrypt.KeyLen =3D=
 (unsigned char)key_len;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CopyMemory(v1-&gt;Decrypt.NonceTail, decrypt_iv, nonce_len);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSER=
T(crypto_data.CipherAlg &gt; 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ASSERT(v1-&gt;CipherAlg &gt; 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    DWORD ioctl =3D OVPN_IOCTL_NEW_KEY;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    VOID *buf =3D &amp;crypto_data.V1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bufSize =3D siz=
eof(crypto_data.V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ioctl =3D =
OVPN_IOCTL_NEW_KEY_V2;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        crypto_data.CryptoOptions |=3D CRYPTO_OPTIONS_EPOCH;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        buf =3D &amp;crypto_dat=
a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bufSize =
=3D sizeof(crypto_data);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span> </span><br><span>     DWORD bytes_returned =3D =
0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_NEW_KEY, &amp;crypt=
o_data, sizeof(crypto_data), NULL,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                         0, &amp;bytes_returned, NULL))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(d=
co-&gt;tt-&gt;hand, ioctl, buf, bufSize, NULL, 0, &amp;bytes_returned, NULL=
))</span><br><span>     {</span><br><span>         msg(M_ERR, &quot;DeviceI=
oControl(OVPN_IOCTL_NEW_KEY) failed&quot;);</span><br><span>         return=
 -1;</span><br><span>@@ -1076,4 +1089,11 @@</span><br><span>     gc_free(&a=
mp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dco_supports_epoch_data(struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    OVPN_VERSION ver =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return dco_get_version(&amp;ver) &amp;&amp;=
 ((ver.Major =3D=3D 2 &amp;&amp; ver.Minor &gt;=3D 8) || (ver.Major &gt; 2)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined=
(_WIN32) */</span><br><span>diff --git a/src/openvpn/ovpn_dco_win.h b/src/o=
penvpn/ovpn_dco_win.h</span><br><span>index 9e1378a..e76770b 100644</span><=
br><span>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>+++ b/src/openvpn=
/ovpn_dco_win.h</span><br><span>@@ -118,6 +118,13 @@</span><br><span> 	int =
PeerId;</span><br><span> } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CRY=
PTO_OPTIONS_EPOCH (1&lt;&lt;1)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef =
struct _OVPN_CRYPTO_DATA_V2 {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_CRYPTO_DATA V1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    UINT32 CryptoOptions;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef s=
truct _OVPN_MP_SET_PEER {</span><br><span>     int PeerId;</span><br><span>=
     LONG KeepaliveInterval;</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail">cha=
nge 1219</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5ed5969dcd405a47e34ed8479b=
7ffaaa5c43080 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1219 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--5UipeI+aKD4=--

