From: Steffan Karger <steffan@...1856...>
Date: Sun,  3 Jun 2018 12:11:57 +0200
Message-Id: <1528020718-12721-2-git-send-email-steffan@...1856...>
In-Reply-To: <1528020718-12721-1-git-send-email-steffan@...1856...>
References: <1528020718-12721-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/3] Reject unadvertised compression
 algorithms
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

A server should not push us compression algorithms we didn't specify.  If
the server does so anyway, reject the compression algorithm.

This will result in a warning being printed, and a non-working connection
to be set up.  This is currently our way to "handle push/pull errors",
which should probably be improved.  But I didn't want refactor that in
this patch.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8         | 16 +++++++---
 src/openvpn/options.c | 85 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 0e5d467..9e988b3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2505,11 +2505,12 @@ Enable a compression algorithm.
 
 The
 .B algorithm
-parameter may be "lzo", "lz4", or empty.  LZO and LZ4
-are different compression algorithms, with LZ4 generally
-offering the best performance with least CPU usage.
-For backwards compatibility with OpenVPN versions before v2.4, use "lzo"
-(which is identical to the older option "\-\-comp\-lzo yes").
+parameter may be empty, "stub", "stub-v2", "lzo", "lz4", or "lz4-v2".
+
+LZO and LZ4 are different compression algorithms, with LZ4 generally offering
+the best performance with least CPU usage.  For backwards compatibility with
+OpenVPN versions before v2.4, use "lzo" (which is identical to the older option
+"\-\-comp\-lzo yes").
 
 If the
 .B algorithm
@@ -2517,6 +2518,11 @@ parameter is empty, compression will be turned off, but the packet
 framing for compression will still be enabled, allowing a different
 setting to be pushed later.
 
+If the
+.B algorithm
+parameter is "stub" or "stub-v2", compression framing is enabled, but no
+compression will be used (even if pushed by the server).
+
 .B Security Considerations
 
 Compression and encryption is a tricky combination.  If an attacker knows or is
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 426057a..ad44f8e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7354,50 +7354,73 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_COMP);
         options->comp.flags &= ~COMP_F_ADAPTIVE;
     }
-    else if (streq(p[0], "compress") && !p[2])
+    else if (streq(p[0], "compress") && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_COMP);
-        if (p[1])
+
+        /* Reset all compression flags, except "stubs only" and "no warn" if
+         * this option was pushed. */
+        if (streq(file, "[PUSH-OPTIONS]"))
+        {
+            options->comp.flags = options->comp.flags
+                & (COMP_F_ADVERTISE_STUBS_ONLY|COMP_F_NOWARN);
+        }
+
+        /* Parse supplied compression options */
+        if (!p[1])
         {
-            if (streq(p[1], "stub"))
+            options->comp.alg = COMP_ALG_STUB;
+            options->comp.flags |= COMP_F_SWAP;
+        }
+        else if (streq(p[1], "stub"))
+        {
+            options->comp.alg = COMP_ALG_STUB;
+            options->comp.flags |= COMP_F_SWAP;
+            if (!streq(file, "[PUSH-OPTIONS]"))
             {
-                options->comp.alg = COMP_ALG_STUB;
-                options->comp.flags = (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
+                options->comp.flags |= COMP_F_ADVERTISE_STUBS_ONLY;
             }
-            else if (streq(p[1], "stub-v2"))
+        }
+        else if (streq(p[1], "stub-v2"))
+        {
+            options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
+            if (!streq(file, "[PUSH-OPTIONS]"))
             {
-                options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
-                options->comp.flags = COMP_F_ADVERTISE_STUBS_ONLY;
+                options->comp.flags |= COMP_F_ADVERTISE_STUBS_ONLY;
             }
+        }
+        else if (options->comp.flags & COMP_F_ADVERTISE_STUBS_ONLY)
+        {
+            /* Reject pushed compression algorithms if explicitly disabled */
+            msg(msglevel, "Enabling compression not allowed!");
+            goto err;
+        }
 #if defined(ENABLE_LZO)
-            else if (streq(p[1], "lzo"))
-            {
-                options->comp.alg = COMP_ALG_LZO;
-                options->comp.flags = 0;
-            }
+        else if (streq(p[1], "lzo"))
+        {
+            options->comp.alg = COMP_ALG_LZO;
+        }
 #endif
 #if defined(ENABLE_LZ4)
-            else if (streq(p[1], "lz4"))
-            {
-                options->comp.alg = COMP_ALG_LZ4;
-                options->comp.flags = COMP_F_SWAP;
-            }
-            else if (streq(p[1], "lz4-v2"))
-            {
-                options->comp.alg = COMP_ALGV2_LZ4;
-                options->comp.flags = 0;
-            }
-#endif
-            else
-            {
-                msg(msglevel, "bad comp option: %s", p[1]);
-                goto err;
-            }
+        else if (streq(p[1], "lz4"))
+        {
+            options->comp.alg = COMP_ALG_LZ4;
+            options->comp.flags |= COMP_F_SWAP;
         }
+        else if (streq(p[1], "lz4-v2"))
+        {
+            options->comp.alg = COMP_ALGV2_LZ4;
+        }
+#endif
         else
         {
-            options->comp.alg = COMP_ALG_STUB;
-            options->comp.flags = COMP_F_SWAP;
+            msg(msglevel, "bad comp option: %s", p[1]);
+            goto err;
+        }
+
+        if (p[2] && streq(p[2], "nowarn"))
+        {
+            options->comp.flags |= COMP_F_NOWARN;
         }
     }
 #endif /* USE_COMP */
-- 
2.7.4


