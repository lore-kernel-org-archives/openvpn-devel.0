From: Klemens Nanni <klemens@...2010...>
Date: Tue, 22 Apr 2025 00:44:34 +0300
Message-ID: <20250421214434.83431-1-klemens@...2010...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [SPAM] [PATCH 1/1] Accept "issuer" in
 `x509-username-field` for the peer certificate's issuer name
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
Cc: Klemens Nanni <klemens@...2010...>, Klemens Nanni <kn@...2273...>

This allows for accepting clients based on their certificate authority:
	x509-username-field issuer CN
	verify-x509-name    ...CA=ExampleCA_ match-prefix

`tls-verify` or `plugin` can do the equivalent, but require additional code
execution and always incur overhead or may not be an option when running with
reduced privileges, e.g. `chroot`.

Tested against
- FreeBSD 13,          OpenSSL 1.1.1t, OpenVPN 2.5.6
- OpenBSD 7.7-stable,  LibreSSL 4.1.0, OpenVPN 2.6.4
- OpenBSD 7.7-current, LibreSSL 4.1.0, OpenVPN f7aedca7

Signed-off-by: Klemens Nanni <kn@...2273...>
---
 doc/man-sections/tls-options.rst | 18 ++++++++++++++----
 src/openvpn/ssl_verify_openssl.c | 26 ++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 0638d095..f60b711c 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -77,9 +77,8 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
 
   CAs in the capath directory are expected to be named <hash>.<n>. CRLs
   are expected to be named <hash>.r<n>. See the ``-CApath`` option of
-  ``openssl verify``, and the ``-hash`` option of ``openssl x509``,
-  ``openssl crl`` and ``X509_LOOKUP_hash_dir()``\(3)
-  for more information.
+  ``openssl verify``, the ``-hash`` option of ``openssl x509``, ``openssl crl``
+  and ``X509_LOOKUP_hash_dir(3)`` for more information.
 
   Similar to the ``--crl-verify`` option, CRLs are not mandatory -
   OpenVPN will log the usual warning in the logs if the relevant CRL is
@@ -664,7 +663,7 @@ If the option is inlined, ``algo`` is always :code:`SHA256`.
   Valid syntax:
   ::
 
-     verify-x509 name type
+     verify-x509-name type
 
   Which X.509 name is compared to ``name`` depends on the setting of type.
   ``type`` can be :code:`subject` to match the complete subject DN
@@ -768,3 +767,14 @@ If the option is inlined, ``algo`` is always :code:`SHA256`.
   Non-compliant symbols are being replaced with the :code:`_` symbol, same as
   the field separator, so concatenating multiple fields with such or :code:`_`
   symbols can potentially lead to username collisions.
+
+  The special name :code:`issuer` will yield the certificate's issuer name in
+  *sep_comma_plus_space,sname,utf8,esc_ctrl* format, see the ``-issuer`` option
+  of ``openssl x509`` and ``openssl-namedisplay-options(1)`` for more information:
+  ::
+
+     x509-username-field issuer CN
+     verify-x509-name    'C=DE, ..., CN=ExampleCA_' match-prefix
+
+  This example prepends the default username with the certificate authority to
+  verify it without the need of ``--tls-verify`` or ``--plugin``.
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index ce1e7da1..baebe63c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -283,6 +283,32 @@ backend_x509_get_username(char *common_name, int cn_len,
         snprintf(common_name, cn_len, "0x%s", serial);
         gc_free(&gc);
     }
+    else if (strcmp("ISSUER", x509_username_field) == 0)
+    {
+        BIO *issuer_bio = BIO_new(BIO_s_mem());
+        BUF_MEM *issuer_mem;
+
+        if (!issuer_bio)
+        {
+            return FAILURE;
+        }
+
+        /* match x509_get_subject() format seen in "VERIFY ..." output */
+        X509_NAME_print_ex(issuer_bio, X509_get_issuer_name(peer_cert),
+                           0, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN
+                           | ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);
+
+        if (BIO_eof(issuer_bio)
+            || BIO_get_mem_ptr(issuer_bio, &issuer_mem) <= 0
+            || cn_len < issuer_mem->length)
+        {
+            BIO_free(issuer_bio);
+            return FAILURE;
+        }
+
+        strncpynt(common_name, issuer_mem->data, cn_len);
+        BIO_free(issuer_bio);
+    }
     else
 #endif /* ifdef ENABLE_X509ALTUSERNAME */
     if (FAILURE == extract_x509_field_ssl(X509_get_subject_name(peer_cert),
-- 
2.49.0


