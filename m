Message-ID: <4395A972.6020300@...260...>
From: Mathieu GIANNECCHINI <mat.giann@...260...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020000020207060904030309"
Subject: [Openvpn-devel] Patch for a new tls-export-cert option
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
Date: Tue Dec  6 07:10:03 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020000020207060904030309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Here is a tiny patch which add to OpenVPN a new option "tls-export-cert" :

--tls-export-cert [directory] : Get peer cert in PEM format and store it 
in an openvpn temporary file in [directory]. Peer cert is stored 
*before* tls-verify script execution and deleted *after*.
The peer cert temporary file name is send to tls-verify script by an 
environement variable named "peer_cert".

This new option may be usefull to add some check into tls-verify script.

For example, if you have a PKI with more than one CA, you can handle a 
full CRL check with -crl_check_all openssl option. Here is an example of 
tls-verify script :

#!/bin/sh

# All CRL are in /etc/openvpn/capath directory
RESULT=`openssl verify -CApath /etc/openvpn/capath -crl_check_all 
-verbose $peer_cert 2>&1`

# Is CRL check OK ?
echo $RESULT | grep -qE "$peer_cert: OK"
if [ $? -eq 0 ]
then
        echo "openssl verify successed : $RESULT"
        exit 0
fi

# CRL verification failed
exit 1



Regards,

Mat






--------------020000020207060904030309
Content-Type: text/x-patch;
 name="export_cert_option.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export_cert_option.diff"

diff -ru openvpn-2.0.5/init.c openvpn-2.0.5-patch/init.c
--- openvpn-2.0.5/init.c	2005-12-05 14:44:42.000000000 +0100
+++ openvpn-2.0.5-patch/init.c	2005-12-05 14:47:21.000000000 +0100
@@ -1358,6 +1358,7 @@
 #endif
 
   to.verify_command = options->tls_verify;
+  to.verify_export_cert = options->tls_export_cert;
   to.verify_x509name = options->tls_remote;
   to.crl_file = options->crl_file;
   to.ns_cert_type = options->ns_cert_type;
diff -ru openvpn-2.0.5/options.c openvpn-2.0.5-patch/options.c
--- openvpn-2.0.5/options.c	2005-12-05 14:44:42.000000000 +0100
+++ openvpn-2.0.5-patch/options.c	2005-12-05 14:59:57.000000000 +0100
@@ -432,6 +432,9 @@
   "                  tests of certification.  cmd should return 0 to allow\n"
   "                  TLS handshake to proceed, or 1 to fail.  (cmd is\n"
   "                  executed as 'cmd certificate_depth X509_NAME_oneline')\n"
+  "--tls-export-cert [directory] : Get peer cert in PEM format and store it \n"
+  "		     in an openvpn temporary file in [directory]. Peer cert is \n" 
+  "		     stored before tls-verify script execution and deleted after.\n"
   "--tls-remote x509name: Accept connections only from a host with X509 name\n"
   "                  x509name. The remote host must also pass all other tests\n"
   "                  of verification.\n"
@@ -1114,6 +1117,7 @@
 #endif
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
+  SHOW_STR (tls_export_cert);
   SHOW_STR (tls_remote);
   SHOW_STR (crl_file);
   SHOW_INT (ns_cert_type);
@@ -1634,6 +1638,7 @@
       MUST_BE_UNDEF (pkcs12_file);
       MUST_BE_UNDEF (cipher_list);
       MUST_BE_UNDEF (tls_verify);
+      MUST_BE_UNDEF (tls_export_cert);
       MUST_BE_UNDEF (tls_remote);
       MUST_BE_UNDEF (tls_timeout);
       MUST_BE_UNDEF (renegotiate_bytes);
@@ -4442,6 +4447,11 @@
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
       ++i;
diff -ru openvpn-2.0.5/options.h openvpn-2.0.5-patch/options.h
--- openvpn-2.0.5/options.h	2005-12-05 14:44:42.000000000 +0100
+++ openvpn-2.0.5-patch/options.h	2005-12-05 15:01:00.000000000 +0100
@@ -363,6 +363,7 @@
   const char *pkcs12_file;
   const char *cipher_list;
   const char *tls_verify;
+  const char *tls_export_cert;
   const char *tls_remote;
   const char *crl_file;
   int ns_cert_type; /* set to 0, NS_SSL_SERVER, or NS_SSL_CLIENT */
diff -ru openvpn-2.0.5/ssl.c openvpn-2.0.5-patch/ssl.c
--- openvpn-2.0.5/ssl.c	2005-12-05 14:44:42.000000000 +0100
+++ openvpn-2.0.5-patch/ssl.c	2005-12-05 15:52:19.000000000 +0100
@@ -410,6 +410,64 @@
     }
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
+  const char *tmp_file="";
+  char subject[256];
+  char common_name[TLS_CN_LEN];
+  struct buffer cmd = alloc_buf_gc (256, gc);
+
+  if(!tmp_dir)
+    {
+      return NULL;
+    }
+  
+  /* get peer cert */
+  peercert = X509_STORE_CTX_get_current_cert(ctx);
+  if(!peercert)
+    {
+      msg (M_ERR, "Unable to get peer certificate from current context");
+      return NULL;
+    }
+  
+  /* get the X509 name */
+  X509_NAME_oneline (X509_get_subject_name (ctx->current_cert), subject, sizeof (subject));
+  subject[sizeof (subject) - 1] = '\0';
+  
+  /* enforce character class restrictions in X509 name */
+  string_mod (subject, X509_NAME_CHAR_CLASS, 0, '_');
+  
+  /* extract the common name */
+  extract_x509_field (subject, "CN", common_name, TLS_CN_LEN);
+  string_mod (common_name, COMMON_NAME_CHAR_CLASS, 0, '_');
+  
+  /* create tmp file to store peer cert */
+  tmp_file = create_temp_filename (tmp_dir, gc);
+  
+  /* write peer-cert in tmp-file */
+  peercert_file = fopen(tmp_file, "w+");
+  if(!peercert_file)
+    {
+      msg (M_ERR, "Failed to open temporary file : %s", tmp_file);
+      return NULL;
+    }
+  if(PEM_write_X509(peercert_file,peercert)<0)
+    {
+      msg (M_ERR, "Failed to write peer certificate in PEM format");
+      fclose(peercert_file);
+      return NULL;
+    }
+  fclose(peercert_file);
+  return tmp_file;
+}
+
 /*
  * Our verify callback function -- check
  * that an incoming peer certificate is good.
@@ -552,11 +610,22 @@
   if (opt->verify_command)
     {
       char command[256];
+      const char *tmp_file;
       struct buffer out;
+      struct gc_arena gc;
       int ret;
 
       setenv_str (opt->es, "script_type", "tls-verify");
 
+      if (opt->verify_export_cert)
+        {
+	  gc = gc_new();
+	  if (tmp_file=get_peer_cert(ctx, opt->verify_export_cert,&gc))
+	    {
+	      setenv_str(opt->es, "peer_cert", tmp_file);
+	    }
+	}
+
       buf_set_write (&out, (uint8_t*)command, sizeof (command));
       buf_printf (&out, "%s %d %s",
 		  opt->verify_command,
@@ -565,6 +634,12 @@
       dmsg (D_TLS_DEBUG, "TLS: executing verify command: %s", command);
       ret = openvpn_system (command, opt->es, S_SCRIPT);
 
+      if (opt->verify_export_cert)
+        {
+	  delete_file(tmp_file);
+	  gc_free(&gc);
+	}	
+      
       if (system_ok (ret))
 	{
 	  msg (D_HANDSHAKE, "VERIFY SCRIPT OK: depth=%d, %s",
diff -ru openvpn-2.0.5/ssl.h openvpn-2.0.5-patch/ssl.h
--- openvpn-2.0.5/ssl.h	2005-12-05 14:44:42.000000000 +0100
+++ openvpn-2.0.5-patch/ssl.h	2005-12-05 15:13:47.000000000 +0100
@@ -407,6 +407,7 @@
 
   /* cert verification parms */
   const char *verify_command;
+  const char *verify_export_cert;
   const char *verify_x509name;
   const char *crl_file;
   int ns_cert_type;

--------------020000020207060904030309--

