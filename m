From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:22:18 +0200
Message-Id: <1330546942-18250-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
References: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [openvpn-gui 4/8] cleanup: add missing stdlib.h
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
 proxy.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/proxy.c b/proxy.c
index 9750046..af575f6 100644
--- a/proxy.c
+++ b/proxy.c
@@ -26,6 +26,7 @@
 #include <prsht.h>
 #include <tchar.h>
 #include <wininet.h>
+#include <stdlib.h>
 
 #include "config.h"
 #include "main.h"
-- 
1.7.3.4


