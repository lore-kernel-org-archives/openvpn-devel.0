From: Arne Schwabe <arne@...1227...>
Date: Sat, 11 Jul 2020 11:36:44 +0200
Message-Id: <20200711093655.23686-3-arne@...1227...>
In-Reply-To: <20200711093655.23686-1-arne@...1227...>
References: <20200711093655.23686-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v5 03/14] client-connect: Refactor
 multi_client_connect_source_ccd
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

From: Fabian Knittel <fabian.knittel@...1547...>

Refactor multi_client_connect_source_ccd(), so that options_server_import() (or
the success path in general) is only entered in one place within the function.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>

Patch V5: Simplify the logic even further to make more easy to understand.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3c4ceeb5..35e0bd10 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2164,15 +2164,30 @@ multi_client_connect_source_ccd(struct multi_context *m,
     if (mi->context.options.client_config_dir)
     {
         struct gc_arena gc = gc_new();
-        const char *ccd_file;
+        const char *ccd_file = NULL;
+
+        const char *ccd_client = platform_gen_path(mi->context.options.client_config_dir,
+                                                   tls_common_name(mi->context.c2.tls_multi,
+                                                                   false),
+                                                   &gc);
+
+        const char *ccd_default = platform_gen_path(mi->context.options.client_config_dir,
+                                                    CCD_DEFAULT,
+                                                    &gc);
 
-        ccd_file = platform_gen_path(mi->context.options.client_config_dir,
-                                     tls_common_name(mi->context.c2.tls_multi,
-                                                     false),
-                                     &gc);
 
         /* try common-name file */
-        if (platform_test_file(ccd_file))
+        if (platform_test_file(ccd_client))
+        {
+            ccd_file = ccd_client;
+        }
+        /* try default file */
+        else if (platform_test_file(ccd_default))
+        {
+            ccd_file = ccd_default;
+        }
+
+        if (ccd_file)
         {
             options_server_import(&mi->context.options,
                                   ccd_file,
@@ -2181,22 +2196,6 @@ multi_client_connect_source_ccd(struct multi_context *m,
                                   option_types_found,
                                   mi->context.c2.es);
         }
-        else /* try default file */
-        {
-            ccd_file = platform_gen_path(mi->context.options.client_config_dir,
-                                         CCD_DEFAULT,
-                                         &gc);
-
-            if (platform_test_file(ccd_file))
-            {
-                options_server_import(&mi->context.options,
-                                      ccd_file,
-                                      D_IMPORT_ERRORS|M_OPTERR,
-                                      CLIENT_CONNECT_OPT_MASK,
-                                      option_types_found,
-                                      mi->context.c2.es);
-            }
-        }
         gc_free(&gc);
     }
 }
-- 
2.26.2


