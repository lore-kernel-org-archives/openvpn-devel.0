From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 28 Nov 2014 17:56:51 +0200
Message-Id: <1417190211-27941-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Send push reply right after async auth
	complete
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This feature speeds up connection establishment in cases when async
authentication result is not ready when first push request arrives. At
the moment server sends push reply only when it receives next push
request, which comes 5 seconds later.

Implementation overview.

Add new configure option ENABLE_ASYNC_PUSH, which can be enabled if
system supports inotify.

Add inotify descriptor to an event loop. Add inotify watch for a
authentication control file. Store mapping between watch descriptor and
multi_instance in a dictionary. When file is closed, inotify fires an
event and we continue with connection establishment - call client-
connect etc and send push reply.

Inotify watch descriptor got automatically deleted after file is closed
or when file is removed. We catch that event and remove it from the
dictionary.

Feature is easily tested with sample "defer" plugin and following settings:

auth-user-pass-optional
setenv test_deferred_auth 3
plugin simple.so

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 configure.ac          |  15 ++++++
 src/openvpn/forward.c |   8 +++
 src/openvpn/mtcp.c    |  28 +++++++++++
 src/openvpn/mudp.c    |  27 ++++++++++
 src/openvpn/multi.c   | 135 ++++++++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/multi.h   |  10 ++++
 src/openvpn/openvpn.h |   9 ++++
 src/openvpn/push.c    |  67 ++++++++++++++-----------
 src/openvpn/push.h    |   2 +
 9 files changed, 270 insertions(+), 31 deletions(-)

diff --git a/configure.ac b/configure.ac
index 608ab6d..fc28779 100644
--- a/configure.ac
+++ b/configure.ac
@@ -264,6 +264,13 @@ AC_ARG_ENABLE(
 	[enable_systemd="no"]
 )
 
+AC_ARG_ENABLE(
+	[async-push],
+	[AS_HELP_STRING([--enable-async-push], [enable async-push support @<:@default=no@:>@])],
+	[enable_async_push="yes"],
+	[enable_async_push="no"]
+)
+
 AC_ARG_WITH(
 	[special-build],
 	[AS_HELP_STRING([--with-special-build=STRING], [specify special build string])],
@@ -1168,6 +1175,14 @@ if test "${enable_plugin_auth_pam}" = "yes"; then
 	fi
 fi
 
+if test "${enable_async_push}" = "yes"; then
+	AC_CHECK_HEADERS(
+		[sys/inotify.h],
+		AC_DEFINE([ENABLE_ASYNC_PUSH], [1], [Enable async push]),
+		AC_MSG_ERROR([inotify.h not found.])
+	)
+fi
+
 CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
 AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"], [Configuration settings])
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 91c4711..417e7cb 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1378,6 +1378,9 @@ io_wait_dowork (struct context *c, const unsigned int flags)
 #ifdef ENABLE_MANAGEMENT
   static int management_shift = 6; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
 #endif
+#ifdef ENABLE_ASYNC_PUSH
+  static int file_shift = 8;
+#endif
 
   /*
    * Decide what kind of events we want to wait for.
@@ -1472,6 +1475,11 @@ io_wait_dowork (struct context *c, const unsigned int flags)
     management_socket_set (management, c->c2.event_set, (void*)&management_shift, NULL);
 #endif
 
+#ifdef ENABLE_ASYNC_PUSH
+  /* arm inotify watcher */
+  event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&file_shift);
+#endif
+
   /*
    * Possible scenarios:
    *  (1) tcp/udp port has data available to read
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index dc15f09..b27c5eb 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -62,6 +62,10 @@
 # define MTCP_MANAGEMENT ((void*)4)
 #endif
 
+#ifdef ENABLE_ASYNC_PUSH
+#define MTCP_FILE_CLOSE_WRITE ((void*)5)
+#endif
+
 #define MTCP_N           ((void*)16) /* upper bound on MTCP_x */
 
 struct ta_iow_flags
@@ -245,6 +249,12 @@ multi_tcp_wait (const struct context *c,
   if (management)
     management_socket_set (management, mtcp->es, MTCP_MANAGEMENT, &mtcp->management_persist_flags);
 #endif
+
+#ifdef ENABLE_ASYNC_PUSH
+  /* arm inotify watcher */
+  event_ctl (mtcp->es, c->c2.inotify_fd, EVENT_READ, MTCP_FILE_CLOSE_WRITE);
+#endif
+
   status = event_wait (mtcp->es, &c->c2.timeval, mtcp->esr, mtcp->maxevents);
   update_time ();
   mtcp->n_esr = 0;
@@ -636,6 +646,12 @@ multi_tcp_process_io (struct multi_context *m)
 	    {
 	      get_signal (&m->top.sig->signal_received);
 	    }
+#ifdef ENABLE_ASYNC_PUSH
+	  else if (e->arg == MTCP_FILE_CLOSE_WRITE)
+	    {
+	      multi_process_file_closed (m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);
+	    }
+#endif
 	}
       if (IS_SIG (&m->top))
 	break;
@@ -684,6 +700,14 @@ tunnel_server_tcp (struct context *top)
   /* finished with initialization */
   initialization_sequence_completed (top, ISC_SERVER); /* --mode server --proto tcp-server */
 
+#ifdef ENABLE_ASYNC_PUSH
+  multi.top.c2.inotify_fd = inotify_init();
+  if (multi.top.c2.inotify_fd < 0)
+    {
+      msg (D_MULTI_ERRORS, "MULTI: inotify_init error: %s", strerror(errno));
+    }
+#endif
+
   /* per-packet event loop */
   while (true)
     {
@@ -712,6 +736,10 @@ tunnel_server_tcp (struct context *top)
       perf_pop ();
     }
 
+#ifdef ENABLE_ASYNC_PUSH
+  close(top->c2.inotify_fd);
+#endif
+
   /* shut down management interface */
   uninit_management_callback_multi (&multi);
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 853c08c..82d6b93 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -38,6 +38,10 @@
 
 #include "memdbg.h"
 
+#ifdef ENABLE_ASYNC_PUSH
+#include <sys/inotify.h>
+#endif
+
 /*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
@@ -172,6 +176,10 @@ multi_process_io_udp (struct multi_context *m)
     strcat (buf, "TR/");
   else if (status & TUN_WRITE)
     strcat (buf, "TW/");
+#ifdef ENABLE_ASYNC_PUSH
+  else if (status & FILE_CLOSED)
+    strcat (buf, "FC/");
+#endif
   printf ("IO %s\n", buf);
 #endif
 
@@ -209,6 +217,13 @@ multi_process_io_udp (struct multi_context *m)
       if (!IS_SIG (&m->top))
 	multi_process_incoming_tun (m, mpp_flags);
     }
+#ifdef ENABLE_ASYNC_PUSH
+  /* INOTIFY callback */
+  else if (status & FILE_CLOSED)
+    {
+      multi_process_file_closed(m, mpp_flags);
+    }
+#endif
 }
 
 /*
@@ -271,6 +286,14 @@ tunnel_server_udp_single_threaded (struct context *top)
   /* finished with initialization */
   initialization_sequence_completed (top, ISC_SERVER); /* --mode server --proto udp */
 
+#ifdef ENABLE_ASYNC_PUSH
+  multi.top.c2.inotify_fd = inotify_init();
+  if (multi.top.c2.inotify_fd < 0)
+    {
+      msg (D_MULTI_ERRORS, "MULTI: inotify_init error: %s", strerror(errno));
+    }
+#endif
+
   /* per-packet event loop */
   while (true)
     {
@@ -299,6 +322,10 @@ tunnel_server_udp_single_threaded (struct context *top)
       perf_pop ();
     }
 
+#ifdef ENABLE_ASYNC_PUSH
+  close(top->c2.inotify_fd);
+#endif
+
   /* shut down management interface */
   uninit_management_callback_multi (&multi);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 538f4f1..a0c030c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -28,6 +28,11 @@
 #include "config-msvc.h"
 #endif
 
+#ifdef ENABLE_ASYNC_PUSH
+#include <sys/inotify.h>
+#define INOTIFY_EVENT_BUFFER_SIZE 16384
+#endif
+
 #include "syshead.h"
 
 #if P2MP_SERVER
@@ -243,6 +248,20 @@ cid_compare_function (const void *key1, const void *key2)
 
 #endif
 
+#ifdef ENABLE_ASYNC_PUSH
+static uint32_t
+int_hash_function (const void *key, uint32_t iv)
+{
+  return (unsigned long)key;
+}
+
+static bool
+int_compare_function (const void *key1, const void *key2)
+{
+  return (unsigned long)key1 == (unsigned long)key2;
+}
+#endif
+
 /*
  * Main initialization function, init multi_context object.
  */
@@ -304,6 +323,17 @@ multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int threa
 			   cid_compare_function);
 #endif
 
+#ifdef ENABLE_ASYNC_PUSH
+  /*
+   * Mapping between inotify watch descriptors and
+   * multi_instances.
+   */
+  m->inotify_watchers = hash_init (t->options.real_hash_size,
+                        get_random(),
+                        int_hash_function,
+                        int_compare_function);
+#endif
+
   /*
    * This is our scheduler, for time-based wakeup
    * events.
@@ -636,6 +666,11 @@ multi_uninit (struct multi_context *m)
 
 	  free(m->instances);
 
+#ifdef ENABLE_ASYNC_PUSH
+	  hash_free (m->inotify_watchers);
+	  m->inotify_watchers = NULL;
+#endif
+
 	  schedule_free (m->schedule);
 	  mbuf_free (m->mbuf);
 	  ifconfig_pool_free (m->ifconfig_pool);
@@ -712,6 +747,8 @@ multi_create_instance (struct multi_context *m, const struct mroute_addr *real)
 
   mi->context.c2.push_reply_deferred = true;
 
+  mi->context.c2.push_request_received = false;
+
   if (!multi_process_post (m, mi, MPP_PRE_SELECT))
     {
       msg (D_MULTI_ERRORS, "MULTI: signal occurred during client instance initialization");
@@ -915,6 +952,13 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
       status_flush (so);
       gc_free (&gc_top);
     }
+
+#ifdef ENABLE_ASYNC_PUSH
+  if (m->inotify_watchers)
+  {
+    msg (D_MULTI_DEBUG, "inotify watchers count: %d\n", hash_n_elements(m->inotify_watchers));
+  }
+#endif
 }
 
 /*
@@ -1871,6 +1915,14 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
 	  /* set context-level authentication flag */
 	  mi->context.c2.context_auth = CAS_SUCCEEDED;
+
+#ifdef ENABLE_ASYNC_PUSH
+	  /* authentication complete, send push reply */
+	  if (mi->context.c2.push_request_received)
+	    {
+	      process_incoming_push_request(&mi->context);
+	    }
+#endif
 	}
       else
 	{
@@ -1900,6 +1952,53 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
   mi->context.c2.push_reply_deferred = false;
 }
 
+#ifdef ENABLE_ASYNC_PUSH
+void
+multi_process_file_closed (struct multi_context *m, const unsigned int mpp_flags)
+{
+  char buffer[INOTIFY_EVENT_BUFFER_SIZE];
+  size_t buffer_i = 0;
+  int r = read (m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);
+
+  while (buffer_i < r)
+    {
+      /* parse inotify events */
+      struct inotify_event *pevent = (struct inotify_event *) &buffer[buffer_i];
+      size_t event_size = sizeof (struct inotify_event) + pevent->len;
+      buffer_i += event_size;
+
+      msg(D_MULTI_DEBUG, "MULTI: modified fd %d, mask %d", pevent->wd, pevent->mask);
+
+      struct multi_instance* mi = hash_lookup(m->inotify_watchers, (void*) (unsigned long) pevent->wd);
+
+      if (pevent->mask & IN_CLOSE_WRITE)
+	{
+	  if (mi)
+	    {
+	      /* continue authentication and send push_reply */
+	      multi_process_post (m, mi, mpp_flags);
+	    }
+	  else
+	    {
+	      msg(D_MULTI_ERRORS, "MULTI: multi_instance not found!");
+	    }
+	}
+      else if (pevent->mask & IN_IGNORED)
+	{
+	  /* this event is _always_ fired when watch is removed or file is deleted */
+	  if (mi)
+	    {
+	      hash_remove(m->inotify_watchers, (void*) (unsigned long) pevent->wd);
+	    }
+	}
+      else
+	{
+	  msg(D_MULTI_ERRORS, "MULTI: unknown mask %d", pevent->mask);
+	}
+    }
+}
+#endif
+
 /*
  * Add a mbuf buffer to a particular
  * instance.
@@ -2060,19 +2159,49 @@ multi_process_post (struct multi_context *m, struct multi_instance *mi, const un
 
   if (!IS_SIG (&mi->context) && ((flags & MPP_PRE_SELECT) || ((flags & MPP_CONDITIONAL_PRE_SELECT) && !ANY_OUT (&mi->context))))
     {
+#ifdef ENABLE_ASYNC_PUSH
+#ifdef ENABLE_DEF_AUTH
+      bool was_deferred = false;
+      struct key_state *ks = NULL;
+      if (mi->context.c2.tls_multi)
+        {
+          ks = &mi->context.c2.tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
+          was_deferred = ks->auth_deferred;
+        }
+#endif
+#endif
+
       /* figure timeouts and fetch possible outgoing
 	 to_link packets (such as ping or TLS control) */
       pre_select (&mi->context);
 
-      if (!IS_SIG (&mi->context))
+#ifdef ENABLE_ASYNC_PUSH
+#ifdef ENABLE_DEF_AUTH
+      if (ks && ks->auth_control_file && ks->auth_deferred && !was_deferred)
 	{
-	  /* tell scheduler to wake us up at some point in the future */
-	  multi_schedule_context_wakeup(m, mi);
+	  /* watch acf file */
+	  long wd = inotify_add_watch(m->top.c2.inotify_fd, ks->auth_control_file, IN_CLOSE_WRITE | IN_ONESHOT);
+	  if (wd >= 0)
+	    {
+	      hash_add (m->inotify_watchers, (const uintptr_t*)wd, mi, true);
+	    }
+	  else
+	    {
+	      msg(M_NONFATAL, "MULTI: inotify_add_watch error: %s", strerror(errno));
+	    }
+	}
+#endif
+#endif
 
+      if (!IS_SIG (&mi->context))
+	{
 	  /* connection is "established" when SSL/TLS key negotiation succeeds
 	     and (if specified) auth user/pass succeeds */
 	  if (!mi->connection_established_flag && CONNECTION_ESTABLISHED (&mi->context))
 	    multi_connection_established (m, mi);
+
+	  /* tell scheduler to wake us up at some point in the future */
+	  multi_schedule_context_wakeup(m, mi);
 	}
     }
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index ad7f700..05c3986 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -170,6 +170,11 @@ struct multi_context {
    * Timer object for stale route check
    */
   struct event_timeout stale_routes_check_et;
+
+#ifdef ENABLE_ASYNC_PUSH
+  /* mapping between inotify watch descriptors and multi_instances */
+  struct hash *inotify_watchers;
+#endif
 };
 
 /*
@@ -325,6 +330,11 @@ void multi_close_instance_on_signal (struct multi_context *m, struct multi_insta
 void init_management_callback_multi (struct multi_context *m);
 void uninit_management_callback_multi (struct multi_context *m);
 
+
+#ifdef ENABLE_ASYNC_PUSH
+void multi_process_file_closed (struct multi_context *m, const unsigned int mpp_flags);
+#endif
+
 /*
  * Return true if our output queue is not full
  */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 24df3bb..1c995e3 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -247,6 +247,9 @@ struct context_2
 #  define MANAGEMENT_READ  (1<<6)
 #  define MANAGEMENT_WRITE (1<<7)
 # endif
+#ifdef ENABLE_ASYNC_PUSH
+# define FILE_CLOSED       (1<<8)
+#endif
 
   unsigned int event_set_status;
 
@@ -446,6 +449,7 @@ struct context_2
 #if P2MP_SERVER
   /* --ifconfig endpoints to be pushed to client */
   bool push_reply_deferred;
+  bool push_request_received;
   bool push_ifconfig_defined;
   time_t sent_push_reply_expiry;
   in_addr_t push_ifconfig_local;
@@ -491,6 +495,11 @@ struct context_2
 #ifdef MANAGEMENT_DEF_AUTH
   struct man_def_auth_context mda_context;
 #endif
+
+#ifdef ENABLE_ASYNC_PUSH
+  /* descriptor for monitoring file changes */
+  int inotify_fd;
+#endif
 };
 
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 932df5c..6594c7d 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -413,6 +413,44 @@ push_reset (struct options *o)
 #endif
 
 int
+process_incoming_push_request (struct context *c)
+{
+  int ret = PUSH_MSG_ERROR;
+
+  c->c2.push_request_received = true;
+  if (tls_authentication_status (c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED || c->c2.context_auth == CAS_FAILED)
+    {
+      const char *client_reason = tls_client_reason (c->c2.tls_multi);
+      send_auth_failed (c, client_reason);
+      ret = PUSH_MSG_AUTH_FAILURE;
+    }
+  else if (!c->c2.push_reply_deferred && c->c2.context_auth == CAS_SUCCEEDED)
+    {
+      time_t now;
+
+      openvpn_time (&now);
+      if (c->c2.sent_push_reply_expiry > now)
+	{
+	  ret = PUSH_MSG_ALREADY_REPLIED;
+	}
+      else
+	{
+	  if (send_push_reply (c))
+	    {
+	      ret = PUSH_MSG_REQUEST;
+	      c->c2.sent_push_reply_expiry = now + 30;
+	    }
+	}
+    }
+  else
+    {
+      ret = PUSH_MSG_REQUEST_DEFERRED;
+    }
+
+  return ret;
+}
+
+int
 process_incoming_push_msg (struct context *c,
 			   const struct buffer *buffer,
 			   bool honor_received_options,
@@ -425,34 +463,7 @@ process_incoming_push_msg (struct context *c,
 #if P2MP_SERVER
   if (buf_string_compare_advance (&buf, "PUSH_REQUEST"))
     {
-      if (tls_authentication_status (c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED || c->c2.context_auth == CAS_FAILED)
-	{
-	  const char *client_reason = tls_client_reason (c->c2.tls_multi);
-	  send_auth_failed (c, client_reason);
-	  ret = PUSH_MSG_AUTH_FAILURE;
-	}
-      else if (!c->c2.push_reply_deferred && c->c2.context_auth == CAS_SUCCEEDED)
-	{
-	  time_t now;
-
-	  openvpn_time(&now);
-	  if (c->c2.sent_push_reply_expiry > now)
-	    {
-	      ret = PUSH_MSG_ALREADY_REPLIED;
-	    }
-	  else
-	    {
-	      if (send_push_reply (c))
-		{
-		  ret = PUSH_MSG_REQUEST;
-		  c->c2.sent_push_reply_expiry = now + 30;
-		}
-	    }
-	}
-      else
-	{
-	  ret = PUSH_MSG_REQUEST_DEFERRED;
-	}
+      ret = process_incoming_push_request(c);
     }
   else
 #endif
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 8c3f157..5eca45f 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -40,6 +40,8 @@
 void incoming_push_message (struct context *c,
 			    const struct buffer *buffer);
 
+int process_incoming_push_request (struct context *c);
+
 int process_incoming_push_msg (struct context *c,
 			       const struct buffer *buffer,
 			       bool honor_received_options,
-- 
1.9.1


