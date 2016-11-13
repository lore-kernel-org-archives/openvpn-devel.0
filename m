From: Gert Doering <gert@...1296...>
Date: Sun, 13 Nov 2016 20:36:45 +0100
Message-Id: <20161113193645.73523-1-gert@...1296...>
In-Reply-To: <1479060203-4472-1-git-send-email-steffan@...1856...>
References: <1479060203-4472-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix compilation on MinGW with -std=c99
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

commit 9223336a88bc moved the CFLAGS="-std=c99" bit in configure.ac
before the "socklen_t" test, which relies on #ifdef WIN32 to decide
whether to include <ws2tcpip.h> or <sys/socket.h> - which is no longer
defined then, and things explode in interesting ways.

Change to _WIN32, which is the "always defined on all compilers" define
for this.

Signed-off-by: Gert Doering <gert@...1296...>
---
 m4/ax_socklen_t.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/m4/ax_socklen_t.m4 b/m4/ax_socklen_t.m4
index cd7cad8..b420a17 100644
--- a/m4/ax_socklen_t.m4
+++ b/m4/ax_socklen_t.m4
@@ -55,7 +55,7 @@ getpeername(0,0,&len);
 		],
 		[[
 #include <sys/types.h>
-#ifdef WIN32
+#ifdef _WIN32
 #include <ws2tcpip.h>
 #else
 #include <sys/socket.h>
-- 
1.9.1


