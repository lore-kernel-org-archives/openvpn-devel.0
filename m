From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 25 Oct 2023 14:19:28 +0200
Message-Id: <20231025121928.1031109-1-frank@...2641...>
In-Reply-To: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
References: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] Update README.mbedtls
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
Cc: Max Fillinger <max@...2606...>

From: Max Fillinger <max@...2606...>

Change-Id: Ia61c467d85d690752011bafcf112e39d5b252aa7
Signed-off-by: Max Fillinger <max@...2606...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/372
This mail reflects revision 8 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/README.mbedtls b/README.mbedtls
index d3466fa..9b75c2b 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -1,13 +1,13 @@
-This version of OpenVPN has mbed TLS support. To enable follow the following
-instructions:
+This version of OpenVPN has mbed TLS support. To enable, follow the
+instructions below:
 
-To Build and Install,
+To build and install,
 
 	./configure --with-crypto-library=mbedtls
 	make
 	make install
 
-This version depends on mbed TLS 2.0 (and requires at least 2.0.0).
+This version requires mbed TLS version >= 2.0.0 or >= 3.2.1.
 
 *************************************************************************
 
@@ -16,7 +16,8 @@
 As of mbed TLS 2.17, it can be licensed *only* under the Apache v2.0 license.
 That license is incompatible with OpenVPN's GPLv2.
 
-If you wish to distribute OpenVPN linked with mbed TLS, there are two options:
+We are currently in the process of resolving this problem, but for now, if you
+wish to distribute OpenVPN linked with mbed TLS, there are two options:
 
  * Ensure that your case falls under the system library exception in GPLv2, or
 
@@ -24,9 +25,6 @@
    that may be licensed under GPLv2. Unfortunately, this version is
    unsupported and won't receive any more updates.
 
-If nothing changes about the license situation, mbed TLS support may be
-deprecated in a future release of OpenVPN.
-
 *************************************************************************
 
 Due to limitations in the mbed TLS library, the following features are missing
@@ -42,3 +40,22 @@
  * X.509 subject line has a different format than the OpenSSL subject line
  * X.509 certificate export does not work
  * X.509 certificate tracking
+
+*************************************************************************
+
+Mbed TLS 3 supports the TLS 1.3 protocol, but the implementation is not yet
+complete. Therefore, using TLS 1.3 in the mbed TLS build of OpenVPN is not yet
+supported.
+
+Nevertheless, here are some pointers to make it work with mbed TLS 3.5.0:
+
+ * The stock configuration of mbed TLS does not support TLS 1.3. To enable it,
+   uncomment `#define MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h before
+   compiling the library.
+ * An OpenVPN client with mbed TLS cannot connect to a server with OpenSSL
+   using TLS 1.3.
+ * An OpenVPN client with OpenSSL *can* connect to a server using mbed TLS with
+   TLS 1.3, but *only* if `#define MBEDTLS_SSL_TLS1_3_COMPATIBILITY_MODE` has
+   been uncommented in mbedtls_config.h.
+
+Note that none of these limitations apply to TLS 1.2.

