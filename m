From: Julien Muchembled <jm@...1926...>
Date: Fri, 16 Dec 2016 17:32:18 +0100
Message-Id: <20161216163218.25449-1-jm@...1926...>
Subject: [Openvpn-devel] [PATCH] Fix implicit declarations when
	HAVE_OPENSSL_ENGINE is unset
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
Cc: kirr@...1926...

This fixes a regression in commit 8e95e20913:
on amd64, an implicit declaration of ERR_error_string leads to segfaults
if the returned pointer does not fit in an 'int'.

Trac: #792

Signed-off-by: Julien Muchembled <jm@...1926...>
---
This patch is for the 2.3 branch. In the master branch,
crypto_openssl.c already includes these files.

 src/openvpn/crypto_openssl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 7b1ac6c..fe22044 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -45,6 +45,8 @@
 #include <openssl/objects.h>
 #include <openssl/evp.h>
 #include <openssl/des.h>
+#include <openssl/err.h>
+#include <openssl/rand.h>
 
 /*
  * Check for key size creepage.
-- 
2.10.2.2.g19ca937.dirty


