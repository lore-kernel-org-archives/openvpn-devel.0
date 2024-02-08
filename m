From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 8 Feb 2024 11:15:12 +0000
In-Reply-To: <gerrit.1705939439000.Ifa5ae96165d17b3cae4afc53e844bb34d1610e58@...2715...>
References: <gerrit.1705939439000.Ifa5ae96165d17b3cae4afc53e844bb34d1610e58@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <18fbab60088607a60af5ba0d0e3f9edfb7fbca27-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZZxR+9cIwqo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unit test for
 encrypting/decrypting data channel
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

--ZZxR+9cIwqo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/505?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add unit test for encrypting/decrypting data channel
......................................................................

Add unit test for encrypting/decrypting data channel

This test is reusing code from --test-crypto but is modified to not rely
on the static key functionality and also only tests the most common
algorithm. So it does not yet completely replace --test-crypto

Change-Id: Ifa5ae96165d17b3cae4afc53e844bb34d1610e58
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240208085749.869-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
195.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 223 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/505/4

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 18b9ec8..8c1fb5b 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -44,6 +44,9 @@
 #include "ssl_verify_backend.h"
 #include "win32.h"
 #include "test_common.h"
+#include "ssl.h"
+#include "buffer.h"
+#include "packet_id.h"

 /* Mock function to be allowed to include win32.c which is required for
  * getting the temp directory */
@@ -120,20 +123,238 @@
     gc_free(&gc);
 }

+static void
+init_implicit_iv(struct crypto_options *co)
+{
+    cipher_ctx_t *cipher =3D co->key_ctx_bi.encrypt.cipher;
+
+    if (cipher_ctx_mode_aead(cipher))
+    {
+        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(packe=
t_id_type);
+        ASSERT(cipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH);
+        ASSERT(cipher_ctx_iv_length(cipher) >=3D OPENVPN_AEAD_MIN_IV_LEN);
+
+        /* Generate dummy implicit IV */
+        ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
+                          OPENVPN_MAX_IV_LENGTH));
+        co->key_ctx_bi.encrypt.implicit_iv_len =3D impl_iv_len;
+
+        memcpy(co->key_ctx_bi.decrypt.implicit_iv,
+               co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
+        co->key_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_len;
+    }
+}
+
+static void
+init_frame_parameters(struct frame *frame)
+{
+    int overhead =3D 0;
+
+    /* tls-auth and tls-crypt */
+    overhead +=3D 128;
+
+    /* TCP length field and opcode */
+    overhead +=3D 3;
+
+    /* ACK array and remote SESSION ID (part of the ACK array) */
+    overhead +=3D ACK_SIZE(RELIABLE_ACK_SIZE);
+
+    /* Previous OpenVPN version calculated the maximum size and buffer of a
+     * control frame depending on the overhead of the data channel frame
+     * overhead and limited its maximum size to 1250. Since control frames
+     * also need to fit into data channel buffer we have the same
+     * default of 1500 + 100 as data channel buffers have. Increasing
+     * control channel mtu beyond this limit also increases the data chann=
el
+     * buffers */
+    int tls_mtu =3D 1500;
+    frame->buf.payload_size =3D tls_mtu + 100;
+
+    frame->buf.headroom =3D overhead;
+    frame->buf.tailroom =3D overhead;
+
+    frame->tun_mtu =3D tls_mtu;
+
+}
+
+static void
+do_data_channel_round_trip(struct crypto_options *co)
+{
+    struct gc_arena gc =3D gc_new();
+
+    /* initialise frame for the test */
+    struct frame frame;
+    init_frame_parameters(&frame);
+
+    struct buffer src =3D alloc_buf_gc(frame.buf.payload_size, &gc);
+    struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
+    struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
+    struct buffer buf =3D clear_buf();
+    void *buf_p;
+
+    /* init work */
+    ASSERT(buf_init(&work, frame.buf.headroom));
+
+    init_implicit_iv(co);
+    update_time();
+
+    /* Test encryption, decryption for all packet sizes */
+    for (int i =3D 1; i <=3D frame.buf.payload_size; ++i)
+    {
+
+        /* msg(M_INFO, "TESTING ENCRYPT/DECRYPT of packet length=3D%d", i)=
; */
+
+        /*
+         * Load src with random data.
+         */
+        ASSERT(buf_init(&src, 0));
+        ASSERT(i <=3D src.capacity);
+        src.len =3D i;
+        ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+
+        /* copy source to input buf */
+        buf =3D work;
+        buf_p =3D buf_write_alloc(&buf, BLEN(&src));
+        ASSERT(buf_p);
+        memcpy(buf_p, BPTR(&src), BLEN(&src));
+
+        /* initialize work buffer with buf.headroom bytes of prepend capac=
ity */
+        ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
+
+        /* encrypt */
+        openvpn_encrypt(&buf, encrypt_workspace, co);
+
+        /* decrypt */
+        openvpn_decrypt(&buf, decrypt_workspace, co, &frame, BPTR(&buf));
+
+        /* compare */
+        assert_int_equal(buf.len, src.len);
+        assert_memory_equal(BPTR(&src), BPTR(&buf), i);
+
+    }
+    gc_free(&gc);
+}
+
+
+
+struct crypto_options
+init_crypto_options(const char *cipher, const char *auth)
+{
+    struct key2 key2 =3D { .n =3D 2};
+
+    ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher)));
+    ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));
+    ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)));
+    ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));
+
+    struct crypto_options co =3D { 0 };
+
+    struct key_type kt =3D create_kt(cipher, auth, "ssl-test");
+
+    init_key_ctx_bi(&co.key_ctx_bi, &key2, 0, &kt, "unit-test-ssl");
+    packet_id_init(&co.packet_id,  5, 5, "UNITTEST", 0);
+
+    return co;
+}
+
+static void
+uninit_crypto_options(struct crypto_options *co)
+{
+    packet_id_free(&co->packet_id);
+    free_key_ctx_bi(&co->key_ctx_bi);
+
+}
+
+
+static void
+run_data_channel_with_cipher(const char *cipher, const char *auth)
+{
+    struct crypto_options co =3D init_crypto_options(cipher, auth);
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
+static void
+test_data_channel_roundtrip_aes_128_gcm(void **state)
+{
+    run_data_channel_with_cipher("AES-128-GCM", "none");
+}
+
+static void
+test_data_channel_roundtrip_aes_192_gcm(void **state)
+{
+    run_data_channel_with_cipher("AES-192-GCM", "none");
+}
+
+static void
+test_data_channel_roundtrip_aes_256_gcm(void **state)
+{
+    run_data_channel_with_cipher("AES-256-GCM", "none");
+}
+
+static void
+test_data_channel_roundtrip_aes_128_cbc(void **state)
+{
+    run_data_channel_with_cipher("AES-128-CBC", "SHA256");
+}
+
+static void
+test_data_channel_roundtrip_aes_192_cbc(void **state)
+{
+    run_data_channel_with_cipher("AES-192-CBC", "SHA256");
+}
+
+static void
+test_data_channel_roundtrip_aes_256_cbc(void **state)
+{
+    run_data_channel_with_cipher("AES-256-CBC", "SHA256");
+}
+
+static void
+test_data_channel_roundtrip_chacha20_poly1305(void **state)
+{
+    if (!cipher_valid("ChaCha20-Poly1305"))
+    {
+        skip();
+        return;
+    }
+    run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
+}
+
+static void
+test_data_channel_roundtrip_bf_cbc(void **state)
+{
+    if (!cipher_valid("BF-CBC"))
+    {
+        skip();
+        return;
+    }
+    run_data_channel_with_cipher("BF-CBC", "SHA1");
+}
+
+
 int
 main(void)
 {
     openvpn_unit_test_setup();

     const struct CMUnitTest tests[] =3D {
-        cmocka_unit_test(crypto_pem_encode_certificate)
+        cmocka_unit_test(crypto_pem_encode_certificate),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_chacha20_poly1305),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_128_cbc),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_192_cbc),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),
+        cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
     };
=20
 #if defined(ENABLE_CRYPTO_OPENSSL)
     tls_init_lib();
 #endif

-    int ret =3D cmocka_run_group_tests_name("crypto tests", tests, NULL, N=
ULL);
+    int ret =3D cmocka_run_group_tests_name("ssl tests", tests, NULL, NULL=
);

 #if defined(ENABLE_CRYPTO_OPENSSL)
     tls_free_lib();

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/505?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifa5ae96165d17b3cae4afc53e844bb34d1610e58
Gerrit-Change-Number: 505
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--ZZxR+9cIwqo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
505?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add unit test for encrypting/decrypting data =
channel<br><br>This test is reusing code from --test-crypto but is modified=
 to not rely<br>on the static key functionality and also only tests the mos=
t common<br>algorithm. So it does not yet completely replace --test-crypto<=
br><br>Change-Id: Ifa5ae96165d17b3cae4afc53e844bb34d1610e58<br>Acked-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240208085749.=
869-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg28195.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_ssl.c<br>1 file=
 changed, 223 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/05/505/4</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests=
/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span>=
<br><span>index 18b9ec8..8c1fb5b 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
ssl.c</span><br><span>@@ -44,6 +44,9 @@</span><br><span> #include &quot;ssl=
_verify_backend.h&quot;</span><br><span> #include &quot;win32.h&quot;</span=
><br><span> #include &quot;test_common.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;ssl.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;packet_id.h&quot=
;</span><br><span> </span><br><span> /* Mock function to be allowed to incl=
ude win32.c which is required for</span><br><span>  * getting the temp dire=
ctory */</span><br><span>@@ -120,20 +123,238 @@</span><br><span>     gc_fre=
e(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+init_implicit_iv(struct crypto_options *co)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    cipher_ctx_t *cipher =3D co-&gt;key_ctx_bi.e=
ncrypt.cipher;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_ctx_mode_=
aead(cipher))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t impl_=
iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(packet_id_type);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(cipher_ctx_iv_=
length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        ASSERT(cipher_ctx_iv_length(cipher) &gt;=
=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* Generate dummy implicit IV */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ASSERT(rand_bytes(co-&gt;key_ctx_bi.encrypt.implicit_iv=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
        OPENVPN_MAX_IV_LENGTH));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        co-&gt;key_ctx_bi.encrypt.implicit_iv_len =3D impl_iv_=
len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        memcpy(co-&gt;key_ctx_bi.d=
ecrypt.implicit_iv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
               co-&gt;key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co-&gt;ke=
y_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_len;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+init_frame_parameters(struct =
frame *frame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int overhead =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* tls-auth and tls-crypt */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    overhead +=3D 128;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* TCP length field and opcode */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    overhead +=3D 3;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* ACK array and remote SESSION ID (p=
art of the ACK array) */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    overhead +=3D ACK_SIZE(RELIABLE_ACK_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Previous OpenVPN version calculated the maximum size =
and buffer of a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * control frame depending on the overhead of the data channel frame</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * overhead and limite=
d its maximum size to 1250. Since control frames</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * also need to fit into data channel buff=
er we have the same</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * default of 1500 + 100 as data channel buffers have. Increasing</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * control channel mt=
u beyond this limit also increases the data channel</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * buffers */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int tls_mtu =3D 1500;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    frame-&gt;buf.payload_size =3D =
tls_mtu + 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    frame-&gt;buf.headro=
om =3D overhead;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 frame-&gt;buf.tailroom =3D overhead;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   frame-&gt;tun_mtu =3D tls_mtu;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+do_data_channel_round_trip(struct crypto_options =
*co)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* initialise frame for the tes=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct fram=
e frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_fr=
ame_parameters(&amp;frame);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer src =3D alloc_buf_gc(frame.buf.payload_size, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer work =3D alloc_=
buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer encrypt_workspace =3D alloc_buf_gc(BUF=
_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp=
;frame), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer buf =3D clear_buf();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    void *buf_p;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* init work */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ASSERT(buf_init(&amp;work, frame.buf.headroom));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    init_implicit_iv(co);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    update_time();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Test encryption, decryption for all packet sizes */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 1; i &lt;=3D frame.bu=
f.payload_size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* msg(M_INFO, &quot;TES=
TING ENCRYPT/DECRYPT of packet length=3D%d&quot;, i); */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * Load src with random data.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ASSERT(buf_init(&amp;src, 0));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(i &lt;=3D src.capacity=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src.len =
=3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSER=
T(rand_bytes(BPTR(&amp;src), BLEN(&amp;src)));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* copy source to input buf */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        buf =3D work;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        buf_p =3D buf_write_alloc(&amp;buf, BL=
EN(&amp;src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ASSERT(buf_p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      memcpy(buf_p, BPTR(&amp;src), BLEN(&amp;src));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* initialize work buffer with buf.headroom bytes of=
 prepend capacity */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ASSERT(buf_init(&amp;encrypt_workspace, frame.buf.headroom));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* encrypt */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        openvpn_encrypt(&amp;buf, encry=
pt_workspace, co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* decrypt *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_de=
crypt(&amp;buf, decrypt_workspace, co, &amp;frame, BPTR(&amp;buf));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* compare */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        assert_int_equal(buf.len, src.len);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_memor=
y_equal(BPTR(&amp;src), BPTR(&amp;buf), i);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
crypto_options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_=
crypto_options(const char *cipher, const char *auth)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct key2 key2 =3D { .n =3D 2};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[=
0].cipher)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(rand_bytes(key2.keys=
[1].cipher, sizeof(key2.keys[1].cipher)));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2=
.keys)[1].hmac));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_opt=
ions co =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_type =
kt =3D create_kt(cipher, auth, &quot;ssl-test&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    init_key_ctx_bi(&amp;co.key_ctx_bi, &amp;key2, 0, &amp;k=
t, &quot;unit-test-ssl&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    packet_id_init(&amp;co.packet_id,  5, 5, &quot;UNITTEST&quot=
;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return co;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uninit_=
crypto_options(struct crypto_options *co)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    packet_id_free(&amp;co-&gt;packet_id);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    free_key_ctx_bi(&amp;co-&gt;key_ctx_bi);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+run_data_channel_with_cipher(c=
onst char *cipher, const char *auth)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct crypto_options co =3D init_crypto_options(cipher, auth);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    do_data_channel_round_tr=
ip(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uni=
nit_crypto_options(&amp;co);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_data_channel_roundtrip_aes_128_=
gcm(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channel=
_with_cipher(&quot;AES-128-GCM&quot;, &quot;none&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_dat=
a_channel_roundtrip_aes_192_gcm(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    run_data_channel_with_cipher(&quot;AES-192-GCM&quot;, &quot;non=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_data_channel_roundtrip_aes_256_gcm(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with_cipher(&quot;=
AES-256-GCM&quot;, &quot;none&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_data_channel_roundtrip=
_aes_128_cbc(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_dat=
a_channel_with_cipher(&quot;AES-128-CBC&quot;, &quot;SHA256&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_data_channel_roundtrip_aes_192_cbc(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    run_data_channel_with_cipher(&quot;AES-192-CBC&quot;=
, &quot;SHA256&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_data_channel_roundtrip_aes_256_cbc(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with=
_cipher(&quot;AES-256-CBC&quot;, &quot;SHA256&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_data_c=
hannel_roundtrip_chacha20_poly1305(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!cipher_valid(&quot;ChaCha20-Poly1305&quot;))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        skip();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    run_data_channel_with_cipher(&quot;ChaCha20-Poly1305&quot;, &q=
uot;none&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_data_channel_roundtrip_bf_cbc(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!cipher_valid(&quot;BF-CBC&qu=
ot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        skip();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    run_data_channel_with_cipher(&quot;BF-CBC&quot=
;, &quot;SHA1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><sp=
an> main(void)</span><br><span> {</span><br><span>     openvpn_unit_test_se=
tup();</span><br><span> </span><br><span>     const struct CMUnitTest tests=
[] =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmock=
a_unit_test(crypto_pem_encode_certificate)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(crypto_pem_encode_certifica=
te),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_data_channel_roundtrip_aes_128_gcm),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_data_channe=
l_roundtrip_aes_192_gcm),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_data_channel_roundtrip_chacha20_poly1305),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_data_channel_r=
oundtrip_aes_128_cbc),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_data_channel_roundtrip_aes_192_cbc),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_data_channel_roundtrip_aes_256_cbc),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_data_channel_roundtrip_=
bf_cbc),</span><br><span>     };</span><br><span> </span><br><span> #if def=
ined(ENABLE_CRYPTO_OPENSSL)</span><br><span>     tls_init_lib();</span><br>=
<span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int ret =3D cmocka_run_group_tests_name(&quot;crypto tests&qu=
ot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int ret =3D cmocka_run_group_tests_name(&quot;ssl tests&quot;, tes=
ts, NULL, NULL);</span><br><span> </span><br><span> #if defined(ENABLE_CRYP=
TO_OPENSSL)</span><br><span>     tls_free_lib();</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
05?usp=3Demail">change 505</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/505?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifa5ae96165d17b3cae4afc53e84=
4bb34d1610e58 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 505 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ZZxR+9cIwqo=--

