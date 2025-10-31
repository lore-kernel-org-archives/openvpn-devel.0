From: Gert Doering <gert@...1296...>
Date: Fri, 31 Oct 2025 11:08:04 +0100
Message-ID: <20251031100819.24855-1-gert@...1296...>
In-Reply-To: <gerrit.1761580588000.Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c@...2715...>
References: <gerrit.1761580588000.Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Zeroize tls-crypt-v2 client keys
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

From: Max Fillinger <max@...2606...>

Joshua Rogers sent in a bug report generated with ZeroPath that the
tls-crypt-v2 client key is loaded before running the verify script. If
the verify script fails, the key is not zeroized.

While investigating this report, I found that free_tls_pre_decrypt_state
never zeroizes tls_wrap_tmp.original_wrap_keydata. So also when the
check is successful, key data will remain in memory when it is no longer
needed.

This commit moves the tls-crypt-v2-verify check before loading the key.
If it fails, original_wrap_keydata is zeroized. Also, in
free_tls_pre_decrypt_state, if a key has been loaded,
original_wrap_keydata is zeroized.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: Zeropath

Change-Id: Icfcbf8ee20c1c0016eb98b570f24b9325b157c5c
Signed-off-by: Max Fillinger <max@...2606...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1315
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1315
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 825719c..d7f7ac3 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -280,6 +280,7 @@
     if (state->tls_wrap_tmp.cleanup_key_ctx)
     {
         free_key_ctx_bi(&state->tls_wrap_tmp.opt.key_ctx_bi);
+        secure_memzero(&state->tls_wrap_tmp.original_wrap_keydata, sizeof(state->tls_wrap_tmp.original_wrap_keydata));
     }
 }
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 51b4eb3..a808de3 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -642,6 +642,12 @@
         return false;
     }
 
+    if (opt && opt->tls_crypt_v2_verify_script && !tls_crypt_v2_verify_metadata(ctx, opt))
+    {
+        secure_memzero(&ctx->original_wrap_keydata, sizeof(ctx->original_wrap_keydata));
+        return false;
+    }
+
     /* Load the decrypted key */
     ctx->mode = TLS_WRAP_CRYPT;
     ctx->cleanup_key_ctx = true;
@@ -652,11 +658,6 @@
     /* Remove client key from buffer so tls-crypt code can unwrap message */
     ASSERT(buf_inc_len(buf, -(BLEN(&wrapped_client_key))));
 
-    if (opt && opt->tls_crypt_v2_verify_script)
-    {
-        return tls_crypt_v2_verify_metadata(ctx, opt);
-    }
-
     return true;
 }
 

