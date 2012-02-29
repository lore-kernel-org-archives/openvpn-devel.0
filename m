From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:48 +0200
Message-Id: <1330546342-17794-19-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 18/52] Remove easy-rsa
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
 Makefile.am                                |    1 -
 easy-rsa/1.0/README                        |  161 ------------
 easy-rsa/1.0/build-ca                      |   13 -
 easy-rsa/1.0/build-dh                      |   12 -
 easy-rsa/1.0/build-inter                   |   19 --
 easy-rsa/1.0/build-key                     |   20 --
 easy-rsa/1.0/build-key-pass                |   20 --
 easy-rsa/1.0/build-key-pkcs12              |   21 --
 easy-rsa/1.0/build-key-server              |   22 --
 easy-rsa/1.0/build-req                     |   18 --
 easy-rsa/1.0/build-req-pass                |   18 --
 easy-rsa/1.0/clean-all                     |   19 --
 easy-rsa/1.0/list-crl                      |   18 --
 easy-rsa/1.0/make-crl                      |   18 --
 easy-rsa/1.0/openssl.cnf                   |  255 -------------------
 easy-rsa/1.0/revoke-crt                    |   18 --
 easy-rsa/1.0/revoke-full                   |   29 ---
 easy-rsa/1.0/sign-req                      |   18 --
 easy-rsa/1.0/vars                          |   49 ----
 easy-rsa/2.0/Makefile                      |   13 -
 easy-rsa/2.0/README                        |  229 -----------------
 easy-rsa/2.0/build-ca                      |    8 -
 easy-rsa/2.0/build-dh                      |   11 -
 easy-rsa/2.0/build-inter                   |    7 -
 easy-rsa/2.0/build-key                     |    7 -
 easy-rsa/2.0/build-key-pass                |    7 -
 easy-rsa/2.0/build-key-pkcs12              |    8 -
 easy-rsa/2.0/build-key-server              |   10 -
 easy-rsa/2.0/build-req                     |    7 -
 easy-rsa/2.0/build-req-pass                |    7 -
 easy-rsa/2.0/clean-all                     |   16 --
 easy-rsa/2.0/inherit-inter                 |   39 ---
 easy-rsa/2.0/list-crl                      |   13 -
 easy-rsa/2.0/openssl-0.9.6.cnf             |  265 -------------------
 easy-rsa/2.0/openssl-0.9.8.cnf             |  290 ---------------------
 easy-rsa/2.0/openssl-1.0.0.cnf             |  285 ---------------------
 easy-rsa/2.0/pkitool                       |  379 ----------------------------
 easy-rsa/2.0/revoke-full                   |   40 ---
 easy-rsa/2.0/sign-req                      |    7 -
 easy-rsa/2.0/vars                          |   74 ------
 easy-rsa/2.0/whichopensslcnf               |   26 --
 easy-rsa/Windows/README.txt                |   44 ----
 easy-rsa/Windows/build-ca-pass.bat         |    8 -
 easy-rsa/Windows/build-ca.bat              |    4 -
 easy-rsa/Windows/build-dh.bat              |    4 -
 easy-rsa/Windows/build-key-pass.bat        |    8 -
 easy-rsa/Windows/build-key-pkcs12.bat      |   10 -
 easy-rsa/Windows/build-key-server-pass.bat |    8 -
 easy-rsa/Windows/build-key-server.bat      |    8 -
 easy-rsa/Windows/build-key.bat             |    8 -
 easy-rsa/Windows/clean-all.bat             |   13 -
 easy-rsa/Windows/init-config.bat           |    1 -
 easy-rsa/Windows/revoke-full.bat           |   13 -
 easy-rsa/Windows/serial.start              |    1 -
 easy-rsa/Windows/vars.bat.sample           |   40 ---
 openvpn.spec.in                            |    2 +-
 56 files changed, 1 insertions(+), 2668 deletions(-)
 delete mode 100644 easy-rsa/1.0/README
 delete mode 100755 easy-rsa/1.0/build-ca
 delete mode 100755 easy-rsa/1.0/build-dh
 delete mode 100755 easy-rsa/1.0/build-inter
 delete mode 100755 easy-rsa/1.0/build-key
 delete mode 100755 easy-rsa/1.0/build-key-pass
 delete mode 100755 easy-rsa/1.0/build-key-pkcs12
 delete mode 100755 easy-rsa/1.0/build-key-server
 delete mode 100755 easy-rsa/1.0/build-req
 delete mode 100755 easy-rsa/1.0/build-req-pass
 delete mode 100755 easy-rsa/1.0/clean-all
 delete mode 100644 easy-rsa/1.0/list-crl
 delete mode 100644 easy-rsa/1.0/make-crl
 delete mode 100644 easy-rsa/1.0/openssl.cnf
 delete mode 100644 easy-rsa/1.0/revoke-crt
 delete mode 100755 easy-rsa/1.0/revoke-full
 delete mode 100755 easy-rsa/1.0/sign-req
 delete mode 100644 easy-rsa/1.0/vars
 delete mode 100644 easy-rsa/2.0/Makefile
 delete mode 100644 easy-rsa/2.0/README
 delete mode 100755 easy-rsa/2.0/build-ca
 delete mode 100755 easy-rsa/2.0/build-dh
 delete mode 100755 easy-rsa/2.0/build-inter
 delete mode 100755 easy-rsa/2.0/build-key
 delete mode 100755 easy-rsa/2.0/build-key-pass
 delete mode 100755 easy-rsa/2.0/build-key-pkcs12
 delete mode 100755 easy-rsa/2.0/build-key-server
 delete mode 100755 easy-rsa/2.0/build-req
 delete mode 100755 easy-rsa/2.0/build-req-pass
 delete mode 100755 easy-rsa/2.0/clean-all
 delete mode 100755 easy-rsa/2.0/inherit-inter
 delete mode 100755 easy-rsa/2.0/list-crl
 delete mode 100755 easy-rsa/2.0/openssl-0.9.6.cnf
 delete mode 100755 easy-rsa/2.0/openssl-0.9.8.cnf
 delete mode 100755 easy-rsa/2.0/openssl-1.0.0.cnf
 delete mode 100755 easy-rsa/2.0/pkitool
 delete mode 100755 easy-rsa/2.0/revoke-full
 delete mode 100755 easy-rsa/2.0/sign-req
 delete mode 100755 easy-rsa/2.0/vars
 delete mode 100755 easy-rsa/2.0/whichopensslcnf
 delete mode 100644 easy-rsa/Windows/README.txt
 delete mode 100644 easy-rsa/Windows/build-ca-pass.bat
 delete mode 100644 easy-rsa/Windows/build-ca.bat
 delete mode 100644 easy-rsa/Windows/build-dh.bat
 delete mode 100644 easy-rsa/Windows/build-key-pass.bat
 delete mode 100644 easy-rsa/Windows/build-key-pkcs12.bat
 delete mode 100644 easy-rsa/Windows/build-key-server-pass.bat
 delete mode 100644 easy-rsa/Windows/build-key-server.bat
 delete mode 100644 easy-rsa/Windows/build-key.bat
 delete mode 100644 easy-rsa/Windows/clean-all.bat
 delete mode 100644 easy-rsa/Windows/index.txt.start
 delete mode 100755 easy-rsa/Windows/init-config.bat
 delete mode 100644 easy-rsa/Windows/revoke-full.bat
 delete mode 100644 easy-rsa/Windows/serial.start
 delete mode 100644 easy-rsa/Windows/vars.bat.sample

diff --git a/Makefile.am b/Makefile.am
index 33c4545..b6fcfbb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -40,7 +40,6 @@ MAINTAINERCLEANFILES = \
 CLEANFILES = openvpn.8.html configure.h
 
 EXTRA_DIST = \
-	easy-rsa \
 	sample-config-files \
 	sample-keys \
 	sample-scripts \
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
diff --git a/easy-rsa/1.0/build-ca b/easy-rsa/1.0/build-ca
deleted file mode 100755
index 5ad59cc..0000000
--- a/easy-rsa/1.0/build-ca
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/sh
-
-#
-# Build a root certificate
-#
-
-if test $KEY_DIR; then
-	cd $KEY_DIR && \
-	openssl req -days 3650 -nodes -new -x509 -keyout ca.key -out ca.crt -config $KEY_CONFIG && \
-        chmod 0600 ca.key
-else
-	echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/build-dh b/easy-rsa/1.0/build-dh
deleted file mode 100755
index 6de4baf..0000000
--- a/easy-rsa/1.0/build-dh
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/bin/sh
-
-#
-# Build Diffie-Hellman parameters for the server side
-# of an SSL/TLS connection.
-#
-
-if test $KEY_DIR; then
-    openssl dhparam -out ${KEY_DIR}/dh${KEY_SIZE}.pem ${KEY_SIZE}
-else
-    echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/build-inter b/easy-rsa/1.0/build-inter
deleted file mode 100755
index 8b3a6b2..0000000
--- a/easy-rsa/1.0/build-inter
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/sh
-
-#
-# Make an intermediate CA certificate/private key pair using a locally generated
-# root certificate.
-#
-
-if test $# -ne 1; then
-        echo "usage: build-inter <name>";
-        exit 1
-fi                                                                             
-
-if test $KEY_DIR; then
-	cd $KEY_DIR && \
-	openssl req -days 3650 -nodes -new -keyout $1.key -out $1.csr -config $KEY_CONFIG && \
-	openssl ca -extensions v3_ca -days 3650 -out $1.crt -in $1.csr -config $KEY_CONFIG
-else
-	echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/build-key b/easy-rsa/1.0/build-key
deleted file mode 100755
index 3159d2b..0000000
--- a/easy-rsa/1.0/build-key
+++ /dev/null
@@ -1,20 +0,0 @@
-#!/bin/sh
-
-#
-# Make a certificate/private key pair using a locally generated
-# root certificate.
-#
-
-if test $# -ne 1; then
-        echo "usage: build-key <name>";
-        exit 1
-fi                                                                             
-
-if test $KEY_DIR; then
-	cd $KEY_DIR && \
-	openssl req -days 3650 -nodes -new -keyout $1.key -out $1.csr -config $KEY_CONFIG && \
-	openssl ca -days 3650 -out $1.crt -in $1.csr -config $KEY_CONFIG && \
-	chmod 0600 $1.key
-else
-	echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/build-key-pass b/easy-rsa/1.0/build-key-pass
deleted file mode 100755
index 03ab304..0000000
--- a/easy-rsa/1.0/build-key-pass
+++ /dev/null
@@ -1,20 +0,0 @@
-#!/bin/sh
-
-#
-# Similar to build-key, but protect the private key
-# with a password.
-#
-
-if test $# -ne 1; then
-        echo "usage: build-key-pass <name>";
-        exit 1
-fi
-
-if test $KEY_DIR; then
-	cd $KEY_DIR && \
-	openssl req -days 3650 -new -keyout $1.key -out $1.csr -config $KEY_CONFIG && \
-	openssl ca -days 3650 -out $1.crt -in $1.csr -config $KEY_CONFIG && \
-	chmod 0600 $1.key
-else
-	echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/build-key-pkcs12 b/easy-rsa/1.0/build-key-pkcs12
deleted file mode 100755
index f8a057b..0000000
--- a/easy-rsa/1.0/build-key-pkcs12
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/bin/sh
-
-#
-# Make a certificate/private key pair using a locally generated
-# root certificate and convert it to a PKCS #12 file including the
-# the CA certificate as well.
-
-if test $# -ne 1; then
-        echo "usage: build-key-pkcs12 <name>";
-        exit 1
-fi                                                                             
-
-if test $KEY_DIR; then
-	cd $KEY_DIR && \
-	openssl req -days 3650 -nodes -new -keyout $1.key -out $1.csr -config $KEY_CONFIG && \
-	openssl ca -days 3650 -out $1.crt -in $1.csr -config $KEY_CONFIG && \
-        openssl pkcs12 -export -inkey $1.key -in $1.crt -certfile ca.crt -out $1.p12 && \
-	chmod 0600 $1.key $1.p12
-else
-	echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/build-key-server b/easy-rsa/1.0/build-key-server
deleted file mode 100755
index 30dc41e..0000000
--- a/easy-rsa/1.0/build-key-server
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-
-#
-# Make a certificate/private key pair using a locally generated
-# root certificate.
-#
-# Explicitly set nsCertType to server using the "server"
-# extension in the openssl.cnf file.
-
-if test $# -ne 1; then
-        echo "usage: build-key-server <name>";
-        exit 1
-fi                                                                             
-
-if test $KEY_DIR; then
-	cd $KEY_DIR && \
-	openssl req -days 3650 -nodes -new -keyout $1.key -out $1.csr -extensions server -config $KEY_CONFIG && \
-	openssl ca -days 3650 -out $1.crt -in $1.csr -extensions server -config $KEY_CONFIG && \
-        chmod 0600 $1.key
-else
-	echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/build-req b/easy-rsa/1.0/build-req
deleted file mode 100755
index 30f62f5..0000000
--- a/easy-rsa/1.0/build-req
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-#
-# Build a certificate signing request and private key.  Use this
-# when your root certificate and key is not available locally.
-#
-
-if test $# -ne 1; then
-    echo "usage: build-req <name>";
-    exit 1
-fi                                                                             
-
-if test $KEY_DIR; then
-    cd $KEY_DIR && \
-    openssl req -days 3650 -nodes -new -keyout $1.key -out $1.csr -config $KEY_CONFIG
-else
-    echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/build-req-pass b/easy-rsa/1.0/build-req-pass
deleted file mode 100755
index 829b286..0000000
--- a/easy-rsa/1.0/build-req-pass
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-#
-# Like build-req, but protect your private key
-# with a password.
-#
-
-if test $# -ne 1; then
-    echo "usage: build-req-pass <name>";
-    exit 1
-fi                                                                             
-
-if test $KEY_DIR; then
-    cd $KEY_DIR && \
-    openssl req -days 3650 -new -keyout $1.key -out $1.csr -config $KEY_CONFIG
-else
-    echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/clean-all b/easy-rsa/1.0/clean-all
deleted file mode 100755
index d10aef5..0000000
--- a/easy-rsa/1.0/clean-all
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/sh
-
-#
-# Initialize the $KEY_DIR directory.
-# Note that this script does a
-# rm -rf on $KEY_DIR so be careful!
-#
-
-d=$KEY_DIR
-
-if test $d; then
-	rm -rf $d
-	mkdir $d && \
-	chmod go-rwx $d && \
-	touch $d/index.txt && \
-	echo 01 >$d/serial
-else
-	echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/list-crl b/easy-rsa/1.0/list-crl
deleted file mode 100644
index b214dbd..0000000
--- a/easy-rsa/1.0/list-crl
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-#
-# list revoked certificates
-#
-#
-
-if test $# -ne 1; then
-        echo "usage: list-crl <crlfile.pem>";
-        exit 1
-fi
-
-if test $KEY_DIR; then
-       cd $KEY_DIR && \
-       openssl crl -text -noout -in $1
-else
-       echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/make-crl b/easy-rsa/1.0/make-crl
deleted file mode 100644
index 62fe6c1..0000000
--- a/easy-rsa/1.0/make-crl
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-#
-# generate a CRL
-#
-#
-
-if test $# -ne 1; then
-        echo "usage: make-crl <crlfile.pem>";
-        exit 1
-fi
-
-if test $KEY_DIR; then
-       cd $KEY_DIR && \
-       openssl ca -gencrl -out $1 -config $KEY_CONFIG
-else
-       echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/openssl.cnf b/easy-rsa/1.0/openssl.cnf
deleted file mode 100644
index 270b069..0000000
--- a/easy-rsa/1.0/openssl.cnf
+++ /dev/null
@@ -1,255 +0,0 @@
-#
-# OpenSSL example configuration file.
-# This is mostly being used for generation of certificate requests.
-#
-
-# This definition stops the following lines choking if HOME isn't
-# defined.
-HOME			= .
-RANDFILE		= $ENV::HOME/.rnd
-
-# Extra OBJECT IDENTIFIER info:
-#oid_file		= $ENV::HOME/.oid
-oid_section		= new_oids
-
-# To use this configuration file with the "-extfile" option of the
-# "openssl x509" utility, name here the section containing the
-# X.509v3 extensions to use:
-# extensions		= 
-# (Alternatively, use a configuration file that has only
-# X.509v3 extensions in its main [= default] section.)
-
-[ new_oids ]
-
-# We can add new OIDs in here for use by 'ca' and 'req'.
-# Add a simple OID like this:
-# testoid1=1.2.3.4
-# Or use config file substitution like this:
-# testoid2=${testoid1}.5.6
-
-####################################################################
-[ ca ]
-default_ca	= CA_default		# The default ca section
-
-####################################################################
-[ CA_default ]
-
-dir		= $ENV::KEY_DIR		# Where everything is kept
-certs		= $dir			# Where the issued certs are kept
-crl_dir		= $dir			# Where the issued crl are kept
-database	= $dir/index.txt	# database index file.
-new_certs_dir	= $dir			# default place for new certs.
-
-certificate	= $dir/ca.crt	 	# The CA certificate
-serial		= $dir/serial 		# The current serial number
-crl		= $dir/crl.pem 		# The current CRL
-private_key	= $dir/ca.key	 	# The private key
-RANDFILE	= $dir/.rand		# private random number file
-
-x509_extensions	= usr_cert		# The extentions to add to the cert
-
-# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
-# so this is commented out by default to leave a V1 CRL.
-# crl_extensions	= crl_ext
-
-default_days	= 3650			# how long to certify for
-default_crl_days= 30			# how long before next CRL
-default_md	= md5			# which md to use.
-preserve	= no			# keep passed DN ordering
-
-# A few difference way of specifying how similar the request should look
-# For type CA, the listed attributes must be the same, and the optional
-# and supplied fields are just that :-)
-policy		= policy_match
-
-# For the CA policy
-[ policy_match ]
-countryName		= match
-stateOrProvinceName	= match
-organizationName	= match
-organizationalUnitName	= optional
-commonName		= supplied
-emailAddress		= optional
-
-# For the 'anything' policy
-# At this point in time, you must list all acceptable 'object'
-# types.
-[ policy_anything ]
-countryName		= optional
-stateOrProvinceName	= optional
-localityName		= optional
-organizationName	= optional
-organizationalUnitName	= optional
-commonName		= supplied
-emailAddress		= optional
-
-####################################################################
-[ req ]
-default_bits		= $ENV::KEY_SIZE
-default_keyfile 	= privkey.pem
-distinguished_name	= req_distinguished_name
-attributes		= req_attributes
-x509_extensions	= v3_ca	# The extentions to add to the self signed cert
-
-# Passwords for private keys if not present they will be prompted for
-# input_password = secret
-# output_password = secret
-
-# This sets a mask for permitted string types. There are several options. 
-# default: PrintableString, T61String, BMPString.
-# pkix	 : PrintableString, BMPString.
-# utf8only: only UTF8Strings.
-# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
-# MASK:XXXX a literal mask value.
-# WARNING: current versions of Netscape crash on BMPStrings or UTF8Strings
-# so use this option with caution!
-string_mask = nombstr
-
-# req_extensions = v3_req # The extensions to add to a certificate request
-
-[ req_distinguished_name ]
-countryName			= Country Name (2 letter code)
-countryName_default		= $ENV::KEY_COUNTRY
-countryName_min			= 2
-countryName_max			= 2
-
-stateOrProvinceName		= State or Province Name (full name)
-stateOrProvinceName_default	= $ENV::KEY_PROVINCE
-
-localityName			= Locality Name (eg, city)
-localityName_default		= $ENV::KEY_CITY
-
-0.organizationName		= Organization Name (eg, company)
-0.organizationName_default	= $ENV::KEY_ORG
-
-# we can do this but it is not needed normally :-)
-#1.organizationName		= Second Organization Name (eg, company)
-#1.organizationName_default	= World Wide Web Pty Ltd
-
-organizationalUnitName		= Organizational Unit Name (eg, section)
-#organizationalUnitName_default	=
-
-commonName			= Common Name (eg, your name or your server\'s hostname)
-commonName_max			= 64
-
-emailAddress			= Email Address
-emailAddress_default		= $ENV::KEY_EMAIL
-emailAddress_max		= 40
-
-# SET-ex3			= SET extension number 3
-
-[ req_attributes ]
-challengePassword		= A challenge password
-challengePassword_min		= 4
-challengePassword_max		= 20
-
-unstructuredName		= An optional company name
-
-[ usr_cert ]
-
-# These extensions are added when 'ca' signs a request.
-
-# This goes against PKIX guidelines but some CAs do it and some software
-# requires this to avoid interpreting an end user certificate as a CA.
-
-basicConstraints=CA:FALSE
-
-# Here are some examples of the usage of nsCertType. If it is omitted
-# the certificate can be used for anything *except* object signing.
-
-# This is OK for an SSL server.
-# nsCertType			= server
-
-# For an object signing certificate this would be used.
-# nsCertType = objsign
-
-# For normal client use this is typical
-# nsCertType = client, email
-
-# and for everything including object signing:
-# nsCertType = client, email, objsign
-
-# This is typical in keyUsage for a client certificate.
-# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-# This will be displayed in Netscape's comment listbox.
-nsComment			= "OpenSSL Generated Certificate"
-
-# PKIX recommendations harmless if included in all certificates.
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-
-# This stuff is for subjectAltName and issuerAltname.
-# Import the email address.
-# subjectAltName=email:copy
-
-# Copy subject details
-# issuerAltName=issuer:copy
-
-#nsCaRevocationUrl		= http://www.domain.dom/ca-crl.pem
-#nsBaseUrl
-#nsRevocationUrl
-#nsRenewalUrl
-#nsCaPolicyUrl
-#nsSslServerName
-
-[ server ]
-
-# JY ADDED -- Make a cert with nsCertType set to "server"
-basicConstraints=CA:FALSE
-nsCertType			= server
-nsComment			= "OpenSSL Generated Server Certificate"
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-
-[ v3_req ]
-
-# Extensions to add to a certificate request
-
-basicConstraints = CA:FALSE
-keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-[ v3_ca ]
-
-
-# Extensions for a typical CA
-
-
-# PKIX recommendation.
-
-subjectKeyIdentifier=hash
-
-authorityKeyIdentifier=keyid:always,issuer:always
-
-# This is what PKIX recommends but some broken software chokes on critical
-# extensions.
-#basicConstraints = critical,CA:true
-# So we do this instead.
-basicConstraints = CA:true
-
-# Key usage: this is typical for a CA certificate. However since it will
-# prevent it being used as an test self-signed certificate it is best
-# left out by default.
-# keyUsage = cRLSign, keyCertSign
-
-# Some might want this also
-# nsCertType = sslCA, emailCA
-
-# Include email address in subject alt name: another PKIX recommendation
-# subjectAltName=email:copy
-# Copy issuer details
-# issuerAltName=issuer:copy
-
-# DER hex encoding of an extension: beware experts only!
-# obj=DER:02:03
-# Where 'obj' is a standard or added object
-# You can even override a supported extension:
-# basicConstraints= critical, DER:30:03:01:01:FF
-
-[ crl_ext ]
-
-# CRL extensions.
-# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.
-
-# issuerAltName=issuer:copy
-authorityKeyIdentifier=keyid:always,issuer:always
diff --git a/easy-rsa/1.0/revoke-crt b/easy-rsa/1.0/revoke-crt
deleted file mode 100644
index 35b071a..0000000
--- a/easy-rsa/1.0/revoke-crt
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-#
-# revoke a certificate
-#
-#
-
-if test $# -ne 1; then
-        echo "usage: revoke-crt <file.crt>";
-        exit 1
-fi
-
-if test $KEY_DIR; then
-       cd $KEY_DIR && \
-       openssl ca -revoke $1 -config $KEY_CONFIG
-else
-       echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/revoke-full b/easy-rsa/1.0/revoke-full
deleted file mode 100755
index 66ea03f..0000000
--- a/easy-rsa/1.0/revoke-full
+++ /dev/null
@@ -1,29 +0,0 @@
-#!/bin/sh
-
-# revoke a certificate, regenerate CRL,
-# and verify revocation
-
-CRL=crl.pem
-RT=revoke-test.pem
-
-if test $# -ne 1; then
-        echo "usage: revoke-full <name>";
-        exit 1
-fi
-
-if test $KEY_DIR; then
-       cd $KEY_DIR
-       rm -f $RT
-
-       # revoke key and generate a new CRL
-       openssl ca -revoke $1.crt -config $KEY_CONFIG
-
-       # generate a new CRL
-       openssl ca -gencrl -out $CRL -config $KEY_CONFIG
-       cat ca.crt $CRL >$RT
-    
-       # verify the revocation
-       openssl verify -CAfile $RT -crl_check $1.crt
-else
-       echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/sign-req b/easy-rsa/1.0/sign-req
deleted file mode 100755
index 59edc42..0000000
--- a/easy-rsa/1.0/sign-req
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-#
-# Sign a certificate signing request (a .csr file)
-# with a local root certificate and key.
-#
-
-if test $# -ne 1; then
-        echo "usage: sign-req <name>";
-        exit 1
-fi                                                                             
-
-if test $KEY_DIR; then
-	cd $KEY_DIR && \
-	openssl ca -days 3650 -out $1.crt -in $1.csr -config $KEY_CONFIG
-else
-	echo you must define KEY_DIR
-fi
diff --git a/easy-rsa/1.0/vars b/easy-rsa/1.0/vars
deleted file mode 100644
index da89cd2..0000000
--- a/easy-rsa/1.0/vars
+++ /dev/null
@@ -1,49 +0,0 @@
-# easy-rsa parameter settings
-
-# NOTE: If you installed from an RPM,
-# don't edit this file in place in
-# /usr/share/openvpn/easy-rsa --
-# instead, you should copy the whole
-# easy-rsa directory to another location
-# (such as /etc/openvpn) so that your
-# edits will not be wiped out by a future
-# OpenVPN package upgrade.
-
-# This variable should point to
-# the top level of the easy-rsa
-# tree.
-export D=`pwd`
-
-# This variable should point to
-# the openssl.cnf file included
-# with easy-rsa.
-export KEY_CONFIG=$D/openssl.cnf
-
-# Edit this variable to point to
-# your soon-to-be-created key
-# directory.
-#
-# WARNING: clean-all will do
-# a rm -rf on this directory
-# so make sure you define
-# it correctly!
-export KEY_DIR=$D/keys
-
-# Issue rm -rf warning
-echo NOTE: when you run ./clean-all, I will be doing a rm -rf on $KEY_DIR
-
-# Increase this to 2048 if you
-# are paranoid.  This will slow
-# down TLS negotiation performance
-# as well as the one-time DH parms
-# generation process.
-export KEY_SIZE=1024
-
-# These are the default values for fields
-# which will be placed in the certificate.
-# Don't leave any of these fields blank.
-export KEY_COUNTRY=KG
-export KEY_PROVINCE=NA
-export KEY_CITY=BISHKEK
-export KEY_ORG="OpenVPN-TEST"
-export KEY_EMAIL="me@...430..."
diff --git a/easy-rsa/2.0/Makefile b/easy-rsa/2.0/Makefile
deleted file mode 100644
index 8000cc5..0000000
--- a/easy-rsa/2.0/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-
-DESTDIR=
-PREFIX=
-
-all:
-	echo "All done."
-	echo "Run make install DESTDIR=/usr/share/somewhere"
-
-install:
-	install -d "${DESTDIR}/${PREFIX}"
-	install -m 0755 build-* "${DESTDIR}/${PREFIX}"
-	install -m 0755 clean-all list-crl inherit-inter pkitool revoke-full sign-req whichopensslcnf "${DESTDIR}/${PREFIX}"
-	install -m 0644 openssl-0.9.6.cnf openssl-0.9.8.cnf openssl-1.0.0.cnf README vars "${DESTDIR}/${PREFIX}"
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
diff --git a/easy-rsa/2.0/build-ca b/easy-rsa/2.0/build-ca
deleted file mode 100755
index bce29a6..0000000
--- a/easy-rsa/2.0/build-ca
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-
-#
-# Build a root certificate
-#
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --initca $*
diff --git a/easy-rsa/2.0/build-dh b/easy-rsa/2.0/build-dh
deleted file mode 100755
index 4beb127..0000000
--- a/easy-rsa/2.0/build-dh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-# Build Diffie-Hellman parameters for the server side
-# of an SSL/TLS connection.
-
-if [ -d $KEY_DIR ] && [ $KEY_SIZE ]; then
-    $OPENSSL dhparam -out ${KEY_DIR}/dh${KEY_SIZE}.pem ${KEY_SIZE}
-else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
-    echo 'Make sure you have edited it to reflect your configuration.'
-fi
diff --git a/easy-rsa/2.0/build-inter b/easy-rsa/2.0/build-inter
deleted file mode 100755
index 87bf98d..0000000
--- a/easy-rsa/2.0/build-inter
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-# Make an intermediate CA certificate/private key pair using a locally generated
-# root certificate.
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --inter $*
diff --git a/easy-rsa/2.0/build-key b/easy-rsa/2.0/build-key
deleted file mode 100755
index 6c0fed8..0000000
--- a/easy-rsa/2.0/build-key
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-# Make a certificate/private key pair using a locally generated
-# root certificate.
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact $*
diff --git a/easy-rsa/2.0/build-key-pass b/easy-rsa/2.0/build-key-pass
deleted file mode 100755
index 8ef8307..0000000
--- a/easy-rsa/2.0/build-key-pass
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-# Similar to build-key, but protect the private key
-# with a password.
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --pass $*
diff --git a/easy-rsa/2.0/build-key-pkcs12 b/easy-rsa/2.0/build-key-pkcs12
deleted file mode 100755
index ba90e6a..0000000
--- a/easy-rsa/2.0/build-key-pkcs12
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-
-# Make a certificate/private key pair using a locally generated
-# root certificate and convert it to a PKCS #12 file including the
-# the CA certificate as well.
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --pkcs12 $*
diff --git a/easy-rsa/2.0/build-key-server b/easy-rsa/2.0/build-key-server
deleted file mode 100755
index fee0194..0000000
--- a/easy-rsa/2.0/build-key-server
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-
-# Make a certificate/private key pair using a locally generated
-# root certificate.
-#
-# Explicitly set nsCertType to server using the "server"
-# extension in the openssl.cnf file.
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --server $*
diff --git a/easy-rsa/2.0/build-req b/easy-rsa/2.0/build-req
deleted file mode 100755
index 559d512..0000000
--- a/easy-rsa/2.0/build-req
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-# Build a certificate signing request and private key.  Use this
-# when your root certificate and key is not available locally.
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --csr $*
diff --git a/easy-rsa/2.0/build-req-pass b/easy-rsa/2.0/build-req-pass
deleted file mode 100755
index b73ee1b..0000000
--- a/easy-rsa/2.0/build-req-pass
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-# Like build-req, but protect your private key
-# with a password.
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --csr --pass $*
diff --git a/easy-rsa/2.0/clean-all b/easy-rsa/2.0/clean-all
deleted file mode 100755
index cc6e3b2..0000000
--- a/easy-rsa/2.0/clean-all
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/sh
-
-# Initialize the $KEY_DIR directory.
-# Note that this script does a
-# rm -rf on $KEY_DIR so be careful!
-
-if [ "$KEY_DIR" ]; then
-    rm -rf "$KEY_DIR"
-    mkdir "$KEY_DIR" && \
-	chmod go-rwx "$KEY_DIR" && \
-	touch "$KEY_DIR/index.txt" && \
-	echo 01 >"$KEY_DIR/serial"
-else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
-    echo 'Make sure you have edited it to reflect your configuration.'
-fi
diff --git a/easy-rsa/2.0/inherit-inter b/easy-rsa/2.0/inherit-inter
deleted file mode 100755
index aaa5168..0000000
--- a/easy-rsa/2.0/inherit-inter
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/sh
-
-# Build a new PKI which is rooted on an intermediate certificate generated
-# by ./build-inter or ./pkitool --inter from a parent PKI.  The new PKI should
-# have independent vars settings, and must use a different KEY_DIR directory
-# from the parent.  This tool can be used to generate arbitrary depth
-# certificate chains.
-#
-# To build an intermediate CA, follow the same steps for a regular PKI but
-# replace ./build-key or ./pkitool --initca with this script.
-
-# The EXPORT_CA file will contain the CA certificate chain and should be
-# referenced by the OpenVPN "ca" directive in config files.  The ca.crt file
-# will only contain the local intermediate CA -- it's needed by the easy-rsa
-# scripts but not by OpenVPN directly.
-EXPORT_CA="export-ca.crt"
-
-if [ $# -ne 2 ]; then
-    echo "usage: $0 <parent-key-dir> <common-name>"
-    echo "parent-key-dir: the KEY_DIR directory of the parent PKI"
-    echo "common-name: the common name of the intermediate certificate in the parent PKI"
-    exit 1;
-fi
-
-if [ "$KEY_DIR" ]; then
-    cp "$1/$2.crt" "$KEY_DIR/ca.crt"
-    cp "$1/$2.key" "$KEY_DIR/ca.key"
-
-    if [ -e "$1/$EXPORT_CA" ]; then
-	PARENT_CA="$1/$EXPORT_CA"
-    else
-	PARENT_CA="$1/ca.crt"
-    fi
-    cp "$PARENT_CA" "$KEY_DIR/$EXPORT_CA"
-    cat "$KEY_DIR/ca.crt" >> "$KEY_DIR/$EXPORT_CA"
-else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
-    echo 'Make sure you have edited it to reflect your configuration.'
-fi
diff --git a/easy-rsa/2.0/list-crl b/easy-rsa/2.0/list-crl
deleted file mode 100755
index d1d8a69..0000000
--- a/easy-rsa/2.0/list-crl
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/sh
-
-# list revoked certificates
-
-CRL="${1:-crl.pem}"
-
-if [ "$KEY_DIR" ]; then
-    cd "$KEY_DIR" && \
-	$OPENSSL crl -text -noout -in "$CRL"
-else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
-    echo 'Make sure you have edited it to reflect your configuration.'
-fi
diff --git a/easy-rsa/2.0/openssl-0.9.6.cnf b/easy-rsa/2.0/openssl-0.9.6.cnf
deleted file mode 100755
index d28341d..0000000
--- a/easy-rsa/2.0/openssl-0.9.6.cnf
+++ /dev/null
@@ -1,265 +0,0 @@
-# For use with easy-rsa version 2.0
-
-#
-# OpenSSL example configuration file.
-# This is mostly being used for generation of certificate requests.
-#
-
-# This definition stops the following lines choking if HOME isn't
-# defined.
-HOME			= .
-RANDFILE		= $ENV::HOME/.rnd
-
-# Extra OBJECT IDENTIFIER info:
-#oid_file		= $ENV::HOME/.oid
-oid_section		= new_oids
-
-# To use this configuration file with the "-extfile" option of the
-# "openssl x509" utility, name here the section containing the
-# X.509v3 extensions to use:
-# extensions		= 
-# (Alternatively, use a configuration file that has only
-# X.509v3 extensions in its main [= default] section.)
-
-[ new_oids ]
-
-# We can add new OIDs in here for use by 'ca' and 'req'.
-# Add a simple OID like this:
-# testoid1=1.2.3.4
-# Or use config file substitution like this:
-# testoid2=${testoid1}.5.6
-
-####################################################################
-[ ca ]
-default_ca	= CA_default		# The default ca section
-
-####################################################################
-[ CA_default ]
-
-dir		= $ENV::KEY_DIR		# Where everything is kept
-certs		= $dir			# Where the issued certs are kept
-crl_dir		= $dir			# Where the issued crl are kept
-database	= $dir/index.txt	# database index file.
-new_certs_dir	= $dir			# default place for new certs.
-
-certificate	= $dir/ca.crt	 	# The CA certificate
-serial		= $dir/serial 		# The current serial number
-crl		= $dir/crl.pem 		# The current CRL
-private_key	= $dir/ca.key	 	# The private key
-RANDFILE	= $dir/.rand		# private random number file
-
-x509_extensions	= usr_cert		# The extentions to add to the cert
-
-# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
-# so this is commented out by default to leave a V1 CRL.
-# crl_extensions	= crl_ext
-
-default_days	= 3650			# how long to certify for
-default_crl_days= 30			# how long before next CRL
-default_md	= md5			# which md to use.
-preserve	= no			# keep passed DN ordering
-
-# A few difference way of specifying how similar the request should look
-# For type CA, the listed attributes must be the same, and the optional
-# and supplied fields are just that :-)
-policy		= policy_anything
-
-# For the CA policy
-[ policy_match ]
-countryName		= match
-stateOrProvinceName	= match
-organizationName	= match
-organizationalUnitName	= optional
-commonName		= supplied
-emailAddress		= optional
-
-# For the 'anything' policy
-# At this point in time, you must list all acceptable 'object'
-# types.
-[ policy_anything ]
-countryName		= optional
-stateOrProvinceName	= optional
-localityName		= optional
-organizationName	= optional
-organizationalUnitName	= optional
-commonName		= supplied
-emailAddress		= optional
-
-####################################################################
-[ req ]
-default_bits		= $ENV::KEY_SIZE
-default_keyfile 	= privkey.pem
-distinguished_name	= req_distinguished_name
-attributes		= req_attributes
-x509_extensions	= v3_ca	# The extentions to add to the self signed cert
-
-# Passwords for private keys if not present they will be prompted for
-# input_password = secret
-# output_password = secret
-
-# This sets a mask for permitted string types. There are several options. 
-# default: PrintableString, T61String, BMPString.
-# pkix	 : PrintableString, BMPString.
-# utf8only: only UTF8Strings.
-# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
-# MASK:XXXX a literal mask value.
-# WARNING: current versions of Netscape crash on BMPStrings or UTF8Strings
-# so use this option with caution!
-string_mask = nombstr
-
-# req_extensions = v3_req # The extensions to add to a certificate request
-
-[ req_distinguished_name ]
-countryName			= Country Name (2 letter code)
-countryName_default		= $ENV::KEY_COUNTRY
-countryName_min			= 2
-countryName_max			= 2
-
-stateOrProvinceName		= State or Province Name (full name)
-stateOrProvinceName_default	= $ENV::KEY_PROVINCE
-
-localityName			= Locality Name (eg, city)
-localityName_default		= $ENV::KEY_CITY
-
-0.organizationName		= Organization Name (eg, company)
-0.organizationName_default	= $ENV::KEY_ORG
-
-# we can do this but it is not needed normally :-)
-#1.organizationName		= Second Organization Name (eg, company)
-#1.organizationName_default	= World Wide Web Pty Ltd
-
-organizationalUnitName		= Organizational Unit Name (eg, section)
-#organizationalUnitName_default	=
-
-commonName			= Common Name (eg, your name or your server\'s hostname)
-commonName_max			= 64
-
-emailAddress			= Email Address
-emailAddress_default		= $ENV::KEY_EMAIL
-emailAddress_max		= 40
-
-# JY -- added for batch mode
-organizationalUnitName_default = $ENV::KEY_OU
-commonName_default = $ENV::KEY_CN
-
-# SET-ex3			= SET extension number 3
-
-[ req_attributes ]
-challengePassword		= A challenge password
-challengePassword_min		= 4
-challengePassword_max		= 20
-
-unstructuredName		= An optional company name
-
-[ usr_cert ]
-
-# These extensions are added when 'ca' signs a request.
-
-# This goes against PKIX guidelines but some CAs do it and some software
-# requires this to avoid interpreting an end user certificate as a CA.
-
-basicConstraints=CA:FALSE
-
-# Here are some examples of the usage of nsCertType. If it is omitted
-# the certificate can be used for anything *except* object signing.
-
-# This is OK for an SSL server.
-# nsCertType			= server
-
-# For an object signing certificate this would be used.
-# nsCertType = objsign
-
-# For normal client use this is typical
-# nsCertType = client, email
-
-# and for everything including object signing:
-# nsCertType = client, email, objsign
-
-# This is typical in keyUsage for a client certificate.
-# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-# This will be displayed in Netscape's comment listbox.
-nsComment			= "Easy-RSA Generated Certificate"
-
-# PKIX recommendations harmless if included in all certificates.
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-extendedKeyUsage=clientAuth
-keyUsage = digitalSignature
-
-# This stuff is for subjectAltName and issuerAltname.
-# Import the email address.
-# subjectAltName=email:copy
-
-# Copy subject details
-# issuerAltName=issuer:copy
-
-#nsCaRevocationUrl		= http://www.domain.dom/ca-crl.pem
-#nsBaseUrl
-#nsRevocationUrl
-#nsRenewalUrl
-#nsCaPolicyUrl
-#nsSslServerName
-
-[ server ]
-
-# JY ADDED -- Make a cert with nsCertType set to "server"
-basicConstraints=CA:FALSE
-nsCertType			= server
-nsComment			= "Easy-RSA Generated Server Certificate"
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-extendedKeyUsage=serverAuth
-keyUsage = digitalSignature, keyEncipherment
-
-[ v3_req ]
-
-# Extensions to add to a certificate request
-
-basicConstraints = CA:FALSE
-keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-[ v3_ca ]
-
-
-# Extensions for a typical CA
-
-
-# PKIX recommendation.
-
-subjectKeyIdentifier=hash
-
-authorityKeyIdentifier=keyid:always,issuer:always
-
-# This is what PKIX recommends but some broken software chokes on critical
-# extensions.
-#basicConstraints = critical,CA:true
-# So we do this instead.
-basicConstraints = CA:true
-
-# Key usage: this is typical for a CA certificate. However since it will
-# prevent it being used as an test self-signed certificate it is best
-# left out by default.
-# keyUsage = cRLSign, keyCertSign
-
-# Some might want this also
-# nsCertType = sslCA, emailCA
-
-# Include email address in subject alt name: another PKIX recommendation
-# subjectAltName=email:copy
-# Copy issuer details
-# issuerAltName=issuer:copy
-
-# DER hex encoding of an extension: beware experts only!
-# obj=DER:02:03
-# Where 'obj' is a standard or added object
-# You can even override a supported extension:
-# basicConstraints= critical, DER:30:03:01:01:FF
-
-[ crl_ext ]
-
-# CRL extensions.
-# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.
-
-# issuerAltName=issuer:copy
-authorityKeyIdentifier=keyid:always,issuer:always
diff --git a/easy-rsa/2.0/openssl-0.9.8.cnf b/easy-rsa/2.0/openssl-0.9.8.cnf
deleted file mode 100755
index 340b8af..0000000
--- a/easy-rsa/2.0/openssl-0.9.8.cnf
+++ /dev/null
@@ -1,290 +0,0 @@
-# For use with easy-rsa version 2.0
-
-#
-# OpenSSL example configuration file.
-# This is mostly being used for generation of certificate requests.
-#
-
-# This definition stops the following lines choking if HOME isn't
-# defined.
-HOME			= .
-RANDFILE		= $ENV::HOME/.rnd
-openssl_conf		= openssl_init
-
-[ openssl_init ]
-# Extra OBJECT IDENTIFIER info:
-#oid_file		= $ENV::HOME/.oid
-oid_section		= new_oids
-engines                 = engine_section
-
-# To use this configuration file with the "-extfile" option of the
-# "openssl x509" utility, name here the section containing the
-# X.509v3 extensions to use:
-# extensions		=
-# (Alternatively, use a configuration file that has only
-# X.509v3 extensions in its main [= default] section.)
-
-[ new_oids ]
-
-# We can add new OIDs in here for use by 'ca' and 'req'.
-# Add a simple OID like this:
-# testoid1=1.2.3.4
-# Or use config file substitution like this:
-# testoid2=${testoid1}.5.6
-
-####################################################################
-[ ca ]
-default_ca	= CA_default		# The default ca section
-
-####################################################################
-[ CA_default ]
-
-dir		= $ENV::KEY_DIR		# Where everything is kept
-certs		= $dir			# Where the issued certs are kept
-crl_dir		= $dir			# Where the issued crl are kept
-database	= $dir/index.txt	# database index file.
-new_certs_dir	= $dir			# default place for new certs.
-
-certificate	= $dir/ca.crt	 	# The CA certificate
-serial		= $dir/serial 		# The current serial number
-crl		= $dir/crl.pem 		# The current CRL
-private_key	= $dir/ca.key	 	# The private key
-RANDFILE	= $dir/.rand		# private random number file
-
-x509_extensions	= usr_cert		# The extentions to add to the cert
-
-# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
-# so this is commented out by default to leave a V1 CRL.
-# crl_extensions	= crl_ext
-
-default_days	= 3650			# how long to certify for
-default_crl_days= 30			# how long before next CRL
-default_md	= md5			# which md to use.
-preserve	= no			# keep passed DN ordering
-
-# A few difference way of specifying how similar the request should look
-# For type CA, the listed attributes must be the same, and the optional
-# and supplied fields are just that :-)
-policy		= policy_anything
-
-# For the CA policy
-[ policy_match ]
-countryName		= match
-stateOrProvinceName	= match
-organizationName	= match
-organizationalUnitName	= optional
-commonName		= supplied
-name			= optional
-emailAddress		= optional
-
-# For the 'anything' policy
-# At this point in time, you must list all acceptable 'object'
-# types.
-[ policy_anything ]
-countryName		= optional
-stateOrProvinceName	= optional
-localityName		= optional
-organizationName	= optional
-organizationalUnitName	= optional
-commonName		= supplied
-name			= optional
-emailAddress		= optional
-
-####################################################################
-[ req ]
-default_bits		= $ENV::KEY_SIZE
-default_keyfile 	= privkey.pem
-distinguished_name	= req_distinguished_name
-attributes		= req_attributes
-x509_extensions	= v3_ca	# The extentions to add to the self signed cert
-
-# Passwords for private keys if not present they will be prompted for
-# input_password = secret
-# output_password = secret
-
-# This sets a mask for permitted string types. There are several options.
-# default: PrintableString, T61String, BMPString.
-# pkix	 : PrintableString, BMPString.
-# utf8only: only UTF8Strings.
-# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
-# MASK:XXXX a literal mask value.
-# WARNING: current versions of Netscape crash on BMPStrings or UTF8Strings
-# so use this option with caution!
-string_mask = nombstr
-
-# req_extensions = v3_req # The extensions to add to a certificate request
-
-[ req_distinguished_name ]
-countryName			= Country Name (2 letter code)
-countryName_default		= $ENV::KEY_COUNTRY
-countryName_min			= 2
-countryName_max			= 2
-
-stateOrProvinceName		= State or Province Name (full name)
-stateOrProvinceName_default	= $ENV::KEY_PROVINCE
-
-localityName			= Locality Name (eg, city)
-localityName_default		= $ENV::KEY_CITY
-
-0.organizationName		= Organization Name (eg, company)
-0.organizationName_default	= $ENV::KEY_ORG
-
-# we can do this but it is not needed normally :-)
-#1.organizationName		= Second Organization Name (eg, company)
-#1.organizationName_default	= World Wide Web Pty Ltd
-
-organizationalUnitName		= Organizational Unit Name (eg, section)
-#organizationalUnitName_default	=
-
-commonName			= Common Name (eg, your name or your server\'s hostname)
-commonName_max			= 64
-
-name				= Name
-name_max			= 64
-
-emailAddress			= Email Address
-emailAddress_default		= $ENV::KEY_EMAIL
-emailAddress_max		= 40
-
-# JY -- added for batch mode
-organizationalUnitName_default = $ENV::KEY_OU
-commonName_default = $ENV::KEY_CN
-name_default = $ENV::KEY_NAME
-
-# SET-ex3			= SET extension number 3
-
-[ req_attributes ]
-challengePassword		= A challenge password
-challengePassword_min		= 4
-challengePassword_max		= 20
-
-unstructuredName		= An optional company name
-
-[ usr_cert ]
-
-# These extensions are added when 'ca' signs a request.
-
-# This goes against PKIX guidelines but some CAs do it and some software
-# requires this to avoid interpreting an end user certificate as a CA.
-
-basicConstraints=CA:FALSE
-
-# Here are some examples of the usage of nsCertType. If it is omitted
-# the certificate can be used for anything *except* object signing.
-
-# This is OK for an SSL server.
-# nsCertType			= server
-
-# For an object signing certificate this would be used.
-# nsCertType = objsign
-
-# For normal client use this is typical
-# nsCertType = client, email
-
-# and for everything including object signing:
-# nsCertType = client, email, objsign
-
-# This is typical in keyUsage for a client certificate.
-# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-# This will be displayed in Netscape's comment listbox.
-nsComment			= "Easy-RSA Generated Certificate"
-
-# PKIX recommendations harmless if included in all certificates.
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-extendedKeyUsage=clientAuth
-keyUsage = digitalSignature
-
-# This stuff is for subjectAltName and issuerAltname.
-# Import the email address.
-# subjectAltName=email:copy
-
-# Copy subject details
-# issuerAltName=issuer:copy
-
-#nsCaRevocationUrl		= http://www.domain.dom/ca-crl.pem
-#nsBaseUrl
-#nsRevocationUrl
-#nsRenewalUrl
-#nsCaPolicyUrl
-#nsSslServerName
-
-[ server ]
-
-# JY ADDED -- Make a cert with nsCertType set to "server"
-basicConstraints=CA:FALSE
-nsCertType			= server
-nsComment			= "Easy-RSA Generated Server Certificate"
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-extendedKeyUsage=serverAuth
-keyUsage = digitalSignature, keyEncipherment
-
-[ v3_req ]
-
-# Extensions to add to a certificate request
-
-basicConstraints = CA:FALSE
-keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-[ v3_ca ]
-
-
-# Extensions for a typical CA
-
-
-# PKIX recommendation.
-
-subjectKeyIdentifier=hash
-
-authorityKeyIdentifier=keyid:always,issuer:always
-
-# This is what PKIX recommends but some broken software chokes on critical
-# extensions.
-#basicConstraints = critical,CA:true
-# So we do this instead.
-basicConstraints = CA:true
-
-# Key usage: this is typical for a CA certificate. However since it will
-# prevent it being used as an test self-signed certificate it is best
-# left out by default.
-# keyUsage = cRLSign, keyCertSign
-
-# Some might want this also
-# nsCertType = sslCA, emailCA
-
-# Include email address in subject alt name: another PKIX recommendation
-# subjectAltName=email:copy
-# Copy issuer details
-# issuerAltName=issuer:copy
-
-# DER hex encoding of an extension: beware experts only!
-# obj=DER:02:03
-# Where 'obj' is a standard or added object
-# You can even override a supported extension:
-# basicConstraints= critical, DER:30:03:01:01:FF
-
-[ crl_ext ]
-
-# CRL extensions.
-# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.
-
-# issuerAltName=issuer:copy
-authorityKeyIdentifier=keyid:always,issuer:always
-
-[ engine_section ]
-#
-# If you are using PKCS#11
-# Install engine_pkcs11 of opensc (www.opensc.org)
-# And uncomment the following
-# verify that dynamic_path points to the correct location
-#
-#pkcs11 = pkcs11_section
-
-[ pkcs11_section ]
-engine_id = pkcs11
-dynamic_path = /usr/lib/engines/engine_pkcs11.so
-MODULE_PATH = $ENV::PKCS11_MODULE_PATH
-PIN = $ENV::PKCS11_PIN
-init = 0
diff --git a/easy-rsa/2.0/openssl-1.0.0.cnf b/easy-rsa/2.0/openssl-1.0.0.cnf
deleted file mode 100755
index fa258a5..0000000
--- a/easy-rsa/2.0/openssl-1.0.0.cnf
+++ /dev/null
@@ -1,285 +0,0 @@
-# For use with easy-rsa version 2.0 and OpenSSL 1.0.0*
-
-# This definition stops the following lines choking if HOME isn't
-# defined.
-HOME			= .
-RANDFILE		= $ENV::HOME/.rnd
-openssl_conf		= openssl_init
-
-[ openssl_init ]
-# Extra OBJECT IDENTIFIER info:
-#oid_file		= $ENV::HOME/.oid
-oid_section		= new_oids
-engines			= engine_section
-
-# To use this configuration file with the "-extfile" option of the
-# "openssl x509" utility, name here the section containing the
-# X.509v3 extensions to use:
-# extensions		=
-# (Alternatively, use a configuration file that has only
-# X.509v3 extensions in its main [= default] section.)
-
-[ new_oids ]
-
-# We can add new OIDs in here for use by 'ca' and 'req'.
-# Add a simple OID like this:
-# testoid1=1.2.3.4
-# Or use config file substitution like this:
-# testoid2=${testoid1}.5.6
-
-####################################################################
-[ ca ]
-default_ca	= CA_default		# The default ca section
-
-####################################################################
-[ CA_default ]
-
-dir		= $ENV::KEY_DIR		# Where everything is kept
-certs		= $dir			# Where the issued certs are kept
-crl_dir		= $dir			# Where the issued crl are kept
-database	= $dir/index.txt	# database index file.
-new_certs_dir	= $dir			# default place for new certs.
-
-certificate	= $dir/ca.crt	 	# The CA certificate
-serial		= $dir/serial 		# The current serial number
-crl		= $dir/crl.pem 		# The current CRL
-private_key	= $dir/ca.key		# The private key
-RANDFILE	= $dir/.rand		# private random number file
-
-x509_extensions	= usr_cert		# The extentions to add to the cert
-
-# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
-# so this is commented out by default to leave a V1 CRL.
-# crl_extensions	= crl_ext
-
-default_days	= 3650			# how long to certify for
-default_crl_days= 30			# how long before next CRL
-default_md	= md5			# use public key default MD
-preserve	= no			# keep passed DN ordering
-
-# A few difference way of specifying how similar the request should look
-# For type CA, the listed attributes must be the same, and the optional
-# and supplied fields are just that :-)
-policy		= policy_anything
-
-# For the CA policy
-[ policy_match ]
-countryName		= match
-stateOrProvinceName	= match
-organizationName	= match
-organizationalUnitName	= optional
-commonName		= supplied
-name			= optional
-emailAddress		= optional
-
-# For the 'anything' policy
-# At this point in time, you must list all acceptable 'object'
-# types.
-[ policy_anything ]
-countryName		= optional
-stateOrProvinceName	= optional
-localityName		= optional
-organizationName	= optional
-organizationalUnitName	= optional
-commonName		= supplied
-name			= optional
-emailAddress		= optional
-
-####################################################################
-[ req ]
-default_bits		= $ENV::KEY_SIZE
-default_keyfile 	= privkey.pem
-distinguished_name	= req_distinguished_name
-attributes		= req_attributes
-x509_extensions	= v3_ca	# The extentions to add to the self signed cert
-
-# Passwords for private keys if not present they will be prompted for
-# input_password = secret
-# output_password = secret
-
-# This sets a mask for permitted string types. There are several options.
-# default: PrintableString, T61String, BMPString.
-# pkix	 : PrintableString, BMPString (PKIX recommendation after 2004).
-# utf8only: only UTF8Strings (PKIX recommendation after 2004).
-# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
-# MASK:XXXX a literal mask value.
-string_mask = nombstr
-
-# req_extensions = v3_req # The extensions to add to a certificate request
-
-[ req_distinguished_name ]
-countryName			= Country Name (2 letter code)
-countryName_default		= $ENV::KEY_COUNTRY
-countryName_min			= 2
-countryName_max			= 2
-
-stateOrProvinceName		= State or Province Name (full name)
-stateOrProvinceName_default	= $ENV::KEY_PROVINCE
-
-localityName			= Locality Name (eg, city)
-localityName_default		= $ENV::KEY_CITY
-
-0.organizationName		= Organization Name (eg, company)
-0.organizationName_default	= $ENV::KEY_ORG
-
-# we can do this but it is not needed normally :-)
-#1.organizationName		= Second Organization Name (eg, company)
-#1.organizationName_default	= World Wide Web Pty Ltd
-
-organizationalUnitName		= Organizational Unit Name (eg, section)
-#organizationalUnitName_default	=
-
-commonName			= Common Name (eg, your name or your server\'s hostname)
-commonName_max			= 64
-
-name				= Name
-name_max			= 64
-
-emailAddress			= Email Address
-emailAddress_default		= $ENV::KEY_EMAIL
-emailAddress_max		= 40
-
-# JY -- added for batch mode
-organizationalUnitName_default = $ENV::KEY_OU
-commonName_default = $ENV::KEY_CN
-name_default = $ENV::KEY_NAME
-
-
-# SET-ex3			= SET extension number 3
-
-[ req_attributes ]
-challengePassword		= A challenge password
-challengePassword_min		= 4
-challengePassword_max		= 20
-
-unstructuredName		= An optional company name
-
-[ usr_cert ]
-
-# These extensions are added when 'ca' signs a request.
-
-# This goes against PKIX guidelines but some CAs do it and some software
-# requires this to avoid interpreting an end user certificate as a CA.
-
-basicConstraints=CA:FALSE
-
-# Here are some examples of the usage of nsCertType. If it is omitted
-# the certificate can be used for anything *except* object signing.
-
-# This is OK for an SSL server.
-# nsCertType			= server
-
-# For an object signing certificate this would be used.
-# nsCertType = objsign
-
-# For normal client use this is typical
-# nsCertType = client, email
-
-# and for everything including object signing:
-# nsCertType = client, email, objsign
-
-# This is typical in keyUsage for a client certificate.
-# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-# This will be displayed in Netscape's comment listbox.
-nsComment			= "Easy-RSA Generated Certificate"
-
-# PKIX recommendations harmless if included in all certificates.
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-extendedKeyUsage=clientAuth
-keyUsage = digitalSignature
-
-
-# This stuff is for subjectAltName and issuerAltname.
-# Import the email address.
-# subjectAltName=email:copy
-
-# Copy subject details
-# issuerAltName=issuer:copy
-
-#nsCaRevocationUrl		= http://www.domain.dom/ca-crl.pem
-#nsBaseUrl
-#nsRevocationUrl
-#nsRenewalUrl
-#nsCaPolicyUrl
-#nsSslServerName
-
-[ server ]
-
-# JY ADDED -- Make a cert with nsCertType set to "server"
-basicConstraints=CA:FALSE
-nsCertType                     = server
-nsComment                      = "Easy-RSA Generated Server Certificate"
-subjectKeyIdentifier=hash
-authorityKeyIdentifier=keyid,issuer:always
-extendedKeyUsage=serverAuth
-keyUsage = digitalSignature, keyEncipherment
-
-[ v3_req ]
-
-# Extensions to add to a certificate request
-
-basicConstraints = CA:FALSE
-keyUsage = nonRepudiation, digitalSignature, keyEncipherment
-
-[ v3_ca ]
-
-
-# Extensions for a typical CA
-
-
-# PKIX recommendation.
-
-subjectKeyIdentifier=hash
-
-authorityKeyIdentifier=keyid:always,issuer:always
-
-# This is what PKIX recommends but some broken software chokes on critical
-# extensions.
-#basicConstraints = critical,CA:true
-# So we do this instead.
-basicConstraints = CA:true
-
-# Key usage: this is typical for a CA certificate. However since it will
-# prevent it being used as an test self-signed certificate it is best
-# left out by default.
-# keyUsage = cRLSign, keyCertSign
-
-# Some might want this also
-# nsCertType = sslCA, emailCA
-
-# Include email address in subject alt name: another PKIX recommendation
-# subjectAltName=email:copy
-# Copy issuer details
-# issuerAltName=issuer:copy
-
-# DER hex encoding of an extension: beware experts only!
-# obj=DER:02:03
-# Where 'obj' is a standard or added object
-# You can even override a supported extension:
-# basicConstraints= critical, DER:30:03:01:01:FF
-
-[ crl_ext ]
-
-# CRL extensions.
-# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.
-
-# issuerAltName=issuer:copy
-authorityKeyIdentifier=keyid:always,issuer:always
-
-[ engine_section ]
-#
-# If you are using PKCS#11
-# Install engine_pkcs11 of opensc (www.opensc.org)
-# And uncomment the following
-# verify that dynamic_path points to the correct location
-#
-#pkcs11 = pkcs11_section
-
-[ pkcs11_section ]
-engine_id = pkcs11
-dynamic_path = /usr/lib/engines/engine_pkcs11.so
-MODULE_PATH = $ENV::PKCS11_MODULE_PATH
-PIN = $ENV::PKCS11_PIN
-init = 0
diff --git a/easy-rsa/2.0/pkitool b/easy-rsa/2.0/pkitool
deleted file mode 100755
index 49588f5..0000000
--- a/easy-rsa/2.0/pkitool
+++ /dev/null
@@ -1,379 +0,0 @@
-#!/bin/sh
-
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single TCP/UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License version 2
-#  as published by the Free Software Foundation.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program (see the file COPYING included with this
-#  distribution); if not, write to the Free Software Foundation, Inc.,
-#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-
-# pkitool is a front-end for the openssl tool.
-
-# Calling scripts can set the certificate organizational 
-# unit with the KEY_OU environmental variable. 
-
-# Calling scripts can also set the KEY_NAME environmental
-# variable to set the "name" X509 subject field.
-
-PROGNAME=pkitool
-VERSION=2.0
-DEBUG=0
-
-die()
-{
-    local m="$1"
-
-    echo "$m" >&2
-    exit 1
-}
-
-need_vars()
-{
-    echo '  Please edit the vars script to reflect your configuration,'
-    echo '  then source it with "source ./vars".'
-    echo '  Next, to start with a fresh PKI configuration and to delete any'
-    echo '  previous certificates and keys, run "./clean-all".'
-    echo "  Finally, you can run this tool ($PROGNAME) to build certificates/keys."
-}
-
-usage()
-{
-    echo "$PROGNAME $VERSION"
-    echo "Usage: $PROGNAME [options...] [common-name]"
-    echo "Options:"
-    echo "  --batch    : batch mode (default)"
-    echo "  --keysize  : Set keysize"
-    echo "      size   : size (default=1024)"
-    echo "  --interact : interactive mode"
-    echo "  --server   : build server cert"
-    echo "  --initca   : build root CA"
-    echo "  --inter    : build intermediate CA"
-    echo "  --pass     : encrypt private key with password"
-    echo "  --csr      : only generate a CSR, do not sign"
-    echo "  --sign     : sign an existing CSR"
-    echo "  --pkcs12   : generate a combined PKCS#12 file"
-    echo "  --pkcs11   : generate certificate on PKCS#11 token"
-    echo "      lib    : PKCS#11 library"
-    echo "      slot   : PKCS#11 slot"
-    echo "      id     : PKCS#11 object id (hex string)"
-    echo "      label  : PKCS#11 object label"
-    echo "Standalone options:"
-    echo "  --pkcs11-slots   : list PKCS#11 slots"
-    echo "      lib    : PKCS#11 library"
-    echo "  --pkcs11-objects : list PKCS#11 token objects"
-    echo "      lib    : PKCS#11 library"
-    echo "      slot   : PKCS#11 slot"
-    echo "  --pkcs11-init    : initialize PKCS#11 token DANGEROUS!!!"
-    echo "      lib    : PKCS#11 library"
-    echo "      slot   : PKCS#11 slot"
-    echo "      label  : PKCS#11 token label"
-    echo "Notes:"
-    need_vars
-    echo "  In order to use PKCS#11 interface you must have opensc-0.10.0 or higher."
-    echo "Generated files and corresponding OpenVPN directives:"
-    echo '(Files will be placed in the $KEY_DIR directory, defined in ./vars)'
-    echo "  ca.crt     -> root certificate (--ca)"
-    echo "  ca.key     -> root key, keep secure (not directly used by OpenVPN)"
-    echo "  .crt files -> client/server certificates (--cert)"
-    echo "  .key files -> private keys, keep secure (--key)"
-    echo "  .csr files -> certificate signing request (not directly used by OpenVPN)"
-    echo "  dh1024.pem or dh2048.pem -> Diffie Hellman parameters (--dh)"
-    echo "Examples:"
-    echo "  $PROGNAME --initca          -> Build root certificate"
-    echo "  $PROGNAME --initca --pass   -> Build root certificate with password-protected key"
-    echo "  $PROGNAME --server server1  -> Build \"server1\" certificate/key"
-    echo "  $PROGNAME client1           -> Build \"client1\" certificate/key"
-    echo "  $PROGNAME --pass client2    -> Build password-protected \"client2\" certificate/key"
-    echo "  $PROGNAME --pkcs12 client3  -> Build \"client3\" certificate/key in PKCS#12 format"
-    echo "  $PROGNAME --csr client4     -> Build \"client4\" CSR to be signed by another CA"
-    echo "  $PROGNAME --sign client4    -> Sign \"client4\" CSR"
-    echo "  $PROGNAME --inter interca   -> Build an intermediate key-signing certificate/key"
-    echo "                               Also see ./inherit-inter script."
-    echo "  $PROGNAME --pkcs11 /usr/lib/pkcs11/lib1 0 010203 \"client5 id\" client5"
-    echo "                              -> Build \"client5\" certificate/key in PKCS#11 token"
-    echo "Typical usage for initial PKI setup.  Build myserver, client1, and client2 cert/keys."
-    echo "Protect client2 key with a password.  Build DH parms.  Generated files in ./keys :"
-    echo "  [edit vars with your site-specific info]"
-    echo "  source ./vars"
-    echo "  ./clean-all"
-    echo "  ./build-dh     -> takes a long time, consider backgrounding"
-    echo "  ./$PROGNAME --initca"
-    echo "  ./$PROGNAME --server myserver"
-    echo "  ./$PROGNAME client1"
-    echo "  ./$PROGNAME --pass client2"
-    echo "Typical usage for adding client cert to existing PKI:"
-    echo "  source ./vars"
-    echo "  ./$PROGNAME client-new"
-}
-
-# Set tool defaults
-[ -n "$OPENSSL" ] || export OPENSSL="openssl"
-[ -n "$PKCS11TOOL" ] || export PKCS11TOOL="pkcs11-tool"
-[ -n "$GREP" ] || export GREP="grep"
-
-# Set defaults
-DO_REQ="1"
-REQ_EXT=""
-DO_CA="1"
-CA_EXT=""
-DO_P12="0"
-DO_P11="0"
-DO_ROOT="0"
-NODES_REQ="-nodes"
-NODES_P12=""
-BATCH="-batch"
-CA="ca"
-# must be set or errors of openssl.cnf
-PKCS11_MODULE_PATH="dummy"
-PKCS11_PIN="dummy"
-
-# Process options
-while [ $# -gt 0 ]; do
-    case "$1" in
-        --keysize  ) KEY_SIZE=$2
-		     shift;;
-	--server   ) REQ_EXT="$REQ_EXT -extensions server"
-	             CA_EXT="$CA_EXT -extensions server" ;;
-	--batch    ) BATCH="-batch" ;;
-	--interact ) BATCH="" ;;
-        --inter    ) CA_EXT="$CA_EXT -extensions v3_ca" ;;
-        --initca   ) DO_ROOT="1" ;;
-	--pass     ) NODES_REQ="" ;;
-        --csr      ) DO_CA="0" ;;
-        --sign     ) DO_REQ="0" ;;
-        --pkcs12   ) DO_P12="1" ;;
-	--pkcs11   ) DO_P11="1"
-	             PKCS11_MODULE_PATH="$2"
-		     PKCS11_SLOT="$3"
-		     PKCS11_ID="$4"
-		     PKCS11_LABEL="$5"
-		     shift 4;;
-
-	# standalone
-	--pkcs11-init)
-	             PKCS11_MODULE_PATH="$2"
-	             PKCS11_SLOT="$3"
-	             PKCS11_LABEL="$4"
-		     if [ -z "$PKCS11_LABEL" ]; then
-		       die "Please specify library name, slot and label"
-		     fi
-		     $PKCS11TOOL --module "$PKCS11_MODULE_PATH" --init-token --slot "$PKCS11_SLOT" \
-		     	--label "$PKCS11_LABEL" &&
-			$PKCS11TOOL --module "$PKCS11_MODULE_PATH" --init-pin --slot "$PKCS11_SLOT"
-		     exit $?;;
-	--pkcs11-slots)
-	             PKCS11_MODULE_PATH="$2"
-		     if [ -z "$PKCS11_MODULE_PATH" ]; then
-		       die "Please specify library name"
-		     fi
-		     $PKCS11TOOL --module "$PKCS11_MODULE_PATH" --list-slots
-		     exit 0;;
-	--pkcs11-objects)
-	             PKCS11_MODULE_PATH="$2"
-	             PKCS11_SLOT="$3"
-		     if [ -z "$PKCS11_SLOT" ]; then
-		       die "Please specify library name and slot"
-		     fi
-		     $PKCS11TOOL --module "$PKCS11_MODULE_PATH" --list-objects --login --slot "$PKCS11_SLOT"
-		     exit 0;;
-
-        --help|--usage)
-                    usage
-                    exit ;;
-        --version)
-                    echo "$PROGNAME $VERSION"
-                    exit ;;
-	# errors
-	--*        ) die "$PROGNAME: unknown option: $1" ;;
-	*          ) break ;;
-    esac
-    shift   
-done
-
-if ! [ -z "$BATCH" ]; then
-	if $OPENSSL version | grep 0.9.6 > /dev/null; then
-		die "Batch mode is unsupported in openssl<0.9.7"
-	fi
-fi
-
-if [ $DO_P12 -eq 1 -a $DO_P11 -eq 1 ]; then
-	die "PKCS#11 and PKCS#12 cannot be specified together"
-fi
-
-if [ $DO_P11 -eq 1 ]; then
-	if ! grep "^pkcs11.*=" "$KEY_CONFIG" > /dev/null; then
-		die "Please edit $KEY_CONFIG and setup PKCS#11 engine"
-	fi
-fi
-
-# If we are generating pkcs12, only encrypt the final step
-if [ $DO_P12 -eq 1 ]; then
-    NODES_P12="$NODES_REQ"
-    NODES_REQ="-nodes"
-fi
-
-if [ $DO_P11 -eq 1 ]; then
-	if [ -z "$PKCS11_LABEL" ]; then
-		die "PKCS#11 arguments incomplete"
-	fi
-fi
-
-# If undefined, set default key expiration intervals
-if [ -z "$KEY_EXPIRE" ]; then
-    KEY_EXPIRE=3650
-fi
-if [ -z "$CA_EXPIRE" ]; then
-    CA_EXPIRE=3650
-fi
-
-# Set organizational unit to empty string if undefined
-if [ -z "$KEY_OU" ]; then
-    KEY_OU=""
-fi
-
-# Set X509 Name string to empty string if undefined
-if [ -z "$KEY_NAME" ]; then
-    KEY_NAME=""
-fi
-
-# Set KEY_CN, FN
-if [ $DO_ROOT -eq 1 ]; then
-    if [ -z "$KEY_CN" ]; then
-	if [ "$1" ]; then
-	    KEY_CN="$1"
-	elif [ "$KEY_ORG" ]; then
-	    KEY_CN="$KEY_ORG CA"
-	fi
-    fi
-    if [ $BATCH ] && [ "$KEY_CN" ]; then
-	echo "Using CA Common Name:" "$KEY_CN"
-    fi
-    FN="$KEY_CN"
-elif [ $BATCH ] && [ "$KEY_CN" ]; then
-    echo "Using Common Name:" "$KEY_CN"
-    FN="$KEY_CN"
-    if [ "$1" ]; then
-	FN="$1"
-    fi
-else
-    if [ $# -ne 1 ]; then
-	usage
-	exit 1
-    else
-	KEY_CN="$1"
-    fi
-    FN="$KEY_CN"
-fi
-
-export CA_EXPIRE KEY_EXPIRE KEY_OU KEY_NAME KEY_CN PKCS11_MODULE_PATH PKCS11_PIN
-
-# Show parameters (debugging)
-if [ $DEBUG -eq 1 ]; then
-    echo DO_REQ $DO_REQ
-    echo REQ_EXT $REQ_EXT
-    echo DO_CA $DO_CA
-    echo CA_EXT $CA_EXT
-    echo NODES_REQ $NODES_REQ
-    echo NODES_P12 $NODES_P12
-    echo DO_P12 $DO_P12
-    echo KEY_CN $KEY_CN
-    echo BATCH $BATCH
-    echo DO_ROOT $DO_ROOT
-    echo KEY_EXPIRE $KEY_EXPIRE
-    echo CA_EXPIRE $CA_EXPIRE
-    echo KEY_OU $KEY_OU
-    echo KEY_NAME $KEY_NAME
-    echo DO_P11 $DO_P11
-    echo PKCS11_MODULE_PATH $PKCS11_MODULE_PATH
-    echo PKCS11_SLOT $PKCS11_SLOT
-    echo PKCS11_ID $PKCS11_ID
-    echo PKCS11_LABEL $PKCS11_LABEL
-fi
-
-# Make sure ./vars was sourced beforehand
-if [ -d "$KEY_DIR" ] && [ "$KEY_CONFIG" ]; then
-    cd "$KEY_DIR"
-
-    # Make sure $KEY_CONFIG points to the correct version
-    # of openssl.cnf
-    if $GREP -i 'easy-rsa version 2\.[0-9]' "$KEY_CONFIG" >/dev/null; then
-	:
-    else
-	echo "$PROGNAME: KEY_CONFIG (set by the ./vars script) is pointing to the wrong"
-        echo "version of openssl.cnf: $KEY_CONFIG"
-	echo "The correct version should have a comment that says: easy-rsa version 2.x";
-	exit 1;
-    fi
-
-    # Build root CA
-    if [ $DO_ROOT -eq 1 ]; then
-	$OPENSSL req $BATCH -days $CA_EXPIRE $NODES_REQ -new -newkey rsa:$KEY_SIZE -sha1 \
-	    -x509 -keyout "$CA.key" -out "$CA.crt" -config "$KEY_CONFIG" && \
-	    chmod 0600 "$CA.key"
-    else        
-        # Make sure CA key/cert is available
-	if [ $DO_CA -eq 1 ] || [ $DO_P12 -eq 1 ]; then
-	    if [ ! -r "$CA.crt" ] || [ ! -r "$CA.key" ]; then
-		echo "$PROGNAME: Need a readable $CA.crt and $CA.key in $KEY_DIR"
-		echo "Try $PROGNAME --initca to build a root certificate/key."
-		exit 1
-	    fi
-	fi
-
-	# Generate key for PKCS#11 token
-	PKCS11_ARGS=
-	if [ $DO_P11 -eq 1 ]; then
-	        stty -echo
-	        echo -n "User PIN: "
-	        read -r PKCS11_PIN
-	        stty echo
-		export PKCS11_PIN
-
-		echo "Generating key pair on PKCS#11 token..."
-		$PKCS11TOOL --module "$PKCS11_MODULE_PATH" --keypairgen \
-			--login --pin "$PKCS11_PIN" \
-			--key-type rsa:1024 \
-			--slot "$PKCS11_SLOT" --id "$PKCS11_ID" --label "$PKCS11_LABEL" || exit 1
-		PKCS11_ARGS="-engine pkcs11 -keyform engine -key $PKCS11_SLOT:$PKCS11_ID"
-	fi
-
-        # Build cert/key
-	( [ $DO_REQ -eq 0 ] || $OPENSSL req $BATCH -days $KEY_EXPIRE $NODES_REQ -new -newkey rsa:$KEY_SIZE \
-	        -keyout "$FN.key" -out "$FN.csr" $REQ_EXT -config "$KEY_CONFIG" $PKCS11_ARGS ) && \
-	    ( [ $DO_CA -eq 0 ]  || $OPENSSL ca $BATCH -days $KEY_EXPIRE -out "$FN.crt" \
-	        -in "$FN.csr" $CA_EXT -md sha1 -config "$KEY_CONFIG" ) && \
-	    ( [ $DO_P12 -eq 0 ] || $OPENSSL pkcs12 -export -inkey "$FN.key" \
-	        -in "$FN.crt" -certfile "$CA.crt" -out "$FN.p12" $NODES_P12 ) && \
-	    ( [ $DO_CA -eq 0 -o $DO_P11 -eq 1 ]  || chmod 0600 "$FN.key" ) && \
-	    ( [ $DO_P12 -eq 0 ] || chmod 0600 "$FN.p12" )
-
-	# Load certificate into PKCS#11 token
-	if [ $DO_P11 -eq 1 ]; then
-		$OPENSSL x509 -in "$FN.crt" -inform PEM -out "$FN.crt.der" -outform DER && \
-		  $PKCS11TOOL --module "$PKCS11_MODULE_PATH" --write-object "$FN.crt.der" --type cert \
-			--login --pin "$PKCS11_PIN" \
-			--slot "$PKCS11_SLOT" --id "$PKCS11_ID" --label "$PKCS11_LABEL" 
-		[ -e "$FN.crt.der" ]; rm "$FN.crt.der"
-	fi
-
-    fi
-
-# Need definitions
-else
-    need_vars
-fi
diff --git a/easy-rsa/2.0/revoke-full b/easy-rsa/2.0/revoke-full
deleted file mode 100755
index 4169c4c..0000000
--- a/easy-rsa/2.0/revoke-full
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/sh
-
-# revoke a certificate, regenerate CRL,
-# and verify revocation
-
-CRL="crl.pem"
-RT="revoke-test.pem"
-
-if [ $# -ne 1 ]; then
-    echo "usage: revoke-full <cert-name-base>";
-    exit 1
-fi
-
-if [ "$KEY_DIR" ]; then
-    cd "$KEY_DIR"
-    rm -f "$RT"
-
-    # set defaults
-    export KEY_CN=""
-    export KEY_OU=""
-    export KEY_NAME=""
-
-    # revoke key and generate a new CRL
-    $OPENSSL ca -revoke "$1.crt" -config "$KEY_CONFIG"
-
-    # generate a new CRL -- try to be compatible with
-    # intermediate PKIs
-    $OPENSSL ca -gencrl -out "$CRL" -config "$KEY_CONFIG"
-    if [ -e export-ca.crt ]; then
-	cat export-ca.crt "$CRL" >"$RT"
-    else
-	cat ca.crt "$CRL" >"$RT"
-    fi
-    
-    # verify the revocation
-    $OPENSSL verify -CAfile "$RT" -crl_check "$1.crt"
-else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
-    echo 'Make sure you have edited it to reflect your configuration.'
-fi
diff --git a/easy-rsa/2.0/sign-req b/easy-rsa/2.0/sign-req
deleted file mode 100755
index 6cae7b4..0000000
--- a/easy-rsa/2.0/sign-req
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-# Sign a certificate signing request (a .csr file)
-# with a local root certificate and key.
-
-export EASY_RSA="${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --sign $*
diff --git a/easy-rsa/2.0/vars b/easy-rsa/2.0/vars
deleted file mode 100755
index 2ea1ced..0000000
--- a/easy-rsa/2.0/vars
+++ /dev/null
@@ -1,74 +0,0 @@
-# easy-rsa parameter settings
-
-# NOTE: If you installed from an RPM,
-# don't edit this file in place in
-# /usr/share/openvpn/easy-rsa --
-# instead, you should copy the whole
-# easy-rsa directory to another location
-# (such as /etc/openvpn) so that your
-# edits will not be wiped out by a future
-# OpenVPN package upgrade.
-
-# This variable should point to
-# the top level of the easy-rsa
-# tree.
-export EASY_RSA="`pwd`"
-
-#
-# This variable should point to
-# the requested executables
-#
-export OPENSSL="openssl"
-export PKCS11TOOL="pkcs11-tool"
-export GREP="grep"
-
-
-# This variable should point to
-# the openssl.cnf file included
-# with easy-rsa.
-export KEY_CONFIG=`$EASY_RSA/whichopensslcnf $EASY_RSA`
-
-# Edit this variable to point to
-# your soon-to-be-created key
-# directory.
-#
-# WARNING: clean-all will do
-# a rm -rf on this directory
-# so make sure you define
-# it correctly!
-export KEY_DIR="$EASY_RSA/keys"
-
-# Issue rm -rf warning
-echo NOTE: If you run ./clean-all, I will be doing a rm -rf on $KEY_DIR
-
-# PKCS11 fixes
-export PKCS11_MODULE_PATH="dummy"
-export PKCS11_PIN="dummy"
-
-# Increase this to 2048 if you
-# are paranoid.  This will slow
-# down TLS negotiation performance
-# as well as the one-time DH parms
-# generation process.
-export KEY_SIZE=1024
-
-# In how many days should the root CA key expire?
-export CA_EXPIRE=3650
-
-# In how many days should certificates expire?
-export KEY_EXPIRE=3650
-
-# These are the default values for fields
-# which will be placed in the certificate.
-# Don't leave any of these fields blank.
-export KEY_COUNTRY="US"
-export KEY_PROVINCE="CA"
-export KEY_CITY="SanFrancisco"
-export KEY_ORG="Fort-Funston"
-export KEY_EMAIL="me@...430..."
-export KEY_EMAIL=mail@...1470...
-export KEY_CN=changeme
-export KEY_NAME=changeme
-export KEY_OU=changeme
-export PKCS11_MODULE_PATH=changeme
-export PKCS11_PIN=1234
diff --git a/easy-rsa/2.0/whichopensslcnf b/easy-rsa/2.0/whichopensslcnf
deleted file mode 100755
index 2226a8e..0000000
--- a/easy-rsa/2.0/whichopensslcnf
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/sh
-
-cnf="$1/openssl.cnf"
-
-if [ "$OPENSSL" ]; then
-	if $OPENSSL version | grep -E "0\.9\.6[[:alnum:]]" > /dev/null; then
-		cnf="$1/openssl-0.9.6.cnf"
-	elif $OPENSSL version | grep -E "0\.9\.8[[:alnum:]]" > /dev/null; then
-		cnf="$1/openssl-0.9.8.cnf"
-	elif $OPENSSL version | grep -E "1\.0\.([[:digit:]][[:alnum:]])" > /dev/null; then
-                cnf="$1/openssl-1.0.0.cnf"
-	else
-		cnf="$1/openssl.cnf"
-	fi
-fi
-
-echo $cnf
-
-if [ ! -r $cnf ]; then
-    echo "**************************************************************" >&2
-    echo "  No $cnf file could be found" >&2
-    echo "  Further invocations will fail" >&2
-    echo "**************************************************************" >&2
-fi
-
-exit 0
diff --git a/easy-rsa/Windows/README.txt b/easy-rsa/Windows/README.txt
deleted file mode 100644
index 2ede7b1..0000000
--- a/easy-rsa/Windows/README.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Extract all zip'd files to the OpenVPN home directory,
-including the openssl.cnf file from the top-level
-"easy-rsa" directory.
-
-First run init-config.bat
-
-Next, edit vars.bat to adapt it to your environment, and
-create the directory that will hold your key files.
-
-To generate TLS keys:
-
-Create new empty index and serial files (once only)
-1. vars
-2. clean-all
-
-Build a CA key (once only)
-1. vars
-2. build-ca
-
-Build a DH file (for server side, once only)
-1. vars
-2. build-dh
-
-Build a private key/certficate for the openvpn server
-1. vars
-2. build-key-server <machine-name>
-
-Build key files in PEM format (for each client machine)
-1. vars
-2. build-key <machine-name>
-   (use <machine name> for specific name within script)
-
-or
-
-Build key files in PKCS #12 format (for each client machine)
-1. vars
-2. build-key-pkcs12 <machine-name>
-   (use <machine name> for specific name within script)
-
-To revoke a TLS certificate and generate a CRL file:
-1. vars
-2. revoke-full <machine-name>
-3. verify last line of output confirms revokation
-4. copy crl.pem to server directory and ensure config file uses "crl-verify <crl filename>"
diff --git a/easy-rsa/Windows/build-ca-pass.bat b/easy-rsa/Windows/build-ca-pass.bat
deleted file mode 100644
index ab0b2a4..0000000
--- a/easy-rsa/Windows/build-ca-pass.bat
+++ /dev/null
@@ -1,8 +0,0 @@
-@...1657... off
-cd %HOME%
-rem build a request for a cert that will be valid for ten years
-openssl req -days 3650 -new -keyout %KEY_DIR%\%1.key -out %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem sign the cert request with our ca, creating a cert/key pair
-openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem delete any .old files created in this process, to avoid future file creation errors
-del /q %KEY_DIR%\*.old
diff --git a/easy-rsa/Windows/build-ca.bat b/easy-rsa/Windows/build-ca.bat
deleted file mode 100644
index a3f234b..0000000
--- a/easy-rsa/Windows/build-ca.bat
+++ /dev/null
@@ -1,4 +0,0 @@
-@...1657... off
-cd %HOME%
-rem build a cert authority valid for ten years, starting now
-openssl req -days 3650 -nodes -new -x509 -keyout %KEY_DIR%\ca.key -out %KEY_DIR%\ca.crt -config %KEY_CONFIG%
diff --git a/easy-rsa/Windows/build-dh.bat b/easy-rsa/Windows/build-dh.bat
deleted file mode 100644
index 74bc603..0000000
--- a/easy-rsa/Windows/build-dh.bat
+++ /dev/null
@@ -1,4 +0,0 @@
-@...1657... off
-cd %HOME%
-rem build a dh file for the server side
-openssl dhparam -out %KEY_DIR%/dh%KEY_SIZE%.pem %KEY_SIZE%
diff --git a/easy-rsa/Windows/build-key-pass.bat b/easy-rsa/Windows/build-key-pass.bat
deleted file mode 100644
index ab0b2a4..0000000
--- a/easy-rsa/Windows/build-key-pass.bat
+++ /dev/null
@@ -1,8 +0,0 @@
-@...1657... off
-cd %HOME%
-rem build a request for a cert that will be valid for ten years
-openssl req -days 3650 -new -keyout %KEY_DIR%\%1.key -out %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem sign the cert request with our ca, creating a cert/key pair
-openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem delete any .old files created in this process, to avoid future file creation errors
-del /q %KEY_DIR%\*.old
diff --git a/easy-rsa/Windows/build-key-pkcs12.bat b/easy-rsa/Windows/build-key-pkcs12.bat
deleted file mode 100644
index 1fc083e..0000000
--- a/easy-rsa/Windows/build-key-pkcs12.bat
+++ /dev/null
@@ -1,10 +0,0 @@
-@...1657... off
-cd %HOME%
-rem build a request for a cert that will be valid for ten years
-openssl req -days 3650 -nodes -new -keyout %KEY_DIR%\%1.key -out %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem sign the cert request with our ca, creating a cert/key pair
-openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem convert the key/cert and embed the ca cert into a pkcs12 file.
-openssl pkcs12 -export -inkey %KEY_DIR%\%1.key -in %KEY_DIR%\%1.crt -certfile %KEY_DIR%\ca.crt -out %KEY_DIR%\%1.p12
-rem delete any .old files created in this process, to avoid future file creation errors
-del /q %KEY_DIR%\*.old
diff --git a/easy-rsa/Windows/build-key-server-pass.bat b/easy-rsa/Windows/build-key-server-pass.bat
deleted file mode 100644
index 99ed4d3..0000000
--- a/easy-rsa/Windows/build-key-server-pass.bat
+++ /dev/null
@@ -1,8 +0,0 @@
-@...1657... off
-cd %HOME%
-rem build a request for a cert that will be valid for ten years
-openssl req -days 3650 -new -keyout %KEY_DIR%\%1.key -out %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem sign the cert request with our ca, creating a cert/key pair
-openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr -extensions server -config %KEY_CONFIG%
-rem delete any .old files created in this process, to avoid future file creation errors
-del /q %KEY_DIR%\*.old
diff --git a/easy-rsa/Windows/build-key-server.bat b/easy-rsa/Windows/build-key-server.bat
deleted file mode 100644
index 20e3605..0000000
--- a/easy-rsa/Windows/build-key-server.bat
+++ /dev/null
@@ -1,8 +0,0 @@
-@...1657... off
-cd %HOME%
-rem build a request for a cert that will be valid for ten years
-openssl req -days 3650 -nodes -new -keyout %KEY_DIR%\%1.key -out %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem sign the cert request with our ca, creating a cert/key pair
-openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr -extensions server -config %KEY_CONFIG%
-rem delete any .old files created in this process, to avoid future file creation errors
-del /q %KEY_DIR%\*.old
diff --git a/easy-rsa/Windows/build-key.bat b/easy-rsa/Windows/build-key.bat
deleted file mode 100644
index c040904..0000000
--- a/easy-rsa/Windows/build-key.bat
+++ /dev/null
@@ -1,8 +0,0 @@
-@...1657... off
-cd %HOME%
-rem build a request for a cert that will be valid for ten years
-openssl req -days 3650 -nodes -new -keyout %KEY_DIR%\%1.key -out %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem sign the cert request with our ca, creating a cert/key pair
-openssl ca -days 3650 -out %KEY_DIR%\%1.crt -in %KEY_DIR%\%1.csr -config %KEY_CONFIG%
-rem delete any .old files created in this process, to avoid future file creation errors
-del /q %KEY_DIR%\*.old
diff --git a/easy-rsa/Windows/clean-all.bat b/easy-rsa/Windows/clean-all.bat
deleted file mode 100644
index 71cbf4d..0000000
--- a/easy-rsa/Windows/clean-all.bat
+++ /dev/null
@@ -1,13 +0,0 @@
-@...1657... off
-rem move to the HOME directory specified in VARS script
-cd %HOME%
-rem set a temporary KEY_DIR variable
-set d=%KEY_DIR%
-rem delete the KEY_DIR and any subdirs quietly
-rmdir /s /q %d%
-rem make a new KEY_DIR
-mkdir %d%
-rem copy in a fesh index file so we begin with an empty database
-copy index.txt.start %d%\index.txt
-rem copy in a fresh serial file so we begin generating keys at index 01
-copy serial.start %d%\serial.
diff --git a/easy-rsa/Windows/index.txt.start b/easy-rsa/Windows/index.txt.start
deleted file mode 100644
index e69de29..0000000
diff --git a/easy-rsa/Windows/init-config.bat b/easy-rsa/Windows/init-config.bat
deleted file mode 100755
index 12e6d78..0000000
--- a/easy-rsa/Windows/init-config.bat
+++ /dev/null
@@ -1 +0,0 @@
-copy vars.bat.sample vars.bat
diff --git a/easy-rsa/Windows/revoke-full.bat b/easy-rsa/Windows/revoke-full.bat
deleted file mode 100644
index ef2e4b5..0000000
--- a/easy-rsa/Windows/revoke-full.bat
+++ /dev/null
@@ -1,13 +0,0 @@
-@...1657... off
-cd %HOME%
-rem revoke cert
-openssl ca -revoke %KEY_DIR%\%1.crt -config %KEY_CONFIG%
-rem generate new crl
-openssl ca -gencrl -out %KEY_DIR%\crl.pem -config %KEY_CONFIG%
-rem test revocation
-rem first concatinate ca cert with newly generated crl
-copy %KEY_DIR%\ca.crt+%KEY_DIR%\crl.pem %KEY_DIR%\revoke_test_file.pem
-rem now verify the revocation
-openssl verify -CAfile %KEY_DIR%\revoke_test_file.pem -crl_check %KEY_DIR%\%1.crt
-rem delete temporary test file
-del /q %KEY_DIR%\revoke_test_file.pem
diff --git a/easy-rsa/Windows/serial.start b/easy-rsa/Windows/serial.start
deleted file mode 100644
index 8a0f05e..0000000
--- a/easy-rsa/Windows/serial.start
+++ /dev/null
@@ -1 +0,0 @@
-01
diff --git a/easy-rsa/Windows/vars.bat.sample b/easy-rsa/Windows/vars.bat.sample
deleted file mode 100644
index 36e6f71..0000000
--- a/easy-rsa/Windows/vars.bat.sample
+++ /dev/null
@@ -1,40 +0,0 @@
-@...1657... off
-rem Edit this variable to point to
-rem the openssl.cnf file included
-rem with easy-rsa.
-
-set HOME=%ProgramFiles%\OpenVPN\easy-rsa
-set KEY_CONFIG=openssl-1.0.0.cnf
-
-rem Edit this variable to point to
-rem your soon-to-be-created key
-rem directory.
-rem
-rem WARNING: clean-all will do
-rem a rm -rf on this directory
-rem so make sure you define
-rem it correctly!
-set KEY_DIR=keys
-
-rem Increase this to 2048 if you
-rem are paranoid.  This will slow
-rem down TLS negotiation performance
-rem as well as the one-time DH parms
-rem generation process.
-set KEY_SIZE=1024
-
-rem These are the default values for fields
-rem which will be placed in the certificate.
-rem Change these to reflect your site.
-rem Don't leave any of these parms blank.
-
-set KEY_COUNTRY=US
-set KEY_PROVINCE=CA
-set KEY_CITY=SanFrancisco
-set KEY_ORG=OpenVPN
-set KEY_EMAIL=mail@...1470...
-set KEY_CN=changeme
-set KEY_NAME=changeme
-set KEY_OU=changeme
-set PKCS11_MODULE_PATH=changeme
-set PKCS11_PIN=1234
diff --git a/openvpn.spec.in b/openvpn.spec.in
index 9a45c79..a2f0cb1 100644
--- a/openvpn.spec.in
+++ b/openvpn.spec.in
@@ -222,7 +222,7 @@ fi
 %endif
 
 # Install extra %doc stuff
-%doc contrib/ easy-rsa/ sample-*/ plugins/README.*
+%doc contrib/ sample-*/ plugins/README.*
 
 %changelog
 * Thu Jul 30 2009 David Sommerseth <dazo@...384...>
-- 
1.7.3.4


