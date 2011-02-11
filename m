From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:39 +0200
Message-Id: <1297436985-18991-7-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 07/13] Added command-line switch to
	win/build_all.py to skip TAP driver building
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

Modified win/build_all.py so that by giving -n or --notap switch the TAP driver
is not built. This is useful if using prebuilt TAP drivers, or when WinDDK is
not installed.
---
 win/build_all.py |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/win/build_all.py b/win/build_all.py
index dec3a78..2c4d1aa 100644
--- a/win/build_all.py
+++ b/win/build_all.py
@@ -11,6 +11,7 @@ def Usage():
     print
     print " -h, --help		Show this help"
     print " -u, --unsigned	Do not sign the TAP drivers"
+    print " -n, --notap		Don't build the TAP driver"
     sys.exit(1)
 
 def main(config):
@@ -18,9 +19,12 @@ def main(config):
     # Do a signed build by default
     signedBuild=True
 
+    # Build the TAP driver by default
+    tap=True
+
     # Parse the command line argument(s)
     try:
-       opts, args = getopt.getopt(sys.argv[1:], "hu", ["help", "unsigned"])
+       opts, args = getopt.getopt(sys.argv[1:], "hun", ["help", "unsigned", "notap"])
     except getopt.GetoptError:
        Usage()
 
@@ -29,7 +33,8 @@ def main(config):
           Usage()
        if o in ("-u", "--unsigned"):
           signedBuild=False
-
+       if o in ("-n", "--notap"):
+          tap=False
 
     # Check if the SignTool module is present. This avoids ImportErrors popping
     # up annoyingly _after_ the build.
@@ -45,8 +50,12 @@ def main(config):
     # Start the build
     config_all(config)
     build_openvpn()
-    build_ddk(config, 'tap', 'all')
-    build_ddk(config, 'tapinstall', 'all')
+
+    if tap:
+       build_ddk(config, 'tap', 'all')
+       build_ddk(config, 'tapinstall', 'all')
+    else:
+       print "Not building the TAP driver"
 
     if signedBuild:
        sign(config, 'all')
@@ -54,6 +63,6 @@ def main(config):
     make_dist(config)
 
 # if we are run directly, and not loaded as a module
-if __name__ == "__main__":
-    from wb import config
-    main(config)
+if __name__ == "__main__":
+    from wb import config
+    main(config)
-- 
1.6.3.3


