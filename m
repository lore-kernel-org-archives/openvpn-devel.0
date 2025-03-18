From: Gert Doering <gert@...1296...>
Date: Tue, 18 Mar 2025 18:39:06 +0100
Message-ID: <20250318173914.24425-1-gert@...1296...>
In-Reply-To: <gerrit.1742305513000.If15862fe537496ac836fc443936ff8e7876a39c0@...2715...>
References: <gerrit.1742305513000.If15862fe537496ac836fc443936ff8e7876a39c0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: Clean up use of TEXT() from
 DNS patches
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

From: Frank Lichtenheld <frank@...2641...>

These are slightly different and so not covered
by my automatic conversion script. Use __func__
to make the actual string slightly shorter.

Change-Id: If15862fe537496ac836fc443936ff8e7876a39c0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/910
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index bc53f04..50363b6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1194,30 +1194,30 @@
 
     if (apply_gpol && ApplyGpolSettings() == FALSE)
     {
-        MsgToEventLog(M_ERR, L"ApplyDnsSettings: sending GPOL notification failed");
+        MsgToEventLog(M_ERR, L"%s: sending GPOL notification failed", __func__);
     }
 
     scm = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
     if (scm == NULL)
     {
-        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
-                                  "OpenSCManager call failed (%lu)"), GetLastError());
+        MsgToEventLog(M_ERR, L"%s: OpenSCManager call failed (%lu)",
+                      __func__, GetLastError());
         goto out;
     }
 
     dnssvc = OpenServiceA(scm, "Dnscache", SERVICE_PAUSE_CONTINUE);
     if (dnssvc == NULL)
     {
-        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
-                                  "OpenService call failed (%lu)"), GetLastError());
+        MsgToEventLog(M_ERR, L"%s: OpenService call failed (%lu)",
+                      __func__, GetLastError());
         goto out;
     }
 
     SERVICE_STATUS status;
     if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) == 0)
     {
-        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
-                                  "ControlService call failed (%lu)"), GetLastError());
+        MsgToEventLog(M_ERR, L"%s: ControlService call failed (%lu)",
+                      __func__, GetLastError());
         goto out;
     }
 
@@ -1255,22 +1255,19 @@
     err = InterfaceLuid(itf_name, &luid);
     if (err)
     {
-        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
-                                  "failed to convert itf alias '%s'"), itf_name);
+        MsgToEventLog(M_ERR, L"%s: failed to convert itf alias '%s'", __func__, itf_name);
         goto out;
     }
     err = ConvertInterfaceLuidToGuid(&luid, &guid);
     if (err)
     {
-        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
-                                  "Failed to convert itf '%s' LUID"), itf_name);
+        MsgToEventLog(M_ERR, L"%s: Failed to convert itf '%s' LUID", __func__, itf_name);
         goto out;
     }
 
     if (StringFromIID(&guid, &iid_str) != S_OK)
     {
-        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
-                                  "Failed to convert itf '%s' IID"), itf_name);
+        MsgToEventLog(M_ERR, L"%s: Failed to convert itf '%s' IID", __func__, itf_name);
         err = ERROR_OUTOFMEMORY;
         goto out;
     }
@@ -1420,8 +1417,8 @@
         {
             return FALSE;
         }
-        MsgToEventLog(M_ERR, TEXT("InitialSearchListExists: "
-                                  "failed to get InitialSearchList (%lu)"), err);
+        MsgToEventLog(M_ERR, L"%s: failed to get InitialSearchList (%lu)",
+                      __func__, err);
     }
 
     return TRUE;
@@ -1456,8 +1453,8 @@
     LSTATUS err = RegSetValueExW(key, L"InitialSearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_ERR, TEXT("StoreInitialDnsSearchList: "
-                                  "failed to set InitialSearchList value (%lu)"), err);
+        MsgToEventLog(M_ERR, L"%s: failed to set InitialSearchList value (%lu)",
+                      __func__, err);
         return FALSE;
     }
 
@@ -1485,8 +1482,8 @@
         err = RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL, list, &size);
         if (err)
         {
-            MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
-                                         "could not get SearchList from registry (%lu)"), err);
+            MsgToEventLog(M_SYSERR, L"%s: could not get SearchList from registry (%lu)",
+                          __func__, err);
             return FALSE;
         }
 
@@ -1499,9 +1496,8 @@
         size_t domlen = wcslen(domains);
         if (listlen + domlen + 2 > _countof(list))
         {
-            MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
-                                         "not enough space in list for search domains (len=%lu)"),
-                          domlen);
+            MsgToEventLog(M_SYSERR, L"%s: not enough space in list for search domains (len=%lu)",
+                          __func__, domlen);
             return FALSE;
         }
 
@@ -1519,8 +1515,8 @@
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
-                                     "could not set SearchList to registry (%lu)"), err);
+        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList to registry (%lu)",
+                      __func__, err);
         return FALSE;
     }
 
@@ -1551,8 +1547,8 @@
     {
         if (err != ERROR_FILE_NOT_FOUND)
         {
-            MsgToEventLog(M_SYSERR, TEXT("ResetDnsSearchDomains: "
-                                         "could not get InitialSearchList from registry (%lu)"), err);
+            MsgToEventLog(M_SYSERR, L"%s: could not get InitialSearchList from registry (%lu)",
+                          __func__, err);
         }
         goto out;
     }
@@ -1561,8 +1557,8 @@
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("ResetDnsSearchDomains: "
-                                     "could not set SearchList in registry (%lu)"), err);
+        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList in registry (%lu)",
+                      __func__, err);
         goto out;
     }
 
@@ -1589,16 +1585,15 @@
     err = RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL, list, &size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
-                                     "could not get SearchList from registry (%lu)"), err);
+        MsgToEventLog(M_SYSERR, L"%s: could not get SearchList from registry (%lu)",
+                      __func__, err);
         return;
     }
 
     PWSTR dst = wcsstr(list, domains);
     if (!dst)
     {
-        MsgToEventLog(M_ERR, TEXT("RemoveDnsSearchDomains: "
-                                  "could not find domains in search list"));
+        MsgToEventLog(M_ERR, L"%s: could not find domains in search list", __func__);
         return;
     }
 
@@ -1618,8 +1613,8 @@
         err = RegGetValueW(key, NULL, L"InitialSearchList", RRF_RT_REG_SZ, NULL, initial, &size);
         if (err)
         {
-            MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
-                                         "could not get InitialSearchList from registry (%lu)"), err);
+            MsgToEventLog(M_SYSERR, L"%s: could not get InitialSearchList from registry (%lu)",
+                          __func__, err);
             return;
         }
 
@@ -1635,8 +1630,8 @@
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
-                                     "could not set SearchList in registry (%lu)"), err);
+        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList in registry (%lu)",
+                      __func__, err);
     }
 }
 
@@ -1692,8 +1687,7 @@
     BOOL have_list = GetDnsSearchListKey(itf_name, gpol, &list_key);
     if (list_key == INVALID_HANDLE_VALUE)
     {
-        MsgToEventLog(M_SYSERR, TEXT("SetDnsSearchDomains: "
-                                     "could not get search list registry key"));
+        MsgToEventLog(M_SYSERR, L"%s: could not get search list registry key", __func__);
         return ERROR_FILE_NOT_FOUND;
     }
 
@@ -1762,9 +1756,8 @@
     if (err)
     {
         *key = INVALID_HANDLE_VALUE;
-        MsgToEventLog(M_SYSERR, TEXT("GetInterfacesKey: "
-                                     "could not open interfaces registry key for family %d (%lu)"),
-                      family, err);
+        MsgToEventLog(M_SYSERR, L"%s: could not open interfaces registry key for family %d (%lu)",
+                      __func__, family, err);
     }
 
     return err ? FALSE : TRUE;
@@ -1794,18 +1787,16 @@
     err = RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &itf);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("SetNameServersValue: "
-                                     "could not open interface key for %s family %d (%lu)"),
-                      itf_id, family, err);
+        MsgToEventLog(M_SYSERR, L"%s: could not open interface key for %s family %d (%lu)",
+                      __func__, itf_id, family, err);
         goto out;
     }
 
     err = RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, strlen(value) + 1);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("SetNameServersValue: "
-                                     "could not set name servers '%S' for %s family %d (%lu)"),
-                      value, itf_id, family, err);
+        MsgToEventLog(M_SYSERR, L"%s: could not set name servers '%S' for %s family %d (%lu)",
+                      __func__, value, itf_id, family, err);
     }
 
 out:

