From: Gert Doering <gert@...1296...>
Date: Mon,  2 Aug 2021 15:31:27 +0200
Message-Id: <20210802133127.25000-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ignore --explicit-exit-notify in TCP mode.
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

Mixed udp+tcp configs can not have --explicit-exit-notify in them
today because this option is refused in TCP mode.  At the same time,
it was always possible to push the option both in UDP and TCP mode
(with a warning logged in TCP mode, and the option reset to 0).

Do the same thing for local config - warn, and reset to 0.

(Leaving it enabled in TCP mode is harmless, but causes extra error
messages in the log which is undesired behaviour.  Maybe one should
just fix the underlying logic for TCP mode instead, but this is more
invasive)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 63cda1e8..7e146db9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2266,12 +2266,6 @@ options_postprocess_verify_ce(const struct options *options,
     }
 #endif
 
-    if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
-    {
-        msg(M_USAGE,
-            "--explicit-exit-notify can only be used with --proto udp");
-    }
-
     if (!ce->remote && ce->proto == PROTO_TCP_CLIENT)
     {
         msg(M_USAGE, "--remote MUST be used in TCP Client mode");
@@ -2978,6 +2972,13 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         connection_entry_preload_key(&ce->tls_crypt_v2_file,
                                      &ce->tls_crypt_v2_file_inline, &o->gc);
     }
+
+    if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
+    {
+        msg(M_WARN, "NOTICE: --explicit-exit-notify ignored for --proto tcp");
+        ce->explicit_exit_notification = 0;
+    }
+
 }
 
 #ifdef _WIN32
-- 
2.26.3


