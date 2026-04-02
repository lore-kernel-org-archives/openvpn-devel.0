From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  2 Apr 2026 14:10:49 +0200
Message-ID: <20260402121049.41102-1-frank@...2641...>
In-Reply-To: <gerrit.1774974242000.Iea1d13c160599f134587c6f1c2f4a90e7f5e3991@...2715...>
References: <gerrit.1774974242000.Iea1d13c160599f134587c6f1c2f4a90e7f5e3991@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] OpenSSL 4.0: Make X509 objects const
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

In OpenSSL 4.0 a lot of the APIs have changed to return const objects.
Adjust our source code to use const objects as well.

Change-Id: Iea1d13c160599f134587c6f1c2f4a90e7f5e3991
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1596
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1596
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a26663a..fd05f43 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1789,7 +1789,6 @@
     STACK_OF(X509_NAME) *cert_names = NULL;
     X509_LOOKUP *lookup = NULL;
     X509_STORE *store = NULL;
-    X509_NAME *xn = NULL;
     BIO *in = NULL;
     int i, added = 0, prev = 0;
 
@@ -1853,21 +1852,26 @@
                         }
                     }
 
-                    xn = X509_get_subject_name(info->x509);
+                    /* OpenSSL 4.0 has made X509_get_subject_name return const
+                     * but not adjusted the other functions to take const
+                     * arguments, and other libraries do not have const
+                     * arguments, so just ignore const here */
+                    X509_NAME *xn = (X509_NAME *)X509_get_subject_name(info->x509);
                     if (!xn)
                     {
                         continue;
                     }
 
+
                     /* Don't add duplicate CA names */
-                    if (sk_X509_NAME_find(cert_names, xn) == -1)
+                    if (sk_X509_NAME_find(cert_names, (X509_NAME *)xn) == -1)
                     {
-                        xn = X509_NAME_dup(xn);
-                        if (!xn)
+                        X509_NAME *xn_dup = X509_NAME_dup(xn);
+                        if (!xn_dup)
                         {
                             continue;
                         }
-                        sk_X509_NAME_push(cert_names, xn);
+                        sk_X509_NAME_push(cert_names, xn_dup);
                     }
                 }
 
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 08946cd..c5c4acd 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -191,7 +191,7 @@
  * to contain result is grounds for error).
  */
 static result_t
-extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out, size_t size)
+extract_x509_field_ssl(const X509_NAME *x509, const char *field_name, char *out, size_t size)
 {
     int lastpos = -1;
     int tmp = -1;
@@ -209,7 +209,12 @@
     do
     {
         lastpos = tmp;
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
         tmp = X509_NAME_get_index_by_OBJ(x509, field_name_obj, lastpos);
+#else
+        /* OpenSSL 1.1.x has the argument as non-const */
+        tmp = X509_NAME_get_index_by_OBJ((X509_NAME *)x509, field_name_obj, lastpos);
+#endif
     } while (tmp > -1);
 
     ASN1_OBJECT_free(field_name_obj);
@@ -269,7 +274,7 @@
     }
     else
     {
-        X509_NAME *x509_subject_name = X509_get_subject_name(peer_cert);
+        const X509_NAME *x509_subject_name = X509_get_subject_name(peer_cert);
         if (x509_subject_name == NULL)
         {
             msg(D_TLS_ERRORS, "X509 subject name is NULL");
@@ -457,7 +462,12 @@
 x509_setenv_track(const struct x509_track *xt, struct env_set *es, const int depth, X509 *x509)
 {
     struct gc_arena gc = gc_new();
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
+    /* OpenSSL 1.1.x APIs all take non-const arguments */
     X509_NAME *x509_name = X509_get_subject_name(x509);
+#else
+    const X509_NAME *x509_name = X509_get_subject_name(x509);
+#endif
     const char nullc = '\0';
 
     while (xt)
@@ -491,10 +501,10 @@
                     int i = X509_NAME_get_index_by_NID(x509_name, xt->nid, -1);
                     if (i >= 0)
                     {
-                        X509_NAME_ENTRY *ent = X509_NAME_get_entry(x509_name, i);
+                        const X509_NAME_ENTRY *ent = X509_NAME_get_entry(x509_name, i);
                         if (ent)
                         {
-                            ASN1_STRING *val = X509_NAME_ENTRY_get_data(ent);
+                            const ASN1_STRING *val = X509_NAME_ENTRY_get_data(ent);
                             unsigned char *buf = NULL;
                             if (ASN1_STRING_to_UTF8(&buf, val) >= 0)
                             {
@@ -508,7 +518,11 @@
                         i = X509_get_ext_by_NID(x509, xt->nid, -1);
                         if (i >= 0)
                         {
+#if OPENSSL_VERSION_NUMBER < 0x40000000L
                             X509_EXTENSION *ext = X509_get_ext(x509, i);
+#else
+                            const X509_EXTENSION *ext = X509_get_ext(x509, i);
+#endif
                             if (ext)
                             {
                                 BIO *bio = BIO_new(BIO_s_mem());
@@ -544,51 +558,43 @@
 void
 x509_setenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *peer_cert)
 {
-    int i, n;
-    int fn_nid;
-    ASN1_OBJECT *fn;
-    ASN1_STRING *val;
-    X509_NAME_ENTRY *ent;
-    const char *objbuf;
-    unsigned char *buf = NULL;
-    char *name_expand;
-    size_t name_expand_size;
-    X509_NAME *x509 = X509_get_subject_name(peer_cert);
+    const X509_NAME *x509 = X509_get_subject_name(peer_cert);
 
-    n = X509_NAME_entry_count(x509);
-    for (i = 0; i < n; ++i)
+    int n = X509_NAME_entry_count(x509);
+    for (int i = 0; i < n; ++i)
     {
-        ent = X509_NAME_get_entry(x509, i);
+        const X509_NAME_ENTRY *ent = X509_NAME_get_entry(x509, i);
         if (!ent)
         {
             continue;
         }
-        fn = X509_NAME_ENTRY_get_object(ent);
+        const ASN1_OBJECT *fn = X509_NAME_ENTRY_get_object(ent);
         if (!fn)
         {
             continue;
         }
-        val = X509_NAME_ENTRY_get_data(ent);
+        const ASN1_STRING *val = X509_NAME_ENTRY_get_data(ent);
         if (!val)
         {
             continue;
         }
-        fn_nid = OBJ_obj2nid(fn);
+        int fn_nid = OBJ_obj2nid(fn);
         if (fn_nid == NID_undef)
         {
             continue;
         }
-        objbuf = OBJ_nid2sn(fn_nid);
+        const char *objbuf = OBJ_nid2sn(fn_nid);
         if (!objbuf)
         {
             continue;
         }
+        unsigned char *buf = NULL;
         if (ASN1_STRING_to_UTF8(&buf, val) < 0)
         {
             continue;
         }
-        name_expand_size = 64 + strlen(objbuf);
-        name_expand = (char *)malloc(name_expand_size);
+        size_t name_expand_size = 64 + strlen(objbuf);
+        char *name_expand = malloc(name_expand_size);
         check_malloc_return(name_expand);
         snprintf(name_expand, name_expand_size, "X509_%d_%s", cert_depth, objbuf);
         string_mod(name_expand, CC_PRINT, CC_CRLF, '_');

