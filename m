From: hashiz <hashiz@...2305...>
Date: Thu, 28 Sep 2017 12:16:20 +0900
Message-Id: <20170928031620.22331-1-hashiz@...2305...>
Subject: [Openvpn-devel] [PATCH] Fixed that "--bind ipv6only" did not work
 due to incorrect parameter processing. It seems that "ipv6only" did not
 work from the beginning.
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

---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3a5bccfc..5f31e7eb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5881,7 +5881,7 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
         options->ce.remote_port = p[1];
     }
-    else if (streq(p[0], "bind") && !p[1])
+    else if (streq(p[0], "bind") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
         options->ce.bind_defined = true;
-- 
2.11.0


