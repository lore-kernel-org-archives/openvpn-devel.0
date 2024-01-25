From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 25 Jan 2024 12:38:19 +0000
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <def1d1e58b22fe5c305eef8e1d776bc30c61d5ba-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C/lK9r8oQBw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement support
 for larger packet counter sizes
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

--C/lK9r8oQBw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail

to review the following change.


Change subject: Implement support for larger packet counter sizes
......................................................................

Implement support for larger packet counter sizes

With DCO and possible future hardware assisted OpenVPN acceleration we
are approaching the point where 32 bit IVs are not cutting it any more.

To illustrate the problem, some back of the envelope math here:

If we want to keep the current 3600s renegotiation interval and have
a safety margin of 25% (when we trigger renegotiation) we have about
3.2 million packets (2*32 * 0.7) to work with. That translates to
about 835k packets per second.

With 1300 Byte packets that translates into 8-9 Gbit/s. That is far
from unrealistic any more. Current DCO implementations are already in
spitting distance to that or might even reach (for a single client
connection) that if you have extremely fast
single core performance CPU.

This introduces the 64bit packet counters for AEAD data channel
ciphers in TLS mode ciphers. No effort has been made to support
larger packet counters in any scenario since the other scenarios
are all legacy.

While we still keep the old --secret logic around we use the same
weird unix timestamp + packet counter format to avoid refactoring the
code now and again when we remove --secret code but DCO
implementations are free to use just a single 64 bit counter. One
other small downside of this approach is that when rollover happens
and we get reordering all the older packets are thrown away since
the distance between the packet before and after the rollover is
quite large as we probably jump forward more than 1s (or more than
2^32 packet ids) forward. But this is an obscure edge that we can
(currently) live with.

Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M src/openvpn/ssl_ncp.c
M tests/unit_tests/openvpn/test_ssl.c
10 files changed, 105 insertions(+), 20 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/507/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9988ebe..81b33fe 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -68,6 +68,7 @@
     const struct key_ctx *ctx =3D &opt->key_ctx_bi.encrypt;
     uint8_t *mac_out =3D NULL;
     const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;
+    bool longiv =3D opt->flags & CO_64_BIT_PKT_ID;

     /* IV, packet-ID and implicit IV required for this mode. */
     ASSERT(ctx->cipher);
@@ -86,7 +87,7 @@
         buf_set_write(&iv_buffer, iv, iv_len);

         /* IV starts with packet id to make the IV unique for packet */
-        if (!packet_id_write(&opt->packet_id.send, &iv_buffer, false, fals=
e))
+        if (!packet_id_write(&opt->packet_id.send, &iv_buffer, longiv, fal=
se))
         {
             msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
             goto err;
@@ -384,6 +385,8 @@
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));

+    bool longiv =3D opt->flags & CO_64_BIT_PKT_ID;
+
     /* Combine IV from explicit part from packet and implicit part from co=
ntext */
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
@@ -409,7 +412,7 @@
     }

     /* Read packet ID from packet */
-    if (!packet_id_read(&pin, buf, false))
+    if (!packet_id_read(&pin, buf, longiv))
     {
         CRYPT_ERROR("error reading packet-id");
     }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 95a5b31..0ef13e0 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -283,6 +283,11 @@
     /**< Bit-flag indicating that the AEAD tag is at the end of the
      *   packet.
      */
+#define CO_64_BIT_PKT_ID  (1<<9)
+    /**< Bit-flag indicating that we should use a 64 bit (8 byte) packet
+     * counter instead of the 32 bit that we normally use.
+     */
+

     unsigned int flags;         /**< Bit-flags determining behavior of
                                  *   security operation functions. */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cd37b36..7db8d06 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2327,6 +2327,10 @@
         {
             buf_printf(&out, " aead-tag-end");
         }
+        if (o->imported_protocol_flags & CO_64_BIT_PKT_ID)
+        {
+            buf_printf(&out, " pkt-id-64-bit");
+        }
     }

     if (buf_len(&out) > strlen(header))
@@ -3297,6 +3301,16 @@
         to.push_peer_info_detail =3D 1;
     }

+    /* Check if the DCO drivers support the new 64bit packet counter and
+     * AEAD tag at the end */
+    if (dco_enabled(options))
+    {
+        to.data_v3_features_supported =3D false;
+    }
+    else
+    {
+        to.data_v3_features_supported =3D true;
+    }

     /* should we not xmit any packets until we get an initial
      * response from client? */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4344126..a80b9f4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1851,6 +1851,13 @@
         o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }

+    if (tls_multi->session[TM_ACTIVE].opt->data_v3_features_supported
+        && (proto & IV_PROTO_DATA_V3))
+    {
+        o->imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;
+        o->imported_protocol_flags |=3D CO_64_BIT_PKT_ID;
+    }
+
     /* Select cipher if client supports Negotiable Crypto Parameters */

     /* if we have already created our key, we cannot *change* our own
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 39f00c0..3f8fccf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8690,6 +8690,10 @@
             {
                 options->imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_E=
ND;
             }
+            else if (streq(p[j], "pkt-id-64-bit"))
+            {
+                options->imported_protocol_flags |=3D CO_64_BIT_PKT_ID;
+            }
             else
             {
                 msg(msglevel, "Unknown protocol-flags flag: %s", p[j]);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e4c122c..5766c97 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -691,6 +691,10 @@
     {
         buf_printf(&proto_flags, " aead-tag-end");
     }
+    if (o->imported_protocol_flags & CO_64_BIT_PKT_ID)
+    {
+        buf_printf(&proto_flags, " pkt-id-64-bit");
+    }

     if (buf_len(&proto_flags) > 0)
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33c8670..6579ff9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -105,9 +105,11 @@
  * @param ctx                   Encrypt/decrypt key context
  * @param key                   HMAC key, used to calculate implicit IV
  * @param key_len               HMAC key length
+ * @param long_pkt_id           64-bit packet counters are used
  */
 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en);
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en,
+                           bool long_pkt_id);


 /**
@@ -1369,13 +1371,15 @@
     }
     else
     {
+        bool longiv =3D ks->crypto_options.flags & CO_64_BIT_PKT_ID;
         init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel"=
);
         /* Initialize implicit IVs */
-        key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].=
hmac,
-                                   MAX_HMAC_KEY_LENGTH);
+        key_ctx_update_implicit_iv(&key->encrypt,
+                                   key2->keys[(int)server].hmac,
+                                   MAX_HMAC_KEY_LENGTH, longiv);
         key_ctx_update_implicit_iv(&key->decrypt,
                                    key2->keys[1 - (int)server].hmac,
-                                   MAX_HMAC_KEY_LENGTH);
+                                   MAX_HMAC_KEY_LENGTH, longiv);
     }
 }

@@ -1513,14 +1517,15 @@
 }

 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en)
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key,
+                           size_t key_len, bool longiv)
 {
     /* Only use implicit IV in AEAD cipher mode, where HMAC key is not use=
d */
     if (cipher_ctx_mode_aead(ctx->cipher))
     {
         size_t impl_iv_len =3D 0;
         ASSERT(cipher_ctx_iv_length(ctx->cipher) >=3D OPENVPN_AEAD_MIN_IV_=
LEN);
-        impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
+        impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - packet_id_size=
(longiv);
         ASSERT(impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <=3D key_len);
         memcpy(ctx->implicit_iv, key, impl_iv_len);
@@ -1935,6 +1940,12 @@
         iv_proto |=3D IV_PROTO_DYN_TLS_CRYPT;
 #endif

+        /* support for AEAD tag at the end and 8 byte IV */
+        if (session->opt->data_v3_features_supported)
+        {
+            iv_proto |=3D IV_PROTO_DATA_V3;
+        }
+
         buf_printf(&out, "IV_PROTO=3D%d\n", iv_proto);

         if (session->opt->push_peer_info_detail > 1)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f085e0d..53bf763 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -311,7 +311,6 @@

     /* from command line */
     bool single_session;
-    bool disable_occ;
     int mode;
     bool pull;
     /**
@@ -361,6 +360,8 @@
     const char *config_ciphername;
     const char *config_ncp_ciphers;
=20
+    bool data_v3_features_supported; /**< dco supports new data channel fe=
atures */
+
     bool tls_crypt_v2;
     const char *tls_crypt_v2_verify_script;

@@ -490,8 +491,6 @@
      */
     int key_id;

-    int limit_next;             /* used for traffic shaping on the control=
 channel */
-
     int verify_maxlevel;

     char *common_name;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 0ca6d42..0b4ad8a 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -430,6 +430,12 @@
         session->opt->crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }

+    if (session->opt->data_v3_features_supported && (iv_proto_peer & IV_PR=
OTO_DATA_V3))
+    {
+        session->opt->crypto_flags |=3D CO_AEAD_TAG_AT_THE_END;
+        session->opt->crypto_flags |=3D CO_64_BIT_PKT_ID;
+    }
+
 #if defined(HAVE_EXPORT_KEYING_MATERIAL)
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 0ded052..125d24b 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -128,9 +128,12 @@
 {
     cipher_ctx_t *cipher =3D co->key_ctx_bi.encrypt.cipher;

+
     if (cipher_ctx_mode_aead(cipher))
     {
-        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(packe=
t_id_type);
+        bool longiv =3D co->flags & CO_64_BIT_PKT_ID;
+
+        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - packet_id_si=
ze(longiv);
         ASSERT(cipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH);
         ASSERT(cipher_ctx_iv_length(cipher) >=3D OPENVPN_AEAD_MIN_IV_LEN);

@@ -142,6 +145,11 @@
         memcpy(co->key_ctx_bi.decrypt.implicit_iv,
                co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
         co->key_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_len;
+
+        if (longiv)
+        {
+            co->flags |=3D CO_64_BIT_PKT_ID;
+        }
     }
 }

@@ -280,6 +288,25 @@
 }

 static void
+run_data_channel_with_cipher_end_and_long_pkt_counter(const char *cipher)
+{
+    struct crypto_options co =3D init_crypto_options(cipher, "none");
+    co.flags |=3D CO_AEAD_TAG_AT_THE_END;
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
+static void
+run_data_channel_with_long_pkt_counter(const char *cipher)
+{
+    struct crypto_options co =3D init_crypto_options(cipher, "none");
+    co.flags |=3D CO_64_BIT_PKT_ID;
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
+
+static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
 {
     struct crypto_options co =3D init_crypto_options(cipher, auth);
@@ -289,24 +316,30 @@


 static void
+run_aead_channel_tests(const char *cipher)
+{
+    run_data_channel_with_cipher_end(cipher);
+    run_data_channel_with_cipher(cipher, "none");
+    run_data_channel_with_cipher_end_and_long_pkt_counter(cipher);
+    run_data_channel_with_long_pkt_counter(cipher);
+}
+
+static void
 test_data_channel_roundtrip_aes_128_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-128-GCM");
-    run_data_channel_with_cipher("AES-128-GCM", "none");
+    run_aead_channel_tests("AES-128-GCM");
 }

 static void
 test_data_channel_roundtrip_aes_192_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-192-GCM");
-    run_data_channel_with_cipher("AES-192-GCM", "none");
+    run_aead_channel_tests("AES-192-GCM");
 }

 static void
 test_data_channel_roundtrip_aes_256_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-256-GCM");
-    run_data_channel_with_cipher("AES-256-GCM", "none");
+    run_aead_channel_tests("AES-256-GCM");
 }

 static void
@@ -336,8 +369,7 @@
         return;
     }

-    run_data_channel_with_cipher_end("ChaCha20-Poly1305");
-    run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
+    run_aead_channel_tests("ChaCha20-Poly1305");
 }

 static void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Gerrit-Change-Number: 507
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--C/lK9r8oQBw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Implement support for larger packet counter sizes<br><br>With=
 DCO and possible future hardware assisted OpenVPN acceleration we<br>are a=
pproaching the point where 32 bit IVs are not cutting it any more.<br><br>T=
o illustrate the problem, some back of the envelope math here:<br><br>If we=
 want to keep the current 3600s renegotiation interval and have<br>a safety=
 margin of 25% (when we trigger renegotiation) we have about<br>3.2 million=
 packets (2*32 * 0.7) to work with. That translates to<br>about 835k packet=
s per second.<br><br>With 1300 Byte packets that translates into 8-9 Gbit/s=
. That is far<br>from unrealistic any more. Current DCO implementations are=
 already in<br>spitting distance to that or might even reach (for a single =
client<br>connection) that if you have extremely fast<br>single core perfor=
mance CPU.<br><br>This introduces the 64bit packet counters for AEAD data c=
hannel<br>ciphers in TLS mode ciphers. No effort has been made to support<b=
r>larger packet counters in any scenario since the other scenarios<br>are a=
ll legacy.<br><br>While we still keep the old --secret logic around we use =
the same<br>weird unix timestamp + packet counter format to avoid refactori=
ng the<br>code now and again when we remove --secret code but DCO<br>implem=
entations are free to use just a single 64 bit counter. One<br>other small =
downside of this approach is that when rollover happens<br>and we get reord=
ering all the older packets are thrown away since<br>the distance between t=
he packet before and after the rollover is<br>quite large as we probably ju=
mp forward more than 1s (or more than<br>2^32 packet ids) forward. But this=
 is an obscure edge that we can<br>(currently) live with.<br><br>Change-Id:=
 I01e258e97351b5aa4b9e561f5b35ddc2318569e2<br>---<br>M src/openvpn/crypto.c=
<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openvpn/multi.c=
<br>M src/openvpn/options.c<br>M src/openvpn/push.c<br>M src/openvpn/ssl.c<=
br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_ncp.c<br>M tests/unit_te=
sts/openvpn/test_ssl.c<br>10 files changed, 105 insertions(+), 20 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
07/507/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</=
span><br><span>index 9988ebe..81b33fe 100644</span><br><span>--- a/src/open=
vpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ =
-68,6 +68,7 @@</span><br><span>     const struct key_ctx *ctx =3D &amp;opt-=
&gt;key_ctx_bi.encrypt;</span><br><span>     uint8_t *mac_out =3D NULL;</sp=
an><br><span>     const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool longiv =3D opt-&gt;fl=
ags &amp; CO_64_BIT_PKT_ID;</span><br><span> </span><br><span>     /* IV, p=
acket-ID and implicit IV required for this mode. */</span><br><span>     AS=
SERT(ctx-&gt;cipher);</span><br><span>@@ -86,7 +87,7 @@</span><br><span>   =
      buf_set_write(&amp;iv_buffer, iv, iv_len);</span><br><span> </span><b=
r><span>         /* IV starts with packet id to make the IV unique for pack=
et */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!pac=
ket_id_write(&amp;opt-&gt;packet_id.send, &amp;iv_buffer, false, false))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!packet_id=
_write(&amp;opt-&gt;packet_id.send, &amp;iv_buffer, longiv, false))</span><=
br><span>         {</span><br><span>             msg(D_CRYPT_ERRORS, &quot;=
ENCRYPT ERROR: packet ID roll over&quot;);</span><br><span>             got=
o err;</span><br><span>@@ -384,6 +385,8 @@</span><br><span>     /* IV and P=
acket ID required for this mode */</span><br><span>     ASSERT(packet_id_in=
itialized(&amp;opt-&gt;packet_id));</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool longiv =3D opt-&gt;flags &amp; C=
O_64_BIT_PKT_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     /* Combine IV from explicit part from packet and implici=
t part from context */</span><br><span>     {</span><br><span>         uint=
8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };</span><br><span>@@ -409,7 +412,7 @=
@</span><br><span>     }</span><br><span> </span><br><span>     /* Read pac=
ket ID from packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (!packet_id_read(&amp;pin, buf, false))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!packet_id_read(&amp;pin, buf, longiv))<=
/span><br><span>     {</span><br><span>         CRYPT_ERROR(&quot;error rea=
ding packet-id&quot;);</span><br><span>     }</span><br><span>diff --git a/=
src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index 95a5b31..=
0ef13e0 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+=
++ b/src/openvpn/crypto.h</span><br><span>@@ -283,6 +283,11 @@</span><br><s=
pan>     /**&lt; Bit-flag indicating that the AEAD tag is at the end of the=
</span><br><span>      *   packet.</span><br><span>      */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CO_64_BIT_PKT_ID  (1&lt;&lt=
;9)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**&lt; Bit-=
flag indicating that we should use a 64 bit (8 byte) packet</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * counter instead of the 32 bi=
t that we normally use.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> </span><br><span>     unsigned int flags;         /**&lt; Bit-fla=
gs determining behavior of</span><br><span>                                =
  *   security operation functions. */</span><br><span>diff --git a/src/ope=
nvpn/init.c b/src/openvpn/init.c</span><br><span>index cd37b36..7db8d06 100=
644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/open=
vpn/init.c</span><br><span>@@ -2327,6 +2327,10 @@</span><br><span>         =
{</span><br><span>             buf_printf(&amp;out, &quot; aead-tag-end&quo=
t;);</span><br><span>         }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (o-&gt;imported_protocol_flags &amp; CO_64_BIT_PKT_I=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp=
;out, &quot; pkt-id-64-bit&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span>     }</span><br><span> </span><br=
><span>     if (buf_len(&amp;out) &gt; strlen(header))</span><br><span>@@ -=
3297,6 +3301,16 @@</span><br><span>         to.push_peer_info_detail =3D 1;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Check if the DCO drivers support the new 64bit=
 packet counter and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * AEAD tag at the end */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (dco_enabled(options))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        to.data_v3_features_supported =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    to.data_v3_features_supported =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     /* sho=
uld we not xmit any packets until we get an initial</span><br><span>      *=
 response from client? */</span><br><span>diff --git a/src/openvpn/multi.c =
b/src/openvpn/multi.c</span><br><span>index 4344126..a80b9f4 100644</span><=
br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.=
c</span><br><span>@@ -1851,6 +1851,13 @@</span><br><span>         o-&gt;imp=
orted_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (tls_multi-&gt;session[TM_ACTIVE].opt-&gt;data_v3_features_supported</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (prot=
o &amp; IV_PROTO_DATA_V3))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 o-&gt;imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;imported_protocol_fla=
gs |=3D CO_64_BIT_PKT_ID;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     /* Select cipher if client supports Negotiable Crypto Paramet=
ers */</span><br><span> </span><br><span>     /* if we have already created=
 our key, we cannot *change* our own</span><br><span>diff --git a/src/openv=
pn/options.c b/src/openvpn/options.c</span><br><span>index 39f00c0..3f8fccf=
 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/s=
rc/openvpn/options.c</span><br><span>@@ -8690,6 +8690,10 @@</span><br><span=
>             {</span><br><span>                 options-&gt;imported_proto=
col_flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span>             }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (stre=
q(p[j], &quot;pkt-id-64-bit&quot;))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                options-&gt;imported_protocol_flags |=3D CO_64_BI=
T_PKT_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span>             else</span><br><span>             {</span>=
<br><span>                 msg(msglevel, &quot;Unknown protocol-flags flag:=
 %s&quot;, p[j]);</span><br><span>diff --git a/src/openvpn/push.c b/src/ope=
nvpn/push.c</span><br><span>index e4c122c..5766c97 100644</span><br><span>-=
-- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br>=
<span>@@ -691,6 +691,10 @@</span><br><span>     {</span><br><span>         =
buf_printf(&amp;proto_flags, &quot; aead-tag-end&quot;);</span><br><span>  =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;i=
mported_protocol_flags &amp; CO_64_BIT_PKT_ID)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        buf_printf(&amp;proto_flags, &quot; pkt-id-64-bit&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span> </span><br><span>     if (buf_len(&amp;proto_flags) &gt; 0)</span><b=
r><span>     {</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn=
/ssl.c</span><br><span>index 33c8670..6579ff9 100644</span><br><span>--- a/=
src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@=
@ -105,9 +105,11 @@</span><br><span>  * @param ctx                   Encryp=
t/decrypt key context</span><br><span>  * @param key                   HMAC=
 key, used to calculate implicit IV</span><br><span>  * @param key_len     =
          HMAC key length</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param long_pkt_id           64-bit packet counters are used</span=
><br><span>  */</span><br><span> static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint=
8_t *key, size_t key_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t=
 key_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                 bool long_pkt_id);</span><br><span> </span><br><span> </sp=
an><br><span> /**</span><br><span>@@ -1369,13 +1371,15 @@</span><br><span> =
    }</span><br><span>     else</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        bool longiv =3D ks-&gt;crypto_op=
tions.flags &amp; CO_64_BIT_PKT_ID;</span><br><span>         init_key_ctx_b=
i(key, key2, key_direction, key_type, &quot;Data Channel&quot;);</span><br>=
<span>         /* Initialize implicit IVs */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        key_ctx_update_implicit_iv(&amp;key-&gt;encr=
ypt, key2-&gt;keys[(int)server].hmac,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                   MAX_HMAC_KEY_LENGTH);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_ctx_update=
_implicit_iv(&amp;key-&gt;encrypt,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                   key2-&gt;keys[(int)server=
].hmac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                       MAX_HMAC_KEY_LENGTH, longiv);</span><br><span>      =
   key_ctx_update_implicit_iv(&amp;key-&gt;decrypt,</span><br><span>       =
                             key2-&gt;keys[1 - (int)server].hmac,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
    MAX_HMAC_KEY_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                   MAX_HMAC_KEY_LENGTH, longiv);</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span>@@ =
-1513,14 +1517,15 @@</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_ctx_up=
date_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+key_ctx_update_implicit_iv(=
struct key_ctx *ctx, uint8_t *key,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                           size_t key_len, bool longiv)</spa=
n><br><span> {</span><br><span>     /* Only use implicit IV in AEAD cipher =
mode, where HMAC key is not used */</span><br><span>     if (cipher_ctx_mod=
e_aead(ctx-&gt;cipher))</span><br><span>     {</span><br><span>         siz=
e_t impl_iv_len =3D 0;</span><br><span>         ASSERT(cipher_ctx_iv_length=
(ctx-&gt;cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        impl_iv_len =3D cipher_ctx_iv_length(c=
tx-&gt;cipher) - sizeof(packet_id_type);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;c=
ipher) - packet_id_size(longiv);</span><br><span>         ASSERT(impl_iv_le=
n &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         ASSERT(impl_iv_l=
en &lt;=3D key_len);</span><br><span>         memcpy(ctx-&gt;implicit_iv, k=
ey, impl_iv_len);</span><br><span>@@ -1935,6 +1940,12 @@</span><br><span>  =
       iv_proto |=3D IV_PROTO_DYN_TLS_CRYPT;</span><br><span> #endif</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* support for AEAD tag at the end and 8 byte IV */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;opt-&gt;data_v3_f=
eatures_supported)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 iv_proto |=3D IV_PROTO_DATA_V3;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>         buf_printf(&amp;out, &quot;IV_PROTO=3D%d\n&quo=
t;, iv_proto);</span><br><span> </span><br><span>         if (session-&gt;o=
pt-&gt;push_peer_info_detail &gt; 1)</span><br><span>diff --git a/src/openv=
pn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index f085e0d..5=
3bf763 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><spa=
n>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -311,7 +311,6 @@</span>=
<br><span> </span><br><span>     /* from command line */</span><br><span>  =
   bool single_session;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    bool disable_occ;</span><br><span>     int mode;</span><br><span>    =
 bool pull;</span><br><span>     /**</span><br><span>@@ -361,6 +360,8 @@</s=
pan><br><span>     const char *config_ciphername;</span><br><span>     cons=
t char *config_ncp_ciphers;</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool data_v3_features_supported; /**&lt; dco =
supports new data channel features */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     bool tls_crypt_v2;</span><br><span>=
     const char *tls_crypt_v2_verify_script;</span><br><span> </span><br><s=
pan>@@ -490,8 +491,6 @@</span><br><span>      */</span><br><span>     int k=
ey_id;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int limit_next;             /* used for traffic shaping on the contr=
ol channel */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     int verify_maxlevel;</span><br><span> </span><br><span>     c=
har *common_name;</span><br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/=
openvpn/ssl_ncp.c</span><br><span>index 0ca6d42..0b4ad8a 100644</span><br><=
span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.=
c</span><br><span>@@ -430,6 +430,12 @@</span><br><span>         session-&gt=
;opt-&gt;crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (session-&gt;opt-&gt;data_v3_features_supported &amp;&amp; (iv_proto_pee=
r &amp; IV_PROTO_DATA_V3))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 session-&gt;opt-&gt;crypto_flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        session-&gt;opt-&gt;cryp=
to_flags |=3D CO_64_BIT_PKT_ID;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> #if defined(HAVE_EXPORT_KEYING_MATERIAL)</span><br><span>  =
   if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span>     {<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/un=
it_tests/openvpn/test_ssl.c</span><br><span>index 0ded052..125d24b 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -128,9 +128,12 @=
@</span><br><span> {</span><br><span>     cipher_ctx_t *cipher =3D co-&gt;k=
ey_ctx_bi.encrypt.cipher;</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     if (cipher_ctx_mode_aead(ciph=
er))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(=
packet_id_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     bool longiv =3D co-&gt;flags &amp; CO_64_BIT_PKT_ID;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        size_t impl_iv_len =3D cipher_ctx_iv_length(ciph=
er) - packet_id_size(longiv);</span><br><span>         ASSERT(cipher_ctx_iv=
_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         AS=
SERT(cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><=
br><span> </span><br><span>@@ -142,6 +145,11 @@</span><br><span>         me=
mcpy(co-&gt;key_ctx_bi.decrypt.implicit_iv,</span><br><span>               =
 co-&gt;key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);</span><br><=
span>         co-&gt;key_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_len;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (longiv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            co-&gt;flags |=3D CO_64_BIT_PKT_ID;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span>@@ -280,6 +2=
88,25 @@</span><br><span> }</span><br><span> </span><br><span> static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+run_data_channel_wit=
h_cipher_end_and_long_pkt_counter(const char *cipher)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct crypto_options co =3D init_crypto_options(cipher=
, &quot;none&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    co.flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    do_data_channel_round_trip(&amp;co);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uninit_crypto_options(&amp;=
co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+run_data_channel_with_long_pkt_counter(const char *cipher)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options co =3D init_c=
rypto_options(cipher, &quot;none&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    co.flags |=3D CO_64_BIT_PKT_ID;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    do_data_channel_round_trip(&amp;co=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uninit_crypto=
_options(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span> run_data_channel_with_cipher=
(const char *cipher, const char *auth)</span><br><span> {</span><br><span> =
    struct crypto_options co =3D init_crypto_options(cipher, auth);</span><=
br><span>@@ -289,24 +316,30 @@</span><br><span> </span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+run_aead_channel_tests(const char *cipher)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    run_data_channel_with_cipher_end(cipher);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with_cipher(cipher, =
&quot;none&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   run_data_channel_with_cipher_end_and_long_pkt_counter(cipher);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with_lon=
g_pkt_counter(cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> test_=
data_channel_roundtrip_aes_128_gcm(void **state)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    run_data_channel_with_cip=
her_end(&quot;AES-128-GCM&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    run_data_channel_with_cipher(&quot;AES-128-GCM&quot;, &quot=
;none&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ru=
n_aead_channel_tests(&quot;AES-128-GCM&quot;);</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span> test_data_channel_ro=
undtrip_aes_192_gcm(void **state)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    run_data_channel_with_cipher_end(&quot;=
AES-192-GCM&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  run_data_channel_with_cipher(&quot;AES-192-GCM&quot;, &quot;none&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_aead_channel=
_tests(&quot;AES-192-GCM&quot;);</span><br><span> }</span><br><span> </span=
><br><span> static void</span><br><span> test_data_channel_roundtrip_aes_25=
6_gcm(void **state)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    run_data_channel_with_cipher_end(&quot;AES-256-GCM&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_data_chan=
nel_with_cipher(&quot;AES-256-GCM&quot;, &quot;none&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    run_aead_channel_tests(&quot;AE=
S-256-GCM&quot;);</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span>@@ -336,8 +369,7 @@</span><br><span>         retur=
n;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    run_data_channel_with_cipher_end(&quot;ChaCha20-P=
oly1305&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ru=
n_data_channel_with_cipher(&quot;ChaCha20-Poly1305&quot;, &quot;none&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_aead_chann=
el_tests(&quot;ChaCha20-Poly1305&quot;);</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">c=
hange 507</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b3=
5ddc2318569e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--C/lK9r8oQBw=--

