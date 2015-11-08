From: Steffan Karger <steffan@...1856...>
Date: Sun,  8 Nov 2015 13:04:27 +0100
Message-Id: <1446984267-3323-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix unintialized variable in plugin_vlog()
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

Does not seem to be a problem in normal usage, because one of the PLOG_ERR,
PLOG_WARN, PLOG_NOTE or PLOG_DEBUG will be set, and will cause msg_flags
to be initialized.  In the worst case, msg_flags might accidentally
end up having M_FATAL set, causing openvpn to exit.

This was previously fixed in the master branch (5ead2ae0), but was not
backported to release/2.3, probably because that commit fixed other parts
of the code too, and those parts are quite different between master and
release/2.3.

Re-discovered by coverity.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 0948f23..54c5b52 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -291,7 +291,7 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
 static void
 plugin_vlog (openvpn_plugin_log_flags_t flags, const char *name, const char *format, va_list arglist)
 {
-  unsigned int msg_flags;
+  unsigned int msg_flags = 0;
 
   if (!format)
     return;
-- 
2.5.0


