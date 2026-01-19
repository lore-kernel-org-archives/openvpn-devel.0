From: Gert Doering <gert@...1296...>
Date: Mon, 19 Jan 2026 22:49:03 +0100
Message-ID: <20260119214908.27729-1-gert@...1296...>
In-Reply-To: <gerrit.1767808679000.I864cd4a718886f437b72e93d0286f90fcb73592b@...2715...>
References: <gerrit.1767808679000.I864cd4a718886f437b72e93d0286f90fcb73592b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] openvpnserv: Fix conversion warnings in
 interactive.c
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

Mostly DWORD vs. size_t conversions where we have no
choice but to cast.

Change-Id: I864cd4a718886f437b72e93d0286f90fcb73592b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1457
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1457
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@...515...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index aa7da00..b53207bc 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1383,10 +1383,20 @@
     return TRUE;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
+/**
+ * Return correct length for regex value to set for string
+ *
+ */
+static DWORD
+RegWStringSize(PCWSTR string)
+{
+    size_t length = (wcslen(string) + 1) * sizeof(wchar_t);
+    if (length > UINT_MAX)
+    {
+        length = UINT_MAX;
+    }
+    return (DWORD)length;
+}
 
 /**
  * Prepare DNS domain "SearchList" registry value, so additional
@@ -1413,7 +1423,7 @@
         return TRUE;
     }
 
-    DWORD size = (wcslen(list) + 1) * sizeof(*list);
+    DWORD size = RegWStringSize(list);
     LSTATUS err = RegSetValueExW(key, L"InitialSearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
@@ -1474,7 +1484,7 @@
         wcsncpy(list, domains, wcslen(domains) + 1);
     }
 
-    size = (wcslen(list) + 1) * sizeof(list[0]);
+    size = RegWStringSize(list);
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
@@ -1515,7 +1525,7 @@
         goto out;
     }
 
-    size = (wcslen(list) + 1) * sizeof(list[0]);
+    size = RegWStringSize(list);
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
@@ -1579,14 +1589,14 @@
         }
 
         /* If the search list is back to its initial state reset it */
-        if (wcsncmp(list, initial, wcslen(list)) == 0)
+        if (wcsncmp(list, initial, list_len) == 0)
         {
             ResetDnsSearchDomains(key);
             return;
         }
     }
 
-    size = (list_len + 1) * sizeof(list[0]);
+    size = RegWStringSize(list);
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
@@ -1751,7 +1761,7 @@
         goto out;
     }
 
-    err = RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, strlen(value) + 1);
+    err = RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, (DWORD)strlen(value) + 1);
     if (err)
     {
         MsgToEventLog(M_SYSERR, L"%S: could not set name servers '%S' for %s family %d (%lu)",
@@ -1807,7 +1817,7 @@
     int addr_len = msg->addr_len;
 
     /* sanity check */
-    const size_t max_addrs = _countof(msg->addr);
+    const int max_addrs = _countof(msg->addr);
     if (addr_len > max_addrs)
     {
         addr_len = max_addrs;
@@ -1949,7 +1959,7 @@
         short family = families[i];
 
         /* Create a comma sparated list of addresses of this family */
-        int offset = 0;
+        size_t offset = 0;
         char addr_list[NRPT_ADDR_SIZE * NRPT_ADDR_NUM];
         for (int j = 0; j < NRPT_ADDR_NUM && addresses[j][0]; j++)
         {
@@ -2085,9 +2095,9 @@
 
             size_t addr_len = strlen(pos);
             pos += addr_len;
-            s -= addr_len;
+            s -= (DWORD)addr_len;
         }
-        s = strlen(addrs) + 1;
+        s = (DWORD)strlen(addrs) + 1;
     }
 
     if (strchr(addrs, ':'))
@@ -2163,7 +2173,8 @@
 
     LSTATUS err = ERROR_FILE_NOT_FOUND;
     const DWORD buf_size = *size;
-    const size_t glyph_size = sizeof(*domains);
+    const DWORD glyph_size = sizeof(*domains);
+    const DWORD buf_len = buf_size / glyph_size;
     PWSTR values[] = { L"SearchList", L"Domain", L"DhcpDomainSearchList", L"DhcpDomain", NULL };
 
     for (int i = 0; values[i]; i++)
@@ -2178,7 +2189,6 @@
              *   - convert comma separated list to MULTI_SZ
              */
             PWCHAR pos = domains;
-            const DWORD buf_len = buf_size / glyph_size;
             while (TRUE)
             {
                 /* Terminate the domain at the next comma */
@@ -2188,9 +2198,9 @@
                     *comma = '\0';
                 }
 
-                size_t domain_len = wcslen(pos);
-                size_t domain_size = domain_len * glyph_size;
-                size_t converted_size = (pos - domains) * glyph_size;
+                DWORD domain_len = (DWORD)wcslen(pos);
+                DWORD domain_size = domain_len * glyph_size;
+                DWORD converted_size = (DWORD)(pos - domains) * glyph_size;
 
                 /* Ignore itf domains which match a pushed search domain */
                 if (ListContainsDomain(search_domains, pos, domain_len))
@@ -2216,7 +2226,7 @@
                 domain_size += glyph_size;
 
                 /* Space for the terminating zeros */
-                size_t extra_size = 2 * glyph_size;
+                const DWORD extra_size = 2 * glyph_size;
 
                 /* Check for enough space to convert this domain */
                 if (converted_size + domain_size + extra_size > buf_size)
@@ -2450,7 +2460,7 @@
 
     /* Set DNS Server address */
     err = RegSetValueExA(rule_key, "GenericDNSServers", 0, REG_SZ, (PBYTE)address,
-                         strlen(address) + 1);
+                         (DWORD)strlen(address) + 1);
     if (err)
     {
         goto out;
@@ -2571,7 +2581,7 @@
     if (domains[0])
     {
         size_t domains_len = strlen(domains);
-        dom_size = domains_len + 2; /* len + the trailing NULs */
+        dom_size = (DWORD)domains_len + 2; /* len + the trailing NULs */
 
         wide_domains = utf8to16_size(domains, dom_size);
         dom_size *= sizeof(*wide_domains);
@@ -2628,10 +2638,6 @@
     return err;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Return the registry key where NRPT rules are stored
  *

