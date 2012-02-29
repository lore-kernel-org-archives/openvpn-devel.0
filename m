From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:22:16 +0200
Message-Id: <1330546942-18250-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
References: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [openvpn-gui 2/8] cleanup: resolve warnings missing
	malloc include
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
 localization.c |    1 +
 manage.c       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/localization.c b/localization.c
index eb541fc..3a6be38 100644
--- a/localization.c
+++ b/localization.c
@@ -28,6 +28,7 @@
 #include <tchar.h>
 #include <stdio.h>
 #include <stdarg.h>
+#include <malloc.h>
 
 #include "config.h"
 #include "main.h"
diff --git a/manage.c b/manage.c
index 54f024e..15f5493 100644
--- a/manage.c
+++ b/manage.c
@@ -20,6 +20,7 @@
  */
 
 #include <winsock2.h>
+#include <malloc.h>
 
 #include "options.h"
 #include "main.h"
-- 
1.7.3.4


