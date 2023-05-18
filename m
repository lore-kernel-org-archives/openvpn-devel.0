From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 18 May 2023 14:00:58 +0300
Message-Id: <20230518110058.1382-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco-win: support for --dev-node
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

With --dev-node on Windows, one can specify GUID
of the adapter openvpn should use. Those can be listed with:

  C:\Program Files\OpenVPN\bin>openvpn.exe --show-adapters

While on it, remove "TAP-WIN32 / Wintun" from --show-adapters output.

Fixes https://github.com/OpenVPN/openvpn/issues/336

Change-Id: I57de4d3c069465fb730bb635bfdbdf360fc8c475
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/options.c | 4 ++--
 src/openvpn/tun.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fa435c1d..e4c596b8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3771,14 +3771,14 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
             o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
         }
     }
-#endif
-
+#else  /* _WIN32 */
     if (dco_enabled(o) && o->dev_node)
     {
         msg(M_WARN, "Note: ignoring --dev-node as it has no effect when using "
             "data channel offload");
         o->dev_node = NULL;
     }
+#endif /* _WIN32 */
 
     /* this depends on o->windows_driver, which is set above */
     options_postprocess_mutate_invariant(o);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index df10dbd2..4ef390ad 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4200,7 +4200,7 @@ show_tap_win_adapters(int msglev, int warnlev)
     const struct tap_reg *tap_reg = get_tap_reg(&gc);
     const struct panel_reg *panel_reg = get_panel_reg(&gc);
 
-    msg(msglev, "Available TAP-WIN32 / Wintun adapters [name, GUID, driver]:");
+    msg(msglev, "Available adapters [name, GUID, driver]:");
 
     /* loop through each TAP-Windows adapter registry entry */
     for (tr = tap_reg; tr != NULL; tr = tr->next)
-- 
2.23.0.windows.1


