From: Gert Doering <gert@...1296...>
Date: Fri, 24 Jul 2020 20:13:24 +0200
Message-Id: <20200724181324.19037-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Repair --inetd
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

commit 25a422cc60 deprecated --inetd, which is still something we want.

Unlike all "usual" deprecated option warnings, we cannot print this at
option parsing time, because we need logging to be set up first - otherwise
the deprecation warning is sent via the socket (on stdin/stdout)
towards the connecting client, totally breaking this mode.

(Which is why we want to deprecate it: too special even for us)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1a915e27..a8a9bb97 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2050,6 +2050,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "--inetd nowait only makes sense in --dev tap mode");
     }
 
+    if (options->inetd)
+    {
+        msg(M_WARN, "DEPRECATED OPTION: --inetd mode is deprecated "
+                    "and will be removed in OpenVPN 2.6");
+    }
 
     if (options->lladdr && dev != DEV_TYPE_TAP)
     {
@@ -5802,8 +5807,6 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "inetd") && !p[3])
     {
-        msg(M_WARN, "DEPRECATED OPTION: --inetd mode is deprecated "
-                    "and will be removed in OpenVPN 2.6");
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (!options->inetd)
         {
-- 
2.26.2


