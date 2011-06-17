From: samuli@...515...
Date: Fri, 17 Jun 2011 12:18:02 +0300
Message-Id: <1308302282-27985-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH] Fix a build-ca issue on Windows
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

From: Samuli SeppÃ¤nen <samuli@...515...>

Fixes Trac ticket #125
---
 easy-rsa/Windows/init-config.bat |    1 -
 win/openvpn.nsi                  |    5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/easy-rsa/Windows/init-config.bat b/easy-rsa/Windows/init-config.bat
index 048d558..12e6d78 100755
--- a/easy-rsa/Windows/init-config.bat
+++ b/easy-rsa/Windows/init-config.bat
@@ -1,2 +1 @@
 copy vars.bat.sample vars.bat
-copy openssl.cnf.sample openssl.cnf
diff --git a/win/openvpn.nsi b/win/openvpn.nsi
index d3f80d0..82be118 100755
--- a/win/openvpn.nsi
+++ b/win/openvpn.nsi
@@ -272,8 +272,9 @@ Section "${PRODUCT_NAME} RSA Certificate Management Scripts" SecOpenVPNEasyRSA
 
   # FIXME: the easy-rsa directory would need cleaning up
 
-  # Original nsi script looked for openssl.cnf.sample
-  File "${EASYRSA}\2.0\openssl.cnf"
+  # Original nsi script looked for ${EASYRSA}\2.0\openssl.cnf.sample. A newer 
+  # openssl.cnf is needed on OpenVPN 2.2+.
+  File "${EASYRSA}\Windows\openssl.cnf"
 
   File "${EASYRSA}\Windows\vars.bat.sample"
 
-- 
1.7.4.1


