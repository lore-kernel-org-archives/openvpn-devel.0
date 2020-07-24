From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 24 Jul 2020 13:48:41 +0300
Message-Id: <20200724104841.89-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] wintun: remove SYSTEM elevation hack
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

As discussed a while ago on the mailing list and
community meetings, having SYSTEM elevation hack
inside openvpn code considered harmful.

Since interactive service is the recommended way
of using openvpn on Windows, limiting wintun usage to
interactive service should not be an issue.

Remove elevation hack code and provide an error message
telling user to use interactive service or do SYSTEM
elevation himself via psexec.

Move implementation of register_ring_buffers() to header
amd delete ring_buffer.c.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/Makefile.am                     |  2 +-
 src/openvpn/openvpn.vcxproj                 |  1 -
 src/openvpn/openvpn.vcxproj.filters         |  3 -
 src/openvpn/ring_buffer.c                   | 56 ------------
 src/openvpn/ring_buffer.h                   | 31 +++++--
 src/openvpn/tun.c                           | 33 +------
 src/openvpn/win32.c                         | 95 ---------------------
 src/openvpnserv/Makefile.am                 |  2 +-
 src/openvpnserv/openvpnserv.vcxproj         |  1 -
 src/openvpnserv/openvpnserv.vcxproj.filters |  3 -
 10 files changed, 32 insertions(+), 195 deletions(-)
 delete mode 100644 src/openvpn/ring_buffer.c

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index f0e0ad23..47ad762d 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -141,6 +141,6 @@ openvpn_LDADD = \
 	$(OPTIONAL_DL_LIBS) \
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
-openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.c ring_buffer.h
+openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.h
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
 endif
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index c34733ea..bd1a5844 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -189,7 +189,6 @@
     <ClCompile Include="ps.c" />
     <ClCompile Include="push.c" />
     <ClCompile Include="reliable.c" />
-    <ClCompile Include="ring_buffer.c" />
     <ClCompile Include="route.c" />
     <ClCompile Include="run_command.c" />
     <ClCompile Include="schedule.c" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 80eb52b3..e0bc7d5e 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -240,9 +240,6 @@
     <ClCompile Include="vlan.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-    <ClCompile Include="ring_buffer.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
     <ClCompile Include="ssl_ncp.c">
       <Filter>Source Files</Filter>
     </ClCompile>
diff --git a/src/openvpn/ring_buffer.c b/src/openvpn/ring_buffer.c
deleted file mode 100644
index 8c81dc46..00000000
--- a/src/openvpn/ring_buffer.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
- *                2019 Lev Stipakov <lev@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include "ring_buffer.h"
-
-#ifdef _WIN32
-
-bool
-register_ring_buffers(HANDLE device,
-                      struct tun_ring *send_ring,
-                      struct tun_ring *receive_ring,
-                      HANDLE send_tail_moved,
-                      HANDLE receive_tail_moved)
-{
-    struct tun_register_rings rr;
-    BOOL res;
-    DWORD bytes_returned;
-
-    ZeroMemory(&rr, sizeof(rr));
-
-    rr.send.ring = send_ring;
-    rr.send.ring_size = sizeof(struct tun_ring);
-    rr.send.tail_moved = send_tail_moved;
-
-    rr.receive.ring = receive_ring;
-    rr.receive.ring_size = sizeof(struct tun_ring);
-    rr.receive.tail_moved = receive_tail_moved;
-
-    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr),
-                          NULL, 0, &bytes_returned, NULL);
-
-    return res != FALSE;
-}
-
-#endif /* ifdef _WIN32 */
\ No newline at end of file
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
index af46f106..4293f633 100644
--- a/src/openvpn/ring_buffer.h
+++ b/src/openvpn/ring_buffer.h
@@ -94,11 +94,32 @@ struct TUN_PACKET
  *                            that data has been written to receive ring
  * @return                    true if registration is successful, false otherwise - use GetLastError()
  */
-bool register_ring_buffers(HANDLE device,
-                           struct tun_ring *send_ring,
-                           struct tun_ring *receive_ring,
-                           HANDLE send_tail_moved,
-                           HANDLE receive_tail_moved);
+static bool
+register_ring_buffers(HANDLE device,
+                      struct tun_ring *send_ring,
+                      struct tun_ring *receive_ring,
+                      HANDLE send_tail_moved,
+                      HANDLE receive_tail_moved)
+{
+    struct tun_register_rings rr;
+    BOOL res;
+    DWORD bytes_returned;
+
+    ZeroMemory(&rr, sizeof(rr));
+
+    rr.send.ring = send_ring;
+    rr.send.ring_size = sizeof(struct tun_ring);
+    rr.send.tail_moved = send_tail_moved;
+
+    rr.receive.ring = receive_ring;
+    rr.receive.ring_size = sizeof(struct tun_ring);
+    rr.receive.tail_moved = receive_tail_moved;
+
+    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr),
+      NULL, 0, &bytes_returned, NULL);
+
+    return res != FALSE;
+}
 
 #endif /* ifndef OPENVPN_RING_BUFFER_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e96368ca..82d96927 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6148,35 +6148,10 @@ wintun_register_ring_buffer(struct tuntap *tt, const char *device_guid)
     }
     else
     {
-        if (!impersonate_as_system())
-        {
-            msg(M_FATAL, "ERROR:  Failed to impersonate as SYSTEM, make sure process is running under privileged account");
-        }
-        if (!register_ring_buffers(tt->hand,
-                                   tt->wintun_send_ring,
-                                   tt->wintun_receive_ring,
-                                   tt->rw_handle.read,
-                                   tt->rw_handle.write))
-        {
-            switch (GetLastError())
-            {
-                case ERROR_ACCESS_DENIED:
-                    msg(M_FATAL, "Access denied registering ring buffers. Is this process run as SYSTEM?");
-                    break;
-
-                case ERROR_ALREADY_INITIALIZED:
-                    msg(M_NONFATAL, "Adapter %s is already in use", device_guid);
-                    break;
-
-                default:
-                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring buffers");
-            }
-            ret = false;
-        }
-        if (!RevertToSelf())
-        {
-            msg(M_FATAL, "ERROR:  RevertToSelf error: %lu", GetLastError());
-        }
+        msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and therefore "
+                     "should be used with interactive service. If you want to "
+                     "use openvpn from command line, you need to do SYSTEM "
+                     "elevation yourself (for example with psexec).");
     }
 
     return ret;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index b2f2a19f..eb4c0307 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1493,99 +1493,4 @@ send_msg_iservice(HANDLE pipe, const void *data, size_t size,
     return ret;
 }
 
-bool
-impersonate_as_system()
-{
-    HANDLE thread_token, process_snapshot, winlogon_process, winlogon_token, duplicated_token;
-    PROCESSENTRY32 entry;
-    BOOL ret;
-    DWORD pid = 0;
-    TOKEN_PRIVILEGES privileges;
-
-    CLEAR(entry);
-    CLEAR(privileges);
-
-    entry.dwSize = sizeof(PROCESSENTRY32);
-
-    privileges.PrivilegeCount = 1;
-    privileges.Privileges->Attributes = SE_PRIVILEGE_ENABLED;
-
-    if (!LookupPrivilegeValue(NULL, SE_DEBUG_NAME, &privileges.Privileges[0].Luid))
-    {
-        return false;
-    }
-
-    if (!ImpersonateSelf(SecurityImpersonation))
-    {
-        return false;
-    }
-
-    if (!OpenThreadToken(GetCurrentThread(), TOKEN_ADJUST_PRIVILEGES, FALSE, &thread_token))
-    {
-        RevertToSelf();
-        return false;
-    }
-    if (!AdjustTokenPrivileges(thread_token, FALSE, &privileges, sizeof(privileges), NULL, NULL))
-    {
-        CloseHandle(thread_token);
-        RevertToSelf();
-        return false;
-    }
-    CloseHandle(thread_token);
-
-    process_snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
-    if (process_snapshot == INVALID_HANDLE_VALUE)
-    {
-        RevertToSelf();
-        return false;
-    }
-    for (ret = Process32First(process_snapshot, &entry); ret; ret = Process32Next(process_snapshot, &entry))
-    {
-        if (!_stricmp(entry.szExeFile, "winlogon.exe"))
-        {
-            pid = entry.th32ProcessID;
-            break;
-        }
-    }
-    CloseHandle(process_snapshot);
-    if (!pid)
-    {
-        RevertToSelf();
-        return false;
-    }
-
-    winlogon_process = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, pid);
-    if (!winlogon_process)
-    {
-        RevertToSelf();
-        return false;
-    }
-
-    if (!OpenProcessToken(winlogon_process, TOKEN_IMPERSONATE | TOKEN_DUPLICATE, &winlogon_token))
-    {
-        CloseHandle(winlogon_process);
-        RevertToSelf();
-        return false;
-    }
-    CloseHandle(winlogon_process);
-
-    if (!DuplicateToken(winlogon_token, SecurityImpersonation, &duplicated_token))
-    {
-        CloseHandle(winlogon_token);
-        RevertToSelf();
-        return false;
-    }
-    CloseHandle(winlogon_token);
-
-    if (!SetThreadToken(NULL, duplicated_token))
-    {
-        CloseHandle(duplicated_token);
-        RevertToSelf();
-        return false;
-    }
-    CloseHandle(duplicated_token);
-
-    return true;
-}
-
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index f8d3319c..5dc38c9b 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -37,4 +37,4 @@ openvpnserv_SOURCES = \
 	validate.c validate.h \
 	$(top_srcdir)/src/openvpn/block_dns.c $(top_srcdir)/src/openvpn/block_dns.h \
 	openvpnserv_resources.rc \
-	$(top_srcdir)/src/openvpn/ring_buffer.c $(top_srcdir)/src/openvpn/ring_buffer.h
+	$(top_srcdir)/src/openvpn/ring_buffer.h
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index c5a34b87..5e973df4 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -115,7 +115,6 @@
     </Link>
   </ItemDefinitionGroup>
   <ItemGroup>
-    <ClCompile Include="..\openvpn\ring_buffer.c" />
     <ClCompile Include="automatic.c" />
     <ClCompile Include="common.c" />
     <ClCompile Include="interactive.c" />
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/openvpnserv.vcxproj.filters
index 3cb14ef6..41ad3e80 100644
--- a/src/openvpnserv/openvpnserv.vcxproj.filters
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters
@@ -33,9 +33,6 @@
     <ClCompile Include="..\openvpn\block_dns.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-    <ClCompile Include="..\openvpn\ring_buffer.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="service.h">
-- 
2.17.1


