From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  8 Oct 2018 13:46:52 +0300
Message-Id: <1538995612-17450-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix various compiler warnings
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

From: Lev Stipakov <lev@...515...>

This patch fixes "unused variable/unreferenced format parameter"
warnings in different places, kudos to Visual Studio compiler
for discoveing some of those.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/forward.c |  2 +-
 src/openvpn/init.c    |  2 +-
 src/openvpn/init.h    |  2 +-
 src/openvpn/mtcp.c    |  2 +-
 src/openvpn/mudp.c    |  2 +-
 src/openvpn/multi.c   | 28 +++++++++++++---------------
 src/openvpn/multi.h   |  8 ++++----
 src/openvpn/openvpn.c |  2 +-
 src/openvpn/tun.c     | 11 ++++-------
 src/openvpn/tun.h     |  2 +-
 src/openvpn/win32.c   |  3 +--
 11 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f8faa81..35de490 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1251,7 +1251,7 @@ read_incoming_tun(struct context *c)
 
     c->c2.buf = c->c2.buffers->read_tun_buf;
 #ifdef TUN_PASS_BUFFER
-    read_tun_buffered(c->c1.tuntap, &c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame));
+    read_tun_buffered(c->c1.tuntap, &c->c2.buf);
 #else
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
     ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52c64da..3dfa632 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3858,7 +3858,7 @@ init_management_callback_p2p(struct context *c)
 #ifdef ENABLE_MANAGEMENT
 
 void
-init_management(struct context *c)
+init_management(void)
 {
     if (!management)
     {
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 085ac53..d4bacf4 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -119,7 +119,7 @@ void initialization_sequence_completed(struct context *c, const unsigned int fla
 
 #ifdef ENABLE_MANAGEMENT
 
-void init_management(struct context *c);
+void init_management(void);
 
 bool open_management(struct context *c);
 
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index a53efad..31c92a2 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -834,7 +834,7 @@ tunnel_server_tcp(struct context *top)
 #endif
 
     /* shut down management interface */
-    uninit_management_callback_multi(&multi);
+    uninit_management_callback_multi();
 
     /* save ifconfig-pool */
     multi_ifconfig_pool_persist(&multi, true);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index a604d21..7fdd776 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -362,7 +362,7 @@ tunnel_server_udp_single_threaded(struct context *top)
 #endif
 
     /* shut down management interface */
-    uninit_management_callback_multi(&multi);
+    uninit_management_callback_multi();
 
     /* save ifconfig-pool */
     multi_ifconfig_pool_persist(&multi, true);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8440f31..ae4d1d2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -557,8 +557,7 @@ setenv_stats(struct context *c)
 }
 
 static void
-multi_client_disconnect_setenv(struct multi_context *m,
-                               struct multi_instance *mi)
+multi_client_disconnect_setenv(struct multi_instance *mi)
 {
     /* setenv client real IP address */
     setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi->context));
@@ -571,13 +570,12 @@ multi_client_disconnect_setenv(struct multi_context *m,
 }
 
 static void
-multi_client_disconnect_script(struct multi_context *m,
-                               struct multi_instance *mi)
+multi_client_disconnect_script(struct multi_instance *mi)
 {
     if ((mi->context.c2.context_auth == CAS_SUCCEEDED && mi->connection_established_flag)
         || mi->context.c2.context_auth == CAS_PARTIAL)
     {
-        multi_client_disconnect_setenv(m, mi);
+        multi_client_disconnect_setenv(mi);
 
         if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT))
         {
@@ -684,7 +682,7 @@ multi_close_instance(struct multi_context *m,
     set_cc_config(mi, NULL);
 #endif
 
-    multi_client_disconnect_script(m, mi);
+    multi_client_disconnect_script(mi);
 
     if (mi->did_open_context)
     {
@@ -1112,7 +1110,7 @@ multi_learn_addr(struct multi_context *m,
 
         if (oldroute) /* route already exists? */
         {
-            if (route_quota_test(m, mi) && learn_address_script(m, mi, "update", &newroute->addr))
+            if (route_quota_test(mi) && learn_address_script(m, mi, "update", &newroute->addr))
             {
                 learn_succeeded = true;
                 owner = mi;
@@ -1129,7 +1127,7 @@ multi_learn_addr(struct multi_context *m,
         }
         else
         {
-            if (route_quota_test(m, mi) && learn_address_script(m, mi, "add", &newroute->addr))
+            if (route_quota_test(mi) && learn_address_script(m, mi, "add", &newroute->addr))
             {
                 learn_succeeded = true;
                 owner = mi;
@@ -1579,7 +1577,7 @@ multi_select_virtual_addr(struct multi_context *m, struct multi_instance *mi)
  * Set virtual address environmental variables.
  */
 static void
-multi_set_virtual_addr_env(struct multi_context *m, struct multi_instance *mi)
+multi_set_virtual_addr_env(struct multi_instance *mi)
 {
     setenv_del(mi->context.c2.es, "ifconfig_pool_local_ip");
     setenv_del(mi->context.c2.es, "ifconfig_pool_remote_ip");
@@ -1658,7 +1656,7 @@ multi_client_connect_post(struct multi_context *m,
          * directory or any --ifconfig-pool dynamic address.
          */
         multi_select_virtual_addr(m, mi);
-        multi_set_virtual_addr_env(m, mi);
+        multi_set_virtual_addr_env(mi);
     }
 }
 
@@ -1702,7 +1700,7 @@ multi_client_connect_post_plugin(struct multi_context *m,
          * directory or any --ifconfig-pool dynamic address.
          */
         multi_select_virtual_addr(m, mi);
-        multi_set_virtual_addr_env(m, mi);
+        multi_set_virtual_addr_env(mi);
     }
 }
 
@@ -1742,7 +1740,7 @@ multi_client_connect_mda(struct multi_context *m,
          * directory or any --ifconfig-pool dynamic address.
          */
         multi_select_virtual_addr(m, mi);
-        multi_set_virtual_addr_env(m, mi);
+        multi_set_virtual_addr_env(mi);
     }
 }
 
@@ -1761,7 +1759,7 @@ multi_client_connect_setenv(struct multi_context *m,
     setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi->context));
 
     /* setenv client virtual IP address */
-    multi_set_virtual_addr_env(m, mi);
+    multi_set_virtual_addr_env(mi);
 
     /* setenv connection time */
     {
@@ -2936,7 +2934,7 @@ multi_process_drop_outgoing_tun(struct multi_context *m, const unsigned int mpp_
  */
 
 void
-route_quota_exceeded(const struct multi_context *m, const struct multi_instance *mi)
+route_quota_exceeded(const struct multi_instance *mi)
 {
     struct gc_arena gc = gc_new();
     msg(D_ROUTE_QUOTA, "MULTI ROUTE: route quota (%d) exceeded for %s (see --max-routes-per-client option)",
@@ -3373,7 +3371,7 @@ init_management_callback_multi(struct multi_context *m)
 }
 
 void
-uninit_management_callback_multi(struct multi_context *m)
+uninit_management_callback_multi(void)
 {
     uninit_management_callback();
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3d3d687..f0dca9d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -346,7 +346,7 @@ void multi_close_instance_on_signal(struct multi_context *m, struct multi_instan
 
 void init_management_callback_multi(struct multi_context *m);
 
-void uninit_management_callback_multi(struct multi_context *m);
+void uninit_management_callback_multi(void);
 
 
 #ifdef ENABLE_ASYNC_PUSH
@@ -403,7 +403,7 @@ multi_process_outgoing_link_pre(struct multi_context *m)
  * Per-client route quota management
  */
 
-void route_quota_exceeded(const struct multi_context *m, const struct multi_instance *mi);
+void route_quota_exceeded(const struct multi_instance *mi);
 
 static inline void
 route_quota_inc(struct multi_instance *mi)
@@ -419,11 +419,11 @@ route_quota_dec(struct multi_instance *mi)
 
 /* can we add a new route? */
 static inline bool
-route_quota_test(const struct multi_context *m, const struct multi_instance *mi)
+route_quota_test(const struct multi_instance *mi)
 {
     if (mi->route_count >= mi->context.options.max_routes_per_client)
     {
-        route_quota_exceeded(m, mi);
+        route_quota_exceeded(mi);
         return false;
     }
     else
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 5d6a41c..ad73af5 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -199,7 +199,7 @@ openvpn_main(int argc, char *argv[])
 
 #ifdef ENABLE_MANAGEMENT
             /* initialize management subsystem */
-            init_management(&c);
+            init_management();
 #endif
 
             /* initialize options to default state */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 948fd17..8ca8dd4 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4867,7 +4867,6 @@ void
 ipconfig_register_dns(const struct env_set *es)
 {
     struct argv argv = argv_new();
-    bool status;
     const char err[] = "ERROR: Windows ipconfig command failed";
 
     msg(D_TUNTAP_INFO, "Start ipconfig commands for register-dns...");
@@ -4877,14 +4876,14 @@ ipconfig_register_dns(const struct env_set *es)
                 get_win_sys_path(),
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
-    status = openvpn_execve_check(&argv, es, 0, err);
+    openvpn_execve_check(&argv, es, 0, err);
     argv_reset(&argv);
 
     argv_printf(&argv, "%s%sc /registerdns",
                 get_win_sys_path(),
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
-    status = openvpn_execve_check(&argv, es, 0, err);
+    openvpn_execve_check(&argv, es, 0, err);
     argv_reset(&argv);
 
     netcmd_semaphore_release();
@@ -5178,8 +5177,7 @@ netsh_ifconfig(const struct tuntap_options *to,
 }
 
 static void
-netsh_enable_dhcp(const struct tuntap_options *to,
-                  const char *actual_name)
+netsh_enable_dhcp(const char *actual_name)
 {
     struct argv argv = argv_new();
 
@@ -5199,7 +5197,6 @@ netsh_enable_dhcp(const struct tuntap_options *to,
 static bool
 service_enable_dhcp(const struct tuntap *tt)
 {
-    DWORD len;
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
@@ -5720,7 +5717,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                 }
                 else
                 {
-                    netsh_enable_dhcp(&tt->options, tt->actual_name);
+                    netsh_enable_dhcp(tt->actual_name);
                 }
             }
             dhcp_masq = true;
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index cb1ab1c..9ed8ef0 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -457,7 +457,7 @@ tun_write_win32(struct tuntap *tt, struct buffer *buf)
 }
 
 static inline int
-read_tun_buffered(struct tuntap *tt, struct buffer *buf, int maxsize)
+read_tun_buffered(struct tuntap *tt, struct buffer *buf)
 {
     return tun_finalize(tt->hand, &tt->reads, buf);
 }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index e43296e..2e8a4b0 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -685,11 +685,10 @@ win32_pause(struct win32_signal *ws)
 {
     if (ws->mode == WSO_MODE_CONSOLE && HANDLE_DEFINED(ws->in.read))
     {
-        int status;
         msg(M_INFO|M_NOPREFIX, "Press any key to continue...");
         do
         {
-            status = WaitForSingleObject(ws->in.read, INFINITE);
+            WaitForSingleObject(ws->in.read, INFINITE);
         } while (!win32_keyboard_get(ws));
     }
 }
-- 
2.7.4


