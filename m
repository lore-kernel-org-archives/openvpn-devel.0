Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <BE248316-44A3-11D9-87C0-000393CC2E90@...124...>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-22--840647054"
From: Timo Sirainen <tss@...124...>
Content-Transfer-Encoding: 7bit
Subject: [Openvpn-devel] Keeping certs in config file
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
Date: Thu Dec  2 12:51:02 2004
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail-22--840647054
Content-Type: multipart/mixed; boundary=Apple-Mail-21--840647069

--Apple-Mail-21--840647069
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit

I'd like to keep everything an openvpn client needs in one 
configuration file, so it's easy to move around. Included a working 
implementation, but I could rewrite it to work some other way to get it 
included in main openvpn distribution.

Currently it works like:
ca \
"---- BEGIN CERT .. \
etc. \
--- END CERT .."

I hardcoded it as max. 10240 bytes for now. Buffers can't be grown 
dynamically?

--Apple-Mail-21--840647069
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0640;
	name="openvpn.diff"
Content-Disposition: attachment;
	filename=openvpn.diff

diff -ru openvpn-2.0_beta15-orig/options.c openvpn-2.0_beta15/options.c
--- openvpn-2.0_beta15-orig/options.c	2004-10-28 10:09:17.000000000 +0300
+++ openvpn-2.0_beta15/options.c	2004-12-02 22:18:09.000000000 +0200
@@ -1901,7 +1901,7 @@
   bool backslash = false;
   char in, out;
 
-  char parm[256];
+  char parm[10240];
   unsigned int parm_len = 0;
 
   do
@@ -2028,6 +2028,7 @@
 		  struct env_set *es)
 {
   const int max_recursive_levels = 10;
+  struct buffer full_line = alloc_buf (10240);
   FILE *fp;
   int line_num;
   char line[256];
@@ -2044,16 +2045,47 @@
   while (fgets(line, sizeof (line), fp))
     {
       char *p[MAX_PARMS];
-      CLEAR (p);
+      int len = strlen(line);
+
+      if (len > 0 && line[len-1] == '\n')
+	len--;
+      if (len > 0 && line[len-1] == '\r')
+	len--;
+
       ++line_num;
-      if (parse_line (line, p, SIZE (p), file, line_num, msglevel, &options->gc))
+      if (len > 0 && line[len-1] == '\\')
 	{
-	  if (strlen (p[0]) >= 3 && !strncmp (p[0], "--", 2))
-	    p[0] += 2;
-	  add_option (options, 0, p, file, line_num, level, msglevel, permission_mask, option_types_found, es);
+	  /* multiline value */
+	  if (!buf_write(&full_line, line, len - 1) ||
+	      !buf_write(&full_line, "\n", 1))
+	    msg (M_ERR, "In %s:%d: Multiline value is too large", top_file, top_line);
+	}
+      else
+	{
+	  char *pline;
+
+	  CLEAR (p);
+	  if (BLEN(&full_line) == 0)
+	    pline = line;
+	  else
+	    {
+	      if (!buf_write(&full_line, line, len) ||
+		  !buf_write(&full_line, "\n", 2))
+		msg (M_ERR, "In %s:%d: Multiline value is too large", top_file, top_line);
+	      pline = BSTR(&full_line);
+	    }
+
+	  if (parse_line (pline, p, SIZE (p), file, line_num, msglevel, &options->gc))
+	    {
+	      if (strlen (p[0]) >= 3 && !strncmp (p[0], "--", 2))
+		p[0] += 2;
+	      add_option (options, 0, p, file, line_num, level, msglevel, permission_mask, option_types_found, es);
+	    }
+          buf_init(&full_line, 0);
 	}
     }
   fclose (fp);
+  free_buf(&full_line);
 }
 
 void
diff -ru openvpn-2.0_beta15-orig/ssl.c openvpn-2.0_beta15/ssl.c
--- openvpn-2.0_beta15-orig/ssl.c	2004-10-28 04:41:30.000000000 +0300
+++ openvpn-2.0_beta15/ssl.c	2004-12-02 22:27:31.000000000 +0200
@@ -745,20 +745,58 @@
 	  /* Load Certificate */
 	  if (options->cert_file)
 	    {
-	      if (!SSL_CTX_use_certificate_file (ctx, options->cert_file, SSL_FILETYPE_PEM))
-		msg (M_SSLERR, "Cannot load certificate file %s", options->cert_file);
+	      if (strchr (options->cert_file, '\n') == NULL)
+		{
+		  if (!SSL_CTX_use_certificate_file (ctx, options->cert_file, SSL_FILETYPE_PEM))
+		    msg (M_SSLERR, "Cannot load certificate file %s", options->cert_file);
+
+		  /* Enable the use of certificate chains */
+		  if (!SSL_CTX_use_certificate_chain_file (ctx, options->cert_file))
+		    msg (M_SSLERR, "Cannot load certificate chain file %s (SSL_use_certificate_chain_file)", options->cert_file);
+		}
+	      else
+		{
+		  BIO *bio;
+                  X509 *x509;
 
-	      /* Enable the use of certificate chains */
-	      if (!SSL_CTX_use_certificate_chain_file (ctx, options->cert_file))
-		msg (M_SSLERR, "Cannot load certificate chain file %s (SSL_use_certificate_chain_file)", options->cert_file);
+		  bio = BIO_new_mem_buf ((void *)options->cert_file, strlen(options->cert_file));
+		  x509 = PEM_read_bio_X509 (bio, NULL, NULL, NULL);
+		  BIO_free (bio);
+
+		  if (x509 == NULL)
+		    msg (M_SSLERR, "Cannot parse given certificate");
+
+		  if (!SSL_CTX_use_certificate (ctx, x509))
+		    msg (M_SSLERR, "Cannot use given certificate");
+                  X509_free (x509);
+		}
 	    }
 
 	  /* Load Private Key */
 	  if (options->priv_key_file)
 	    {
-	      if (!SSL_CTX_use_PrivateKey_file (ctx, options->priv_key_file, SSL_FILETYPE_PEM))
-		msg (M_SSLERR, "Cannot load private key file %s", options->priv_key_file);
-	      warn_if_group_others_accessible (options->priv_key_file);
+	      if (strchr (options->priv_key_file, '\n') == NULL)
+		{
+		  if (!SSL_CTX_use_PrivateKey_file (ctx, options->priv_key_file, SSL_FILETYPE_PEM))
+		    msg (M_SSLERR, "Cannot load private key file %s", options->priv_key_file);
+		  warn_if_group_others_accessible (options->priv_key_file);
+		}
+	      else
+		{
+		  BIO *bio;
+                  EVP_PKEY *pkey;
+
+		  bio = BIO_new_mem_buf ((void *)options->priv_key_file, strlen(options->priv_key_file));
+		  pkey = PEM_read_bio_PrivateKey (bio, NULL, NULL, NULL);
+		  BIO_free (bio);
+
+		  if (pkey == NULL)
+		    msg (M_SSLERR, "Cannot parse given private key");
+
+		  if (!SSL_CTX_use_PrivateKey (ctx, pkey))
+		    msg (M_SSLERR, "Cannot use given private key");
+                  EVP_PKEY_free (pkey);
+		}
 
 	      /* Check Private Key */
 	      if (!SSL_CTX_check_private_key (ctx))
@@ -768,18 +806,35 @@
 
       /* Load CA file for verifying peer supplied certificate */
       ASSERT (options->ca_file);
-      if (!SSL_CTX_load_verify_locations (ctx, options->ca_file, NULL))
-        msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_CTX_load_verify_locations)", options->ca_file);
-
-      /* Load names of CAs from file and use it as a client CA list */
-      {
-        STACK_OF(X509_NAME) *cert_names;
-        cert_names = SSL_load_client_CA_file (options->ca_file);
-        if (!cert_names)
-          msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_load_client_CA_file)", options->ca_file);
-        SSL_CTX_set_client_CA_list (ctx, cert_names);
-      }
+      if (strchr (options->ca_file, '\n') == NULL)
+	{
+	  if (!SSL_CTX_load_verify_locations (ctx, options->ca_file, NULL))
+	    msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_CTX_load_verify_locations)", options->ca_file);
+	  /* Load names of CAs from file and use it as a client CA list */
+	  {
+	    STACK_OF(X509_NAME) *cert_names;
+	    cert_names = SSL_load_client_CA_file (options->ca_file);
+	    if (!cert_names)
+	      msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_load_client_CA_file)", options->ca_file);
+	    SSL_CTX_set_client_CA_list (ctx, cert_names);
+	  }
+	}
+      else
+	{
+	  BIO *bio;
+	  X509 *x509;
 
+	  bio = BIO_new_mem_buf ((void *)options->ca_file, strlen(options->ca_file));
+	  x509 = PEM_read_bio_X509 (bio, NULL, NULL, NULL);
+	  BIO_free (bio);
+
+	  if (x509 == NULL)
+	    msg (M_SSLERR, "Cannot parse given CA certificate");
+
+	  if (!SSL_CTX_add_client_CA (ctx, x509))
+	    msg (M_SSLERR, "Cannot use given CA certificate");
+	  X509_free (x509);
+	}
     }
 
   /* Require peer certificate verification */

--Apple-Mail-21--840647069--

--Apple-Mail-22--840647054
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFBr3/8yUhSUUBViskRAv4NAJwIjo+euy/5JGiiuoXE2Yjx8kS0igCfQ3lV
OdOLVjA93pIRw9N8HKvSx/M=
=Qo6E
-----END PGP SIGNATURE-----

--Apple-Mail-22--840647054--


