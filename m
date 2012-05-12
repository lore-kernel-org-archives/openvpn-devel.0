From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:41 +0300
Message-Id: <1336850389-23719-9-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 08/16] cleanup: syshead: move sleep, random,
	syshead.h emulation to compat
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

---
 src/compat/compat.h   |    6 ++++++
 src/openvpn/syshead.h |    3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/compat/compat.h b/src/compat/compat.h
index 021573e..7d91277 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -41,6 +41,12 @@
 #include <sys/socket.h>
 #endif
 
+#ifdef WIN32
+#define sleep(x) Sleep((x)*1000)
+#define random rand
+#define srandom srand
+#endif
+
 #ifndef HAVE_DIRNAME
 char * dirname(char *str);
 #endif /* HAVE_DIRNAME */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 98d6023..db39625 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -31,9 +31,6 @@
 #ifdef WIN32
 #include <windows.h>
 #include <winsock2.h>
-#define sleep(x) Sleep((x)*1000)
-#define random rand
-#define srandom srand
 #endif
 
 #ifdef HAVE_SYS_TYPES_H
-- 
1.7.3.4


