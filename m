From: Gert Doering <gert@...1296...>
Date: Thu, 27 Nov 2025 12:35:12 +0100
Message-ID: <20251127113517.1352-1-gert@...1296...>
In-Reply-To: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
References: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] extract_x509_field_ssl(): verify that
 X509_NAME is not NULL.
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

This seems to be unlikely to ever happen, but this check won't harm
- as a matter of coding convention, we do not ensure this inside
extract_x509_field_ssl(), but in the (single) caller.

While at it, fix pre-C99 local-variable indent block, and missing {}
block in else/#endif construction.

Reported-By: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1388
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1388
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 40d117b..6cb04ee 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -202,8 +202,8 @@
     X509_NAME_ENTRY *x509ne = NULL;
     ASN1_STRING *asn1 = NULL;
     unsigned char *buf = NULL;
-    ASN1_OBJECT *field_name_obj = OBJ_txt2obj(field_name, 0);
 
+    ASN1_OBJECT *field_name_obj = OBJ_txt2obj(field_name, 0);
     if (field_name_obj == NULL)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_name);
@@ -244,11 +244,9 @@
 
     strncpynt(out, (char *)buf, size);
 
-    {
-        const result_t ret = (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
-        OPENSSL_free(buf);
-        return ret;
-    }
+    const result_t ret = (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+    OPENSSL_free(buf);
+    return ret;
 }
 
 result_t
@@ -278,12 +276,21 @@
     }
     else
 #endif /* ifdef ENABLE_X509ALTUSERNAME */
+    {
+        X509_NAME *x509_subject_name = X509_get_subject_name(peer_cert);
+        if (x509_subject_name == NULL)
+        {
+            msg(D_TLS_ERRORS, "X509 subject name is NULL");
+            return FAILURE;
+        }
+
         if (FAILURE
-            == extract_x509_field_ssl(X509_get_subject_name(peer_cert), x509_username_field,
+            == extract_x509_field_ssl(x509_subject_name, x509_username_field,
                                       common_name, cn_len))
         {
             return FAILURE;
         }
+    }
 
     return SUCCESS;
 }

