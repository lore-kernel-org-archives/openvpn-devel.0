From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 31 Jul 2012 15:32:46 +0200
Message-ID: <1343741566-30911-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] add plugin_log() API to write to openvpn log
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
 include/openvpn-plugin.h |   20 ++++++++++++++++++++
 src/openvpn/error.c      |   11 ++++++++---
 src/openvpn/error.h      |    2 ++
 src/openvpn/plugin.c     |   35 +++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index 1c80eec..e966baf 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -47,6 +47,26 @@ typedef X509 openvpn_x509_cert_t;
 extern "C" {
 #endif
 
+/**
+ * Struct to transport log lines from the plugin to openvpn.
+ * The plugin should allocate all structure instances and msg strings
+ * with malloc, since OpenVPN will free them after logging took place.
+ */
+typedef enum
+{
+  PLOG_ERR       = (1 << 0),  /* Error condition message */
+  PLOG_WARN      = (1 << 1),  /* General warning message */
+  PLOG_NOTE      = (1 << 2),  /* Informational message */
+  PLOG_DEBUG     = (1 << 3),  /* Debug message, displayed if verb >= 7 */
+
+  PLOG_ERRNO     = (1 <<  8), /* Add error description to message */
+  PLOG_NOMUTE    = (1 <<  9), /* Mute setting does not apply for message */
+  PLOG_NOIPREFIX = (1 << 10)  /* No instance prefix for this message */
+
+} openvpn_plugin_log_flags_t;
+
+void plugin_log (openvpn_plugin_log_flags_t flags, const char *fmt, ...);
+
 /*
  * Plug-in types.  These types correspond to the set of script callbacks
  * supported by OpenVPN.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 8396fe0..6848425 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -201,8 +201,15 @@ int x_msg_line_num; /* GLOBAL */
 
 void x_msg (const unsigned int flags, const char *format, ...)
 {
-  struct gc_arena gc;
   va_list arglist;
+  va_start (arglist, format);
+  x_msg_va (flags, format, arglist);
+  va_end (arglist);
+}
+
+void x_msg_va (const unsigned int flags, const char *format, va_list arglist)
+{
+  struct gc_arena gc;
 #if SYSLOG_CAPABILITY
   int level;
 #endif
@@ -237,9 +244,7 @@ void x_msg (const unsigned int flags, const char *format, ...)
   m1 = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
   m2 = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
 
-  va_start (arglist, format);
   vsnprintf (m1, ERR_BUF_SIZE, format, arglist);
-  va_end (arglist);
   m1[ERR_BUF_SIZE - 1] = 0; /* windows vsnprintf needs this */
 
   if ((flags & M_ERRNO) && e)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index aedb7c3..27c48b6 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -182,6 +182,8 @@ void x_msg (const unsigned int flags, const char *format, ...)
 #endif
     ; /* should be called via msg above */
 
+void x_msg_va (const unsigned int flags, const char *format, va_list arglist);
+
 /*
  * Function prototypes
  */
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 7ce2f5e..cbad76b 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -286,6 +286,41 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   gc_free (&gc);
 }
 
+
+void
+plugin_log (openvpn_plugin_log_flags_t plog_flags, const char *format, ...)
+{
+  unsigned int msg_flags;
+  va_list arglist;
+
+  if (format == NULL)
+    return;
+
+  if (plog_flags & PLOG_ERR)
+    msg_flags = M_INFO | M_NONFATAL;
+  else if (plog_flags & PLOG_WARN)
+    msg_flags = M_INFO | M_WARN;
+  else if (plog_flags & PLOG_NOTE)
+    msg_flags = M_INFO;
+  else if (plog_flags & PLOG_DEBUG)
+    msg_flags = D_PLUGIN_DEBUG;
+
+  if (plog_flags & PLOG_ERRNO)
+    msg_flags |= M_ERRNO;
+  if (plog_flags & PLOG_NOMUTE)
+    msg_flags |= M_NOMUTE;
+  if (plog_flags & PLOG_NOIPREFIX)
+    msg_flags |= M_NOIPREFIX;
+
+  if (MSG_TEST (msg_flags))
+    {
+      va_start (arglist, format);
+      x_msg_va (msg_flags, format, arglist);
+      va_end (arglist);
+    }
+}
+
+
 static void
 plugin_open_item (struct plugin *p,
 		  const struct plugin_option *o,
-- 
1.7.9.5


