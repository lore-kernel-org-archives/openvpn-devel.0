Message-ID: <4D027FC1.2020308@...1432...>
Date: Fri, 10 Dec 2010 20:30:09 +0100
From: =?ISO-8859-15?Q?Markus_K=F6tter?=
 <koetter@...1432...>
MIME-Version: 1.0
References: <4D021744.7010307@...515...>
In-Reply-To: <4D021744.7010307@...515...>
Content-Type: multipart/mixed; boundary="------------010708000707000806070003"
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (9th Dec 2010)
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
--------------010708000707000806070003
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mrelay17.uni-hannover.de id oBAJU92U002906
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Samuli Sepp=E4nen wrote:
> <http://thread.gmane.org/gmane.network.openvpn.devel/4185>
> In deeper analysis it was noted that this feature, or using an external
> CA for OpenVPN certs in general, may be dangerous. Consider the
> following scenario:
>=20
> - An external root CA (e.g. Verisign) is used for OpenVPN certificates,
>   with or without an internal sub-CA
> - A certificate field such as subjectAltName contains an email address
>   and is used as common_name in OpenVPN
>=20
> Even if a sub-CA is included in the certificate signing chain, it's
> likely that OpenVPN/OpenSSL will happily accept certificates signed
> _only_ by the external root CA. So, a malicious person could connect to
> the VPN by having a certificate with a faked email address signed by the
> external CA.

I had a chat with my PKI oracles on this, and from what I got you are
correct.
So you do not only have to trust your CA, but all sub-CA's of your CA.
As you pay your CA for this, and your CA has every sub-CA, including
you, sign agreements on the nature of the certificates created, this is
not considered a problem here.

If you do not or can not trust your CA, it makes no difference if you
use an email address extracted from via "extv3:altSubjectName" "email"
or the default CN for authentication.

> This feature could be implemented more safely as a separate plugin using
> the new v3 plug-in API, as that will provide full access to the X509
> certificate object in C code. Dazo sent the second version of the v3
> plug-in API to openvpn-devel mailing list today.

I need the email address from extv3 altSubjectName for the
connect-script userland script, as the address assignment relies on it.
Currently this script is pretty easy, some lines of python querying a
sqlite database, I doubt this will get any easier or secure by writing
this in c.
Of course, it may be possible to change the internal common_name in a v3
plugin instead of patching openvpn to take care, and do
authentication/authorization in the plugin too, but it would be way more
complex/error pront to accomplish the same goal using the same path.

I have to authenticate/authorize users based on their valid certificate
and the email address from the altSubjectName field.
It is useful to have the logfiles use the email address as well for the
internal 'common_name' of the client, it is just consistent.
As the CN is not meant to be uniq by definition, I may run into CN
collisions if openvpn uses the CN internally, even though there is no
collision as it is different users with the same CN but different
certificates.

If you are part of a larger PKI and want use this PKI for openvpn
certificates, you'll need something slightly more uniq than the CN of
the certificates for authentication/authorization as you can't start
changing the names in your users birth certificates for technical reasons.

I can't ask for a separate PKI for openvpn.
There is no reason, we can and have to rely on our PKI's integrity,
thats what it exists for, thats what we pay for.
Our users already have certificates which are used to authenticate via
https or sign emails, asking for 'a special certificate for vpn' is not
an option, not even mentioning 'a special smartcard for the vpn'.

That said, I disagree with the decision to put this down.

Given the requirement to cooperate with existing infrastructure, I'd
rather look into how to make it easier to use openvpn with existing CA
signed sub-CA PKI's and think about adding support for ocsp verification.


I've attached the most recent version of the patch which was
acknowledged code-wise yesterday, but rejected for the cited reasons,
just in case somebody faces similar problems.


MfG
Markus


--------------010708000707000806070003
Content-Type: text/x-diff;
	name="000x-x509-username-field-add-extv3-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="000x-x509-username-field-add-extv3-support.patch"

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
index 8644ae4..8f30c6a 100644
--- a/ssl.c
+++ b/ssl.c
@@ -489,6 +489,60 @@ extract_x509_field_ssl (X509_NAME *x509, const char *field_name, char *out, int
   }
 }
 
+static 
+bool extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
+{
+  bool retval = false;
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
+                    OPENSSL_free (buf);
+                  }else
+                  {
+                    strncpynt(out, buf, size);
+                    OPENSSL_free(buf);
+                    retval = true;
+                  }
+                break;
+              default:
+                msg (D_TLS_ERRORS, "ASN1 ERROR: can not handle field type %i", 
+                     name->type);
+                break;
+            }
+          }
+        sk_GENERAL_NAME_free (extensions);
+    }
+  return retval;
+}
+
 /*
  * Save X509 fields to environment, using the naming convention:
  *
@@ -774,6 +828,18 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   string_replace_leading (subject, '-', '_');
 
   /* extract the username (default is CN) */
+  if (strncmp("ext:",x509_username_field,4) == 0)
+    {
+      if (!extract_x509_extension (ctx->current_cert, x509_username_field+4, common_name, sizeof(common_name)))
+        {
+          msg (D_TLS_ERRORS, "VERIFY ERROR: could not extract %s extension from X509 subject string ('%s') "
+                             "-- note that the username length is limited to %d characters",
+                             x509_username_field+4,
+                             subject,
+                             TLS_USERNAME_LEN);
+          goto err;
+        }
+    } else
   if (!extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert), x509_username_field, common_name, sizeof(common_name)))
     {
       if (!ctx->error_depth)


--------------010708000707000806070003--

