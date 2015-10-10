From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 10 Oct 2015 19:04:25 +0300
Message-Id: <1444493065-13506-1-git-send-email-lstipakov@...277...>
In-Reply-To: <561910F6.6070504@...1114...>
References: <561910F6.6070504@...1114...>
Subject: [Openvpn-devel] [PATCH v3] Send push reply right after async auth
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

v3:
* better comments
* better variable naming
* include sys/inotify.h if HAVE_SYS_INOTIFY_H is defined

v2:
More careful inotify_watchers handling
* Ensure that same multi_instance is added only once
* Ensure that multi_instance is always removed

v1:
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

Add doxygen comment
---
 configure.ac          |  15 +++++
 src/openvpn/forward.c |   8 +++
 src/openvpn/mtcp.c    |  28 +++++++++
 src/openvpn/mudp.c    |  27 +++++++++
 src/openvpn/multi.c   | 155 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/multi.h   |  21 +++++++
 src/openvpn/openvpn.h |  10 ++++
 src/openvpn/push.c    |  69 +++++++++++++---------
 src/openvpn/push.h    |   2 +
 9 files changed, 304 insertions(+), 31 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2e651d8..32620c6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -277,6 +277,13 @@ AC_ARG_ENABLE(
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
@@ -1201,6 +1208,14 @@ if test "${enable_plugin_auth_pam}" = "yes"; then
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
index 7a5d383..f89c5bc 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1371,6 +1371,9 @@ io_wait_dowork (struct context *c, const unsigned int flags)
 #ifdef ENABLE_MANAGEMENT
   static int management_shift = 6; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
 #endif
+#ifdef ENABLE_ASYNC_PUSH
+  static int file_shift = 8;       /* listening inotify events */
+#endif
 
   /*
    * Decide what kind of events we want to wait for.
@@ -1465,6 +1468,11 @@ io_wait_dowork (struct context *c, const unsigned int flags)
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
index 57118f8..3aed3a0 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -38,6 +38,10 @@
 
 #include "memdbg.h"
 
+#ifdef HAVE_SYS_INOTIFY_H
+#include <sys/inotify.h>
+#endif
+
 /*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
@@ -177,6 +181,10 @@ multi_process_io_udp (struct multi_context *m)
     strcat (buf, "TR/");
   else if (status & TUN_WRITE)
     strcat (buf, "TW/");
+#ifdef ENABLE_ASYNC_PUSH
+  else if (status & FILE_CLOSED)
+    strcat (buf, "FC/");
+#endif
   printf ("IO %s\n", buf);
 #endif
 
@@ -214,6 +222,13 @@ multi_process_io_udp (struct multi_context *m)
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
@@ -276,6 +291,14 @@ tunnel_server_udp_single_threaded (struct context *top)
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
@@ -304,6 +327,10 @@ tunnel_server_udp_single_threaded (struct context *top)
       perf_pop ();
     }
 
+#ifdef ENABLE_ASYNC_PUSH
+  close(top->c2.inotify_fd);
+#endif
+
   /* shut down management interface */
   uninit_management_callback_multi (&multi);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 902c4dc..578c0db 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -28,6 +28,11 @@
 #include "config-msvc.h"
 #endif
 
+#ifdef HAVE_SYS_INOTIFY_H
+#include <sys/inotify.h>
+#define INOTIFY_EVENT_BUFFER_SIZE 16384
+#endif
+
 #include "syshead.h"
 
 #if P2MP_SERVER
@@ -243,6 +248,23 @@ cid_compare_function (const void *key1, const void *key2)
 
 #endif
 
+#ifdef ENABLE_ASYNC_PUSH
+static uint32_t
+/*
+ * inotify watcher descriptors are used as hash value
+ */
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
@@ -304,6 +326,17 @@ multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int threa
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
@@ -562,6 +595,14 @@ multi_close_instance (struct multi_context *m,
 	}
 #endif
 
+#ifdef ENABLE_ASYNC_PUSH
+      if (mi->inotify_watch != -1)
+	{
+	  hash_remove(m->inotify_watchers, (void*) (unsigned long)mi->inotify_watch);
+	  mi->inotify_watch = -1;
+	}
+#endif
+
       m->instances[mi->context.c2.tls_multi->peer_id] = NULL;
 
       schedule_remove_entry (m->schedule, (struct schedule_entry *) mi);
@@ -642,6 +683,11 @@ multi_uninit (struct multi_context *m)
 
 	  free(m->instances);
 
+#ifdef ENABLE_ASYNC_PUSH
+	  hash_free (m->inotify_watchers);
+	  m->inotify_watchers = NULL;
+#endif
+
 	  schedule_free (m->schedule);
 	  mbuf_free (m->mbuf);
 	  ifconfig_pool_free (m->ifconfig_pool);
@@ -718,6 +764,11 @@ multi_create_instance (struct multi_context *m, const struct mroute_addr *real)
 
   mi->context.c2.push_reply_deferred = true;
 
+#ifdef ENABLE_ASYNC_PUSH
+  mi->context.c2.push_request_received = false;
+  mi->inotify_watch = -1;
+#endif
+
   if (!multi_process_post (m, mi, MPP_PRE_SELECT))
     {
       msg (D_MULTI_ERRORS, "MULTI: signal occurred during client instance initialization");
@@ -923,6 +974,13 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
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
@@ -1877,6 +1935,14 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
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
@@ -1906,6 +1972,58 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
   mi->context.c2.push_reply_deferred = false;
 }
 
+#ifdef ENABLE_ASYNC_PUSH
+/*
+ * Called when inotify event is fired, which happens when acf file is closed or deleted.
+ * Continues authentication and sends push_reply.
+ */
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
+	      mi->inotify_watch = -1;
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
@@ -2066,19 +2184,50 @@ multi_process_post (struct multi_context *m, struct multi_instance *mi, const un
 
   if (!IS_SIG (&mi->context) && ((flags & MPP_PRE_SELECT) || ((flags & MPP_CONDITIONAL_PRE_SELECT) && !ANY_OUT (&mi->context))))
     {
+#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+      bool was_authenticated = false;
+      struct key_state *ks = NULL;
+      if (mi->context.c2.tls_multi)
+        {
+          ks = &mi->context.c2.tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
+          was_authenticated = ks->authenticated;
+        }
+#endif
+
       /* figure timeouts and fetch possible outgoing
 	 to_link packets (such as ping or TLS control) */
       pre_select (&mi->context);
 
-      if (!IS_SIG (&mi->context))
+#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+      if (ks && ks->auth_control_file && ks->auth_deferred && !was_authenticated)
 	{
-	  /* tell scheduler to wake us up at some point in the future */
-	  multi_schedule_context_wakeup(m, mi);
+	  /* watch acf file */
+	  long watch_descriptor = inotify_add_watch(m->top.c2.inotify_fd, ks->auth_control_file, IN_CLOSE_WRITE | IN_ONESHOT);
+	  if (watch_descriptor >= 0)
+	    {
+	      if (mi->inotify_watch != -1)
+		{
+		  hash_remove(m->inotify_watchers, (void*) (unsigned long)mi->inotify_watch);
+	      	}
+	      hash_add (m->inotify_watchers, (const uintptr_t*)watch_descriptor, mi, true);
+	      mi->inotify_watch = watch_descriptor;
+	    }
+	  else
+	    {
+	      msg(M_NONFATAL, "MULTI: inotify_add_watch error: %s", strerror(errno));
+	    }
+	}
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
index 32b89d2..69ed85e 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -105,6 +105,10 @@ struct multi_instance {
 
   struct context context;       /**< The context structure storing state
                                  *   for this VPN tunnel. */
+
+#ifdef ENABLE_ASYNC_PUSH
+  int inotify_watch; /* watch descriptor for acf */
+#endif
 };
 
 
@@ -172,6 +176,11 @@ struct multi_context {
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
@@ -327,6 +336,18 @@ void multi_close_instance_on_signal (struct multi_context *m, struct multi_insta
 void init_management_callback_multi (struct multi_context *m);
 void uninit_management_callback_multi (struct multi_context *m);
 
+
+#ifdef ENABLE_ASYNC_PUSH
+/**
+ * Called when inotify event is fired, which happens when acf file is closed or deleted.
+ * Continues authentication and sends push_repl
+ *
+ * @param m multi_context
+ * @param mpp_flags
+ */
+void multi_process_file_closed (struct multi_context *m, const unsigned int mpp_flags);
+#endif
+
 /*
  * Return true if our output queue is not full
  */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index ef22269..4fab00b 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -241,6 +241,9 @@ struct context_2
 #  define MANAGEMENT_READ  (1<<6)
 #  define MANAGEMENT_WRITE (1<<7)
 # endif
+#ifdef ENABLE_ASYNC_PUSH
+# define FILE_CLOSED       (1<<8)
+#endif
 
   unsigned int event_set_status;
 
@@ -436,6 +439,9 @@ struct context_2
 #if P2MP_SERVER
   /* --ifconfig endpoints to be pushed to client */
   bool push_reply_deferred;
+#ifdef ENABLE_ASYNC_PUSH
+  bool push_request_received;
+#endif
   bool push_ifconfig_defined;
   time_t sent_push_reply_expiry;
   in_addr_t push_ifconfig_local;
@@ -479,6 +485,10 @@ struct context_2
 #ifdef MANAGEMENT_DEF_AUTH
   struct man_def_auth_context mda_context;
 #endif
+
+#ifdef ENABLE_ASYNC_PUSH
+  int inotify_fd; /* descriptor for monitoring file changes */
+#endif
 };
 
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index b9d0c4c..704818d 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -411,6 +411,46 @@ push_reset (struct options *o)
 #endif
 
 int
+process_incoming_push_request (struct context *c)
+{
+  int ret = PUSH_MSG_ERROR;
+
+#ifdef ENABLE_ASYNC_PUSH
+  c->c2.push_request_received = true;
+#endif
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
@@ -423,34 +463,7 @@ process_incoming_push_msg (struct context *c,
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


