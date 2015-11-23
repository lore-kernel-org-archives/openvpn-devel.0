From: <steffan.karger@...1435...>
Date: Mon, 23 Nov 2015 11:26:24 +0100
Message-ID: <1448274384-22953-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] polarssl: require >= 1.3.8
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

From: Steffan Karger <steffan.karger@...1435...>

Since commit 67a67e39, we use API calls that were introduced in polarssl
1.3.8.  Update the configure check to reflect that.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3424584..d3cacc8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -871,13 +871,13 @@ if test "${with_crypto_library}" = "polarssl" ; then
 #include <polarssl/version.h>
 			]],
 			[[
-#if POLARSSL_VERSION_NUMBER < 0x01030300 || POLARSSL_VERSION_NUMBER >= 0x01040000
+#if POLARSSL_VERSION_NUMBER < 0x01030800 || POLARSSL_VERSION_NUMBER >= 0x01040000
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([PolarSSL 1.3.x required and must be 1.3.3 or later])]
+		[AC_MSG_ERROR([PolarSSL 1.3.x required and must be 1.3.8 or later])]
 	)
 
 	polarssl_with_pkcs11="no"
-- 
2.1.4


