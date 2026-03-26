From: Gert Doering <gert@...1296...>
Date: Thu, 26 Mar 2026 12:06:52 +0100
Message-ID: <20260326110658.25741-1-gert@...1296...>
In-Reply-To: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
References: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Use const specifices in
 extract_x509_field_ssl
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

From: Arne Schwabe <arne@...1227...>

The new OpenSSL 4.0 will return const objects from these objects, so
make them const in our code as well.

Change-Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1588
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1588
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 46401cd..4c492a3 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -195,8 +195,6 @@
 {
     int lastpos = -1;
     int tmp = -1;
-    X509_NAME_ENTRY *x509ne = NULL;
-    ASN1_STRING *asn1 = NULL;
     unsigned char *buf = NULL;
 
     ASN1_OBJECT *field_name_obj = OBJ_txt2obj(field_name, 0);
@@ -222,13 +220,13 @@
         return FAILURE;
     }
 
-    x509ne = X509_NAME_get_entry(x509, lastpos);
+    const X509_NAME_ENTRY *x509ne = X509_NAME_get_entry(x509, lastpos);
     if (!x509ne)
     {
         return FAILURE;
     }
 
-    asn1 = X509_NAME_ENTRY_get_data(x509ne);
+    const ASN1_STRING *asn1 = X509_NAME_ENTRY_get_data(x509ne);
     if (!asn1)
     {
         return FAILURE;

