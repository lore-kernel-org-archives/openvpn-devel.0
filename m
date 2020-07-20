From: Gert Doering <gert@...1296...>
Date: Mon, 20 Jul 2020 09:08:02 +0200
Message-Id: <20200720070802.18819-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Separate handling of non-deferred return
 values for client-connect-scripts.
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

(Only) on "CC_RET_SUCCESS", run multi_client_connect_post().

On "CC_RET_FAILURE", add missing log line, do not call ..._post().

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 08112c98..e99de713 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2139,13 +2139,19 @@ multi_client_connect_script_deferred(struct multi_context *m,
         ret = CC_RET_DEFERRED;
     }
 
-    if (ret != CC_RET_DEFERRED)
+    if (ret == CC_RET_SUCCEEDED)
     {
         ccs_delete_deferred_ret_file(mi);
         multi_client_connect_post(m, mi, ccs->config_file,
                                   option_types_found);
         ccs_delete_config_file(mi);
     }
+    if (ret == CC_RET_FAILED)
+    {
+	msg(M_INFO, "MULTI: deferred --client-connect script returned CC_RET_FAILED");
+        ccs_delete_deferred_ret_file(mi);
+        ccs_delete_config_file(mi);
+    }
     return ret;
 }
 
-- 
2.26.2


