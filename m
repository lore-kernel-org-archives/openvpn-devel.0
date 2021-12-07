From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:02:06 +0100
Message-Id: <20211207170211.3275837-17-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 16/21] Remove link_mtu parameter when
 running up/down scripts
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

The link mtu is no longer used and calculating a compatibility link
MTU just for scripts makes little sense as well. Replace the parameter
instead with a fixed paramter 0.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst        |  2 ++
 src/openvpn/init.c | 16 +++-------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index c673196fa..3ae994022 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -129,6 +129,8 @@ User-visible Changes
 - CHACHA20-POLY1305 is included in the default of ``--data-ciphers`` when available.
 - Option ``--prng`` is ignored as we rely on the SSL library random number generator.
 - Option ``--nobind`` is default when ``--client`` or ``--pull`` is used in the configuration
+- :code:`link_mtu` parameter is removed from environment or replaced with 0 when scripts are
+  called with parameters. This parameter is unreliable and no longer internally calculated.
 
 Overview of changes in 2.5
 ==========================
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4f08e560a..72ffbfdfc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -113,7 +113,6 @@ run_up_down(const char *command,
 #endif
             const char *dev_type,
             int tun_mtu,
-            int link_mtu,
             const char *ifconfig_local,
             const char *ifconfig_remote,
             const char *context,
@@ -129,7 +128,6 @@ run_up_down(const char *command,
     }
     setenv_str(es, "script_context", context);
     setenv_int(es, "tun_mtu", tun_mtu);
-    setenv_int(es, "link_mtu", link_mtu);
     setenv_str(es, "dev", arg);
     if (dev_type)
     {
@@ -157,11 +155,8 @@ run_up_down(const char *command,
         struct argv argv = argv_new();
         ASSERT(arg);
         argv_printf(&argv,
-                    "%s %d %d %s %s %s",
-                    arg,
-                    tun_mtu, link_mtu,
-                    ifconfig_local, ifconfig_remote,
-                    context);
+                    "%s %d 0 %s %s %s",
+                    arg, tun_mtu, ifconfig_local, ifconfig_remote, context);
 
         if (plugin_call(plugins, plugin_type, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
@@ -177,7 +172,7 @@ run_up_down(const char *command,
         ASSERT(arg);
         setenv_str(es, "script_type", script_type);
         argv_parse_cmd(&argv, command);
-        argv_printf_cat(&argv, "%s %d %d %s %s %s", arg, tun_mtu, link_mtu,
+        argv_printf_cat(&argv, "%s %d 0 %s %s %s", arg, tun_mtu,
                         ifconfig_local, ifconfig_remote, context);
         argv_msg(M_INFO, &argv);
         openvpn_run_script(&argv, es, S_FATAL, "--up/--down");
@@ -1784,7 +1779,6 @@ do_open_tun(struct context *c)
 #endif
                 dev_type_string(c->options.dev, c->options.dev_type),
                 TUN_MTU_SIZE(&c->c2.frame),
-                EXPANDED_SIZE(&c->c2.frame),
                 print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
                 print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                 "init",
@@ -1834,7 +1828,6 @@ else
 #endif
                     dev_type_string(c->options.dev, c->options.dev_type),
                     TUN_MTU_SIZE(&c->c2.frame),
-                    EXPANDED_SIZE(&c->c2.frame),
                     print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
                     print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                     "restart",
@@ -1914,7 +1907,6 @@ do_close_tun(struct context *c, bool force)
 #endif
                             NULL,
                             TUN_MTU_SIZE(&c->c2.frame),
-                            EXPANDED_SIZE(&c->c2.frame),
                             print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                             print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                             "init",
@@ -1945,7 +1937,6 @@ do_close_tun(struct context *c, bool force)
 #endif
                         NULL,
                         TUN_MTU_SIZE(&c->c2.frame),
-                        EXPANDED_SIZE(&c->c2.frame),
                         print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                         print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                         "init",
@@ -1984,7 +1975,6 @@ do_close_tun(struct context *c, bool force)
 #endif
                             NULL,
                             TUN_MTU_SIZE(&c->c2.frame),
-                            EXPANDED_SIZE(&c->c2.frame),
                             print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                             print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                             "restart",
-- 
2.33.0


