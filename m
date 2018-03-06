From: selva.nair@...277...
Date: Tue,  6 Mar 2018 01:09:28 -0500
Message-Id: <1520316568-8983-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Avoid overflow in wakeup time computation
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

Time interval arithmetic can overflow especially when user
defined intervals are involved. E.g., see Trac #922.

Avoid this by reordering the arithmetic operation in
event_timeout_trigger(). Also avoid unnecessary casting of time
variable to int.

Time until wakeup is now calculated like:

time_t wakeup = (last - now) + delay

Here delay is of type int, but is +ve by construction. Time backtrack
protection in OpenVPN ensures (last - now) <= 0. Then the above
expression cannot overflow (provided time_t is at least as large
as int).

A similar expression in interval.h is also changed.

(This patch grew out of patch 168 by Steffan Karger.)

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/interval.c | 8 +++++---
 src/openvpn/interval.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 00ee627..b728560 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -51,11 +51,12 @@ event_timeout_trigger(struct event_timeout *et,
 
     if (et->defined)
     {
-        int wakeup = (int) et->last + et->n - local_now;
+        time_t wakeup = et->last - local_now + et->n;
         if (wakeup <= 0)
         {
 #if INTERVAL_DEBUG
-            dmsg(D_INTERVAL, "EVENT event_timeout_trigger (%d) etcr=%d", et->n, et_const_retry);
+            dmsg(D_INTERVAL, "EVENT event_timeout_trigger (%d) etcr=%d", et->n,
+                 et_const_retry);
 #endif
             if (et_const_retry < 0)
             {
@@ -72,7 +73,8 @@ event_timeout_trigger(struct event_timeout *et,
         if (tv && wakeup < tv->tv_sec)
         {
 #if INTERVAL_DEBUG
-            dmsg(D_INTERVAL, "EVENT event_timeout_wakeup (%d/%d) etcr=%d", wakeup, et->n, et_const_retry);
+            dmsg(D_INTERVAL, "EVENT event_timeout_wakeup (%d/%d) etcr=%d",
+                 (int) wakeup, et->n, et_const_retry);
 #endif
             tv->tv_sec = wakeup;
             tv->tv_usec = 0;
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 826a08b..5623f3a 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -196,7 +196,7 @@ event_timeout_modify_wakeup(struct event_timeout *et, interval_t n)
 static inline interval_t
 event_timeout_remaining(struct event_timeout *et)
 {
-    return (int) et->last + et->n - now;
+    return (interval_t) (et->last - now + et->n);
 }
 
 /*
-- 
2.1.4


