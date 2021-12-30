From: Arne Schwabe <arne@...1227...>
Date: Thu, 30 Dec 2021 18:21:36 +0100
Message-Id: <20211230172136.2017215-1-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 09/21] Rework occ link-mtu calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Use the functions that directly compute the link mtu instead relying on the
frame logic.

Patch V2: rebase on master

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mtu.c                      |  43 +++++++++
 src/openvpn/mtu.h                      |  11 +++
 src/openvpn/options.c                  |  51 ----------
 tests/unit_tests/openvpn/Makefile.am   |   6 +-
 tests/unit_tests/openvpn/test_crypto.c | 128 ++++++++++++++++++++++++-
 tests/unit_tests/openvpn/test_misc.c   |   1 +
 6 files changed, 186 insertions(+), 54 deletions(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 662984f6..dac0c1de 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -138,6 +138,49 @@ frame_calculate_payload_size(const struct frame *frame, const struct options *op
     return payload_size;
 }
 
+size_t
+calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
+{
+    unsigned int payload = frame_calculate_payload_size(frame, o);
+
+    /* neither --secret nor TLS mode */
+    if (!o->tls_client && !o->tls_server && !o->shared_secret_file)
+    {
+        return payload;
+    }
+
+    struct key_type occ_kt;
+
+    /* o->ciphername might be BF-CBC even though the underlying SSL library
+     * does not support it. For this reason we workaround this corner case
+     * by pretending to have no encryption enabled and by manually adding
+     * the required packet overhead to the MTU computation.
+     */
+    const char* ciphername = o->ciphername;
+
+    unsigned int overhead = 0;
+
+    if (strcmp(o->ciphername, "BF-CBC") == 0)
+    {
+        /* none has no overhead, so use this to later add only --auth
+         * overhead */
+
+        /* overhead of BF-CBC: 64 bit block size, 64 bit IV size */
+        overhead += 64/8 + 64/8;
+        /* set ciphername to none, so its size does get added in the
+         * fake_kt and the cipher is not tried to be resolved */
+        ciphername = "none";
+    }
+
+    /* We pass tlsmode always true here since as we do not need to check if
+     * the ciphers are actually valid for non tls in occ calucation */
+    init_key_type(&occ_kt, ciphername, o->authname, true, false);
+
+    overhead += frame_calculate_protocol_header_size(&occ_kt, o, 0, true);
+
+    return payload + overhead;
+}
+
 void
 frame_finalize(struct frame *frame,
                bool link_mtu_defined,
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index ae83d3e7..f6013860 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -280,6 +280,17 @@ frame_calculate_protocol_header_size(const struct key_type *kt,
                                      unsigned int payload_size,
                                      bool occ);
 
+/**
+ * Calculate the link-mtu to advertise to our peer.  The actual value is not
+ * relevant, because we will possibly perform data channel cipher negotiation
+ * after this, but older clients will log warnings if we do not supply them the
+ * value they expect.  This assumes that the traditional cipher/auth directives
+ * in the config match the config of the peer.
+ */
+size_t
+calc_options_string_link_mtu(const struct options *options,
+                             const struct frame *frame);
+
 /*
  * frame_set_mtu_dynamic and flags
  */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fb049621..2ca24685 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3764,57 +3764,6 @@ pre_connect_restore(struct options *o, struct gc_arena *gc)
     o->data_channel_crypto_flags = 0;
 }
 
-/**
- * Calculate the link-mtu to advertise to our peer.  The actual value is not
- * relevant, because we will possibly perform data channel cipher negotiation
- * after this, but older clients will log warnings if we do not supply them the
- * value they expect.  This assumes that the traditional cipher/auth directives
- * in the config match the config of the peer.
- */
-static size_t
-calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
-{
-    size_t link_mtu = EXPANDED_SIZE(frame);
-
-    if (o->pull || o->mode == MODE_SERVER)
-    {
-        struct frame fake_frame = *frame;
-        struct key_type fake_kt;
-
-        frame_remove_from_extra_frame(&fake_frame, crypto_max_overhead());
-
-
-        /* o->ciphername might be BF-CBC even though the underlying SSL library
-         * does not support it. For this reason we workaround this corner case
-         * by pretending to have no encryption enabled and by manually adding
-         * the required packet overhead to the MTU computation.
-         */
-        const char* ciphername = o->ciphername;
-
-        if (strcmp(o->ciphername, "BF-CBC") == 0)
-        {
-            /* none has no overhead, so use this to later add only --auth
-             * overhead */
-
-            /* overhead of BF-CBC: 64 bit block size, 64 bit IV size */
-            frame_add_to_extra_frame(&fake_frame, 64/8 + 64/8);
-            /* set ciphername to none, so its size does get added in the
-             * fake_kt and the cipher is not tried to be resolved */
-            ciphername = "none";
-        }
-
-        init_key_type(&fake_kt, ciphername, o->authname, true, false);
-
-        crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
-                                       cipher_kt_mode_ofb_cfb(fake_kt.cipher));
-        frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
-                       o->ce.tun_mtu_defined, o->ce.tun_mtu);
-        msg(D_MTU_DEBUG, "%s: link-mtu %u -> %d", __func__, (unsigned int) link_mtu,
-            EXPANDED_SIZE(&fake_frame));
-        link_mtu = EXPANDED_SIZE(&fake_frame);
-    }
-    return link_mtu;
-}
 /*
  * Build an options string to represent data channel encryption options.
  * This string must match exactly between peers.  The keysize is checked
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 44b77cc5..f681b353 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -46,7 +46,9 @@ crypto_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/crypto_openssl.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c
+	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/mtu.c \
+	$(openvpn_srcdir)/mss.c
 
 packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
@@ -137,4 +139,4 @@ misc_testdriver_SOURCES = test_misc.c mock_msg.c \
     mock_get_random.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/ssl_util.c \
-	$(openvpn_srcdir)/platform.c
\ No newline at end of file
+	$(openvpn_srcdir)/platform.c
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 51672f9b..19ce174e 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -37,6 +37,7 @@
 #include <cmocka.h>
 
 #include "crypto.h"
+#include "options.h"
 #include "ssl_backend.h"
 
 #include "mock_msg.h"
@@ -234,6 +235,130 @@ test_des_encrypt(void **state)
     free(src2);
 }
 
+/* This test is in test_crypto as it calls into the functions that calculate
+ * the crypto overhead */
+static void
+test_occ_mtu_calculation(void **state)
+{
+    struct gc_arena gc = gc_new();
+
+    struct frame f = { 0 };
+    struct options o = { 0 };
+    size_t linkmtu;
+
+    /* common defaults */
+    o.ce.tun_mtu = 1400;
+    o.replay = true;
+    o.ce.proto = PROTO_UDP;
+
+    /* No crypto at all */
+    o.ciphername = "none";
+    o.authname = "none";
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1400);
+
+    /* Static key OCC examples */
+    o.shared_secret_file = "not null";
+
+    /* secret, auth none, cipher none */
+    o.ciphername = "none";
+    o.authname = "none";
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1408);
+
+    /* secret, cipher AES-128-CBC, auth none */
+    o.ciphername = "AES-128-CBC";
+    o.authname = "none";
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1440);
+
+    /* secret, cipher none, auth SHA256 */
+    o.ciphername = "none";
+    o.authname = "SHA256";
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1440);
+
+    /* --secret, cipher BF-CBC, auth SHA1 */
+    o.ciphername = "BF-CBC";
+    o.authname = "SHA1";
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1444);
+
+    /* --secret, cipher BF-CBC, auth SHA1, tcp-client */
+    o.ce.proto = PROTO_TCP_CLIENT;
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1446);
+
+    o.ce.proto = PROTO_UDP;
+
+    /* --secret, comp-lzo yes, cipher BF-CBC, auth SHA1 */
+    o.comp.alg = COMP_ALG_LZO;
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1445);
+
+    /* --secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
+    o.ce.fragment = 1200;
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1449);
+
+    o.comp.alg = COMP_ALG_UNDEF;
+    o.ce.fragment = 0;
+
+    /* TLS mode */
+    o.shared_secret_file = NULL;
+    o.tls_client = true;
+    o.pull = true;
+
+    /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth*/
+    o.authname = "SHA1";
+    o.ciphername = "AES-128-CBC";
+    o.tls_auth_file = "dummy";
+
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1457);
+
+    /* tls client, cipher AES-128-CBC, auth SHA1 */
+    o.tls_auth_file = NULL;
+
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1457);
+
+    /* tls client, cipher none, auth none */
+    o.authname = "none";
+    o.ciphername = "none";
+
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1405);
+
+    /* tls client, auth none, cipher none, no-replay */
+    o.replay = false;
+
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1401);
+
+
+    o.replay = true;
+
+    /* tls client, auth SHA1, cipher AES-256-GCM */
+    o.authname = "SHA1";
+    o.ciphername = "AES-256-GCM";
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1449);
+
+
+    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes */
+    o.comp.alg = COMP_ALG_LZO;
+    o.ce.fragment = 1200;
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1454);
+
+    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes, socks */
+    o.ce.socks_proxy_server = "socks.example.com";
+    linkmtu = calc_options_string_link_mtu(&o, &f);
+    assert_int_equal(linkmtu, 1464);
+
+    gc_free(&gc);
+}
 
 int
 main(void)
@@ -243,7 +368,8 @@ main(void)
         cmocka_unit_test(crypto_translate_cipher_names),
         cmocka_unit_test(crypto_test_tls_prf),
         cmocka_unit_test(crypto_test_hmac),
-        cmocka_unit_test(test_des_encrypt)
+        cmocka_unit_test(test_des_encrypt),
+        cmocka_unit_test(test_occ_mtu_calculation)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 70f726d0..867fa1bb 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -37,6 +37,7 @@
 #include <cmocka.h>
 
 #include "ssl_util.h"
+#include "options.h"
 
 static void
 test_compat_lzo_string(void **state)
-- 
2.33.0


