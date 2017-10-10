From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:26 +0200
Message-Id: <20171010231130.6832-9-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
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

From: Simon Rozman <simon@...2293...>

---
 src/openvpn/block_dns.c       | 2 +-
 src/openvpnserv/automatic.c   | 2 +-
 src/openvpnserv/common.c      | 2 +-
 src/openvpnserv/interactive.c | 4 ++--
 src/openvpnserv/validate.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index d43cbcf..f88ba2c 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -370,7 +370,7 @@ get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family)
         }
         return ipiface.Metric;
     }
-    return -err;
+    return -(int)err;
 }
 
 /*
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 4123d0f..6c39aaa 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -155,7 +155,7 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)
  * Modify the extension on a filename.
  */
 static bool
-modext(LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)
+modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
 {
     int i;
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index b8b817b..7901fd6 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -36,7 +36,7 @@ openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
         len = _vsntprintf(str, size, format, arglist);
         str[size - 1] = 0;
     }
-    return (len >= 0 && len < size);
+    return (len >= 0 && (size_t)len < size);
 }
 int
 openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 8d94197..96e0de0 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -188,7 +188,7 @@ typedef enum {
 static DWORD
 AsyncPipeOp(async_op_t op, HANDLE pipe, LPVOID buffer, DWORD size, DWORD count, LPHANDLE events)
 {
-    int i;
+    DWORD i;
     BOOL success;
     HANDLE io_event;
     DWORD res, bytes = 0;
@@ -1061,7 +1061,7 @@ RegisterDNS(LPVOID unused)
         { ipcfg, L"ipconfig /flushdns",    timeout },
         { ipcfg, L"ipconfig /registerdns", timeout },
     };
-    int ncmds = sizeof(cmds) / sizeof(cmds[0]);
+    DWORD ncmds = sizeof(cmds) / sizeof(cmds[0]);
 
     HANDLE wait_handles[2] = {rdns_semaphore, exit_event};
 
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 7a2d0e3..5422d33 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -298,7 +298,7 @@ IsUserInGroup(PSID sid, const PTOKEN_GROUPS token_groups, const WCHAR *group_nam
             break;
         }
         /* If a match is already found, ret == TRUE and the loop is skipped */
-        for (int i = 0; i < nread && !ret; ++i)
+        for (DWORD i = 0; i < nread && !ret; ++i)
         {
             ret = EqualSid(members[i].lgrmi0_sid, sid);
         }
-- 
2.9.0.windows.1


