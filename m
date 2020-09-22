From: Vladislav Grishenko <themiron@...2010...>
Date: Tue, 22 Sep 2020 05:40:05 +0500
Message-Id: <20200922004005.10268-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH] Fix update_time() and openvpn_gettimeofday()
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

With TIME_BACKTRACK_PROTECTION defined, openvpn_gettimeofday() uses and
updates global variable "now_usec" along with "now" only if current time
is ahead of the previsouly stored, taking nanoseconds into account.
But, update_time() function updates only "now" leaving "now_usec" as
is with any previously value stored.
This breaks both update_time() and openvpn_gettimeofday() results and
leads to time jumps in the future within one second, can affect shaper
and user timers.

100.900 openvpn_gettimeofday():
    now set to 100s, now_usec set to 100ns, stored time is 100.900
101.300 update_time():
    now set to 101s, but now_usec is not updated and still 900ns, stored
    time jumps to the future 101.900
101.600 openvpn_gettimeofday():
    current time 101.600 is in the past relatively stored time 101.900,
    now & now_usec variables are not updated, returned time 101.900 is
    still and again incorrect
102.100 openvpn_gettimeofday():
    current time 102.100 is no longer in the past relatively stored time
    101.900, so now & now_usec get updated with wrong time delta from
    previous openvpn_gettimeofday() call or now/now_usec math

Since update_time() and openvpn_gettimeofday() calls are mixed in runtime,
to fix their coexistance update_time() must update "now_usec" as well,
calling just update_now() is not enough.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/otime.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index a6f7ec25..fab4575c 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -78,13 +78,9 @@ openvpn_gettimeofday(struct timeval *tv, void *tz)
 static inline void
 update_time(void)
 {
-#ifdef _WIN32
-    /* on _WIN32, gettimeofday is faster than time(NULL) */
+    /* can't use time(NULL), now_usec needs to be updated */
     struct timeval tv;
     openvpn_gettimeofday(&tv, NULL);
-#else
-    update_now(time(NULL));
-#endif
 }
 
 #else /* !TIME_BACKTRACK_PROTECTION */
-- 
2.17.1


