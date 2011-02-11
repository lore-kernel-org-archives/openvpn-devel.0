From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:36 +0200
Message-Id: <1297436985-18991-4-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 04/13] Added helper functionality to
	win/wb.py
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

This change adds several helper functions to win/wb.py:

- config-win32.h parser (to read build configuration options)
- helper function to cd to service-win32 for openvpnserv.exe building
- code to dynamically generate TAP-driver -related variables from version.m4,
  required by tap-win32/tapdrv.c
- configure.h generator to allow viewing build options using openvpn --version
- creation of temporary version.m4-based file to allow importing it's variables
  to the NSI installer script (win/openvpn.nsi)
- helper function to rename files (used in win/make_dist.py)
---
 win/wb.py |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/win/wb.py b/win/wb.py
index 8e23684..2d7bd61 100644
--- a/win/wb.py
+++ b/win/wb.py
@@ -19,6 +19,12 @@ def get_config():
 
     return kv
 
+def get_build_params():
+    kv = {}
+    parse_config_win32_h(kv,home_fn('config-win32.h'))
+
+    return kv
+
 def mod_fn(fn, src=__file__, real=True):
     p = os.path.join(os.path.dirname(src), os.path.normpath(fn))
     if real:
@@ -31,18 +37,35 @@ def home_fn(fn, real=True):
 def cd_home():
     os.chdir(os.path.join(os.path.dirname(__file__), '..'))
 
+def cd_service_win32():
+    os.chdir(os.path.join(os.path.dirname(__file__), '../service-win32'))
+
 def system(cmd):
     print "RUN:", cmd
     os.system(cmd)
 
 def parse_version_m4(kv, version_m4):
+    '''Parse define lines in version.m4'''
     r = re.compile(r'^define\((\w+),\[(.*)\]\)$')
     f = open(version_m4)
     for line in f:
         line = line.rstrip()
         m = re.match(r, line)
+
         if m:
             g = m.groups()
+
+            # If we encounter PRODUCT_TAP_WIN32_MIN_MAJOR or 
+            # PRODUCT_TAP_WIN32_MIN_MAJOR then we need to generate extra 
+            # variables, PRODUCT_TAP_MAJOR_VER and PRODUCT_TAP_MINOR_VER with 
+            # the same contents. This is necessary because tap-win32/tapdrv.c 
+            # build depends on those.
+            if g[0] == 'PRODUCT_TAP_WIN32_MIN_MAJOR':
+                kv['PRODUCT_TAP_MAJOR_VER'] = g[1]
+            elif g[0] == 'PRODUCT_TAP_WIN32_MIN_MINOR':
+                kv['PRODUCT_TAP_MINOR_VER'] = g[1]
+
+            # Add the variable to build configuration
             kv[g[0]] = g[1]
     f.close()
 
@@ -57,6 +80,39 @@ def parse_settings_in(kv, settings_in):
             kv[g[0]] = g[1] or ''
     f.close()
 
+def parse_config_win32_h(kv, config_win32_h):
+    r = re.compile(r'^#define\s+(ENABLE_\w+)\s+(\w+)')
+    s = re.compile(r'^#ifdef|^#ifndef')
+    e = re.compile(r'^#endif')
+
+    # How "deep" in nested conditional statements are we?
+    depth=0
+
+    f = open(config_win32_h)
+
+    for line in f:
+        line = line.rstrip()
+
+        # Check if this is a #define line starting with ENABLE_
+        m = re.match(r, line)
+
+        # Calculate how deep we're in (nested) conditional statements. A simple
+        # #ifdef/#endif state switcher would get confused by an #endif followed
+        # by a #define.
+        if re.match(s, line):
+            depth=depth+1
+        if re.match(e, line):
+            depth=depth-1
+
+        if m:
+            # Only add this #define if it's not inside a conditional statement 
+            # block
+            if depth == 0:
+                g = m.groups()
+                kv[g[0]] = g[1] or ''
+    f.close()
+
+
 def dict_def(dict, newdefs):
     ret = dict.copy()
     ret.update(newdefs)
@@ -70,6 +126,43 @@ def build_autodefs(kv, autodefs_in, autodefs_out):
                quote_end='@',
                head_comment='/* %s */\n\n' % autogen)
 
+def build_configure_h(kv, configure_h_out, head_comment):
+    """Generate a configure.h dynamically"""
+    fout = open(configure_h_out, 'w')
+    configure_defines='#define CONFIGURE_DEFINES \"'
+    configure_call='#define CONFIGURE_CALL \" config_all.py \"'
+
+    fout.write(head_comment)
+
+    dict = get_build_params()
+
+    for key, value in dict.iteritems():
+        configure_defines = configure_defines + " " + key + "=" + value + ","
+
+    configure_defines = configure_defines + "\"" + "\n"
+
+    fout.write(configure_defines)
+    fout.write(configure_call)
+    fout.close()
+
+def build_version_m4_vars(version_m4_vars_out, head_comment):
+    """Generate a temporary file containing variables from version.m4 in 
+win/settings.in format. This done to allow importing them in win/openvpn.nsi"""
+
+    fout = open(version_m4_vars_out, 'w')
+    fout.write(head_comment)
+
+    kv = {}
+    parse_version_m4(kv, home_fn('version.m4'))
+
+    for key, value in kv.iteritems():
+         line = "!define " + key + "\t" + "\"" + value + "\"" + "\n"
+         fout.write(line)
+
+    fout.close()
+
+
+
 def preprocess(kv, in_fn, out_fn, quote_begin=None, quote_end=None, if_prefix=None, head_comment=None):
     def repfn(m):
         var, = m.groups()
@@ -116,6 +209,7 @@ def print_key_values(kv):
         print "%s%s%s" % (k, ' '*(32-len(k)), repr(v))
 
 def get_sources(makefile_am):
+    """Parse ../Makefile.am to obtain a list of .h and .c files"""
     c = set()
     h = set()
     f = open(makefile_am)
@@ -147,6 +241,7 @@ def output_mak_list(title, srclist, ext):
     return ret
 
 def make_headers_objs(makefile_am):
+    """Generate HEADER and OBJS entries dynamically from ../Makefile.am"""
     c, h = get_sources(makefile_am)
     ret = output_mak_list('HEADERS', h, 'h')
     ret += output_mak_list('OBJS', c, 'obj')
@@ -182,6 +277,10 @@ def cp(src, dest, dest_is_dir=True):
     print "COPY %s %s" % (src, dest)
     shutil.copyfile(src, dest)
 
+def rename(src, dest):
+    print "RENAME %s %s" % (src, dest)
+    shutil.move(src, dest)
+
 def rm_rf(path):
     try:
         shutil.rmtree(path, onerror=onerror)
-- 
1.6.3.3


