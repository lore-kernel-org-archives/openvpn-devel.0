From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Jun 2016 22:50:56 -0400
Message-Id: <1466736656-27501-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1466649762-1657-1-git-send-email-selva.nair@...277...>
References: <1466649762-1657-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Return process id of openvpn from
	interactive service to client
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

- The process id is returned as a message formatted in the same manner
  as error messages from the service to the client: i.e., a three-line
  message with error number formatted as 0x%08x on line 1, followed by
  the PID in format 0x%08x on line 2 and a description that reads as
  "Process ID" on line 3. Error number is set to zero to indicate
  this is an informational message.

This provides a way for service clients to check the status of openvpn
and terminate it without needing management interface or exit event.
Useful when the interactive service is used from a launch script, or
to force-terminate openvpn from the GUI if/when needed.

v2 changes: format of the message changed as described above.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 2453f17..ffaa171 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -230,6 +230,21 @@ WritePipeAsync (HANDLE pipe, LPVOID data, DWORD size, DWORD count, LPHANDLE even
   return AsyncPipeOp (write, pipe, data, size, count, events);
 }
 
+static VOID
+ReturnProcessId (HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
+{
+  const WCHAR msg[] = L"Process ID";
+  WCHAR buf[22 + _countof(msg)]; /* 10 chars each for error and PID and 2 for line breaks */
+
+  /*
+   * Same format as error messages (3 line string) with error = 0 in
+   * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
+   */
+  _snwprintf (buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
+  buf[_countof(buf) - 1] = '\0';
+
+  WritePipeAsync (pipe, buf, wcslen (buf) * 2, count, events);
+}
 
 static VOID
 ReturnError (HANDLE pipe, DWORD error, LPCWSTR func, DWORD count, LPHANDLE events)
@@ -1293,6 +1308,8 @@ RunOpenvpn (LPVOID p)
       goto out;
     }
 
+  ReturnProcessId (pipe, proc_info.dwProcessId, 1, &exit_event);
+
   CloseHandleEx (&stdout_write);
   CloseHandleEx (&stdin_read);
   CloseHandleEx (&svc_pipe);
-- 
1.7.10.4


