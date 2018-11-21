From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Nov 2018 11:10:08 +0100
Message-Id: <20181121101019.1801-3-arne@...1227...>
In-Reply-To: <20181121101019.1801-1-arne@...1227...>
References: <20181121101019.1801-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4 02/13] client-connect: Refactor
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
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a4b62151..8fc69a07 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2063,31 +2063,30 @@ multi_client_connect_source_ccd(struct multi_context *m,
                                      &gc);
 
         /* try common-name file */
-        if (platform_test_file(ccd_file))
+        if (!platform_test_file(ccd_file))
         {
-            options_server_import(&mi->context.options,
-                                  ccd_file,
-                                  D_IMPORT_ERRORS|M_OPTERR,
-                                  CLIENT_CONNECT_OPT_MASK,
-                                  option_types_found,
-                                  mi->context.c2.es);
+            ccd_file = NULL;
         }
-        else /* try default file */
+        /* try default file */
         {
             ccd_file = platform_gen_path(mi->context.options.client_config_dir,
                                          CCD_DEFAULT,
                                          &gc);
-
-            if (platform_test_file(ccd_file))
+            if (!platform_test_file(ccd_file))
             {
-                options_server_import(&mi->context.options,
-                                      ccd_file,
-                                      D_IMPORT_ERRORS|M_OPTERR,
-                                      CLIENT_CONNECT_OPT_MASK,
-                                      option_types_found,
-                                      mi->context.c2.es);
+                ccd_file = NULL;
             }
         }
+
+        if (ccd_file)
+        {
+            options_server_import(&mi->context.options,
+                                  ccd_file,
+                                  D_IMPORT_ERRORS|M_OPTERR,
+                                  CLIENT_CONNECT_OPT_MASK,
+                                  option_types_found,
+                                  mi->context.c2.es);
+        }
         gc_free(&gc);
     }
 }
-- 
2.19.1


