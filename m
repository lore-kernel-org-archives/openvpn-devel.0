From: David Sommerseth <davids@...515...>
Date: Tue, 22 Aug 2017 13:47:15 +0200
Message-Id: <20170822114715.14225-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] docs: Replace all PolarSSL references to
 mbed TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

There were references in our documentation to the now deprecated PolarSSL
library, which have changed name upstream to mbed TLS.

In addition, where appropriate, the documentation now considers only
mbed TLS 2.0 and newer.  This is in accordance with the requirements
./configure sets.

Signed-off-by: David Sommerseth <davids@...515...>
---
 INSTALL                           |  4 ++--
 README.polarssl => README.mbedtls | 10 +++++-----
 doc/doxygen/doc_data_crypto.h     |  2 +-
 doc/doxygen/doc_key_generation.h  |  6 +++---
 doc/openvpn.8                     | 16 +++++++---------
 5 files changed, 18 insertions(+), 20 deletions(-)
 rename README.polarssl => README.mbedtls (65%)

diff --git a/INSTALL b/INSTALL
index 97070604..3a31e6f1 100644
--- a/INSTALL
+++ b/INSTALL
@@ -75,8 +75,8 @@ REQUIRES:
 OPTIONAL (but recommended):
   (1) OpenSSL library, necessary for encryption, version 0.9.8 or higher
       required, available from http://www.openssl.org/
-  (2) PolarSSL library, an alternative for encryption, version 1.1 or higher
-      required, available from https://polarssl.org/
+  (2) mbed TLS library, an alternative for encryption, version 2.0 or higher
+      required, available from https://tls.mbed.org/
   (3) LZO real-time compression library, required for link compression,
       available from http://www.oberhumer.com/opensource/lzo/
       OpenBSD users can use ports or packages to install lzo, but remember
diff --git a/README.polarssl b/README.mbedtls
similarity index 65%
rename from README.polarssl
rename to README.mbedtls
index 6f1fa51a..4875822d 100644
--- a/README.polarssl
+++ b/README.mbedtls
@@ -1,18 +1,18 @@
-This version of OpenVPN has PolarSSL support. To enable follow the following
+This version of OpenVPN has mbed TLS support. To enable follow the following
 instructions:
 
 To Build and Install,
 
-	./configure --with-crypto-library=polarssl
+	./configure --with-crypto-library=mbedtls
 	make
 	make install
 
-This version depends on PolarSSL 1.3 (and requires at least 1.3.3).
+This version depends on mbed TLS 2.0 (and requires at least 2.0.0).
 
 *************************************************************************
 
-Due to limitations in the PolarSSL library, the following features are missing
-in the PolarSSL version of OpenVPN:
+Due to limitations in the mbed TLS library, the following features are missing
+in the mbed TLS version of OpenVPN:
 
  * PKCS#12 file support
  * --capath support - Loading certificate authorities from a directory
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index 925fcd52..c2b1866c 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -68,5 +68,5 @@
  *
  * @par Crypto algorithms
  * This module uses the crypto algorithm implementations of the external
- * crypto library (currently either OpenSSL (default), or PolarSSL).
+ * crypto library (currently either OpenSSL (default), or mbed TLS).
  */
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index 4b225e09..4109ac5d 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -78,7 +78,7 @@
  *
  * @subsection key_generation_random Source of random material
  *
- * OpenVPN uses the either the OpenSSL library or the PolarSSL library as its
+ * OpenVPN uses the either the OpenSSL library or the mbed TLS library as its
  * source of random material.
  *
  * In OpenSSL, the \c RAND_bytes() function is called
@@ -91,8 +91,8 @@
  * - For OpenSSL's support for external crypto modules:
  *   http://www.openssl.org/docs/crypto/engine.html
  *
- * In PolarSSL, the Havege random number generator is used. For details, see
- * the PolarSSL documentation.
+ * In mbed TLS, the Havege random number generator is used. For details, see
+ * the mbed TLS documentation.
  *
  * @section key_generation_exchange Key exchange:
  *
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 04ff9cb5..5f6f2db1 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4472,7 +4472,7 @@ datagram replay protection as the IV.
 .\"*********************************************************
 .TP
 .B \-\-use\-prediction\-resistance
-Enable prediction resistance on PolarSSL's RNG.
+Enable prediction resistance on mbed TLS's RNG.
 
 Enabling prediction resistance causes the RNG to reseed in each
 call for random. Reseeding this often can quickly deplete the kernel
@@ -4481,8 +4481,6 @@ entropy pool.
 If you need this option, please consider running a daemon that adds
 entropy to the kernel pool.
 
-Note that this option only works with PolarSSL versions greater
-than 1.1.
 .\"*********************************************************
 .TP
 .B \-\-test\-crypto
@@ -4583,7 +4581,7 @@ they are distributed with OpenVPN, they are totally insecure.
 .TP
 .B \-\-capath dir
 Directory containing trusted certificates (CAs and CRLs).
-Not available with PolarSSL.
+Not available with mbed TLS.
 
 When using the
 .B \-\-capath
@@ -4612,7 +4610,7 @@ Set
 .B file=none
 to disable Diffie Hellman key exchange (and use ECDH only). Note that this
 requires peers to be using an SSL library that supports ECDH TLS cipher suites
-(e.g. OpenSSL 1.0.1+, or PolarSSL 1.3+).
+(e.g. OpenSSL 1.0.1+, or mbed TLS 2.0+).
 
 Use
 .B openssl dhparam \-out dh2048.pem 2048
@@ -4717,7 +4715,7 @@ This option can be used instead of
 .B \-\-ca, \-\-cert,
 and
 .B \-\-key.
-Not available with PolarSSL.
+Not available with mbed TLS.
 .\"*********************************************************
 .TP
 .B \-\-verify\-hash hash [algo]
@@ -4900,7 +4898,7 @@ channel, over which the keys that are used to protect the actual VPN traffic
 are exchanged.
 
 The supplied list of ciphers is (after potential OpenSSL/IANA name translation)
-simply supplied to the crypto library.  Please see the OpenSSL and/or PolarSSL
+simply supplied to the crypto library.  Please see the OpenSSL and/or mbed TLS
 documentation for details on the cipher list interpretation.
 
 Use
@@ -4913,8 +4911,8 @@ is an expert feature, which - if used correcly - can improve the security of
 your VPN connection.  But it is also easy to unwittingly use it to carefully
 align a gun with your foot, or just break your connection.  Use with care!
 
-The default for \-\-tls\-cipher is to use PolarSSL's default cipher list
-when using PolarSSL or
+The default for \-\-tls\-cipher is to use mbed TLS's default cipher list
+when using mbed TLS or
 "DEFAULT:!EXP:!LOW:!MEDIUM:!kDH:!kECDH:!DSS:!PSK:!SRP:!kRSA" when using
 OpenSSL.
 .\"*********************************************************
-- 
2.13.5


