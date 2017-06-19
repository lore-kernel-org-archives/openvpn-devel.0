From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 19 Jun 2017 11:28:39 +0200
Message-ID: <1497864520-12219-5-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
References: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] Restrict --x509-alt-username extension
 types
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

The code never supported all extension types.  Make this explicit by only
allowing subjectAltName and issuerAltName (for which the current code does
work).

Using unsupported extension fields would most likely cause OpenVPN to crash
as soon as a client connects.  This does not have a real-world security
impact, as such a configuration would not be possible to use in practice.

This bug was discovered, analysed and reported to the OpenVPN team by
Guido Vranken.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst                      |  3 +++
 doc/openvpn.8                    |  2 ++
 src/openvpn/options.c            |  4 ++++
 src/openvpn/ssl_verify_backend.h |  8 ++++++++
 src/openvpn/ssl_verify_openssl.c | 19 ++++++++++++++++---
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 89cfae8..6fa1c0c 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -324,6 +324,9 @@ User-visible Changes
 - ``--verify-hash`` can now take an optional flag which changes the hashing
   algorithm. It can be either SHA1 or SHA256.  The default if not provided is
   SHA1 to preserve backwards compatibility with existing configurations.
+- Restrict the supported --x509-alt-username extension fields to subjectAltName
+  and issuerAltName.  Other extensions probably didn't work anyway, and would
+  cause OpenVPN to crash when a client connects.
 
 Bugfixes
 --------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3f183e6..20bdd91 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5307,6 +5307,8 @@ option will match against the chosen
 .B fieldname
 instead of the Common Name.
 
+Only the subjectAltName and issuerAltName X.509 extensions are supported.
+
 .B Please note:
 This option has a feature which will convert an all-lowercase
 .B fieldname
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 76a8550..505c5b2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8083,6 +8083,10 @@ add_option(struct options *options,
                     "configuration", p[1]);
             }
         }
+        else if (!x509_username_field_ext_supported(s+4))
+        {
+            msg(msglevel, "Unsupported x509-username-field extension: %s", s);
+        }
         options->x509_username_field = p[1];
     }
 #endif /* ENABLE_X509ALTUSERNAME */
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 978e54f..e8eaabe 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -124,6 +124,14 @@ struct buffer x509_get_sha256_fingerprint(openvpn_x509_cert_t *cert,
 result_t backend_x509_get_username(char *common_name, int cn_len,
                                    char *x509_username_field, openvpn_x509_cert_t *peer_cert);
 
+#ifdef ENABLE_X509ALTUSERNAME
+/**
+ * Return true iff the supplied extension field is supported by the
+ * --x509-username-field option.
+ */
+bool x509_username_field_ext_supported(const char *extname);
+#endif
+
 /*
  * Return the certificate's serial number in decimal string representation.
  *
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 7c1a481..08451f2 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -113,16 +113,29 @@ cleanup:
 }
 
 #ifdef ENABLE_X509ALTUSERNAME
+bool x509_username_field_ext_supported(const char *fieldname)
+{
+    int nid = OBJ_txt2nid(fieldname);
+    return nid == NID_subject_alt_name || nid == NID_issuer_alt_name;
+}
+
 static
 bool
 extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
 {
     bool retval = false;
     char *buf = 0;
-    GENERAL_NAMES *extensions;
-    int nid = OBJ_txt2nid(fieldname);
 
-    extensions = (GENERAL_NAMES *)X509_get_ext_d2i(cert, nid, NULL, NULL);
+    if (!x509_username_field_ext_supported(fieldname))
+    {
+        msg(D_TLS_ERRORS,
+            "ERROR: --x509-alt-username field 'ext:%s' not supported",
+            fieldname);
+        return false;
+    }
+
+    int nid = OBJ_txt2nid(fieldname);
+    GENERAL_NAMES *extensions = X509_get_ext_d2i(cert, nid, NULL, NULL);
     if (extensions)
     {
         int numalts;
-- 
2.7.4



