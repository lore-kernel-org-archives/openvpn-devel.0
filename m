From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 2 Aug 2012 11:53:40 +0200
Message-ID: <1343901220-25458-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
References: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2 v2.1] add plugin_log() API to write to
	openvpn log
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

Some plugins want to add messages to the openvpn log file. The
plugin_log() API provides a way for them to do so.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---

This is the first variant of PATCH 2/2 that deals with the fact that
the original plugin_log() approach was not working on Windows.

It uses an inline function on Windows which explicitly resolves the
symbol needed to log from plug-ins, as the dynamic linker fails to do so.
OpenVPN exports the plugin_log_va() function for use by plug-ins.

Pros:
  + simple to use, just call plugin_log() in you plug-in code
  + available to any plug-in regradless of its API version

Cons:
  - looks a bit messy with all the preprocessor stuff in place
  - multiple symbol look-ups when including openvpn-plugin.h in two+ files

 include/openvpn-plugin.h |   48 ++++++++++++++++++++++++++++++++++++++-
 src/openvpn/plugin.c     |   56 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index 1c80eec..eaf9e7c 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -47,6 +47,52 @@ typedef X509 openvpn_x509_cert_t;
 extern "C" {
 #endif
 
+/**
+ * plugin_log() - plug-in log function.
+ *
+ * Use this function to add information to the OpenVPN log file.
+ * Messages will only be displayed if the plugin_name parameter is set.
+ * Debug messages will only be displayed with plug-in debug log verbosity.
+ *
+ */
+typedef enum
+{
+  PLOG_ERR    = (1 << 0),  /* Error condition message */
+  PLOG_WARN   = (1 << 1),  /* General warning message */
+  PLOG_NOTE   = (1 << 2),  /* Informational message */
+  PLOG_DEBUG  = (1 << 3),  /* Debug message, displayed if verb >= 7 */
+
+  PLOG_ERRNO  = (1 << 8),  /* Add error description to message */
+  PLOG_NOMUTE = (1 << 9),  /* Mute setting does not apply for message */
+
+} openvpn_plugin_log_flags_t;
+
+#if defined(WIN32)
+#include <windows.h>
+#include <stdarg.h>
+
+static inline void
+plugin_log (openvpn_plugin_log_flags_t flags, const char *plugin_name, const char *format, ...)
+{
+  typedef void (*log_fn_t)(openvpn_plugin_log_flags_t, const char *, const char *, va_list);
+  static log_fn_t log = NULL;
+  if (log == NULL)
+    {
+      log = (log_fn_t) GetProcAddress (GetModuleHandle (NULL), "plugin_log_va");
+      if (log == NULL)
+        return;
+    }
+
+  va_list arglist;
+  va_start(arglist, format);
+  log(flags, plugin_name, format, arglist);
+  va_end(arglist);
+}
+#else
+void plugin_log (openvpn_plugin_log_flags_t flags, const char *plugin_name, const char *format, ...);
+#endif
+
+
 /*
  * Plug-in types.  These types correspond to the set of script callbacks
  * supported by OpenVPN.
@@ -145,7 +191,7 @@ typedef void *openvpn_plugin_handle_t;
 /*
  * For Windows (needs to be modified for MSVC)
  */
-#if defined(__MINGW32_VERSION) && !defined(OPENVPN_PLUGIN_H)
+#if defined(WIN32)
 # define OPENVPN_EXPORT __declspec(dllexport)
 #else
 # define OPENVPN_EXPORT
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 7ce2f5e..b146a52 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -286,6 +286,62 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   gc_free (&gc);
 }
 
+OPENVPN_EXPORT void
+plugin_log_va (openvpn_plugin_log_flags_t flags, const char *name, const char *format, va_list arglist)
+{
+  unsigned int msg_flags;
+
+  if (!format)
+    return;
+
+  if (!name || name[0] == '\0')
+    {
+      msg (D_PLUGIN_DEBUG, "PLUGIN: suppressed log message from plugin with unknown name");
+      return;
+    }
+
+  if (flags & PLOG_ERR)
+    msg_flags = M_INFO | M_NONFATAL;
+  else if (flags & PLOG_WARN)
+    msg_flags = M_INFO | M_WARN;
+  else if (flags & PLOG_NOTE)
+    msg_flags = M_INFO;
+  else if (flags & PLOG_DEBUG)
+    msg_flags = D_PLUGIN_DEBUG;
+
+  if (flags & PLOG_ERRNO)
+    msg_flags |= M_ERRNO;
+  if (flags & PLOG_NOMUTE)
+    msg_flags |= M_NOMUTE;
+
+  if (MSG_TEST (msg_flags))
+    {
+      struct gc_arena gc;
+      char* msg_fmt;
+
+      /* Never add instance prefix; not thread safe */
+      msg_flags |= M_NOIPREFIX;
+
+      gc_init (&gc);
+      msg_fmt = gc_malloc (ERR_BUF_SIZE, false, &gc);
+      openvpn_snprintf (msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, format);
+      x_msg_va (msg_flags, msg_fmt, arglist);
+
+      gc_free (&gc);
+    }
+}
+
+#if !defined(WIN32)
+void
+plugin_log (openvpn_plugin_log_flags_t flags, const char *name, const char *format, ...)
+{
+  va_list arglist;
+  va_start (arglist, format);
+  plugin_log_va (flags, name, format, arglist);
+  va_end (arglist);
+}
+#endif
+
 static void
 plugin_open_item (struct plugin *p,
 		  const struct plugin_option *o,
-- 
1.7.10.4


