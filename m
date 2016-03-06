From: Selva Nair <selva.nair@...277...>
Date: Sun,  6 Mar 2016 00:19:19 -0500
Message-Id: <1457241559-23374-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] Fix interactive service ignoring stop
	command if openvpn is running
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

Make the exit event not auto-reset so that the signal propagates to
all worker threads and finally to the main thread.

Fixes Trac #666

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 22239b2..39397d1 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1289,7 +1289,7 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
     goto out;
 
   io_event = InitOverlapped (&overlapped);
-  exit_event = CreateEvent (NULL, FALSE, FALSE, NULL);
+  exit_event = CreateEvent (NULL, TRUE, FALSE, NULL);
   if (!exit_event || !io_event)
     {
       error = MsgToEventLog (M_SYSERR, TEXT("Could not create event"));
@@ -1356,6 +1356,7 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
             {
               /* exit event signaled */
               CloseHandleEx (&pipe);
+              ResetEvent (exit_event);
               error = NO_ERROR;
               break;
             }
-- 
1.7.10.4


