From: Juliusz Sosinowicz <juliusz@...2525...>
Date: Fri, 19 Mar 2021 14:43:22 +0100
Message-Id: <20210319134322.131905-1-juliusz@...2525...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] README.wolfssl Update
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

Updates for the wolfSSL README file:
- fix typos
- correct wolfSSL company spelling
- add a point of contact for users having problems using OpenVPN + wolfSSL

Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
---
 README.wolfssl | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/README.wolfssl b/README.wolfssl
index d417807b..a5dfe31f 100644
--- a/README.wolfssl
+++ b/README.wolfssl
@@ -1,10 +1,11 @@
-Support for WolfSSL is implemented and maintained by WolfSSL Inc. The support is
-implemented using WolfSSL's compatiblity layer. The WolfSSL support in OpenVPN
+Support for wolfSSL is implemented and maintained by wolfSSL Inc. The support is
+implemented using wolfSSL's compatibility layer. The wolfSSL support in OpenVPN
 receives very limited testing/support from the OpenVPN community itself.
 
-If bugs in OpenVPN when using WolfSSL are encountered, the user should try to
-also compile OpenVPN with OpenSSL to determinate if these are bugs in the
-WolfSSL TLS implemenation or OpenVPN itself.
+If bugs in OpenVPN when using wolfSSL are encountered, the user should try to
+also compile OpenVPN with OpenSSL to determine if these are bugs in the
+wolfSSL TLS implementation or OpenVPN itself. If bugs are caused by compiling
+with wolfSSL, please contact support@...2525... directly.
 
 To Build and Install,
 
@@ -21,7 +22,7 @@ make
 make install
 
 *************************************************************************
-Due to limitations in the wolfSSL TLS library or its compability layer, the
+Due to limitations in the wolfSSL TLS library or its compatibility layer, the
 following features are missing
 
  * blowfish support (BF-CBC), you must use something like
-- 
2.25.1


