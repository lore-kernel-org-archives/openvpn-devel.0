From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 14:12:58 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., steffan@...1856..., max@...2606...,
 gert@...1296...
Message-ID: <9352f21b748d6446d60f6538cf4cbc7ed2cc4565-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KPiNJNe6xcw="; charset=UTF-8
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
To: syzzer <steffan@...1856...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KPiNJNe6xcw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, flichtenheld, plaisthos,=
 syzzer.

Hello MaxF, flichtenheld, syzzer,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail

to look at the new patch set (#13).

The following approvals got outdated and were removed:
Code-Review-1 by syzzer


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

For a VPN like OpenVPN, the same calculation would either require using a
pessimistic assumption of using a MTU size of 65k which limits us to
2^24 packets, which equals only 24 GB with more common MTU/MSS of 1400
or requiring a dynamic calculation which includes the actual MTU that
we allow to send. For 1500 the calculation yields 2*29.4 which is a
quite significant higher number of packets (923 GB at 1400 MSS/MTU).

To avoid this dynamic calculation and also avoid needing to know the
MSS/MTU size in the crypto layer, this implementation foregoes the
simplification of counting just packets but will count blocks and packets
instead and determines the limit from that.

This also has the side effect that connections with a lot of small packets
(like TCP ACKs) mixed with large packets will be able to keep using the same
key much longer until requiring a renegotiation.

This patch will set the limit where to trigger the renegotiation at 7/8
of the recommended maximum value.

[1]  https://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-08.html

Testing instructions:

The easiest way to test if this patch works as
intended is to manually change the return value of cipher_get_aead_limits
to some silly low value like 2048. After a bit of VPN traffic, a soft
reset should occur that indicates being over the

    TLS: soft reset sec=3D41/3600 bytes=3D59720/-1 pkts=3D78/0 aead_limit_s=
end=3D1883/1792 aead_limit_recv=3D1937/1792

Here the send limit is over the limit (1792 =3D 2048 * 8/7).

Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M tests/unit_tests/openvpn/test_crypto.c
6 files changed, 169 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/796/13

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
index 8f34eaa..89949d0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -134,6 +134,11 @@
     ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf),=
 BLEN(buf)));
     ASSERT(buf_inc_len(&work, outlen));

+    /* update number of plaintext blocks encrypted. Use the (x + (n-1))/n =
trick
+     * to round up the result to the number of blocks used */
+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.encrypt.plaintext_blocks +=3D (outlen + (blocksize - 1=
))/blocksize;
+
     /* Flush the encryption buffer */
     ASSERT(cipher_ctx_final(ctx->cipher, BEND(&work), &outlen));
     ASSERT(buf_inc_len(&work, outlen));
@@ -321,6 +326,37 @@
     }
 }

+uint64_t
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
+     *
+     * as is the one that is limiting us.
+     *
+     *  With p =3D 2^-57 this becomes
+     *
+     *      q + s <=3D (2^36 - 1)
+     *
+     */
+    uint64_t rs =3D (1ull << 36) - 1;
+
+    return rs;
+}
+
 bool
 crypto_check_replay(struct crypto_options *opt,
                     const struct packet_id_net *pin, const char *error_pre=
fix,
@@ -478,6 +514,12 @@
         goto error_exit;
     }

+
+    /* update number of plaintext blocks decrypted. Use the (x + (n-1))/n =
trick
+     * to round up the result to the number of blocks used. */
+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize - 1=
))/blocksize;
+
     *buf =3D work;

     gc_free(&gc);
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 074dad6..439d003 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -166,6 +166,10 @@
     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
     /**< The implicit part of the IV */
     size_t implicit_iv_len;     /**< The length of implicit_iv */
+    /** Counter for the number of plaintext block encrypted using this cip=
her
+     * with the current key in number of 128 bit blocks (only used for
+     * AEAD ciphers) */
+    uint64_t plaintext_blocks;
 };

 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -596,6 +600,25 @@
 }

 /**
+ * Check if the cipher is an AEAD cipher and needs to be limited to a cert=
ain
+ * number of number of blocks + packets. Return 0 if ciphername is not an =
AEAD
+ * cipher or no limit (e.g. Chacha20-Poly1305) is needed. (Or the limit is
+ * larger than 2^64)
+ *
+ * For reference see the OpenVPN RFC draft and
+ * https://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-08.html
+ */
+uint64_t
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
@@ -603,4 +626,20 @@
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
+aead_usage_limit_reached(const uint64_t limit, const struct key_ctx *key_c=
tx,
+                         int64_t higest_pid)
+{
+    /* This is the  q + s <=3D  p^(1/2) * 2^(129/2) - 1 calculation where
+     * q is the number of protected messages (highest_pid)
+     * s Total plaintext length in all messages (in blocks) */
+    return (limit > 0 && key_ctx->plaintext_blocks + (uint64_t) higest_pid=
 > limit);
+}
+
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33c22b4..ef09e20 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -131,6 +131,26 @@
     }
 }

+static uint64_t
+tls_get_limit_aead(const char *ciphername)
+{
+    uint64_t limit =3D cipher_get_aead_limits(ciphername);
+
+    if (limit =3D=3D 0)
+    {
+        return 0;
+    }
+
+    /* set limit to 7/8 of the limit so the renegotiation can succeed befo=
re
+     * we go over the limit */
+    limit =3D limit/8 * 7;
+
+    msg(D_SHOW_KEYS, "Note: AEAD cipher %s will trigger a renegotiation"
+        " at a sum of %" PRIi64 " blocks and packets.",
+        ciphername, limit);
+    return limit;
+}
+
 void
 tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu)
 {
@@ -1578,6 +1598,8 @@
     tls_limit_reneg_bytes(session->opt->key_type.cipher,
                           &session->opt->renegotiate_bytes);

+    session->opt->aead_usage_limit =3D tls_get_limit_aead(session->opt->ke=
y_type.cipher);
+
     /* set the state of the keys for the session to generated */
     ks->state =3D S_GENERATED_KEYS;

@@ -2998,6 +3020,27 @@
         return true;
     }

+    /* Check the AEAD usage limit of cleartext blocks + packets.
+     *
+     *  Contrary to when epoch data mode is active, where only the sender =
side
+     *  checks the limit, here we check both receive and send limit since
+     *  we assume that only one side is aware of the limit.
+     *
+     *  Since if both sides were aware, then both sides will probably also
+     *  switch to use epoch data channel instead, so this code is not
+     *  in effect then.
+     */
+    const struct key_ctx_bi *key_ctx_bi =3D &ks->crypto_options.key_ctx_bi;
+    const uint64_t usage_limit =3D session->opt->aead_usage_limit;
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
@@ -3030,10 +3073,17 @@
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
index 5840e2d..ccbc053 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -333,6 +333,9 @@
     interval_t packet_timeout;
     int64_t renegotiate_bytes;
     int64_t renegotiate_packets;
+    /** limit for AEAD cipher, this is the sum of packets + blocks
+     * that are allowed to be used */
+    uint64_t aead_usage_limit;
     interval_t renegotiate_seconds;

     /* cert verification parms */
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index fdc8fbd..ec8e661 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -448,6 +448,29 @@
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
+    /* Check if this matches our exception for 1600 size packets assuming
+     * AEAD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes). Gives us 100 blocks
+     * + 1 for the packet */
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
@@ -458,7 +481,8 @@
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
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--KPiNJNe6xcw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, cron2, flichtenheld, plaist=
hos, syzzer. </p>
<p>plaisthos <strong>uploaded patch set #13</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by syzzer</p><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Trigger renegotiation of data key if getting close =
to the AEAD usage limit<br><br>This implements the limitation of AEAD key u=
sage[1] with a confidentiality<br>margin of 2^-57, the same as TLS 1.3.  In=
 this implementation, unlike<br>TLS 1.3 that counts the number of records, =
we count the actual number of<br>packets and plaintext blocks. TLS 1.3 can =
reasonable assume that for<br>large data transfers, full records are used a=
nd therefore the maximum<br>record size of 2**14 (2*10 blocks) is used to c=
alculate the number of<br>records before a new key needs to be used.<br><br=
>For a VPN like OpenVPN, the same calculation would either require using a<=
br>pessimistic assumption of using a MTU size of 65k which limits us to<br>=
2^24 packets, which equals only 24 GB with more common MTU/MSS of 1400<br>o=
r requiring a dynamic calculation which includes the actual MTU that<br>we =
allow to send. For 1500 the calculation yields 2*29.4 which is a<br>quite s=
ignificant higher number of packets (923 GB at 1400 MSS/MTU).<br><br>To avo=
id this dynamic calculation and also avoid needing to know the<br>MSS/MTU s=
ize in the crypto layer, this implementation foregoes the<br>simplification=
 of counting just packets but will count blocks and packets<br>instead and =
determines the limit from that.<br><br>This also has the side effect that c=
onnections with a lot of small packets<br>(like TCP ACKs) mixed with large =
packets will be able to keep using the same<br>key much longer until requir=
ing a renegotiation.<br><br>This patch will set the limit where to trigger =
the renegotiation at 7/8<br>of the recommended maximum value.<br><br>[1]  h=
ttps://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-08.html<br><br>T=
esting instructions:<br><br>The easiest way to test if this patch works as<=
br>intended is to manually change the return value of cipher_get_aead_limit=
s<br>to some silly low value like 2048. After a bit of VPN traffic, a soft<=
br>reset should occur that indicates being over the<br><br>    TLS: soft re=
set sec=3D41/3600 bytes=3D59720/-1 pkts=3D78/0 aead_limit_send=3D1883/1792 =
aead_limit_recv=3D1937/1792<br><br>Here the send limit is over the limit (1=
792 =3D 2048 * 8/7).<br><br>Change-Id: I057f007577f10c6ac917ee4620ee3d25591=
87dc7<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M Ch=
anges.rst<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/open=
vpn/ssl.c<br>M src/openvpn/ssl_common.h<br>M tests/unit_tests/openvpn/test_=
crypto.c<br>6 files changed, 169 insertions(+), 3 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/796/13</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/Changes.rst b/Changes.rst</span><br><span>index a6cc3be..345=
42a5 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes=
.rst</span><br><span>@@ -22,6 +22,14 @@</span><br><span> </span><br><span> =
    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lw=
ipovpn).</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+Enforcement of AES-GCM usage limit</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OpenVPN will now enforce the usage limits on AES-=
GCM with the same</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  confidentiality margin as TLS 1.3 does. This mean that renegotiation will=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    be triggered af=
ter roughly 2^28 to 2^31 packets depending of the packet</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    size. More details about usage lim=
it of AES-GCM can be found here:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ht=
tps://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Deprecated featur=
es</span><br><span> -------------------</span><br><span> ``secret`` support=
 has been removed by default.</span><br><span>diff --git a/src/openvpn/cryp=
to.c b/src/openvpn/crypto.c</span><br><span>index 8f34eaa..89949d0 100644</=
span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn=
/crypto.c</span><br><span>@@ -134,6 +134,11 @@</span><br><span>     ASSERT(=
cipher_ctx_update(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen, BPTR(buf), =
BLEN(buf)));</span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* update number of plaintext blocks encrypted. Use the (x + (n-1))/n tric=
k</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to round up=
 the result to the number of blocks used */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const int blocksize =3D AEAD_LIMIT_BLOCKSIZE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opt-&gt;key_ctx_b=
i.encrypt.plaintext_blocks +=3D (outlen + (blocksize - 1))/blocksize;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* =
Flush the encryption buffer */</span><br><span>     ASSERT(cipher_ctx_final=
(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen));</span><br><span>     ASSER=
T(buf_inc_len(&amp;work, outlen));</span><br><span>@@ -321,6 +326,37 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+cipher_get_aead_limits(const char *ciphername)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!cipher_kt_mode_aead(ciphername)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (cipher_kt_name(ciphername) =3D=3D cipher_kt_name(&quot;CHAC=
HA20-POLY1305&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Assume all other ciphers require the lim=
it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* We focus here on the equat=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     *       q + s &lt;=3D p^=
(1/2) * 2^(129/2) - 1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * as i=
s the one that is limiting us.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   *  With p =3D 2^-57 this becomes</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     *      q + s &lt;=3D (2^36 - 1)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int64_t rs =3D (1ull &lt;&lt; 36) - 1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return rs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool<=
/span><br><span> crypto_check_replay(struct crypto_options *opt,</span><br>=
<span>                     const struct packet_id_net *pin, const char *err=
or_prefix,</span><br><span>@@ -478,6 +514,12 @@</span><br><span>         go=
to error_exit;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* update number of plaintext blocks decrypted. Use th=
e (x + (n-1))/n trick</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * to round up the result to the number of blocks used. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const int blocksize =3D AE=
AD_LIMIT_BLOCKSIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    opt-&gt;key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize -=
 1))/blocksize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     *buf =3D work;</span><br><span> </span><br><span>     gc_=
free(&amp;gc);</span><br><span>diff --git a/src/openvpn/crypto.h b/src/open=
vpn/crypto.h</span><br><span>index 074dad6..439d003 100644</span><br><span>=
--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span=
><br><span>@@ -166,6 +166,10 @@</span><br><span>     uint8_t implicit_iv[OP=
ENVPN_MAX_IV_LENGTH];</span><br><span>     /**&lt; The implicit part of the=
 IV */</span><br><span>     size_t implicit_iv_len;     /**&lt; The length =
of implicit_iv */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /** Counter for the number of plaintext block encrypted using this cipher=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * with the cur=
rent key in number of 128 bit blocks (only used for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * AEAD ciphers) */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint64_t plaintext_blocks;</span>=
<br><span> };</span><br><span> </span><br><span> #define KEY_DIRECTION_BIDI=
RECTIONAL 0 /* same keys for both directions */</span><br><span>@@ -596,6 +=
600,25 @@</span><br><span> }</span><br><span> </span><br><span> /**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if the cipher is a=
n AEAD cipher and needs to be limited to a certain</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * number of number of blocks + packets. Ret=
urn 0 if ciphername is not an AEAD</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * cipher or no limit (e.g. Chacha20-Poly1305) is needed. (O=
r the limit is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * la=
rger than 2^64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * For reference see =
the OpenVPN RFC draft and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * https://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-08.htm=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+cipher_get_aead_limits(const char *ciphername=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Blocksize used for the AEAD limit caluclation</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Since cipher_ctx_block_size() is not =
reliable and will return 1 in many</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * cases use a hardcoded blocksize instead */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define     AEAD_LIMIT_BLOCKSIZE  =
  16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Checks if =
the current TLS library supports the TLS 1.0 PRF with MD5+SHA1</span><br><s=
pan>  * that OpenVPN uses when TLS Keying Material Export is not available.=
</span><br><span>  *</span><br><span>@@ -603,4 +626,20 @@</span><br><span> =
 */</span><br><span> bool check_tls_prf_working(void);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Checks if the usage limit for an AE=
AD cipher is reached</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method a=
bstracts the calculation to make the calling function easier</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * to read.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+aead_usage_limit_reached(const uint64_t limit, const struc=
t key_ctx *key_ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                         int64_t higest_pid)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* This is the  q + s &lt;=3D  p^(1/2) * 2^(129/2) - 1 calculati=
on where</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * q is=
 the number of protected messages (highest_pid)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * s Total plaintext length in all messages=
 (in blocks) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (limit &gt; 0 &amp;&amp; key_ctx-&gt;plaintext_blocks + (uint64_t) h=
igest_pid &gt; limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #endif /* CRYPTO_H */</span><br><span>diff --git a/src/openvpn/ssl.c b/s=
rc/openvpn/ssl.c</span><br><span>index 33c22b4..ef09e20 100644</span><br><s=
pan>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><=
br><span>@@ -131,6 +131,26 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_get_l=
imit_aead(const char *ciphername)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint64_t limit =3D cipher_get_aead_limits(ciphername);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (limit =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* set limit to 7/8 of th=
e limit so the renegotiation can succeed before</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * we go over the limit */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    limit =3D limit/8 * 7;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(D_SHOW_KEYS, &quot;Note: AEAD cipher %s =
will trigger a renegotiation&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &quot; at a sum of %&quot; PRIi64 &quot; blocks and =
packets.&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ciphername, limit);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return limit;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> void</span><br><span> tls_init_control_channel_frame_parameters(struct fr=
ame *frame, int tls_mtu)</span><br><span> {</span><br><span>@@ -1578,6 +159=
8,8 @@</span><br><span>     tls_limit_reneg_bytes(session-&gt;opt-&gt;key_t=
ype.cipher,</span><br><span>                           &amp;session-&gt;opt=
-&gt;renegotiate_bytes);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    session-&gt;opt-&gt;aead_usage_limit =3D tls_get=
_limit_aead(session-&gt;opt-&gt;key_type.cipher);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     /* set the state of the=
 keys for the session to generated */</span><br><span>     ks-&gt;state =3D=
 S_GENERATED_KEYS;</span><br><span> </span><br><span>@@ -2998,6 +3020,27 @@=
</span><br><span>         return true;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check th=
e AEAD usage limit of cleartext blocks + packets.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     *  Contrary to when epoch data mode is active, where =
only the sender side</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     *  checks the limit, here we check both receive and send limit since<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  we assume th=
at only one side is aware of the limit.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     *  Since if both sides were aware, then both sides will probabl=
y also</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  switc=
h to use epoch data channel instead, so this code is not</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     *  in effect then.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const struct key_ctx_bi *key_ctx_bi =3D &a=
mp;ks-&gt;crypto_options.key_ctx_bi;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const uint64_t usage_limit =3D session-&gt;opt-&gt;aea=
d_usage_limit;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (aead_usage_limit=
_reached(usage_limit, &amp;key_ctx_bi-&gt;encrypt,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 ks-&gt;cryp=
to_options.packet_id.send.id)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        || aead_usage_limit_reached(usage_limit, &amp;key_ctx_bi-=
&gt;decrypt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                             ks-&gt;crypto_options.packet_id.rec.id))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     return false;</span><br><span>=
 }</span><br><span> /*</span><br><span>@@ -3030,10 +3073,17 @@</span><br><s=
pan>         &amp;&amp; should_trigger_renegotiation(session, ks))</span><b=
r><span>     {</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: sof=
t reset sec=3D%d/%d bytes=3D&quot; counter_format</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            &quot;/%&quot; PRIi64 &quot; pkts=
=3D&quot; counter_format &quot;/%&quot; PRIi64,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            &quot;/%&quot; PRIi64 &quot; pkts=
=3D&quot; counter_format &quot;/%&quot; PRIi64</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot; aead_limit_send=3D%&quot; PRI=
u64 &quot;/%&quot; PRIu64</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot; aead_limit_recv=3D%&quot; PRIu64 &quot;/%&quot; PR=
Iu64,</span><br><span>             (int) (now - ks-&gt;established), sessio=
n-&gt;opt-&gt;renegotiate_seconds,</span><br><span>             ks-&gt;n_by=
tes, session-&gt;opt-&gt;renegotiate_bytes,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            ks-&gt;n_packets, session-&gt;opt-&gt;ren=
egotiate_packets);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           ks-&gt;n_packets, session-&gt;opt-&gt;renegotiate_packets,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;crypto=
_options.key_ctx_bi.encrypt.plaintext_blocks + ks-&gt;n_packets,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            session-&gt;opt-&g=
t;aead_usage_limit,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            ks-&gt;crypto_options.key_ctx_bi.decrypt.plaintext_blocks + ks-=
&gt;n_packets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       session-&gt;opt-&gt;aead_usage_limit</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            );</span><br><span>         key_state_s=
oft_reset(session);</span><br><span>     }</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><b=
r><span>index 5840e2d..ccbc053 100644</span><br><span>--- a/src/openvpn/ssl=
_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@=
 -333,6 +333,9 @@</span><br><span>     interval_t packet_timeout;</span><br=
><span>     int64_t renegotiate_bytes;</span><br><span>     int64_t renegot=
iate_packets;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
* limit for AEAD cipher, this is the sum of packets + blocks</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * that are allowed to be used=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t aea=
d_usage_limit;</span><br><span>     interval_t renegotiate_seconds;</span><=
br><span> </span><br><span>     /* cert verification parms */</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/o=
penvpn/test_crypto.c</span><br><span>index fdc8fbd..ec8e661 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -448,6 +448,29 @@=
</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+crypto_test_aead_limits(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* if ChaCha20-Poly1305 is no=
t supported by the crypto library or in the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * current mode (FIPS), this will still return =
-1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(cipher_get_aead_limits(&quot;CHACHA20-POLY1305&quot;), 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int64_t aeslimit =3D cipher_get_aead_limits(=
&quot;AES-128-GCM&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(aeslimit, (1ull &lt;&lt; 36) - 1);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Check if this matches our exception for 1600 size packets assumi=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * AEAD_LIMIT=
_BLOCKSIZE (128 bits/ 16 bytes). Gives us 100 blocks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * + 1 for the packet */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int64_t L =3D 101;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* 2 ^ 29.34, using the r=
esult here to avoid linking to libm */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(aeslimit / L, 680390858);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* and for 9000, 2^26.86 */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    L =3D 563;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(aeslimit / L, 122059=
461);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br>=
<span> main(void)</span><br><span> {</span><br><span>@@ -458,7 +481,8 @@</s=
pan><br><span>         cmocka_unit_test(crypto_test_tls_prf),</span><br><sp=
an>         cmocka_unit_test(crypto_test_hmac),</span><br><span>         cm=
ocka_unit_test(test_occ_mtu_calculation),</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        cmocka_unit_test(test_mssfix_mtu_calculation)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_mssfix_mtu_calculation),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(crypto_test_aead_limits)</span><br><=
span>     };</span><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_O=
PENSSL)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">change 796</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/796?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--KPiNJNe6xcw=--

