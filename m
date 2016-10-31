From: David Sommerseth <davids@...515...>
Date: Mon, 31 Oct 2016 13:51:57 +0100
Message-Id: <1477918318-18561-2-git-send-email-davids@...515...>
In-Reply-To: <1477918318-18561-1-git-send-email-davids@...515...>
References: <1477918318-18561-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 1/2] Refactor to provide struct context
	object inside key_method_2_read()
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

This refactors the call chain of  tls_multi_process(), tls_process()
and key_method_2_read() so the the latter function have access
to the struct context object.

This change is needed for the following patch where verify_user_pass()
will need to call send_auth_failed(), which depends on direct access
to the the context object.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/forward.c |  2 +-
 src/openvpn/ssl.c     | 28 ++++++++++++++++------------
 src/openvpn/ssl.h     |  6 +-----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index b3077ed..7dafd53 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -96,7 +96,7 @@ check_tls_dowork (struct context *c)
 
   if (interval_test (&c->c2.tmp_int))
     {
-      const int tmp_status = tls_multi_process
+      const int tmp_status = tls_multi_process(c, &wakeup);
 	(c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
 	 get_link_socket_info (c), &wakeup);
       if (tmp_status == TLSMP_ACTIVE)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4a0cd6f..61c8aa0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -58,6 +58,8 @@
 #include "pkcs11.h"
 #include "route.h"
 
+#include "forward.h"
+#include "forward-inline.h"
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_backend.h"
@@ -2191,8 +2193,9 @@ key_method_1_read (struct buffer *buf, struct tls_session *session)
 }
 
 static bool
-key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
+key_method_2_read (struct buffer *buf, struct context *c, struct tls_session *session)
 {
+  struct tls_multi *multi = c->c2.tls_multi;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
 
   int key_method_flags;
@@ -2382,11 +2385,10 @@ auth_deferred_expire_window (const struct tls_options *o)
  * want to send to our peer.
  */
 static bool
-tls_process (struct tls_multi *multi,
+tls_process (struct context *c,
 	     struct tls_session *session,
 	     struct buffer *to_link,
 	     struct link_socket_actual **to_link_addr,
-	     struct link_socket_info *to_link_socket_info,
 	     interval_t *wakeup)
 {
   struct gc_arena gc = gc_new ();
@@ -2395,6 +2397,8 @@ tls_process (struct tls_multi *multi,
   bool active = false;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
   struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
+  struct tls_multi *multi = c->c2.tls_multi;
+  struct link_socket_info *to_link_socket_info = get_link_socket_info (c);
 
   /* Make sure we were initialized and that we're not in an error state */
   ASSERT (ks->state != S_UNDEF);
@@ -2425,6 +2429,7 @@ tls_process (struct tls_multi *multi,
 	msg (D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
   }
 
+
   do
     {
       update_time ();
@@ -2654,7 +2659,7 @@ tls_process (struct tls_multi *multi,
 	    }
 	  else if (session->opt->key_method == 2)
 	    {
-	      if (!key_method_2_read (buf, multi, session))
+	      if (!key_method_2_read (buf, c, session))
 		goto error;
 	    }
 	  else
@@ -2775,11 +2780,7 @@ error:
  */
 
 int
-tls_multi_process (struct tls_multi *multi,
-		   struct buffer *to_link,
-		   struct link_socket_actual **to_link_addr,
-		   struct link_socket_info *to_link_socket_info,
-		   interval_t *wakeup)
+tls_multi_process (struct context *c, interval_t *wakeup)
 {
   struct gc_arena gc = gc_new ();
   int i;
@@ -2787,6 +2788,8 @@ tls_multi_process (struct tls_multi *multi,
   bool error = false;
   int tas;
 
+  ASSERT(c != NULL);
+
   perf_push (PERF_TLS_MULTI_PROCESS);
 
   tls_clear_error ();
@@ -2795,6 +2798,8 @@ tls_multi_process (struct tls_multi *multi,
    * Process each session object having state of S_INITIAL or greater,
    * and which has a defined remote IP addr.
    */
+  struct tls_multi *multi = c->c2.tls_multi;
+  struct link_socket_info *to_link_socket_info = get_link_socket_info (c);
 
   for (i = 0; i < TM_SIZE; ++i)
     {
@@ -2821,8 +2826,7 @@ tls_multi_process (struct tls_multi *multi,
 
 	  update_time ();
 
-	  if (tls_process (multi, session, to_link, &tla,
-			   to_link_socket_info, wakeup))
+	  if (tls_process (c, session, &c->c2.to_link, &tla, wakeup))
 	    active = TLSMP_ACTIVE;
 
 	  /*
@@ -2833,7 +2837,7 @@ tls_multi_process (struct tls_multi *multi,
 	  if (tla)
 	    {
 	      multi->to_link_addr = *tla;
-	      *to_link_addr = &multi->to_link_addr;
+	      c->c2.to_link_addr = &multi->to_link_addr;
 	    }
 
 	  /*
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e6963a4..3403315 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -244,11 +244,7 @@ void tls_multi_free (struct tls_multi *multi, bool clear);
  * Basically decides if we should call tls_process for
  * the active or untrusted sessions.
  */
-int tls_multi_process (struct tls_multi *multi,
-		       struct buffer *to_link,
-		       struct link_socket_actual **to_link_addr,
-		       struct link_socket_info *to_link_socket_info,
-		       interval_t *wakeup);
+int tls_multi_process (struct context *c, interval_t *wakeup);
 
 
 /**************************************************************************/
-- 
1.8.3.1


