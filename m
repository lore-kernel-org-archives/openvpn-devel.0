From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  9 Sep 2022 09:41:26 +0300
Message-Id: <20220909064126.482-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] do_persist_tuntap: remove indentation level
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Reverse if condition - this allows us to get rid of
indentation level, which makes code easier to read.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/init.c | 88 ++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 84d95c21..d94b781e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1057,57 +1057,59 @@ do_genkey(const struct options *options)
 bool
 do_persist_tuntap(struct options *options, openvpn_net_ctx_t *ctx)
 {
-    if (options->persist_config)
-    {
-        /* sanity check on options for --mktun or --rmtun */
-        notnull(options->dev, "TUN/TAP device (--dev)");
-        if (options->ce.remote || options->ifconfig_local
-            || options->ifconfig_remote_netmask
-            || options->shared_secret_file
-            || options->tls_server || options->tls_client
-            )
-        {
-            msg(M_FATAL|M_OPTERR,
-                "options --mktun or --rmtun should only be used together with --dev");
-        }
+    if (!options->persist_config)
+    {
+        return false;
+    }
 
-#if defined(ENABLE_DCO)
-        if (dco_enabled(options))
-        {
-            /* creating a DCO interface via --mktun is not supported as it does not
-             * make much sense. Since DCO is enabled by default, people may run into
-             * this without knowing, therefore this case should be properly handled.
-             *
-             * Disable DCO if --mktun was provided and print a message to let
-             * user know.
-             */
-            if (dev_type_enum(options->dev, options->dev_type) == DEV_TYPE_TUN)
-            {
-                msg(M_WARN, "Note: --mktun does not support DCO. Creating TUN interface.");
-            }
+    /* sanity check on options for --mktun or --rmtun */
+    notnull(options->dev, "TUN/TAP device (--dev)");
+    if (options->ce.remote || options->ifconfig_local
+        || options->ifconfig_remote_netmask
+        || options->shared_secret_file
+        || options->tls_server || options->tls_client
+        )
+    {
+        msg(M_FATAL|M_OPTERR,
+            "options --mktun or --rmtun should only be used together with --dev");
+    }
 
-            options->tuntap_options.disable_dco = true;
+#if defined(ENABLE_DCO)
+    if (dco_enabled(options))
+    {
+        /* creating a DCO interface via --mktun is not supported as it does not
+         * make much sense. Since DCO is enabled by default, people may run into
+         * this without knowing, therefore this case should be properly handled.
+         *
+         * Disable DCO if --mktun was provided and print a message to let
+         * user know.
+         */
+        if (dev_type_enum(options->dev, options->dev_type) == DEV_TYPE_TUN)
+        {
+            msg(M_WARN, "Note: --mktun does not support DCO. Creating TUN interface.");
         }
+
+        options->tuntap_options.disable_dco = true;
+    }
 #endif
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
-        tuncfg(options->dev, options->dev_type, options->dev_node,
-               options->persist_mode,
-               options->username, options->groupname, &options->tuntap_options,
-               ctx);
-        if (options->persist_mode && options->lladdr)
-        {
-            set_lladdr(ctx, options->dev, options->lladdr, NULL);
-        }
-        return true;
+    tuncfg(options->dev, options->dev_type, options->dev_node,
+           options->persist_mode,
+           options->username, options->groupname, &options->tuntap_options,
+           ctx);
+    if (options->persist_mode && options->lladdr)
+    {
+        set_lladdr(ctx, options->dev, options->lladdr, NULL);
+    }
+    return true;
 #else  /* ifdef ENABLE_FEATURE_TUN_PERSIST */
-        msg( M_FATAL|M_OPTERR,
-             "options --mktun and --rmtun are not available on your operating "
-             "system.  Please check 'man tun' (or 'tap'), whether your system "
-             "supports using 'ifconfig %s create' / 'destroy' to create/remove "
-             "persistent tunnel interfaces.", options->dev );
+    msg(M_FATAL|M_OPTERR,
+        "options --mktun and --rmtun are not available on your operating "
+        "system.  Please check 'man tun' (or 'tap'), whether your system "
+        "supports using 'ifconfig %s create' / 'destroy' to create/remove "
+        "persistent tunnel interfaces.", options->dev );
 #endif
-    }
     return false;
 }
 
-- 
2.23.0.windows.1


