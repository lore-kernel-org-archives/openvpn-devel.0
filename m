Message-ID: <496B7A61.6090602@...260...>
Date: Mon, 12 Jan 2009 18:14:09 +0100
From: Mathieu GIANNECCHINI <mat.giann@...260...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050406060306040005030402"
Subject: [Openvpn-devel] [patch] enhance tls-verify possibility
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
--------------050406060306040005030402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

It should be nice to enhance tls-verify check possibilities against peer
cert during a pending TLS connection like :
- OCSP verification
- check any X509 extensions of the peer certificate
- delta CRL verification
- ...

This patch add a new "tls-export-cert" option which allow to get peer
certificate in PEM format and to store it in an openvpn temporary file.
Peer certificate is stored before tls-script execution and deleted after.
The name of the related temporary file is available under tls-verify
script by an environment variable "peer_cert".

The patch was made from OpenVPN svn Beta21 branches.

Here is a very simple exemple of Tls-verify script which provide OCSP
support to OpenVPN (with tls-export-cert option) without any OpenVPN
"core" modification :



#!/bin/sh

X509=$2

# Perform OCSP check on peer certificate
openssl ocsp \
      -issuer /etc/openvpn/ssl.crt/RootCA.pem \
      -CAfile /etc/openvpn/ssl.capath/OpenVPNServeur-cafile.pem \
      -cert $peer_cert \
      -url http://your-ocsp-url
      if [ $? -ne 0 ]
      then
          echo "error : OCSP check failed for ${X509}" | logger -t
"tls-verify"
          exit 1
       fi


Regards

--------------050406060306040005030402
Content-Type: text/plain;
 name="openvpn-svnbeta21-export-cert.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-svnbeta21-export-cert.diff"

diff -ru openvpn/init.c openvpn-tls-export-cert/init.c
--- openvpn/init.c	2009-01-09 16:25:25.000000000 +0100
+++ openvpn-tls-export-cert/init.c	2009-01-09 16:28:34.000000000 +0100
@@ -1761,6 +1761,7 @@
 #endif
 
   to.verify_command = options->tls_verify;
+  to.verify_export_cert = options->tls_export_cert;
   to.verify_x509name = options->tls_remote;
   to.crl_file = options->crl_file;
   to.ns_cert_type = options->ns_cert_type;
diff -ru openvpn/options.c openvpn-tls-export-cert/options.c
--- openvpn/options.c	2009-01-09 16:25:25.000000000 +0100
+++ openvpn-tls-export-cert/options.c	2009-01-12 12:37:34.000000000 +0100
@@ -518,6 +518,9 @@
   "                  tests of certification.  cmd should return 0 to allow\n"
   "                  TLS handshake to proceed, or 1 to fail.  (cmd is\n"
   "                  executed as 'cmd certificate_depth X509_NAME_oneline')\n"
+  "--tls-export-cert [directory] : Get peer cert in PEM format and store it \n"
+  "                  in an openvpn temporary file in [directory]. Peer cert is \n"
+  "                  stored before tls-verify script execution and deleted after.\n"
   "--tls-remote x509name: Accept connections only from a host with X509 name\n"
   "                  x509name. The remote host must also pass all other tests\n"
   "                  of verification.\n"
@@ -1309,6 +1312,7 @@
 #endif
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
+  SHOW_STR (tls_export_cert);
   SHOW_STR (tls_remote);
   SHOW_STR (crl_file);
   SHOW_INT (ns_cert_type);
@@ -1902,6 +1906,7 @@
       MUST_BE_UNDEF (pkcs12_file);
       MUST_BE_UNDEF (cipher_list);
       MUST_BE_UNDEF (tls_verify);
+      MUST_BE_UNDEF (tls_export_cert);
       MUST_BE_UNDEF (tls_remote);
       MUST_BE_UNDEF (tls_timeout);
       MUST_BE_UNDEF (renegotiate_bytes);
@@ -5424,6 +5429,11 @@
 	goto err;
       options->tls_verify = string_substitute (p[1], ',', ' ', &options->gc);
     }
+  else if (streq (p[0], "tls-export-cert") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->tls_export_cert = p[1];
+    }
   else if (streq (p[0], "tls-remote") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff -ru openvpn/options.h openvpn-tls-export-cert/options.h
--- openvpn/options.h	2009-01-09 16:25:25.000000000 +0100
+++ openvpn-tls-export-cert/options.h	2009-01-09 16:37:04.000000000 +0100
@@ -443,6 +443,7 @@
   const char *pkcs12_file;
   const char *cipher_list;
   const char *tls_verify;
+  const char *tls_export_cert;
   const char *tls_remote;
   const char *crl_file;
 
diff -ru openvpn/ssl.c openvpn-tls-export-cert/ssl.c
--- openvpn/ssl.c	2009-01-09 16:25:25.000000000 +0100
+++ openvpn-tls-export-cert/ssl.c	2009-01-09 17:29:51.000000000 +0100
@@ -589,6 +589,49 @@
     string_mod (str, restrictive_flags, 0, '_');
 }
 
+/* Get peer cert and store it in pem format in a temporary file
+ * in tmp_dir
+ */
+
+const char *
+get_peer_cert(X509_STORE_CTX *ctx, const char *tmp_dir, struct gc_arena *gc)
+{
+  X509 *peercert;
+  FILE *peercert_file;
+  const char *peercert_filename="";
+  
+  if(!tmp_dir)
+      return NULL;
+  
+  /* get peer cert */
+  peercert = X509_STORE_CTX_get_current_cert(ctx);
+  if(!peercert)
+    {
+      msg (M_ERR, "Unable to get peer certificate from current context");
+      return NULL;
+    }
+  
+  /* create tmp file to store peer cert */
+  peercert_filename = create_temp_filename (tmp_dir, "pcf", gc);
+  
+  /* write peer-cert in tmp-file */
+  peercert_file = fopen(peercert_filename, "w+");
+  if(!peercert_file)
+    {
+      msg (M_ERR, "Failed to open temporary file : %s", peercert_filename);
+      return NULL;
+    }
+  if(PEM_write_X509(peercert_file,peercert)<0)
+    {
+      msg (M_ERR, "Failed to write peer certificate in PEM format");
+      fclose(peercert_file);
+      return NULL;
+    }
+
+  fclose(peercert_file);
+  return peercert_filename;
+}
+
 /*
  * Our verify callback function -- check
  * that an incoming peer certificate is good.
@@ -777,10 +820,21 @@
   /* run --tls-verify script */
   if (opt->verify_command)
     {
+      const char *tmp_file;
+      struct gc_arena gc;
       int ret;
 
       setenv_str (opt->es, "script_type", "tls-verify");
 
+      if (opt->verify_export_cert)
+        {
+          gc = gc_new();
+          if (tmp_file=get_peer_cert(ctx, opt->verify_export_cert,&gc))
+           {
+             setenv_str(opt->es, "peer_cert", tmp_file);
+           }
+        }
+
       argv_printf (&argv, "%sc %d %s",
 		   opt->verify_command,
 		   ctx->error_depth,
@@ -788,6 +842,12 @@
       argv_msg_prefix (D_TLS_DEBUG, &argv, "TLS: executing verify command");
       ret = openvpn_execve (&argv, opt->es, S_SCRIPT);
 
+      if (opt->verify_export_cert)
+        {
+           delete_file(tmp_file);
+           gc_free(&gc);
+        }       
+
       if (system_ok (ret))
 	{
 	  msg (D_HANDSHAKE, "VERIFY SCRIPT OK: depth=%d, %s",
diff -ru openvpn/ssl.h openvpn-tls-export-cert/ssl.h
--- openvpn/ssl.h	2009-01-09 16:25:25.000000000 +0100
+++ openvpn-tls-export-cert/ssl.h	2009-01-09 16:52:41.000000000 +0100
@@ -428,6 +428,7 @@
 
   /* cert verification parms */
   const char *verify_command;
+  const char *verify_export_cert;
   const char *verify_x509name;
   const char *crl_file;
   int ns_cert_type;



--------------050406060306040005030402--

