From: Gert Doering <gert@...1296...>
Date: Sun, 16 Nov 2025 14:57:52 +0100
Message-ID: <20251116135757.15805-1-gert@...1296...>
In-Reply-To: <gerrit.1760452015000.Ie22f4902162b7004542f030c734b968de71e0e9e@...2715...>
References: <gerrit.1760452015000.Ie22f4902162b7004542f030c734b968de71e0e9e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] otime: Fix various conversion warnings
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

Generally just use better types. Use typedef
to handle the Win32 situation where tv_sec
is long which is smaller than time_t (which
is long long).

Change-Id: Ie22f4902162b7004542f030c734b968de71e0e9e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1274
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1274
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index d9bf157..1b3b096 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -95,50 +95,37 @@
 const char *
 tv_string_abs(const struct timeval *tv, struct gc_arena *gc)
 {
-    return time_string((time_t)tv->tv_sec, (long)tv->tv_usec, true, gc);
+    return time_string(tv->tv_sec, tv->tv_usec, true, gc);
 }
 
 /* format a time_t as ascii, or use current time if 0 */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 const char *
-time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc)
+time_string(time_t t, tv_usec_t usec, bool show_usec, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(64, gc);
     struct timeval tv;
 
-    if (t)
-    {
-        tv.tv_sec = t;
-        tv.tv_usec = usec;
-    }
-    else
+    if (!t)
     {
         gettimeofday(&tv, NULL);
+        t = tv.tv_sec;
+        usec = tv.tv_usec;
     }
 
-    t = tv.tv_sec;
     struct tm *tm = localtime(&t);
 
     buf_printf(&out, "%04d-%02d-%02d %02d:%02d:%02d", tm->tm_year + 1900, tm->tm_mon + 1,
                tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec);
 
-    if (show_usec && tv.tv_usec)
+    if (show_usec && usec)
     {
-        buf_printf(&out, " us=%ld", (long)tv.tv_usec);
+        buf_printf(&out, " us=%ld", (long)usec);
     }
 
     return BSTR(&out);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Limit the frequency of an event stream.
  *
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 108d0f2..60533fd 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -27,6 +27,14 @@
 #include "integer.h"
 #include "buffer.h"
 
+#ifdef _WIN32
+typedef long tv_sec_t;
+typedef long tv_usec_t;
+#else
+typedef time_t tv_sec_t;
+typedef suseconds_t tv_usec_t;
+#endif
+
 struct frequency_limit
 {
     int max;
@@ -42,7 +50,7 @@
 bool frequency_limit_event_allowed(struct frequency_limit *f);
 
 /* format a time_t as ascii, or use current time if 0 */
-const char *time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc);
+const char *time_string(time_t t, tv_usec_t usec, bool show_usec, struct gc_arena *gc);
 
 /* struct timeval functions */
 
@@ -59,11 +67,6 @@
 extern time_t now_usec;
 void update_now_usec(struct timeval *tv);
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static inline int
 openvpn_gettimeofday(struct timeval *tv, void *tz)
 {
@@ -71,8 +74,8 @@
     if (!status)
     {
         update_now_usec(tv);
-        tv->tv_sec = now;
-        tv->tv_usec = now_usec;
+        tv->tv_sec = (tv_sec_t)now;
+        tv->tv_usec = (tv_usec_t)now_usec;
     }
     return status;
 }
@@ -116,20 +119,21 @@
 
 /* return tv1 - tv2 in usec, constrained by max_seconds */
 static inline int
-tv_subtract(const struct timeval *tv1, const struct timeval *tv2, const unsigned int max_seconds)
+tv_subtract(const struct timeval *tv1, const struct timeval *tv2, const int max_seconds)
 {
     const int max_usec = max_seconds * 1000000;
-    const int sec_diff = tv1->tv_sec - tv2->tv_sec;
+    const tv_sec_t sec_diff = tv1->tv_sec - tv2->tv_sec;
 
-    if (sec_diff > ((int)max_seconds + 10))
+    if (sec_diff > (max_seconds + 10))
     {
         return max_usec;
     }
-    else if (sec_diff < -((int)max_seconds + 10))
+    else if (sec_diff < -(max_seconds + 10))
     {
         return -max_usec;
     }
-    return constrain_int(sec_diff * 1000000 + (tv1->tv_usec - tv2->tv_usec), -max_usec, max_usec);
+    const time_t complete_diff = sec_diff * 1000000 + (tv1->tv_usec - tv2->tv_usec);
+    return constrain_int((int)complete_diff, -max_usec, max_usec);
 }
 
 static inline void
@@ -223,8 +227,8 @@
 static inline void
 tv_delta(struct timeval *dest, const struct timeval *t1, const struct timeval *t2)
 {
-    int sec = t2->tv_sec - t1->tv_sec;
-    int usec = t2->tv_usec - t1->tv_usec;
+    tv_sec_t sec = t2->tv_sec - t1->tv_sec;
+    tv_usec_t usec = t2->tv_usec - t1->tv_usec;
 
     while (usec < 0)
     {
@@ -241,10 +245,6 @@
     dest->tv_usec = usec;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #define TV_WITHIN_SIGMA_MAX_SEC  600
 #define TV_WITHIN_SIGMA_MAX_USEC (TV_WITHIN_SIGMA_MAX_SEC * 1000000)
 

