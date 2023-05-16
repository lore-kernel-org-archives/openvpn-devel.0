From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 16 May 2023 11:35:34 +0200
Message-Id: <20230516093534.26384-1-frank@...2641...>
In-Reply-To: <20230515155339.38600-1-frank@...2641...>
References: <20230515155339.38600-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] sample-plugins: Fix memleak in
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

v2:
 - remove unneccessary usages of snprintf, replace
   with strncpy.

Change-Id: Ibd1b282afc4a28768be3f165f84ab60ca4d24a9b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .../sample-plugins/client-connect/sample-client-connect.c   | 6 ++++++
 .../keying-material-exporter-demo/keyingmaterialexporter.c  | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

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
index 6a0a1f69..71badf2c 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -155,7 +155,7 @@ session_user_set(struct session *sess, X509 *x509)
 
         if (!strncasecmp(objbuf, "CN", 2))
         {
-            snprintf(sess->user, sizeof(sess->user) - 1, (char *)buf);
+            strncpy(sess->user, (char *)buf, sizeof(sess->user) - 1);
         }
 
         OPENSSL_free(buf);
@@ -234,7 +234,7 @@ tls_final(struct openvpn_plugin_args_func_in const *args,
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
-    snprintf(sess->key, sizeof(sess->key) - 1, "%s", key);
+    strncpy(sess->key, key, sizeof(sess->key) - 1);
     ovpn_note("app session key:  %s", sess->key);
 
     switch (plugin->type)
-- 
2.34.1


