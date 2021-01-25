From: Greg Cox <gcox@...1057...>
Date: Mon, 25 Jan 2021 07:15:57 +0000
Message-Id: <1611558957-2958-1-git-send-email-gcox@...1057...>
Subject: [Openvpn-devel] [PATCH] Fix naming error in
 sample-plugins/defer/simple.c
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
 sample/sample-plugins/defer/simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index b3c2fee48f8d2c10b10a09e8aadc1995e9cf067d..22bc22765d6773d3ea2344a328faf5008b0c5d89 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -148,7 +148,7 @@ openvpn_plugin_open_v3(const int v3structver,
     /* Check API compatibility -- struct version 5 or higher needed */
     if (v3structver < 5)
     {
-        fprintf(stderr, "sample-client-connect: this plugin is incompatible with the running version of OpenVPN\n");
+        fprintf(stderr, "%s: this plugin is incompatible with the running version of OpenVPN\n", MODULE);
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
-- 
2.7.6


