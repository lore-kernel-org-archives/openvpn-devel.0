From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:36 +0300
Message-Id: <1336850389-23719-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 03/16] cleanup: syshead: remove useless
	WIN32_0_1
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/syshead.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 91a23d3..99a6674 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -439,16 +439,6 @@
 #endif
 
 /*
- * Define a boolean value based
- * on Win32 status.
- */
-#ifdef WIN32
-#define WIN32_0_1 1
-#else
-#define WIN32_0_1 0
-#endif
-
-/*
  * Our socket descriptor type.
  */
 #ifdef WIN32
-- 
1.7.3.4


