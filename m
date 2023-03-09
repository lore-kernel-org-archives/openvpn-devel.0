From: Kristof Provost <kprovost@...2661...>
Date: Thu,  9 Mar 2023 13:23:32 +0100
Message-Id: <20230309122332.92490-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: print FreeBSD version
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

Implement dco_version_string() for FreeBSD.
Unlike Linux and Windows the DCO driver is built into the operating
system itself, so we log the OS version as a proxy for the DCO version.
---
 src/openvpn/dco_freebsd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 2b94b2a2..5238ebdd 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -31,6 +31,8 @@
 #include <sys/param.h>
 #include <sys/linker.h>
 #include <sys/nv.h>
+#include <sys/utsname.h>
+
 #include <netinet/in.h>
 
 #include "dco_freebsd.h"
@@ -627,7 +629,15 @@ out:
 const char *
 dco_version_string(struct gc_arena *gc)
 {
-    return "v0";
+    struct utsname* uts;
+    ALLOC_OBJ_GC(uts, struct utsname, gc);
+
+    if (uname(uts) != 0)
+    {
+        return "N/A";
+    }
+
+    return uts->version;
 }
 
 void
-- 
2.39.2


