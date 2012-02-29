From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:37:28 +0200
Message-Id: <1330547854-18889-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [tap-windows 05/11] build: set default to newer ddk
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/prototypes.h |    2 +-
 src/tapdrvr.c    |    5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/prototypes.h b/src/prototypes.h
index 55454d5..18c566f 100755
--- a/src/prototypes.h
+++ b/src/prototypes.h
@@ -202,7 +202,7 @@ VOID HookDispatchFunctions();
 
 #if ENABLE_NONADMIN
 
-#if DDKVER_MAJOR < 5600
+#if defined(DDKVER_MAJOR) && DDKVER_MAJOR < 5600
 /*
  * Better solution for use on Vista DDK, but possibly not compatible with
  * earlier DDKs:
diff --git a/src/tapdrvr.c b/src/tapdrvr.c
index 0df076a..0f75b77 100755
--- a/src/tapdrvr.c
+++ b/src/tapdrvr.c
@@ -36,9 +36,6 @@
 //======================================================
 
 #include "common.h"
-#ifndef DDKVER_MAJOR
-#error DDKVER_MAJOR must be defined as the major number of the DDK Version
-#endif
 
 #define NDIS_MINIPORT_DRIVER
 #define BINARY_COMPATIBLE 0
@@ -66,7 +63,7 @@
 //========================================================
 #define ENABLE_NONADMIN 1
 
-#if DDKVER_MAJOR < 5600
+#if defined(DDKVER_MAJOR) && DDKVER_MAJOR < 5600
 #include <ndis.h>
 #include <ntstrsafe.h>
 #include <ntddk.h>
-- 
1.7.3.4


