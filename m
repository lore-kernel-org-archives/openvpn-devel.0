From: Gert Doering <gert@...1296...>
Date: Wed, 19 Nov 2025 15:01:43 +0100
Message-ID: <20251119140149.31867-1-gert@...1296...>
In-Reply-To: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
References: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Add option to check tls-crypt-v2 key
 timestamps
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

This commit adds the option --tls-crypt-v2-max-age n. When a client key
is older than n days or has no timestamp, the server rejects it.

Based on work by Rein van Baaren for Sentyron.

Co-authored-by: Rein van Baaren <revaban04@...2783...>
Change-Id: I0579d18c784e2ac16973d5553992c28f281a0900
Signed-off-by: Max Fillinger <max@...2606...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1304
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1304
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index db107e6..63cb32f 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -568,6 +568,10 @@
   The command can reject the connection by exiting with a non-zero exit
   code.
 
+--tls-crypt-v2-max-age n
+  Reject tls-crypt-v2 client keys that are older than n days or have
+  no timestamp.
+
 --tls-exit
   Exit on TLS negotiation failure. This option can be useful when you only
   want to make one attempt at connecting, e.g. in a test or monitoring script.
diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
index 7dcd041..c2e9deb 100644
--- a/doc/tls-crypt-v2.txt
+++ b/doc/tls-crypt-v2.txt
@@ -139,7 +139,10 @@
    The message is dropped and no error response is sent when either 3.1, 3.2 or
    3.3 fails (DoS protection).
 
-4. Server optionally checks metadata using a --tls-crypt-v2-verify script
+4. The server optionally checks if the client key contains a timestamp that is
+   below a maximum age configured with the --tls-crypt-v2-max-age option.
+
+5. Server optionally checks metadata using a --tls-crypt-v2-verify script
 
    This allows early abort of connection, *before* we expose any of the
    notoriously dangerous TLS, X.509 and ASN.1 parsers and thereby reduces the
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8d95d5c..fc079e1 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3418,6 +3418,7 @@
         {
             to.tls_wrap.tls_crypt_v2_server_key = c->c1.ks.tls_crypt_v2_server_key;
             to.tls_crypt_v2_verify_script = c->options.tls_crypt_v2_verify_script;
+            to.tls_crypt_v2_max_age = c->options.tls_crypt_v2_max_age;
             if (options->ce.tls_crypt_v2_force_cookie)
             {
                 to.tls_wrap.opt.flags |= CO_FORCE_TLSCRYPTV2_COOKIE;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ecf9374..e1a9a61 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -650,6 +650,8 @@
     "                  fresh tls-crypt-v2 server key, and store to keyfile\n"
     "--tls-crypt-v2-verify cmd : Run command cmd to verify the metadata of the\n"
     "                  client-supplied tls-crypt-v2 client key\n"
+    "--tls-crypt-v2-max-age n : Only accept tls-crypt-v2 client keys that have a\n"
+    "                  timestamp which is at most n days old.\n"
     "--askpass [file]: Get PEM password from controlling tty before we daemonize.\n"
     "--auth-nocache  : Don't cache --askpass or --auth-user-pass passwords.\n"
     "--crl-verify crl ['dir']: Check peer certificate against a CRL.\n"
@@ -9084,6 +9086,14 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->tls_crypt_v2_verify_script = p[1];
     }
+    else if (streq(p[0], "tls-crypt-v2-max-age") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!atoi_constrained(p[1], &options->tls_crypt_v2_max_age, "tls-crypt-v2-max-age", 1, INT_MAX, msglevel))
+        {
+            goto err;
+        }
+    }
     else if (streq(p[0], "x509-track") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9d2ff9f..42db9ca 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -678,6 +678,8 @@
 
     const char *tls_crypt_v2_verify_script;
 
+    int tls_crypt_v2_max_age;
+
     /* Allow only one session */
     bool single_session;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index de89d30..0402a6a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -383,6 +383,7 @@
 
     bool tls_crypt_v2;
     const char *tls_crypt_v2_verify_script;
+    int tls_crypt_v2_max_age;
 
     /** TLS handshake wrapping state */
     struct tls_wrap_ctx tls_wrap;
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index a808de3..7d78d8e 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -29,6 +29,7 @@
 #include "argv.h"
 #include "base64.h"
 #include "crypto.h"
+#include "integer.h"
 #include "platform.h"
 #include "run_command.h"
 #include "session_id.h"
@@ -528,6 +529,34 @@
 }
 
 static bool
+tls_crypt_v2_check_client_key_age(const struct tls_wrap_ctx *ctx, int max_days)
+{
+    if (ctx->tls_crypt_v2_metadata.len < 1 + sizeof(int64_t))
+    {
+        msg(M_WARN, "ERROR: Client key metadata is too small to contain a timestamp.");
+        return false;
+    }
+
+    const uint8_t *metadata = ctx->tls_crypt_v2_metadata.data;
+    if (*metadata != TLS_CRYPT_METADATA_TYPE_TIMESTAMP)
+    {
+        msg(M_WARN, "ERROR: Client key does not have a timestamp.");
+        return false;
+    }
+
+    int64_t timestamp;
+    memcpy(&timestamp, metadata + 1, sizeof(int64_t));
+    timestamp = (int64_t)ntohll((uint64_t)timestamp);
+    int64_t max_age_in_seconds = max_days * 24 * 60 * 60;
+    if (now - timestamp > max_age_in_seconds)
+    {
+        msg(M_WARN, "ERROR: Client key is too old.");
+        return false;
+    }
+    return true;
+}
+
+static bool
 tls_crypt_v2_verify_metadata(const struct tls_wrap_ctx *ctx, const struct tls_options *opt)
 {
     bool ret = false;
@@ -642,6 +671,12 @@
         return false;
     }
 
+    if (opt && opt->tls_crypt_v2_max_age > 0 && !tls_crypt_v2_check_client_key_age(ctx, opt->tls_crypt_v2_max_age))
+    {
+        secure_memzero(&ctx->original_wrap_keydata, sizeof(ctx->original_wrap_keydata));
+        return false;
+    }
+
     if (opt && opt->tls_crypt_v2_verify_script && !tls_crypt_v2_verify_metadata(ctx, opt))
     {
         secure_memzero(&ctx->original_wrap_keydata, sizeof(ctx->original_wrap_keydata));

