From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 31 Aug 2011 14:38:08 +0000
Message-Id: <1314801488-25380-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] lowercase include header name in syshead.h
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

Cross compiling for Windows is broken since commit
739fa9881f12e67dc8b9cadc7230e59e7fe42423 added the mixed
case header name "NtDDNdis.h" to the file. While this header
exists in a MinGW build environment it's lowercase there.

Windows doesn't mind the case of a file name, but Linux does.
So, lowercasing the filename will make openvpn build in both
worlds.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 syshead.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/syshead.h b/syshead.h
index 87cc369..e208d4c 100644
--- a/syshead.h
+++ b/syshead.h
@@ -342,7 +342,7 @@
 
 #ifdef WIN32
 #include <iphlpapi.h>
-#include <NtDDNdis.h>
+#include <ntddndis.h>
 #include <wininet.h>
 /* The following two headers are needed of PF_INET6 */
 #include <winsock2.h>
-- 
1.7.5.4


