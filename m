From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:41 +0200
Message-Id: <1297436985-18991-9-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 09/13] Added openvpnserv.exe building to
	win/build.py
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

Made win/build.py call nmake in service-win32 directory to build openvpnserv.exe
after main build (openvpn.exe) has finished.
---
 win/build.py |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/win/build.py b/win/build.py
index 3a9fbc7..1861377 100644
--- a/win/build.py
+++ b/win/build.py
@@ -1,18 +1,25 @@
 import os, sys
-from wb import system, config, home_fn, cd_home
+from wb import system, config, home_fn, cd_home, cd_service_win32
 
 os.environ['PATH'] += ";%s\\VC" % (os.path.normpath(config['MSVC']),)
 
 def build_vc(cmd):
+    """Make sure environment variables are setup before build"""
     system('cmd /c "vcvarsall.bat x86 && %s"' % (cmd,))
 
 def main():
+    """Build openvpn.exe and openvpnserv.exe"""
     cd_home()
     build_vc("nmake /f %s" % (home_fn('msvc.mak'),))
+    cd_service_win32()
+    build_vc("nmake /f %s" % ('msvc.mak'))
 
 def clean():
+    """Clean up after openvpn.exe and openvpnserv.exe build"""
     cd_home()
     build_vc("nmake /f %s clean" % (home_fn('msvc.mak'),))
+    os.chdir("service-win32")
+    build_vc("nmake /f %s clean" % ('msvc.mak'))
 
 # if we are run directly, and not loaded as a module
 if __name__ == "__main__":
-- 
1.6.3.3


