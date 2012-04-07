From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat,  7 Apr 2012 20:42:27 +0300
Message-Id: <1333820547-9672-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] cleanup: remove C++ comments
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpnserv/openvpnserv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpnserv/openvpnserv.c b/src/openvpnserv/openvpnserv.c
index a9a9441..56f5a02 100755
--- a/src/openvpnserv/openvpnserv.c
+++ b/src/openvpnserv/openvpnserv.c
@@ -87,9 +87,9 @@ static HANDLE exit_event = NULL;
 /*
  * Message handling
  */
-#define M_INFO    (0)                                  // informational
-#define M_SYSERR  (MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) // error + system code
-#define M_ERR     (MSG_FLAGS_ERROR)                    // error
+#define M_INFO    (0)                                  /* informational */
+#define M_SYSERR  (MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) /* error + system code */
+#define M_ERR     (MSG_FLAGS_ERROR)                    /* error */
 
 /* write error to event log */
 #define MSG(flags, ...) \
-- 
1.7.3.4


