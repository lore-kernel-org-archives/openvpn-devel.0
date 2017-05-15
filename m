From: Matthias Andree <matthias.andree@...68...>
Date: Mon, 15 May 2017 23:48:45 +0200
Message-Id: <1494884925-12539-1-git-send-email-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH] Make openvpn-plugin.h self-contained again.
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

2.4.2 introduced a declaration that references size_t, so use the C99
way of declaring it, and add #include <stddef.h>.

Note this may break on non-C99-compliant versions of MS Visual Studio.

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 include/openvpn-plugin.h.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 5e6f874..aa71b49 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -44,6 +44,7 @@ typedef X509 openvpn_x509_cert_t;
 #endif
 
 #include <stdarg.h>
+#include <stddef.h>
 
 #ifdef __cplusplus
 extern "C" {
-- 
2.7.4


