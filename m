MIME-Version: 1.0
Sender: heikki.hannikainen@...277...
Date: Sat, 18 May 2013 14:53:51 +0300
Message-ID: <CAHqXQkNN_bf9G_SRefYTCu8EiVQCAaCZ3G+K4ppoXGTcN+1g4Q@...278...>
From: Heikki Hannikainen <hessu@...1822...>
Subject: [Openvpn-devel] [PATCH] pkcs12-additional-cas option to load
 CA+intermediate certs from both PKCS#12 and a --ca PEM file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I've set up a VPN service which authenticates users using certificates
provided by a 3rd party (which has manually authenticated the users
from paper documents and given out some 50k certs). Their tools allow
the end users to nicely export a PKCS#12 certificate which OpenVPN can
currently use out of the box. Grand!

The 3rd party does not give out server certificates, so my VPN server
uses a certificate signed by my own CA. Thus I need to pass my CA to
the VPN client using the --ca option.

Currently OpenVPN ignores CA and intermediate certificates inside the
PKCS#12 file if --ca is set. Without --ca it loads them. The problem
is that the 3rd party CA uses intermediate certificates, and rotates
them ~yearly without warning, so I need the client to load the
intermediates from PKCS#12. To get both client and server validation
working I need to load certs from both the PKCS#12 file and a PEM file
provided using --ca.

So, I added a client option 'pkcs12-additional-cas' to make the --ca
and pkcs12 CA certs additive, not exclusive either-or. Default
functionality is like before. Manual page updated, too.

Patch attached, feedback welcome. I'm not quite sure if the name of
the option (--pkcs12-additional-cas) is good.


---
 doc/openvpn.8             |   16 ++++++++++++++++
 src/openvpn/options.c     |   16 ++++++++++++++++
 src/openvpn/options.h     |    1 +
 src/openvpn/ssl.c         |    2 +-
 src/openvpn/ssl_openssl.c |    2 +-
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index cbfc107..c758776 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4225,6 +4225,22 @@ and
 Not available with PolarSSL.
 .\"*********************************************************
 .TP
+.B \-\-pkcs12-additional-cas
+Load trusted CA and intermediate certificates from both the PKCS #12
+file specified using
+.B \-\-pkcs12
+and an additional PEM file specified using
+.B \-\-ca.
+The default is to not load CA or intermediate certificates from a
+PKCS #12 file if
+.B \-\-ca
+is set. This option can be used when the PKCS #12 client certificate
+is provided by a different CA than the server certificate, and
+contains intermediate certificates required for successful client
+authentication, but does not contain the CA certificate used for signing
+the server's certificate.
+.\"*********************************************************
+.TP
 .B \-\-verify-hash hash
 Specify SHA1 fingerprint for level-1 cert.  The level-1 cert is the
 CA (or intermediate cert) that signs the leaf certificate, and is
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c5ed0d6..5175607 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -578,6 +578,10 @@ static const char usage_message[] =
 #ifndef ENABLE_CRYPTO_POLARSSL
   "--pkcs12 file   : PKCS#12 file containing local private key, local
certificate\n"
   "                  and optionally the root CA certificate.\n"
+  "--pkcs12-additional-cas : Load CA certificates from both the
PKCS#12 file and a\n"
+  "                          PEM file specified using --ca. Default
is to ignore\n"
+  "                          CAs and intermediate certificates
contained in the\n"
+  "                          PKCS#12 file if --ca is set.\n"
 #endif
 #ifdef ENABLE_X509ALTUSERNAME
   "--x509-username-field : Field used in x509 certificate to be username.\n"
@@ -1594,6 +1598,7 @@ show_settings (const struct options *o)
   SHOW_STR (priv_key_file);
 #ifndef ENABLE_CRYPTO_POLARSSL
   SHOW_STR (pkcs12_file);
+  SHOW_BOOL (pkcs12_additional_cas);
 #endif
 #ifdef ENABLE_CRYPTOAPI
   SHOW_STR (cryptoapi_cert);
@@ -2286,6 +2291,12 @@ options_postprocess_verify_ce (const struct
options *options, const struct conne
       notnull (options->priv_key_file, "private key file (--key) or
PKCS#12 file (--pkcs12)");
     }
  }
+
+      if (options->pkcs12_additional_cas && !options->ca_file &&
!options->pkcs12_file)
+        {
+          msg (M_USAGE, "When --pkcs12-additional-cas is set, CA
certificates are loaded from both a PEM file (--ca) and a PKCS#12 file
(--pkcs12). Both options must be specified.");
+        }
+
     }
   else
     {
@@ -6458,6 +6469,11 @@ add_option (struct options *options,
   options->pkcs12_file_inline = p[2];
  }
     }
+  else if (streq (p[0], "pkcs12-additional-cas"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->pkcs12_additional_cas = true;
+    }
 #endif /* ENABLE_CRYPTO_POLARSSL */
   else if (streq (p[0], "askpass"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d2ad94c..2f2fe8b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -504,6 +504,7 @@ struct options
   const char *extra_certs_file;
   const char *priv_key_file;
   const char *pkcs12_file;
+  bool pkcs12_additional_cas;
   const char *cipher_list;
   const char *tls_verify;
   int verify_x509_type;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 09cf300..e4457fd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -472,7 +472,7 @@ init_ssl (const struct options *options, struct
tls_root_ctx *new_ctx)
   if (options->pkcs12_file)
     {
       if (0 != tls_ctx_load_pkcs12(new_ctx, options->pkcs12_file,
-  options->pkcs12_file_inline, !options->ca_file))
+  options->pkcs12_file_inline, options->pkcs12_additional_cas ||
!options->ca_file))
         goto err;
     }
 #ifdef ENABLE_PKCS11

