From: Gert Doering <gert@...1296...>
Date: Thu,  9 Jan 2025 22:28:03 +0100
Message-ID: <20250109212803.11505-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
References: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v12] Rename aead-tag-at-end to aead-epoch
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

From: Arne Schwabe <arne@...1227...>

Since we introduce aead at the end and epoch data keys together
and only allow the aead tag at the end if epoch data keys are
used, we can use just one flag for both of them

Change-Id: I9e9433b56dcbaa538d9bed30e50cf74948c647cc
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/805
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 5ca85e0..0aee9e2 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -367,6 +367,7 @@
     - bit 7: The client is capable of sending exit notification via control channel using ``EXIT`` message. Also, the client is accepting the protocol-flags pushed option for the EKM capability
     - bit 8: The client is capable of accepting ``AUTH_FAILED,TEMP`` messages
     - bit 9: The client is capable of dynamic tls-crypt
+    - bit 10: The client is capable of data epoch keys
 
   :code:`IV_NCP=2`
         Negotiable ciphers, client supports ``--cipher`` pushed by
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index b107f88..84ec436 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -127,7 +127,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s",
          format_hex(BPTR(&work), BLEN(&work), 0, &gc));
 
-    if (!(opt->flags & CO_AEAD_TAG_AT_THE_END))
+    if (!(opt->flags & CO_EPOCH_DATA_KEY_FORMAT))
     {
         /* Reserve space for authentication tag */
         mac_out = buf_write_alloc(&work, mac_len);
@@ -148,7 +148,7 @@
     ASSERT(buf_inc_len(&work, outlen));
 
     /* if the tag is at end the end, allocate it now */
-    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
     {
         /* Reserve space for authentication tag */
         mac_out = buf_write_alloc(&work, mac_len);
@@ -479,7 +479,7 @@
     uint8_t *tag_ptr = NULL;
     int data_len = 0;
 
-    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
     {
         data_len = BLEN(buf) - tag_size;
         tag_ptr = BPTR(buf) + data_len;
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index a98dca0..b58e4ef 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -373,9 +373,11 @@
     /**< Bit-flag indicating that renegotiations are using tls-crypt
      *   with a TLS-EKM derived key.
      */
-#define CO_AEAD_TAG_AT_THE_END  (1<<8)
-    /**< Bit-flag indicating that the AEAD tag is at the end of the
-     *   packet.
+#define CO_EPOCH_DATA_KEY_FORMAT  (1<<8)
+    /**< Bit-flag indicating the epoch the data format. This format
+     * has the AEAD tag is at the end of the packet and using a longer
+     * 64-bit packet id that is split into a 16 bit epoch and 48 bit
+     * epoch counter
      */
 
     unsigned int flags;         /**< Bit-flags determining behavior of
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2bd5518..9d1048c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2407,9 +2407,9 @@
         {
             buf_printf(&out, " dyn-tls-crypt");
         }
-        if (o->imported_protocol_flags & CO_AEAD_TAG_AT_THE_END)
+        if (o->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT)
         {
-            buf_printf(&out, " aead-tag-end");
+            buf_printf(&out, " aead-epoch");
         }
     }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1c35d67..eb0d9b5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8659,9 +8659,9 @@
                 options->imported_protocol_flags |= CO_USE_DYNAMIC_TLS_CRYPT;
             }
 #endif
-            else if (streq(p[j], "aead-tag-end"))
+            else if (streq(p[j], "aead-epoch"))
             {
-                options->imported_protocol_flags |= CO_AEAD_TAG_AT_THE_END;
+                options->imported_protocol_flags |= CO_EPOCH_DATA_KEY_FORMAT;
             }
             else
             {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index de44eb2..a7cd3bf 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -689,9 +689,9 @@
         buf_printf(&proto_flags, " dyn-tls-crypt");
     }
 
-    if (o->imported_protocol_flags & CO_AEAD_TAG_AT_THE_END)
+    if (o->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT)
     {
-        buf_printf(&proto_flags, " aead-tag-end");
+        buf_printf(&proto_flags, " aead-epoch");
     }
 
     if (buf_len(&proto_flags) > 0)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 3561c41..c32cb6c 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -108,6 +108,9 @@
 /** Support to dynamic tls-crypt (renegotiation with TLS-EKM derived tls-crypt key) */
 #define IV_PROTO_DYN_TLS_CRYPT   (1<<9)
 
+/** Support the extended packet id and epoch format for data channel packets */
+#define IV_PROTO_DATA_EPOCH      (1<<10)
+
 /** Supports the --dns option after all the incompatible changes */
 #define IV_PROTO_DNS_OPTION_V2   (1<<11)
 
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index caacd9e..845ca56 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -404,7 +404,7 @@
 run_data_channel_with_cipher_end(const char *cipher)
 {
     struct crypto_options co = init_crypto_options(cipher, "none");
-    co.flags |= CO_AEAD_TAG_AT_THE_END;
+    co.flags |= CO_EPOCH_DATA_KEY_FORMAT;
     do_data_channel_round_trip(&co);
     uninit_crypto_options(&co);
 }

