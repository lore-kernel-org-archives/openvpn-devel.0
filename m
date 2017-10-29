Message-ID: <1509291288.3116.14.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 29 Oct 2017 15:34:48 +0000
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] autoconf: Fix engine checks for openssl 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

In openssl 1.1, ENGINE_cleanup became a #define instead of a function
(because it's no longer needed as engines are self cleaning).  Update
the autoconf.ac script to check for ENGINE_cleanup as a declaration to
avoid falsely underfinig HAVE_OPENSSL_ENGINE in openssl 1.1+

Signed-off-by: James Bottomley <James.Bottomley@...2316...>
---
 configure.ac | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 6f59baef..45aa5017 100644
--- a/configure.ac
+++ b/configure.ac
@@ -899,6 +899,13 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 		,
 		[have_openssl_engine="no"; break]
 	)
+	if test "${have_openssl_engine}" = "no"; then
+		AC_CHECK_DECL( [ENGINE_cleanup], [have_openssl_engine="yes"],,
+			[[
+				#include <openssl/engine.h>
+			]]
+		)
+	fi
 	if test "${have_openssl_engine}" = "yes"; then
 		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
 	fi
-- 
2.12.3

