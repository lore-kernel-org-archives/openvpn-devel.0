From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 28 Feb 2010 22:12:03 +0100
Message-Id: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] bash->bourne script cleanup
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
To: openvpn-devel@lists.sourceforge.net
Cc: Dan Nelson <dnelson@...384...>, David Sommerseth <dazo@...384...>

From: Dan Nelson <dnelson@...384...>

Many of the scripts in the openvpn source have their shell set to
/bin/bash, but only two use bash features. The attached patch (against
openvpn-2.1_rc9) sets the shell on the rest of the scripts to /bin/sh for
better portability. The only scripts that actually require bash are
contrib/pull-resolv-conf/client.{up,down} ; they use the ${!var} variable
indirection feature.

sf.net tracker:
<https://sourceforge.net/tracker/?func=detail&aid=2040296&group_id=48978&atid=454721>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 easy-rsa/2.0/build-ca           |    2 +-
 easy-rsa/2.0/build-dh           |    2 +-
 easy-rsa/2.0/build-inter        |    2 +-
 easy-rsa/2.0/build-key          |    2 +-
 easy-rsa/2.0/build-key-pass     |    2 +-
 easy-rsa/2.0/build-key-pkcs12   |    2 +-
 easy-rsa/2.0/build-key-server   |    2 +-
 easy-rsa/2.0/build-req          |    2 +-
 easy-rsa/2.0/build-req-pass     |    2 +-
 easy-rsa/2.0/clean-all          |    2 +-
 easy-rsa/2.0/inherit-inter      |    2 +-
 easy-rsa/2.0/list-crl           |    2 +-
 easy-rsa/2.0/revoke-full        |    2 +-
 easy-rsa/2.0/sign-req           |    2 +-
 sample-config-files/firewall.sh |    2 +-
 sample-scripts/bridge-start     |    2 +-
 sample-scripts/bridge-stop      |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/easy-rsa/2.0/build-ca b/easy-rsa/2.0/build-ca
index fb1e2ca..bce29a6 100755
--- a/easy-rsa/2.0/build-ca
+++ b/easy-rsa/2.0/build-ca
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 #
 # Build a root certificate
diff --git a/easy-rsa/2.0/build-dh b/easy-rsa/2.0/build-dh
index f019222..4beb127 100755
--- a/easy-rsa/2.0/build-dh
+++ b/easy-rsa/2.0/build-dh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Build Diffie-Hellman parameters for the server side
 # of an SSL/TLS connection.
diff --git a/easy-rsa/2.0/build-inter b/easy-rsa/2.0/build-inter
index f831d6f..87bf98d 100755
--- a/easy-rsa/2.0/build-inter
+++ b/easy-rsa/2.0/build-inter
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Make an intermediate CA certificate/private key pair using a locally generated
 # root certificate.
diff --git a/easy-rsa/2.0/build-key b/easy-rsa/2.0/build-key
index 6196308..6c0fed8 100755
--- a/easy-rsa/2.0/build-key
+++ b/easy-rsa/2.0/build-key
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Make a certificate/private key pair using a locally generated
 # root certificate.
diff --git a/easy-rsa/2.0/build-key-pass b/easy-rsa/2.0/build-key-pass
index 35543e0..8ef8307 100755
--- a/easy-rsa/2.0/build-key-pass
+++ b/easy-rsa/2.0/build-key-pass
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Similar to build-key, but protect the private key
 # with a password.
diff --git a/easy-rsa/2.0/build-key-pkcs12 b/easy-rsa/2.0/build-key-pkcs12
index 5ef064f..ba90e6a 100755
--- a/easy-rsa/2.0/build-key-pkcs12
+++ b/easy-rsa/2.0/build-key-pkcs12
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Make a certificate/private key pair using a locally generated
 # root certificate and convert it to a PKCS #12 file including the
diff --git a/easy-rsa/2.0/build-key-server b/easy-rsa/2.0/build-key-server
index 5502675..fee0194 100755
--- a/easy-rsa/2.0/build-key-server
+++ b/easy-rsa/2.0/build-key-server
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Make a certificate/private key pair using a locally generated
 # root certificate.
diff --git a/easy-rsa/2.0/build-req b/easy-rsa/2.0/build-req
index 26587d1..559d512 100755
--- a/easy-rsa/2.0/build-req
+++ b/easy-rsa/2.0/build-req
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Build a certificate signing request and private key.  Use this
 # when your root certificate and key is not available locally.
diff --git a/easy-rsa/2.0/build-req-pass b/easy-rsa/2.0/build-req-pass
index 6e6c863..b73ee1b 100755
--- a/easy-rsa/2.0/build-req-pass
+++ b/easy-rsa/2.0/build-req-pass
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Like build-req, but protect your private key
 # with a password.
diff --git a/easy-rsa/2.0/clean-all b/easy-rsa/2.0/clean-all
index 0576db5..cc6e3b2 100755
--- a/easy-rsa/2.0/clean-all
+++ b/easy-rsa/2.0/clean-all
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Initialize the $KEY_DIR directory.
 # Note that this script does a
diff --git a/easy-rsa/2.0/inherit-inter b/easy-rsa/2.0/inherit-inter
index 2101951..aaa5168 100755
--- a/easy-rsa/2.0/inherit-inter
+++ b/easy-rsa/2.0/inherit-inter
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Build a new PKI which is rooted on an intermediate certificate generated
 # by ./build-inter or ./pkitool --inter from a parent PKI.  The new PKI should
diff --git a/easy-rsa/2.0/list-crl b/easy-rsa/2.0/list-crl
index afc0cd6..d1d8a69 100755
--- a/easy-rsa/2.0/list-crl
+++ b/easy-rsa/2.0/list-crl
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # list revoked certificates
 
diff --git a/easy-rsa/2.0/revoke-full b/easy-rsa/2.0/revoke-full
index efc94e8..4169c4c 100755
--- a/easy-rsa/2.0/revoke-full
+++ b/easy-rsa/2.0/revoke-full
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # revoke a certificate, regenerate CRL,
 # and verify revocation
diff --git a/easy-rsa/2.0/sign-req b/easy-rsa/2.0/sign-req
index 38655d3..6cae7b4 100755
--- a/easy-rsa/2.0/sign-req
+++ b/easy-rsa/2.0/sign-req
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # Sign a certificate signing request (a .csr file)
 # with a local root certificate and key.
diff --git a/sample-config-files/firewall.sh b/sample-config-files/firewall.sh
index f0db806..19d75ee 100755
--- a/sample-config-files/firewall.sh
+++ b/sample-config-files/firewall.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # A Sample OpenVPN-aware firewall.
 
diff --git a/sample-scripts/bridge-start b/sample-scripts/bridge-start
index bfbbdc5..d20a260 100755
--- a/sample-scripts/bridge-start
+++ b/sample-scripts/bridge-start
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 #################################
 # Set up Ethernet bridge on Linux
diff --git a/sample-scripts/bridge-stop b/sample-scripts/bridge-stop
index d452893..8192779 100755
--- a/sample-scripts/bridge-stop
+++ b/sample-scripts/bridge-stop
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 ####################################
 # Tear Down Ethernet bridge on Linux
-- 
1.6.6.1


