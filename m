From: Arne Schwabe <arne@...1227...>
Date: Mon, 18 May 2020 17:54:27 +0200
Message-Id: <20200518155427.17283-1-arne@...1227...>
In-Reply-To: <20200326172332.2356-1-arne@...1227...>
References: <20200326172332.2356-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Refuse server mode on Android
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

After the commit 042429d3 "build: Remove --disable-server from ./configure"
Android needs another way to ensure that OpenVPN is not run in server mode.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2da8cf6d..bfba62ad 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2254,6 +2254,9 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
      */
     if (options->mode == MODE_SERVER)
     {
+#ifdef TARGET_ANDROID
+        msg(M_FATAL, "--mode server not supported on Android");
+#endif
         if (!(dev == DEV_TYPE_TUN || dev == DEV_TYPE_TAP))
         {
             msg(M_USAGE, "--mode server only works with --dev tun or --dev tap");
-- 
2.26.0


