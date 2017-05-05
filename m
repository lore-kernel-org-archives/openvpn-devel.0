From: David Sommerseth <davids@...515...>
Date: Fri,  5 May 2017 20:46:22 +0200
Message-Id: <20170505184622.24520-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] plugin: Export secure_memzero() to plug-ins
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

The provides plug-ins with a safe and secure way to santize sensitive
information such as passwords, by re-using the secure_memzero()
implementation in OpenVPN.

Signed-off-by: David Sommerseth <davids@...515...>
---
 include/openvpn-plugin.h.in | 25 ++++++++++++++++++++++---
 src/openvpn/plugin.c        |  3 ++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 0b303520..ec83f3a6 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -199,7 +199,8 @@ struct openvpn_plugin_string_list
 
 /* openvpn_plugin_{open,func}_v3() related structs */
 
-/* Defines version of the v3 plugin argument structs
+/**
+ * Defines version of the v3 plugin argument structs
  *
  * Whenever one or more of these structs are modified, this constant
  * must be updated.  A changelog should be appended in this comment
@@ -218,8 +219,10 @@ struct openvpn_plugin_string_list
  *    3      Added ovpn_version, ovpn_version_major, ovpn_version_minor
  *           and ovpn_version_patch to provide the runtime version of
  *           OpenVPN to plug-ins.
+ *
+ *    4      Exported secure_memzero() as plugin_secure_memzero()
  */
-#define OPENVPN_PLUGINv3_STRUCTVER 3
+#define OPENVPN_PLUGINv3_STRUCTVER 4
 
 /**
  * Definitions needed for the plug-in callback functions.
@@ -255,10 +258,19 @@ typedef void (*plugin_vlog_t)(openvpn_plugin_log_flags_t flags,
                               const char *plugin_name,
                               const char *format,
                               va_list arglist) _ovpn_chk_fmt (3, 0);
-
 #undef _ovpn_chk_fmt
 
 /**
+ *  Export of secure_memzero() to be used inside plug-ins
+ *
+ *  @param data   Pointer to data to zeroise
+ *  @param len    Length of data, in bytes
+ *
+ */
+typedef void (*plugin_secure_memzero_t)(void *data, size_t len);
+
+
+/**
  * Used by the openvpn_plugin_open_v3() function to pass callback
  * function pointers to the plug-in.
  *
@@ -267,11 +279,18 @@ typedef void (*plugin_vlog_t)(openvpn_plugin_log_flags_t flags,
  *               Messages will only be displayed if the plugin_name parameter
  *               is set. PLOG_DEBUG messages will only be displayed with plug-in
  *               debug log verbosity (at the time of writing that's verb >= 7).
+ *
+ * plugin_secure_memzero
+ *             : Use this function to securely wipe sensitive information from
+ *               memory.  This function is declared in a way that the compiler
+ *               will not remove these function calls during the compiler
+ *               optimization phase.
  */
 struct openvpn_plugin_callbacks
 {
     plugin_log_t plugin_log;
     plugin_vlog_t plugin_vlog;
+    plugin_secure_memzero_t plugin_secure_memzero;
 };
 
 /**
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 05cbae3e..a652d528 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -410,7 +410,8 @@ plugin_log(openvpn_plugin_log_flags_t flags, const char *name, const char *forma
 
 static struct openvpn_plugin_callbacks callbacks = {
     plugin_log,
-    plugin_vlog
+    plugin_vlog,
+    secure_memzero   /* plugin_secure_memzero */
 };
 
 
-- 
2.11.0


