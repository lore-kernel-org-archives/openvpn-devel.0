From: Antonio Quartulli <a@...2181...>
Date: Thu, 13 Jan 2022 11:14:34 +0100
Message-Id: <20220113101434.30223-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sig.c: define signal_handler on non-windows
 only
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
Cc: Antonio Quartulli <a@...2181...>

signal_handler() is unused on Windows and generates a warning.
Confine it within "ifdef _WIN32" in order to reduce the compilation
noise.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/sig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index eadd7109..9747c083 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -214,7 +214,7 @@ signal_restart_status(const struct signal_info *si)
 #endif /* ifdef ENABLE_MANAGEMENT */
 }
 
-
+#ifndef _WIN32
 /* normal signal handler, when we are in event loop */
 static void
 signal_handler(const int signum)
@@ -222,6 +222,7 @@ signal_handler(const int signum)
     throw_signal(signum);
     signal(signum, signal_handler);
 }
+#endif
 
 
 /* set handlers for unix signals */
-- 
2.34.1


