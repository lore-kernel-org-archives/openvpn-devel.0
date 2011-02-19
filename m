From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Sat, 19 Feb 2011 11:15:14 +0200
Message-Id: <1298106914-13356-1-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH] Changes to buildsystem patchset
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

Implemented changes to the buildsystem patchset suggested by jamesyonan in IRC
meeting on 17th Feb 2010:

1) Remove variables added to version.m4 and use win/settings.in instead
2) Add ENABLE_<FEATURE> configuration to win/settings.in instead of parsing
   config-win32.h for them

This patch applies on top of the previous 13 patches.
---
 version.m4      |    3 ---
 win/settings.in |   15 +++++++++++++++
 win/show.py     |    3 +--
 win/wb.py       |   39 ++++++++++++++++++---------------------
 4 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/version.m4 b/version.m4
index 475a82f..d914fc1 100644
--- a/version.m4
+++ b/version.m4
@@ -4,6 +4,3 @@ dnl define the TAP version
 define(PRODUCT_TAP_ID,[tap0901])
 define(PRODUCT_TAP_WIN32_MIN_MAJOR,[9])
 define(PRODUCT_TAP_WIN32_MIN_MINOR,[1])
-define(PRODUCT_TAP_RELDATE,[04/19/2010])
-define(PRODUCT_TAP_DEVICE_DESCRIPTION,[TAP-Win32 Adapter V9])
-define(PRODUCT_TAP_PROVIDER,[TAP-Win32 Provider V9])
diff --git a/win/settings.in b/win/settings.in
index c349752..25109e2 100644
--- a/win/settings.in
+++ b/win/settings.in
@@ -5,6 +5,16 @@
 # stored in this file. This is done to allow using the old and new Windows build 
 # systems side-by-side
 
+# Features to include
+!define ENABLE_PASSWORD_SAVE 1
+!define ENABLE_CLIENT_SERVER 1
+!define ENABLE_CLIENT_ONLY
+!define ENABLE_MANAGEMENT 1
+!define ENABLE_HTTP_PROXY 1
+!define ENABLE_SOCKS 1
+!define ENABLE_FRAGMENT 1
+!define ENABLE_DEBUG 1
+
 # Branding
 !define PRODUCT_NAME      "OpenVPN"
 !define PRODUCT_UNIX_NAME "openvpn"
@@ -30,6 +40,11 @@
 # TAP adapter icon -- visible=0x81 or hidden=0x89
 !define PRODUCT_TAP_CHARACTERISTICS     0x81
 
+# TAP adapter metadata. Version information in ../version.m4.
+!define PRODUCT_TAP_RELDATE    "04/19/2010"
+!define PRODUCT_TAP_DEVICE_DESCRIPTION    "TAP-Win32 Adapter V9"
+!define PRODUCT_TAP_PROVIDER    "TAP-Win32 Provider V9"
+
 # Build debugging version of TAP driver
 ;!define PRODUCT_TAP_DEBUG
 
diff --git a/win/show.py b/win/show.py
index 6b1140a..6cfebf2 100644
--- a/win/show.py
+++ b/win/show.py
@@ -1,9 +1,8 @@
-from wb import get_config, get_build_params
+from wb import get_config
 from js import JSON
 
 def main():
     print JSON().encode(get_config())
-    print JSON().encode(get_build_params())
 
 # if we are run directly, and not loaded as a module
 if __name__ == "__main__":
diff --git a/win/wb.py b/win/wb.py
index 2d7bd61..d4f8203 100644
--- a/win/wb.py
+++ b/win/wb.py
@@ -21,7 +21,7 @@ def get_config():
 
 def get_build_params():
     kv = {}
-    parse_config_win32_h(kv,home_fn('config-win32.h'))
+    parse_build_params(kv,mod_fn('settings.in'))
 
     return kv
 
@@ -80,34 +80,18 @@ def parse_settings_in(kv, settings_in):
             kv[g[0]] = g[1] or ''
     f.close()
 
-def parse_config_win32_h(kv, config_win32_h):
-    r = re.compile(r'^#define\s+(ENABLE_\w+)\s+(\w+)')
-    s = re.compile(r'^#ifdef|^#ifndef')
-    e = re.compile(r'^#endif')
+def parse_build_params(kv, settings_in):
+    r = re.compile(r'^!define\s+(ENABLE_\w+)\s+(\w+)')
 
-    # How "deep" in nested conditional statements are we?
-    depth=0
-
-    f = open(config_win32_h)
+    f = open(settings_in)
 
     for line in f:
         line = line.rstrip()
 
-        # Check if this is a #define line starting with ENABLE_
+        # Check if this is a #define line starts with ENABLE_
         m = re.match(r, line)
 
-        # Calculate how deep we're in (nested) conditional statements. A simple
-        # #ifdef/#endif state switcher would get confused by an #endif followed
-        # by a #define.
-        if re.match(s, line):
-            depth=depth+1
-        if re.match(e, line):
-            depth=depth-1
-
         if m:
-            # Only add this #define if it's not inside a conditional statement 
-            # block
-            if depth == 0:
                 g = m.groups()
                 kv[g[0]] = g[1] or ''
     f.close()
@@ -129,20 +113,33 @@ def build_autodefs(kv, autodefs_in, autodefs_out):
 def build_configure_h(kv, configure_h_out, head_comment):
     """Generate a configure.h dynamically"""
     fout = open(configure_h_out, 'w')
+
+    # These two variables are required to view build parameters during runtime 
     configure_defines='#define CONFIGURE_DEFINES \"'
     configure_call='#define CONFIGURE_CALL \" config_all.py \"'
 
+    # Initialize the list of enabled features
+    features = ''
+
+    # Write the header
     fout.write(head_comment)
 
     dict = get_build_params()
 
     for key, value in dict.iteritems():
+        # Add enabled features
+	features = features + "#define " + key + " " + value + "\n"
+
+	# Add each enabled feature to CONFIGURE_DEFINES list
         configure_defines = configure_defines + " " + key + "=" + value + ","
 
     configure_defines = configure_defines + "\"" + "\n"
 
+    fout.write(features)
     fout.write(configure_defines)
     fout.write(configure_call)
+
+
     fout.close()
 
 def build_version_m4_vars(version_m4_vars_out, head_comment):
-- 
1.6.3.3


