From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  4 Aug 2022 17:03:00 +0200
Message-Id: <20220804150301.62856-1-frank@...2641...>
In-Reply-To: <YukYNOwpaIeA7j80@...1296...>
References: <YukYNOwpaIeA7j80@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] config-version.h: remove unused includes
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

We only need to include this when we want the
git version. This is currently only the case
in options.c

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/block_dns.c | 3 ---
 src/openvpn/plugin.c    | 3 ---
 src/tapctl/main.c       | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index 88e933fb..7849ec53 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -28,9 +28,6 @@
 #elif defined(_MSC_VER)
 #include "config-msvc.h"
 #endif
-#ifdef HAVE_CONFIG_VERSION_H
-#include "config-version.h"
-#endif
 
 #include "syshead.h"
 
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 51136fea..dc7fd459 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -26,9 +26,6 @@
 #elif defined(_MSC_VER)
 #include "config-msvc.h"
 #endif
-#ifdef HAVE_CONFIG_VERSION_H
-#include "config-version.h"
-#endif
 
 #include "syshead.h"
 
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index df73a965..e13549bf 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -24,9 +24,6 @@
 #elif defined(_MSC_VER)
 #include <config-msvc.h>
 #endif
-#ifdef HAVE_CONFIG_VERSION_H
-#include <config-version.h>
-#endif
 
 #include "tap.h"
 #include "error.h"
-- 
2.34.1


