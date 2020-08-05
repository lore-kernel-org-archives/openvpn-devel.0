From: Vladislav Grishenko <themiron@...2010...>
Date: Wed,  5 Aug 2020 15:23:33 +0500
Message-Id: <20200805102333.3109-1-themiron@...2010...>
In-Reply-To: <CAGyAFMXOcFeXHjqN=nkYvgPAeoor7nQiis7Oe+MncbU2XTm7QQ@...278...>
References: <CAGyAFMXOcFeXHjqN=nkYvgPAeoor7nQiis7Oe+MncbU2XTm7QQ@...278...>
Subject: [Openvpn-devel] [PATCH v2] Log serial number of revoked certificate
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

As it appears commit 767e4c56becbfeea525e4695a810593f373883cd "Log
serial number of revoked certificate" hasn't survive refactoring
of CRL handling.

In most of situations admin of OpenVPN server needs to know which
particular certificate is used by client.
In the case when certificate is valid, environment variable can be
used for that but once it is revoked, no user scripts are invoked
so there is no way to get serial number, only subject is logged.

Let's log certificate serial in case it is revoked and additionally
log certificate depth & subject in crl-verify "dir" mode for better
consistency with crl file (non-dir) mode.

v2: log if serial is not availble, require it in crl-verify dir mode

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/ssl_verify.c         | 14 +++++++++++---
 src/openvpn/ssl_verify_mbedtls.c |  5 +++--
 src/openvpn/ssl_verify_openssl.c |  5 +++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 844bc57d..97ccb93b 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -599,7 +599,8 @@ cleanup:
  * check peer cert against CRL directory
  */
 static result_t
-verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
+verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert,
+                     const char *subject, int cert_depth)
 {
     result_t ret = FAILURE;
     char fn[256];
@@ -607,6 +608,12 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
     struct gc_arena gc = gc_new();
 
     char *serial = backend_x509_get_serial(cert, &gc);
+    if (!serial)
+    {
+        msg(D_HANDSHAKE, "VERIFY CRL: depth=%d, %s, serial number is not available",
+            cert_depth, subject);
+        goto cleanup;
+    }
 
     if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, OS_SPECIFIC_DIRSEP, serial))
     {
@@ -616,7 +623,8 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
     fd = platform_open(fn, O_RDONLY, 0);
     if (fd >= 0)
     {
-        msg(D_HANDSHAKE, "VERIFY CRL: certificate serial number %s is revoked", serial);
+        msg(D_HANDSHAKE, "VERIFY CRL: depth=%d, %s, serial=%s is revoked",
+            cert_depth, subject, serial);
         goto cleanup;
     }
 
@@ -758,7 +766,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     {
         if (opt->ssl_flags & SSLF_CRL_VERIFY_DIR)
         {
-            if (SUCCESS != verify_check_crl_dir(opt->crl_file, cert))
+            if (SUCCESS != verify_check_crl_dir(opt->crl_file, cert, subject, cert_depth))
             {
                 goto cleanup;
             }
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index fd31bbbd..93891038 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -68,6 +68,7 @@ verify_callback(void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
         int ret = 0;
         char errstr[512] = { 0 };
         char *subject = x509_get_subject(cert, &gc);
+        char *serial = backend_x509_get_serial(cert, &gc);
 
         ret = mbedtls_x509_crt_verify_info(errstr, sizeof(errstr)-1, "", *flags);
         if (ret <= 0 && !openvpn_snprintf(errstr, sizeof(errstr),
@@ -82,8 +83,8 @@ verify_callback(void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
 
         if (subject)
         {
-            msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, subject=%s: %s",
-                cert_depth, subject, errstr);
+            msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, subject=%s, serial=%s: %s",
+                cert_depth, subject, serial ? serial : "<not available>", errstr);
         }
         else
         {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index ff14db23..454efeec 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -71,6 +71,7 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
     {
         /* get the X509 name */
         char *subject = x509_get_subject(current_cert, &gc);
+        char *serial = backend_x509_get_serial(current_cert, &gc);
 
         if (!subject)
         {
@@ -89,10 +90,10 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
         }
 
         /* Remote site specified a certificate, but it's not correct */
-        msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
+        msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s, serial=%s",
             X509_STORE_CTX_get_error_depth(ctx),
             X509_verify_cert_error_string(X509_STORE_CTX_get_error(ctx)),
-            subject);
+            subject, serial ? serial : "<not available>");
 
         ERR_clear_error();
 
-- 
2.17.1


