From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:42 +0300
Message-Id: <1336850389-23719-10-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 09/16] cleanup: syshead: rename
	S_ERROR->S_ERRORS to avoid conflict with stropts.h
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/ssl.c        |   16 ++++++++--------
 src/openvpn/ssl_common.h |    2 +-
 src/openvpn/syshead.h    |    1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 19512c0..3178ff4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -429,8 +429,8 @@ state_name (int state)
       return "S_ACTIVE";
     case S_NORMAL_OP:
       return "S_NORMAL_OP";
-    case S_ERROR:
-      return "S_ERROR";
+    case S_ERRORS:
+      return "S_ERRORS";
     default:
       return "S_???";
     }
@@ -858,7 +858,7 @@ lame_duck_must_die (const struct tls_session* session, interval_t *wakeup)
       else
 	return true;
     }
-  else if (lame->state == S_ERROR)
+  else if (lame->state == S_ERRORS)
     return true;
   else
     return false;
@@ -2020,7 +2020,7 @@ tls_process (struct tls_multi *multi,
 
   /* Make sure we were initialized and that we're not in an error state */
   ASSERT (ks->state != S_UNDEF);
-  ASSERT (ks->state != S_ERROR);
+  ASSERT (ks->state != S_ERRORS);
   ASSERT (session_id_defined (&session->session_id));
 
   /* Should we trigger a soft reset? -- new key, keeps old key for a while */
@@ -2386,7 +2386,7 @@ tls_process (struct tls_multi *multi,
 
 error:
   tls_clear_error();
-  ks->state = S_ERROR;
+  ks->state = S_ERRORS;
   msg (D_TLS_ERRORS, "TLS Error: TLS handshake failed");
   INCR_ERROR;
   gc_free (&gc);
@@ -2468,7 +2468,7 @@ tls_multi_process (struct tls_multi *multi,
 	   * (2) Reinitialize the session.
 	   * (3) Increment soft error count
 	   */
-	  if (ks->state == S_ERROR)
+	  if (ks->state == S_ERRORS)
 	    {
 	      ++multi->n_soft_errors;
 
@@ -2513,7 +2513,7 @@ tls_multi_process (struct tls_multi *multi,
   }
 
   /*
-   * A hard error means that TM_ACTIVE hit an S_ERROR state and that no
+   * A hard error means that TM_ACTIVE hit an S_ERRORS state and that no
    * other key state objects are S_ACTIVE or higher.
    */
   if (error)
@@ -2921,7 +2921,7 @@ tls_pre_decrypt (struct tls_multi *multi,
 
 	    /* Make sure we were initialized and that we're not in an error state */
 	    ASSERT (ks->state != S_UNDEF);
-	    ASSERT (ks->state != S_ERROR);
+	    ASSERT (ks->state != S_ERRORS);
 	    ASSERT (session_id_defined (&session->session_id));
 
 	    /* Let our caller know we processed a control channel packet */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f3f43be..6cf8552 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -75,7 +75,7 @@
  *
  * @{
  */
-#define S_ERROR          -1     /**< Error state.  */
+#define S_ERRORS         -1     /**< Error state.  */
 #define S_UNDEF           0     /**< Undefined state, used after a \c
                                  *   key_state is cleaned up. */
 #define S_INITIAL         1     /**< Initial \c key_state state after
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index db39625..d095799 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -221,7 +221,6 @@
 
 #ifdef HAVE_STROPTS_H
 #include <stropts.h>
-#undef S_ERROR
 #endif
 
 #ifdef HAVE_NET_IF_TUN_H
-- 
1.7.3.4


