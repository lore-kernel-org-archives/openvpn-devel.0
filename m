From: David Sommerseth <openvpn.list@...1114...>
Date: Fri, 10 Jul 2015 15:22:28 +0200
Message-Id: <1436534548-21507-3-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1436534548-21507-1-git-send-email-openvpn.list@...1114...>
References: <1436534548-21507-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH 2/2] Provide OpenVPN runtime version
	information to plug-ins
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

From: David Sommerseth <davids@...1347...>

Also updated the log_v3 sample-plugin to demonstrate how this
works.

  $ openvpn --plugin log_v3.so --dev tun
  Fri Jul 10 15:17:28 2015 OpenVPN 2.3_git [git:dev/plugin-version/f05d8623a29078bf+].....
  ...more.openvpn.logging...
  log_v3: OpenVPN 2.3_git  (Major: 2, Minor: 3, Patch: git:dev/plugin-version/f05d8623a29078bf+)
  ...more.openvpn.logging...
  $

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac                       |  3 +++
 include/openvpn-plugin.h.in        |  9 ++++++++-
 sample/sample-plugins/log/log_v3.c |  6 ++++++
 src/openvpn/plugin.c               | 21 ++++++++++++++++++++-
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index c7354f6..7bcbb7c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,6 +33,9 @@ AC_DEFINE([OPENVPN_VERSION_RESOURCE], [PRODUCT_VERSION_RESOURCE], [Version in wi
 AC_SUBST([OPENVPN_VERSION_MAJOR], [PRODUCT_VERSION_MAJOR], [OpenVPN major version])
 AC_SUBST([OPENVPN_VERSION_MINOR], [PRODUCT_VERSION_MINOR], [OpenVPN minor version])
 AC_SUBST([OPENVPN_VERSION_PATCH], [PRODUCT_VERSION_PATCH], [OpenVPN patch level - may be a string or integer])
+AC_DEFINE([OPENVPN_VERSION_MAJOR], [PRODUCT_VERSION_MAJOR], [OpenVPN major version - integer])
+AC_DEFINE([OPENVPN_VERSION_MINOR], [PRODUCT_VERSION_MINOR], [OpenVPN minor version - integer])
+AC_DEFINE([OPENVPN_VERSION_PATCH], ["PRODUCT_VERSION_PATCH"], [OpenVPN patch level - may be a string or integer])
 
 AC_CONFIG_AUX_DIR([.])
 AC_CONFIG_HEADERS([config.h])
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index ddf3298..d4bf622 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -215,8 +215,11 @@ struct openvpn_plugin_string_list
  *           which identifies the SSL implementation OpenVPN is compiled
  *           against.
  *
+ *    3      Added ovpn_version, ovpn_version_major, ovpn_version_minor
+ *           and ovpn_version_patch to provide the runtime version of
+ *           OpenVPN to plug-ins.
  */
-#define OPENVPN_PLUGINv3_STRUCTVER 2
+#define OPENVPN_PLUGINv3_STRUCTVER 3
 
 /**
  * Definitions needed for the plug-in callback functions.
@@ -311,6 +314,10 @@ struct openvpn_plugin_args_open_in
   const char ** const envp;
   struct openvpn_plugin_callbacks *callbacks;
   const ovpnSSLAPI ssl_api;
+  const char *ovpn_version;
+  const unsigned int ovpn_version_major;
+  const unsigned int ovpn_version_minor;
+  const char * const ovpn_version_patch;
 };
 
 
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index bf1a15c..275b1e7 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -82,6 +82,7 @@ openvpn_plugin_open_v3 (const int v3structver,
 
   /* Check that we are API compatible */
   if( v3structver != OPENVPN_PLUGINv3_STRUCTVER ) {
+    printf("log_v3: ** ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\n");
     return OPENVPN_PLUGIN_FUNC_ERROR;
   }
 
@@ -90,6 +91,11 @@ openvpn_plugin_open_v3 (const int v3structver,
     return OPENVPN_PLUGIN_FUNC_ERROR;
   }
 
+  /* Print some version information about the OpenVPN process using this plug-in */
+  printf("log_v3: OpenVPN %s  (Major: %i, Minor: %i, Patch: %s)\n",
+         args->ovpn_version, args->ovpn_version_major,
+         args->ovpn_version_minor, args->ovpn_version_patch);
+
   /*  Which callbacks to intercept.  */
   ret->type_mask =
     OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) |
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 60dd2ee..9be0b0c 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -27,6 +27,9 @@
 #elif defined(_MSC_VER)
 #include "config-msvc.h"
 #endif
+#ifdef HAVE_CONFIG_VERSION_H
+#include "config-version.h"
+#endif
 
 #include "syshead.h"
 
@@ -347,6 +350,17 @@ static struct openvpn_plugin_callbacks callbacks = {
   plugin_vlog
 };
 
+
+/* Provide a wrapper macro for a version patch level string to plug-ins.
+ * This is located here purely to not make the code too messy with #ifndef
+ * inside a struct declaration
+ */
+#ifndef CONFIGURE_GIT_REVISION
+# define _OPENVPN_PATCH_LEVEL OPENVPN_VERSION_PATCH
+#else
+# define _OPENVPN_PATCH_LEVEL "git:" CONFIGURE_GIT_REVISION CONFIGURE_GIT_FLAGS
+#endif
+
 static void
 plugin_open_item (struct plugin *p,
 		  const struct plugin_option *o,
@@ -375,7 +389,12 @@ plugin_open_item (struct plugin *p,
                                                     (const char ** const) o->argv,
                                                     (const char ** const) envp,
                                                     &callbacks,
-                                                    SSLAPI };
+                                                    SSLAPI,
+                                                    PACKAGE_VERSION,
+                                                    OPENVPN_VERSION_MAJOR,
+                                                    OPENVPN_VERSION_MINOR,
+                                                    _OPENVPN_PATCH_LEVEL
+        };
         struct openvpn_plugin_args_open_return retargs;
 
         CLEAR(retargs);
-- 
1.8.3.1


