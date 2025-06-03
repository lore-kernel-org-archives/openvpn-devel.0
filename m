From: Gert Doering <gert@...1296...>
Date: Tue,  3 Jun 2025 18:30:34 +0200
Message-ID: <20250603163040.31169-1-gert@...1296...>
In-Reply-To: <gerrit.1748255754000.I83831060fdf5588a0ada8d6abbedc7ce3ded4182@...2715...>
References: <gerrit.1748255754000.I83831060fdf5588a0ada8d6abbedc7ce3ded4182@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix various badly placed comments in
 preparation for reformat
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

From: Frank Lichtenheld <frank@...2641...>

Change-Id: I83831060fdf5588a0ada8d6abbedc7ce3ded4182
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1030
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index b2a5bf5..4b83eeb 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -910,7 +910,8 @@
     {
         return true;
     }
-    if ((flags & CC_PRINT) && (c >= 32 && c != 127)) /* allow ascii non-control and UTF-8, consider DEL to be a control */
+    /* allow ascii non-control and UTF-8, consider DEL to be a control */
+    if ((flags & CC_PRINT) && (c >= 32 && c != 127))
     {
         return true;
     }
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 7f47319..6ab06bb 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -247,7 +247,8 @@
         case TA_TUN_WRITE:
             looking_for = TUN_WRITE;
             tun_input_pending = NULL;
-            c->c2.timeval.tv_sec = 1; /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */
+            /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */
+            c->c2.timeval.tv_sec = 1;
             perf_push(PERF_PROC_OUT_TUN_MTCP);
             io_wait(c, IOW_TO_TUN);
             perf_pop();
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index f06d6df..d9aca1e 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -302,7 +302,7 @@
                      int metric);
 
 /**
- * Delete a route for an IPv4 address/network
+ * Delete a route for an IPv6 address/network
  *
  * @param ctx       the implementation specific context
  * @param dst       the destination of the route
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bcc18a5..4528edd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8398,9 +8398,10 @@
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         setenv_foreign_option(options, (const char **)p, 3, es);
     }
-    else if (streq(p[0], "route-method") && p[1] && !p[2]) /* ignore when pushed to non-Windows OS */
+    else if (streq(p[0], "route-method") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);
+        /* ignore when pushed to non-Windows OS */
     }
 #endif /* ifdef _WIN32 */
 #if PASSTOS_CAPABILITY
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index d77c99e..7a362e0 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -44,8 +44,10 @@
 void
 update_now(const time_t system_time)
 {
-    const int forward_threshold = 86400; /* threshold at which to dampen forward jumps */
-    const int backward_trigger  = 10;  /* backward jump must be >= this many seconds before we adjust */
+    /* threshold at which to dampen forward jumps */
+    const int forward_threshold = 86400;
+    /* backward jump must be >= this many seconds before we adjust */
+    const int backward_trigger = 10;
     time_t real_time = system_time + now_adj;
 
     if (real_time > now)
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 9543732..04aa5c6 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -246,7 +246,8 @@
 static inline bool
 tv_within_sigma(const struct timeval *t1, const struct timeval *t2, unsigned int sigma)
 {
-    const int delta = tv_subtract(t1, t2, TV_WITHIN_SIGMA_MAX_SEC); /* sigma should be less than 10 minutes */
+    /* sigma should be less than 10 minutes */
+    const int delta = tv_subtract(t1, t2, TV_WITHIN_SIGMA_MAX_SEC);
     return -(int)sigma <= delta && delta <= (int)sigma;
 }
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index de1876a..379a31a 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -212,7 +212,8 @@
 
 #ifdef _WIN32
     HANDLE hand;
-    OVERLAPPED dco_new_peer_ov; /* used for async NEW_PEER dco call, which might wait for TCP connect */
+    /* used for async NEW_PEER dco call, which might wait for TCP connect */
+    OVERLAPPED dco_new_peer_ov;
     struct overlapped_io reads;
     struct overlapped_io writes;
     struct rw_handle rw_handle;

