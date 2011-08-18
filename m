From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 18 Aug 2011 12:17:50 +0000
Message-Id: <1313669870-32067-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] add .gitignore to official repository
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
Cc: =?UTF-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...1341...>

This .gitignore make the output of git status a lot more readable. It was
made from the dynamically generated files that showed after using both
build system.

Signed-off-by: Samuli Seppänen <samuli@...1341...>
Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 .gitignore |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..3d12f5d
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,40 @@
+*.[oa]
+*.dll
+*.exe
+*.mak
+*.obj
+*.pyc
+*.so
+.deps
+Makefile
+Makefile.in
+aclocal.m4
+autodefs.h
+autom4te.cache
+config.guess
+config.h
+config.h.in
+config.log
+config.status
+config.sub
+configure
+configure.h
+depcomp
+dist/
+install-sh
+install-win32/settings
+install-win32/tmp
+missing
+openvpn
+openvpn.8.html
+openvpn.exe.manifest
+openvpnserv.exe.manifest
+openvpn.spec
+stamp-h1
+t_client.sh
+tap-win32/SOURCES
+tap-win32/amd64/
+tap-win32/i386/
+tapinstall/
+vc90.idb
+win/version_m4_vars.tmp
-- 
1.7.5.4


