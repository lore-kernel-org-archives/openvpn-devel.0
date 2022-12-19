From: Arne Schwabe <arne@...1227...>
Date: Mon, 19 Dec 2022 18:21:41 +0100
Message-Id: <20221219172141.2565798-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Use include "buffer.h" instead of include
 <buffer.h>
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

My own non-standard cmake based build system found this one. But
even if this is not a problem with the normal autoconf based system
we should still be consistent.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_freebsd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 0d059ddaf..2e35f3ace 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -22,7 +22,7 @@
 
 #if defined(ENABLE_DCO) && defined(TARGET_FREEBSD)
 
-#include <buffer.h>
+#include "buffer.h"
 #include "event.h"
 
 #include "ovpn_dco_freebsd.h"
-- 
2.37.1 (Apple Git-137.1)


