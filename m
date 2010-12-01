Message-ID: <4CF6B9B3.6010608@...1432...>
Date: Wed, 01 Dec 2010 22:10:11 +0100
From: =?ISO-8859-1?Q?Markus_K=F6tter?=
 <koetter@...1432...>
MIME-Version: 1.0
References: <4CED2879.2030009@...1432...>
	<4CF51D5B.4090905@...68...>
In-Reply-To: <4CF51D5B.4090905@...68...>
Content-Type: multipart/mixed; boundary="------------020302090202060102080906"
Subject: Re: [Openvpn-devel] use extv3 extensions such as subjectAltName as
 common_name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020302090202060102080906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Matthias Andree wrote:
> NAK on the patch:
> 
> 1. unsafe use of strncpy (remember that strncpy does not NUL terminate if
> there's no room!), and

You are right, I just noticed the existence of strcpynt for this purpose.

> 2. without reading ASN1_STRING_to_UTF8() docs, I do not believe that the ASN
> extraction is safe in itself.  There is no check for embedded NULs, and this
> needs to be checked whenever you convert between NUL-terminated C-strings and
> pointer/length strings and vice versa.  There have been prior vulnerabilities,
> such as CVE-2009-2666.

You are right - same problem holds true for extract_x509_field_ssl, 
setenv_x509?
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=ssl.c;h=a1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=HEAD#l453

> Make sure that the extraction reports failure (aka "return false;") and the
> caller deals with that in case there are embedded NULs, IOW strlen() != ia5.size.

Given the fetchmail ref, seems like the value returned by
X509_get_ext_d2i needs to be freed with sk_GENERAL_NAME_free afterwards
anyway.

Attached is an updated version of the patch using 
remotes/origin/feat_misc as base.

Thanks for reviewing.

Markus

--------------020302090202060102080906
Content-Type: text/x-diff;	name="0001-x509-username-field-add-extv3-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-x509-username-field-add-extv3-support.patch"

From c750625294b4680ac8a8f2c7216f3796631bbbcb Mon Sep 17 00:00:00 2001
From: Markus Koetter <koetter@...1432...>
Date: Wed, 1 Dec 2010 22:03:27 +0100
Subject: [PATCH] x509-username-field - add extv3 support
   - this allows using altSubjectName of the certificate
     to be used for authentication. To use, set
     x509-username-field ext:altSubjectName

Signed-off-by: Markus Koetter <koetter@...1432...>
---
 options.c |    3 +-
 ssl.c     |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/options.c b/options.c
index d0cec7d..1e3fc6e 100644
--- a/options.c
+++ b/options.c
@@ -5647,7 +5647,8 @@ add_option (struct options *options,
     {
       char *s = p[1];
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      while ((*s = toupper(*s)) != '\0') s++; /* Uppercase if necessary */
+      if( strncmp ("ext:",s,4) != 0 )
+        while ((*s = toupper(*s)) != '\0') s++; /* Uppercase if necessary */
       options->x509_username_field = p[1];
     }
 #endif /* USE_SSL */
diff --git a/ssl.c b/ssl.c
index 8644ae4..a69195e 100644
--- a/ssl.c
+++ b/ssl.c
@@ -489,6 +489,65 @@ extract_x509_field_ssl (X509_NAME *x509, const char *field_name, char *out, int
   }
 }
 
+static 
+bool extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
+{
+  X509_EXTENSION *pExt;
+  char *buf = 0;
+  int length = 0;
+  GENERAL_NAMES *extensions;
+  int nid = OBJ_txt2nid(fieldname);
+
+  extensions = (GENERAL_NAMES *)X509_get_ext_d2i(cert, nid, NULL, NULL);
+  if ( extensions )
+    {
+      int numalts;
+      int i;
+      /* get amount of alternatives, 
+       * RFC2459 claims there MUST be at least 
+       * one, but we don't depend on it... 
+       */
+
+      numalts = sk_GENERAL_NAME_num(extensions);
+
+      /* loop through all alternatives */
+      for (i=0; i<numalts; i++)
+        {
+          /* get a handle to alternative name number i */
+          const GENERAL_NAME *name = sk_GENERAL_NAME_value (extensions, i );
+
+          switch (name->type)
+            {
+              case GEN_EMAIL:
+                ASN1_STRING_to_UTF8((unsigned char**)&buf, name->d.ia5);
+                if ( strlen (buf) != name->d.ia5->length )
+                  {
+                    msg (D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero");
+                    sk_GENERAL_NAME_free (extensions);
+                    OPENSSL_free (buf);
+                    return false;
+                  }
+                strncpynt(out, buf, size);
+                OPENSSL_free(buf);
+                break;
+              case GEN_OTHERNAME:
+              case GEN_DNS:
+              case GEN_X400:
+              case GEN_DIRNAME:
+              case GEN_EDIPARTY:
+              case GEN_URI:
+              case GEN_IPADD:
+              case GEN_RID:
+                return false;
+                break;
+            }
+          }
+        sk_GENERAL_NAME_free (extensions);
+    } else
+      return false;
+  return true;
+}
+
 /*
  * Save X509 fields to environment, using the naming convention:
  *
@@ -774,6 +833,21 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   string_replace_leading (subject, '-', '_');
 
   /* extract the username (default is CN) */
+  if (strncmp("ext:",x509_username_field,4) == 0)
+    {
+      if (!extract_x509_extension (ctx->current_cert, x509_username_field+4, common_name, sizeof(common_name)))
+        {
+          if (!ctx->error_depth)
+            {
+              msg (D_TLS_ERRORS, "VERIFY ERROR: could not extract %s extension from X509 subject string ('%s') "
+                                 "-- note that the username length is limited to %d characters",
+                                 x509_username_field+4,
+                                 subject,
+                                 TLS_USERNAME_LEN);
+              goto err;
+            }
+        }
+    } else
   if (!extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert), x509_username_field, common_name, sizeof(common_name)))
     {
       if (!ctx->error_depth)
-- 
1.6.3.3


--------------020302090202060102080906--

