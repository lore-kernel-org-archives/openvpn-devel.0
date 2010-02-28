From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 28 Feb 2010 14:59:42 +0100
Message-Id: <1267365582-13629-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] enhance tls-verify possibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

From: Mathieu GIANNECCHINI <mat.giann at>

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

X509=$2

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

This has been discussed here:
<http://thread.gmane.org/gmane.network.openvpn.devel/2492>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 init.c    |    1 +
 options.c |   10 ++++++++++
 options.h |    1 +
 ssl.c     |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ssl.h     |    1 +
 5 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/init.c b/init.c
index 3748c2e..19ac032 100644
--- a/init.c
+++ b/init.c
@@ -1805,6 +1805,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
 #endif
 
   to.verify_command = options->tls_verify;
+  to.verify_export_cert = options->tls_export_cert;
   to.verify_x509name = options->tls_remote;
   to.crl_file = options->crl_file;
   to.ns_cert_type = options->ns_cert_type;
diff --git a/options.c b/options.c
index 36b9913..e79f742 100644
--- a/options.c
+++ b/options.c
@@ -529,6 +529,9 @@ static const char usage_message[] =
   "                  tests of certification.  cmd should return 0 to allow\n"
   "                  TLS handshake to proceed, or 1 to fail.  (cmd is\n"
   "                  executed as 'cmd certificate_depth X509_NAME_oneline')\n"
+  "--tls-export-cert [directory] : Get peer cert in PEM format and store it \n"
+  "                  in an openvpn temporary file in [directory]. Peer cert is \n"
+  "                  stored before tls-verify script execution and deleted after.\n"
   "--tls-remote x509name: Accept connections only from a host with X509 name\n"
   "                  x509name. The remote host must also pass all other tests\n"
   "                  of verification.\n"
@@ -1325,6 +1328,7 @@ show_settings (const struct options *o)
 #endif
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
+  SHOW_STR (tls_export_cert);
   SHOW_STR (tls_remote);
   SHOW_STR (crl_file);
   SHOW_INT (ns_cert_type);
@@ -1914,6 +1918,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (pkcs12_file);
       MUST_BE_UNDEF (cipher_list);
       MUST_BE_UNDEF (tls_verify);
+      MUST_BE_UNDEF (tls_export_cert);
       MUST_BE_UNDEF (tls_remote);
       MUST_BE_UNDEF (tls_timeout);
       MUST_BE_UNDEF (renegotiate_bytes);
@@ -5525,6 +5530,11 @@ add_option (struct options *options,
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
diff --git a/options.h b/options.h
index 740e18e..a3114e2 100644
--- a/options.h
+++ b/options.h
@@ -440,6 +440,7 @@ struct options
   const char *pkcs12_file;
   const char *cipher_list;
   const char *tls_verify;
+  const char *tls_export_cert;
   const char *tls_remote;
   const char *crl_file;
 
diff --git a/ssl.c b/ssl.c
index 82e04a3..805e37d 100644
--- a/ssl.c
+++ b/ssl.c
@@ -687,6 +687,49 @@ string_mod_sslname (char *str, const unsigned int restrictive_flags, const unsig
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
@@ -885,10 +928,21 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
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
@@ -896,6 +950,12 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
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
diff --git a/ssl.h b/ssl.h
index 9737f26..a22c854 100644
--- a/ssl.h
+++ b/ssl.h
@@ -441,6 +441,7 @@ struct tls_options
 
   /* cert verification parms */
   const char *verify_command;
+  const char *verify_export_cert;
   const char *verify_x509name;
   const char *crl_file;
   int ns_cert_type;
-- 
1.6.6.1


