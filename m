From: selva.nair@...277...
Date: Thu, 30 Jun 2022 20:07:26 -0400
Message-Id: <20220701000726.8198-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove management_write_peer_info_file and
 related code
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

From: Selva Nair <selva.nair@...277...>

Use of this has never been documented and the code was
dead for a long while now.

Signed-off-by: Selva Nair <selva.nair@...277...>
---

Alternative for [PATCH 2/3] Reactivate record_peer_info in manage.c

 src/openvpn/init.c    |  1 -
 src/openvpn/manage.c  | 49 -------------------------------------------
 src/openvpn/manage.h  |  2 --
 src/openvpn/options.c |  5 +----
 src/openvpn/options.h |  1 -
 5 files changed, 1 insertion(+), 57 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 03221cbb..1bfbf4eb 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3862,7 +3862,6 @@ open_management(struct context *c)
                                 c->options.management_log_history_cache,
                                 c->options.management_echo_buffer_size,
                                 c->options.management_state_buffer_size,
-                                c->options.management_write_peer_info_file,
                                 c->options.remap_sigusr1,
                                 flags))
             {
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 50f162a3..19e44221 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1614,48 +1614,6 @@ man_stop_ne32(struct management *man)
 
 #endif /* ifdef _WIN32 */
 
-static void
-man_record_peer_info(struct management *man)
-{
-    struct gc_arena gc = gc_new();
-    if (man->settings.write_peer_info_file)
-    {
-        bool success = false;
-#ifdef HAVE_GETSOCKNAME
-        if (socket_defined(man->connection.sd_cli))
-        {
-            struct sockaddr_in addr;
-            socklen_t addrlen = sizeof(addr);
-            int status;
-
-            CLEAR(addr);
-            status = getsockname(man->connection.sd_cli, (struct sockaddr *)&addr, &addrlen);
-            if (!status && addrlen == sizeof(addr))
-            {
-                const in_addr_t a = ntohl(addr.sin_addr.s_addr);
-                const int p = ntohs(addr.sin_port);
-                FILE *fp = platform_fopen(man->settings.write_peer_info_file, "w");
-                if (fp)
-                {
-                    fprintf(fp, "%s\n%d\n", print_in_addr_t(a, 0, &gc), p);
-                    if (!fclose(fp))
-                    {
-                        success = true;
-                    }
-                }
-            }
-        }
-#endif /* ifdef HAVE_GETSOCKNAME */
-        if (!success)
-        {
-            msg(D_MANAGEMENT, "MANAGEMENT: failed to write peer info to file %s",
-                man->settings.write_peer_info_file);
-            throw_signal_soft(SIGTERM, "management-connect-failed");
-        }
-    }
-    gc_free(&gc);
-}
-
 static void
 man_connection_settings_reset(struct management *man)
 {
@@ -1903,7 +1861,6 @@ man_connect(struct management *man)
         goto done;
     }
 
-    man_record_peer_info(man);
     man_new_connection_post(man, "Connected to management server at");
 
 done:
@@ -2376,7 +2333,6 @@ man_settings_init(struct man_settings *ms,
                   const int log_history_cache,
                   const int echo_buffer_size,
                   const int state_buffer_size,
-                  const char *write_peer_info_file,
                   const int remap_sigusr1,
                   const unsigned int flags)
 {
@@ -2416,8 +2372,6 @@ man_settings_init(struct man_settings *ms,
             ASSERT(ms->client_gid >= 0);
         }
 
-        ms->write_peer_info_file = string_alloc(write_peer_info_file, NULL);
-
 #if UNIX_SOCK_SUPPORT
         if (ms->flags & MF_UNIX_SOCK)
         {
@@ -2481,7 +2435,6 @@ man_settings_close(struct man_settings *ms)
     {
         freeaddrinfo(ms->local);
     }
-    free(ms->write_peer_info_file);
     CLEAR(*ms);
 }
 
@@ -2584,7 +2537,6 @@ management_open(struct management *man,
                 const int log_history_cache,
                 const int echo_buffer_size,
                 const int state_buffer_size,
-                const char *write_peer_info_file,
                 const int remap_sigusr1,
                 const unsigned int flags)
 {
@@ -2603,7 +2555,6 @@ management_open(struct management *man,
                       log_history_cache,
                       echo_buffer_size,
                       state_buffer_size,
-                      write_peer_info_file,
                       remap_sigusr1,
                       flags);
 
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 44a5d964..f46274e6 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -229,7 +229,6 @@ struct man_settings {
     int log_history_cache;
     int echo_buffer_size;
     int state_buffer_size;
-    char *write_peer_info_file;
     int client_uid;
     int client_gid;
 
@@ -351,7 +350,6 @@ bool management_open(struct management *man,
                      const int log_history_cache,
                      const int echo_buffer_size,
                      const int state_buffer_size,
-                     const char *write_peer_info_file,
                      const int remap_sigusr1,
                      const unsigned int flags);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 233c02e0..e9dd6b2c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1893,7 +1893,6 @@ show_settings(const struct options *o)
     SHOW_STR(management_user_pass);
     SHOW_INT(management_log_history_cache);
     SHOW_INT(management_echo_buffer_size);
-    SHOW_STR(management_write_peer_info_file);
     SHOW_STR(management_client_user);
     SHOW_STR(management_client_group);
     SHOW_INT(management_flags);
@@ -2380,7 +2379,6 @@ options_postprocess_verify_ce(const struct options *options,
 #ifdef ENABLE_MANAGEMENT
     if (!options->management_addr
         && (options->management_flags
-            || options->management_write_peer_info_file
             || options->management_log_history_cache != defaults.management_log_history_cache))
     {
         msg(M_USAGE, "--management is not specified, however one or more options which modify the behavior of --management were specified");
@@ -5718,11 +5716,10 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->management_flags |= MF_UP_DOWN;
     }
-    else if (streq(p[0], "management-client") && !p[2])
+    else if (streq(p[0], "management-client") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->management_flags |= MF_CONNECT_AS_CLIENT;
-        options->management_write_peer_info_file = p[1];
     }
 #ifdef ENABLE_MANAGEMENT
     else if (streq(p[0], "management-external-key"))
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f7e3f265..1a9d9291 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -421,7 +421,6 @@ struct options
     int management_log_history_cache;
     int management_echo_buffer_size;
     int management_state_buffer_size;
-    const char *management_write_peer_info_file;
 
     const char *management_client_user;
     const char *management_client_group;
-- 
2.30.2


