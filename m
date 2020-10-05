From: Arne Schwabe <arne@...1227...>
Date: Mon,  5 Oct 2020 11:18:05 +0200
Message-Id: <20201005091805.17260-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Ignore deprecation warning for daemon on
 macOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

macOS warns that we should posix_spawn instead. However posix_spawn
would require a major redesign of code to daemonise or drop the --daemon
feature on macOS. Ignore the clang warning in order to allow -Werror
compile on macOS.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c                | 8 ++++++++
 src/plugins/down-root/down-root.c | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 31ecadcc..61d9cd75 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1237,10 +1237,18 @@ possibly_become_daemon(const struct options *options)
     {
         ASSERT(!options->inetd);
         /* Don't chdir immediately, but the end of the init sequence, if needed */
+
+#if defined(__APPLE__) && defined(__clang__)
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+#endif
         if (daemon(1, options->log) < 0)
         {
             msg(M_ERR, "daemon() failed or unsupported");
         }
+#if defined(__APPLE__) && defined(__clang__)
+#pragma clang diagnostic pop
+#endif
         restore_signal_state();
         if (options->log)
         {
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index c5e5023e..da445c61 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -173,10 +173,17 @@ daemonize(const char *envp[])
         {
             fd = dup(2);
         }
+#if defined(__APPLE__) && defined(__clang__)
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+#endif
         if (daemon(0, 0) < 0)
         {
             warn("DOWN-ROOT: daemonization failed");
         }
+#if defined(__APPLE__) && defined(__clang__)
+#pragma clang diagnostic pop
+#endif
         else if (fd >= 3)
         {
             dup2(fd, 2);
-- 
2.26.2


