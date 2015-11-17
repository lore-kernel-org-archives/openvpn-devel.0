From: Selva Nair <selva.nair@...277...>
Date: Mon, 16 Nov 2015 21:48:09 -0500
Message-Id: <1447728489-14991-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1447271171-29141-2-git-send-email-selva.nair@...277...>
References: <1447271171-29141-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Handle ctrl-C and ctrl-break events on
	Windows
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

v2 changes
 - cleaner, hopefully easier to get a code review :)
 - handles both console mode and service mode
-- >8 --

Handle ctrl-C or ctrl-Break sent to the console as a SIGTERM.
Depending on the console mode, windows delivers ctrl-C as a
keyboard input or as a signal. We handle both cases. This allows
graceful termination of openvpn from programs such as nssm.
Works in both console mode and service mode.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/win32.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index d06b41f..1f9bda0 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -324,6 +324,53 @@ net_event_win32_close (struct net_event_win32 *ne)
  * (2) Service mode -- map Windows event object to SIGTERM
  */
 
+static void
+win_trigger_event(struct win32_signal *ws)
+{
+  if (ws->mode == WSO_MODE_SERVICE && HANDLE_DEFINED(ws->in.read))
+    SetEvent (ws->in.read);
+  else /* generate a key-press event */
+    {
+      DWORD tmp;
+      INPUT_RECORD ir;
+      HANDLE stdin_handle = GetStdHandle(STD_INPUT_HANDLE);
+
+      CLEAR(ir);
+      ir.EventType = KEY_EVENT;
+      ir.Event.KeyEvent.bKeyDown = true;
+      if (!stdin_handle || !WriteConsoleInput(stdin_handle, &ir, 1, &tmp))
+        msg(M_WARN|M_ERRNO, "WARN: win_trigger_event: WriteConsoleInput");
+    }
+}
+
+/*
+ * Callback to handle console ctrl events
+ */
+static bool WINAPI
+win_ctrl_handler (DWORD signum)
+{
+  msg(D_LOW, "win_ctrl_handler: signal received (code=%lu)", (unsigned long) signum);
+
+  if (siginfo_static.signal_received == SIGTERM)
+     return true;
+
+  switch (signum)
+    {
+    case CTRL_C_EVENT:
+    case CTRL_BREAK_EVENT:
+      throw_signal(SIGTERM);
+      /* trigget the win32_signal to interrupt the event loop */
+      win_trigger_event(&win32_signal);
+      return true;
+      break;
+    default:
+      msg(D_LOW, "win_ctrl_handler: signal (code=%lu) not handled", (unsigned long) signum);
+      break;
+    }
+  /* pass all other signals to the next handler */
+  return false;
+}
+
 void
 win32_signal_clear (struct win32_signal *ws)
 {
@@ -403,6 +450,9 @@ win32_signal_open (struct win32_signal *ws,
 	    ws->mode = WSO_MODE_SERVICE;
 	}
     }
+    /* set the ctrl handler in both console and service modes */
+    if (!SetConsoleCtrlHandler ((PHANDLER_ROUTINE) win_ctrl_handler, true))
+       msg (M_WARN|M_ERRNO, "WARN: SetConsoleCtrlHandler failed");
 }
 
 static bool
@@ -512,6 +562,9 @@ win32_signal_get (struct win32_signal *ws)
 	    case 0x3E: /* F4 -> TERM */
 	      ret = SIGTERM;
 	      break;
+           case 0x03: /* CTRL-C -> TERM */
+             ret = SIGTERM;
+             break;
 	    }
 	}
       if (ret)
-- 
2.6.2


