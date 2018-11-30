From: Gert Doering <gert@...1296...>
Date: Fri, 30 Nov 2018 14:56:40 +0100
Message-Id: <20181130135641.11533-2-gert@...1296...>
In-Reply-To: <20181130135641.11533-1-gert@...1296...>
References: <20181130135641.11533-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] uncrustify openvpnserv/ sources
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

this is really just whitespace changes, but will make
running uncrustify as pre-commit-check easier if the
"base sources" won't see changes

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpnserv/interactive.c | 4 ++--
 src/openvpnserv/service.c     | 4 ++--
 src/openvpnserv/service.h     | 2 ++
 src/openvpnserv/validate.c    | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 2dc152c2..623c3ff7 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -514,7 +514,7 @@ GetStartupData(HANDLE pipe, STARTUP_DATA *sud)
     return TRUE;
 
 err:
-    sud->directory = NULL;		/* caller must not free() */
+    sud->directory = NULL;              /* caller must not free() */
     free(data);
     return FALSE;
 }
@@ -1318,7 +1318,7 @@ Undo(undo_lists_t *lists)
                     break;
 
                 case block_dns:
-                    interface_data = (block_dns_data_t*)(item->data);
+                    interface_data = (block_dns_data_t *)(item->data);
                     delete_block_dns_filters(interface_data->engine);
                     if (interface_data->metric_v4 >= 0)
                     {
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 7157bea2..8efe25f9 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -270,8 +270,8 @@ _tmain(int argc, TCHAR *argv[])
             else if (argc > i + 2 && _tcsicmp(TEXT("instance"), argv[i] + 1) == 0)
             {
                 dispatchTable = _tcsicmp(TEXT("interactive"), argv[i + 1]) != 0 ?
-                    dispatchTable_automatic :
-                    dispatchTable_interactive;
+                                dispatchTable_automatic :
+                                dispatchTable_interactive;
 
                 service_instance = argv[i + 2];
                 i += 2;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index cb7020fc..f5afe2f0 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -77,9 +77,11 @@ extern openvpn_service_t interactive_service;
 extern LPCTSTR service_instance;
 
 VOID WINAPI ServiceStartAutomaticOwn(DWORD argc, LPTSTR *argv);
+
 VOID WINAPI ServiceStartAutomatic(DWORD argc, LPTSTR *argv);
 
 VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);
+
 VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);
 
 BOOL openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist);
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 5506e902..9e1d7d2d 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -49,6 +49,7 @@ static const WCHAR *white_list[] =
 };
 
 static BOOL IsUserInGroup(PSID sid, const PTOKEN_GROUPS groups, const WCHAR *group_name);
+
 static PTOKEN_GROUPS GetTokenGroups(const HANDLE token);
 
 /*
@@ -305,7 +306,7 @@ IsUserInGroup(PSID sid, const PTOKEN_GROUPS token_groups, const WCHAR *group_nam
             ret = EqualSid(members[i].lgrmi0_sid, sid);
         }
         NetApiBufferFree(members);
-    /* MSDN says the lookup should always iterate until err != ERROR_MORE_DATA */
+        /* MSDN says the lookup should always iterate until err != ERROR_MORE_DATA */
     } while (err == ERROR_MORE_DATA && nloop++ < 100);
 
     if (err != NERR_Success && err != NERR_GroupNotFound)
-- 
2.19.2


