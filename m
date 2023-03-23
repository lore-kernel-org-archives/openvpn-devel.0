From: Arne Schwabe <arne@...1227...>
Date: Thu, 23 Mar 2023 18:05:58 +0100
Message-Id: <20230323170601.1256132-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 1/4] Simplify --compress parsing in
 options.c
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

This removes a level of identation and make the "stub" condition
easier to see.

Change-Id: Iae47b191f522625f81eedd3a237b272cb7374d90
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 87 +++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64a8250b2..2bed4ce99 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8458,60 +8458,59 @@ add_option(struct options *options,
     else if (streq(p[0], "compress") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_COMP);
+        const char *alg = "stub";
         if (p[1])
         {
-            if (streq(p[1], "stub"))
-            {
-                options->comp.alg = COMP_ALG_STUB;
-                options->comp.flags |= (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
-            }
-            else if (streq(p[1], "stub-v2"))
-            {
-                options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
-                options->comp.flags |= COMP_F_ADVERTISE_STUBS_ONLY;
-            }
-            else if (streq(p[1], "migrate"))
-            {
-                options->comp.alg = COMP_ALG_UNDEF;
-                options->comp.flags = COMP_F_MIGRATE;
+            alg = p[1];
+        }
 
-            }
-            else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
-            {
-                /* Also printed on a push to hint at configuration problems */
-                msg(msglevel, "Cannot set compress to '%s', "
-                    "allow-compression is set to 'no'", p[1]);
-                goto err;
-            }
+        if (streq(alg, "stub"))
+        {
+            options->comp.alg = COMP_ALG_STUB;
+            options->comp.flags |= (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
+        }
+        else if (streq(alg, "stub-v2"))
+        {
+            options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
+            options->comp.flags |= COMP_F_ADVERTISE_STUBS_ONLY;
+        }
+        else if (streq(alg, "migrate"))
+        {
+            options->comp.alg = COMP_ALG_UNDEF;
+            options->comp.flags = COMP_F_MIGRATE;
+
+        }
+        else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
+        {
+            /* Also printed on a push to hint at configuration problems */
+            msg(msglevel, "Cannot set compress to '%s', "
+                "allow-compression is set to 'no'", alg);
+            goto err;
+        }
 #if defined(ENABLE_LZO)
-            else if (streq(p[1], "lzo"))
-            {
-                options->comp.alg = COMP_ALG_LZO;
-                options->comp.flags &= ~(COMP_F_ADAPTIVE | COMP_F_SWAP);
-            }
+        else if (streq(alg, "lzo"))
+        {
+            options->comp.alg = COMP_ALG_LZO;
+            options->comp.flags &= ~(COMP_F_ADAPTIVE | COMP_F_SWAP);
+        }
 #endif
 #if defined(ENABLE_LZ4)
-            else if (streq(p[1], "lz4"))
-            {
-                options->comp.alg = COMP_ALG_LZ4;
-                options->comp.flags |= COMP_F_SWAP;
-            }
-            else if (streq(p[1], "lz4-v2"))
-            {
-                options->comp.alg = COMP_ALGV2_LZ4;
-            }
-#endif
-            else
-            {
-                msg(msglevel, "bad comp option: %s", p[1]);
-                goto err;
-            }
+        else if (streq(alg, "lz4"))
+        {
+            options->comp.alg = COMP_ALG_LZ4;
+            options->comp.flags |= COMP_F_SWAP;
+        }
+        else if (streq(alg, "lz4-v2"))
+        {
+            options->comp.alg = COMP_ALGV2_LZ4;
         }
+#endif
         else
         {
-            options->comp.alg = COMP_ALG_STUB;
-            options->comp.flags |= COMP_F_SWAP;
+            msg(msglevel, "bad comp option: %s", alg);
+            goto err;
         }
+
         show_compression_warning(&options->comp);
     }
 #endif /* USE_COMP */
-- 
2.37.1 (Apple Git-137.1)


