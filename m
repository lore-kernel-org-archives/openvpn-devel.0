From: David Sommerseth <davids@...515...>
Date: Mon, 20 Jul 2020 13:18:40 +0200
Message-Id: <20200720111840.7527-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove --client-cert-not-required
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

This removes support for the --client-cert-not-required option.  To
avoid starting a server with this option just ignored, which would make
it impossible for existing clients to connect it will exit with
instructions to replace this option with --verify-client-cert none.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/options.c                | 9 +++------
 src/plugins/auth-pam/README.auth-pam | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a81336f2..ae7b8586 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -446,8 +446,6 @@ static const char usage_message[] =
     "                  Only valid in a client-specific config file.\n"
     "--disable       : Client is disabled.\n"
     "                  Only valid in a client-specific config file.\n"
-    "--client-cert-not-required : (DEPRECATED) Don't require client certificate, client\n"
-    "                  will authenticate using username/password.\n"
     "--verify-client-cert [none|optional|require] : perform no, optional or\n"
     "                  mandatory client certificate verification.\n"
     "                  Default is to require the client to supply a certificate.\n"
@@ -2479,7 +2477,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         }
         if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
         {
-            msg(M_USAGE, "--client-cert-not-required and --verify-client-cert require --mode server");
+            msg(M_USAGE, "--verify-client-cert require --mode server");
         }
         if (options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
         {
@@ -2552,7 +2550,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
     if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
     {
         msg(M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
-            "--verify-client-cert none|optional (or --client-cert-not-required) "
+            "--verify-client-cert none|optional "
             "may accept clients which do not present a certificate");
     }
 
@@ -6953,8 +6951,7 @@ add_option(struct options *options,
     else if (streq(p[0], "client-cert-not-required") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->ssl_flags |= SSLF_CLIENT_CERT_NOT_REQUIRED;
-        msg(M_WARN, "DEPRECATED OPTION: --client-cert-not-required, use --verify-client-cert instead");
+        msg(M_FATAL, "REMOVED OPTION: --client-cert-not-required, use '--verify-client-cert none' instead");
     }
     else if (streq(p[0], "verify-client-cert") && !p[2])
     {
diff --git a/src/plugins/auth-pam/README.auth-pam b/src/plugins/auth-pam/README.auth-pam
index 64b3ace7..e3ca027e 100644
--- a/src/plugins/auth-pam/README.auth-pam
+++ b/src/plugins/auth-pam/README.auth-pam
@@ -60,7 +60,7 @@ is to be answered with the constant value "mydomain.com":
 The following OpenVPN directives can also influence
 the operation of this plugin:
 
-  client-cert-not-required
+  verify-client-cert none
   username-as-common-name
   static-challenge
 
-- 
2.26.0


