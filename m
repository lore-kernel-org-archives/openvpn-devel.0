From: Gert Doering <gert@...1296...>
Date: Mon, 24 Nov 2025 19:38:34 +0100
Message-ID: <20251124183839.24803-1-gert@...1296...>
In-Reply-To: <gerrit.1764008169000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
References: <gerrit.1764008169000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Harden interactive service pipe
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

From: Selva Nair <selva.nair@...277...>

- Append a version 4 uuid to ovpn_pipe_name to make it less
  predictable
- Do not allow remote access to the pipe

This greatly reduces the possibility of a rogue process racing to
open the pipe before CreateFile() is called in the worker thread.

Reported-by: Marc Heuse <marc@...2953...>
Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1401
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1401
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c717e99..2dc865e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1955,11 +1955,30 @@
         goto out;
     }
 
+    UUID pipe_uuid;
+    RPC_STATUS rpc_stat = UuidCreate(&pipe_uuid);
+    if (rpc_stat != RPC_S_OK)
+    {
+        ReturnError(pipe, rpc_stat, L"UuidCreate", 1, &exit_event);
+        goto out;
+    }
+
+    RPC_WSTR pipe_uuid_str = NULL;
+    rpc_stat = UuidToStringW(&pipe_uuid, &pipe_uuid_str);
+    if (rpc_stat != RPC_S_OK)
+    {
+        ReturnError(pipe, rpc_stat, L"UuidToString", 1, &exit_event);
+        goto out;
+    }
     openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-                     TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_instance, GetCurrentThreadId());
+                     TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu_%ls"), service_instance,
+                     GetCurrentThreadId(), pipe_uuid_str);
+    RpcStringFree(&pipe_uuid_str);
+
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
-                                PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);
+                                PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS,
+                                1, 128, 128, 0, NULL);
     if (ovpn_pipe == INVALID_HANDLE_VALUE)
     {
         ReturnLastError(pipe, L"CreateNamedPipe");

