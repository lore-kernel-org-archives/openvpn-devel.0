From: Gert Doering <gert@...1296...>
Date: Wed, 12 Mar 2025 10:22:53 +0100
Message-ID: <20250312092259.26487-1-gert@...1296...>
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v13] dns: support multiple domains without
 DHCP
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

From: Heiko Hund <heiko@...2662...>

Instead of using wmic on Windows to set one (the first) DNS domain,
modify the registry directly and let the resolver know that something
changed.

This fixes that more than one search domain suffix could only be applied
when DHCP and the tap driver was used. Now this works as well in netsh
mode with the interactive service.

If possible the search domains are stored with the rest of the VPN interface
parameter values. However, a global search list and one which is
distributed via group policy have priority (in that order), so we probe
for the existence of those first. In order to be able to restore the
original list in any case we store an "initial list" as a backup of the
search list before we modify it.

Github: closes OpenVPN/openvpn#642
Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/824
This mail reflects revision 13 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 704e65a..31000e9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8370,7 +8370,7 @@
                 msg(msglevel, "--dhcp-option %s: maximum of %d search entries can be specified",
                     p[1], N_SEARCH_LIST_LEN);
             }
-            o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "DISABLE-NBT") && !p[2])
         {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index de54e89..4f7de6c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -183,9 +183,10 @@
 {
     ack_message_t ack;
     struct gc_arena gc = gc_new();
-    HANDLE pipe = tt->options.msg_channel;
+    const struct tuntap_options *o = &tt->options;
 
-    if (!tt->options.domain) /* no  domain to add or delete */
+    /* no domains to add or delete */
+    if (!o->domain && !o->domain_search_list[0])
     {
         goto out;
     }
@@ -203,28 +204,49 @@
         .addr_len = 0       /* add/delete only the domain, not DNS servers */
     };
 
+    /* interface name is required */
     strncpynt(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
-    strncpynt(dns.domains, tt->options.domain, sizeof(dns.domains));
-    /* truncation of domain name is not checked as it can't happen
-     * with 512 bytes room in dns.domains.
-     */
 
-    msg(D_LOW, "%s dns domain on '%s' (if_index = %d) using service",
+    /* only use domain when there are no search domains */
+    if (o->domain && !o->domain_search_list[0])
+    {
+        strncpynt(dns.domains, o->domain, sizeof(dns.domains));
+    }
+
+    /* Create a comma separated list of search domains */
+    for (int i = 0; i < N_SEARCH_LIST_LEN && o->domain_search_list[i]; ++i)
+    {
+        size_t dstlen = strlen(dns.domains);
+        size_t srclen = strlen(o->domain_search_list[i]);
+        size_t extra = dstlen ? 2 : 1; /* space for comma and NUL */
+        if (dstlen + srclen + extra > sizeof(dns.domains))
+        {
+            msg(M_WARN, "DNS search domains sent to service truncated to %d", i);
+            break;
+        }
+        if (dstlen)
+        {
+            dns.domains[dstlen++] = ',';
+        }
+        strncpy(dns.domains + dstlen, o->domain_search_list[i], srclen + 1);
+    }
+
+    msg(D_LOW, "%s DNS domains on '%s' (if_index = %d) using service",
         (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
-    if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
+    if (!send_msg_iservice(o->msg_channel, &dns, sizeof(dns), &ack, "TUN"))
     {
         goto out;
     }
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s dns domain failed using service: %s [status=%u if_name=%s]",
+        msg(M_WARN, "TUN: %s DNS domains failed using service: %s [status=%u if_name=%s]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
             ack.error_number, dns.iface.name);
         goto out;
     }
 
-    msg(M_INFO, "DNS domain %s using service", (add ? "set" : "deleted"));
+    msg(M_INFO, "DNS domains %s using service", (add ? "set" : "deleted"));
 
 out:
     gc_free(&gc);
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index ff03867..44a40fe 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -28,7 +28,8 @@
     -D_WIN32_WINNT=_WIN32_WINNT_VISTA
     )
 target_link_libraries(openvpnserv
-    advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib)
+    advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib
+    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib)
 if (MINGW)
     target_compile_options(openvpnserv PRIVATE -municode)
     target_link_options(openvpnserv PRIVATE -municode)
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 621ce73..f053f40 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -25,7 +25,9 @@
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
-openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 -lshlwapi -lnetapi32 -lws2_32 -lntdll
+openvpnserv_LDADD = \
+	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
+	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32
 endif
 
 openvpnserv_SOURCES = \
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 35753b7..606ca4b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -88,7 +88,7 @@
     wfp_block,
     undo_dns4,
     undo_dns6,
-    undo_domain,
+    undo_domains,
     undo_ring_buffer,
     undo_wins,
     _undo_type_max
@@ -103,6 +103,11 @@
 } wfp_block_data_t;
 
 typedef struct {
+    char itf_name[256];
+    PWSTR domains;
+} dns_domains_undo_data_t;
+
+typedef struct {
     struct tun_ring *send_ring;
     struct tun_ring *receive_ring;
 } ring_buffer_maps_t;
@@ -565,24 +570,6 @@
     return status;
 }
 
-static DWORD
-ConvertInterfaceNameToIndex(const wchar_t *ifname, NET_IFINDEX *index)
-{
-    NET_LUID luid;
-    DWORD err;
-
-    err = ConvertInterfaceAliasToLuid(ifname, &luid);
-    if (err == ERROR_SUCCESS)
-    {
-        err = ConvertInterfaceLuidToIndex(&luid, index);
-    }
-    if (err != ERROR_SUCCESS)
-    {
-        MsgToEventLog(M_ERR, L"Failed to find interface index for <%ls>", ifname);
-    }
-    return err;
-}
-
 static BOOL
 CmpAddress(LPVOID item, LPVOID address)
 {
@@ -1152,52 +1139,6 @@
     return err;
 }
 
-/**
- * Run command: wmic nicconfig (InterfaceIndex=$if_index) call $action ($data)
- * @param  if_index    "index of interface"
- * @param  action      e.g., "SetDNSDomain"
- * @param  data        data if required for action
- *                     - a single word for SetDNSDomain, empty or NULL to delete
- *                     - comma separated values for a list
- */
-static DWORD
-wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
-                   const wchar_t *data)
-{
-    DWORD err = 0;
-    wchar_t argv0[MAX_PATH];
-    wchar_t *cmdline = NULL;
-    int timeout = 10000; /* in msec */
-
-    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"wbem\\wmic.exe");
-
-    const wchar_t *fmt;
-    /* comma separated list must be enclosed in parenthesis */
-    if (data && wcschr(data, L','))
-    {
-        fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls (%ls)";
-    }
-    else
-    {
-        fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls \"%ls\"";
-    }
-
-    size_t ncmdline = wcslen(fmt) + 20 + wcslen(action) /* max 20 for ifindex */
-                      + (data ? wcslen(data) + 1 : 1);
-    cmdline = malloc(ncmdline*sizeof(wchar_t));
-    if (!cmdline)
-    {
-        return ERROR_OUTOFMEMORY;
-    }
-
-    swprintf(cmdline, ncmdline, fmt, if_index, action,
-             data ? data : L"");
-    err = ExecCommand(argv0, cmdline, timeout);
-
-    free(cmdline);
-    return err;
-}
-
 /* Delete all IPv4 or IPv6 dns servers for an interface */
 static DWORD
 DeleteDNS(short family, wchar_t *if_name)
@@ -1221,50 +1162,660 @@
 }
 
 /**
- * Set interface specific DNS domain suffix
- * @param  if_name    name of the interface
- * @param  domain     a single domain name
- * @param  lists      pointer to the undo lists. If NULL
- *                    undo lists are not altered.
- * Will delete the currently set value if domain is empty.
+ * Signal the DNS resolver (and others potentially) to reload the
+ * group policy (DNS) settings on 32 bit Windows systems
+ *
+ * @return BOOL to indicate if the reload was initiated
+ */
+static BOOL
+ApplyGpolSettings32(void)
+{
+    typedef NTSTATUS (__stdcall *publish_fn_t)(
+        DWORD StateNameLo,
+        DWORD StateNameHi,
+        DWORD TypeId,
+        DWORD Buffer,
+        DWORD Length,
+        DWORD ExplicitScope);
+    publish_fn_t RtlPublishWnfStateData;
+    const DWORD WNF_GPOL_SYSTEM_CHANGES_HI = 0x0D891E2A;
+    const DWORD WNF_GPOL_SYSTEM_CHANGES_LO = 0xA3BC0875;
+
+    HMODULE ntdll = LoadLibraryA("ntdll.dll");
+    if (ntdll == NULL)
+    {
+        return FALSE;
+    }
+
+    RtlPublishWnfStateData = (publish_fn_t) GetProcAddress(ntdll, "RtlPublishWnfStateData");
+    if (RtlPublishWnfStateData == NULL)
+    {
+        return FALSE;
+    }
+
+    if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM_CHANGES_HI, 0, 0, 0, 0) != ERROR_SUCCESS)
+    {
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+/**
+ * Signal the DNS resolver (and others potentially) to reload the
+ * group policy (DNS) settings on 64 bit Windows systems
+ *
+ * @return BOOL to indicate if the reload was initiated
+ */
+static BOOL
+ApplyGpolSettings64(void)
+{
+    typedef NTSTATUS (*publish_fn_t)(
+        INT64 StateName,
+        INT64 TypeId,
+        INT64 Buffer,
+        unsigned int Length,
+        INT64 ExplicitScope);
+    publish_fn_t RtlPublishWnfStateData;
+    const INT64 WNF_GPOL_SYSTEM_CHANGES = 0x0D891E2AA3BC0875;
+
+    HMODULE ntdll = LoadLibraryA("ntdll.dll");
+    if (ntdll == NULL)
+    {
+        return FALSE;
+    }
+
+    RtlPublishWnfStateData = (publish_fn_t) GetProcAddress(ntdll, "RtlPublishWnfStateData");
+    if (RtlPublishWnfStateData == NULL)
+    {
+        return FALSE;
+    }
+
+    if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) != ERROR_SUCCESS)
+    {
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+/**
+ * Signal the DNS resolver (and others potentially) to reload the group policy (DNS) settings
+ *
+ * @return BOOL to indicate if the reload was initiated
+ */
+static BOOL
+ApplyGpolSettings(void)
+{
+    SYSTEM_INFO si;
+    GetSystemInfo(&si);
+    const BOOL win_32bit = si.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_INTEL;
+    return win_32bit ? ApplyGpolSettings32() : ApplyGpolSettings64();
+}
+
+/**
+ * Signal the DNS resolver to reload its settings
+ *
+ * @param apply_gpol    BOOL reload setting from group policy hives as well
+ *
+ * @return BOOL to indicate if the reload was initiated
+ */
+static BOOL
+ApplyDnsSettings(BOOL apply_gpol)
+{
+    BOOL res = FALSE;
+    SC_HANDLE scm = NULL;
+    SC_HANDLE dnssvc = NULL;
+
+    if (apply_gpol && ApplyGpolSettings() == FALSE)
+    {
+        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: sending GPOL notification failed"));
+    }
+
+    scm = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
+    if (scm == NULL)
+    {
+        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
+                                  "OpenSCManager call failed (%lu)"), GetLastError());
+        goto out;
+    }
+
+    dnssvc = OpenServiceA(scm, "Dnscache", SERVICE_PAUSE_CONTINUE);
+    if (dnssvc == NULL)
+    {
+        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
+                                  "OpenService call failed (%lu)"), GetLastError());
+        goto out;
+    }
+
+    SERVICE_STATUS status;
+    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) == 0)
+    {
+        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
+                                  "ControlService call failed (%lu)"), GetLastError());
+        goto out;
+    }
+
+    res = TRUE;
+
+out:
+    if (dnssvc)
+    {
+        CloseServiceHandle(dnssvc);
+    }
+    if (scm)
+    {
+        CloseServiceHandle(scm);
+    }
+    return res;
+}
+
+/**
+ * Get the string interface UUID (with braces) for an interface alias name
+ *
+ * @param  itf_name   the interface alias name
+ * @param  str        pointer to the buffer the wide UUID is returned in
+ * @param  len        size of the str buffer in characters
+ *
+ * @return NO_ERROR on success, or the Windows error code for the failure
  */
 static DWORD
-SetDNSDomain(const wchar_t *if_name, const char *domain, undo_lists_t *lists)
+InterfaceIdString(PCSTR itf_name, PWSTR str, size_t len)
 {
-    NET_IFINDEX if_index;
+    DWORD err;
+    GUID guid;
+    NET_LUID luid;
+    PWSTR iid_str = NULL;
 
-    DWORD err  = ConvertInterfaceNameToIndex(if_name, &if_index);
-    if (err != ERROR_SUCCESS)
+    err = InterfaceLuid(itf_name, &luid);
+    if (err)
     {
-        return err;
+        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
+                                  "failed to convert itf alias '%s'"), itf_name);
+        goto out;
+    }
+    err = ConvertInterfaceLuidToGuid(&luid, &guid);
+    if (err)
+    {
+        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
+                                  "Failed to convert itf '%s' LUID"), itf_name);
+        goto out;
     }
 
-    wchar_t *wdomain = utf8to16(domain); /* utf8 to wide-char */
-    if (!wdomain)
+    if (StringFromIID(&guid, &iid_str) != S_OK)
     {
-        return ERROR_OUTOFMEMORY;
+        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
+                                  "Failed to convert itf '%s' IID"), itf_name);
+        err = ERROR_OUTOFMEMORY;
+        goto out;
+    }
+    if (wcslen(iid_str) + 1 > len)
+    {
+        err = ERROR_INVALID_PARAMETER;
+        goto out;
     }
 
-    /* free undo list if previously set */
-    if (lists)
+    wcsncpy(str, iid_str, len);
+
+out:
+    if (iid_str)
     {
-        free(RemoveListItem(&(*lists)[undo_domain], CmpWString, (void *)if_name));
+        CoTaskMemFree(iid_str);
     }
+    return err;
+}
 
-    err = wmic_nicconfig_cmd(L"SetDNSDomain", if_index, wdomain);
-
-    /* Add to undo list if domain is non-empty */
-    if (err == 0 && wdomain[0] && lists)
+/**
+ * Check for a valid search list in a certain key of the registry
+ *
+ * Valid means that a string value "SearchList" exists and that it
+ * contains one or more domains. We only check if the string contains
+ * a valid domain name character, but the main point is to prevent letting
+ * pass whitespace-only lists, so that check is good enough for that
+ * purpose.
+ *
+ * @param  key  HKEY in which to check for a valid search list
+ *
+ * @return BOOL to indicate if a valid search list has been found
+ */
+static BOOL
+HasValidSearchList(HKEY key)
+{
+    char data[64];
+    DWORD size = sizeof(data);
+    LSTATUS err = RegGetValueA(key, NULL, "SearchList", RRF_RT_REG_SZ, NULL, (PBYTE)data, &size);
+    if (!err || err == ERROR_MORE_DATA)
     {
-        wchar_t *tmp_name = _wcsdup(if_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_domain], tmp_name))
+        data[sizeof(data) - 1] = '\0';
+        for (int i = 0; i < strlen(data); ++i)
         {
-            free(tmp_name);
-            err = ERROR_OUTOFMEMORY;
+            if (isalnum(data[i]) || data[i] == '-' || data[i] == '.')
+            {
+                return TRUE;
+            }
+        }
+    }
+    return FALSE;
+}
+
+/**
+ * Find the registry key for storing the DNS domains for the VPN interface
+ *
+ * @param  itf_name PCSTR that contains the alias name of the interface the domains
+ *                  are related to. If this is NULL the interface probing is skipped.
+ * @param  gpol     PBOOL to indicate if the key returned is the group policy hive
+ * @param  key      PHKEY in which the found registry key is returned in
+ *
+ * @return BOOL to indicate if a search list is already present at the location.
+ *         If the key returned is INVALID_HANDLE_VALUE, this indicates an
+ *         unrecoverable error.
+ *
+ * The correct location to add them is where a non-empty "SearchList" value exists,
+ * or in the interface configuration itself. However, the system-wide and then the
+ * group policy search lists overrule the previous one respectively, so we need to
+ * probe to find the effective list.
+ */
+static BOOL
+GetDnsSearchListKey(PCSTR itf_name, PBOOL gpol, PHKEY key)
+{
+    LSTATUS err;
+
+    *gpol = FALSE;
+
+    /* Try the group policy search list */
+    err = RegOpenKeyExA(HKEY_LOCAL_MACHINE,
+                        "SOFTWARE\\Policies\\Microsoft\\Windows NT\\DNSClient",
+                        0, KEY_ALL_ACCESS, key);
+    if (!err)
+    {
+        if (HasValidSearchList(*key))
+        {
+            *gpol = TRUE;
+            return TRUE;
+        }
+        RegCloseKey(*key);
+    }
+
+    /* Try the system-wide search list */
+    err = RegOpenKeyExA(HKEY_LOCAL_MACHINE,
+                        "System\\CurrentControlSet\\Services\\TCPIP\\Parameters",
+                        0, KEY_ALL_ACCESS, key);
+    if (!err)
+    {
+        if (HasValidSearchList(*key))
+        {
+            return TRUE;
+        }
+        RegCloseKey(*key);
+    }
+
+    if (itf_name)
+    {
+        /* Always return the VPN interface key (if it exists) */
+        WCHAR iid[64];
+        DWORD iid_err = InterfaceIdString(itf_name, iid, _countof(iid));
+        if (!iid_err)
+        {
+            HKEY itfs;
+            err = RegOpenKeyExA(HKEY_LOCAL_MACHINE,
+                                "System\\CurrentControlSet\\Services\\TCPIP\\Parameters\\Interfaces",
+                                0, KEY_ALL_ACCESS, &itfs);
+            if (!err)
+            {
+                err = RegOpenKeyExW(itfs, iid, 0, KEY_ALL_ACCESS, key);
+                RegCloseKey(itfs);
+                if (!err)
+                {
+                    return FALSE; /* No need to preserve the VPN itf search list */
+                }
+            }
         }
     }
 
-    free(wdomain);
+    *key = INVALID_HANDLE_VALUE;
+    return FALSE;
+}
+
+/**
+ * Check if a initial list had already been created
+ *
+ * @param  key      HKEY of the registry subkey to search in
+ *
+ * @return BOOL to indicate if the initial list is already present under key
+ */
+static BOOL
+InitialSearchListExists(HKEY key)
+{
+    LSTATUS err;
+
+    err = RegGetValueA(key, NULL, "InitialSearchList", RRF_RT_REG_SZ, NULL, NULL, NULL);
+    if (err)
+    {
+        if (err == ERROR_FILE_NOT_FOUND)
+        {
+            return FALSE;
+        }
+        MsgToEventLog(M_ERR, TEXT("InitialSearchListExists: "
+                                  "failed to get InitialSearchList (%lu)"), err);
+    }
+
+    return TRUE;
+}
+
+/**
+ * Prepare DNS domain "SearchList" registry value, so additional
+ * VPN domains can be added and its original state can be restored
+ * in case the system cannot clean up regularly.
+ *
+ * @param  key      registry subkey to store the list in
+ * @param  list     string of comma separated domains to use as the list
+ *
+ * @return boolean to indicate whether the list was stored successfully
+ */
+static BOOL
+StoreInitialDnsSearchList(HKEY key, PCWSTR list)
+{
+    if (!list || wcslen(list) == 0)
+    {
+        MsgToEventLog(M_ERR, TEXT("StoreInitialDnsSearchList: empty search list"));
+        return FALSE;
+    }
+
+    if (InitialSearchListExists(key))
+    {
+        /* Initial list had already been stored */
+        return TRUE;
+    }
+
+    DWORD size = (wcslen(list) + 1) * sizeof(*list);
+    LSTATUS err = RegSetValueExW(key, L"InitialSearchList", 0, REG_SZ, (PBYTE)list, size);
+    if (err)
+    {
+        MsgToEventLog(M_ERR, TEXT("StoreInitialDnsSearchList: "
+                                  "failed to set InitialSearchList value (%lu)"), err);
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+/**
+ * Append domain suffixes to an existing search list
+ *
+ * @param  key          HKEY the list is stored at
+ * @param  have_list    BOOL to indicate if a search list already exists
+ * @param  domains      domain suffixes as comma separated string
+ *
+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+AddDnsSearchDomains(HKEY key, BOOL have_list, PCWSTR domains)
+{
+    LSTATUS err;
+    WCHAR list[2048] = {0};
+    DWORD size = sizeof(list);
+
+    if (have_list)
+    {
+        err = RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL, list, &size);
+        if (err)
+        {
+            MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
+                                         "could not get SearchList from registry (%lu)"), err);
+            return FALSE;
+        }
+
+        if (!StoreInitialDnsSearchList(key, list))
+        {
+            return FALSE;
+        }
+
+        size_t listlen = (size / sizeof(list[0])) - 1; /* returned size is in bytes */
+        size_t domlen = wcslen(domains);
+        if (listlen + domlen + 2 > _countof(list))
+        {
+            MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
+                                         "not enough space in list for search domains (len=%lu)"),
+                          domlen);
+            return FALSE;
+        }
+
+        /* Append to end of the search list */
+        PWSTR pos = list + listlen;
+        *pos = ',';
+        wcsncpy(pos + 1, domains, domlen + 1);
+    }
+    else
+    {
+        wcsncpy(list, domains, wcslen(domains) + 1);
+    }
+
+    size = (wcslen(list) + 1) * sizeof(list[0]);
+    err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
+                                     "could not set SearchList to registry (%lu)"), err);
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+/**
+ * Reset the DNS search list to its original value
+ *
+ * Looks for a "InitialSearchList" value as the one to reset to.
+ * If it doesn't exist, doesn't reset anything, as there was no
+ * SearchList in the first place.
+ *
+ * @param  key  HKEY of the location in the registry to reset
+ *
+ * @return BOOL to indicate if something was reset
+ */
+static BOOL
+ResetDnsSearchDomains(HKEY key)
+{
+    LSTATUS err;
+    BOOL ret = FALSE;
+    WCHAR list[2048];
+    DWORD size = sizeof(list);
+
+    err = RegGetValueW(key, NULL, L"InitialSearchList", RRF_RT_REG_SZ, NULL, list, &size);
+    if (err)
+    {
+        if (err != ERROR_FILE_NOT_FOUND)
+        {
+            MsgToEventLog(M_SYSERR, TEXT("ResetDnsSearchDomains: "
+                                         "could not get InitialSearchList from registry (%lu)"), err);
+        }
+        goto out;
+    }
+
+    size = (wcslen(list) + 1) * sizeof(list[0]);
+    err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("ResetDnsSearchDomains: "
+                                     "could not set SearchList in registry (%lu)"), err);
+        goto out;
+    }
+
+    RegDeleteValueA(key, "InitialSearchList");
+    ret = TRUE;
+
+out:
+    return ret;
+}
+
+/**
+ * Remove domain suffixes from an existing search list
+ *
+ * @param  key      HKEY the list is stored at
+ * @param  domains  domain suffixes to remove as comma separated string
+ */
+static void
+RemoveDnsSearchDomains(HKEY key, PCWSTR domains)
+{
+    LSTATUS err;
+    WCHAR list[2048];
+    DWORD size = sizeof(list);
+
+    err = RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL, list, &size);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
+                                     "could not get SearchList from registry (%lu)"), err);
+        return;
+    }
+
+    PWSTR dst = wcsstr(list, domains);
+    if (!dst)
+    {
+        MsgToEventLog(M_ERR, TEXT("RemoveDnsSearchDomains: "
+                                  "could not find domains in search list"));
+        return;
+    }
+
+    /* Cut out domains from list */
+    size_t domlen = wcslen(domains);
+    PCWSTR src = dst + domlen;
+    /* Also remove the leading comma, if there is one */
+    dst = dst > list ? dst - 1 : dst;
+    wmemmove(dst, src, domlen);
+
+    size_t list_len = wcslen(list);
+    if (list_len)
+    {
+        /* Now check if the shortened list equals the initial search list */
+        WCHAR initial[2048];
+        size = sizeof(initial);
+        err = RegGetValueW(key, NULL, L"InitialSearchList", RRF_RT_REG_SZ, NULL, initial, &size);
+        if (err)
+        {
+            MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
+                                         "could not get InitialSearchList from registry (%lu)"), err);
+            return;
+        }
+
+        /* If the search list is back to its initial state reset it */
+        if (wcsncmp(list, initial, wcslen(list)) == 0)
+        {
+            ResetDnsSearchDomains(key);
+            return;
+        }
+    }
+
+    size = (list_len + 1) * sizeof(list[0]);
+    err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
+                                     "could not set SearchList in registry (%lu)"), err);
+    }
+}
+
+/**
+ * Removes DNS domains from a search list they were previously added to
+ *
+ * @param undo_data     pointer to dns_domains_undo_data_t
+ */
+static void
+UndoDnsSearchDomains(dns_domains_undo_data_t *undo_data)
+{
+    BOOL gpol;
+    HKEY dns_searchlist_key;
+    GetDnsSearchListKey(undo_data->itf_name, &gpol, &dns_searchlist_key);
+    if (dns_searchlist_key != INVALID_HANDLE_VALUE)
+    {
+        RemoveDnsSearchDomains(dns_searchlist_key, undo_data->domains);
+        RegCloseKey(dns_searchlist_key);
+        ApplyDnsSettings(gpol);
+
+        free(undo_data->domains);
+        undo_data->domains = NULL;
+    }
+}
+
+/**
+ * Add or remove DNS search domains
+ *
+ * @param  itf_name   alias name of the interface the domains are set for
+ * @param  domains    a comma separated list of domain name suffixes
+ * @param  gpol       PBOOL to indicate if group policy values were modified
+ * @param  lists      pointer to the undo lists
+ *
+ * @return NO_ERROR on success, an error status code otherwise
+ *
+ * If a SearchList is present in the registry already, the domains are added
+ * to that list. Otherwise the domains are added to the VPN interface specific list.
+ * A group policy search list takes precedence over a system-wide list, and that one
+ * itself takes precedence over interface specific ones.
+ *
+ * This function will remove previously set domains if the domains parameter
+ * is NULL or empty.
+ *
+ * The gpol value is only valid if the function returns no error. In the error
+ * case nothing is changed.
+ */
+static DWORD
+SetDnsSearchDomains(PCSTR itf_name, PCSTR domains, PBOOL gpol, undo_lists_t *lists)
+{
+    DWORD err = ERROR_OUTOFMEMORY;
+
+    HKEY list_key;
+    BOOL have_list = GetDnsSearchListKey(itf_name, gpol, &list_key);
+    if (list_key == INVALID_HANDLE_VALUE)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("SetDnsSearchDomains: "
+                                     "could not get search list registry key"));
+        return ERROR_FILE_NOT_FOUND;
+    }
+
+    /* Remove previously installed search domains */
+    dns_domains_undo_data_t *undo_data = RemoveListItem(&(*lists)[undo_domains], CmpAny, NULL);
+    if (undo_data)
+    {
+        RemoveDnsSearchDomains(list_key, undo_data->domains);
+        free(undo_data->domains);
+        free(undo_data);
+        undo_data = NULL;
+    }
+
+    /* If there are search domains, add them */
+    if (domains && *domains)
+    {
+        wchar_t *wide_domains = utf8to16(domains); /* utf8 to wide-char */
+        if (!wide_domains)
+        {
+            goto out;
+        }
+
+        undo_data = malloc(sizeof(*undo_data));
+        if (!undo_data)
+        {
+            free(wide_domains);
+            wide_domains = NULL;
+            goto out;
+        }
+        strncpy(undo_data->itf_name, itf_name, sizeof(undo_data->itf_name));
+        undo_data->domains = wide_domains;
+
+        if (AddDnsSearchDomains(list_key, have_list, wide_domains) == FALSE
+            || AddListItem(&(*lists)[undo_domains], undo_data) != NO_ERROR)
+        {
+            RemoveDnsSearchDomains(list_key, wide_domains);
+            free(wide_domains);
+            free(undo_data);
+            undo_data = NULL;
+            goto out;
+        }
+    }
+
+    err = NO_ERROR;
+
+out:
+    RegCloseKey(list_key);
     return err;
 }
 
@@ -1315,11 +1866,13 @@
 
     if (msg->header.type == msg_del_dns_cfg)
     {
+        BOOL gpol = FALSE;
         if (msg->domains[0])
         {
-            /* setting an empty domain removes any previous value */
-            err = SetDNSDomain(wide_name, "", lists);
+            /* setting an empty domain list removes any previous value */
+            err = SetDnsSearchDomains(msg->iface.name, NULL, &gpol, lists);
         }
+        ApplyDnsSettings(gpol);
         goto out;  /* job done */
     }
 
@@ -1357,10 +1910,12 @@
         }
     }
 
+    BOOL gpol = FALSE;
     if (msg->domains[0])
     {
-        err = SetDNSDomain(wide_name, msg->domains, lists);
+        err = SetDnsSearchDomains(msg->iface.name, msg->domains, &gpol, lists);
     }
+    ApplyDnsSettings(gpol);
 
 out:
     free(wide_name);
@@ -1751,12 +2306,12 @@
                     DeleteDNS(AF_INET6, item->data);
                     break;
 
-                case undo_wins:
-                    netsh_wins_cmd(L"delete", item->data, NULL);
+                case undo_domains:
+                    UndoDnsSearchDomains(item->data);
                     break;
 
-                case undo_domain:
-                    SetDNSDomain(item->data, "", NULL);
+                case undo_wins:
+                    netsh_wins_cmd(L"delete", item->data, NULL);
                     break;
 
                 case wfp_block:
@@ -2260,6 +2815,34 @@
     ServiceStartInteractive(dwArgc, lpszArgv);
 }
 
+/**
+ * Clean up remains of previous sessions in registry. These remains can
+ * happen with unclean shutdowns or crashes and would interfere with
+ * normal operation of the system with and without active tunnels.
+ */
+static void
+CleanupRegistry(void)
+{
+    HKEY key;
+    DWORD changed = 0;
+
+    /* Clean up leftover DNS search list fragments */
+    BOOL gpol_list;
+    GetDnsSearchListKey(NULL, &gpol_list, &key);
+    if (key != INVALID_HANDLE_VALUE)
+    {
+        if (ResetDnsSearchDomains(key))
+        {
+            changed++;
+        }
+        RegCloseKey(key);
+    }
+
+    if (changed)
+    {
+        ApplyDnsSettings(gpol_list);
+    }
+}
 
 VOID WINAPI
 ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)
@@ -2283,6 +2866,9 @@
     status.dwWaitHint = 3000;
     ReportStatusToSCMgr(service, &status);
 
+    /* Clean up potentially left over registry values */
+    CleanupRegistry();
+
     /* Read info from registry in key HKLM\SOFTWARE\OpenVPN */
     error = GetOpenvpnSettings(&settings);
     if (error != ERROR_SUCCESS)

