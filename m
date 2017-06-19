From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 19 Jun 2017 11:28:38 +0200
Message-ID: <1497864520-12219-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
References: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] Fix remote-triggerable memory leaks
 (CVE-2017-7521)
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

Several of our OpenSSL-specific certificate-parsing code paths did not
always clear all allocated memory.  Since a client can cause a few bytes
of memory to be leaked for each connection attempt, a client can cause a
server to run out of memory and thereby kill the server.  That makes this
a (quite inefficient) DoS attack.

When using the --x509-alt-username option on openssl builds with an
extension (argument prefixed with "ext:", e.g. "ext:subjectAltName"), the
code would not free all allocated memory.  Fix this by using the proper
free function.

If ASN1_STRING_to_UTF8() returns 0, it didn't fail and *did* allocate
memory.  So also free the returned buffer if it returns 0.

These issues were found, analysed and reported to the OpenVPN team by Guido
Vranken.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst                      | 5 +++++
 src/openvpn/ssl_verify_openssl.c | 9 ++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index f1aed2d..89cfae8 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -313,6 +313,11 @@ Security
   --x509-track option and the client has a correct, signed and unrevoked
   certificate that contains an embedded NUL in the certificate subject.
   Discovered and reported to the OpenVPN security team by Guido Vranken.
+- CVE-2017-7521: Fix post-authentication remote-triggerable memory leaks
+  A client could cause a server to leak a few bytes each time it connects to the
+  server.  That can eventuall cause the server to run out of memory, and thereby
+  causing the server process to terminate. Discovered and reported to the
+  OpenVPN security team by Guido Vranken.  (OpenSSL builds only.)
 
 User-visible Changes
 --------------------
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 31c1638..7c1a481 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -163,7 +163,7 @@ extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
                     break;
             }
         }
-        sk_GENERAL_NAME_free(extensions);
+        GENERAL_NAMES_free(extensions);
     }
     return retval;
 }
@@ -225,8 +225,7 @@ extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out,
     {
         return FAILURE;
     }
-    tmp = ASN1_STRING_to_UTF8(&buf, asn1);
-    if (tmp <= 0)
+    if (ASN1_STRING_to_UTF8(&buf, asn1) < 0)
     {
         return FAILURE;
     }
@@ -466,7 +465,7 @@ x509_setenv_track(const struct x509_track *xt, struct env_set *es, const int dep
                         {
                             ASN1_STRING *val = X509_NAME_ENTRY_get_data(ent);
                             unsigned char *buf = NULL;
-                            if (ASN1_STRING_to_UTF8(&buf, val) > 0)
+                            if (ASN1_STRING_to_UTF8(&buf, val) >= 0)
                             {
                                 do_setenv_x509(es, xt->name, (char *)buf, depth);
                                 OPENSSL_free(buf);
@@ -553,7 +552,7 @@ x509_setenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *peer_cert)
         {
             continue;
         }
-        if (ASN1_STRING_to_UTF8(&buf, val) <= 0)
+        if (ASN1_STRING_to_UTF8(&buf, val) < 0)
         {
             continue;
         }
-- 
2.7.4



