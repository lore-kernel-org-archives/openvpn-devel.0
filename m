Message-ID: <42821866.9080008@...349...>
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
References: <4281BADE.2020402@...349...> <Pine.LNX.4.58.0505110329020.15651@...41...> <4281E350.8020609@...349...>
In-Reply-To: <4281E350.8020609@...349...>
Content-Type: multipart/mixed;
 boundary="------------070000040503060508030807"
Subject: [Openvpn-devel] Patch for a --capath option (was: Security bug with crl-verify)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed May 11 07:38:14 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070000040503060508030807
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hello,

>>>  (...)
>>>  #if OPENSSL_VERSION_NUMBER >=3D 0x00907000L
>>>        X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK);
>>>        X509_STORE_CTX_set_flags (csc, X509_V_FLAG_CRL_CHECK_ALL);
>>>  #endif
>>>  (...)>>
>>>With this kind of X509_STORE_CTX, openssl automagically manage all CA=20
>>>and all CRL included in a "CAPath".
>>Good idea -- it would be better for OpenSSL to handle all of the CRL stuf=
f=20
>>for 0.9.7 and above.
> I will try to produce a patch for a "--capath" option. See you in two or =

> three hours.

Attached, a patch (experimental, proof of concept...).

I'm not very happy with this patch : all CA and CRL are checked, but if=20
I update a CRL, openssl doesn't see any changes and continue to accept=20
my revoked certificate.

I don't know if there is a "cache" system integrated in openssl... I=20
don't know if I correctly use X509_STORE_add_lookup() and=20
X509_LOOKUP_add_dir() ... I'm not a openssl guru, not at all ;-)

Thanks,
--=20
Thomas NOEL <thomas.noel@...349...> http://www.auf.org/
Coordinateur des infrastructures techniques
Agence universitaire de la Francophonie (AUF)
Services centraux Paris - 4 place de la Sorbonne - 75005 Paris
T=E9l: +33 (0)1 44 41 18 18, poste 1822 Tlc: +33(0)1 44 41 18 19
 > Merci d'=E9viter de m'envoyer des documents Word ou PowerPoint
 > cf http://www.gnu.org/philosophy/no-word-attachments.fr.html

--------------070000040503060508030807
Content-Type: text/x-patch;
 name="openvpn-capath.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-capath.patch"

diff -Nru --exclude=debian --exclude='*win32*' --exclude=plugin openvpn-2.0.orig/options.c openvpn-2.0/options.c
--- openvpn-2.0.orig/options.c	2005-05-11 16:24:33.000000000 +0200
+++ openvpn-2.0/options.c	2005-05-11 14:33:06.000000000 +0200
@@ -388,6 +388,13 @@
   "                  number, such as 1 (default), 2, etc.\n"
   "--ca file       : Certificate authority file in .pem format containing\n"
   "                  root certificate.\n"
+  "--capath dir    : A directory of trusted certificates (CAs"
+#if OPENSSL_VERSION_NUMBER >= 0x00907000L
+  " and CRLs).\n"
+#else
+  ").\n"
+  "                  WARNING: no support of CRL available with this version.\n"
+#endif
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
   "                  Use \"openssl dhparam -out dh1024.pem 1024\" to generate.\n"
@@ -1096,6 +1103,7 @@
   SHOW_BOOL (tls_client);
   SHOW_INT (key_method);
   SHOW_STR (ca_file);
+  SHOW_STR (ca_path);
   SHOW_STR (dh_file);
   SHOW_STR (cert_file);
   SHOW_STR (priv_key_file);
@@ -1561,7 +1569,8 @@
 #ifdef WIN32
       if (options->cryptoapi_cert)
 	{
-          notnull (options->ca_file, "CA file (--ca)");
+	  if ((!(options->ca_file)) && (!(options->ca_path)))
+	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
           if (options->cert_file)
 	    msg(M_USAGE, "Parameter --cert cannot be used when --cryptoapicert is also specified.");
           if (options->priv_key_file)
@@ -1575,6 +1584,8 @@
         {
           if (options->ca_file)
 	    msg(M_USAGE, "Parameter --ca cannot be used when --pkcs12 is also specified.");
+          if (options->ca_path)
+	    msg(M_USAGE, "Parameter --capath cannot be used when --pkcs12 is also specified.");
           if (options->cert_file)
 	    msg(M_USAGE, "Parameter --cert cannot be used when --pkcs12 is also specified.");
           if (options->priv_key_file)
@@ -1582,7 +1593,8 @@
         }
       else
         {
-          notnull (options->ca_file, "CA file (--ca) or PKCS#12 file (--pkcs12)");
+	  if ((!(options->ca_file)) && (!(options->ca_path)))
+	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
 	  if (pull)
 	    {
 	      const int sum = (options->cert_file != NULL) + (options->priv_key_file != NULL);
@@ -1619,6 +1631,7 @@
       const char err[] = "Parameter %s can only be specified in TLS-mode, i.e. where --tls-server or --tls-client is also specified.";
 
       MUST_BE_UNDEF (ca_file);
+      MUST_BE_UNDEF (ca_path);
       MUST_BE_UNDEF (dh_file);
       MUST_BE_UNDEF (cert_file);
       MUST_BE_UNDEF (priv_key_file);
@@ -4278,6 +4291,12 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ca_file = p[1];
     }
+  else if (streq (p[0], "capath") && p[1])
+    {
+      ++i;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->ca_path = p[1];
+    }
   else if (streq (p[0], "dh") && p[1])
     {
       ++i;
diff -Nru --exclude=debian --exclude='*win32*' --exclude=plugin openvpn-2.0.orig/options.h openvpn-2.0/options.h
--- openvpn-2.0.orig/options.h	2005-05-11 16:24:33.000000000 +0200
+++ openvpn-2.0/options.h	2005-05-11 12:55:57.000000000 +0200
@@ -356,6 +356,7 @@
   bool tls_server;
   bool tls_client;
   const char *ca_file;
+  const char *ca_path;
   const char *dh_file;
   const char *cert_file;
   const char *priv_key_file;
diff -Nru --exclude=debian --exclude='*win32*' --exclude=plugin openvpn-2.0.orig/ssl.c openvpn-2.0/ssl.c
--- openvpn-2.0.orig/ssl.c	2005-05-11 16:24:33.000000000 +0200
+++ openvpn-2.0/ssl.c	2005-05-11 16:23:14.000000000 +0200
@@ -867,12 +867,32 @@
 	}
 
       /* Load CA file for verifying peer supplied certificate */
-      ASSERT (options->ca_file);
-      if (!SSL_CTX_load_verify_locations (ctx, options->ca_file, NULL))
-        msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_CTX_load_verify_locations)", options->ca_file);
+      ASSERT (options->ca_file || options->ca_path);
+      if (!SSL_CTX_load_verify_locations (ctx, options->ca_file, options->ca_path))
+        msg (M_SSLERR, "Cannot load CA certificate file %s path %s (SSL_CTX_load_verify_locations)", options->ca_file, options->ca_path);
+
+      /* Set a store for certs (CA & CRL) with a lookup on the "capath" hash directory */
+      if (options->ca_path) {
+        X509_STORE *store = SSL_CTX_get_cert_store(ctx);
+
+        if (store) {
+          X509_LOOKUP *lookup = X509_STORE_add_lookup(store, X509_LOOKUP_hash_dir());
+	  if (!X509_LOOKUP_add_dir(lookup, options->ca_path, X509_FILETYPE_PEM))
+            X509_LOOKUP_add_dir(lookup, NULL, X509_FILETYPE_DEFAULT);
+	  else
+	    msg(M_WARN, "WARNING: experimental option --capath %s", options->ca_path);
+#if OPENSSL_VERSION_NUMBER >= 0x00907000L
+          X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
+#else
+#warn This version of OpenSSL cannot handle CRL files in capath 
+          msg(M_WARN, "WARNING: this version of OpenSSL cannot handle CRL files in capath");
+#endif
+	} else
+          msg(M_SSLERR, "Cannot get certificate store (SSL_CTX_get_cert_store)");
+      }
 
       /* Load names of CAs from file and use it as a client CA list */
-      {
+      if (options->ca_file) {
         STACK_OF(X509_NAME) *cert_names;
         cert_names = SSL_load_client_CA_file (options->ca_file);
         if (!cert_names)

--------------070000040503060508030807--

