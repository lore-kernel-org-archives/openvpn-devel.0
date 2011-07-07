From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 7 Jul 2011 10:19:51 +0200
Message-ID: <1310026791-5268-1-git-send-email-dejong@...1435...>
In-Reply-To: <1310023632-30830-1-git-send-email-dejong@...1435...>
References: <1310023632-30830-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Further improvements to plugin support:
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

 - Renamed struct entries to explicitly show them as disabled
 - Added a warning if USE_SSL is enabled, but neither ssl_verify_openssl.h or ssl_verify_polarssl.h is included
 - If neither of those files is included, disable ssl support for a plugin including openvpn-plugin.h

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 openvpn-plugin.h         |   19 ++++++++-----------
 plugin.c                 |    4 ++--
 plugin.h                 |    6 ++++++
 plugin/examples/log_v3.c |    1 +
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index 65a3ffd..474c910 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -24,15 +24,12 @@
 
 #ifndef OPENVPN_PLUGIN_H_
 #define OPENVPN_PLUGIN_H_
-
 #ifdef USE_SSL
-#if defined(USE_OPENSSL)
-#include "ssl_verify_openssl.h"
-#elif defined(USE_POLARSSL)
-#include "ssl_verify_polarssl.h"
-#else
-#error "Either USE_OPENSSL or USE_POLARSSL should be defined"
-#endif
+#  if defined(SSL_VERIFY_OPENSSL_H_) || defined(SSL_VERIFY_POLARSSL_H_)
+#    define ENABLE_SSL_PLUGIN
+#  else
+#    warning "Neither OpenSSL or PoLarSSL headers included, disabling plugin's SSL support"
+#  endif
 #endif /*USE_SSL*/
 
 #define OPENVPN_PLUGIN_VERSION 3
@@ -282,12 +279,12 @@ struct openvpn_plugin_args_func_in
   const char ** const envp;
   openvpn_plugin_handle_t handle;
   void *per_client_context;
-#ifdef USE_SSL
+#ifdef ENABLE_SSL_PLUGIN
   int current_cert_depth;
   x509_cert_t *current_cert;
 #else
-  int current_cert_depth; /* Unused, for compatibility purposes only */
-  void *current_cert; /* Unused, for compatibility purposes only */
+  int __current_cert_depth_disabled; /* Unused, for compatibility purposes only */
+  void *__current_cert_disabled; /* Unused, for compatibility purposes only */
 #endif
 };
 
diff --git a/plugin.c b/plugin.c
index 331671c..dc581a4 100644
--- a/plugin.c
+++ b/plugin.c
@@ -379,8 +379,8 @@ plugin_call_item (const struct plugin *p,
 						    .current_cert_depth = (current_cert ? certdepth : -1),
 						    .current_cert = current_cert
 #else
-						    .current_cert_depth = -1,
-						    .current_cert = NULL
+						    .__current_cert_depth_disabled = -1,
+						    .__current_cert_disabled = NULL
 #endif
 						  };
         struct openvpn_plugin_args_func_return retargs;
diff --git a/plugin.h b/plugin.h
index 8fa4168..8782751 100644
--- a/plugin.h
+++ b/plugin.h
@@ -29,6 +29,12 @@
 #ifndef OPENVPN_PLUGIN_H
 #define OPENVPN_PLUGIN_H
 
+#ifdef USE_OPENSSL
+#include "ssl_verify_openssl.h"
+#endif
+#ifdef USE_POLARSSL
+#include "ssl_verify_polarssl.h"
+#endif
 #include "openvpn-plugin.h"
 
 #ifdef ENABLE_PLUGIN
diff --git a/plugin/examples/log_v3.c b/plugin/examples/log_v3.c
index 2dff6a6..187c592 100644
--- a/plugin/examples/log_v3.c
+++ b/plugin/examples/log_v3.c
@@ -38,6 +38,7 @@
 
 #define USE_SSL
 #define USE_OPENSSL
+#include "ssl_verify_openssl.h"
 
 #include "openvpn-plugin.h"
 
-- 
1.7.4.1


