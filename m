From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:28:04 +0200
Message-Id: <1330547285-18481-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547285-18481-1-git-send-email-alon.barlev@...277...>
References: <1330547285-18481-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [easy-rsa 3/4] build: doc
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 Makefile.am         |    2 +-
 configure.ac        |    1 +
 doc/Makefile.am     |   16 ++++
 doc/README-1.0      |  161 ++++++++++++++++++++++++++++++++++++
 doc/README-2.0      |  229 +++++++++++++++++++++++++++++++++++++++++++++++++++
 easy-rsa/1.0/README |  161 ------------------------------------
 easy-rsa/2.0/README |  229 ---------------------------------------------------
 7 files changed, 408 insertions(+), 391 deletions(-)
 create mode 100644 doc/Makefile.am
 create mode 100644 doc/README-1.0
 create mode 100644 doc/README-2.0
 delete mode 100644 easy-rsa/1.0/README
 delete mode 100644 easy-rsa/2.0/README

diff --git a/Makefile.am b/Makefile.am
index f6433d5..743da35 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -33,7 +33,7 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/depcomp $(srcdir)/aclocal.m4 \
 	$(srcdir)/config.guess $(srcdir)/config.sub
 
-EXTRA_DIST = easy-rsa
+EXTRA_DIST = doc easy-rsa
 
 dist_doc_DATA = \
 	COPYRIGHT.GPL \
diff --git a/configure.ac b/configure.ac
index f9625e5..1e52ece 100644
--- a/configure.ac
+++ b/configure.ac
@@ -47,5 +47,6 @@ AC_SUBST([easyrsadir])
 
 AC_CONFIG_FILES([
 	Makefile
+	doc/Makefile
 ])
 AC_OUTPUT
diff --git a/doc/Makefile.am b/doc/Makefile.am
new file mode 100644
index 0000000..de183c6
--- /dev/null
+++ b/doc/Makefile.am
@@ -0,0 +1,16 @@
+#
+#  Easy-RSA -- This is a small RSA key management package, based on the openssl
+#              command line tool, that can be found in the easy-rsa subdirectory
+#              of the OpenVPN distribution.  While this tool is primary concerned
+#              with key management for the SSL VPN application space, it can also
+#              be used for building web certificates.
+#
+#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+dist_doc_DATA = README-2.0
+dist_noinst_DATA = README-1.0
diff --git a/doc/README-1.0 b/doc/README-1.0
new file mode 100644
index 0000000..fd424ef
--- /dev/null
+++ b/doc/README-1.0
@@ -0,0 +1,161 @@
+This is a small RSA key management package,
+based on the openssl command line tool, that
+can be found in the easy-rsa subdirectory
+of the OpenVPN distribution.
+
+These are reference notes.  For step
+by step instructions, see the HOWTO:
+
+http://openvpn.net/howto.html
+
+INSTALL
+
+1. Edit vars.
+2. Set KEY_CONFIG to point to the openssl.cnf file
+   included in this distribution.
+3. Set KEY_DIR to point to a directory which will
+   contain all keys, certificates, etc.  This
+   directory need not exist, and if it does,
+   it will be deleted with rm -rf, so BE
+   CAREFUL how you set KEY_DIR.
+4. (Optional) Edit other fields in vars
+   per your site data.  You may want to
+   increase KEY_SIZE to 2048 if you are
+   paranoid and don't mind slower key
+   processing, but certainly 1024 is
+   fine for testing purposes.  KEY_SIZE
+   must be compatible across both peers
+   participating in a secure SSL/TLS
+   connection.
+5  . vars
+6. ./clean-all
+7. As you create certificates, keys, and
+   certificate signing requests, understand that
+   only .key files should be kept confidential.
+   .crt and .csr files can be sent over insecure
+   channels such as plaintext email.
+8. You should never need to copy a .key file
+   between computers.  Normally each computer
+   will have its own certificate/key pair.
+
+BUILD YOUR OWN ROOT CERTIFICATE AUTHORITY (CA) CERTIFICATE/KEY
+
+1. ./build-ca
+2. ca.crt and ca.key will be built in your KEY_DIR
+   directory
+
+BUILD AN INTERMEDIATE CERTIFICATE AUTHORITY CERTIFICATE/KEY (optional)
+
+1. ./build-inter inter
+2. inter.crt and inter.key will be built in your KEY_DIR
+   directory and signed with your root certificate.
+
+BUILD DIFFIE-HELLMAN PARAMETERS (necessary for
+the server end of a SSL/TLS connection).
+
+1. ./build-dh
+
+BUILD A CERTIFICATE SIGNING REQUEST (If
+you want to sign your certificate with a root
+certificate controlled by another individual
+or organization, or residing on a different machine).
+
+1. Get ca.crt (the root certificate) from your
+   certificate authority.  Though this
+   transfer can be over an insecure channel, to prevent
+   man-in-the-middle attacks you must confirm that
+   ca.crt was not tampered with.  Large CAs solve this
+   problem by hardwiring their root certificates into
+   popular web browsers.  A simple way to verify a root
+   CA is to call the issuer on the telephone and confirm
+   that the md5sum or sha1sum signatures on the ca.crt
+   files match (such as with the command: "md5sum ca.crt").
+2. Choose a name for your certificate such as your computer
+   name.  In our example we will use "mycert".
+3. ./build-req mycert
+4. You can ignore most of the fields, but set
+   "Common Name" to something unique such as your
+   computer's host name.  Leave all password
+   fields blank, unless you want your private key
+   to be protected by password.  Using a password
+   is not required -- it will make your key more secure
+   but also more inconvenient to use, because you will
+   need to supply your password anytime the key is used.
+   NOTE: if you are using a password, use ./build-req-pass
+   instead of ./build-req
+5. Your key will be written to $KEY_DIR/mycert.key
+6. Your certificate signing request will be written to
+   to $KEY_DIR/mycert.csr
+7. Email mycert.csr to the individual or organization
+   which controls the root certificate.  This can be
+   done over an insecure channel.
+8. After the .csr file is signed by the root certificate
+   authority, you will receive a file mycert.crt
+   (your certificate).  Place mycert.crt in your
+   KEY_DIR directory.
+9. The combined files of mycert.crt, mycert.key,
+   and ca.crt can now be used to secure one end of
+   an SSL/TLS connection.
+
+SIGN A CERTIFICATE SIGNING REQUEST
+
+1. ./sign-req mycert
+2. mycert.crt will be built in your KEY_DIR
+   directory using mycert.csr and your root CA
+   file as input.
+
+BUILD AND SIGN A CERTIFICATE SIGNING REQUEST
+USING A LOCALLY INSTALLED ROOT CERTIFICATE/KEY -- this
+script generates and signs a certificate in one step,
+but it requires that the generated certificate and private
+key files be copied to the destination host over a
+secure channel.
+
+1. ./build-key mycert (no password protection)
+2. OR ./build-key-pass mycert (with password protection)
+3. OR ./build-key-pkcs12 mycert (PKCS #12 format)
+4. OR ./build-key-server mycert (with nsCertType=server)
+5. mycert.crt and mycert.key will be built in your
+   KEY_DIR directory, and mycert.crt will be signed
+   by your root CA. If ./build-key-pkcs12 was used a
+   mycert.p12 file will also be created including the
+   private key, certificate and the ca certificate.
+
+IMPORTANT
+
+To avoid a possible Man-in-the-Middle attack where an authorized
+client tries to connect to another client by impersonating the
+server, make sure to enforce some kind of server certificate
+verification by clients.  There are currently four different ways
+of accomplishing this, listed in the order of preference:
+
+(1) Build your server certificates with the build-key-server
+    script.  This will designate the certificate as a
+    server-only certificate by setting nsCertType=server.
+    Now add the following line to your client configuration:
+      
+    ns-cert-type server
+
+    This will block clients from connecting to any
+    server which lacks the nsCertType=server designation
+    in its certificate, even if the certificate has been
+    signed by the CA which is cited in the OpenVPN configuration
+    file (--ca directive).
+
+(2) Use the --tls-remote directive on the client to
+    accept/reject the server connection based on the common
+    name of the server certificate.
+
+(3) Use a --tls-verify script or plugin to accept/reject the
+    server connection based on a custom test of the server
+    certificate's embedded X509 subject details.
+
+(4) Sign server certificates with one CA and client certificates
+    with a different CA.  The client config "ca" directive should
+    reference the server-signing CA while the server config "ca"
+    directive should reference the client-signing CA.
+
+NOTES
+
+Show certificate fields:
+  openssl x509 -in cert.crt -text
diff --git a/doc/README-2.0 b/doc/README-2.0
new file mode 100644
index 0000000..6f5395c
--- /dev/null
+++ b/doc/README-2.0
@@ -0,0 +1,229 @@
+EASY-RSA Version 2.0-rc1
+
+This is a small RSA key management package, based on the openssl
+command line tool, that can be found in the easy-rsa subdirectory
+of the OpenVPN distribution.  While this tool is primary concerned
+with key management for the SSL VPN application space, it can also
+be used for building web certificates.
+
+These are reference notes.  For step-by-step instructions, see the
+HOWTO:
+
+http://openvpn.net/howto.html
+
+This package is based on the ./pkitool script.  Run ./pkitool
+without arguments for a detailed help message (which is also pasted
+below).
+
+Release Notes for easy-rsa-2.0
+
+* Most functionality has been consolidated into the pkitool
+  script. For compatibility, all previous scripts from 1.0 such
+  as build-key and build-key-server are provided as stubs
+  which call pkitool to do the real work.
+
+* pkitool has a --batch flag (enabled by default) which generates
+  keys/certs without needing any interactive input.  pkitool
+  can still generate certs/keys using interactive prompting by
+  using the --interact flag.
+
+* The inherit-inter script has been provided for creating
+  a new PKI rooted on an intermediate certificate built within a
+  higher-level PKI.  See comments in the inherit-inter script
+  for more info.
+
+* The openssl.cnf file has been modified.  pkitool will not
+  work with the openssl.cnf file included with previous
+  easy-rsa releases.
+
+* The vars file has been modified -- the following extra
+  variables have been added: EASY_RSA, CA_EXPIRE,
+  KEY_EXPIRE.
+
+* The make-crl and revoke-crt scripts have been removed and
+  are replaced by the revoke-full script.
+
+* The "Organizational Unit" X509 field can be set using
+  the KEY_OU environmental variable before calling pkitool.
+
+* This release only affects the Linux/Unix version of easy-rsa.
+  The Windows version (written to use the Windows shell) is unchanged.
+
+* Use the revoke-full script to revoke a certificate, and generate
+  (or update) the crl.pem file in the keys directory (as set by the
+  vars script).  Then use "crl-verify crl.pem" in your OpenVPN server
+  config file, so that OpenVPN can reject any connections coming from
+  clients which present a revoked certificate.  Usage for the script is:
+
+    revoke-full <common-name>
+
+  Note this this procedure is primarily designed to revoke client
+  certificates. You could theoretically use this method to revoke
+  server certificates as well, but then you would need to propagate
+  the crl.pem file to all clients as well, and have them include
+  "crl-verify crl.pem" in their configuration files.
+
+* PKCS#11 support was added.
+
+* For those interested in using this tool to generate web certificates,
+  A variant of the easy-rsa package that allows the creation of multi-domain
+  certificates with subjectAltName can be obtained from here:
+
+  http://www.bisente.com/proyectos/easy-rsa-subjectaltname/
+
+INSTALL easy-rsa
+
+1. Edit vars.
+2. Set KEY_CONFIG to point to the correct openssl-<version>.cnf
+   file included in this distribution.
+3. Set KEY_DIR to point to a directory which will
+   contain all keys, certificates, etc.  This
+   directory need not exist, and if it does,
+   it will be deleted with rm -rf, so BE
+   CAREFUL how you set KEY_DIR.
+4. (Optional) Edit other fields in vars
+   per your site data.  You may want to
+   increase KEY_SIZE to 2048 if you are
+   paranoid and don't mind slower key
+   processing, but certainly 1024 is
+   fine for testing purposes.  KEY_SIZE
+   must be compatible across both peers
+   participating in a secure SSL/TLS
+   connection.
+5. (Optional) If you intend to use PKCS#11,
+   install openssl >= 0.9.7, install the 
+   following components from www.opensc.org:
+   - opensc >= 0.10.0
+   - engine_pkcs11 >= 0.1.3
+   Update the openssl.cnf to load the engine:
+   - Uncomment pkcs11 under engine_section.
+   - Validate path at dynamic_path under pkcs11_section.
+6. . vars
+7. ./clean-all
+8. As you create certificates, keys, and
+   certificate signing requests, understand that
+   only .key files should be kept confidential.
+   .crt and .csr files can be sent over insecure
+   channels such as plaintext email.
+
+IMPORTANT
+
+To avoid a possible Man-in-the-Middle attack where an authorized
+client tries to connect to another client by impersonating the
+server, make sure to enforce some kind of server certificate
+verification by clients.  There are currently four different ways
+of accomplishing this, listed in the order of preference:
+
+(1) Build your server certificates with specific key usage and
+    extended key usage. The RFC3280 determine that the following
+    attributes should be provided for TLS connections:
+
+    Mode      Key usage	                         Extended key usage
+    ---------------------------------------------------------------------------
+    Client    digitalSignature	                 TLS Web Client Authentication
+              keyAgreement
+              digitalSignature, keyAgreement
+	      
+    Server    digitalSignature, keyEncipherment  TLS Web Server Authentication
+              digitalSignature, keyAgreement
+
+    Now add the following line to your client configuration:
+      
+    remote-cert-tls server
+
+    This will block clients from connecting to any
+    server which lacks the required extension designation
+    in its certificate, even if the certificate has been
+    signed by the CA which is cited in the OpenVPN configuration
+    file (--ca directive).
+
+(3) Use the --tls-remote directive on the client to
+    accept/reject the server connection based on the common
+    name of the server certificate.
+
+(3) Use a --tls-verify script or plugin to accept/reject the
+    server connection based on a custom test of the server
+    certificate's embedded X509 subject details.
+
+(4) Sign server certificates with one CA and client certificates
+    with a different CA.  The client config "ca" directive should
+    reference the server-signing CA while the server config "ca"
+    directive should reference the client-signing CA.
+
+NOTES
+
+Show certificate fields:
+  openssl x509 -in cert.crt -text
+
+PKITOOL documentation
+
+pkitool 2.0
+Usage: pkitool [options...] [common-name]
+Options:
+  --batch    : batch mode (default)
+  --keysize  : Set keysize
+      size   : size (default=1024)
+  --interact : interactive mode
+  --server   : build server cert
+  --initca   : build root CA
+  --inter    : build intermediate CA
+  --pass     : encrypt private key with password
+  --csr      : only generate a CSR, do not sign
+  --sign     : sign an existing CSR
+  --pkcs12   : generate a combined PKCS#12 file
+  --pkcs11   : generate certificate on PKCS#11 token
+      lib    : PKCS#11 library
+      slot   : PKCS#11 slot
+      id     : PKCS#11 object id (hex string)
+      label  : PKCS#11 object label
+Standalone options:
+  --pkcs11-slots   : list PKCS#11 slots
+      lib    : PKCS#11 library
+  --pkcs11-objects : list PKCS#11 token objects
+      lib    : PKCS#11 library
+      slot   : PKCS#11 slot
+  --pkcs11-init    : initialize PKCS#11 token DANGEROUS!!!
+      lib    : PKCS#11 library
+      slot   : PKCS#11 slot
+      label  : PKCS#11 token label
+Notes:
+  Please edit the vars script to reflect your configuration,
+  then source it with "source ./vars".
+  Next, to start with a fresh PKI configuration and to delete any
+  previous certificates and keys, run "./clean-all".
+  Finally, you can run this tool (pkitool) to build certificates/keys.
+  In order to use PKCS#11 interface you must have opensc-0.10.0 or higher.
+Generated files and corresponding OpenVPN directives:
+(Files will be placed in the $KEY_DIR directory, defined in ./vars)
+  ca.crt     -> root certificate (--ca)
+  ca.key     -> root key, keep secure (not directly used by OpenVPN)
+  .crt files -> client/server certificates (--cert)
+  .key files -> private keys, keep secure (--key)
+  .csr files -> certificate signing request (not directly used by OpenVPN)
+  dh1024.pem or dh2048.pem -> Diffie Hellman parameters (--dh)
+Examples:
+  pkitool --initca          -> Build root certificate
+  pkitool --initca --pass   -> Build root certificate with password-protected key
+  pkitool --server server1  -> Build "server1" certificate/key
+  pkitool client1           -> Build "client1" certificate/key
+  pkitool --pass client2    -> Build password-protected "client2" certificate/key
+  pkitool --pkcs12 client3  -> Build "client3" certificate/key in PKCS#12 format
+  pkitool --csr client4     -> Build "client4" CSR to be signed by another CA
+  pkitool --sign client4    -> Sign "client4" CSR
+  pkitool --inter interca   -> Build an intermediate key-signing certificate/key
+                               Also see ./inherit-inter script.
+  pkitool --pkcs11 /usr/lib/pkcs11/lib1 0 010203 "client5 id" client5
+                              -> Build "client5" certificate/key in PKCS#11 token
+Typical usage for initial PKI setup.  Build myserver, client1, and client2 cert/keys.
+Protect client2 key with a password.  Build DH parms.  Generated files in ./keys :
+  [edit vars with your site-specific info]
+  source ./vars
+  ./clean-all
+  ./build-dh     -> takes a long time, consider backgrounding
+  ./pkitool --initca
+  ./pkitool --server myserver
+  ./pkitool client1
+  ./pkitool --pass client2
+Typical usage for adding client cert to existing PKI:
+  source ./vars
+  ./pkitool client-new
diff --git a/easy-rsa/1.0/README b/easy-rsa/1.0/README
deleted file mode 100644
index fd424ef..0000000
--- a/easy-rsa/1.0/README
+++ /dev/null
@@ -1,161 +0,0 @@
-This is a small RSA key management package,
-based on the openssl command line tool, that
-can be found in the easy-rsa subdirectory
-of the OpenVPN distribution.
-
-These are reference notes.  For step
-by step instructions, see the HOWTO:
-
-http://openvpn.net/howto.html
-
-INSTALL
-
-1. Edit vars.
-2. Set KEY_CONFIG to point to the openssl.cnf file
-   included in this distribution.
-3. Set KEY_DIR to point to a directory which will
-   contain all keys, certificates, etc.  This
-   directory need not exist, and if it does,
-   it will be deleted with rm -rf, so BE
-   CAREFUL how you set KEY_DIR.
-4. (Optional) Edit other fields in vars
-   per your site data.  You may want to
-   increase KEY_SIZE to 2048 if you are
-   paranoid and don't mind slower key
-   processing, but certainly 1024 is
-   fine for testing purposes.  KEY_SIZE
-   must be compatible across both peers
-   participating in a secure SSL/TLS
-   connection.
-5  . vars
-6. ./clean-all
-7. As you create certificates, keys, and
-   certificate signing requests, understand that
-   only .key files should be kept confidential.
-   .crt and .csr files can be sent over insecure
-   channels such as plaintext email.
-8. You should never need to copy a .key file
-   between computers.  Normally each computer
-   will have its own certificate/key pair.
-
-BUILD YOUR OWN ROOT CERTIFICATE AUTHORITY (CA) CERTIFICATE/KEY
-
-1. ./build-ca
-2. ca.crt and ca.key will be built in your KEY_DIR
-   directory
-
-BUILD AN INTERMEDIATE CERTIFICATE AUTHORITY CERTIFICATE/KEY (optional)
-
-1. ./build-inter inter
-2. inter.crt and inter.key will be built in your KEY_DIR
-   directory and signed with your root certificate.
-
-BUILD DIFFIE-HELLMAN PARAMETERS (necessary for
-the server end of a SSL/TLS connection).
-
-1. ./build-dh
-
-BUILD A CERTIFICATE SIGNING REQUEST (If
-you want to sign your certificate with a root
-certificate controlled by another individual
-or organization, or residing on a different machine).
-
-1. Get ca.crt (the root certificate) from your
-   certificate authority.  Though this
-   transfer can be over an insecure channel, to prevent
-   man-in-the-middle attacks you must confirm that
-   ca.crt was not tampered with.  Large CAs solve this
-   problem by hardwiring their root certificates into
-   popular web browsers.  A simple way to verify a root
-   CA is to call the issuer on the telephone and confirm
-   that the md5sum or sha1sum signatures on the ca.crt
-   files match (such as with the command: "md5sum ca.crt").
-2. Choose a name for your certificate such as your computer
-   name.  In our example we will use "mycert".
-3. ./build-req mycert
-4. You can ignore most of the fields, but set
-   "Common Name" to something unique such as your
-   computer's host name.  Leave all password
-   fields blank, unless you want your private key
-   to be protected by password.  Using a password
-   is not required -- it will make your key more secure
-   but also more inconvenient to use, because you will
-   need to supply your password anytime the key is used.
-   NOTE: if you are using a password, use ./build-req-pass
-   instead of ./build-req
-5. Your key will be written to $KEY_DIR/mycert.key
-6. Your certificate signing request will be written to
-   to $KEY_DIR/mycert.csr
-7. Email mycert.csr to the individual or organization
-   which controls the root certificate.  This can be
-   done over an insecure channel.
-8. After the .csr file is signed by the root certificate
-   authority, you will receive a file mycert.crt
-   (your certificate).  Place mycert.crt in your
-   KEY_DIR directory.
-9. The combined files of mycert.crt, mycert.key,
-   and ca.crt can now be used to secure one end of
-   an SSL/TLS connection.
-
-SIGN A CERTIFICATE SIGNING REQUEST
-
-1. ./sign-req mycert
-2. mycert.crt will be built in your KEY_DIR
-   directory using mycert.csr and your root CA
-   file as input.
-
-BUILD AND SIGN A CERTIFICATE SIGNING REQUEST
-USING A LOCALLY INSTALLED ROOT CERTIFICATE/KEY -- this
-script generates and signs a certificate in one step,
-but it requires that the generated certificate and private
-key files be copied to the destination host over a
-secure channel.
-
-1. ./build-key mycert (no password protection)
-2. OR ./build-key-pass mycert (with password protection)
-3. OR ./build-key-pkcs12 mycert (PKCS #12 format)
-4. OR ./build-key-server mycert (with nsCertType=server)
-5. mycert.crt and mycert.key will be built in your
-   KEY_DIR directory, and mycert.crt will be signed
-   by your root CA. If ./build-key-pkcs12 was used a
-   mycert.p12 file will also be created including the
-   private key, certificate and the ca certificate.
-
-IMPORTANT
-
-To avoid a possible Man-in-the-Middle attack where an authorized
-client tries to connect to another client by impersonating the
-server, make sure to enforce some kind of server certificate
-verification by clients.  There are currently four different ways
-of accomplishing this, listed in the order of preference:
-
-(1) Build your server certificates with the build-key-server
-    script.  This will designate the certificate as a
-    server-only certificate by setting nsCertType=server.
-    Now add the following line to your client configuration:
-      
-    ns-cert-type server
-
-    This will block clients from connecting to any
-    server which lacks the nsCertType=server designation
-    in its certificate, even if the certificate has been
-    signed by the CA which is cited in the OpenVPN configuration
-    file (--ca directive).
-
-(2) Use the --tls-remote directive on the client to
-    accept/reject the server connection based on the common
-    name of the server certificate.
-
-(3) Use a --tls-verify script or plugin to accept/reject the
-    server connection based on a custom test of the server
-    certificate's embedded X509 subject details.
-
-(4) Sign server certificates with one CA and client certificates
-    with a different CA.  The client config "ca" directive should
-    reference the server-signing CA while the server config "ca"
-    directive should reference the client-signing CA.
-
-NOTES
-
-Show certificate fields:
-  openssl x509 -in cert.crt -text
diff --git a/easy-rsa/2.0/README b/easy-rsa/2.0/README
deleted file mode 100644
index 6f5395c..0000000
--- a/easy-rsa/2.0/README
+++ /dev/null
@@ -1,229 +0,0 @@
-EASY-RSA Version 2.0-rc1
-
-This is a small RSA key management package, based on the openssl
-command line tool, that can be found in the easy-rsa subdirectory
-of the OpenVPN distribution.  While this tool is primary concerned
-with key management for the SSL VPN application space, it can also
-be used for building web certificates.
-
-These are reference notes.  For step-by-step instructions, see the
-HOWTO:
-
-http://openvpn.net/howto.html
-
-This package is based on the ./pkitool script.  Run ./pkitool
-without arguments for a detailed help message (which is also pasted
-below).
-
-Release Notes for easy-rsa-2.0
-
-* Most functionality has been consolidated into the pkitool
-  script. For compatibility, all previous scripts from 1.0 such
-  as build-key and build-key-server are provided as stubs
-  which call pkitool to do the real work.
-
-* pkitool has a --batch flag (enabled by default) which generates
-  keys/certs without needing any interactive input.  pkitool
-  can still generate certs/keys using interactive prompting by
-  using the --interact flag.
-
-* The inherit-inter script has been provided for creating
-  a new PKI rooted on an intermediate certificate built within a
-  higher-level PKI.  See comments in the inherit-inter script
-  for more info.
-
-* The openssl.cnf file has been modified.  pkitool will not
-  work with the openssl.cnf file included with previous
-  easy-rsa releases.
-
-* The vars file has been modified -- the following extra
-  variables have been added: EASY_RSA, CA_EXPIRE,
-  KEY_EXPIRE.
-
-* The make-crl and revoke-crt scripts have been removed and
-  are replaced by the revoke-full script.
-
-* The "Organizational Unit" X509 field can be set using
-  the KEY_OU environmental variable before calling pkitool.
-
-* This release only affects the Linux/Unix version of easy-rsa.
-  The Windows version (written to use the Windows shell) is unchanged.
-
-* Use the revoke-full script to revoke a certificate, and generate
-  (or update) the crl.pem file in the keys directory (as set by the
-  vars script).  Then use "crl-verify crl.pem" in your OpenVPN server
-  config file, so that OpenVPN can reject any connections coming from
-  clients which present a revoked certificate.  Usage for the script is:
-
-    revoke-full <common-name>
-
-  Note this this procedure is primarily designed to revoke client
-  certificates. You could theoretically use this method to revoke
-  server certificates as well, but then you would need to propagate
-  the crl.pem file to all clients as well, and have them include
-  "crl-verify crl.pem" in their configuration files.
-
-* PKCS#11 support was added.
-
-* For those interested in using this tool to generate web certificates,
-  A variant of the easy-rsa package that allows the creation of multi-domain
-  certificates with subjectAltName can be obtained from here:
-
-  http://www.bisente.com/proyectos/easy-rsa-subjectaltname/
-
-INSTALL easy-rsa
-
-1. Edit vars.
-2. Set KEY_CONFIG to point to the correct openssl-<version>.cnf
-   file included in this distribution.
-3. Set KEY_DIR to point to a directory which will
-   contain all keys, certificates, etc.  This
-   directory need not exist, and if it does,
-   it will be deleted with rm -rf, so BE
-   CAREFUL how you set KEY_DIR.
-4. (Optional) Edit other fields in vars
-   per your site data.  You may want to
-   increase KEY_SIZE to 2048 if you are
-   paranoid and don't mind slower key
-   processing, but certainly 1024 is
-   fine for testing purposes.  KEY_SIZE
-   must be compatible across both peers
-   participating in a secure SSL/TLS
-   connection.
-5. (Optional) If you intend to use PKCS#11,
-   install openssl >= 0.9.7, install the 
-   following components from www.opensc.org:
-   - opensc >= 0.10.0
-   - engine_pkcs11 >= 0.1.3
-   Update the openssl.cnf to load the engine:
-   - Uncomment pkcs11 under engine_section.
-   - Validate path at dynamic_path under pkcs11_section.
-6. . vars
-7. ./clean-all
-8. As you create certificates, keys, and
-   certificate signing requests, understand that
-   only .key files should be kept confidential.
-   .crt and .csr files can be sent over insecure
-   channels such as plaintext email.
-
-IMPORTANT
-
-To avoid a possible Man-in-the-Middle attack where an authorized
-client tries to connect to another client by impersonating the
-server, make sure to enforce some kind of server certificate
-verification by clients.  There are currently four different ways
-of accomplishing this, listed in the order of preference:
-
-(1) Build your server certificates with specific key usage and
-    extended key usage. The RFC3280 determine that the following
-    attributes should be provided for TLS connections:
-
-    Mode      Key usage	                         Extended key usage
-    ---------------------------------------------------------------------------
-    Client    digitalSignature	                 TLS Web Client Authentication
-              keyAgreement
-              digitalSignature, keyAgreement
-	      
-    Server    digitalSignature, keyEncipherment  TLS Web Server Authentication
-              digitalSignature, keyAgreement
-
-    Now add the following line to your client configuration:
-      
-    remote-cert-tls server
-
-    This will block clients from connecting to any
-    server which lacks the required extension designation
-    in its certificate, even if the certificate has been
-    signed by the CA which is cited in the OpenVPN configuration
-    file (--ca directive).
-
-(3) Use the --tls-remote directive on the client to
-    accept/reject the server connection based on the common
-    name of the server certificate.
-
-(3) Use a --tls-verify script or plugin to accept/reject the
-    server connection based on a custom test of the server
-    certificate's embedded X509 subject details.
-
-(4) Sign server certificates with one CA and client certificates
-    with a different CA.  The client config "ca" directive should
-    reference the server-signing CA while the server config "ca"
-    directive should reference the client-signing CA.
-
-NOTES
-
-Show certificate fields:
-  openssl x509 -in cert.crt -text
-
-PKITOOL documentation
-
-pkitool 2.0
-Usage: pkitool [options...] [common-name]
-Options:
-  --batch    : batch mode (default)
-  --keysize  : Set keysize
-      size   : size (default=1024)
-  --interact : interactive mode
-  --server   : build server cert
-  --initca   : build root CA
-  --inter    : build intermediate CA
-  --pass     : encrypt private key with password
-  --csr      : only generate a CSR, do not sign
-  --sign     : sign an existing CSR
-  --pkcs12   : generate a combined PKCS#12 file
-  --pkcs11   : generate certificate on PKCS#11 token
-      lib    : PKCS#11 library
-      slot   : PKCS#11 slot
-      id     : PKCS#11 object id (hex string)
-      label  : PKCS#11 object label
-Standalone options:
-  --pkcs11-slots   : list PKCS#11 slots
-      lib    : PKCS#11 library
-  --pkcs11-objects : list PKCS#11 token objects
-      lib    : PKCS#11 library
-      slot   : PKCS#11 slot
-  --pkcs11-init    : initialize PKCS#11 token DANGEROUS!!!
-      lib    : PKCS#11 library
-      slot   : PKCS#11 slot
-      label  : PKCS#11 token label
-Notes:
-  Please edit the vars script to reflect your configuration,
-  then source it with "source ./vars".
-  Next, to start with a fresh PKI configuration and to delete any
-  previous certificates and keys, run "./clean-all".
-  Finally, you can run this tool (pkitool) to build certificates/keys.
-  In order to use PKCS#11 interface you must have opensc-0.10.0 or higher.
-Generated files and corresponding OpenVPN directives:
-(Files will be placed in the $KEY_DIR directory, defined in ./vars)
-  ca.crt     -> root certificate (--ca)
-  ca.key     -> root key, keep secure (not directly used by OpenVPN)
-  .crt files -> client/server certificates (--cert)
-  .key files -> private keys, keep secure (--key)
-  .csr files -> certificate signing request (not directly used by OpenVPN)
-  dh1024.pem or dh2048.pem -> Diffie Hellman parameters (--dh)
-Examples:
-  pkitool --initca          -> Build root certificate
-  pkitool --initca --pass   -> Build root certificate with password-protected key
-  pkitool --server server1  -> Build "server1" certificate/key
-  pkitool client1           -> Build "client1" certificate/key
-  pkitool --pass client2    -> Build password-protected "client2" certificate/key
-  pkitool --pkcs12 client3  -> Build "client3" certificate/key in PKCS#12 format
-  pkitool --csr client4     -> Build "client4" CSR to be signed by another CA
-  pkitool --sign client4    -> Sign "client4" CSR
-  pkitool --inter interca   -> Build an intermediate key-signing certificate/key
-                               Also see ./inherit-inter script.
-  pkitool --pkcs11 /usr/lib/pkcs11/lib1 0 010203 "client5 id" client5
-                              -> Build "client5" certificate/key in PKCS#11 token
-Typical usage for initial PKI setup.  Build myserver, client1, and client2 cert/keys.
-Protect client2 key with a password.  Build DH parms.  Generated files in ./keys :
-  [edit vars with your site-specific info]
-  source ./vars
-  ./clean-all
-  ./build-dh     -> takes a long time, consider backgrounding
-  ./pkitool --initca
-  ./pkitool --server myserver
-  ./pkitool client1
-  ./pkitool --pass client2
-Typical usage for adding client cert to existing PKI:
-  source ./vars
-  ./pkitool client-new
-- 
1.7.3.4


