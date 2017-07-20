From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 20 Jul 2017 18:00:35 +0200
Message-ID: <1500566435-29920-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Move openvpn_sleep() to manage.c
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

openvpn_sleep() is basically "service the management interface for x
seconds, then return".  Therefore, manage.c is a more suitable location
than the random collection of unrelated stuff called misc.c.

(I think we should find a better place for everything currently in misc.c,
and get rid of it all together.  This patch is part of that effort.)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/forward.c |  2 +-
 src/openvpn/init.c    |  4 ++--
 src/openvpn/manage.c  | 20 ++++++++++++++++++--
 src/openvpn/manage.h  |  7 +++++++
 src/openvpn/misc.c    | 13 -------------
 src/openvpn/misc.h    |  6 ------
 src/openvpn/socket.c  |  8 ++++----
 7 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 371ddca..c45d125 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -756,7 +756,7 @@ read_incoming_link(struct context *c)
                 if (event_timeout_defined(&c->c2.explicit_exit_notification_interval))
                 {
                     msg(D_STREAM_ERRORS, "Connection reset during exit notification period, ignoring [%d]", status);
-                    openvpn_sleep(1);
+                    management_sleep(1);
                 }
                 else
 #endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a54307a..bc3b81e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1969,7 +1969,7 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
                 /* if so, close tun, delete routes, then reinitialize tun and add routes */
                 msg(M_INFO, "NOTE: Pulled options changed on restart, will need to close and reopen TUN/TAP device.");
                 do_close_tun(c, true);
-                openvpn_sleep(1);
+                management_sleep(1);
                 c->c2.did_open_tun = do_open_tun(c);
                 update_time();
             }
@@ -2263,7 +2263,7 @@ socket_restart_pause(struct context *c)
     if (sec)
     {
         msg(D_RESTART, "Restart pause, %d second(s)", sec);
-        openvpn_sleep(sec);
+        management_sleep(sec);
     }
 }
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2b85d25..13be6f6 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3997,9 +3997,25 @@ log_history_ref(const struct log_history *h, const int index)
     }
 }
 
+void
+management_sleep(const int n)
+{
+    if (management)
+    {
+        management_event_loop_n_seconds(management, n);
+    }
+    else
+    {
+        sleep(n);
+    }
+}
+
 #else  /* ifdef ENABLE_MANAGEMENT */
-static void
-dummy(void)
+
+void
+management_sleep(const int n)
 {
+    sleep(n);
 }
+
 #endif /* ENABLE_MANAGEMENT */
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 542cc07..676be64 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -605,4 +605,11 @@ management_bytes_server(struct management *man,
 #endif /* MANAGEMENT_DEF_AUTH */
 
 #endif /* ifdef ENABLE_MANAGEMENT */
+
+/**
+ * A sleep function that services the management layer for n seconds rather
+ * than doing nothing.
+ */
+void management_sleep(const int n);
+
 #endif /* ifndef MANAGE_H */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index f6d6c6a..ae96aa6 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1615,19 +1615,6 @@ make_extended_arg_array(char **p, struct gc_arena *gc)
     }
 }
 
-void
-openvpn_sleep(const int n)
-{
-#ifdef ENABLE_MANAGEMENT
-    if (management)
-    {
-        management_event_loop_n_seconds(management, n);
-        return;
-    }
-#endif
-    sleep(n);
-}
-
 /*
  * Remove security-sensitive strings from control message
  * so that they will not be output to log file.
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index bc267d7..32b64e8 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -292,12 +292,6 @@ bool env_safe_to_print(const char *str);
 /* returns true if environmental variable may be passed to an external program */
 bool env_allowed(const char *str);
 
-/*
- * A sleep function that services the management layer for n
- * seconds rather than doing nothing.
- */
-void openvpn_sleep(const int n);
-
 void configure_path(void);
 
 const char *sanitize_control_message(const char *str, struct gc_arena *gc);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 846df04..6e01fe1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -496,7 +496,7 @@ openvpn_getaddrinfo(unsigned int flags,
                 goto done;
             }
 
-            openvpn_sleep(fail_wait_interval);
+            management_sleep(fail_wait_interval);
         }
 
         ASSERT(res);
@@ -1193,7 +1193,7 @@ socket_listen_accept(socket_descriptor_t sd,
 
         if (status <= 0)
         {
-            openvpn_sleep(1);
+            management_sleep(1);
             continue;
         }
 
@@ -1228,7 +1228,7 @@ socket_listen_accept(socket_descriptor_t sd,
                 break;
             }
         }
-        openvpn_sleep(1);
+        management_sleep(1);
     }
 
     if (!nowait && openvpn_close_socket(sd))
@@ -1374,7 +1374,7 @@ openvpn_connect(socket_descriptor_t sd,
 #endif
                     break;
                 }
-                openvpn_sleep(1);
+                management_sleep(1);
                 continue;
             }
 
-- 
2.7.4


