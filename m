From: <steffan.karger@...1435...>
Date: Tue, 22 Oct 2013 14:45:17 +0200
Message-ID: <1382445917-2974-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Require polarssl >= 1.2.10 for
	polarssl-builds, which fixes CVE-2013-5915.
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

PolarSSL 1.2.9 fixes a possible timing attack in PolarSSL's RSA-CRT
implementation. See CVE-2013-5915 for details. This commit bumps the
minimum polarssl version required by configure.ac to 1.2.10, because 1.2.9
also introduced a memory leak, which is fixed in 1.2.10.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index e0db333..9e666cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -809,13 +809,13 @@ if test "${with_crypto_library}" = "polarssl" ; then
 #include <polarssl/version.h>
 			]],
 			[[
-#if POLARSSL_VERSION_NUMBER < 0x01020500
+#if POLARSSL_VERSION_NUMBER < 0x01020A00
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([PolarSSL 1.2.5 or newer required])]
+		[AC_MSG_ERROR([PolarSSL 1.2.10 or newer required])]
 	)
 
 	polarssl_with_pkcs11="no"
-- 
1.8.1.2


