From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:43 +0200
Message-Id: <1297436985-18991-11-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 11/13] Several modifications to
	win/make_dist.py to allow building the NSI installer
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

Added copying of all remaining openvpn dependencies to dist directory so that
the NSI installer script (win/openvpn.nsi) can find and use them more easily.
This includes openvpn.exe, openvpnserv.exe, libpkcs11-helper-1.dll, openssl.exe,
and example files. The associated, external DDL/manifest files are copied also,
so that embedding them with mt.exe is easier. This is a temporary solution until
nmake makefiles are modified to automate this process, except for a few of the
library dependencies (lzo2.dll and libpkcs11-helper-1.dll).
---
 win/make_dist.py |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/win/make_dist.py b/win/make_dist.py
index a6a0563..ab54c2a 100644
--- a/win/make_dist.py
+++ b/win/make_dist.py
@@ -1,5 +1,5 @@
 import os
-from wb import home_fn, rm_rf, mkdir, cp_a, cp
+from wb import home_fn, rm_rf, mkdir, cp_a, cp, rename
 
 def main(config, tap=True):
     dist = config['DIST']
@@ -8,6 +8,7 @@ def main(config, tap=True):
     bin = os.path.join(dist, 'bin')
     i386 = os.path.join(dist, 'i386')
     amd64 = os.path.join(dist, 'amd64')
+    samples = os.path.join(dist, 'samples')
 
     # build dist and subdirectories
     rm_rf(dist)
@@ -16,15 +17,34 @@ def main(config, tap=True):
     if tap:
         mkdir(i386)
         mkdir(amd64)
+    mkdir(samples)
 
-    # copy openvpn.exe and manifest
+    # copy openvpn.exe, openvpnserv.exe and their manifests
     cp(home_fn('openvpn.exe'), bin)
     cp(home_fn('openvpn.exe.manifest'), bin)
+    cp(home_fn('service-win32/openvpnserv.exe'), bin)
+    cp(home_fn('service-win32/openvpnserv.exe.manifest'), bin)
+
+    # copy openvpn-gui
+    cp(home_fn(config['OPENVPN_GUI_DIR']+"/"+config['OPENVPN_GUI']), bin)
 
     # copy DLL dependencies
     cp(home_fn(config['LZO_DIR']+'/bin/lzo2.dll'), bin)
+    cp(home_fn(config['LZO_DIR']+'/bin/lzo2.dll.manifest'), bin)
     cp(home_fn(config['OPENSSL_DIR']+'/bin/libeay32.dll'), bin)
     cp(home_fn(config['OPENSSL_DIR']+'/bin/ssleay32.dll'), bin)
+    cp(home_fn(config['PKCS11_HELPER_DIR']+'/lib/libpkcs11-helper-1.dll'), bin)
+    cp(home_fn(config['PKCS11_HELPER_DIR']+'/lib/libpkcs11-helper-1.dll.manifest'), bin)
+
+    # copy OpenSSL utilities (=openvpn.exe)
+    cp(home_fn(config['OPENSSL_DIR']+'/bin/openssl.exe'), bin)
+
+    # copy sample config files; renaming is necessary due to openvpn.nsi script
+    cp(home_fn('install-win32/sample.ovpn'), samples)
+    cp(home_fn('sample-config-files/client.conf'), samples)
+    cp(home_fn('sample-config-files/server.conf'), samples)
+    rename(os.path.join(samples,'client.conf'), os.path.join(samples, 'client.ovpn'))
+    rename(os.path.join(samples,'server.conf'), os.path.join(samples, 'server.ovpn'))
 
     # copy MSVC CRT
     cp_a(home_fn(config['MSVC_CRT']), bin)
@@ -40,16 +60,18 @@ def main(config, tap=True):
                         cp(os.path.join(dir, f), dest)
                 break
 
-        # copy tapinstall
+        # Copy tapinstall.exe (usually known as devcon.exe)
         dest = {'amd64' : amd64, 'i386' : i386}
         for dirpath, dirnames, filenames in os.walk(home_fn('tapinstall')):
             for f in filenames:
                 if f == 'tapinstall.exe':
+		    # dir_name is either i386 or amd64
                     dir_name = os.path.basename(dirpath)
                     src = os.path.join(dirpath, f)
                     if dir_name in dest:
                         cp(src, dest[dir_name])
 
+
 # if we are run directly, and not loaded as a module
 if __name__ == "__main__":
     from wb import config
-- 
1.6.3.3


