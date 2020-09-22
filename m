From: Vladislav Grishenko <themiron@...2010...>
Date: Tue, 22 Sep 2020 17:21:34 +0500
Message-Id: <20200922122134.12634-1-themiron@...2010...>
In-Reply-To: <75c379c2-35da-da12-d21f-44b1d6b1065b@...1227...>
References: <75c379c2-35da-da12-d21f-44b1d6b1065b@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Fix update_time() and
 openvpn_gettimeofday() coexistance
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
    now set to 100s, now_usec set to 900ns, stored time is 100.900
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
there're two ways to fix their coexistance:
* either fix update_time() to always update "now_usec" for example by
  moving update_time() to gettimeofday(). Unfortunately, it may bring
  performance penalty depending on Arch/OS and vuruallized/hw environmant
  according the tests on various Linux, FreeBSD and MacOS versions.
* or, for now, allow update_time() to break "now_usec" value, since it's
  used directly only in time ajusting and always invalidate it in
  openvpn_gettimeofday() w/o checking the previous and possibly obsolete
  value with no performance changes against the current implementation.
This patch implements the second way.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/otime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 640168a9..d27d1f9d 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -73,7 +73,7 @@ update_now_usec(struct timeval *tv)
 {
     const time_t last = now;
     update_now(tv->tv_sec);
-    if (now > last || (now == last && tv->tv_usec > now_usec))
+    if (now >= last)
     {
         now_usec = tv->tv_usec;
     }
-- 
2.17.1


