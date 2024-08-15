From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 15 Aug 2024 12:33:32 +0000
In-Reply-To: <gerrit.1723550412000.I2e0c50d33f8a57c023120cf348f95d34acbfcde5@...2715...>
References: <gerrit.1723550412000.I2e0c50d33f8a57c023120cf348f95d34acbfcde5@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <295e9d26994c3a18991bff573774e5aa2819fd5c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+FeV/McVXi4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: support for
 data_v3 features
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

--+FeV/McVXi4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/725?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: dco-win: support for data_v3 features
......................................................................

dco-win: support for data_v3 features

Since version 1.4, dco-win drivere supports data_v3 features
such as:

 - AEAD tag at the end
 - 64bit pktid

We have to:

 - check in runtime if driver supports data_v3 features (we might be
 running with the older driver)

 - if those features are negotiated, we pass them to the driver
 as bit flags via the (newly added) NEW_KEY_V2 ioctl

Introduce NEW_KEY_V2 ioctl, which accepts a new OVPN_CRYPTO_DATA_V2
structure, which includes a field for bit flags for the new
crypto options.

Make dco_supports_data_v3() implementation platform-dependend (as it
should be) and indicate data_v3 support by dco-win if the driver version
is at least 1.4. Extend the Windows-specific struct dco_context and
store data_v3 support there so that when dco_new_key() is called, we
know which API to use.

Change the dco internal API and pass crypto options flags to dco_new_key().

Change-Id: I2e0c50d33f8a57c023120cf348f95d34acbfcde5
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/ovpn_dco_win.h
8 files changed, 141 insertions(+), 45 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/725/2

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7f0d53d..baaeb95 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -70,7 +70,7 @@
     int ret =3D dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, sl=
ot,
                           encrypt_key, encrypt_iv,
                           decrypt_key, decrypt_iv,
-                          ciphername);
+                          ciphername, ks->crypto_options.flags);
     if ((ret =3D=3D 0) && (multi->dco_keys_installed < 2))
     {
         multi->dco_keys_installed++;
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 3ce2c31..ec4ec42 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -253,11 +253,7 @@
  * Return whether the dco implementation supports the new protocol feature=
s of
  * a 64 bit packet counter and AEAD tag at the end.
  */
-static inline bool
-dco_supports_data_v3(struct context *c)
-{
-    return false;
-}
+bool dco_supports_data_v3(struct context *c);

 #else /* if defined(ENABLE_DCO) */

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 9a90f5c..9d0fe23 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -415,14 +415,14 @@
             dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
             const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-            const char *ciphername)
+            const char *ciphername, unsigned int co_flags)
 {
     struct ifdrv drv;
     nvlist_t *nvl;
     int ret;

-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
-        __func__, slot, keyid, peerid, ciphername);
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, co_fl=
ags %d",
+        __func__, slot, keyid, peerid, ciphername, co_flags);

     nvl =3D nvlist_create(0);

@@ -778,4 +778,11 @@
     return "none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305";
 }

+bool
+dco_supports_data_v3(struct context *c)
+{
+    /* not implemented */
+    return false;
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 624c110..35500a4 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -70,7 +70,7 @@
                 dco_key_slot_t slot,
                 const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
                 const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-                const char *ciphername);
+                const char *ciphername, unsigned int co_flags);

 int dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t sl=
ot);

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 277cd64..66c2017 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -557,10 +557,10 @@
             dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
             const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-            const char *ciphername)
+            const char *ciphername, unsigned int co_flags)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
-        __func__, slot, keyid, peerid, ciphername);
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, co_fl=
ags %d",
+        __func__, slot, keyid, peerid, ciphername, co_flags);

     const size_t key_len =3D cipher_kt_key_size(ciphername);
     const int nonce_tail_len =3D 8;
@@ -1058,4 +1058,11 @@
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }

+bool
+dco_supports_data_v3(struct context *c)
+{
+    /* not implemented */
+    return false;
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 3ec946f..5ffbb8d 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -55,6 +55,9 @@
 bool
 ovpn_dco_init(int mode, dco_context_t *dco)
 {
+    dco->supports_data_v3 =3D dco_supports_data_v3(NULL);
+    msg(D_DCO_DEBUG, "dco supports data_v3: %d", dco->supports_data_v3);
+
     return true;
 }

@@ -291,47 +294,85 @@
     return 0;
 }

-int
-dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
-            dco_key_slot_t slot,
-            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
-            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-            const char *ciphername)
+static int
+dco_new_key_v1(HANDLE handle, OVPN_CRYPTO_DATA *crypto_data)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
-        __func__, slot, keyid, peerid, ciphername);
-
-    const int nonce_len =3D 8;
-    size_t key_len =3D cipher_kt_key_size(ciphername);
-
-    OVPN_CRYPTO_DATA crypto_data;
-    ZeroMemory(&crypto_data, sizeof(crypto_data));
-
-    crypto_data.CipherAlg =3D dco_get_cipher(ciphername);
-    crypto_data.KeyId =3D keyid;
-    crypto_data.PeerId =3D peerid;
-    crypto_data.KeySlot =3D slot;
-
-    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
-    crypto_data.Encrypt.KeyLen =3D (char)key_len;
-    CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
-
-    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
-    crypto_data.Decrypt.KeyLen =3D (char)key_len;
-    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
-
-    ASSERT(crypto_data.CipherAlg > 0);
-
     DWORD bytes_returned =3D 0;

-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NEW_KEY, &crypto_data,
-                         sizeof(crypto_data), NULL, 0, &bytes_returned, NU=
LL))
+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_KEY, crypto_data, sizeof(*=
crypto_data), NULL, 0, &bytes_returned, NULL))
     {
         msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
         return -1;
     }
     return 0;
 }
+
+static int
+dco_new_key_v2(HANDLE handle, OVPN_CRYPTO_DATA_V2 *crypto_data, unsigned i=
nt co_flags)
+{
+    if (co_flags & CO_AEAD_TAG_AT_THE_END)
+    {
+        crypto_data->CryptoOptions |=3D CRYPTO_OPTIONS_AEAD_TAG_END;
+    }
+
+    if (co_flags & CO_64_BIT_PKT_ID)
+    {
+        crypto_data->CryptoOptions |=3D CRYPTO_OPTIONS_64BIT_PKTID;
+    }
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_KEY_V2, crypto_data, sizeo=
f(*crypto_data), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY_V2) failed");
+        return -1;
+    }
+
+    return 0;
+}
+
+int
+dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+            dco_key_slot_t slot,
+            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+            const char *ciphername, unsigned int co_flags)
+{
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, co_fl=
ags %d",
+        __func__, slot, keyid, peerid, ciphername, co_flags);
+
+    const int nonce_len =3D 8;
+    size_t key_len =3D cipher_kt_key_size(ciphername);
+
+    OVPN_CRYPTO_DATA_V2 crypto_data_v2;
+    ZeroMemory(&crypto_data_v2, sizeof(crypto_data_v2));
+
+    OVPN_CRYPTO_DATA *crypto_data =3D &crypto_data_v2.V1;
+
+    crypto_data->CipherAlg =3D dco_get_cipher(ciphername);
+    crypto_data->KeyId =3D keyid;
+    crypto_data->PeerId =3D peerid;
+    crypto_data->KeySlot =3D slot;
+
+    CopyMemory(crypto_data->Encrypt.Key, encrypt_key, key_len);
+    crypto_data->Encrypt.KeyLen =3D (char)key_len;
+    CopyMemory(crypto_data->Encrypt.NonceTail, encrypt_iv, nonce_len);
+
+    CopyMemory(crypto_data->Decrypt.Key, decrypt_key, key_len);
+    crypto_data->Decrypt.KeyLen =3D (char)key_len;
+    CopyMemory(crypto_data->Decrypt.NonceTail, decrypt_iv, nonce_len);
+
+    ASSERT(crypto_data->CipherAlg > 0);
+
+    if (dco->supports_data_v3)
+    {
+        return dco_new_key_v2(dco->tt->hand, &crypto_data_v2, co_flags);
+    }
+    else
+    {
+        return dco_new_key_v1(dco->tt->hand, crypto_data);
+    }
+}
+
 int
 dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
@@ -494,4 +535,39 @@
     }
 }

+bool
+dco_supports_data_v3(struct context *c)
+{
+    bool res =3D false;
+
+    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
+                          0, NULL, OPEN_EXISTING, 0, NULL);
+
+    if (h =3D=3D INVALID_HANDLE_VALUE)
+    {
+        goto done;
+    }
+
+    OVPN_VERSION version;
+    ZeroMemory(&version, sizeof(OVPN_VERSION));
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
+                         &version, sizeof(version), &bytes_returned, NULL))
+    {
+        goto done;
+    }
+
+    /* data_v3 is supported starting from 1.4 */
+    res =3D (version.Major > 1) || (version.Minor >=3D 4);
+
+done:
+    if (h !=3D INVALID_HANDLE_VALUE)
+    {
+        CloseHandle(h);
+    }
+
+    return res;
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4883629..f58488f 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -33,6 +33,7 @@

 struct dco_context {
     struct tuntap *tt;
+    bool supports_data_v3;
 };

 typedef struct dco_context dco_context_t;
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index ea2a733..9e437f0 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -94,6 +94,14 @@
 	int PeerId;
 } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;

+#define CRYPTO_OPTIONS_AEAD_TAG_END (1<<1)
+#define CRYPTO_OPTIONS_64BIT_PKTID  (1<<2)
+
+typedef struct _OVPN_CRYPTO_DATA_V2 {
+    OVPN_CRYPTO_DATA V1;
+    UINT32 CryptoOptions;
+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;
+
 typedef struct _OVPN_SET_PEER {
 	LONG KeepaliveInterval;
 	LONG KeepaliveTimeout;
@@ -114,3 +122,4 @@
 #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_BU=
FFERED, FILE_ANY_ACCESS)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/725?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2e0c50d33f8a57c023120cf348f95d34acbfcde5
Gerrit-Change-Number: 725
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--+FeV/McVXi4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/725?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco-win: support for data_v3 features<br><br>=
Since version 1.4, dco-win drivere supports data_v3 features<br>such as:<br=
><br> - AEAD tag at the end<br> - 64bit pktid<br><br>We have to:<br><br> - =
check in runtime if driver supports data_v3 features (we might be<br> runni=
ng with the older driver)<br><br> - if those features are negotiated, we pa=
ss them to the driver<br> as bit flags via the (newly added) NEW_KEY_V2 ioc=
tl<br><br>Introduce NEW_KEY_V2 ioctl, which accepts a new OVPN_CRYPTO_DATA_=
V2<br>structure, which includes a field for bit flags for the new<br>crypto=
 options.<br><br>Make dco_supports_data_v3() implementation platform-depend=
end (as it<br>should be) and indicate data_v3 support by dco-win if the dri=
ver version<br>is at least 1.4. Extend the Windows-specific struct dco_cont=
ext and<br>store data_v3 support there so that when dco_new_key() is called=
, we<br>know which API to use.<br><br>Change the dco internal API and pass =
crypto options flags to dco_new_key().<br><br>Change-Id: I2e0c50d33f8a57c02=
3120cf348f95d34acbfcde5<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt=
;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/dco.h<br>M src/openvpn/dco=
_freebsd.c<br>M src/openvpn/dco_internal.h<br>M src/openvpn/dco_linux.c<br>=
M src/openvpn/dco_win.c<br>M src/openvpn/dco_win.h<br>M src/openvpn/ovpn_dc=
o_win.h<br>8 files changed, 141 insertions(+), 45 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/725/2</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 7=
f0d53d..baaeb95 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><s=
pan>+++ b/src/openvpn/dco.c</span><br><span>@@ -70,7 +70,7 @@</span><br><sp=
an>     int ret =3D dco_new_key(multi-&gt;dco, multi-&gt;dco_peer_id, ks-&g=
t;key_id, slot,</span><br><span>                           encrypt_key, enc=
rypt_iv,</span><br><span>                           decrypt_key, decrypt_iv=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
      ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                         ciphername, ks-&gt;crypto_options.flags);</span><b=
r><span>     if ((ret =3D=3D 0) &amp;&amp; (multi-&gt;dco_keys_installed &l=
t; 2))</span><br><span>     {</span><br><span>         multi-&gt;dco_keys_i=
nstalled++;</span><br><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dc=
o.h</span><br><span>index 3ce2c31..ec4ec42 100644</span><br><span>--- a/src=
/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -=
253,11 +253,7 @@</span><br><span>  * Return whether the dco implementation =
supports the new protocol features of</span><br><span>  * a 64 bit packet c=
ounter and AEAD tag at the end.</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-dco_supports_data_v3(struct context *c)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool dco_supports_data_v3(struct context *c);</span><br><span> </span>=
<br><span> #else /* if defined(ENABLE_DCO) */</span><br><span> </span><br><=
span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</sp=
an><br><span>index 9a90f5c..9d0fe23 100644</span><br><span>--- a/src/openvp=
n/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><=
span>@@ -415,14 +415,14 @@</span><br><span>             dco_key_slot_t slot=
,</span><br><span>             const uint8_t *encrypt_key, const uint8_t *e=
ncrypt_iv,</span><br><span>             const uint8_t *decrypt_key, const u=
int8_t *decrypt_iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          const char *ciphername)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            const char *ciphername, unsigned int co_flags)</s=
pan><br><span> {</span><br><span>     struct ifdrv drv;</span><br><span>   =
  nvlist_t *nvl;</span><br><span>     int ret;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: s=
lot %d, key-id %d, peer-id %d, cipher %s&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        __func__, slot, keyid, peerid, ciphername=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEB=
UG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s, co_flags %d&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, s=
lot, keyid, peerid, ciphername, co_flags);</span><br><span> </span><br><spa=
n>     nvl =3D nvlist_create(0);</span><br><span> </span><br><span>@@ -778,=
4 +778,11 @@</span><br><span>     return &quot;none:AES-256-GCM:AES-192-GCM=
:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dco_supports_data_v3(struct context=
 *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* not implemented */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(ENABLE_DCO)=
 &amp;&amp; defined(TARGET_FREEBSD) */</span><br><span>diff --git a/src/ope=
nvpn/dco_internal.h b/src/openvpn/dco_internal.h</span><br><span>index 624c=
110..35500a4 100644</span><br><span>--- a/src/openvpn/dco_internal.h</span>=
<br><span>+++ b/src/openvpn/dco_internal.h</span><br><span>@@ -70,7 +70,7 @=
@</span><br><span>                 dco_key_slot_t slot,</span><br><span>   =
              const uint8_t *encrypt_key, const uint8_t *encrypt_iv,</span>=
<br><span>                 const uint8_t *decrypt_key, const uint8_t *decry=
pt_iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 const char *ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                const char *ciphername, unsigned int co_flags);</span=
><br><span> </span><br><span> int dco_del_key(dco_context_t *dco, unsigned =
int peerid, dco_key_slot_t slot);</span><br><span> </span><br><span>diff --=
git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>ind=
ex 277cd64..66c2017 100644</span><br><span>--- a/src/openvpn/dco_linux.c</s=
pan><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -557,10 +557=
,10 @@</span><br><span>             dco_key_slot_t slot,</span><br><span>  =
           const uint8_t *encrypt_key, const uint8_t *encrypt_iv,</span><br=
><span>             const uint8_t *decrypt_key, const uint8_t *decrypt_iv,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const char=
 *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      const char *ciphername, unsigned int co_flags)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quo=
t;%s: slot %d, key-id %d, peer-id %d, cipher %s&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        __func__, slot, keyid, peerid, cip=
hername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_=
DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s, co_flags %d=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        __fu=
nc__, slot, keyid, peerid, ciphername, co_flags);</span><br><span> </span><=
br><span>     const size_t key_len =3D cipher_kt_key_size(ciphername);</spa=
n><br><span>     const int nonce_tail_len =3D 8;</span><br><span>@@ -1058,4=
 +1058,11 @@</span><br><span>     return &quot;AES-128-GCM:AES-256-GCM:AES-=
192-GCM:CHACHA20-POLY1305&quot;;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+dco_supports_data_v3(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* not implemented */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(ENABLE_DCO) &amp=
;&amp; defined(TARGET_LINUX) */</span><br><span>diff --git a/src/openvpn/dc=
o_win.c b/src/openvpn/dco_win.c</span><br><span>index 3ec946f..5ffbb8d 1006=
44</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/op=
envpn/dco_win.c</span><br><span>@@ -55,6 +55,9 @@</span><br><span> bool</sp=
an><br><span> ovpn_dco_init(int mode, dco_context_t *dco)</span><br><span> =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;suppor=
ts_data_v3 =3D dco_supports_data_v3(NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;dco supports data_v3: %d&=
quot;, dco-&gt;supports_data_v3);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     return true;</span><br><span> }</span><=
br><span> </span><br><span>@@ -291,47 +294,85 @@</span><br><span>     retur=
n 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            dco_key_slot_t slot=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const ui=
nt8_t *encrypt_key, const uint8_t *encrypt_iv,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            const uint8_t *decrypt_key, const uint=
8_t *decrypt_iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       const char *ciphername)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_new_key_v1(HANDLE handle, OVPN_CRYPTO_DATA *crypto_data)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_D=
EBUG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        __func__, slot, keyid, p=
eerid, ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int nonce_len=
 =3D 8;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t key=
_len =3D cipher_kt_key_size(ciphername);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  OVPN_CRYPTO_DATA crypto_data;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ZeroMemory(&amp;crypto_data, sizeof(crypto_data));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    crypto_data.CipherAlg =3D dco_get_cipher(cipherna=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_data.K=
eyId =3D keyid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cr=
ypto_data.PeerId =3D peerid;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    crypto_data.KeySlot =3D slot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    crypto_data.Encrypt.KeyLen =3D (=
char)key_len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Copy=
Memory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key=
_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_data=
.Decrypt.KeyLen =3D (char)key_len;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonc=
e_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(crypto_data.CipherAlg &g=
t; 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n>     DWORD bytes_returned =3D 0;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;han=
d, OVPN_IOCTL_NEW_KEY, &amp;crypto_data,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                         sizeof(crypto_data), NULL, 0, &=
amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_KEY, crypto_data, si=
zeof(*crypto_data), NULL, 0, &amp;bytes_returned, NULL))</span><br><span>  =
   {</span><br><span>         msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_N=
EW_KEY) failed&quot;);</span><br><span>         return -1;</span><br><span>=
     }</span><br><span>     return 0;</span><br><span> }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+dco_new_key_v2(HANDLE handle, OVPN_CRYPTO_DATA_V2 *crypto_data, un=
signed int co_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (co_flags =
&amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    crypto_data-&gt;CryptoOptions |=3D CRYPTO_OPTIONS_AEAD_TAG_END;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (co_flags &amp; CO_64_BIT_PKT_ID)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        crypto_data-&gt;CryptoOptions |=3D CRYPTO_OPT=
IONS_64BIT_PKTID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoContro=
l(handle, OVPN_IOCTL_NEW_KEY_V2, crypto_data, sizeof(*crypto_data), NULL, 0=
, &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_NEW_KEY_V2) failed&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dco_new_key(dco_context_t *dco, unsign=
ed int peerid, int keyid,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            dco_key_slot_t slot,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            const uint8_t *encrypt_key, const uint8_t *e=
ncrypt_iv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   const uint8_t *decrypt_key, const uint8_t *decrypt_iv,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            const char *ciphername, u=
nsigned int co_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DE=
BUG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s, co_flags %d&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, =
slot, keyid, peerid, ciphername, co_flags);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const int nonce_len =3D 8;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    size_t key_len =3D cipher_kt_key_size(ciphername);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_CRYPTO_DATA_V2 crypto_data_v2;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ZeroMemory(&amp;c=
rypto_data_v2, sizeof(crypto_data_v2));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    OVPN_CRYPTO_DATA *crypto_data =3D &amp;crypto_data_v2.V1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    crypto_data-&gt;CipherAlg =3D dco_get_cipher(ci=
phername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    crypt=
o_data-&gt;KeyId =3D keyid;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    crypto_data-&gt;PeerId =3D peerid;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    crypto_data-&gt;KeySlot =3D slot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    CopyMemory(crypto_data-&gt;Encrypt.Key, encry=
pt_key, key_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  crypto_data-&gt;Encrypt.KeyLen =3D (char)key_len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CopyMemory(crypto_data-&gt;Encrypt.No=
nceTail, encrypt_iv, nonce_len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Co=
pyMemory(crypto_data-&gt;Decrypt.Key, decrypt_key, key_len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    crypto_data-&gt;Decrypt.KeyLen=
 =3D (char)key_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    CopyMemory(crypto_data-&gt;Decrypt.NonceTail, decrypt_iv, nonce_len);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ASSERT(crypto_data-&gt;CipherAlg &gt=
; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;supports_data_v3)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return dco_new_key_v2(dco=
-&gt;tt-&gt;hand, &amp;crypto_data_v2, co_flags);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn dco_new_key_v1(dco-&gt;tt-&gt;hand, crypto_data);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> int</span><br><span> dco_del_key(dco_context_t *dco, =
unsigned int peerid, dco_key_slot_t slot)</span><br><span> {</span><br><spa=
n>@@ -494,4 +535,39 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_data_v3(struct=
 context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool res =3D false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    HANDLE h =3D CreateFile(&quot;\\\\.\=
\ovpn-dco-ver&quot;, GENERIC_READ,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          0, NULL, OPEN_EXISTING, 0, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_HANDLE_VALUE)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_VERSION version;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ZeroMemory(&amp;version, sizeof(OVPN_VERSION));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(h, OVPN_IOCT=
L_GET_VERSION, NULL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                         &amp;version, sizeof(version), &amp;bytes_retu=
rned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* data_v3 is supported starting from 1.4 */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    res =3D (version.Major=
 &gt; 1) || (version.Minor &gt;=3D 4);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h !=3D=
 INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Clo=
seHandle(h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return res;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> #endif /* defined(_WIN32) */</span><br><span=
>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span=
>index 4883629..f58488f 100644</span><br><span>--- a/src/openvpn/dco_win.h<=
/span><br><span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ -33,6 +33,7 =
@@</span><br><span> </span><br><span> struct dco_context {</span><br><span>=
     struct tuntap *tt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool supports_data_v3;</span><br><span> };</span><br><span> </span>=
<br><span> typedef struct dco_context dco_context_t;</span><br><span>diff -=
-git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br><s=
pan>index ea2a733..9e437f0 100644</span><br><span>--- a/src/openvpn/ovpn_dc=
o_win.h</span><br><span>+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>@@=
 -94,6 +94,14 @@</span><br><span> 	int PeerId;</span><br><span> } OVPN_CRYP=
TO_DATA, * POVPN_CRYPTO_DATA;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define CRYPTO_OPTIONS_AEAD_TAG_END (1&lt;&lt;1=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CRYPTO_OPT=
IONS_64BIT_PKTID  (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef =
struct _OVPN_CRYPTO_DATA_V2 {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_CRYPTO_DATA V1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    UINT32 CryptoOptions;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef s=
truct _OVPN_SET_PEER {</span><br><span> 	LONG KeepaliveInterval;</span><br>=
<span> 	LONG KeepaliveTimeout;</span><br><span>@@ -114,3 +122,4 @@</span><b=
r><span> #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, M=
ETHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_DEL_PE=
ER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)</=
span><br><span> #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOW=
N, 8, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UN=
KNOWN, 9, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/725?us=
p=3Demail">change 725</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/725?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2e0c50d33f8a57c023120cf348f=
95d34acbfcde5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 725 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+FeV/McVXi4=--

