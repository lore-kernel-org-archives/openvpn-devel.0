From: David Sommerseth <dazo@...384...>
Date: Fri,  7 Jun 2013 13:49:39 +0200
Message-Id: <1370605779-712-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] plugin: Extend the plug-in v3 API to
	identify the SSL implementation used
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

OpenVPN would segfault unexpectedly if it would be compiled against PolarSSL
and the plug-in would expect OpenSSL, or vise-versa.  This segfault would
not appear before the plug-in would try to access functions which would
be available if the plug-in and OpenVPN uses the same SSL implementation.

This patch adds a member to the plug-in initialisation function, which
identifies the SSL implementation.

The log_v3 plug-in is updated accordingly + a simple fix to make it
buildable again using the ./build script.

A minor documentation error in the openvpn-plugin.h was also
corrected, where it mentioned OPENVPN_PLUGIN_VERSION instead of
OPENVPN_PLUGINv3_STRUCTVER.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 include/openvpn-plugin.h           |   24 +++++++++++++++++++++---
 sample/sample-plugins/log/build    |    2 +-
 sample/sample-plugins/log/log_v3.c |    5 +++++
 src/openvpn/plugin.c               |    3 ++-
 src/openvpn/ssl_backend.h          |    2 ++
 5 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index 0879f49..065b250 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -201,10 +201,15 @@ struct openvpn_plugin_string_list
  *
  * Version   Comment
  *    1      Initial plugin v3 structures providing the same API as
- *           the v2 plugin interface + X509 certificate information.
+ *           the v2 plugin interface, X509 certificate information +
+ *           a logging API for plug-ins.
+ *
+ *    2      Added ssl_api member in struct openvpn_plugin_args_open_in
+ *           which identifies the SSL implementation OpenVPN is compiled
+ *           against.
  *
  */
-#define OPENVPN_PLUGINv3_STRUCTVER 1
+#define OPENVPN_PLUGINv3_STRUCTVER 2
 
 /**
  * Definitions needed for the plug-in callback functions.
@@ -260,6 +265,17 @@ struct openvpn_plugin_callbacks
 };
 
 /**
+ * Used by the openvpn_plugin_open_v3() function to indicate to the
+ * plug-in what kind of SSL implementation OpenVPN uses.  This is
+ * to avoid SEGV issues when OpenVPN is complied against PolarSSL
+ * and the plug-in against OpenSSL.
+ */
+typedef enum {
+  SSLAPI_OPENSSL,
+  SSLAPI_POLARSSL
+} ovpnSSLAPI;
+
+/**
  * Arguments used to transport variables to the plug-in.
  * The struct openvpn_plugin_args_open_in is only used
  * by the openvpn_plugin_open_v3() function.
@@ -283,6 +299,7 @@ struct openvpn_plugin_callbacks
 struct openvpn_plugin_args_open_in
 {
   const int type_mask;
+  const ovpnSSLAPI ssl_api;
   const char ** const argv;
   const char ** const envp;
   struct openvpn_plugin_callbacks *callbacks;
@@ -557,7 +574,8 @@ OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v2)
  * ARGUMENTS
  *
  * version : fixed value, defines the API version of the OpenVPN plug-in API.  The plug-in
- *	     should validate that this value is matching the OPENVPN_PLUGIN_VERSION value.
+ *	     should validate that this value is matching the OPENVPN_PLUGINv3_STRUCTVER
+ *	     value.
  *
  * arguments : Structure with all arguments available to the plug-in.
  *
diff --git a/sample/sample-plugins/log/build b/sample/sample-plugins/log/build
index bbb05f7..c07ec40 100755
--- a/sample/sample-plugins/log/build
+++ b/sample/sample-plugins/log/build
@@ -6,7 +6,7 @@
 #
 
 # This directory is where we will look for openvpn-plugin.h
-CPPFLAGS="${CPPFLAGS:--I../../..}"
+CPPFLAGS="${CPPFLAGS:--I../../../include}"
 
 CC="${CC:-gcc}"
 CFLAGS="${CFLAGS:--O2 -Wall -g}"
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 742c756..4d3af91 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -85,6 +85,11 @@ openvpn_plugin_open_v3 (const int v3structver,
     return OPENVPN_PLUGIN_FUNC_ERROR;
   }
 
+  if( args->ssl_api != SSLAPI_OPENSSL ) {
+    printf("This plug-in can only be used against OpenVPN with OpenSSL\n");
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+  }
+
   /*  Which callbacks to intercept.  */
   ret->type_mask =
     OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) |
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index c96c121..55680d1 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -40,8 +40,8 @@
 #include "error.h"
 #include "misc.h"
 #include "plugin.h"
+#include "ssl_backend.h"
 #include "win32.h"
-
 #include "memdbg.h"
 
 #define PLUGIN_SYMBOL_REQUIRED (1<<0)
@@ -372,6 +372,7 @@ plugin_open_item (struct plugin *p,
        */
       if (p->open3) {
         struct openvpn_plugin_args_open_in args = { p->plugin_type_mask,
+                                                    SSLAPI,
                                                     (const char ** const) o->argv,
                                                     (const char ** const) envp,
                                                     &callbacks };
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index f61580c..5aba117 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -36,10 +36,12 @@
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_openssl.h"
 #include "ssl_verify_openssl.h"
+#define SSLAPI SSLAPI_OPENSSL
 #endif
 #ifdef ENABLE_CRYPTO_POLARSSL
 #include "ssl_polarssl.h"
 #include "ssl_verify_polarssl.h"
+#define SSLAPI SSLAPI_POLARSSL
 #endif
 
 
-- 
1.7.10.2


