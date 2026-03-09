From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  9 Mar 2026 14:32:36 +0100
Message-ID: <20260309133236.29732-1-frank@...2641...>
In-Reply-To: <gerrit.1769789455000.I23cc00aee47aef007ab2e7d50b52c6de299505db@...2715...>
References: <gerrit.1769789455000.I23cc00aee47aef007ab2e7d50b52c6de299505db@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] ssl_verify_openssl: Clean up
 extract_x509_extension
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

* Avoid sign-compare warning when comparing string
  lengths
* Use the nicer alias rfc822Name instead of the general ia5
  from the GENERAL_NAME union.
* Use the official ASN1_STRING_length API instead of accessing
  the struct directly.
* C11 changes

Change-Id: I23cc00aee47aef007ab2e7d50b52c6de299505db
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1507
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1507
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 58f665c..46401cd 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -118,16 +118,10 @@
     return nid == NID_subject_alt_name || nid == NID_issuer_alt_name;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static bool
 extract_x509_extension(X509 *cert, char *fieldname, char *out, size_t size)
 {
     bool retval = false;
-    char *buf = 0;
 
     if (!x509_username_field_ext_supported(fieldname))
     {
@@ -139,29 +133,28 @@
     GENERAL_NAMES *extensions = X509_get_ext_d2i(cert, nid, NULL, NULL);
     if (extensions)
     {
-        int numalts;
-        int i;
         /* get amount of alternatives,
          * RFC2459 claims there MUST be at least
          * one, but we don't depend on it...
          */
 
-        numalts = sk_GENERAL_NAME_num(extensions);
+        int numalts = sk_GENERAL_NAME_num(extensions);
 
         /* loop through all alternatives */
-        for (i = 0; i < numalts; i++)
+        for (int i = 0; i < numalts; i++)
         {
             /* get a handle to alternative name number i */
             const GENERAL_NAME *name = sk_GENERAL_NAME_value(extensions, i);
+            char *buf = NULL;
 
             switch (name->type)
             {
                 case GEN_EMAIL:
-                    if (ASN1_STRING_to_UTF8((unsigned char **)&buf, name->d.ia5) < 0)
+                    if (ASN1_STRING_to_UTF8((unsigned char **)&buf, name->d.rfc822Name) < 0)
                     {
                         continue;
                     }
-                    if (strlen(buf) != name->d.ia5->length)
+                    if ((ssize_t)strlen(buf) != ASN1_STRING_length(name->d.rfc822Name))
                     {
                         msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero");
                         OPENSSL_free(buf);
@@ -175,7 +168,7 @@
                     break;
 
                 default:
-                    msg(D_TLS_DEBUG, "%s: ignoring general name field type %i", __func__,
+                    msg(D_TLS_DEBUG, "%s: ignoring general name field type %d", __func__,
                         name->type);
                     break;
             }
@@ -185,10 +178,6 @@
     return retval;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Extract a field from an X509 subject name.
  *

