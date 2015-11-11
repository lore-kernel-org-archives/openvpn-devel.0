From: Selva Nair <selva.nair@...277...>
Date: Wed, 11 Nov 2015 14:46:11 -0500
Message-Id: <1447271171-29141-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1447271171-29141-1-git-send-email-selva.nair@...277...>
References: <CAKuzo_i7tOuGT87h2wQmCG1ivx9NDB5K0J8Z0sXxzTKO-oMHxw@...278...>
	<1447271171-29141-1-git-send-email-selva.nair@...277...>
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

Handle ctrl-C or ctrl-Break sent to the console as a SIGTERM.
Depending on the console mode, windows delivers ctrl-C as a
keyboard input or as a signal.  We handle both cases. This allows
graceful termination of the openvpn from programs such as nssm.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/win32.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 7c89a5a..feae73c 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -324,6 +324,55 @@ net_event_win32_close (struct net_event_win32 *ne)
  * (2) Service mode -- map Windows event object to SIGTERM
  */
 
+static bool
+win_keyboard_put_ctrlC (HANDLE stdin_handle)
+{
+  DWORD tmp;
+  INPUT_RECORD ir;
+
+  CLEAR(ir);
+  ir.EventType = KEY_EVENT;
+  ir.Event.KeyEvent.bKeyDown = true;
+  ir.Event.KeyEvent.wRepeatCount = 1;
+  ir.Event.KeyEvent.uChar.AsciiChar = 0x03; /* ctrl-C */
+  if (WriteConsoleInput(stdin_handle, &ir, 1, &tmp))
+     return true;
+  else
+     return false;
+}
+
+/*
+ * Callback to handle console ctrl events
+ */
+static bool
+win_ctrl_handler (DWORD signum)
+{
+  msg(D_LOW, "win_ctrl_handler: signal received (code=%d)", signum);
+
+  HANDLE stdin_handle = GetStdHandle (STD_INPUT_HANDLE);
+  if (stdin_handle == INVALID_HANDLE_VALUE)
+  {
+     msg(M_WARN, "Warning: win_ctrl_handler: no console input, signal not handled");
+     return false;
+  }
+
+  switch (signum)
+    {
+    case CTRL_C_EVENT:
+    case CTRL_BREAK_EVENT:
+      if (win_keyboard_put_ctrlC (stdin_handle))
+        return true;
+      else
+        msg(M_NONFATAL, "win_ctrl_handler: write to console input failed");
+      break;
+    default:
+      msg(D_LOW, "win_ctrl_handler: unknown signal (code=%d) not handled", signum);
+      break;
+    }
+  /* pass all other signals to the next handler */
+  return false;
+}
+
 void
 win32_signal_clear (struct win32_signal *ws)
 {
@@ -369,6 +418,8 @@ win32_signal_open (struct win32_signal *ws,
 		  ws->console_mode_save_defined = true;
 		}
 	      ws->mode = WSO_MODE_CONSOLE;
+             if (!SetConsoleCtrlHandler ((PHANDLER_ROUTINE) win_ctrl_handler, true))
+                msg (M_NONFATAL, "Error: win32_signal_open: SetConsoleCtrlHandler failed");
 	    }
 	  else
 	    ws->in.read = INVALID_HANDLE_VALUE; /* probably running as a service */
@@ -512,6 +563,9 @@ win32_signal_get (struct win32_signal *ws)
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


