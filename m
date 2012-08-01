From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 1 Aug 2012 13:37:38 +0200
Message-ID: <1343821058-11456-3-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
References: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] add plugin_log() API to write to
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
 include/openvpn-plugin.h |   23 +++++++++++++++++++++
 src/openvpn/plugin.c     |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index 1c80eec..8f09e61 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -47,6 +47,29 @@ typedef X509 openvpn_x509_cert_t;
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
+  PLOG_ERR       = (1 << 0),  /* Error condition message */
+  PLOG_WARN      = (1 << 1),  /* General warning message */
+  PLOG_NOTE      = (1 << 2),  /* Informational message */
+  PLOG_DEBUG     = (1 << 3),  /* Debug message, displayed if verb >= 7 */
+
+  PLOG_ERRNO     = (1 << 8),  /* Add error description to message */
+  PLOG_NOMUTE    = (1 << 9),  /* Mute setting does not apply for message */
+
+} openvpn_plugin_log_flags_t;
+
+plugin_log (openvpn_plugin_log_flags_t flags, const char *plugin_name, const char *format, ...);
+
+
 /*
  * Plug-in types.  These types correspond to the set of script callbacks
  * supported by OpenVPN.
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 7ce2f5e..6224d85 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -286,6 +286,57 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   gc_free (&gc);
 }
 
+
+void
+plugin_log (openvpn_plugin_log_flags_t flags, const char *name, const char *format, ...)
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
+      va_list arglist;
+      char* msg_fmt;
+
+      /* Never add instance prefix; not thread safe */
+      msg_flags |= M_NOIPREFIX;
+
+      gc_init (&gc);
+      msg_fmt = gc_malloc (ERR_BUF_SIZE, false, &gc);
+      openvpn_snprintf (msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, format);
+
+      va_start (arglist, format);
+      x_msg_va (msg_flags, msg_fmt, arglist);
+      va_end (arglist);
+
+      gc_free (&gc)
+    }
+}
+
+
 static void
 plugin_open_item (struct plugin *p,
 		  const struct plugin_option *o,
-- 
1.7.9.5


