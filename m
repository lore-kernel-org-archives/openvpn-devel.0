From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 12:02:18 +0300
Message-Id: <1336813338-9219-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: detect sys/wait.h required for *bsd
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
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 901a916..4592727 100644
--- a/configure.ac
+++ b/configure.ac
@@ -374,7 +374,7 @@ AC_CHECK_HEADERS([ \
 ])
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
-	sys/mman.h sys/file.h \
+	sys/mman.h sys/file.h sys/wait.h \
 	unistd.h signal.h libgen.h stropts.h \
 	syslog.h pwd.h grp.h \
 	sys/sockio.h sys/uio.h linux/sockios.h \
-- 
1.7.3.4


