From: Steffan Karger <steffan@...1856...>
Date: Sun,  1 Jun 2014 19:58:54 +0200
Message-Id: <1401645536-27849-4-git-send-email-steffan@...1856...>
In-Reply-To: <1401645536-27849-1-git-send-email-steffan@...1856...>
References: <1401645536-27849-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/5] Move #include "ssl_verify.h" from ssl.h
	to the source files that need it.
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/forward.c | 1 +
 src/openvpn/init.c    | 1 +
 src/openvpn/multi.c   | 1 +
 src/openvpn/options.c | 1 +
 src/openvpn/pf.c      | 2 +-
 src/openvpn/push.c    | 1 +
 src/openvpn/ssl.h     | 1 -
 7 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0ec00f3..8d524ce 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -39,6 +39,7 @@
 #include "ps.h"
 #include "dhcp.h"
 #include "common.h"
+#include "ssl_verify.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 467b98a..021b5ca 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -43,6 +43,7 @@
 #include "lladdr.h"
 #include "ping.h"
 #include "mstats.h"
+#include "ssl_verify.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2839b30..e451924 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -38,6 +38,7 @@
 #include "otime.h"
 #include "gremlin.h"
 #include "mstats.h"
+#include "ssl_verify.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 57f8949..206a091 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -56,6 +56,7 @@
 #include "helper.h"
 #include "manage.h"
 #include "forward.h"
+#include "ssl_verify.h"
 #include <ctype.h>
 
 #include "memdbg.h"
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 461beed..a3208db 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -35,8 +35,8 @@
 #if defined(ENABLE_PF)
 
 #include "init.h"
-
 #include "memdbg.h"
+#include "ssl_verify.h"
 
 #include "pf-inline.h"
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 606bb05..1de9f74 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -33,6 +33,7 @@
 #include "push.h"
 #include "options.h"
 #include "ssl.h"
+#include "ssl_verify.h"
 #include "manage.h"
 
 #include "memdbg.h"
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cd7cae2..aaecff4 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -44,7 +44,6 @@
 #include "plugin.h"
 
 #include "ssl_common.h"
-#include "ssl_verify.h"
 #include "ssl_backend.h"
 
 /* Used in the TLS PRF function */
-- 
1.9.1


