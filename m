From: Gert Doering <gert@...1296...>
Date: Sun, 16 Nov 2025 14:59:04 +0100
Message-ID: <20251116135909.15964-1-gert@...1296...>
In-Reply-To: <gerrit.1761045859000.I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5@...2715...>
References: <gerrit.1761045859000.I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] interval: Fix conversion warning
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

Use correct return type of the function.

Change-Id: I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1291
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1291
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index fbefcd9..f9953a6 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -38,11 +38,6 @@
     top->horizon = horizon;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 event_timeout_trigger(struct event_timeout *et, struct timeval *tv, const int et_const_retry)
 {
@@ -52,7 +47,7 @@
     }
 
     bool ret = false;
-    time_t wakeup = event_timeout_remaining(et);
+    interval_t wakeup = event_timeout_remaining(et);
 
     if (wakeup <= 0)
     {
@@ -82,7 +77,3 @@
     }
     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

