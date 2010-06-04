Date: Sat, 5 Jun 2010 00:49:39 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20100604224938.GA19956@...1375...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
Sender: Matthias Andree <mandree@...1376...>
Subject: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--dTy3Mrz/UPE2dbVg
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

based on a FreeBSD problem report, I am attaching a patch against the
2.1 branch to remove a bashism (source FILE needs to become . FILE) and
switch the shebang lines to /bin/sh.

Note that some parts of the scripts may be Solaris /bin/sh unfriendly,
for instance, Solaris's sh doesn't support test -e or [ -e. My patch
does not address this.

Please apply.

Best regards
Matthias Andree

--IS0zKkzwUGydFO0o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-2.1-nobash-easyrsa.patch"
Content-Transfer-Encoding: quoted-printable

Index: 2.0/build-ca
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-ca	(Revision 5689)
+++ 2.0/build-ca	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 #
 # Build a root certificate
Index: 2.0/inherit-inter
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/inherit-inter	(Revision 5689)
+++ 2.0/inherit-inter	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Build a new PKI which is rooted on an intermediate certificate generated
 # by ./build-inter or ./pkitool --inter from a parent PKI.  The new PKI sh=
ould
@@ -34,6 +34,6 @@
     cp "$PARENT_CA" "$KEY_DIR/$EXPORT_CA"
     cat "$KEY_DIR/ca.crt" >> "$KEY_DIR/$EXPORT_CA"
 else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
+    echo 'Please source the vars script first (i.e. ". ./vars")'
     echo 'Make sure you have edited it to reflect your configuration.'
 fi
Index: 2.0/pkitool
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/pkitool	(Revision 5689)
+++ 2.0/pkitool	(Arbeitskopie)
@@ -45,7 +45,7 @@
 need_vars()
 {
     echo '  Please edit the vars script to reflect your configuration,'
-    echo '  then source it with "source ./vars".'
+    echo '  then source it with ". ./vars".'
     echo '  Next, to start with a fresh PKI configuration and to delete an=
y'
     echo '  previous certificates and keys, run "./clean-all".'
     echo "  Finally, you can run this tool ($PROGNAME) to build certificat=
es/keys."
@@ -109,7 +109,7 @@
     echo "Typical usage for initial PKI setup.  Build myserver, client1, a=
nd client2 cert/keys."
     echo "Protect client2 key with a password.  Build DH parms.  Generated=
 files in ./keys :"
     echo "  [edit vars with your site-specific info]"
-    echo "  source ./vars"
+    echo "  . ./vars"
     echo "  ./clean-all"
     echo "  ./build-dh     -> takes a long time, consider backgrounding"
     echo "  ./$PROGNAME --initca"
@@ -117,7 +117,7 @@
     echo "  ./$PROGNAME client1"
     echo "  ./$PROGNAME --pass client2"
     echo "Typical usage for adding client cert to existing PKI:"
-    echo "  source ./vars"
+    echo "  . ./vars"
     echo "  ./$PROGNAME client-new"
 }
=20
Index: 2.0/build-req
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-req	(Revision 5689)
+++ 2.0/build-req	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Build a certificate signing request and private key.  Use this
 # when your root certificate and key is not available locally.
Index: 2.0/build-key
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-key	(Revision 5689)
+++ 2.0/build-key	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Make a certificate/private key pair using a locally generated
 # root certificate.
Index: 2.0/sign-req
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/sign-req	(Revision 5689)
+++ 2.0/sign-req	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Sign a certificate signing request (a .csr file)
 # with a local root certificate and key.
Index: 2.0/build-key-pkcs12
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-key-pkcs12	(Revision 5689)
+++ 2.0/build-key-pkcs12	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Make a certificate/private key pair using a locally generated
 # root certificate and convert it to a PKCS #12 file including the
Index: 2.0/clean-all
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/clean-all	(Revision 5689)
+++ 2.0/clean-all	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Initialize the $KEY_DIR directory.
 # Note that this script does a
@@ -11,6 +11,6 @@
 	touch "$KEY_DIR/index.txt" && \
 	echo 01 >"$KEY_DIR/serial"
 else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
+    echo 'Please source the vars script first (i.e. ". ./vars")'
     echo 'Make sure you have edited it to reflect your configuration.'
 fi
Index: 2.0/build-req-pass
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-req-pass	(Revision 5689)
+++ 2.0/build-req-pass	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Like build-req, but protect your private key
 # with a password.
Index: 2.0/build-dh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-dh	(Revision 5689)
+++ 2.0/build-dh	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Build Diffie-Hellman parameters for the server side
 # of an SSL/TLS connection.
@@ -6,6 +6,6 @@
 if [ -d $KEY_DIR ] && [ $KEY_SIZE ]; then
     $OPENSSL dhparam -out ${KEY_DIR}/dh${KEY_SIZE}.pem ${KEY_SIZE}
 else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
+    echo 'Please source the vars script first (i.e. ". ./vars")'
     echo 'Make sure you have edited it to reflect your configuration.'
 fi
Index: 2.0/list-crl
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/list-crl	(Revision 5689)
+++ 2.0/list-crl	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # list revoked certificates
=20
@@ -8,6 +8,6 @@
     cd "$KEY_DIR" && \
 	$OPENSSL crl -text -noout -in "$CRL"
 else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
+    echo 'Please source the vars script first (i.e. ". ./vars")'
     echo 'Make sure you have edited it to reflect your configuration.'
 fi
Index: 2.0/build-key-server
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-key-server	(Revision 5689)
+++ 2.0/build-key-server	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Make a certificate/private key pair using a locally generated
 # root certificate.
Index: 2.0/build-key-pass
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-key-pass	(Revision 5689)
+++ 2.0/build-key-pass	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Similar to build-key, but protect the private key
 # with a password.
Index: 2.0/revoke-full
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/revoke-full	(Revision 5689)
+++ 2.0/revoke-full	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # revoke a certificate, regenerate CRL,
 # and verify revocation
@@ -35,6 +35,6 @@
     # verify the revocation
     $OPENSSL verify -CAfile "$RT" -crl_check "$1.crt"
 else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
+    echo 'Please source the vars script first (i.e. ". ./vars")'
     echo 'Make sure you have edited it to reflect your configuration.'
 fi
Index: 2.0/README
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/README	(Revision 5689)
+++ 2.0/README	(Arbeitskopie)
@@ -188,7 +188,7 @@
       label  : PKCS#11 token label
 Notes:
   Please edit the vars script to reflect your configuration,
-  then source it with "source ./vars".
+  then source it with ". ./vars".
   Next, to start with a fresh PKI configuration and to delete any
   previous certificates and keys, run "./clean-all".
   Finally, you can run this tool (pkitool) to build certificates/keys.
@@ -217,7 +217,7 @@
 Typical usage for initial PKI setup.  Build myserver, client1, and client2=
 cert/keys.
 Protect client2 key with a password.  Build DH parms.  Generated files in =
=2E/keys :
   [edit vars with your site-specific info]
-  source ./vars
+  . ./vars
   ./clean-all
   ./build-dh     -> takes a long time, consider backgrounding
   ./pkitool --initca
@@ -225,5 +225,5 @@
   ./pkitool client1
   ./pkitool --pass client2
 Typical usage for adding client cert to existing PKI:
-  source ./vars
+  . ./vars
   ./pkitool client-new
Index: 2.0/build-inter
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.0/build-inter	(Revision 5689)
+++ 2.0/build-inter	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Make an intermediate CA certificate/private key pair using a locally gen=
erated
 # root certificate.

--IS0zKkzwUGydFO0o--

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (FreeBSD)

iEYEARECAAYFAkwJgwIACgkQvmGDOQUufZXl3ACfYA4Xgs5zvzF6/SRdbroTev8p
H8gAn14lF7FcBjQghedkdr3J5zIXt/iU
=P/5F
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--

