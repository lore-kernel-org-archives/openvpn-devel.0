From: Charles Duffy <charlesduffy@...296...>
Message-Id: <1098050475.13580.8.camel@...23...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_smtp.isgenesis.com-7286-1098050486-0001-2"
Subject: [Openvpn-devel] Simple patch to EasyRSA
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
Date: Sun Oct 17 15:02:26 2004
To: openvpn-devel@lists.sourceforge.net

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_smtp.isgenesis.com-7286-1098050486-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

The attached makes EasyRSA commands source the vars file themselves, if
they can find it.

--=_smtp.isgenesis.com-7286-1098050486-0001-2
Content-Type: text/x-patch; name="easy-rsa.diff"; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=easy-rsa.diff

diff -ru3 openvpn-2.0_beta11/easy-rsa/build-ca easy-rsa/build-ca
--- openvpn-2.0_beta11/easy-rsa/build-ca	Wed May  8 02:00:30 2002
+++ easy-rsa/build-ca	Thu Oct 14 14:52:36 2004
@@ -4,6 +4,10 @@
 # Build a root certificate
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $KEY_DIR; then
 	cd $KEY_DIR && \
 	openssl req -days 3650 -nodes -new -x509 -keyout ca.key -out ca.crt -config $KEY_CONFIG
diff -ru3 openvpn-2.0_beta11/easy-rsa/build-dh easy-rsa/build-dh
--- openvpn-2.0_beta11/easy-rsa/build-dh	Wed May  8 02:00:30 2002
+++ easy-rsa/build-dh	Thu Oct 14 14:52:44 2004
@@ -5,6 +5,10 @@
 # of an SSL/TLS connection.
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $KEY_DIR; then
     openssl dhparam -out ${KEY_DIR}/dh${KEY_SIZE}.pem ${KEY_SIZE}
 else
diff -ru3 openvpn-2.0_beta11/easy-rsa/build-inter easy-rsa/build-inter
--- openvpn-2.0_beta11/easy-rsa/build-inter	Thu Jul 18 16:05:30 2002
+++ easy-rsa/build-inter	Thu Oct 14 14:52:51 2004
@@ -5,6 +5,10 @@
 # root certificate.
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
         echo "usage: build-inter <name>";
         exit 1
diff -ru3 openvpn-2.0_beta11/easy-rsa/build-key easy-rsa/build-key
--- openvpn-2.0_beta11/easy-rsa/build-key	Wed May  8 02:00:30 2002
+++ easy-rsa/build-key	Thu Oct 14 14:53:02 2004
@@ -5,6 +5,10 @@
 # root certificate.
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
         echo "usage: build-key <name>";
         exit 1
diff -ru3 openvpn-2.0_beta11/easy-rsa/build-key-pass easy-rsa/build-key-pass
--- openvpn-2.0_beta11/easy-rsa/build-key-pass	Wed May  8 02:00:30 2002
+++ easy-rsa/build-key-pass	Thu Oct 14 14:53:09 2004
@@ -5,6 +5,10 @@
 # with a password.
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
         echo "usage: build-key-pass <name>";
         exit 1
diff -ru3 openvpn-2.0_beta11/easy-rsa/build-req easy-rsa/build-req
--- openvpn-2.0_beta11/easy-rsa/build-req	Wed May  8 02:00:30 2002
+++ easy-rsa/build-req	Thu Oct 14 14:53:16 2004
@@ -5,6 +5,10 @@
 # when your root certificate and key is not available locally.
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
     echo "usage: build-req <name>";
     exit 1
diff -ru3 openvpn-2.0_beta11/easy-rsa/build-req-pass easy-rsa/build-req-pass
--- openvpn-2.0_beta11/easy-rsa/build-req-pass	Wed May  8 02:00:30 2002
+++ easy-rsa/build-req-pass	Thu Oct 14 14:53:23 2004
@@ -5,6 +5,10 @@
 # with a password.
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
     echo "usage: build-req-pass <name>";
     exit 1
Only in easy-rsa: client-scripts
diff -ru3 openvpn-2.0_beta11/easy-rsa/list-crl easy-rsa/list-crl
--- openvpn-2.0_beta11/easy-rsa/list-crl	Mon Jun 14 19:01:13 2004
+++ easy-rsa/list-crl	Thu Oct 14 14:53:31 2004
@@ -5,6 +5,10 @@
 #
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
         echo "usage: list-crl <crlfile.pem>";
         exit 1
diff -ru3 openvpn-2.0_beta11/easy-rsa/make-crl easy-rsa/make-crl
--- openvpn-2.0_beta11/easy-rsa/make-crl	Wed Jun 30 09:05:52 2004
+++ easy-rsa/make-crl	Thu Oct 14 14:53:38 2004
@@ -5,6 +5,10 @@
 #
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
         echo "usage: make-crl <crlfile.pem>";
         exit 1
diff -ru3 openvpn-2.0_beta11/easy-rsa/revoke-crt easy-rsa/revoke-crt
--- openvpn-2.0_beta11/easy-rsa/revoke-crt	Wed Jun 30 09:05:52 2004
+++ easy-rsa/revoke-crt	Thu Oct 14 14:53:44 2004
@@ -5,6 +5,10 @@
 #
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
         echo "usage: revoke-crt <file.crt>";
         exit 1
diff -ru3 openvpn-2.0_beta11/easy-rsa/sign-req easy-rsa/sign-req
--- openvpn-2.0_beta11/easy-rsa/sign-req	Wed Aug  7 04:13:16 2002
+++ easy-rsa/sign-req	Thu Oct 14 14:53:50 2004
@@ -5,6 +5,10 @@
 # with a local root certificate and key.
 #
 
+if [ -f $(dirname $0)/vars ] ; then
+	source $(dirname $0)/vars
+fi
+
 if test $# -ne 1; then
         echo "usage: sign-req <name>";
         exit 1
diff -ru3 openvpn-2.0_beta11/easy-rsa/vars easy-rsa/vars

--=_smtp.isgenesis.com-7286-1098050486-0001-2--

