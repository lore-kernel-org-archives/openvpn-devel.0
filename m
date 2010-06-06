Date: Sun, 6 Jun 2010 13:57:13 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20100606115713.GA1409@...33...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
Subject: Re: [Openvpn-devel] PATCH v2: remove bashisms from easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>, openvpn devel <openvpn-devel@lists.sourceforge.net>

--CblX+4bnyfN0pR09
Content-Type: multipart/mixed; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Disposition: inline

Am 05.06.2010, 22:23 Uhr, schrieb David Sommerseth:

> On 05/06/10 00:49, Matthias Andree wrote:
>> Note that some parts of the scripts may be Solaris /bin/sh unfriendly,
>> for instance, Solaris's sh doesn't support test -e or [ -e. My patch
>> does not address this.
>
> This makes me very reluctant from accepting the patch, to be very
> honest.  I'd rather keep the current bashism which works on all
> platforms where bash is available than to apply a patch which will break
> the script from working on one of the supported platforms.

This wasn't a regression in my patches, but a defect in easy-rsa. Solaris
doesn't have /bin/bash either, so all ./build-foo would break anyways, and
pkitool doesn't work on Solaris anyways in its current shape.

Try the attached patch that should increase the Solaris compatibility. It
replaces my earlier patch.

Notably, we require explicit sh prefix in all documentation (I hope I
haven't overlooked something - please check), and pkitool tries to
re-exec itself under /usr/xpg4/bin/sh if it exists and if a
shell-compliance test fails.  We also patch a proper Standards PATH from
./vars.

This is because Solaris /bin/sh would otherwise complain that OPENSSL=...
weren't a valid identifier.

--
Matthias Andree

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="easy-rsa.patch"
Content-Transfer-Encoding: quoted-printable

Index: easy-rsa/2.0/build-ca
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-ca	(Revision 5690)
+++ easy-rsa/2.0/build-ca	(Arbeitskopie)
@@ -1,8 +1,8 @@
-#!/bin/bash
+#!/bin/sh
=20
 #
 # Build a root certificate
 #
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --initca $*
+sh "$EASY_RSA/pkitool" --interact --initca "$@"
Index: easy-rsa/2.0/pkitool
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/pkitool	(Revision 5690)
+++ easy-rsa/2.0/pkitool	(Arbeitskopie)
@@ -30,6 +30,23 @@
 # Calling scripts can also set the KEY_NAME environmental
 # variable to set the "name" X509 subject field.
=20
+# force proper shell under Solaris:
+if ( export FOO=3Dbar >/dev/null 2>&1 ) ; then
+    : success
+else
+    if [ -x /usr/xpg4/bin/sh ] ; then
+	exec /usr/xpg4/bin/sh "$0" "$@"
+    else
+	if [ "_$KEYS_DIR" !=3D "_" ] ; then
+	    echo >&2 "Your sh is not POSIX compliant. You must use a POSIX"
+	    echo >&2 "compliant shell for easy-rsa.  Aborting."
+	else
+	    echo >&2 "Please source the vars file first, type: . ./vars"
+	fi
+	exit 1
+    fi
+fi
+
 PROGNAME=3Dpkitool
 VERSION=3D2.0
 DEBUG=3D0
@@ -45,9 +62,9 @@
 need_vars()
 {
     echo '  Please edit the vars script to reflect your configuration,'
-    echo '  then source it with "source ./vars".'
+    echo '  then source it with ". ./vars".'
     echo '  Next, to start with a fresh PKI configuration and to delete an=
y'
-    echo '  previous certificates and keys, run "./clean-all".'
+    echo '  previous certificates and keys, run "sh ./clean-all".'
     echo "  Finally, you can run this tool ($PROGNAME) to build certificat=
es/keys."
 }
=20
@@ -94,31 +111,31 @@
     echo "  .csr files -> certificate signing request (not directly used b=
y OpenVPN)"
     echo "  dh1024.pem or dh2048.pem -> Diffie Hellman parameters (--dh)"
     echo "Examples:"
-    echo "  $PROGNAME --initca          -> Build root certificate"
-    echo "  $PROGNAME --initca --pass   -> Build root certificate with pas=
sword-protected key"
-    echo "  $PROGNAME --server server1  -> Build \"server1\" certificate/k=
ey"
-    echo "  $PROGNAME client1           -> Build \"client1\" certificate/k=
ey"
-    echo "  $PROGNAME --pass client2    -> Build password-protected \"clie=
nt2\" certificate/key"
-    echo "  $PROGNAME --pkcs12 client3  -> Build \"client3\" certificate/k=
ey in PKCS#12 format"
-    echo "  $PROGNAME --csr client4     -> Build \"client4\" CSR to be sig=
ned by another CA"
-    echo "  $PROGNAME --sign client4    -> Sign \"client4\" CSR"
-    echo "  $PROGNAME --inter interca   -> Build an intermediate key-signi=
ng certificate/key"
-    echo "                               Also see ./inherit-inter script."
-    echo "  $PROGNAME --pkcs11 /usr/lib/pkcs11/lib1 0 010203 \"client5 id\=
" client5"
-    echo "                              -> Build \"client5\" certificate/k=
ey in PKCS#11 token"
+    echo "  sh $PROGNAME --initca          -> Build root certificate"
+    echo "  sh $PROGNAME --initca --pass   -> Build root certificate with =
password-protected key"
+    echo "  sh $PROGNAME --server server1  -> Build \"server1\" certificat=
e/key"
+    echo "  sh $PROGNAME client1           -> Build \"client1\" certificat=
e/key"
+    echo "  sh $PROGNAME --pass client2    -> Build password-protected \"c=
lient2\" certificate/key"
+    echo "  sh $PROGNAME --pkcs12 client3  -> Build \"client3\" certificat=
e/key in PKCS#12 format"
+    echo "  sh $PROGNAME --csr client4     -> Build \"client4\" CSR to be =
signed by another CA"
+    echo "  sh $PROGNAME --sign client4    -> Sign \"client4\" CSR"
+    echo "  sh $PROGNAME --inter interca   -> Build an intermediate key-si=
gning certificate/key"
+    printf '%s   Also see the ./inherit-inter script.\n' "$(echo "  sh $PR=
OGNAME --inter interca   " | sed -e 's/./ /g')"
+    echo "  sh $PROGNAME --pkcs11 /usr/lib/pkcs11/lib1 0 010203 \"client5 =
id\" client5"
+    printf '%s-> Build \"client5\" certificate/key in PKCS#11 token\n' "$(=
echo "  sh $PROGNAME --inter interca   " | sed -e 's/./ /g')"
     echo "Typical usage for initial PKI setup.  Build myserver, client1, a=
nd client2 cert/keys."
     echo "Protect client2 key with a password.  Build DH parms.  Generated=
 files in ./keys :"
     echo "  [edit vars with your site-specific info]"
-    echo "  source ./vars"
-    echo "  ./clean-all"
-    echo "  ./build-dh     -> takes a long time, consider backgrounding"
-    echo "  ./$PROGNAME --initca"
-    echo "  ./$PROGNAME --server myserver"
-    echo "  ./$PROGNAME client1"
-    echo "  ./$PROGNAME --pass client2"
+    echo "  . ./vars"
+    echo "  sh ./clean-all"
+    echo "  sh ./build-dh     -> takes a long time, consider backgrounding"
+    echo "  sh ./$PROGNAME --initca"
+    echo "  sh ./$PROGNAME --server myserver"
+    echo "  sh ./$PROGNAME client1"
+    echo "  sh ./$PROGNAME --pass client2"
     echo "Typical usage for adding client cert to existing PKI:"
-    echo "  source ./vars"
-    echo "  ./$PROGNAME client-new"
+    echo "  . ./vars"
+    echo "  sh ./$PROGNAME client-new"
 }
=20
 # Set tool defaults
Index: easy-rsa/2.0/inherit-inter
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/inherit-inter	(Revision 5690)
+++ easy-rsa/2.0/inherit-inter	(Arbeitskopie)
@@ -1,13 +1,13 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Build a new PKI which is rooted on an intermediate certificate generated
-# by ./build-inter or ./pkitool --inter from a parent PKI.  The new PKI sh=
ould
-# have independent vars settings, and must use a different KEY_DIR directo=
ry
-# from the parent.  This tool can be used to generate arbitrary depth
-# certificate chains.
+# by sh ./build-inter or sh ./pkitool --inter from a parent PKI.  The
+# new PKI should have independent vars settings, and must use a
+# different KEY_DIR directory from the parent.  This tool can be used to
+# generate arbitrary depth certificate chains.
 #
 # To build an intermediate CA, follow the same steps for a regular PKI but
-# replace ./build-key or ./pkitool --initca with this script.
+# replace sh ./build-key or sh ./pkitool --initca with this script.
=20
 # The EXPORT_CA file will contain the CA certificate chain and should be
 # referenced by the OpenVPN "ca" directive in config files.  The ca.crt fi=
le
@@ -34,6 +34,6 @@
     cp "$PARENT_CA" "$KEY_DIR/$EXPORT_CA"
     cat "$KEY_DIR/ca.crt" >> "$KEY_DIR/$EXPORT_CA"
 else
-    echo 'Please source the vars script first (i.e. "source ./vars")'
+    echo 'Please source the vars script first (i.e. ". ./vars")'
     echo 'Make sure you have edited it to reflect your configuration.'
 fi
Index: easy-rsa/2.0/build-req
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-req	(Revision 5690)
+++ easy-rsa/2.0/build-req	(Arbeitskopie)
@@ -1,7 +1,7 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Build a certificate signing request and private key.  Use this
 # when your root certificate and key is not available locally.
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --csr $*
+sh "$EASY_RSA/pkitool" --interact --csr "$@"
Index: easy-rsa/2.0/sign-req
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/sign-req	(Revision 5690)
+++ easy-rsa/2.0/sign-req	(Arbeitskopie)
@@ -1,7 +1,7 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Sign a certificate signing request (a .csr file)
 # with a local root certificate and key.
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --sign $*
+sh "$EASY_RSA/pkitool" --interact --sign "$@"
Index: easy-rsa/2.0/build-key
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-key	(Revision 5690)
+++ easy-rsa/2.0/build-key	(Arbeitskopie)
@@ -1,7 +1,7 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Make a certificate/private key pair using a locally generated
 # root certificate.
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact $*
+sh "$EASY_RSA/pkitool" --interact "$@"
Index: easy-rsa/2.0/build-key-pkcs12
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-key-pkcs12	(Revision 5690)
+++ easy-rsa/2.0/build-key-pkcs12	(Arbeitskopie)
@@ -1,8 +1,8 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Make a certificate/private key pair using a locally generated
 # root certificate and convert it to a PKCS #12 file including the
 # the CA certificate as well.
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --pkcs12 $*
+sh "$EASY_RSA/pkitool" --interact --pkcs12 "$@"
Index: easy-rsa/2.0/build-dh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-dh	(Revision 5690)
+++ easy-rsa/2.0/build-dh	(Arbeitskopie)
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
Index: easy-rsa/2.0/build-req-pass
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-req-pass	(Revision 5690)
+++ easy-rsa/2.0/build-req-pass	(Arbeitskopie)
@@ -1,7 +1,7 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Like build-req, but protect your private key
 # with a password.
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --csr --pass $*
+sh "$EASY_RSA/pkitool" --interact --csr --pass "$@"
Index: easy-rsa/2.0/clean-all
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/clean-all	(Revision 5690)
+++ easy-rsa/2.0/clean-all	(Arbeitskopie)
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
Index: easy-rsa/2.0/build-key-pass
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-key-pass	(Revision 5690)
+++ easy-rsa/2.0/build-key-pass	(Arbeitskopie)
@@ -1,7 +1,7 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Similar to build-key, but protect the private key
 # with a password.
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --pass $*
+sh "$EASY_RSA/pkitool" --interact --pass "$@"
Index: easy-rsa/2.0/build-key-server
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-key-server	(Revision 5690)
+++ easy-rsa/2.0/build-key-server	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Make a certificate/private key pair using a locally generated
 # root certificate.
@@ -7,4 +7,4 @@
 # extension in the openssl.cnf file.
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --server $*
+sh "$EASY_RSA/pkitool" --interact --server "$@"
Index: easy-rsa/2.0/list-crl
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/list-crl	(Revision 5690)
+++ easy-rsa/2.0/list-crl	(Arbeitskopie)
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
Index: easy-rsa/2.0/revoke-full
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/revoke-full	(Revision 5690)
+++ easy-rsa/2.0/revoke-full	(Arbeitskopie)
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
Index: easy-rsa/2.0/README
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/README	(Revision 5690)
+++ easy-rsa/2.0/README	(Arbeitskopie)
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
Index: easy-rsa/2.0/vars
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/vars	(Revision 5690)
+++ easy-rsa/2.0/vars	(Arbeitskopie)
@@ -39,7 +39,7 @@
 export KEY_DIR=3D"$EASY_RSA/keys"
=20
 # Issue rm -rf warning
-echo NOTE: If you run ./clean-all, I will be doing a rm -rf on $KEY_DIR
+echo "NOTE: If you run sh ./clean-all, I will be doing a rm -rf $KEY_DIR"
=20
 # PKCS11 fixes
 export PKCS11_MODULE_PATH=3D"dummy"
@@ -66,3 +66,27 @@
 export KEY_CITY=3D"SanFrancisco"
 export KEY_ORG=3D"Fort-Funston"
 export KEY_EMAIL=3D"me@...430..."
+
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+# #### NO USER SERVICEABLE PARTS BELOW THIS LINE ###
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+# patch POSIX shells into Solaris PATH
+# -- Matthias Andree, 2010
+case "`uname -s`" in
+SunOS)
+	case "$PATH" in
+	/usr/xpg6/bin:/usr/xpg4/bin:/usr/ccs/bin:/usr/bin*)
+	    # NOOP
+	    ;;
+	*)
+	    PATH=3D/usr/xpg6/bin:/usr/xpg4/bin:/usr/ccs/bin:/usr/bin:$PATH
+	    export PATH
+	    ;;
+	esac
+	echo
+	echo 'On Solaris, run all easy-rsa commands with "sh" prefixed,'
+	echo 'for instance:  sh build-keys'
+	echo 'DO NOT use /bin/sh, DO USE sh without directories!'
+	echo
+	;;
+esac
Index: easy-rsa/2.0/build-inter
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/2.0/build-inter	(Revision 5690)
+++ easy-rsa/2.0/build-inter	(Arbeitskopie)
@@ -1,7 +1,7 @@
-#!/bin/bash
+#!/bin/sh
=20
 # Make an intermediate CA certificate/private key pair using a locally gen=
erated
 # root certificate.
=20
 export EASY_RSA=3D"${EASY_RSA:-.}"
-"$EASY_RSA/pkitool" --interact --inter $*
+sh "$EASY_RSA/pkitool" --interact --inter "$@"
Index: easy-rsa/1.0/README
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/1.0/README	(Revision 5690)
+++ easy-rsa/1.0/README	(Arbeitskopie)
@@ -28,7 +28,7 @@
    participating in a secure SSL/TLS
    connection.
 5  . vars
-6. ./clean-all
+6. sh ./clean-all
 7. As you create certificates, keys, and
    certificate signing requests, understand that
    only .key files should be kept confidential.
@@ -40,20 +40,20 @@
=20
 BUILD YOUR OWN ROOT CERTIFICATE AUTHORITY (CA) CERTIFICATE/KEY
=20
-1. ./build-ca
+1. sh ./build-ca
 2. ca.crt and ca.key will be built in your KEY_DIR
    directory
=20
 BUILD AN INTERMEDIATE CERTIFICATE AUTHORITY CERTIFICATE/KEY (optional)
=20
-1. ./build-inter inter
+1. sh ./build-inter inter
 2. inter.crt and inter.key will be built in your KEY_DIR
    directory and signed with your root certificate.
=20
 BUILD DIFFIE-HELLMAN PARAMETERS (necessary for
 the server end of a SSL/TLS connection).
=20
-1. ./build-dh
+1. sh ./build-dh
=20
 BUILD A CERTIFICATE SIGNING REQUEST (If
 you want to sign your certificate with a root
@@ -72,7 +72,7 @@
    files match (such as with the command: "md5sum ca.crt").
 2. Choose a name for your certificate such as your computer
    name.  In our example we will use "mycert".
-3. ./build-req mycert
+3. sh ./build-req mycert
 4. You can ignore most of the fields, but set
    "Common Name" to something unique such as your
    computer's host name.  Leave all password
@@ -81,8 +81,8 @@
    is not required -- it will make your key more secure
    but also more inconvenient to use, because you will
    need to supply your password anytime the key is used.
-   NOTE: if you are using a password, use ./build-req-pass
-   instead of ./build-req
+   NOTE: if you are using a password, use sh ./build-req-pass
+   instead of sh ./build-req
 5. Your key will be written to $KEY_DIR/mycert.key
 6. Your certificate signing request will be written to
    to $KEY_DIR/mycert.csr
@@ -99,7 +99,7 @@
=20
 SIGN A CERTIFICATE SIGNING REQUEST
=20
-1. ./sign-req mycert
+1. sh ./sign-req mycert
 2. mycert.crt will be built in your KEY_DIR
    directory using mycert.csr and your root CA
    file as input.
@@ -111,13 +111,13 @@
 key files be copied to the destination host over a
 secure channel.
=20
-1. ./build-key mycert (no password protection)
-2. OR ./build-key-pass mycert (with password protection)
-3. OR ./build-key-pkcs12 mycert (PKCS #12 format)
-4. OR ./build-key-server mycert (with nsCertType=3Dserver)
+1. sh ./build-key mycert (no password protection)
+2. OR sh ./build-key-pass mycert (with password protection)
+3. OR sh ./build-key-pkcs12 mycert (PKCS #12 format)
+4. OR sh ./build-key-server mycert (with nsCertType=3Dserver)
 5. mycert.crt and mycert.key will be built in your
    KEY_DIR directory, and mycert.crt will be signed
-   by your root CA. If ./build-key-pkcs12 was used a
+   by your root CA. If sh ./build-key-pkcs12 was used a
    mycert.p12 file will also be created including the
    private key, certificate and the ca certificate.
=20
@@ -133,7 +133,7 @@
     script.  This will designate the certificate as a
     server-only certificate by setting nsCertType=3Dserver.
     Now add the following line to your client configuration:
-     =20
+
     ns-cert-type server
=20
     This will block clients from connecting to any
Index: easy-rsa/1.0/vars
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- easy-rsa/1.0/vars	(Revision 5690)
+++ easy-rsa/1.0/vars	(Arbeitskopie)
@@ -30,7 +30,7 @@
 export KEY_DIR=3D$D/keys
=20
 # Issue rm -rf warning
-echo NOTE: when you run ./clean-all, I will be doing a rm -rf on $KEY_DIR
+echo "NOTE: when you run sh ./clean-all, I will be doing a rm -rf $KEY_DIR"
=20
 # Increase this to 2048 if you
 # are paranoid.  This will slow
@@ -47,3 +47,31 @@
 export KEY_CITY=3DBISHKEK
 export KEY_ORG=3D"OpenVPN-TEST"
 export KEY_EMAIL=3D"me@...430..."
+
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+# #### NO USER SERVICEABLE PARTS BELOW THIS LINE ###
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+# patch POSIX shells into Solaris PATH
+# -- Matthias Andree, 2010
+case "`uname -s`" in
+SunOS)
+	case "$PATH" in
+	/usr/xpg6/bin:/usr/xpg4/bin:/usr/ccs/bin:/usr/bin*)
+	    # NOOP
+	    ;;
+	*)
+	    PATH=3D/usr/xpg6/bin:/usr/xpg4/bin:/usr/ccs/bin:/usr/bin:$PATH
+	    export PATH
+	    echo
+	    echo "expanding PATH to have standards-confirming shell"
+	    echo "NOTE: DO NOT run /bin/sh, DO USE sh."
+	    echo
+	    ;;
+	esac
+	echo
+	echo 'On Solaris, run all easy-rsa commands with "sh" prefixed,'
+	echo 'for instance:  sh build-keys'
+	echo 'DO NOT use /bin/sh, DO USE sh without directories!'
+	echo
+	;;
+esac

--K8nIJk4ghYZn606h--

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkwLjRkACgkQvmGDOQUufZWfgwCeJY4LAPKkEvYqSU++s1to/eWG
dB0AmwZm/0zA7sAyXsdHwKW3NtNGNOEE
=fg7b
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

