From: Gert Doering <gert@...1296...>
Date: Wed,  9 Sep 2020 12:48:37 +0200
Message-Id: <20200909104837.6123-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Handle NULL returns from calloc() in sample
 plugins.
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

This is basic housekeeping, adding NULL checks to context initialization
of the sample plugin collection which are missing it.  Realistically,
this can never happen, but since these are supposed to be "good examples",
not checking calloc() return isn't one.

Trac: #587

Reported-By: Dogbert (in Trac)
Signed-off-by: Gert Doering <gert@...1296...>
---
 sample/sample-plugins/defer/simple.c                        | 5 +++++
 .../keying-material-exporter-demo/keyingmaterialexporter.c  | 6 ++++++
 sample/sample-plugins/log/log.c                             | 5 +++++
 sample/sample-plugins/log/log_v3.c                          | 5 +++++
 sample/sample-plugins/simple/simple.c                       | 5 +++++
 5 files changed, 26 insertions(+)

diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index d18695b5..64338b4a 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -141,6 +141,11 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
      * Allocate our context
      */
     context = (struct plugin_context *) calloc(1, sizeof(struct plugin_context));
+    if (context == NULL)
+    {
+        printf("PLUGIN: allocating memory for context failed\n");
+        return NULL;
+    }
 
     context->test_deferred_auth = atoi_null0(get_env("test_deferred_auth", envp));
     printf("TEST_DEFERRED_AUTH %d\n", context->test_deferred_auth);
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index b53f13f6..27275f33 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -92,6 +92,12 @@ openvpn_plugin_open_v3(const int version,
 {
     struct plugin *plugin = calloc(1, sizeof(*plugin));
 
+    if (plugin == NULL)
+    {
+        printf("PLUGIN: allocating memory for context failed\n");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
     plugin->type = get_env("remote_1", args->envp) ? CLIENT : SERVER;
     plugin->log  = args->callbacks->plugin_log;
 
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index b5c1c3be..a782aa97 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -78,6 +78,11 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
      * Allocate our context
      */
     context = (struct plugin_context *) calloc(1, sizeof(struct plugin_context));
+    if (context == NULL)
+    {
+        printf("PLUGIN: allocating memory for context failed\n");
+        return NULL;
+    }
 
     /*
      * Set the username/password we will require.
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 17b83f3f..13444997 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -113,6 +113,11 @@ openvpn_plugin_open_v3(const int v3structver,
 
     /* Allocate our context */
     context = (struct plugin_context *) calloc(1, sizeof(struct plugin_context));
+    if (context == NULL)
+    {
+        printf("PLUGIN: allocating memory for context failed\n");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
 
     /* Set the username/password we will require. */
     context->username = "foo";
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 950c547e..60cfea4f 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -80,6 +80,11 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
      * Allocate our context
      */
     context = (struct plugin_context *) calloc(1, sizeof(struct plugin_context));
+    if (context == NULL)
+    {
+        printf("PLUGIN: allocating memory for context failed\n");
+        return NULL;
+    }
 
     /*
      * Set the username/password we will require.
-- 
2.26.2


