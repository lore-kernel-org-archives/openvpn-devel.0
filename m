From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 15 May 2023 17:53:39 +0200
Message-Id: <20230515155339.38600-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sample-plugins: Fix memleak in
 client-connect example plugin
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

I was looking for memleaks in the code and found
this one with cppcheck. Only an example, but no
need to leave this bug in it.

Also fix fortify problem in keying-material-exporter-demo
so I can actually test the compilation of the sample
plugins.

Change-Id: Ibd1b282afc4a28768be3f165f84ab60ca4d24a9b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .../sample-plugins/client-connect/sample-client-connect.c   | 6 ++++++
 .../keying-material-exporter-demo/keyingmaterialexporter.c  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index 391de344..eb242126 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -454,6 +454,9 @@ openvpn_plugin_client_connect_v2(struct plugin_context *context,
     if (!rl->name || !rl->value)
     {
         plugin_log(PLOG_ERR, MODULE, "malloc(return_list->xx) failed");
+        free(rl->name);
+        free(rl->value);
+        free(rl);
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
@@ -509,6 +512,9 @@ openvpn_plugin_client_connect_defer_v2(struct plugin_context *context,
     if (!rl->name || !rl->value)
     {
         plugin_log(PLOG_ERR, MODULE, "malloc(return_list->xx) failed");
+        free(rl->name);
+        free(rl->value);
+        free(rl);
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 6a0a1f69..f84cf232 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -155,7 +155,7 @@ session_user_set(struct session *sess, X509 *x509)
 
         if (!strncasecmp(objbuf, "CN", 2))
         {
-            snprintf(sess->user, sizeof(sess->user) - 1, (char *)buf);
+            snprintf(sess->user, sizeof(sess->user) - 1, "%s", (char *)buf);
         }
 
         OPENSSL_free(buf);
-- 
2.34.1


