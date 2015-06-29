Message-ID: <55910777.10206@...1147...>
Date: Mon, 29 Jun 2015 10:53:11 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] verify-client-cert patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

From: Jan Just Keijser <janjust@...1147...>
Date: Mon, 29 Jun 2015 10:48:12 +0200
Subject: [PATCH] Author: Jan Just Keijser <janjust@...1147...>

Add extended client certificate verification support.

Replace --client-cert-not-required with a more flexible option,
that allows for no, optional or mandatory client certificate
verification.

Signed-off-by: Jan Just Keijser <janjust@...1147...>
---
  doc/openvpn.8             |   49 
+++++++++++++++++++++++++++++++++++++++++++-
  src/openvpn/options.c     |   28 +++++++++++++++++++++++-
  src/openvpn/ssl_common.h  |    5 ++-
  src/openvpn/ssl_openssl.c |   15 +++++++++----
  4 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3eb2493..6ff2b4e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3549,18 +3549,63 @@ to empty strings ("").  The authentication 
module/script MUST have logic
  to detect this condition and respond accordingly.
  .\"*********************************************************
  .TP
-.B \-\-client\-cert\-not\-required
+.B \-\-client\-cert\-not\-required (DEPRECATED)
  Don't require client certificate, client will authenticate
  using username/password only.  Be aware that using this directive
  is less secure than requiring certificates from all clients.

+
+.B Please note:
+This option is now deprecated and will be removed in OpenVPN v2.5.
+It is replaced by
+.B \-\-verify\-client\-cert
+which allows for more flexibility. The option
+.B \-\-verify\-client\-cert none
+is functionally equivalent to
+.B \-\-client\-cert\-not\-required
+.
+
+.\"*********************************************************
+.TP
+.B \-\-verify\-client\-cert none|optional|require
+Specify whether the client is required to supply a valid certificate.
+
+Possible options are
+
+.B none
+: a client certificate is not required. the client need to authenticate
+using username/password only.  Be aware that using this directive
+is less secure than requiring certificates from all clients.
+
  If you use this directive, the
  entire responsibility of authentication will rest on your
  .B \-\-auth\-user\-pass\-verify
  script, so keep in mind that bugs in your script
  could potentially compromise the security of your VPN.

-If you don't use this directive, but you also specify an
+.B \-\-verify\-client\-cert none
+is functionally equivalent to
+.B \-\-client\-cert\-not\-required.
+
+.B optional
+: a client may present a certificate but it is not required to do so.
+When using this directive, you should also use a
+.B \-\-auth\-user\-pass\-verify
+script to ensure that clients are authenticated using a
+certificate, a username and password, or possibly even both.
+
+Again, the entire responsibility of authentication will rest on your
+.B \-\-auth\-user\-pass\-verify
+script, so keep in mind that bugs in your script
+could potentially compromise the security of your VPN.
+
+.B require
+: this is the default option. A client is required to present a
+certificate, otherwise VPN access is refused.
+
+If you don't use this directive (or use
+.B \-\-verify\-client\-cert require
+) but you also specify an
  .B \-\-auth\-user\-pass\-verify
  script, then OpenVPN will perform double authentication.  The
  client certificate verification AND the
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 74276d4..65e4658 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -437,6 +437,9 @@ static const char usage_message[] =
    "                  Only valid in a client-specific config file.\n"
    "--client-cert-not-required : Don't require client certificate, 
client\n"
    "                  will authenticate using username/password.\n"
+  "--verify-client-cert [none|optional|require] : perform no, optional 
or\n"
+  "                  mandatory client certificate verification.\n"
+  "                  Default is to require the client to supply a 
certificate.\n"
    "--username-as-common-name  : For auth-user-pass authentication, use\n"
    "                  the authenticated username as the common name,\n"
    "                  rather than the common name from the client cert.\n"
@@ -2091,8 +2094,8 @@ options_postprocess_verify_ce (const struct 
options *options, const struct conne
      msg (M_USAGE, "--duplicate-cn requires --mode server");
        if (options->cf_max || options->cf_per)
      msg (M_USAGE, "--connect-freq requires --mode server");
-      if (options->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
-    msg (M_USAGE, "--client-cert-not-required requires --mode server");
+      if (options->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED || 
options->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
+    msg (M_USAGE, "--client-cert-not-required and --verify-client-cert 
require --mode server");
        if (options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
      msg (M_USAGE, "--username-as-common-name requires --mode server");
        if (options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL)
@@ -5658,6 +5661,27 @@ add_option (struct options *options,
      {
        VERIFY_PERMISSION (OPT_P_GENERAL);
        options->ssl_flags |= SSLF_CLIENT_CERT_NOT_REQUIRED;
+      msg (M_WARN, "DEPRECATED OPTION: --client-cert-not-required, use 
--verify-client-cert instead");
+    }
+  else if (streq (p[0], "verify-client-cert") && !p[2])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+
+      /* Reset any existing flags */
+      options->ssl_flags &= ~SSLF_CLIENT_CERT_OPTIONAL;
+      options->ssl_flags &= ~SSLF_CLIENT_CERT_NOT_REQUIRED;
+      if (p[1])
+    {
+      if (streq (p[1], "none"))
+          options->ssl_flags |= SSLF_CLIENT_CERT_NOT_REQUIRED;
+      else if (streq (p[1], "optional"))
+          options->ssl_flags |= SSLF_CLIENT_CERT_OPTIONAL;
+      else if (!streq (p[1], "require"))
+        {
+          msg (msglevel, "parameter to --verify-client-cert must be 
'none', 'optional' or 'require'");
+          goto err;
+        }
+    }
      }
    else if (streq (p[0], "username-as-common-name") && !p[1])
      {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 95cd2f7..8fab21f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -293,8 +293,9 @@ struct tls_options

    /* configuration file SSL-related boolean and low-permutation options */
  # define SSLF_CLIENT_CERT_NOT_REQUIRED (1<<0)
-# define SSLF_USERNAME_AS_COMMON_NAME  (1<<1)
-# define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<2)
+# define SSLF_CLIENT_CERT_OPTIONAL     (1<<1)
+# define SSLF_USERNAME_AS_COMMON_NAME  (1<<2)
+# define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<3)
  # define SSLF_OPT_VERIFY               (1<<4)
  # define SSLF_CRL_VERIFY_DIR           (1<<5)
  # define SSLF_TLS_VERSION_MIN_SHIFT    6
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index df9fa87..6e29af4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -180,6 +180,9 @@ void
  tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
  {
    ASSERT(NULL != ctx);
+
+  /* default certificate verification flags */
+  int flags = SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT;

    /* process SSL options including minimum TLS version we will accept 
from peer */
    {
@@ -221,13 +224,15 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, 
unsigned int ssl_flags)
    if (ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
      {
        msg (M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
-      "--client-cert-not-required may accept clients which do not present "
-      "a certificate");
+      "--client-cert-not-required and --verify-client-cert none "
+      "may accept clients which do not present a certificate");
+
+      flags = 0;
      }
-  else
+  else if (ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
+    flags = SSL_VERIFY_PEER;
  #endif
-  SSL_CTX_set_verify (ctx->ctx, SSL_VERIFY_PEER | 
SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
-              verify_callback);
+  SSL_CTX_set_verify (ctx->ctx, flags, verify_callback);

    SSL_CTX_set_info_callback (ctx->ctx, info_callback);
  }
-- 
1.7.1


