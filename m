From: Selva Nair <selva.nair@...277...>
Date: Mon, 13 Jun 2016 22:34:49 -0400
Message-Id: <1465871689-13533-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Promptly close the netcmd_semaphore handle
	after use
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

If more than one openvpn processes are running and one aborts
without releasing the semaphore, subsequent processes fail to get
a lock for the semaphore. This may be avoided by not keeping open
handles to the semaphore so that Windows can destroy it when no
open handles remain.

See also: http://article.gmane.org/gmane.network.openvpn.devel/11913

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/win32.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 8a2f957..ad721cd 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -105,7 +105,6 @@ init_win32 (void)
     }
   window_title_clear (&window_title);
   win32_signal_clear (&win32_signal);
-  netcmd_semaphore_init ();
 }
 
 void
@@ -751,6 +750,10 @@ void
 netcmd_semaphore_lock (void)
 {
   const int timeout_seconds = 600;
+
+  if (!netcmd_semaphore.hand)
+    netcmd_semaphore_init ();
+
   if (!semaphore_lock (&netcmd_semaphore, timeout_seconds * 1000))
     msg (M_FATAL, "Cannot lock net command semaphore"); 
 }
@@ -759,6 +762,8 @@ void
 netcmd_semaphore_release (void)
 {
   semaphore_release (&netcmd_semaphore);
+  /* netcmd_semaphore has max count of 1 - safe to close after release */
+  semaphore_close (&netcmd_semaphore);
 }
 
 /*
-- 
1.7.10.4


