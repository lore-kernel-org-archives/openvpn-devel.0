From: Arne Schwabe <arne@...1227...>
Date: Mon,  7 Sep 2020 18:22:19 +0200
Message-Id: <20200907162221.20928-1-arne@...1227...>
In-Reply-To: <20200825073643.15920-2-arne@...1227...>
References: <20200825073643.15920-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/5] Allow running a default configuration
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
for this, special case this one usage of BF-CBC enough to avoid a hard
requirement on Blowfish in the default configuration.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    | 18 +++++++++------
 src/openvpn/options.c | 51 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dff090b1..1e0baf2a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2752,14 +2752,18 @@ do_init_crypto_tls_c1(struct context *c)
 #endif /* if P2MP */
         }
 
-        /* Do not warn if we only have BF-CBC in options->ciphername
-         * because it is still the default cipher */
-        bool warn = !streq(options->ciphername, "BF-CBC")
-             || options->enable_ncp_fallback;
-        /* Get cipher & hash algorithms */
-        init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
-                      options->keysize, true, warn);
 
+        if (!options->ncp_enabled || options->enable_ncp_fallback
+            || !streq(options->ciphername, "BF-CBC"))
+        {
+            /* Get cipher & hash algorithms
+             * skip BF-CBC for NCP setups when cipher as this is the default
+             * and is also special cased later to allow it to be not available
+             * as we need to construct a fake BF-CBC occ string
+             */
+            init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
+                          options->keysize, true, true);
+        }
         /* Initialize PRNG with config-specified digest */
         prng_init(options->prng_hash, options->prng_nonce_secret_len);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 90e78a7b..01da88ad 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3640,11 +3640,32 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
     {
         struct frame fake_frame = *frame;
         struct key_type fake_kt;
-        init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
-                      false);
+
         frame_remove_from_extra_frame(&fake_frame, crypto_max_overhead());
-        crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
-                                       cipher_kt_mode_ofb_cfb(fake_kt.cipher));
+
+        /* o->ciphername can be still BF-CBC and our SSL library might not like
+         * like it, workaround this important corner case in the name of
+         * compatibility and not stopping openvpn on our default configuration
+         */
+        if ((strcmp(o->ciphername, "BF-CBC") == 0)
+            && cipher_kt_get(o->ciphername) == NULL)
+        {
+            init_key_type(&fake_kt, "none", o->authname, o->keysize, true,
+                          false);
+
+            crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
+                                           cipher_kt_mode_ofb_cfb(fake_kt.cipher));
+            /* 64 bit block size, 64 bit IV size */
+            frame_add_to_extra_frame(&fake_frame, 64/8 + 64/8);
+        }
+        else
+        {
+            init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
+                          false);
+
+            crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
+                                           cipher_kt_mode_ofb_cfb(fake_kt.cipher));
+        }
         frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
                        o->ce.tun_mtu_defined, o->ce.tun_mtu);
         msg(D_MTU_DEBUG, "%s: link-mtu %u -> %d", __func__, (unsigned int) link_mtu,
@@ -3812,18 +3833,32 @@ options_string(const struct options *o,
                + (TLS_SERVER == true)
                <= 1);
 
-        init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
-                      false);
+        /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
+         * to work here in the default configuration */
+        const char *ciphername = o->ciphername;
+        int keysize;
+
+        if (strcmp(o->ciphername, "BF-CBC") == 0) {
+            init_key_type(&kt, "none", o->authname, o->keysize, true,
+                          false);
+            ciphername = cipher_kt_name(kt.cipher);
+            keysize = 128;
+        }
+        else
+        {
+            init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
+                          false);
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
2.26.2


