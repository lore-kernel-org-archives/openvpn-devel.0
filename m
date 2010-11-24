Message-ID: <4CED2879.2030009@...1432...>
Date: Wed, 24 Nov 2010 16:00:09 +0100
From: Markus Koetter <koetter@...1432...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020405010908070506030707"
Subject: [Openvpn-devel] use extv3 extensions such as subjectAltName as
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
--------------020405010908070506030707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

attached is a patch which allows using the extv3 extension of a 
certificate as common name with email address.
Email addresses are more likely to be unique than the common name, and 
the environment forced me to use the subjectAltName extv3 extension for 
authentication.
So, there is already a need for this.

The patch extends the x509_username_field. If the username field is 
prefixed with ext: the value of the field is not uppercased and the 
remaining part of the option is used as fieldname for the extv3 extension.

So for example:
x509-username-field ext:subjectAltName
extracts the email address here.

Extending the code to extract other types than GEN_EMAIL from the 
extensions is possible, so it could even be used to match on other 
fields than subjectAltName with other data than an email address.


Given we have to use this code anyway, I'd be glad if it could get 
merged into trunk, so we do not rely on special builds in the long run.
Therefore I'm glad to step in, if further final touches are required to 
get this merged.


MfG
Markus


--------------020405010908070506030707
Content-Type: text/x-patch;
 name="extv3_as_common_name.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="extv3_as_common_name.diff"

allow extracting the common name from extrv3 fields, for example altSubjectName for email

Index: openvpn-2.2-beta3/options.c
===================================================================
--- openvpn-2.2-beta3.orig/options.c	2010-11-01 18:12:10.000000000 +0100
+++ openvpn-2.2-beta3/options.c	2010-11-01 18:12:41.000000000 +0100
@@ -5904,6 +5904,7 @@
     {
       char *s = p[1];
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (strncmp("ext:",s,4) != 0)
       while ((*s = toupper(*s)) != '\0') s++; /* Uppercase if necessary */
       options->x509_username_field = p[1];
     }
Index: openvpn-2.2-beta3/ssl.c
===================================================================
--- openvpn-2.2-beta3.orig/ssl.c	2010-11-01 18:12:15.000000000 +0100
+++ openvpn-2.2-beta3/ssl.c	2010-11-01 18:12:32.000000000 +0100
@@ -494,6 +494,58 @@
   }
 }
 
+static 
+bool extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
+{
+	X509_EXTENSION *pExt;
+	char *buf = 0;
+	int length = 0;
+	GENERAL_NAMES *extensions;
+	int nid = OBJ_txt2nid(fieldname);
+
+	extensions = (GENERAL_NAMES *)X509_get_ext_d2i(cert, nid, NULL, NULL);
+	if( extensions )
+	{
+		int numalts;
+		int i;
+		/* get amount of alternatives, 
+		 * RFC2459 claims there MUST be at least 
+		 * one, but we don't depend on it... 
+		 */
+
+		numalts = sk_GENERAL_NAME_num(extensions);
+
+		/* loop through all alternatives */
+		for( i=0; ( i<numalts ); i++ )
+		{
+			/* get a handle to alternative name number i */
+			const GENERAL_NAME *name = sk_GENERAL_NAME_value (extensions, i );
+
+			switch( name->type )
+			{
+			case GEN_EMAIL:
+				ASN1_STRING_to_UTF8((unsigned char**)&buf, name->d.ia5);
+                strncpy(out, buf, size);
+				OPENSSL_free(buf);
+				break;
+			case GEN_OTHERNAME:
+			case GEN_DNS:
+			case GEN_X400:
+			case GEN_DIRNAME:
+			case GEN_EDIPARTY:
+			case GEN_URI:
+			case GEN_IPADD:
+			case GEN_RID:
+				return false;
+				break;
+			}
+
+		}
+	} else
+		return false;
+	return true;
+}
+
 /*
  * Save X509 fields to environment, using the naming convention:
  *
@@ -779,6 +831,20 @@
   string_replace_leading (subject, '-', '_');
 
   /* extract the username (default is CN) */
+  if (strncmp("ext:",x509_username_field,4) == 0)
+  {
+  if (!extract_x509_extension (ctx->current_cert, x509_username_field+4, common_name, sizeof(common_name)))
+    {
+      if (!ctx->error_depth)
+        {
+          msg (D_TLS_ERRORS, "VERIFY ERROR: could not extract %s extension from X509 subject string ('%s') -- note that the username length is limited to %d characters",
+                 x509_username_field+4,
+                 subject,
+                 TLS_USERNAME_LEN);
+          goto err;
+        }
+    }
+  } else
   if (!extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert), x509_username_field, common_name, sizeof(common_name)))
     {
       if (!ctx->error_depth)


--------------020405010908070506030707--

