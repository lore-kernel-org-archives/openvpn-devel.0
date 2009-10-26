Date: Mon, 26 Oct 2009 11:19:43 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091026081943.GA29659@...1066...>
References: <20091023142219.GA30874@...1066...> <4AE3580C.7080604@...41...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <4AE3580C.7080604@...41...>
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On 2009.10.24 at 13:39:56 -0600, James Yonan wrote:

> 
> Can you submit a patch (as an email attachment) with this fix?
Attached 

This patch also contains X509_NAME_oneline replacement, which handles
MSB characters.

I've not checked if this patch applies cleanly to unmodified source.
I've just diffed original 2.1_rc19 source, imported in our subversion
repository with current working copy and removed all irrelevant chunks.



--ikeVEW9yuYc//A+q
Content-Type: text/x-diff; charset=koi8-r
Content-Disposition: attachment; filename="cc_msb.diff"

Index: ssl.c
===================================================================
--- ssl.c	(.../tags/openvpn-2.1_rc19)	(revision 4645)
+++ ssl.c	(.../trunk/openvpn-2.1_rc19)	(revision 4645)
@@ -435,8 +435,8 @@
       name_expand = (char *) malloc (name_expand_size);
       check_malloc_return (name_expand);
       openvpn_snprintf (name_expand, name_expand_size, "X509_%d_%s", error_depth, objbuf);
-      string_mod (name_expand, CC_PRINT, CC_CRLF, '_');
-      string_mod ((char*)buf, CC_PRINT, CC_CRLF, '_');
+      string_mod (name_expand, CC_PRINT|CC_MSB, CC_CRLF, '_');
+      string_mod ((char*)buf, CC_PRINT|CC_MSB, CC_CRLF, '_');
       setenv_str (es, name_expand, (char*)buf);
       free (name_expand);
       OPENSSL_free (buf);
@@ -584,11 +584,24 @@
 string_mod_sslname (char *str, const unsigned int restrictive_flags, const unsigned int ssl_flags)
 {
   if (ssl_flags & SSLF_NO_NAME_REMAPPING)
-    string_mod (str, CC_PRINT, CC_CRLF, '_');
+    string_mod (str, CC_PRINT|CC_MSB, CC_CRLF, '_');
   else
     string_mod (str, restrictive_flags, 0, '_');
 }
 
+static char *my_X509_NAME_oneline(X509_NAME *name) {
+	BIO *b = BIO_new(BIO_s_mem());
+	long datalen;
+	char *p,*q;
+	X509_NAME_print_ex(b, name, 0, (XN_FLAG_ONELINE | ASN1_STRFLGS_UTF8_CONVERT) & ~ASN1_STRFLGS_ESC_MSB);
+	datalen = BIO_get_mem_data(b,&p);
+	q=OPENSSL_malloc(datalen+1);
+	strncpy(q,p,datalen);
+	q[datalen]=0;
+	BIO_free(b);
+	return q;
+}
+
 /*
  * Our verify callback function -- check
  * that an incoming peer certificate is good.
@@ -617,7 +630,7 @@
   session->verified = false;
 
   /* get the X509 name */
-  subject = X509_NAME_oneline (X509_get_subject_name (ctx->current_cert), NULL, 0);
+  subject = my_X509_NAME_oneline (X509_get_subject_name (ctx->current_cert));
   if (!subject)
     {
       msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 subject string from certificate", ctx->error_depth);
@@ -3356,11 +3519,11 @@
       /* preserve raw username before string_mod remapping, for plugins */
       ALLOC_ARRAY_CLEAR_GC (raw_username, char, USER_PASS_LEN, &gc);
       strcpy (raw_username, up->username);
-      string_mod (raw_username, CC_PRINT, CC_CRLF, '_');
+      string_mod (raw_username, CC_PRINT|CC_MSB, CC_CRLF, '_');
 
       /* enforce character class restrictions in username/password */
       string_mod_sslname (up->username, COMMON_NAME_CHAR_CLASS, session->opt->ssl_flags);
-      string_mod (up->password, CC_PRINT, CC_CRLF, '_');
+      string_mod (up->password, CC_PRINT|CC_MSB, CC_CRLF, '_');
 
       /* call plugin(s) and/or script */
 #ifdef MANAGEMENT_DEF_AUTH
Index: ssl.h
===================================================================
--- ssl.h	(.../tags/openvpn-2.1_rc19)	(revision 4645)
+++ ssl.h	(.../trunk/openvpn-2.1_rc19)	(revision 4645)
@@ -284,8 +284,8 @@
 #define TLS_CN_LEN 64
 
 /* Legal characters in an X509 or common name */
-#define X509_NAME_CHAR_CLASS   (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_COLON|CC_SLASH|CC_EQUAL)
-#define COMMON_NAME_CHAR_CLASS (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_SLASH)
+#define X509_NAME_CHAR_CLASS   (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_COLON|CC_SLASH|CC_EQUAL|CC_MSB)
+#define COMMON_NAME_CHAR_CLASS (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_SLASH|CC_MSB)
 
 /* Maximum length of OCC options string passed as part of auth handshake */
 #define TLS_OPTIONS_LEN 512
Index: buffer.c
===================================================================
--- buffer.c	(.../tags/openvpn-2.1_rc19)	(revision 4645)
+++ buffer.c	(.../trunk/openvpn-2.1_rc19)	(revision 4645)
@@ -692,7 +692,8 @@
 
   if ((flags & CC_NULL) && c == '\0')
     return true;
-
+  if ((flags & CC_MSB) && (c & 0x80)) 
+  	return true;
   if ((flags & CC_ALNUM) && isalnum (c))
     return true;
   if ((flags & CC_ALPHA) && isalpha (c))
Index: buffer.h
===================================================================
--- buffer.h	(.../tags/openvpn-2.1_rc19)	(revision 4645)
+++ buffer.h	(.../trunk/openvpn-2.1_rc19)	(revision 4645)
@@ -684,9 +684,10 @@
 #define CC_REVERSE_QUOTE      (1<<23)
 #define CC_AT                 (1<<24)
 #define CC_EQUAL              (1<<25)
+#define CC_MSB				  (1<<26)
 
 /* macro classes */
-#define CC_NAME               (CC_ALNUM|CC_UNDERBAR)
+#define CC_NAME               (CC_ALNUM|CC_UNDERBAR|CC_MSB)
 #define CC_CRLF               (CC_CR|CC_NEWLINE)
 
 bool char_class (const unsigned char c, const unsigned int flags);

--ikeVEW9yuYc//A+q--

