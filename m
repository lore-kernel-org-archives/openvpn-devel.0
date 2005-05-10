Message-ID: <4280D0D7.3040908@...349...>
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040302030105090505010606"
Subject: [Openvpn-devel] Multiple CRLs : a patch for a "crl-verify-path" option
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
Date: Tue May 10 08:20:32 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040302030105090505010606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

As I said on "openvpn-users", OpenVPN can't handle multiple CRL. It's an 
issue when the PKI have multiple CAs, typically an offline root CA and 
intermediate CAs.

Attached is a patch for a "--crl-verify-path" option.

The idea is to follow the "openssl way of life" : each CRL is named 
"0a1b2c3d.r0" where 0a1b2c3d is the hash of the CA DN. Typically, on 
Unix systems, we builds symlinks to CRLs files with "c_rehash 
/path/to/crls/".

When OpenVPN must validate a certificate issued by "0a1b2c3d", 
"--crl-verify-path /etc/openvpn/crls/" will check for any 
0a1b2c3d.r{0,1,..,9} CRL file in the /etc/openvpn/crls/ directory.

If the CRL file and the certificate issuers are the same, then
OpenVPN normally check the CRL (as with --crl-file ...).

If no CRL file is found or no CRL file match the cert issuer, an error 
occured.

Thanks,
-- 
Thomas

--------------040302030105090505010606
Content-Type: text/x-patch;
 name="openvpn-crl-verify-path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-crl-verify-path.patch"

diff -Nru --exclude=debian --exclude='*win32*' --exclude=plugin openvpn-2.0.orig/init.c openvpn-2.0/init.c
--- openvpn-2.0.orig/init.c	2005-04-11 05:43:56.000000000 +0200
+++ openvpn-2.0/init.c	2005-05-10 16:23:11.000000000 +0200
@@ -1307,6 +1307,7 @@
   to.verify_command = options->tls_verify;
   to.verify_x509name = options->tls_remote;
   to.crl_file = options->crl_file;
+  to.crl_path = options->crl_path;
   to.ns_cert_type = options->ns_cert_type;
   to.es = c->c2.es;
 
diff -Nru --exclude=debian --exclude='*win32*' --exclude=plugin openvpn-2.0.orig/options.c openvpn-2.0/options.c
--- openvpn-2.0.orig/options.c	2005-04-17 00:03:15.000000000 +0200
+++ openvpn-2.0/options.c	2005-05-10 16:25:55.000000000 +0200
@@ -421,6 +421,9 @@
   "--askpass [file]: Get PEM password from controlling tty before we daemonize.\n"
   "--auth-nocache  : Don't cache --askpass or --auth-user-pass passwords.\n"
   "--crl-verify crl: Check peer certificate against a CRL.\n"
+  "--crl-verify-path path: Check peer certificate against a CRL directory.\n"
+  "                  This directory must contain all CRLs with their 'hashed'\n"
+  "                  name. path must have a trailing slash (/) on Unix system.\n"
   "--tls-verify cmd: Execute shell command cmd to verify the X509 name of a\n"
   "                  pending TLS connection that has otherwise passed all other\n"
   "                  tests of certification.  cmd should return 0 to allow\n"
@@ -1107,6 +1110,7 @@
   SHOW_STR (tls_verify);
   SHOW_STR (tls_remote);
   SHOW_STR (crl_file);
+  SHOW_STR (crl_path);
   SHOW_INT (ns_cert_type);
 
   SHOW_INT (tls_timeout);
@@ -1636,6 +1640,7 @@
       MUST_BE_UNDEF (single_session);
       MUST_BE_UNDEF (tls_exit);
       MUST_BE_UNDEF (crl_file);
+      MUST_BE_UNDEF (crl_path);
       MUST_BE_UNDEF (key_method);
       MUST_BE_UNDEF (ns_cert_type);
 
@@ -4348,6 +4353,12 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->crl_file = p[1];
     }
+  else if (streq (p[0], "crl-verify-path") && p[1])
+    {
+      ++i;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->crl_path = p[1];
+    }
   else if (streq (p[0], "tls-verify") && p[1])
     {
       ++i;
diff -Nru --exclude=debian --exclude='*win32*' --exclude=plugin openvpn-2.0.orig/options.h openvpn-2.0/options.h
--- openvpn-2.0.orig/options.h	2005-04-11 05:43:57.000000000 +0200
+++ openvpn-2.0/options.h	2005-05-10 16:22:44.000000000 +0200
@@ -364,6 +364,7 @@
   const char *tls_verify;
   const char *tls_remote;
   const char *crl_file;
+  const char *crl_path;
   int ns_cert_type; /* set to 0, NS_SSL_SERVER, or NS_SSL_CLIENT */
 #ifdef WIN32
   const char *cryptoapi_cert;
diff -Nru --exclude=debian --exclude='*win32*' --exclude=plugin openvpn-2.0.orig/ssl.c openvpn-2.0/ssl.c
--- openvpn-2.0.orig/ssl.c	2005-04-11 05:43:55.000000000 +0200
+++ openvpn-2.0/ssl.c	2005-05-10 16:55:33.000000000 +0200
@@ -620,6 +620,78 @@
 	goto err;
     }
 
+  if (opt->crl_path) {
+    unsigned long hash;
+    int r;
+    char crl_filename[256];
+    int is_revoked = 0;
+
+    hash = X509_NAME_hash(X509_get_issuer_name(ctx->current_cert));
+
+    for (r = 0 ; r < 10 /* FIXME: how many... ? */; r++) {
+      X509_CRL *crl=NULL;
+      X509_REVOKED *revoked;
+      BIO *in=NULL;
+      int n,i;
+
+      openvpn_snprintf(crl_filename, sizeof(crl_filename), "%s%8x.r%d", opt->crl_path, hash, r );
+      /* msg (D_HANDSHAKE, "VERIFY CRL: %s", crl_filename); // DEBUG */
+
+      in=BIO_new(BIO_s_file());
+
+      if (in == NULL) {
+	msg (M_WARN, "CRL: BIO err");
+	goto next;
+      }
+      if (BIO_read_filename(in, crl_filename) <= 0) {
+	msg (M_WARN, "CRL: cannot read: %s", crl_filename);
+	goto next;
+      }
+      crl=PEM_read_bio_X509_CRL(in,NULL,NULL,NULL);
+      if (crl == NULL) {
+	msg (M_WARN, "CRL: cannot read CRL from file %s", crl_filename);
+	goto next;
+      }
+
+      if (X509_NAME_cmp(X509_CRL_get_issuer(crl), X509_get_issuer_name(ctx->current_cert)) != 0) {
+	/* msg (M_WARN, "CRL: CRL %s is from a different issuer than the issuer of certificate %s", crl_filename, subject); */
+	goto next;
+      }
+
+      n = sk_num(X509_CRL_get_REVOKED(crl));
+
+      for (i = 0; i < n; i++) {
+	revoked = (X509_REVOKED *)sk_value(X509_CRL_get_REVOKED(crl), i);
+	if (ASN1_INTEGER_cmp(revoked->serialNumber, X509_get_serialNumber(ctx->current_cert)) == 0) {
+	  msg (D_HANDSHAKE, "CRL CHECK FAILED (%s): %s is REVOKED", crl_filename, subject);
+	  is_revoked = 1;
+	  goto err;
+	}
+      }
+
+      is_revoked = -1; 
+
+    next:
+
+      BIO_free(in);
+      if (crl)
+        X509_CRL_free (crl);
+      if (is_revoked == 1)
+        goto err;
+      else if (is_revoked == -1) {
+        msg (D_HANDSHAKE, "CRL CHECK OK (%s): %s", crl_filename, subject);
+	break;
+      }
+
+    } /* for */
+
+    if (is_revoked == 0) {
+      msg (D_HANDSHAKE, "CRL CHECK FAILED: no valid CRL found in %s for %s", opt->crl_path, subject);
+      goto err;
+    } 
+
+  }
+
   msg (D_HANDSHAKE, "VERIFY OK: depth=%d, %s", ctx->error_depth, subject);
 
   session->verified = true;
diff -Nru --exclude=debian --exclude='*win32*' --exclude=plugin openvpn-2.0.orig/ssl.h openvpn-2.0/ssl.h
--- openvpn-2.0.orig/ssl.h	2005-04-11 05:43:56.000000000 +0200
+++ openvpn-2.0/ssl.h	2005-05-10 16:22:57.000000000 +0200
@@ -409,6 +409,7 @@
   const char *verify_command;
   const char *verify_x509name;
   const char *crl_file;
+  const char *crl_path;
   int ns_cert_type;
 
   /* allow openvpn config info to be

--------------040302030105090505010606--

