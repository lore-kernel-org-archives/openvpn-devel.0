From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Tue,  8 Mar 2011 16:07:49 +0200
Message-Id: <1299593269-10302-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH] Added support for prebuilt TAP-drivers.
	Automated embedding manifests.
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

Removed win/make_dist.py's dependency on TAP-driver and tapinstall.exe building.
Also added manifest embedding commands to win/make_dist.py. To avoid duplicate
code moved the "build_vc" method from win/build.py to win/wb.py and renamed it
"run_in_vs_shell".
---
 win/build.py     |   16 +++--------
 win/build_all.py |   13 +++++----
 win/make_dist.py |   75 +++++++++++++++++++++++++++++++++++++----------------
 win/settings.in  |    3 ++
 win/tap_span.py  |    2 +-
 win/wb.py        |    5 +++
 6 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/win/build.py b/win/build.py
index 1861377..43d7fc2 100644
--- a/win/build.py
+++ b/win/build.py
@@ -1,25 +1,19 @@
 import os, sys
-from wb import system, config, home_fn, cd_home, cd_service_win32
-
-os.environ['PATH'] += ";%s\\VC" % (os.path.normpath(config['MSVC']),)
-
-def build_vc(cmd):
-    """Make sure environment variables are setup before build"""
-    system('cmd /c "vcvarsall.bat x86 && %s"' % (cmd,))
+from wb import system, config, home_fn, cd_home, cd_service_win32, run_in_vs_shell
 
 def main():
     """Build openvpn.exe and openvpnserv.exe"""
     cd_home()
-    build_vc("nmake /f %s" % (home_fn('msvc.mak'),))
+    run_in_vs_shell("nmake /f %s" % (home_fn('msvc.mak'),))
     cd_service_win32()
-    build_vc("nmake /f %s" % ('msvc.mak'))
+    run_in_vs_shell("nmake /f %s" % ('msvc.mak'))
 
 def clean():
     """Clean up after openvpn.exe and openvpnserv.exe build"""
     cd_home()
-    build_vc("nmake /f %s clean" % (home_fn('msvc.mak'),))
+    run_in_vs_shell("nmake /f %s clean" % (home_fn('msvc.mak'),))
     os.chdir("service-win32")
-    build_vc("nmake /f %s clean" % ('msvc.mak'))
+    run_in_vs_shell("nmake /f %s clean" % ('msvc.mak'))
 
 # if we are run directly, and not loaded as a module
 if __name__ == "__main__":
diff --git a/win/build_all.py b/win/build_all.py
index 2c4d1aa..47716a1 100644
--- a/win/build_all.py
+++ b/win/build_all.py
@@ -54,13 +54,14 @@ def main(config):
     if tap:
        build_ddk(config, 'tap', 'all')
        build_ddk(config, 'tapinstall', 'all')
-    else:
-       print "Not building the TAP driver"
-
-    if signedBuild:
-       sign(config, 'all')
+       if signedBuild:
+          sign(config, 'all')
+       make_dist(config,tap=True)
 
-    make_dist(config)
+    else:
+       if 'TAP_PREBUILT' in config:
+          print "Using prebuilt TAP driver"
+          make_dist(config,tap=False)
 
 # if we are run directly, and not loaded as a module
 if __name__ == "__main__":
diff --git a/win/make_dist.py b/win/make_dist.py
index ab54c2a..746f6d9 100644
--- a/win/make_dist.py
+++ b/win/make_dist.py
@@ -1,5 +1,5 @@
 import os
-from wb import home_fn, rm_rf, mkdir, cp_a, cp, rename
+from wb import home_fn, rm_rf, mkdir, cp_a, cp, rename, run_in_vs_shell
 
 def main(config, tap=True):
     dist = config['DIST']
@@ -14,9 +14,8 @@ def main(config, tap=True):
     rm_rf(dist)
     mkdir(dist)
     mkdir(bin)
-    if tap:
-        mkdir(i386)
-        mkdir(amd64)
+    mkdir(i386)
+    mkdir(amd64)
     mkdir(samples)
 
     # copy openvpn.exe, openvpnserv.exe and their manifests
@@ -46,31 +45,61 @@ def main(config, tap=True):
     rename(os.path.join(samples,'client.conf'), os.path.join(samples, 'client.ovpn'))
     rename(os.path.join(samples,'server.conf'), os.path.join(samples, 'server.ovpn'))
 
+    # embed manifests to executables and DLLs
+    for f in [ "openvpn.exe", "openvpnserv.exe", "lzo2.dll", "libpkcs11-helper-1.dll" ]:
+
+        outputresource = os.path.join(bin,f)
+        manifest = outputresource+".manifest"
+
+        # EXEs and DLLs require slightly different treatment
+        if f.endswith(".exe"):
+            type = "1"
+        elif f.endswith(".dll"):
+            type = "2"
+        else:
+            print "ERROR: Could not embed manifest to "+outputresouce+", bailing out."
+            sys.exit(1)
+
+        # Embed the manifest
+        run_in_vs_shell('mt.exe -manifest %s -outputresource:%s;%s' % (manifest, outputresource, type))
+
     # copy MSVC CRT
     cp_a(home_fn(config['MSVC_CRT']), bin)
 
+    # TAP-driver and tapinstall.exe were built, so copy those over
     if tap:
-        # copy TAP drivers
-        for dir_name, dest in (('amd64', amd64), ('i386', i386)):
-            dir = home_fn(os.path.join('tap-win32', dir_name))
-            for dirpath, dirnames, filenames in os.walk(dir):
-                for f in filenames:
-                    root, ext = os.path.splitext(f)
-                    if ext in ('.inf', '.cat', '.sys'):
-                        cp(os.path.join(dir, f), dest)
-                break
-
-        # Copy tapinstall.exe (usually known as devcon.exe)
-        dest = {'amd64' : amd64, 'i386' : i386}
-        for dirpath, dirnames, filenames in os.walk(home_fn('tapinstall')):
+        drv_dir = 'tap-win32'
+        ti_dir = 'tapinstall'
+
+    # we're using prebuilt TAP-driver and tapinstall.exe
+    elif 'TAP_PREBUILT' in config:
+        drv_dir = config['TAP_PREBUILT']
+        ti_dir = config['TAP_PREBUILT']
+
+    else:
+        print "ERROR: Could not find prebuilt TAP-drivers or tapinstall.exe. Please check win/settings.in"
+        sys.exit(1)
+
+    # copy TAP drivers
+    for dir_name, dest in (('amd64', amd64), ('i386', i386)):
+        dir = home_fn(os.path.join(drv_dir, dir_name))
+        for dirpath, dirnames, filenames in os.walk(dir):
             for f in filenames:
-                if f == 'tapinstall.exe':
-		    # dir_name is either i386 or amd64
-                    dir_name = os.path.basename(dirpath)
-                    src = os.path.join(dirpath, f)
-                    if dir_name in dest:
-                        cp(src, dest[dir_name])
+                root, ext = os.path.splitext(f)
+                if ext in ('.inf', '.cat', '.sys'):
+                    cp(os.path.join(dir, f), dest)
+            break
 
+    # Copy tapinstall.exe (usually known as devcon.exe)
+    dest = {'amd64' : amd64, 'i386' : i386}
+    for dirpath, dirnames, filenames in os.walk(home_fn(ti_dir)):
+        for f in filenames:
+            if f == 'devcon.exe':
+                dir_name = os.path.basename(dirpath)
+                src = os.path.join(dirpath, f)
+                dst = os.path.join(dest[dir_name],'tapinstall.exe')
+                if dir_name in dest:
+                    cp(src, dst, dest_is_dir=False)
 
 # if we are run directly, and not loaded as a module
 if __name__ == "__main__":
diff --git a/win/settings.in b/win/settings.in
index 25109e2..6dded79 100644
--- a/win/settings.in
+++ b/win/settings.in
@@ -69,6 +69,9 @@
 !define SIGNTOOL        "../signtool"
 !define PRODUCT_SIGN_CN "openvpn"
 
+# Directory with prebuilt TAP drivers and tapinstall.exes
+!define TAP_PREBUILT "../tap-prebuilt"
+
 ; DEBUGGING -- set to something like "-DBG2"
 !define OUTFILE_LABEL ""
 
diff --git a/win/tap_span.py b/win/tap_span.py
index 9cd127b..cc28382 100644
--- a/win/tap_span.py
+++ b/win/tap_span.py
@@ -26,7 +26,7 @@ def copy_tapinstall(src, dest, x64):
     mkdir_silent(dest)
     for dirpath, dirnames, filenames in os.walk(home_fn(src)):
         for f in filenames:
-            if f == 'tapinstall.exe':
+            if f == 'devcon.exe':
                 dir_name = os.path.basename(dirpath)
                 s = os.path.join(dirpath, f)
                 if dir_name == base:
diff --git a/win/wb.py b/win/wb.py
index d4f8203..6023ee8 100644
--- a/win/wb.py
+++ b/win/wb.py
@@ -44,6 +44,11 @@ def system(cmd):
     print "RUN:", cmd
     os.system(cmd)
 
+def run_in_vs_shell(cmd):
+    """Make sure environment variables are setup before running command"""
+    os.environ['PATH'] += ";%s\\VC" % (os.path.normpath(config['MSVC']),)
+    system('cmd /c "vcvarsall.bat x86 && %s"' % (cmd,))
+
 def parse_version_m4(kv, version_m4):
     '''Parse define lines in version.m4'''
     r = re.compile(r'^define\((\w+),\[(.*)\]\)$')
-- 
1.6.3.3


