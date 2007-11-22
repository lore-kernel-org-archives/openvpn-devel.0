Date: Thu, 22 Nov 2007 15:21:12 +0300
From: Pavel Shramov <shramov@...1064...>
Message-ID: <20071122122112.GA32315@...1063...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
Subject: [Openvpn-devel] incorrect common name extraction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Openvpn extracts only part of CN before '/'. For example from
"/O=MSU/O=Grid/OU=IMEC/OU=ca.grid.pp.ru/CN=host/vpn.grid.pp.ru"
openvpn extracts "host" (correct is "host/vpn.grid.pp.ru"). 
So all hosts get one CN "host" and client-connect script get incorrect
info.

DN's of such kind are used in Globus.

Fix (rewriting extract_x509_field to use openssl library functions) is
attached.
Second patch adds '/' to the list of allowed chars in CN so it won't be
remapped.

                                        Pavel

--pf9I7BMVVzbSWLtt
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="allow-slash.patch"

commit c96f2538fb506f6c531628ca4f48c3eb33a34765
Author: Pavel Shramov <psha@...1063...>
Date:   Wed Nov 21 17:40:32 2007 +0300

    allow / in CN

diff --git a/ssl.h b/ssl.h
index e07f19a..4319a81 100644
--- a/ssl.h
+++ b/ssl.h
@@ -282,7 +282,7 @@
 
 /* Legal characters in an X509 or common name */
 #define X509_NAME_CHAR_CLASS   (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_COLON|CC_SLASH|CC_EQUAL)
-#define COMMON_NAME_CHAR_CLASS (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT)
+#define COMMON_NAME_CHAR_CLASS (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_SLASH)
 
 /* Maximum length of OCC options string passed as part of auth handshake */
 #define TLS_OPTIONS_LEN 512

--pf9I7BMVVzbSWLtt
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fix-cn.patch"

commit c332964d29fb428c01dc691ececc7d80cce07dbd
Author: Pavel Shramov <psha@...1063...>
Date:   Wed Nov 21 17:40:21 2007 +0300

    fix x509 name fields extraction function

diff --git a/ssl.c b/ssl.c
index 9cde47d..cc5d8d3 100644
--- a/ssl.c
+++ b/ssl.c
@@ -370,6 +370,51 @@ extract_x509_field (const char *x509, const char *field_name, char *out, int siz
     }
 }
 
+/*
+ * Extract a field from an X509 subject name.
+ *
+ * Example:
+ *
+ * /C=US/ST=CO/L=Denver/O=ORG/CN=First-CN/CN=Test-CA/Email=jim@...41...
+ *
+ * The common name is 'Test-CA'
+ */
+static void
+extract_x509_field_ssl (X509_NAME *x509, const char *field_name, char *out, int size)
+{
+  int lastpos = -1;
+  int tmp = -1;
+  X509_NAME_ENTRY *x509ne = 0;
+  ASN1_STRING *asn1 = 0;
+  unsigned char *buf = 0;
+  int nid = OBJ_txt2nid(field_name);
+
+  ASSERT (size > 0);
+  *out = '\0';
+  do {
+    lastpos = tmp;
+    tmp = X509_NAME_get_index_by_NID(x509, nid, lastpos);
+  } while (tmp > 0);
+
+  /* Nothing found */
+  if (lastpos == -1)
+    return;
+
+  x509ne = X509_NAME_get_entry(x509, lastpos);
+  if (!x509ne)
+    return;
+
+  asn1 = X509_NAME_ENTRY_get_data(x509ne);
+  if (!asn1)
+    return;
+  tmp = ASN1_STRING_to_UTF8(&buf, asn1);
+  if (tmp <= 0)
+    return;
+
+  strncpynt(out, buf, size);
+  OPENSSL_free(buf);
+}
+
 static void
 setenv_untrusted (struct tls_session *session)
 {
@@ -445,7 +490,8 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   string_mod (subject, X509_NAME_CHAR_CLASS, 0, '_');
 
   /* extract the common name */
-  extract_x509_field (subject, "CN", common_name, TLS_CN_LEN);
+  extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert), "CN", common_name, TLS_CN_LEN);
+  //extract_x509_field (subject, "CN", common_name, TLS_CN_LEN);
   string_mod (common_name, COMMON_NAME_CHAR_CLASS, 0, '_');
 
 #if 0 /* print some debugging info */

--pf9I7BMVVzbSWLtt--

