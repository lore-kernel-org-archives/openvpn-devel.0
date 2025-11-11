From: Gert Doering <gert@...1296...>
Date: Tue, 11 Nov 2025 16:51:31 +0100
Message-ID: <20251111155139.31642-1-gert@...1296...>
In-Reply-To: <gerrit.1762517501000.Id9158f477404aac1d6b08b08e672980e5a58dc35@...2715...>
References: <gerrit.1762517501000.Id9158f477404aac1d6b08b08e672980e5a58dc35@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] forward: Change context_reschedule_sec
 sec argument to time_t
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

This avoids conversions at the caller sites. Since we only
replace tv_sec if the new value is smaller the cast
to tv_sec_t is also safe.

Change-Id: Id9158f477404aac1d6b08b08e672980e5a58dc35
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1356
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1356
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index cffb310..fbef539 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -33,6 +33,7 @@
 #include "mss.h"
 #include "event.h"
 #include "occ.h"
+#include "otime.h"
 #include "ping.h"
 #include "ps.h"
 #include "dhcp.h"
@@ -127,7 +128,7 @@
 }
 
 static inline void
-context_reschedule_sec(struct context *c, int sec)
+context_reschedule_sec(struct context *c, time_t sec)
 {
     if (sec < 0)
     {
@@ -135,7 +136,7 @@
     }
     if (sec < c->c2.timeval.tv_sec)
     {
-        c->c2.timeval.tv_sec = sec;
+        c->c2.timeval.tv_sec = (tv_sec_t)sec;
         c->c2.timeval.tv_usec = 0;
     }
 }
@@ -822,11 +823,6 @@
 #endif /* ENABLE_MANAGEMENT */
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 check_coarse_timers(struct context *c)
 {
@@ -1297,6 +1293,11 @@
 #endif /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD)) */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Output: c->c2.buf
  */

