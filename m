From: Stefano Bracalenti <stefano.bracalenti@...114...>
In-Reply-To: <002001c39485$2270b9c0$7781cf0a@...120...>
References: <002001c39485$2270b9c0$7781cf0a@...120...>
Content-Type: multipart/mixed; boundary="=-THhZe0dtO9K3hgrO8TXu"
Message-Id: <1066407794.3060.2.camel@...121...>
Mime-Version: 1.0
Subject: [Openvpn-devel] beta1.5_12 CRL
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Oct 17 19:02:13 2003
To: openvpn-devel@lists.sourceforge.net

--=-THhZe0dtO9K3hgrO8TXu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

If someone is interested, I wrote a little patch for check if a
certificate is revoked using a crl in PEM format generated from ca.
I added a --crl-verify "crl.pem" option to specify the crl filename.
It works for me ;)

Regards Stefano.


--=-THhZe0dtO9K3hgrO8TXu
Content-Disposition: attachment; filename=openvpn-crlcheck.diff
Content-Type: text/plain; name=openvpn-crlcheck.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naurp openvpn-1.5_beta12/openvpn.c openvpn-1.5_beta12.diff/openvpn.c
--- openvpn-1.5_beta12/openvpn.c	2003-10-11 05:35:44.000000000 +0200
+++ openvpn-1.5_beta12.diff/openvpn.c	2003-10-17 11:20:32.000000000 +0200
@@ -836,6 +836,10 @@ openvpn (const struct options *options,
       /* Let user specify a script to verify the incoming certificate */
       tls_set_verify_command (options->tls_verify);
 
+      /* Let user specify a crl to check the incoming certificate */
+      tls_set_crl_verify (options->crl_file);
+
+
       if (!ks->ssl_ctx)
 	{
 	  /*
diff -Naurp openvpn-1.5_beta12/options.c openvpn-1.5_beta12.diff/options.c
--- openvpn-1.5_beta12/options.c	2003-10-12 10:54:19.000000000 +0200
+++ openvpn-1.5_beta12.diff/options.c	2003-10-17 11:12:12.000000000 +0200
@@ -258,6 +258,7 @@ static const char usage_message[] =
   "                  control channel to protect against DoS attacks.\n"
   "                  f (required) is a shared-secret passphrase file.\n"
   "--askpass       : Get PEM password from controlling tty before we daemonize.\n"
+  "--crl-verify crl: Execute check of certificate against a CRL.\n"
   "--tls-verify cmd: Execute shell command cmd to verify the X509 name of a\n"
   "                  pending TLS connection that has otherwise passed all other\n"
   "                  tests of certification.  cmd should return 0 to allow\n"
@@ -1568,6 +1569,11 @@ add_option (struct options *options, int
       ++i;
       options->cipher_list = p[1];
     }
+  else if (streq (p[0], "crl-verify") && p[1])
+    {
+      ++i;
+      options->crl_file = p[1];
+    }
   else if (streq (p[0], "tls-verify") && p[1])
     {
       ++i;
diff -Naurp openvpn-1.5_beta12/options.h openvpn-1.5_beta12.diff/options.h
--- openvpn-1.5_beta12/options.h	2003-10-12 10:54:27.000000000 +0200
+++ openvpn-1.5_beta12.diff/options.h	2003-10-17 11:13:16.000000000 +0200
@@ -188,6 +188,7 @@ struct options
   const char *priv_key_file;
   const char *cipher_list;
   const char *tls_verify;
+  const char *crl_file;
 
   /* Per-packet timeout on control channel */
   int tls_timeout;
diff -Naurp openvpn-1.5_beta12/ssl.c openvpn-1.5_beta12.diff/ssl.c
--- openvpn-1.5_beta12/ssl.c	2003-10-11 05:35:44.000000000 +0200
+++ openvpn-1.5_beta12.diff/ssl.c	2003-10-17 14:24:15.000000000 +0200
@@ -266,6 +266,7 @@ tmp_rsa_cb (SSL * s, int is_export, int 
  */
 
 static const char *verify_command;
+static const char *crl_file;
 static int verify_maxlevel;
 
 void
@@ -274,6 +275,13 @@ tls_set_verify_command (const char *cmd)
   verify_command = cmd;
 }
 
+void
+tls_set_crl_verify (const char *crl)
+{
+  crl_file = crl;
+}
+
+
 int
 get_max_tls_verify_id ()
 {
@@ -324,7 +332,7 @@ verify_callback (int preverify_ok, X509_
 	{
 	  msg (D_HANDSHAKE, "VERIFY SCRIPT OK: depth=%d, %s",
 	       ctx->error_depth, txt);
-	  return 1;		/* Accept connection */
+	  //return 1;		/* Accept connection */
 	}
       else
 	{
@@ -335,11 +343,57 @@ verify_callback (int preverify_ok, X509_
 	  return 0;		/* Reject connection */
 	}
     }
-  else
-    {
+
+    if (crl_file)
+      {
+        X509_CRL *crl=NULL;
+        X509_REVOKED *revoked;
+        BIO *in=NULL;
+        int n,i,retval = 0;
+
+
+        in=BIO_new(BIO_s_file());
+
+        if (in == NULL) {
+		msg (M_ERR, "CRL BIO err");
+                goto end;
+	}
+        if (BIO_read_filename(in,crl_file) <= 0) {
+		msg (M_ERR, "CRL cannot read: %s",crl_file);
+                goto end;
+	}
+        crl=PEM_read_bio_X509_CRL(in,NULL,NULL,NULL);
+        if (crl == NULL) {
+		msg (M_ERR, "CRL cannot read crl from file %s",crl_file);
+                goto end;
+	}
+
+        n = sk_num(X509_CRL_get_REVOKED(crl));
+
+        for (i = 0; i < n; i++) {
+                revoked = (X509_REVOKED *)sk_value(X509_CRL_get_REVOKED(crl), i);
+                if (ASN1_INTEGER_cmp(revoked->serialNumber, X509_get_serialNumber(ctx->current_cert)) == 0) {
+                        msg (D_HANDSHAKE, "CRL CHECK FAILED: %s is REVOKED",txt);
+                        goto end;
+                        }
+        }
+
+	retval = 1;
+        msg (D_HANDSHAKE, "CRL CHECK OK: %s",txt);
+
+	end:
+
+        BIO_free(in);
+	if(!retval)
+		return retval;
+
+    }
+
+
+    if(!verify_command || !crl_file)
       msg (D_HANDSHAKE, "VERIFY OK: depth=%d, %s", ctx->error_depth, txt);
+
       return 1;			/* Accept connection */
-    }
 }
 
 /*

--=-THhZe0dtO9K3hgrO8TXu--


