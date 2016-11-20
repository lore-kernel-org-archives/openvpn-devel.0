From: Steffan Karger <steffan@...1856...>
Date: Sun, 20 Nov 2016 15:39:23 +0100
Message-Id: <1479652763-12345-1-git-send-email-steffan@...1856...>
In-Reply-To: <1478255441-21670-1-git-send-email-gert@...1296...>
References: <1478255441-21670-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Poor man's NCP for non-NCP clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Allows non-NCP clients (<= 2.3, or 2.4+ with --ncp-disable) to specify a
--cipher that is different from the one in the server config, as long as
the new cipher value is allowed (i.e. in --ncp-ciphers at the server side).

This patch was inspired by Gert's "Poor man's NCP for 2.3 clients" patch,
but takes a different approach to avoid the need for server-side scripts
or client-side 'setenv UV_*' tricks.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 32 ++++++++++++++++++++++++++++++++
 src/openvpn/options.h | 14 ++++++++++++++
 src/openvpn/ssl.c     | 24 +++++++++++++++++++++---
 src/openvpn/ssl.h     |  7 +++++++
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a74de24..94cd3d4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3431,6 +3431,38 @@ options_string_version (const char* s, struct gc_arena *gc)
   return BSTR (&out);
 }
 
+char *
+options_string_extract_option (const char *options_string,
+    size_t options_string_len, const char *opt_name, struct gc_arena *gc)
+{
+  char *ret = NULL;
+
+  const char *p = options_string;
+  while (p)
+    {
+      if (p == strstr(p, opt_name))
+	{
+	  const size_t opt_name_len = strlen(opt_name);
+	  if (strlen(p) > opt_name_len+1 && p[opt_name_len] == ' ')
+	    {
+	      /* option found, extract value */
+	      const char *start = &p[opt_name_len+1];
+	      const char *end = strchr (p, ',');
+	      size_t val_len = end ? end - start : strlen (start);
+	      ret = gc_malloc (val_len+1, true, gc);
+	      memcpy (ret, start, val_len);
+	      break;
+	    }
+	}
+      p = strchr (p, ',');
+      if (p)
+	{
+	  p++; /* skip delimiter */
+	}
+    }
+  return ret;
+}
+
 #endif /* ENABLE_OCC */
 
 static void
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a028556..a66fd84 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -724,6 +724,20 @@ void options_warning_safe (char *actual, const char *expected, size_t actual_n);
 bool options_cmp_equal (char *actual, const char *expected);
 void options_warning (char *actual, const char *expected);
 
+/**
+ * Given an OpenVPN options string, extract the value of an option.
+ *
+ * @param options_string	Zero-terminated, comma-separated options string
+ * @param opt_name		The name of the option to extract
+ * @param gc			The gc to allocate the return value
+ *
+ * @return gc-allocated value of option with name opt_name if option was found,
+ *         or NULL otherwise.
+ */
+char *options_string_extract_option (const char *options_string,
+    size_t options_string_len, const char *opt_name, struct gc_arena *gc);
+
+
 #endif
 
 void options_postprocess (struct options *options);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1ae1547..4080ffb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1723,8 +1723,8 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len) {
     }
 }
 
-static bool
-item_in_list(const char *item, const char *list)
+bool
+tls_item_in_cipher_list(const char *item, const char *list)
 {
   char *tmp_ciphers = string_alloc (list, NULL);
   char *tmp_ciphers_orig = tmp_ciphers;
@@ -1752,7 +1752,7 @@ tls_session_update_crypto_params(struct tls_session *session,
 
   if (!session->opt->server &&
       0 != strcmp(options->ciphername, session->opt->config_ciphername) &&
-      !item_in_list(options->ciphername, options->ncp_ciphers))
+      !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
     {
       msg (D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s or %s",
 	  options->ciphername, session->opt->config_ciphername,
@@ -2318,6 +2318,24 @@ key_method_2_read (struct buffer *buf, struct context *c, struct tls_session *se
       /* Peer does not support NCP */
       session->opt->ncp_enabled = false;
     }
+
+  /* "Poor man's NCP": Use client-cipher if it is an allowed (NCP) cipher.
+   * Allows non-NCP client to upgrade their cipher individually. */
+  char *options_string_remote_cipher = options_string_extract_option (options,
+      TLS_OPTIONS_LEN, "cipher", &gc);
+  if (!session->opt->ncp_enabled && options_string_remote_cipher &&
+      0 != strcmp(c->options.ciphername, options_string_remote_cipher))
+    {
+      if (tls_item_in_cipher_list(options_string_remote_cipher,
+	  c->options.ncp_ciphers))
+	{
+	  c->options.ciphername = string_alloc(options_string_remote_cipher,
+	      &c->options.gc);
+	  session->opt->ncp_enabled = true;
+	  msg (D_TLS_DEBUG_LOW, "Using client cipher '%s'", c->options.ciphername);
+	}
+    }
+
 #endif
 
   if (tls_session_user_pass_enabled(session))
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 990d8da..8f588c6 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -508,6 +508,13 @@ int tls_peer_info_ncp_ver(const char *peer_info);
  */
 bool tls_check_ncp_cipher_list(const char *list);
 
+/**
+ * Return true iff item is present in the colon-separated zero-terminated
+ * cipher list.
+ */
+bool tls_item_in_cipher_list(const char *item, const char *list);
+
+
 /*
  * inline functions
  */
-- 
2.7.4


