From: David Sommerseth <openvpn@...2080...>
Date: Thu,  7 Jul 2016 13:05:19 +0200
Message-Id: <1467889519-8193-1-git-send-email-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH] Remove NOP function and callers
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
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...2145...>

From: David Sommerseth <dazo@...2145...>

multi_release_io_lock() and the calls to this function are not providing
anything at all.  Lets remove it and make the overall code less suprising.

Signed-off-by: David Sommerseth <dazo@...2145...>
---
 src/openvpn/mudp.c  | 2 --
 src/openvpn/multi.h | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 6e0568e..21a7e97 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -210,7 +210,6 @@ multi_process_io_udp (struct multi_context *m)
   else if (status & SOCKET_READ)
     {
       read_incoming_link (&m->top);
-      multi_release_io_lock (m);
       if (!IS_SIG (&m->top))
 	multi_process_incoming_link (m, NULL, mpp_flags);
     }
@@ -218,7 +217,6 @@ multi_process_io_udp (struct multi_context *m)
   else if (status & TUN_READ)
     {
       read_incoming_tun (&m->top);
-      multi_release_io_lock (m);
       if (!IS_SIG (&m->top))
 	multi_process_incoming_tun (m, mpp_flags);
     }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 9d8185d..0d369f3 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -625,10 +625,5 @@ multi_set_pending (struct multi_context *m, struct multi_instance *mi)
   m->pending = mi;
 }
 
-static inline void
-multi_release_io_lock (struct multi_context *m)
-{
-}
-
 #endif /* P2MP_SERVER */
 #endif /* MULTI_H */
-- 
1.8.3.1


