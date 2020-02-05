From: Simon Rozman <simon@...2293...>
Date: Wed,  5 Feb 2020 19:49:22 +0100
Message-Id: <20200205184922.883-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] wintun: check for conflicting options
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

`--windows-driver wintun` requires `--dev tun`. This is now checked and
documented.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 doc/openvpn.8         | 4 ++++
 src/openvpn/options.c | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 8feb3b9c..e2227a47 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6257,6 +6257,10 @@ Specifies which tun driver to use. Values are
 (default) and
 .B wintun.
 This is Windows-only option.
+"wintun" requires
+.B \-\-dev tun
+and the OpenVPN process to run elevated, or be invoked using
+the Interactive Service.
 .\"*********************************************************
 .TP
 .B \-\-dhcp\-renew
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c459b260..101cca38 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2204,7 +2204,12 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
     {
         msg(M_USAGE, "--dhcp-options requires --ip-win32 dynamic or adaptive");
     }
-#endif
+
+    if (options->windows_driver == WINDOWS_DRIVER_WINTUN && dev != DEV_TYPE_TUN)
+    {
+        msg(M_USAGE, "--windows-driver wintun requires --dev tun");
+    }
+#endif /* ifdef _WIN32 */
 
     /*
      * Check that protocol options make sense.
-- 
2.24.1.windows.2


