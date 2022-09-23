From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Sep 2022 10:58:04 +0200
Message-Id: <20220923085804.3743109-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Document/cleanup event_timeout functions
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

Remove function event_timeout_clear_ret as it is unused.

Cleanup event_timeout_trigger a bit. Do an instant return false if the
timeout is not defined and inline local_now and use
event_timeout_remaining instead of local duplicated code.

Add doxygen comments for all timeout function, especially for the
event_timeout_trigger function that is hard to understand otherwise.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/interval.c | 50 ++++++++++++-----------
 src/openvpn/interval.h | 92 +++++++++++++++++++++++++++++-------------
 src/openvpn/openvpn.h  |  4 +-
 3 files changed, 92 insertions(+), 54 deletions(-)

diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 2f0fc42dd..8f3c1c604 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -41,44 +41,46 @@ interval_init(struct interval *top, int horizon, int refresh)
     top->horizon = horizon;
 }
 
+
 bool
 event_timeout_trigger(struct event_timeout *et,
                       struct timeval *tv,
                       const int et_const_retry)
 {
+    if (!et->defined)
+    {
+        return false;
+    }
+
     bool ret = false;
-    const time_t local_now = now;
+    time_t wakeup = event_timeout_remaining(et);
 
-    if (et->defined)
+    if (wakeup <= 0)
     {
-        time_t wakeup = et->last - local_now + et->n;
-        if (wakeup <= 0)
-        {
 #if INTERVAL_DEBUG
-            dmsg(D_INTERVAL, "EVENT event_timeout_trigger (%d) etcr=%d", et->n,
-                 et_const_retry);
+        dmsg(D_INTERVAL, "EVENT event_timeout_trigger (%d) etcr=%d", et->n,
+             et_const_retry);
 #endif
-            if (et_const_retry < 0)
-            {
-                et->last = local_now;
-                wakeup = et->n;
-                ret = true;
-            }
-            else
-            {
-                wakeup = et_const_retry;
-            }
+        if (et_const_retry < 0)
+        {
+            et->last = now;
+            wakeup = et->n;
+            ret = true;
         }
-
-        if (tv && wakeup < tv->tv_sec)
+        else
         {
+            wakeup = et_const_retry;
+        }
+    }
+
+    if (tv && wakeup < tv->tv_sec)
+    {
 #if INTERVAL_DEBUG
-            dmsg(D_INTERVAL, "EVENT event_timeout_wakeup (%d/%d) etcr=%d",
-                 (int) wakeup, et->n, et_const_retry);
+        dmsg(D_INTERVAL, "EVENT event_timeout_wakeup (%d/%d) etcr=%d",
+             (int) wakeup, et->n, et_const_retry);
 #endif
-            tv->tv_sec = wakeup;
-            tv->tv_usec = 0;
-        }
+        tv->tv_sec = wakeup;
+        tv->tv_usec = 0;
     }
     return ret;
 }
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index f58bfacf6..f6e40705c 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -135,9 +135,9 @@ interval_action(struct interval *top)
 
 struct event_timeout
 {
-    bool defined;
-    interval_t n;
-    time_t last; /* time of last event */
+    bool defined;       /**< This timeout is active */
+    interval_t n;       /**< periodic interval for periodic timeouts */
+    time_t last;        /**< time of last event */
 };
 
 static inline bool
@@ -145,7 +145,12 @@ event_timeout_defined(const struct event_timeout *et)
 {
     return et->defined;
 }
-
+/**
+ * Clears the timeout and reset all values to 0. Following timer checks will
+ * not trigger.
+ *
+ * @param et    timer struct
+ */
 static inline void
 event_timeout_clear(struct event_timeout *et)
 {
@@ -154,22 +159,30 @@ event_timeout_clear(struct event_timeout *et)
     et->last = 0;
 }
 
-static inline struct event_timeout
-event_timeout_clear_ret(void)
-{
-    struct event_timeout ret;
-    event_timeout_clear(&ret);
-    return ret;
-}
 
+/**
+ * Initialises a timer struct. The timer will become true/trigger after last + n seconds
+ *
+ *
+ * @param et            Timer struct
+ * @param n             Interval of the timer for periodic timer. A negative value for n will be interpreted as 0
+ * @param last          Sets the base time of the timer.
+ */
 static inline void
-event_timeout_init(struct event_timeout *et, interval_t n, const time_t local_now)
+event_timeout_init(struct event_timeout *et, interval_t n, const time_t last)
 {
     et->defined = true;
     et->n = (n >= 0) ? n : 0;
-    et->last = local_now;
+    et->last = last;
 }
 
+/**
+ * Reset a timer.
+ *
+ * Sets the last time the timer has been triggered for the calculation of the
+ * next event.
+ * @param et
+ */
 static inline void
 event_timeout_reset(struct event_timeout *et)
 {
@@ -179,6 +192,12 @@ event_timeout_reset(struct event_timeout *et)
     }
 }
 
+/**
+ * Sets the periodic parameter n of a timeout.
+ * @param et
+ * @param n set the periodic value of a timeout, negative values
+ *          will be interpreted as 0
+ */
 static inline void
 event_timeout_modify_wakeup(struct event_timeout *et, interval_t n)
 {
@@ -189,32 +208,47 @@ event_timeout_modify_wakeup(struct event_timeout *et, interval_t n)
     }
 }
 
-/*
- * Will return the time left for a timeout, this function does not check
- * if the timeout is actually valid
+/**
+ * Return time until the timeout should triggered from from now,
+ * this function does not check if the timeout is actually valid.
  */
 static inline interval_t
 event_timeout_remaining(struct event_timeout *et)
 {
-    return (interval_t) (et->last - now + et->n);
+    return (interval_t) ((et->last + et->n) - now);
 }
 
-/*
- * This is the principal function for testing and triggering recurring
- * timers and will return true on a timer signal event.
- * If et_const_retry == ETT_DEFAULT and a signal occurs,
- * the function will return true and *et will be armed for the
- * next event.  If et_const_retry >= 0 and a signal occurs,
- * *et will not be touched, but *tv will be set to
- * minimum (*tv, et_const_retry) for a future re-test,
- * and the function will return true.
- */
-
 #define ETT_DEFAULT (-1)
 
+/**
+ * This is the principal function for testing and triggering recurring
+ * timers.
+ *
+ * If *et is not triggered *tv is set to remaining time until the timeout if
+ * not already lower:
+ *
+ *      *tv = minimum(*tv, event_timeout_remaining(*et))
+ *
+ * If *et triggers and et_const_retry is negative (ETT_DEFAULT is -1):
+ *  - the function will return true
+ *  - *et will be armed for the next event (et->last set to now).
+ *  - *tv will be lowered to the event period (n) if larger than the
+ *     period of the event (set to *et's next timeout)
+ *
+ * If *et triggers and et_const_retry >= 0, *tv be reduced to et_const_try if
+ * larger:
+ *
+ *    *tv = *minimum(*tv, et_const_retry)
+ *
+ *
+ * @param et                the timeout to check
+ * @param tv                will be set to timeout for next check for this timeout unless already small.
+ * @param et_const_retry    see above
+ * @return                  if the timeout has triggered and event has been reset
+ */
 bool event_timeout_trigger(struct event_timeout *et,
                            struct timeval *tv,
-                           const int et_const_retry);
+                           int et_const_retry);
 
 /*
  * Measure time intervals in microseconds
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 00cd652fa..aae1d21b8 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -386,7 +386,9 @@ struct context_2
      * Event loop info
      */
 
-    /* how long to wait on link/tun read before we will need to be serviced */
+    /* time to next event of timers and similar. This is used to determine
+     * how long to wait on event wait (select/poll on link/tun read)
+     * before this context wants to be serviced */
     struct timeval timeval;
 
     /* next wakeup for processing coarse timers (>1 sec resolution) */
-- 
2.37.0 (Apple Git-136)


