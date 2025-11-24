From: Gert Doering <gert@...1296...>
Date: Mon, 24 Nov 2025 19:39:06 +0100
Message-ID: <20251124183911.24851-1-gert@...1296...>
In-Reply-To: <gerrit.1764008169000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
References: <gerrit.1764008169000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Restrict access to the service pipe to
 SYSTEM and owner
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

Access is restricted to SYSTEM and pipe client user
(the user starting openvpn.exe). The default is
full access to Administrtors, owner, and read access
to everyone. This hardens the pipe further.

Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1402
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1402
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 2dc865e..275bf42 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1975,10 +1975,26 @@
                      GetCurrentThreadId(), pipe_uuid_str);
     RpcStringFree(&pipe_uuid_str);
 
+    /* make a security descriptor for the named pipe with access
+     * restricted to the user and SYSTEM
+     */
+    SECURITY_ATTRIBUTES sa;
+    PSECURITY_DESCRIPTOR pSD = NULL;
+    LPCWSTR szSDDL = L"D:(A;;GA;;;SY)(A;;GA;;;OW)";
+    if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(
+            szSDDL, SDDL_REVISION_1, &pSD, NULL))
+    {
+        ReturnLastError(pipe, L"ConvertSDDL");
+        goto out;
+    }
+    sa.nLength = sizeof(sa);
+    sa.lpSecurityDescriptor = pSD;
+    sa.bInheritHandle = FALSE;
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS,
-                                1, 128, 128, 0, NULL);
+                                1, 128, 128, 0, &sa);
+
     if (ovpn_pipe == INVALID_HANDLE_VALUE)
     {
         ReturnLastError(pipe, L"CreateNamedPipe");

