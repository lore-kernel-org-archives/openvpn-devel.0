From: Steffan Karger <steffan@...1856...>
Date: Wed, 20 Aug 2014 23:00:25 +0200
Message-Id: <1408568426-19601-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Fix some unintialized variable warnings
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

Does not actually change behaviour, but fixes compiler warnings
and properly initializing is good habit anyway.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/plugin.c | 2 +-
 src/openvpn/sig.c    | 2 +-
 src/openvpn/socket.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 90e39a4..a3d29de 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -126,7 +126,7 @@ print_signal (const struct signal_info *si, const char *title, int msglevel)
     {
       const char *type = (si->signal_text ? si->signal_text : "");
       const char *t = (title ? title : "process");
-      const char *hs;
+      const char *hs = NULL;
       switch (si->source)
         {
         case SIG_SOURCE_SOFT:
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 9e6bd10..c649d62 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2354,12 +2354,12 @@ print_sockaddr_ex (const struct sockaddr *sa,
 				   struct gc_arena *gc)
 {
   struct buffer out = alloc_buf_gc (128, gc);
-  bool addr_is_defined;
+  bool addr_is_defined = false;
   char hostaddr[NI_MAXHOST] = "";
   char servname[NI_MAXSERV] = "";
   int status;
 
-  socklen_t salen;
+  socklen_t salen = 0;
   switch(sa->sa_family)
     {
     case AF_INET:
-- 
1.9.1


