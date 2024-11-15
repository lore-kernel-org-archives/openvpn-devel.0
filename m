From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 15 Nov 2024 15:12:22 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <afcf6814afa043c75c922e428fd55d5bd2a97fea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yThkcLdzO1o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Trigger
 renegotiation of data key if getting close to the AEAD usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yThkcLdzO1o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail

to look at the new patch set (#4).


Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................

Trigger renegotiation of data key if getting close to the AEAD usage limit

This implements the limitation of AEAD key usage[1] with a confidentiality
margin of 2^-57, the same as TLS 1.3.  In this implementation, unlike
TLS 1.3 that counts the number of records, we count the actual number of
packets and plaintext blocks. TLS 1.3 can reasonable assume that for
large data transfers, full records are used and therefore the maximum
record size of 2**14 (2*10 blocks) is used to calculate the number of
records before a new key needs to be used.

For a VPN OpenVPN, the same calculation would either require using a
pessimistic assumption of using a MTU size of 65k which limits us to
2^24 packets, which equals only 24 GB with more common MTU/MSS of 1400
or requiring a dynamic calculation which includes the actual MTU that
we allow to send. For 1500 the calculation yields 2*29.4 which is a
quite significant higher number of packets (923 GB at 1400 MSS/MTU).

To avoid this dynamic calculation and also avoiding needing to know the
MSS/MTU size in the crypto layer, this implementation foregoes the
simplification of counting just packets but will count blocks and packets
instead and determines the limit from that.

This also has the side effects that connection with a lot of small packets
(like TCP ACKs) mixed with large packets will be able to keep using the same
much longer until requiring a renegotiation.

This patch will set the limit where to trigger the renegotiation at 7/8
of the

[1]  https://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-08.html

Change-Id: Idccc93f303d29869ef4ed10b6bb56f37efedf623

Testing instructions: The easiest way to test if this patch works as
intended is to manually change the return value of cipher_get_aead_limits
to some silly low value like 2048. After a bit of VPN traffic, a soft
reset should occur that indicates being over the

    TLS: soft reset sec=3D41/3600 bytes=3D59720/-1 pkts=3D78/0 aead_limit_s=
end=3D1883/1792 aead_limit_recv=3D1937/1792

Here the send limit is over the limit (1792 =3D 2048 * 8/7).
Change-Id: I0d2c763fd1dcdacdd8993731fc4979e258d1da4e

Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M tests/unit_tests/openvpn/test_crypto.c
6 files changed, 156 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/796/4

diff --git a/Changes.rst b/Changes.rst
index a6cc3be..34542a5 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -22,6 +22,14 @@

     For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).

+Enforcement of AES-GCM usage limit
+    OpenVPN will now enforce the usage limits on AES-GCM with the same
+    confidentiality margin as TLS 1.3 does. This mean that renegotiation w=
ill
+    be triggered after roughly 2^28 to 2^31 packets depending of the packet
+    size. More details about usage limit of AES-GCM can be found here:
+
+    https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8f34eaa..0aa310d 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -134,6 +134,11 @@
     ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf),=
 BLEN(buf)));
     ASSERT(buf_inc_len(&work, outlen));

+    /* update number of plaintext blocks encrypted. Use the x + (n-1)/n tr=
ick
+     * to round up the result to the number of blocked used */
+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.encrypt.plaintext_blocks +=3D (outlen + (blocksize - 1=
))/blocksize;
+
     /* Flush the encryption buffer */
     ASSERT(cipher_ctx_final(ctx->cipher, BEND(&work), &outlen));
     ASSERT(buf_inc_len(&work, outlen));
@@ -321,6 +326,38 @@
     }
 }

+int64_t
+cipher_get_aead_limits(const char *ciphername)
+{
+    if (!cipher_kt_mode_aead(ciphername))
+    {
+        return 0;
+    }
+
+    if (cipher_kt_name(ciphername) =3D=3D cipher_kt_name("CHACHA20-POLY130=
5"))
+    {
+        return 0;
+    }
+
+    /* Assume all other ciphers require the limit */
+
+    /* We focus here on the equation
+     *
+     *       q + s <=3D p^(1/2) * 2^(129/2) - 1
+     *       q <=3D (p^(1/2) * 2^(129/2) - 1) / (L + 1)
+     *
+     * as is the one that is limiting us.
+     *
+     *  With p =3D 2^-57 this becomes
+     *
+     *      q + s <=3D (p^36 - 1)
+     *
+     */
+    int64_t rs =3D (1ull << 36) - 1;
+
+    return rs;
+}
+
 bool
 crypto_check_replay(struct crypto_options *opt,
                     const struct packet_id_net *pin, const char *error_pre=
fix,
@@ -462,6 +499,11 @@
         CRYPT_ERROR("packet decryption failed");
     }

+    /* update number of plaintext blocks decrypted. Use the x + (n-1)/n tr=
ick
+     * to round up the result to the number of blocked used. */
+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize - 1=
))/blocksize;
+
     ASSERT(buf_inc_len(&work, outlen));
     if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen,
                                     &outlen, tag_ptr, tag_size))
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 074dad6..b742880 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -166,6 +166,9 @@
     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
     /**< The implicit part of the IV */
     size_t implicit_iv_len;     /**< The length of implicit_iv */
+    /** Counter for the number of plaintext encrypted using this cipher
+     * in number of 128 bit blocks (only used for AEAD ciphers) */
+    uint64_t plaintext_blocks;
 };

 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -596,6 +599,24 @@
 }

 /**
+ * Check if the cipher is an AEAD cipher and needs to be limited to a cert=
ain
+ * number of number of block + packets. Return -1 if ciphername is not an =
AEAD
+ * cipher or no limit (e.g. Chacha20-Poly1305) is needed.
+ *
+ * For reference see the OpenVPN RFC draft and
+ * https://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-08.html
+ */
+int64_t
+cipher_get_aead_limits(const char *ciphername);
+
+/**
+ * Blocksize used for the AEAD limit caluclation
+ *
+ * Since cipher_ctx_block_size() is not reliable and will return 1 in many
+ * cases use a hardcoded blocksize instead */
+#define     AEAD_LIMIT_BLOCKSIZE    16
+
+/**
  * Checks if the current TLS library supports the TLS 1.0 PRF with MD5+SHA1
  * that OpenVPN uses when TLS Keying Material Export is not available.
  *
@@ -603,4 +624,20 @@
  */
 bool check_tls_prf_working(void);

+/**
+ * Checks if the usage limit for an AEAD cipher is reached
+ *
+ * This method abstracts the calculation to make the calling function easi=
er
+ * to read.
+ */
+static inline bool
+aead_usage_limit_reached(const int64_t limit, const struct key_ctx *key_ct=
x,
+                         int64_t higest_pid)
+{
+    /* This is the  q + s <=3D  p^(1/2) * 2^(129/2) - 1 calculation where
+     * q is the number of protected messages (highest_pid)
+     * s Total plaintext length in all messages (in blocks) */
+    return (limit > 0 && key_ctx->plaintext_blocks + higest_pid > limit);
+}
+
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1f8eb1e..a8cc83b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -131,6 +131,26 @@
     }
 }

+static int64_t
+tls_get_limit_aead(const char *ciphername)
+{
+    int64_t limit =3D cipher_get_aead_limits(ciphername);
+
+    if (limit =3D=3D 0)
+    {
+        return 0;
+    }
+
+    /* set limit to 7/8 of the limit so the renogiation has can succeeds b=
efore
+     * we go over the limit */
+    limit =3D limit * 7/8;
+
+    msg(D_SHOW_KEYS, "Note: AEAD cipher %s will be limited to a sum of %"
+        PRIi64 " for block and packets before renegotiation",
+        ciphername, limit);
+    return limit;
+}
+
 void
 tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu)
 {
@@ -1576,6 +1596,8 @@
     tls_limit_reneg_bytes(session->opt->key_type.cipher,
                           &session->opt->renegotiate_bytes);

+    session->opt->aead_usage_limit =3D tls_get_limit_aead(session->opt->ke=
y_type.cipher);
+
     /* set the state of the keys for the session to generated */
     ks->state =3D S_GENERATED_KEYS;

@@ -2996,6 +3018,18 @@
         return true;
     }

+    /* Check the AEAD usage limit of cleartext blocks + packets */
+    const struct key_ctx_bi *key_ctx_bi =3D &ks->crypto_options.key_ctx_bi;
+    const int64_t usage_limit =3D session->opt->aead_usage_limit;
+
+    if (aead_usage_limit_reached(usage_limit, &key_ctx_bi->encrypt,
+                                 ks->crypto_options.packet_id.send.id)
+        || aead_usage_limit_reached(usage_limit, &key_ctx_bi->decrypt,
+                                    ks->crypto_options.packet_id.rec.id))
+    {
+        return true;
+    }
+
     return false;
 }
 /*
@@ -3028,10 +3062,17 @@
         && should_trigger_renegotiation(session, ks))
     {
         msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=3D%d/%d bytes=3D" counte=
r_format
-            "/%" PRIi64 " pkts=3D" counter_format "/%" PRIi64,
+            "/%" PRIi64 " pkts=3D" counter_format "/%" PRIi64
+            " aead_limit_send=3D%" PRIu64 "/%" PRIu64
+            " aead_limit_recv=3D%" PRIu64 "/%" PRIu64,
             (int) (now - ks->established), session->opt->renegotiate_secon=
ds,
             ks->n_bytes, session->opt->renegotiate_bytes,
-            ks->n_packets, session->opt->renegotiate_packets);
+            ks->n_packets, session->opt->renegotiate_packets,
+            ks->crypto_options.key_ctx_bi.encrypt.plaintext_blocks + ks->n=
_packets,
+            session->opt->aead_usage_limit,
+            ks->crypto_options.key_ctx_bi.decrypt.plaintext_blocks + ks->n=
_packets,
+            session->opt->aead_usage_limit
+            );
         key_state_soft_reset(session);
     }

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5840e2d..ce1cd9e 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -333,6 +333,9 @@
     interval_t packet_timeout;
     int64_t renegotiate_bytes;
     int64_t renegotiate_packets;
+    /** This limit for AEAD cipher, this is the sum of packets + blocks
+     * that are allowed to be used */
+    int64_t aead_usage_limit;
     interval_t renegotiate_seconds;
=20
     /* cert verification parms */
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index fdc8fbd..e573a8b 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -448,6 +448,27 @@
     gc_free(&gc);
 }

+void
+crypto_test_aead_limits(void **state)
+{
+    /* if ChaCha20-Poly1305 is not supported by the crypto library or in t=
he
+     * current mode (FIPS), this will still return -1 */
+    assert_int_equal(cipher_get_aead_limits("CHACHA20-POLY1305"), 0);
+
+    int64_t aeslimit =3D cipher_get_aead_limits("AES-128-GCM");
+
+    assert_int_equal(aeslimit, (1ull << 36) - 1);
+
+    /* Check if this matches our exception for 1600 size packets */
+    int64_t L =3D 101;
+    /* 2 ^ 29.34, using the result here to avoid linking to libm */
+    assert_int_equal(aeslimit / L, 680390858);
+
+    /* and for 9000, 2^26.86 */
+    L =3D 563;
+    assert_int_equal(aeslimit / L, 122059461);
+}
+
 int
 main(void)
 {
@@ -458,7 +479,8 @@
         cmocka_unit_test(crypto_test_tls_prf),
         cmocka_unit_test(crypto_test_hmac),
         cmocka_unit_test(test_occ_mtu_calculation),
-        cmocka_unit_test(test_mssfix_mtu_calculation)
+        cmocka_unit_test(test_mssfix_mtu_calculation),
+        cmocka_unit_test(crypto_test_aead_limits)
     };

 #if defined(ENABLE_CRYPTO_OPENSSL)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--yThkcLdzO1o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Trigger renegotiation of data key if getting close to the AEAD usage =
limit<br><br>This implements the limitation of AEAD key usage[1] with a con=
fidentiality<br>margin of 2^-57, the same as TLS 1.3.  In this implementati=
on, unlike<br>TLS 1.3 that counts the number of records, we count the actua=
l number of<br>packets and plaintext blocks. TLS 1.3 can reasonable assume =
that for<br>large data transfers, full records are used and therefore the m=
aximum<br>record size of 2**14 (2*10 blocks) is used to calculate the numbe=
r of<br>records before a new key needs to be used.<br><br>For a VPN OpenVPN=
, the same calculation would either require using a<br>pessimistic assumpti=
on of using a MTU size of 65k which limits us to<br>2^24 packets, which equ=
als only 24 GB with more common MTU/MSS of 1400<br>or requiring a dynamic c=
alculation which includes the actual MTU that<br>we allow to send. For 1500=
 the calculation yields 2*29.4 which is a<br>quite significant higher numbe=
r of packets (923 GB at 1400 MSS/MTU).<br><br>To avoid this dynamic calcula=
tion and also avoiding needing to know the<br>MSS/MTU size in the crypto la=
yer, this implementation foregoes the<br>simplification of counting just pa=
ckets but will count blocks and packets<br>instead and determines the limit=
 from that.<br><br>This also has the side effects that connection with a lo=
t of small packets<br>(like TCP ACKs) mixed with large packets will be able=
 to keep using the same<br>much longer until requiring a renegotiation.<br>=
<br>This patch will set the limit where to trigger the renegotiation at 7/8=
<br>of the<br><br>[1]  https://www.ietf.org/archive/id/draft-irtf-cfrg-aead=
-limits-08.html<br><br>Change-Id: Idccc93f303d29869ef4ed10b6bb56f37efedf623=
<br><br>Testing instructions: The easiest way to test if this patch works a=
s<br>intended is to manually change the return value of cipher_get_aead_lim=
its<br>to some silly low value like 2048. After a bit of VPN traffic, a sof=
t<br>reset should occur that indicates being over the<br><br>    TLS: soft =
reset sec=3D41/3600 bytes=3D59720/-1 pkts=3D78/0 aead_limit_send=3D1883/179=
2 aead_limit_recv=3D1937/1792<br><br>Here the send limit is over the limit =
(1792 =3D 2048 * 8/7).<br>Change-Id: I0d2c763fd1dcdacdd8993731fc4979e258d1d=
a4e<br><br>Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M Changes.rst<br>M sr=
c/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/ssl.c<br>M sr=
c/openvpn/ssl_common.h<br>M tests/unit_tests/openvpn/test_crypto.c<br>6 fil=
es changed, 156 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/96/796/4</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Cha=
nges.rst b/Changes.rst</span><br><span>index a6cc3be..34542a5 100644</span>=
<br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><sp=
an>@@ -22,6 +22,14 @@</span><br><span> </span><br><span>     For more detai=
ls see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn).</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Enforcement=
 of AES-GCM usage limit</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OpenVPN will now enforce the usage limits on AES-GCM with the same<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    confidentiality =
margin as TLS 1.3 does. This mean that renegotiation will</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    be triggered after roughly 2^28 t=
o 2^31 packets depending of the packet</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    size. More details about usage limit of AES-GCM can =
be found here:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    https://datatracker.=
ietf.org/doc/draft-irtf-cfrg-aead-limits/</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> Deprecated features</span><br><span=
> -------------------</span><br><span> ``secret`` support has been removed =
by default.</span><br><span>diff --git a/src/openvpn/crypto.c b/src/openvpn=
/crypto.c</span><br><span>index 8f34eaa..0aa310d 100644</span><br><span>---=
 a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><b=
r><span>@@ -134,6 +134,11 @@</span><br><span>     ASSERT(cipher_ctx_update(=
ctx-&gt;cipher, BEND(&amp;work), &amp;outlen, BPTR(buf), BLEN(buf)));</span=
><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* update number =
of plaintext blocks encrypted. Use the x + (n-1)/n trick</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * to round up the result to the n=
umber of blocked used */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_bi.encrypt.plaintext=
_blocks +=3D (outlen + (blocksize - 1))/blocksize;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Flush the encryptio=
n buffer */</span><br><span>     ASSERT(cipher_ctx_final(ctx-&gt;cipher, BE=
ND(&amp;work), &amp;outlen));</span><br><span>     ASSERT(buf_inc_len(&amp;=
work, outlen));</span><br><span>@@ -321,6 +326,38 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int64_t</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+cipher_get_aead_limits(const char *ciphername)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!cipher_kt_mode_aead(ciphername))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cip=
her_kt_name(ciphername) =3D=3D cipher_kt_name(&quot;CHACHA20-POLY1305&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Assume all other ciphers require the limit */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* We focus here on the equation</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     *       q + s &lt;=3D p^(1/2) * 2^(129/2) -=
 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *       q &l=
t;=3D (p^(1/2) * 2^(129/2) - 1) / (L + 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * as is the one that is limiting us.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     *  With p =3D 2^-57 this becomes</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     *      q + s &lt;=3D (p^36 - 1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int64_t rs =3D (1ull &lt;&lt; 36) - 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return rs;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> bool</span><br><span> crypto_check_replay(struct crypto_optio=
ns *opt,</span><br><span>                     const struct packet_id_net *p=
in, const char *error_prefix,</span><br><span>@@ -462,6 +499,11 @@</span><b=
r><span>         CRYPT_ERROR(&quot;packet decryption failed&quot;);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* update number of plaintext blocks decrypted. Use the x=
 + (n-1)/n trick</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * to round up the result to the number of blocked used. */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const int blocksize =3D AEAD_L=
IMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
opt-&gt;key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize - 1))=
/blocksize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span>     =
if (!cipher_ctx_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen,</=
span><br><span>                                     &amp;outlen, tag_ptr, t=
ag_size))</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/c=
rypto.h</span><br><span>index 074dad6..b742880 100644</span><br><span>--- a=
/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br>=
<span>@@ -166,6 +166,9 @@</span><br><span>     uint8_t implicit_iv[OPENVPN_=
MAX_IV_LENGTH];</span><br><span>     /**&lt; The implicit part of the IV */=
</span><br><span>     size_t implicit_iv_len;     /**&lt; The length of imp=
licit_iv */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** =
Counter for the number of plaintext encrypted using this cipher</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * in number of 128 bit blo=
cks (only used for AEAD ciphers) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint64_t plaintext_blocks;</span><br><span> };</span><b=
r><span> </span><br><span> #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same ke=
ys for both directions */</span><br><span>@@ -596,6 +599,24 @@</span><br><s=
pan> }</span><br><span> </span><br><span> /**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Check if the cipher is an AEAD cipher and need=
s to be limited to a certain</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * number of number of block + packets. Return -1 if ciphername is=
 not an AEAD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ciph=
er or no limit (e.g. Chacha20-Poly1305) is needed.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * For reference see the OpenVPN RFC draft and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * https://www.ietf.org/archive/id=
/draft-irtf-cfrg-aead-limits-08.html</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_get_=
aead_limits(const char *ciphername);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Blocksize used =
for the AEAD limit caluclation</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sin=
ce cipher_ctx_block_size() is not reliable and will return 1 in many</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * cases use a hardcoded b=
locksize instead */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define     AEAD_LIMIT_BLOCKSIZE    16</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span>  * Checks if the current TLS library supports the TLS =
1.0 PRF with MD5+SHA1</span><br><span>  * that OpenVPN uses when TLS Keying=
 Material Export is not available.</span><br><span>  *</span><br><span>@@ -=
603,4 +624,20 @@</span><br><span>  */</span><br><span> bool check_tls_prf_w=
orking(void);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * C=
hecks if the usage limit for an AEAD cipher is reached</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * This method abstracts the calculation to make the call=
ing function easier</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * to read.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+aead_usage_limit_reached(=
const int64_t limit, const struct key_ctx *key_ctx,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         int64_t higest_p=
id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* This is the  q + s &lt;=3D =
 p^(1/2) * 2^(129/2) - 1 calculation where</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * q is the number of protected messages (highes=
t_pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * s Tota=
l plaintext length in all messages (in blocks) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return (limit &gt; 0 &amp;&amp; key_ctx-&=
gt;plaintext_blocks + higest_pid &gt; limit);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #endif /* CRYPTO_H */</span><br><span>diff --git =
a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 1f8eb1e..a8cc=
83b 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/sr=
c/openvpn/ssl.c</span><br><span>@@ -131,6 +131,26 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int64_t</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tls_get_limit_aead(const char *ciphername)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int64_t limit =3D cipher_get_aead_limits(ciphername);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (limit =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* s=
et limit to 7/8 of the limit so the renogiation has can succeeds before</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * we go over the l=
imit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    limit =
=3D limit * 7/8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_KEYS, &=
quot;Note: AEAD cipher %s will be limited to a sum of %&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        PRIi64 &quot; for block a=
nd packets before renegotiation&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ciphername, limit);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return limit;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> void</span><br><span> tls_init_control_channel_fra=
me_parameters(struct frame *frame, int tls_mtu)</span><br><span> {</span><b=
r><span>@@ -1576,6 +1596,8 @@</span><br><span>     tls_limit_reneg_bytes(se=
ssion-&gt;opt-&gt;key_type.cipher,</span><br><span>                        =
   &amp;session-&gt;opt-&gt;renegotiate_bytes);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;opt-&gt;aead_=
usage_limit =3D tls_get_limit_aead(session-&gt;opt-&gt;key_type.cipher);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
/* set the state of the keys for the session to generated */</span><br><spa=
n>     ks-&gt;state =3D S_GENERATED_KEYS;</span><br><span> </span><br><span=
>@@ -2996,6 +3018,18 @@</span><br><span>         return true;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Check the AEAD usage limit of cleartext blocks + packets */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct key=
_ctx_bi *key_ctx_bi =3D &amp;ks-&gt;crypto_options.key_ctx_bi;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const int64_t usage_limit =
=3D session-&gt;opt-&gt;aead_usage_limit;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (aead_usage_limit_reached(usage_limit, &amp;key_ctx_bi-&gt;encryp=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                ks-&gt;crypto_options.packet_id.send.id)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        || aead_usage_limit_reached(us=
age_limit, &amp;key_ctx_bi-&gt;decrypt,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                    ks-&gt;crypto_optio=
ns.packet_id.rec.id))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ret=
urn false;</span><br><span> }</span><br><span> /*</span><br><span>@@ -3028,=
10 +3062,17 @@</span><br><span>         &amp;&amp; should_trigger_renegotia=
tion(session, ks))</span><br><span>     {</span><br><span>         msg(D_TL=
S_DEBUG_LOW, &quot;TLS: soft reset sec=3D%d/%d bytes=3D&quot; counter_forma=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;/%=
&quot; PRIi64 &quot; pkts=3D&quot; counter_format &quot;/%&quot; PRIi64,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;/%&q=
uot; PRIi64 &quot; pkts=3D&quot; counter_format &quot;/%&quot; PRIi64</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot; aead_l=
imit_send=3D%&quot; PRIu64 &quot;/%&quot; PRIu64</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot; aead_limit_recv=3D%&quot; P=
RIu64 &quot;/%&quot; PRIu64,</span><br><span>             (int) (now - ks-&=
gt;established), session-&gt;opt-&gt;renegotiate_seconds,</span><br><span> =
            ks-&gt;n_bytes, session-&gt;opt-&gt;renegotiate_bytes,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            ks-&gt;n_packets, =
session-&gt;opt-&gt;renegotiate_packets);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            ks-&gt;n_packets, session-&gt;opt-&gt;ren=
egotiate_packets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          ks-&gt;crypto_options.key_ctx_bi.encrypt.plaintext_blocks + ks-&g=
t;n_packets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     session-&gt;opt-&gt;aead_usage_limit,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            ks-&gt;crypto_options.key_ctx_bi.decrypt=
.plaintext_blocks + ks-&gt;n_packets,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            session-&gt;opt-&gt;aead_usage_limit</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            );</span><br><sp=
an>         key_state_soft_reset(session);</span><br><span>     }</span><br=
><span> </span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvp=
n/ssl_common.h</span><br><span>index 5840e2d..ce1cd9e 100644</span><br><spa=
n>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_comm=
on.h</span><br><span>@@ -333,6 +333,9 @@</span><br><span>     interval_t pa=
cket_timeout;</span><br><span>     int64_t renegotiate_bytes;</span><br><sp=
an>     int64_t renegotiate_packets;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /** This limit for AEAD cipher, this is the sum of pac=
kets + blocks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 that are allowed to be used */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int64_t aead_usage_limit;</span><br><span>     interval_t r=
enegotiate_seconds;</span><br><span> </span><br><span>     /* cert verifica=
tion parms */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cr=
ypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>index fdc8f=
bd..e573a8b 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_cryp=
to.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br=
><span>@@ -448,6 +448,27 @@</span><br><span>     gc_free(&amp;gc);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto=
_test_aead_limits(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 if ChaCha20-Poly1305 is not supported by the crypto library or in the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * current mode (FIP=
S), this will still return -1 */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(cipher_get_aead_limits(&quot;CHACHA20-POL=
Y1305&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int64_t aeslimit =
=3D cipher_get_aead_limits(&quot;AES-128-GCM&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(aeslimit, (1ull &lt;&lt; 36) - 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Check if this matches our exceptio=
n for 1600 size packets */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int64_t L =3D 101;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* 2 ^ 29.34, using the result here to avoid linking to libm =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(aeslimit / L, 680390858);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* an=
d for 9000, 2^26.86 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    L =3D 563;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(aeslimit / L, 122059461);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> int</span><br><span> main(void)</span><br><span> {=
</span><br><span>@@ -458,7 +479,8 @@</span><br><span>         cmocka_unit_t=
est(crypto_test_tls_prf),</span><br><span>         cmocka_unit_test(crypto_=
test_hmac),</span><br><span>         cmocka_unit_test(test_occ_mtu_calculat=
ion),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_u=
nit_test(test_mssfix_mtu_calculation)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_mssfix_mtu_calculation),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(crypto_test_aead_limits)</span><br><span>     };</span><br><span> </span=
><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796=
?usp=3Demail">change 796</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--yThkcLdzO1o=--

