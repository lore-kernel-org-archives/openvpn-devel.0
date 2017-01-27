From: David Sommerseth <davids@...515...>
Date: Fri, 27 Jan 2017 15:21:20 +0100
Message-Id: <20170127142120.10492-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] plugin: Improve the handling of default
	plug-in directory
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

OpenVPN uses a default plug-in directore, set using PLUGINDIR when
running ./configure.  If this is set, it will use $LIBDIR/openvpn/plugin.

When using --plugin, OpenVPN will load plug-ins from this directory with
the only exception if the plug-in filename is based on an absolute path.
Any other relative paths are relative to the PLUGINDIR.

This patch adds a third variant, using plug-in paths starting with '.'
In this case, OpenVPN will use the relative directory of where OpenVPN
was started, or the directory OpenVPN have changed into due to --cd
being used before the actual --plugin option.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8        | 28 ++++++++++++++++++++++++++++
 src/openvpn/plugin.c | 18 +++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e3d603e..a8d06f3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2712,6 +2712,34 @@ to the module initialization function.  Multiple
 plugin modules may be loaded into one OpenVPN
 process.
 
+The
+.B module-pathname
+argument can be just a filename or a filename with a relative
+or absolute path.  The format of the filename and path defines
+if the plug-in will be loaded from a default plug-in directory
+or outside this directory.
+
+.nf
+.ft 3
+.in +4
+.B \-\-plugin path\ \ \ \ \ \ \ \ Effective directory used
+====================================================
+ myplug.so            DEFAULT_DIR/myplug.so
+ subdir/myplug.so     DEFAULT_DIR/subdir/myplug.so
+ ./subdir/myplug.so   CWD/subdir/myplug.so
+ /usr/lib/my/plug.so  /usr/lib/my/plug.so
+.in -4
+.fi
+
+DEFAULT_DIR is replaced by the default plug-in directory,
+which is configured at the build time of OpenVPN.  CWD is the
+current directory where OpenVPN was started or the directory
+OpenVPN have swithed into via the
+.B\-\-cd
+option before the
+.B\-\-plugin
+option.
+
 For more information and examples on how to build OpenVPN
 plug-in modules, see the README file in the
 .B plugin
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index f777027..05cbae3 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -235,7 +235,23 @@ plugin_init_item(struct plugin *p, const struct plugin_option *o)
 
     p->handle = NULL;
 
-    if (!absolute_pathname(p->so_pathname))
+    /* If the plug-in filename is not an absolute path,
+     * or beginning with '.', it should use the PLUGIN_LIBDIR
+     * as the base directory for loading the plug-in.
+     *
+     * This means the following scenarios are loaded from these places:
+     *    --plugin fancyplug.so              -> $PLUGIN_LIBDIR/fancyplug.so
+     *    --plugin my/fancyplug.so           -> $PLUGIN_LIBDIR/my/fancyplug.so
+     *    --plugin ./fancyplug.so            -> $CWD/fancyplug.so
+     *    --plugin /usr/lib/my/fancyplug.so  -> /usr/lib/my/fancyplug.so
+     *
+     * Please note that $CWD means the directory OpenVPN is either started from
+     * or the directory OpenVPN have changed into using --cd before --plugin
+     * was parsed.
+     *
+     */
+    if (!absolute_pathname(p->so_pathname)
+        && p->so_pathname[0] != '.')
     {
         char full[PATH_MAX];
 
-- 
2.11.0


