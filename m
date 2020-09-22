From: Vladislav Grishenko <themiron@...2010...>
Date: Tue, 22 Sep 2020 22:08:41 +0500
Message-Id: <20200922170841.13729-1-themiron@...2010...>
In-Reply-To: <75c379c2-35da-da12-d21f-44b1d6b1065b@...1227...>
References: <75c379c2-35da-da12-d21f-44b1d6b1065b@...1227...>
Subject: [Openvpn-devel] [PATCH v3] Fix update_time() and
 openvpn_gettimeofday() coexistence
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
This breaks openvpn_gettimeofday() results and leads to time jumps in the
future within one second, can affect shaper and user timers.

Example:
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
there're several options to fix the things:

1. Allow update_time() to reset "now_usec" value backward to 0, since it's
   used directly only in time ajusting and always invalidate it in
   openvpn_gettimeofday() unless time has drifted backwards.
   Quick solution that only fixes openvpn_gettimeofday() and keeps current
   level of time performance and backward-protection handling way.

2. Switch update_time() to gettimeofday() not only for windows, but for all
   platforms: "now_usec" will be updated accordingly. As a disadvantage,
   gettimeofday() may have performance penalty on older or platforms w/o VDSO
   where expensive kernel syscall will be made. And it will still need time
   adjusting code, doubt it's feasible.

3. Switch update_time() and openvpn_gettimeofday() to clock_gettime() on
   Linux/BSD platforms with CLOCK_REALTIME_FAST/CLOCK_REALTIME_COARSE
   clock sources. According tests it'll be faster with VDSO than gettimeofday()
   or CLOCK_REALTIME/CLOCK_REALTIME_PRECISE, but still may require adjusting
   code to protect from time jumps on devices with no RTC (ex. routers) where
   NTP is the only way to get correct time after boot. Since not every *libc
   have clock_gettime() and corresponding CLOCK_* defines and/or running
   kernel may have no VDSO/corresponding CLOCK_* support - related autotools
   checks and fallback code can still be necessary.

4. Switch update_time() and openvpn_gettimeofday() to clock_gettime() on
   Linux/BSD platforms with CLOCK_MONOTONIC_FAST/CLOCK_MONOTONIC_COARSE
   clock sources. This may allow to get rid of time adjusting code at all
   with the acceptable performance on modern systems, but may still require
   to fallback to gettimeofday() with adj friends on older platforms (most
   likely to be Linux CPE/routers). From the effort point of view, splitting
   the whole OpenVPN code into realtime/monotonic is most significant and
   desired task among the above, several parts still needs to use realtime
   due API or storage or output reasons.

This patch implements the first stage only.

v2: move from gettimeofday() (1st way) back to time(), don't check previous
    value of "now_usec" in update_usec() instead
v3: recover "now_usec" checks against time jumps within one second, zero it
    in update_time() calls instead to pass the check.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/otime.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index a6f7ec25..78d20ba8 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -84,6 +84,7 @@ update_time(void)
     openvpn_gettimeofday(&tv, NULL);
 #else
     update_now(time(NULL));
+    now_usec = 0;
 #endif
 }
 
-- 
2.17.1


