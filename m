From: Gert Doering <gert@...1296...>
Date: Fri, 30 Nov 2018 14:56:39 +0100
Message-Id: <20181130135641.11533-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Uncrustify sample-plugin sources
 according to code style
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

Signed-off-by: Gert Doering <gert@...1296...>
---
 .../keying-material-exporter-demo/keyingmaterialexporter.c  | 6 ++++--
 sample/sample-plugins/log/log.c                             | 4 ++++
 sample/sample-plugins/log/log_v3.c                          | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 9986461b..b53f13f6 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -230,7 +230,8 @@ tls_final(struct openvpn_plugin_args_func_in const *args,
     snprintf(sess->key, sizeof(sess->key) - 1, "%s", key);
     ovpn_note("app session key:  %s", sess->key);
 
-    switch (plugin->type) {
+    switch (plugin->type)
+    {
         case SERVER:
             server_store(args);
             break;
@@ -249,7 +250,8 @@ openvpn_plugin_func_v3(const int version,
                        struct openvpn_plugin_args_func_in const *args,
                        struct openvpn_plugin_args_func_return *rv)
 {
-    switch (args->type) {
+    switch (args->type)
+    {
         case OPENVPN_PLUGIN_TLS_VERIFY:
             return tls_verify(args);
 
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index ecf62c0e..b5c1c3be 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -156,11 +156,15 @@ show(const int type, const char *argv[], const char *envp[])
 
     printf("ARGV\n");
     for (i = 0; argv[i] != NULL; ++i)
+    {
         printf("%d '%s'\n", (int)i, argv[i]);
+    }
 
     printf("ENVP\n");
     for (i = 0; envp[i] != NULL; ++i)
+    {
         printf("%d '%s'\n", (int)i, envp[i]);
+    }
 }
 
 OPENVPN_EXPORT int
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 3ef4a1cb..17b83f3f 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -177,11 +177,15 @@ show(const int type, const char *argv[], const char *envp[])
 
     printf("ARGV\n");
     for (i = 0; argv[i] != NULL; ++i)
+    {
         printf("%d '%s'\n", (int)i, argv[i]);
+    }
 
     printf("ENVP\n");
     for (i = 0; envp[i] != NULL; ++i)
+    {
         printf("%d '%s'\n", (int)i, envp[i]);
+    }
 }
 
 static void
-- 
2.19.2


