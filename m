From: Arne Schwabe <arne@...1227...>
Date: Fri, 19 Feb 2021 17:52:52 +0100
Message-Id: <20210219165252.4562-1-arne@...1227...>
In-Reply-To: <20210216193215.GQ976@...1296...>
References: <20210216193215.GQ976@...1296...>
Subject: [Openvpn-devel] [PATCH v5] Allow running a default configuration
 with TLS libraries without BF-CBC
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

Modern TLS libraries might drop Blowfish by default or distributions
might disable Blowfish in OpenSSL/mbed TLS. We still signal OCC
options with BF-CBC compatible strings. To avoid requiring BF-CBC
for this, special this one usage of BF-CBC enough to avoid a hard
requirement on Blowfish in the default configuration.

Signed-off-by: Arne Schwabe <arne@...1227...>

Patch v2: add more clarifying comment, do not warn about OCC only insecure
          ciphers, code improvements

Patch V3: Put ciphername resolution via ciper_kt_name in the right branch

Patch V4: Fix cornercase of BF-CBC in data-ciphers not itialising cipher.

Patch v5: I accidently resend v3 as v4. So v5 is just a resend of the real v4
---
 src/openvpn/crypto_backend.h |  2 ++
 src/openvpn/init.c           | 37 ++++++++++++++++++++++------
 src/openvpn/options.c        | 47 +++++++++++++++++++++++++++++++-----
 3 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 384ffc80..93f7e475 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -241,6 +241,8 @@ const cipher_kt_t *cipher_kt_get(const char *ciphername);
  * The returned name is normalised to the OpenVPN config name in case the
  * name differs from the name used by the crypto library.
  *
+ * Returns [null-cipher] in case the cipher_kt is NULL.
+ *
  * @param cipher_kt     Static cipher parameters
  *
  * @return a statically allocated string describing the cipher.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 46c933b1..cfd71482 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2769,14 +2769,35 @@ do_init_crypto_tls_c1(struct context *c)
 #endif /* if P2MP */
         }
 
-        /* Do not warn if we only have BF-CBC in options->ciphername
-         * because it is still the default cipher */
-        bool warn = !streq(options->ciphername, "BF-CBC")
-             || options->enable_ncp_fallback;
-        /* Get cipher & hash algorithms */
-        init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
-                      options->keysize, true, warn);
-
+       /*
+        * BF-CBC is allowed to be used only when explicitly configured
+        * as NCP-fallback or when NCP has been disabled or explicitly
+        * allowed in the in ncp_ciphers list.
+        * In all other cases do not attempt to initialize BF-CBC as it
+        * may not even be supported by the underlying SSL library.
+        *
+        * Therefore, the key structure has to be initialized when:
+        * - any non-BF-CBC cipher was selected; or
+        * - BF-CBC is selected and NCP is disabled (explicit request to
+        *   use the BF-CBC cipher); or
+        * - BF-CBC is selected, NCP is enabled and fallback is enabled
+        *   (BF-CBC will be the fallback).
+        * - BF-CBC is in data-ciphers and we negotiate to use BF-CBC:
+        *   If the negotiated cipher and options->ciphername are the
+        *   same we do not reinit the cipher
+        *
+        * Note that BF-CBC will still be part of the OCC string to retain
+        * backwards compatibility with older clients.
+        */
+        if (!streq(options->ciphername, "BF-CBC") || !options->ncp_enabled
+            || (options->ncp_enabled && tls_item_in_cipher_list("BF-CBC", options->ncp_ciphers))
+            || options->enable_ncp_fallback)
+        {
+            /* Do not warn if the if the cipher is used only in OCC */
+            bool warn = !options->ncp_enabled || options->enable_ncp_fallback;
+            init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
+                          options->keysize, true, warn);
+        }
         /* Initialize PRNG with config-specified digest */
         prng_init(options->prng_hash, options->prng_nonce_secret_len);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 059386b3..c02ad051 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3609,9 +3609,29 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
     {
         struct frame fake_frame = *frame;
         struct key_type fake_kt;
-        init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
-                      false);
+
         frame_remove_from_extra_frame(&fake_frame, crypto_max_overhead());
+
+
+        /* o->ciphername might be BF-CBC even though the underlying SSL library
+         * does not support it. For this reason we workaround this corner case
+         * by pretending to have no encryption enabled and by manually adding
+         * the required packet overhead to the MTU computation.
+         */
+        const char* ciphername = o->ciphername;
+
+        if (strcmp(o->ciphername, "BF-CBC") == 0)
+        {
+            /* none has no overhead, so use this to later add only --auth
+             * overhead */
+
+            /* overhead of BF-CBC: 64 bit block size, 64 bit IV size */
+            frame_add_to_extra_frame(&fake_frame, 64/8 + 64/8);
+        }
+
+        init_key_type(&fake_kt, ciphername, o->authname, o->keysize, true,
+                      false);
+
         crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
                                        cipher_kt_mode_ofb_cfb(fake_kt.cipher));
         frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
@@ -3781,18 +3801,33 @@ options_string(const struct options *o,
                + (TLS_SERVER == true)
                <= 1);
 
-        init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
-                      false);
+        /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
+         * to work here in the default configuration */
+        const char *ciphername = o->ciphername;
+        int keysize;
+
+        if (strcmp(o->ciphername, "BF-CBC") == 0)
+        {
+            init_key_type(&kt, "none", o->authname, o->keysize, true,
+                          false);
+            keysize = 128;
+        }
+        else
+        {
+            init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
+                          false);
+            ciphername = cipher_kt_name(kt.cipher);
+            keysize = kt.cipher_length * 8;
+        }
         /* Only announce the cipher to our peer if we are willing to
          * support it */
-        const char *ciphername = cipher_kt_name(kt.cipher);
         if (p2p_nopull || !o->ncp_enabled
             || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
         {
             buf_printf(&out, ",cipher %s", ciphername);
         }
         buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
-        buf_printf(&out, ",keysize %d", kt.cipher_length * 8);
+        buf_printf(&out, ",keysize %d", keysize);
         if (o->shared_secret_file)
         {
             buf_printf(&out, ",secret");
-- 
2.30.0


