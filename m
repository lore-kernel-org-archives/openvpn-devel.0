From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 4 Dec 2024 12:52:55 +0000
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d6ceb212f3fd48d34b35d29329dfe1540b1100ed-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rQI83nbIwcI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support
 multiple domains without DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rQI83nbIwcI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail

to look at the new patch set (#2).


Change subject: dns: support multiple domains without DHCP
......................................................................

dns: support multiple domains without DHCP

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

Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/tun.c
M src/openvpnserv/interactive.c
2 files changed, 708 insertions(+), 110 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/824/2

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 1e67d37..53f3ebc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -183,9 +183,10 @@
 {
     ack_message_t ack;
     struct gc_arena gc =3D gc_new();
-    HANDLE pipe =3D tt->options.msg_channel;
+    const struct tuntap_options *o =3D &tt->options;

-    if (!tt->options.domain) /* no  domain to add or delete */
+    /* no domains to add or delete */
+    if (!o->domain && !o->domain_search_list[0])
     {
         goto out;
     }
@@ -203,28 +204,50 @@
         .addr_len =3D 0       /* add/delete only the domain, not DNS serve=
rs */
     };

+    /* interface name is required */
     strncpynt(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
-    strncpynt(dns.domains, tt->options.domain, sizeof(dns.domains));
-    /* truncation of domain name is not checked as it can't happen
-     * with 512 bytes room in dns.domains.
-     */
+    dns.iface.name[sizeof(dns.iface.name) - 1] =3D '\0';

-    msg(D_LOW, "%s dns domain on '%s' (if_index =3D %d) using service",
+    /* only use domain when there are no search domains */
+    if (o->domain && !o->domain_search_list[0])
+    {
+        strncpynt(dns.domains, o->domain, sizeof(dns.domains));
+    }
+
+    /* Create a comma separated list of search domains */
+    for (int i =3D 0; i < N_SEARCH_LIST_LEN && o->domain_search_list[i]; +=
+i)
+    {
+        size_t dstlen =3D strlen(dns.domains);
+        size_t srclen =3D strlen(o->domain_search_list[i]);
+        size_t extra =3D dstlen ? 2 : 1; /* space for comma and NUL */
+        if (dstlen + srclen + extra > sizeof(dns.domains))
+        {
+            msg(M_WARN, "DNS search domains sent to service truncated to %=
d", i);
+            break;
+        }
+        if (dstlen)
+        {
+            dns.domains[dstlen++] =3D ',';
+        }
+        strncpynt(dns.domains + dstlen, o->domain_search_list[i], srclen);
+    }
+
+    msg(D_LOW, "%s DNS domains on '%s' (if_index =3D %d) using service",
         (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
-    if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
+    if (!send_msg_iservice(o->msg_channel, &dns, sizeof(dns), &ack, "TUN"))
     {
         goto out;
     }

     if (ack.error_number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s dns domain failed using service: %s [status=
=3D%u if_name=3D%s]",
+        msg(M_WARN, "TUN: %s DNS domains failed using service: %s [status=
=3D%u if_name=3D%s]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number=
, &gc),
             ack.error_number, dns.iface.name);
         goto out;
     }

-    msg(M_INFO, "DNS domain %s using service", (add ? "set" : "deleted"));
+    msg(M_INFO, "DNS domains %s using service", (add ? "set" : "deleted"));

 out:
     gc_free(&gc);
@@ -1719,7 +1742,7 @@
     argv_free(&argv);
     gc_free(&gc);
 #endif /* if defined(TARGET_LINUX) */
-       /* Empty for _WIN32 and all other unixoid platforms */
+    /* Empty for _WIN32 and all other unixoid platforms */
 }

 static void
@@ -1745,7 +1768,7 @@
     argv_free(&argv);
     gc_free(&gc);
 #endif /* if defined(TARGET_LINUX) */
-       /* Empty for _WIN32 and all other unixoid platforms */
+    /* Empty for _WIN32 and all other unixoid platforms */
 }

 void
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 67f5bbc..cad8b02 100644
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
-    err =3D ConvertInterfaceAliasToLuid(ifname, &luid);
-    if (err =3D=3D ERROR_SUCCESS)
-    {
-        err =3D ConvertInterfaceLuidToIndex(&luid, index);
-    }
-    if (err !=3D ERROR_SUCCESS)
-    {
-        MsgToEventLog(M_ERR, L"Failed to find interface index for <%ls>", =
ifname);
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
- * Run command: wmic nicconfig (InterfaceIndex=3D$if_index) call $action (=
$data)
- * @param  if_index    "index of interface"
- * @param  action      e.g., "SetDNSDomain"
- * @param  data        data if required for action
- *                     - a single word for SetDNSDomain, empty or NULL to =
delete
- *                     - comma separated values for a list
- */
-static DWORD
-wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
-                   const wchar_t *data)
-{
-    DWORD err =3D 0;
-    wchar_t argv0[MAX_PATH];
-    wchar_t *cmdline =3D NULL;
-    int timeout =3D 10000; /* in msec */
-
-    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"wb=
em\\wmic.exe");
-
-    const wchar_t *fmt;
-    /* comma separated list must be enclosed in parenthesis */
-    if (data && wcschr(data, L','))
-    {
-        fmt =3D L"wmic nicconfig where (InterfaceIndex=3D%ld) call %ls (%l=
s)";
-    }
-    else
-    {
-        fmt =3D L"wmic nicconfig where (InterfaceIndex=3D%ld) call %ls \"%=
ls\"";
-    }
-
-    size_t ncmdline =3D wcslen(fmt) + 20 + wcslen(action) /* max 20 for if=
index */
-                      + (data ? wcslen(data) + 1 : 1);
-    cmdline =3D malloc(ncmdline*sizeof(wchar_t));
-    if (!cmdline)
-    {
-        return ERROR_OUTOFMEMORY;
-    }
-
-    swprintf(cmdline, ncmdline, fmt, if_index, action,
-             data ? data : L"");
-    err =3D ExecCommand(argv0, cmdline, timeout);
-
-    free(cmdline);
-    return err;
-}
-
 /* Delete all IPv4 or IPv6 dns servers for an interface */
 static DWORD
 DeleteDNS(short family, wchar_t *if_name)
@@ -1221,50 +1162,647 @@
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
+ApplyGpolSettings32()
+{
+    typedef NTSTATUS (__stdcall *publish_fn_t)(
+        DWORD StateNameLo,
+        DWORD StateNameHi,
+        DWORD TypeId,
+        DWORD Buffer,
+        DWORD Length,
+        DWORD ExplicitScope);
+    publish_fn_t RtlPublishWnfStateData;
+    const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0D891E2A;
+    const DWORD WNF_GPOL_SYSTEM_CHANGES_LO =3D 0xA3BC0875;
+
+    HMODULE ntdll =3D LoadLibraryA("ntdll.dll");
+    if (ntdll =3D=3D NULL)
+    {
+        return FALSE;
+    }
+
+    RtlPublishWnfStateData =3D (publish_fn_t) GetProcAddress(ntdll, "RtlPu=
blishWnfStateData");
+    if (RtlPublishWnfStateData =3D=3D NULL)
+    {
+        return FALSE;
+    }
+
+    if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM=
_CHANGES_HI, 0, 0, 0, 0) !=3D ERROR_SUCCESS)
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
+ApplyGpolSettings64()
+{
+    typedef NTSTATUS (*publish_fn_t)(
+        INT64 StateName,
+        INT64 TypeId,
+        INT64 Buffer,
+        unsigned int Length,
+        INT64 ExplicitScope);
+    publish_fn_t RtlPublishWnfStateData;
+    const INT64 WNF_GPOL_SYSTEM_CHANGES =3D 0x0D891E2AA3BC0875;
+
+    HMODULE ntdll =3D LoadLibraryA("ntdll.dll");
+    if (ntdll =3D=3D NULL)
+    {
+        return FALSE;
+    }
+
+    RtlPublishWnfStateData =3D (publish_fn_t) GetProcAddress(ntdll, "RtlPu=
blishWnfStateData");
+    if (RtlPublishWnfStateData =3D=3D NULL)
+    {
+        return FALSE;
+    }
+
+    if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) !=3D E=
RROR_SUCCESS)
+    {
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+/**
+ * Signal the DNS resolver (and others potentially) to reload the group po=
licy (DNS) settings
+ *
+ * @return BOOL to indicate if the reload was initiated
+ */
+static BOOL
+ApplyGpolSettings()
+{
+    SYSTEM_INFO si;
+    GetSystemInfo(&si);
+    const BOOL win_32bit =3D si.wProcessorArchitecture =3D=3D PROCESSOR_AR=
CHITECTURE_INTEL;
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
+    BOOL res =3D FALSE;
+    SC_HANDLE scm =3D INVALID_HANDLE_VALUE;
+    SC_HANDLE dnssvc =3D INVALID_HANDLE_VALUE;
+
+    if (apply_gpol && ApplyGpolSettings() =3D=3D FALSE)
+    {
+        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: sending GPOL notifica=
tion failed"));
+    }
+
+    scm =3D OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
+    if (scm =3D=3D NULL)
+    {
+        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
+                                  "OpenSCManager call failed (%lu)"), GetL=
astError());
+        goto out;
+    }
+
+    dnssvc =3D OpenServiceA(scm, "Dnscache", SERVICE_PAUSE_CONTINUE);
+    if (dnssvc =3D=3D NULL)
+    {
+        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
+                                  "OpenService call failed (%lu)"), GetLas=
tError());
+        goto out;
+    }
+
+    SERVICE_STATUS status;
+    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) =3D=
=3D 0)
+    {
+        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
+                                  "ControlService call failed (%lu)"), Get=
LastError());
+        goto out;
+    }
+
+    res =3D TRUE;
+
+out:
+    CloseServiceHandle(dnssvc);
+    CloseServiceHandle(scm);
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
-SetDNSDomain(const wchar_t *if_name, const char *domain, undo_lists_t *lis=
ts)
+InterfaceIdString(PCSTR itf_name, PWSTR str, size_t len)
 {
-    NET_IFINDEX if_index;
+    DWORD err;
+    GUID guid;
+    NET_LUID luid;
+    PWSTR iid_str =3D NULL;

-    DWORD err  =3D ConvertInterfaceNameToIndex(if_name, &if_index);
-    if (err !=3D ERROR_SUCCESS)
+    err =3D InterfaceLuid(itf_name, &luid);
+    if (err)
     {
-        return err;
+        MsgToEventLog(M_ERR, L"InterfaceIdString: "
+                      "failed to convert itf alias '%s'", itf_name);
+        goto out;
+    }
+    err =3D ConvertInterfaceLuidToGuid(&luid, &guid);
+    if (err)
+    {
+        MsgToEventLog(M_ERR, L"InterfaceIdString: "
+                      "Failed to convert itf '%s' LUID", itf_name);
+        goto out;
     }

-    wchar_t *wdomain =3D utf8to16(domain); /* utf8 to wide-char */
-    if (!wdomain)
+    if (StringFromIID(&guid, &iid_str) !=3D S_OK)
     {
-        return ERROR_OUTOFMEMORY;
+        MsgToEventLog(M_ERR, L"InterfaceIdString: "
+                      "Failed to convert itf '%s' IID", itf_name);
+        err =3D ERROR_OUTOFMEMORY;
+        goto out;
+    }
+    if (wcslen(iid_str) + 1 > len)
+    {
+        err =3D ERROR_INVALID_PARAMETER;
+        goto out;
     }

-    /* free undo list if previously set */
-    if (lists)
+    wcsncpy(str, iid_str, len);
+
+out:
+    if (iid_str)
     {
-        free(RemoveListItem(&(*lists)[undo_domain], CmpWString, (void *)if=
_name));
+        CoTaskMemFree(iid_str);
     }
+    return err;
+}

-    err =3D wmic_nicconfig_cmd(L"SetDNSDomain", if_index, wdomain);
-
-    /* Add to undo list if domain is non-empty */
-    if (err =3D=3D 0 && wdomain[0] && lists)
+/**
+ * Check for a valid search list in a certain key of the registry
+ *
+ * Valid means that a string value "SearchList" exists and that it
+ * contains one or more domains. We only check if the string contains
+ * a '.' character, but the main point is to prevent letting pass
+ * whitespace-only lists, so that check is good enough for that
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
+    DWORD size =3D sizeof(data);
+    LSTATUS err =3D RegGetValueA(key, NULL, "SearchList", RRF_RT_REG_SZ, N=
ULL, (PBYTE)data, &size);
+    if (!err || err =3D=3D ERROR_MORE_DATA)
     {
-        wchar_t *tmp_name =3D _wcsdup(if_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_domain], tmp_name))
+        data[sizeof(data) - 1] =3D '\0';
+        if (strchr(data, '.') !=3D NULL)
         {
-            free(tmp_name);
-            err =3D ERROR_OUTOFMEMORY;
+            return TRUE;
+        }
+    }
+    return FALSE;
+}
+
+/**
+ * Find the registry key for storing the DNS domains for the VPN interface
+ *
+ * @param  itf_name PCSTR that contains the alias name of the interface th=
e domains
+ *                  are related to. If this is NULL the interface probing =
is skipped.
+ * @param  gpol     PBOOL to indicate if the key returned is the group pol=
icy hive
+ * @param  key      PHKEY in which the found registry key is returned in
+ *
+ * @return BOOL to indicate if a search list is already present at the loc=
ation.
+ *         If the key returned is INVALID_HANDLE_VALUE, this indicates an
+ *         unrecoverable error.
+ *
+ * The correct location to add them is where a non-empty "SearchList" valu=
e exists,
+ * or in the interface configuration itself. However, the system-wide and =
then the
+ * group policy search lists overrule the previous one respectively, so we=
 need to
+ * probe to find the effective list.
+ */
+static BOOL
+GetDnsSearchListKey(PCSTR itf_name, PBOOL gpol, PHKEY key)
+{
+    LSTATUS err;
+
+    *gpol =3D FALSE;
+
+    /* Try the group policy search list */
+    err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE,
+                        "SOFTWARE\\Policies\\Microsoft\\Windows NT\\DNSCli=
ent",
+                        0, KEY_ALL_ACCESS, key);
+    if (!err)
+    {
+        if (HasValidSearchList(*key))
+        {
+            *gpol =3D TRUE;
+            return TRUE;
+        }
+        RegCloseKey(*key);
+    }
+
+    /* Try the system-wide search list */
+    err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE,
+                        "System\\CurrentControlSet\\Services\\TCPIP\\Param=
eters",
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
+        DWORD iid_err =3D InterfaceIdString(itf_name, iid, _countof(iid));
+        if (!iid_err)
+        {
+            HKEY itfs;
+            err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE,
+                                "System\\CurrentControlSet\\Services\\TCPI=
P\\Parameters\\Interfaces",
+                                0, KEY_ALL_ACCESS, &itfs);
+            if (!err)
+            {
+                err =3D RegOpenKeyExW(itfs, iid, 0, KEY_ALL_ACCESS, key);
+                RegCloseKey(itfs);
+                if (!err)
+                {
+                    return FALSE; /* No need to preserve the VPN itf searc=
h list */
+                }
+            }
         }
     }

-    free(wdomain);
+    *key =3D INVALID_HANDLE_VALUE;
+    return FALSE;
+}
+
+/**
+ * Check if a initial list had already been created
+ *
+ * @param  key      HKEY of the registry subkey to search in
+ *
+ * @return BOOL to indicate if the initial list is already present under k=
ey
+ */
+static BOOL
+InitialSearchListExists(HKEY key)
+{
+    LSTATUS err;
+
+    err =3D RegGetValueA(key, NULL, "InitialSearchList", RRF_RT_REG_SZ, NU=
LL, NULL, NULL);
+    if (err)
+    {
+        if (err =3D=3D ERROR_FILE_NOT_FOUND)
+        {
+            return FALSE;
+        }
+        MsgToEventLog(M_ERR, TEXT("InitialSearchListExists: "
+                                  "failed to get InitialSearchList (%lu)")=
, err);
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
+    if (!list || wcslen(list) =3D=3D 0)
+    {
+        MsgToEventLog(M_ERR, TEXT("StoreInitialDnsSearchList: empty search=
 list"));
+        return FALSE;
+    }
+
+    if (InitialSearchListExists(key))
+    {
+        /* Initial list had already been stored */
+        return TRUE;
+    }
+
+    DWORD size =3D (wcslen(list) + 1) * sizeof(*list);
+    LSTATUS err =3D RegSetValueExW(key, L"InitialSearchList", 0, REG_SZ, (=
PBYTE)list, size);
+    if (err)
+    {
+        MsgToEventLog(M_ERR, TEXT("StoreInitialDnsSearchList: "
+                                  "failed to set InitialSearchList value (=
%lu)"), err);
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
+    WCHAR list[4096];
+    DWORD size =3D sizeof(list);
+
+    if (have_list)
+    {
+        err =3D RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL=
, list, &size);
+        if (err)
+        {
+            MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
+                                         "could not get SearchList from re=
gistry (%lu)"), err);
+            return FALSE;
+        }
+
+        if (!StoreInitialDnsSearchList(key, list))
+        {
+            return FALSE;
+        }
+
+        size_t listlen =3D (size / sizeof(list[0])) - 1; /* returned size =
is in bytes */
+        size_t domlen =3D wcslen(domains);
+        if (listlen + domlen + 2 > _countof(list))
+        {
+            MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
+                                         "not enough space in list for sea=
rch domains (len=3D%lu)"),
+                          domlen);
+            return FALSE;
+        }
+
+        /* Append to end of the search list */
+        PWSTR pos =3D list + listlen;
+        *pos =3D ',';
+        wcsncpy(pos + 1, domains, domlen + 1);
+    }
+    else
+    {
+        wcsncpy(list, domains, wcslen(domains) + 1);
+    }
+
+    size =3D (wcslen(list) + 1) * sizeof(list[0]);
+    err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
+                                     "could not set SearchList to registry=
 (%lu)"), err);
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
+ * If it doesn't exists, resets to empty, effectively disabling it.
+ *
+ * @param  key  HKEY of the location in the registry to reset
+ *
+ * @return BOOL to indicate if something was reset
+ */
+static BOOL
+ResetDnsSearchDomains(HKEY key)
+{
+    LSTATUS err;
+    BOOL ret =3D FALSE;
+    WCHAR list[4096];
+    DWORD size =3D sizeof(list);
+
+    err =3D RegGetValueW(key, NULL, L"InitialSearchList", RRF_RT_REG_SZ, N=
ULL, list, &size);
+    if (err)
+    {
+        if (err !=3D ERROR_FILE_NOT_FOUND)
+        {
+            MsgToEventLog(M_SYSERR, TEXT("ResetDnsSearchDomains: "
+                                         "could not get InitialSearchList =
from registry (%lu)"), err);
+        }
+        goto out;
+    }
+
+    size =3D (wcslen(list) + 1) * sizeof(list[0]);
+    err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("ResetDnsSearchDomains: "
+                                     "could not set SearchList in registry=
 (%lu)"), err);
+        goto out;
+    }
+
+    RegDeleteValueA(key, "InitialSearchList");
+    ret =3D TRUE;
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
+    WCHAR list[4096];
+    DWORD size =3D sizeof(list);
+
+    err =3D RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL, li=
st, &size);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
+                                     "could not get SearchList from regist=
ry (%lu)"), err);
+        return;
+    }
+
+    PWSTR dst =3D wcsstr(list, domains);
+    if (!dst)
+    {
+        MsgToEventLog(M_ERR, TEXT("RemoveDnsSearchDomains: "
+                                  "could not find domains in search list")=
);
+        return;
+    }
+
+    /* Cut out domains from list */
+    size_t domlen =3D wcslen(domains);
+    PCWSTR src =3D dst + domlen;
+    /* Also remove the leading comma, if there is one */
+    dst =3D dst > list ? dst - 1 : dst;
+    wmemmove(dst, src, domlen);
+
+    /* Now check if the shortened list equals the initial search list */
+    WCHAR initial[4096];
+    size =3D sizeof(initial);
+    err =3D RegGetValueW(key, NULL, L"InitialSearchList", RRF_RT_REG_SZ, N=
ULL, initial, &size);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
+                                     "could not get InitialSearchList from=
 registry (%lu)"), err);
+        return;
+    }
+
+    /* If the search list is back to its initial state reset it */
+    if (wcsncmp(list, initial, wcslen(list)) =3D=3D 0)
+    {
+        ResetDnsSearchDomains(key);
+    }
+    else
+    {
+        size =3D (wcslen(list) + 1) * sizeof(list[0]);
+        err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list,=
 size);
+        if (err)
+        {
+            MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
+                                         "could not set SearchList in regi=
stry (%lu)"), err);
+        }
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
+    if (dns_searchlist_key !=3D INVALID_HANDLE_VALUE)
+    {
+        RemoveDnsSearchDomains(dns_searchlist_key, undo_data->domains);
+        RegCloseKey(dns_searchlist_key);
+        ApplyDnsSettings(gpol);
+
+        free(undo_data->domains);
+        undo_data->domains =3D NULL;
+    }
+}
+
+/**
+ * Add or remove DNS search domains
+ *
+ * @param  itf_name   alias name of the interface the domains are set for
+ * @param  domains    a comma separated list of domain name suffixes
+ * @param  gpol       PBOOL to indicate if group policy values were modifi=
ed
+ * @param  lists      pointer to the undo lists
+ *
+ * @return NO_ERROR on success, an error status code otherwise
+ *
+ * If a SearchList is present in the registry already, the domains are add=
ed
+ * to that list. Otherwise the domains are added to the VPN interface spec=
ific list.
+ * A group policy search list takes precedence over a system-wide list, an=
d that one
+ * itself takes precedence over interface specific ones.
+ *
+ * This function will remove previously set domains if the domains paramet=
er
+ * is NULL or empty.
+ *
+ * The gpol value is only valid if the function returns no error. In the e=
rror
+ * case nothing is changed.
+ */
+static DWORD
+SetDnsSearchDomains(PCSTR itf_name, PCSTR domains, PBOOL gpol, undo_lists_=
t *lists)
+{
+    DWORD err =3D ERROR_OUTOFMEMORY;
+
+    HKEY list_key;
+    BOOL have_list =3D GetDnsSearchListKey(itf_name, gpol, &list_key);
+    if (list_key =3D=3D INVALID_HANDLE_VALUE)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("SetDnsSearchDomains: "
+                                     "could not get search list registry k=
ey"));
+        return ERROR_FILE_NOT_FOUND;
+    }
+
+    /* Remove previously installed search domains */
+    dns_domains_undo_data_t *undo_data =3D RemoveListItem(&(*lists)[undo_d=
omains], CmpAny, NULL);
+    if (undo_data)
+    {
+        RemoveDnsSearchDomains(list_key, undo_data->domains);
+        free(undo_data->domains);
+        free(undo_data);
+        undo_data =3D NULL;
+    }
+
+    /* If there are search domains, add them */
+    if (domains && *domains)
+    {
+        wchar_t *wide_domains =3D utf8to16(domains); /* utf8 to wide-char =
*/
+        if (!wide_domains)
+        {
+            goto out;
+        }
+
+        undo_data =3D malloc(sizeof(*undo_data));
+        if (!undo_data)
+        {
+            free(wide_domains);
+            wide_domains =3D NULL;
+            goto out;
+        }
+        strncpy(undo_data->itf_name, itf_name, sizeof(undo_data->itf_name)=
);
+        undo_data->domains =3D wide_domains;
+
+        if (AddDnsSearchDomains(list_key, have_list, wide_domains) =3D=3D =
FALSE
+            || AddListItem(&(*lists)[undo_domains], undo_data) !=3D NO_ERR=
OR)
+        {
+            RemoveDnsSearchDomains(list_key, wide_domains);
+            free(wide_domains);
+            free(undo_data);
+            undo_data =3D NULL;
+            goto out;
+        }
+    }
+
+    err =3D NO_ERROR;
+
+out:
+    RegCloseKey(list_key);
     return err;
 }

@@ -1315,11 +1853,13 @@

     if (msg->header.type =3D=3D msg_del_dns_cfg)
     {
+        BOOL gpol =3D FALSE;
         if (msg->domains[0])
         {
-            /* setting an empty domain removes any previous value */
-            err =3D SetDNSDomain(wide_name, "", lists);
+            /* setting an empty domain list removes any previous value */
+            err =3D SetDnsSearchDomains(msg->iface.name, NULL, &gpol, list=
s);
         }
+        ApplyDnsSettings(gpol);
         goto out;  /* job done */
     }

@@ -1357,10 +1897,12 @@
         }
     }

+    BOOL gpol =3D FALSE;
     if (msg->domains[0])
     {
-        err =3D SetDNSDomain(wide_name, msg->domains, lists);
+        err =3D SetDnsSearchDomains(msg->iface.name, msg->domains, &gpol, =
lists);
     }
+    ApplyDnsSettings(gpol);

 out:
     free(wide_name);
@@ -1751,12 +2293,14 @@
                     DeleteDNS(AF_INET6, item->data);
                     break;

-                case undo_wins:
-                    netsh_wins_cmd(L"delete", item->data, NULL);
                     break;

-                case undo_domain:
-                    SetDNSDomain(item->data, "", NULL);
+                case undo_domains:
+                    UndoDnsSearchDomains(item->data);
+                    break;
+
+                case undo_wins:
+                    netsh_wins_cmd(L"delete", item->data, NULL);
                     break;

                 case wfp_block:
@@ -2260,6 +2804,34 @@
     ServiceStartInteractive(dwArgc, lpszArgv);
 }

+/**
+ * Clean up remains of previous sessions in registry. These remains can
+ * happen with unclean shutdowns or crashes and would interfere with
+ * normal operation of the system with and without active tunnels.
+ */
+static void
+CleanupRegistry()
+{
+    HKEY key;
+    DWORD changed =3D 0;
+
+    /* Clean up leftover DNS search list fragments */
+    BOOL gpol_list;
+    GetDnsSearchListKey(NULL, &gpol_list, &key);
+    if (key !=3D INVALID_HANDLE_VALUE)
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
@@ -2283,6 +2855,9 @@
     status.dwWaitHint =3D 3000;
     ReportStatusToSCMgr(service, &status);

+    /* Clean up potentially left over registry values */
+    CleanupRegistry();
+
     /* Read info from registry in key HKLM\SOFTWARE\OpenVPN */
     error =3D GetOpenvpnSettings(&settings);
     if (error !=3D ERROR_SUCCESS)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Gerrit-Change-Number: 824
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--rQI83nbIwcI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dns: support multiple domains without DHCP<br><br>Instead of using wmic o=
n Windows to set one (the first) DNS domain,<br>modify the registry directl=
y and let the resolver know that something<br>changed.<br><br>This fixes th=
at more than one search domain suffix could only be applied<br>when DHCP an=
d the tap driver was used. Now this works as well in netsh<br>mode with the=
 interactive service.<br><br>If possible the search domains are stored with=
 the rest of the VPN interface<br>parameter values. However, a global searc=
h list and one which is<br>distributed via group policy have priority (in t=
hat order), so we probe<br>for the existence of those first. In order to be=
 able to restore the<br>original list in any case we store an &quot;initial=
 list&quot; as a backup of the<br>search list before we modify it.<br><br>C=
hange-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96<br>Signed-off-by: Heiko=
 Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpn/tun.c<br>M src/openv=
pnserv/interactive.c<br>2 files changed, 708 insertions(+), 110 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24=
/824/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br=
><span>index 1e67d37..53f3ebc 100644</span><br><span>--- a/src/openvpn/tun.=
c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -183,9 +183,10=
 @@</span><br><span> {</span><br><span>     ack_message_t ack;</span><br><s=
pan>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    HANDLE pipe =3D tt-&gt;options.msg_channel;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tuntap_opt=
ions *o =3D &amp;tt-&gt;options;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!tt-&gt;options.domain) /* no  domain =
to add or delete */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* no domains to add or delete */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!o-&gt;domain &amp;&amp; !o-&gt;domain_search_lis=
t[0])</span><br><span>     {</span><br><span>         goto out;</span><br><=
span>     }</span><br><span>@@ -203,28 +204,50 @@</span><br><span>         =
.addr_len =3D 0       /* add/delete only the domain, not DNS servers */</sp=
an><br><span>     };</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* interface name is required */</span><br><span>   =
  strncpynt(dns.iface.name, tt-&gt;actual_name, sizeof(dns.iface.name));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(dns.domain=
s, tt-&gt;options.domain, sizeof(dns.domains));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* truncation of domain name is not checked a=
s it can&#39;t happen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * with 512 bytes room in dns.domains.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    dns.iface.name[sizeof(dns.iface.name) - 1] =3D &#39;\0&#39;;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(D_LOW, &quot;%s dns domain on &#39;%s&#39; (if_index =3D %d) using servi=
ce&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* onl=
y use domain when there are no search domains */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (o-&gt;domain &amp;&amp; !o-&gt;domain_=
search_list[0])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strncpynt(=
dns.domains, o-&gt;domain, sizeof(dns.domains));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Create a comma separated list of search domains */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; N_SEARCH_LIS=
T_LEN &amp;&amp; o-&gt;domain_search_list[i]; ++i)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        size_t dstlen =3D strlen(dns.domains);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        size_t srclen =3D strle=
n(o-&gt;domain_search_list[i]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        size_t extra =3D dstlen ? 2 : 1; /* space for comma and=
 NUL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
dstlen + srclen + extra &gt; sizeof(dns.domains))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_WARN, &quot;DNS search domains sent t=
o service truncated to %d&quot;, i);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (dstlen)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        dns.domains[dstlen++] =3D &#39;,&#39;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        strncpynt(dns.domains + dstlen, o-&gt;domain_searc=
h_list[i], srclen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;%s DNS domai=
ns on &#39;%s&#39; (if_index =3D %d) using service&quot;,</span><br><span> =
        (add ? &quot;Setting&quot; : &quot;Deleting&quot;), dns.iface.name,=
 dns.iface.index);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (!send_msg_iservice(pipe, &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&qu=
ot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!send_=
msg_iservice(o-&gt;msg_channel, &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&=
quot;))</span><br><span>     {</span><br><span>         goto out;</span><br=
><span>     }</span><br><span> </span><br><span>     if (ack.error_number !=
=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(M_WARN, &quot;TUN: %s dns domain failed using se=
rvice: %s [status=3D%u if_name=3D%s]&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;TUN: %s DNS domains faile=
d using service: %s [status=3D%u if_name=3D%s]&quot;,</span><br><span>     =
        (add ? &quot;adding&quot; : &quot;deleting&quot;), strerror_win32(a=
ck.error_number, &amp;gc),</span><br><span>             ack.error_number, d=
ns.iface.name);</span><br><span>         goto out;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(M_INFO, &quot;DNS domain %s using service&quot;, (add ? &quot;set&quot; =
: &quot;deleted&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(M_INFO, &quot;DNS domains %s using service&quot;, (add ? &quot=
;set&quot; : &quot;deleted&quot;));</span><br><span> </span><br><span> out:=
</span><br><span>     gc_free(&amp;gc);</span><br><span>@@ -1719,7 +1742,7 =
@@</span><br><span>     argv_free(&amp;argv);</span><br><span>     gc_free(=
&amp;gc);</span><br><span> #endif /* if defined(TARGET_LINUX) */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-       /* Empty for _WIN32 and a=
ll other unixoid platforms */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Empty for _WIN32 and all other unixoid platforms */</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
>@@ -1745,7 +1768,7 @@</span><br><span>     argv_free(&amp;argv);</span><br=
><span>     gc_free(&amp;gc);</span><br><span> #endif /* if defined(TARGET_=
LINUX) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       /* Em=
pty for _WIN32 and all other unixoid platforms */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Empty for _WIN32 and all other unixoid=
 platforms */</span><br><span> }</span><br><span> </span><br><span> void</s=
pan><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/=
interactive.c</span><br><span>index 67f5bbc..cad8b02 100644</span><br><span=
>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/=
interactive.c</span><br><span>@@ -88,7 +88,7 @@</span><br><span>     wfp_bl=
ock,</span><br><span>     undo_dns4,</span><br><span>     undo_dns6,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    undo_domain,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    undo_domains,</span><br><sp=
an>     undo_ring_buffer,</span><br><span>     undo_wins,</span><br><span> =
    _undo_type_max</span><br><span>@@ -103,6 +103,11 @@</span><br><span> } =
wfp_block_data_t;</span><br><span> </span><br><span> typedef struct {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char itf_name[256];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR domains;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+} dns_domains_undo_dat=
a_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+typedef struct {</span><br><span> =
    struct tun_ring *send_ring;</span><br><span>     struct tun_ring *recei=
ve_ring;</span><br><span> } ring_buffer_maps_t;</span><br><span>@@ -565,24 =
+570,6 @@</span><br><span>     return status;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-ConvertInterfaceNameToI=
ndex(const wchar_t *ifname, NET_IFINDEX *index)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    NET_LUID luid;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    DWORD err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertInterf=
aceAliasToLuid(ifname, &amp;luid);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (err =3D=3D ERROR_SUCCESS)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        err =3D ConvertInterfaceLuidToIndex(&amp;luid, index);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (err !=3D ERROR_SUCCESS)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quot;Failed to f=
ind interface index for &lt;%ls&gt;&quot;, ifname);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return err;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> static BOOL</span><br><span> CmpAddress(LPVOID item, LPVOID address=
)</span><br><span> {</span><br><span>@@ -1152,52 +1139,6 @@</span><br><span=
>     return err;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Run command: wmic nicconfig (InterfaceIndex=3D$if_index) =
call $action ($data)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param  if_index    &quot;index of interface&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param  action      e.g., &quot;SetDNSDo=
main&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  =
data        data if required for action</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *                     - a single word for SetDNSDomain, =
empty or NULL to delete</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *                     - comma separated values for a list</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_=
index,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
    const wchar_t *data)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD err =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t argv0[=
MAX_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t=
 *cmdline =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int timeout =3D 10000; /* in msec */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
swprintf(argv0, _countof(argv0), L&quot;%ls\\%ls&quot;, get_win_sys_path(),=
 L&quot;wbem\\wmic.exe&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const wc=
har_t *fmt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* com=
ma separated list must be enclosed in parenthesis */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (data &amp;&amp; wcschr(data, L&#39;=
,&#39;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        fmt =3D L&quot;wmic n=
icconfig where (InterfaceIndex=3D%ld) call %ls (%ls)&quot;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 fmt =3D L&quot;wmic nicconfig where (InterfaceIndex=3D%ld) call %ls \&quot=
;%ls\&quot;&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + 20=
 + wcslen(action) /* max 20 for ifindex */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                      + (data ? wcslen(data) + 1 : 1);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmdline =3D mallo=
c(ncmdline*sizeof(wchar_t));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!cmdline)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    swprintf(cmdline, ncmdline, fmt, i=
f_index, action,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        data ? data : L&quot;&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    err =3D ExecCommand(argv0, cmdline, timeout);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    free(cmdline);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return err;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> /* Delete all IPv4 or IPv6 dns servers for an interface */</spa=
n><br><span> static DWORD</span><br><span> DeleteDNS(short family, wchar_t =
*if_name)</span><br><span>@@ -1221,50 +1162,647 @@</span><br><span> }</span=
><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * Set interface specific DNS domain suffix</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param  if_name    name of the interfa=
ce</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  domain  =
   a single domain name</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param  lists      pointer to the undo lists. If NULL</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *                    undo lists are n=
ot altered.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Will de=
lete the currently set value if domain is empty.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Signal the DNS resolver (and others potenti=
ally) to reload the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * group policy (DNS) settings on 32 bit Windows systems</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return BOOL to indicate if the reload was initiated=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ApplyGpolSettings32()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    typedef NTSTATUS (__stdcall *publish_fn_t)(</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD StateNameLo,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD StateNam=
eHi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD T=
ypeId,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD=
 Buffer,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWO=
RD Length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        D=
WORD ExplicitScope);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    publish_fn_t RtlPublishWnfStateData;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0D89=
1E2A;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const DWOR=
D WNF_GPOL_SYSTEM_CHANGES_LO =3D 0xA3BC0875;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    HMODULE ntdll =3D LoadLibraryA(&quot;ntdll.dll&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (ntdll =3D=3D NULL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    RtlPublishWnfStateData =3D (publish_fn_t) GetProcAddress(ntdll, =
&quot;RtlPublishWnfStateData&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (RtlPublishWnfStateData =3D=3D NULL)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM_CHAN=
GES_HI, 0, 0, 0, 0) !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sig=
nal the DNS resolver (and others potentially) to reload the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * group policy (DNS) settings on 6=
4 bit Windows systems</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL=
 to indicate if the reload was initiated</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+App=
lyGpolSettings64()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    typedef NTSTATU=
S (*publish_fn_t)(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       INT64 StateName,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        INT64 TypeId,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        INT64 Buffer,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        unsigned int Length,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        INT64 ExplicitScope);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    publish_fn_t RtlPublishWnfStateData;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const INT64 WNF_GPOL_SY=
STEM_CHANGES =3D 0x0D891E2AA3BC0875;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  HMODULE ntdll =3D LoadLibraryA(&quot;ntdll.dll&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (ntdll =3D=3D NULL)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    RtlPublishWnfStateData =3D (publish_fn_t) GetProcAddress(ntdll, &quot;=
RtlPublishWnfStateData&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (RtlPublishWnfStateData =3D=3D NULL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (Rt=
lPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) !=3D ERROR_SUCCES=
S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Signal the DNS resolver (and others po=
tentially) to reload the group policy (DNS) settings</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return BOOL to indicate if the reload was initiated</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ApplyGpolSettings()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    SYSTEM_INFO si;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    GetSystemInfo(&amp;si);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const BOOL win_32bit =3D si.wProcessorArchitecture =
=3D=3D PROCESSOR_ARCHITECTURE_INTEL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return win_32bit ? ApplyGpolSettings32() : ApplyGpolSe=
ttings64();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Signal the DNS resolver to reload its settings</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param apply_gpol    BOOL reload setting from=
 group policy hives as well</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n BOOL to indicate if the reload was initiated</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ApplyDnsSettings(BOOL apply_gpol)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   BOOL res =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SC_HANDLE scm =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SC_HANDLE dnssvc =3D INVALID_HANDLE_VALUE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (apply_gpol &amp;&amp; ApplyGpolS=
ettings() =3D=3D FALSE)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Ms=
gToEventLog(M_ERR, TEXT(&quot;ApplyDnsSettings: sending GPOL notification f=
ailed&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    scm =3D OpenSCManager(NULL, NULL, =
SC_MANAGER_ALL_ACCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (scm =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSettings: &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                  &=
quot;OpenSCManager call failed (%lu)&quot;), GetLastError());</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    dnssvc =3D OpenServiceA(scm, &quot;Dnscache&quot;, SERVICE_PAUSE=
_CONTINUE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
dnssvc =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToE=
ventLog(M_ERR, TEXT(&quot;ApplyDnsSettings: &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                  &quot;Open=
Service call failed (%lu)&quot;), GetLastError());</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SERVICE_STATUS status;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &amp;status)=
 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M=
_ERR, TEXT(&quot;ApplyDnsSettings: &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                  &quot;ControlServic=
e call failed (%lu)&quot;), GetLastError());</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res =
=3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    CloseServiceHandle(dnssvc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    CloseServiceHandle(scm);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return res;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Ge=
t the string interface UUID (with braces) for an interface alias name</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param  itf_name   the interface alias=
 name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  str=
        pointer to the buffer the wide UUID is returned in</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param  len        size of the st=
r buffer in characters</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return NO_=
ERROR on success, or the Windows error code for the failure</span><br><span=
>  */</span><br><span> static DWORD</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-SetDNSDomain(const wchar_t *if_name, const char *domain, undo=
_lists_t *lists)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Int=
erfaceIdString(PCSTR itf_name, PWSTR str, size_t len)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    NET_IFINDEX if_index=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD err;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    GUID guid;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    NET_LUID luid;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR iid_str =3D NULL;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    D=
WORD err  =3D ConvertInterfaceNameToIndex(if_name, &amp;if_index);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (err !=3D ERROR_SUCCESS=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D Interf=
aceLuid(itf_name, &amp;luid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (err)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;InterfaceIdStri=
ng: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
             &quot;failed to convert itf alias &#39;%s&#39;&quot;, itf_name=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertInterfaceLuidT=
oGuid(&amp;luid, &amp;guid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgT=
oEventLog(M_ERR, L&quot;InterfaceIdString: &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      &quot;Failed to convert=
 itf &#39;%s&#39; LUID&quot;, itf_name);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto out;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *wdom=
ain =3D utf8to16(domain); /* utf8 to wide-char */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!wdomain)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (StringFromIID(&amp;guid, &amp;iid_str) !=
=3D S_OK)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return ERROR_OUTOFMEMORY;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;InterfaceIdStr=
ing: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
              &quot;Failed to convert itf &#39;%s&#39; IID&quot;, itf_name)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D ER=
ROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (wcslen(iid_=
str) + 1 &gt; len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D=
 ERROR_INVALID_PARAMETER;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        goto out;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* free undo list if previou=
sly set */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (lis=
ts)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wcsncpy(str,=
 iid_str, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (iid_str)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(RemoveL=
istItem(&amp;(*lists)[undo_domain], CmpWString, (void *)if_name));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        CoTaskMemFree(iid_st=
r);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    err =3D wmic_nicconfig_cmd(L&quot;SetDNSDomain&quot;, if_index, wdomai=
n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* Add to undo list if domain is no=
n-empty */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (err=
 =3D=3D 0 &amp;&amp; wdomain[0] &amp;&amp; lists)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Check for a valid search list in a certain key of the regi=
stry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Valid means that a string val=
ue &quot;SearchList&quot; exists and that it</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * contains one or more domains. We only check if =
the string contains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * a &#39;.&#39; character, but the main point is to prevent letting pass</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whitespace-only li=
sts, so that check is good enough for that</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * purpose.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param  key  HKEY in which to check for a valid search list</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return BOOL to indicate if a valid search list =
has been found</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+HasValidSearchList(HKEY key)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char data[64];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    DWORD size =3D sizeof(data);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err =3D RegGet=
ValueA(key, NULL, &quot;SearchList&quot;, RRF_RT_REG_SZ, NULL, (PBYTE)data,=
 &amp;size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!err || err =3D=3D ERROR_MORE_DATA)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        wchar_t *tmp_name =3D _wcsdup=
(if_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(!tmp_name || AddListItem(&amp;(*lists)[undo_domain], tmp_name))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        data[sizeof(data) - 1]=
 =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (strchr(data, &#39;.&#39;) !=3D NULL)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            free(tmp_n=
ame);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            err =
=3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return TRUE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return FALSE=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Find the registry key for storing the DNS domains for the VPN interf=
ace</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param  itf_name PCSTR that co=
ntains the alias name of the interface the domains</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *                  are related to. If this =
is NULL the interface probing is skipped.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param  gpol     PBOOL to indicate if the key retu=
rned is the group policy hive</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param  key      PHKEY in which the found registry key is retu=
rned in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate i=
f a search list is already present at the location.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         If the key returned is INVALID=
_HANDLE_VALUE, this indicates an</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *         unrecoverable error.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * The correct location to add them is where a non-empty &quot;Sear=
chList&quot; value exists,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * or in the interface configuration itself. However, the system-wid=
e and then the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * gr=
oup policy search lists overrule the previous one respectively, so we need =
to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * probe to find =
the effective list.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+GetDnsSearchListKey(PCST=
R itf_name, PBOOL gpol, PHKEY key)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 LSTATUS err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    *gpol =3D FALSE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Try the group policy search list *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegOpe=
nKeyExA(HKEY_LOCAL_MACHINE,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        &quot;SOFTWARE\\Policies\\Microsoft\\Window=
s NT\\DNSClient&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        0, KEY_ALL_ACCESS, key);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!err)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (HasValidSearchList(*key))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            *gpol =3D TRUE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return TRUE;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        RegCloseKey(*key);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Try the system-wide search list */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
&quot;System\\CurrentControlSet\\Services\\TCPIP\\Parameters&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        0, =
KEY_ALL_ACCESS, key);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (HasVal=
idSearchList(*key))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        RegClos=
eKey(*key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (itf_name)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* Always return the VPN interface key (if it e=
xists) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WC=
HAR iid[64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 DWORD iid_err =3D InterfaceIdString(itf_name, iid, _countof(iid));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!iid_err)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            HKEY itfs;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            err =3D RegOpenKeyEx=
A(HKEY_LOCAL_MACHINE,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                &quot;System\\CurrentControlSet\\Services=
\\TCPIP\\Parameters\\Interfaces&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                0, KEY_ALL_ACCESS, &amp;=
itfs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (!err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                e=
rr =3D RegOpenKeyExW(itfs, iid, 0, KEY_ALL_ACCESS, key);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                RegCloseKey(itfs);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (!er=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 return FALSE; /* No need to preserve the VPN itf search list */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>  =
       }</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    free(wdomain);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    *key =3D INVALID_HANDLE_VALUE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return FALSE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if a=
 initial list had already been created</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param  key      HKEY of the registry subkey to search in</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return BOOL to indicate if the initial list i=
s already present under key</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static B=
OOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+InitialSearchLis=
tExists(HKEY key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    err =3D RegGetValueA(key, NULL, &quot=
;InitialSearchList&quot;, RRF_RT_REG_SZ, NULL, NULL, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (err =3D=3D ERROR_FILE_NOT_FOUND)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return FALSE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;Init=
ialSearchListExists: &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                  &quot;failed to get InitialSearch=
List (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Prepar=
e DNS domain &quot;SearchList&quot; registry value, so additional</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * VPN domains can be added a=
nd its original state can be restored</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * in case the system cannot clean up regularly.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param  key      registry subkey to store =
the list in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m  list     string of comma separated domains to use as the list</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @return boolean to indicate whether the list=
 was stored successfully</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+StoreInitialDnsSear=
chList(HKEY key, PCWSTR list)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!list || wcslen(list) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      MsgToEventLog(M_ERR, TEXT(&quot;StoreInitialDnsSearchList: empty sear=
ch list&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (InitialSearchListExists(ke=
y))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* Initial list had al=
ready been stored */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    DWORD size =3D (wcslen(list=
) + 1) * sizeof(*list);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    LSTATUS err =3D RegSetValueExW(key, L&quot;InitialSearchList&quot;,=
 0, REG_SZ, (PBYTE)list, size);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        M=
sgToEventLog(M_ERR, TEXT(&quot;StoreInitialDnsSearchList: &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
    &quot;failed to set InitialSearchList value (%lu)&quot;), err);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Append domain suffixes to an existin=
g search list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  key         =
 HKEY the list is stored at</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param  have_list    BOOL to indicate if a search list already e=
xists</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  dom=
ains      domain suffixes as comma separated string</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return BOOL to indicate success or failure</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+AddDnsSearchDomains(HKEY key, BOOL have_list, PCWSTR do=
mains)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    WCHAR list[4096];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    DWORD size =3D sizeof(list);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (have_list)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        err =3D RegGetValueW(key, NULL, L&quot;Search=
List&quot;, RRF_RT_REG_SZ, NULL, list, &amp;size);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (err)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsSear=
chDomains: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                       &quot;could not get SearchList from =
registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return FALSE;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!S=
toreInitialDnsSearchList(key, list))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return FALSE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t l=
istlen =3D (size / sizeof(list[0])) - 1; /* returned size is in bytes */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t domlen =
=3D wcslen(domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (listlen + domlen + 2 &gt; _countof(list))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            MsgToEventLog(M_SYSERR, TEXT(&quot;Add=
DnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                         &quot;not enough space in lis=
t for search domains (len=3D%lu)&quot;),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                          domlen);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return FALSE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* Append to end of the search list */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        PWSTR pos =3D list + list=
len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *pos =
=3D &#39;,&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     wcsncpy(pos + 1, domains, domlen + 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wcsncpy=
(list, domains, wcslen(domains) + 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D (w=
cslen(list) + 1) * sizeof(list[0]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    err =3D RegSetValueExW(key, L&quot;SearchList&quot;, 0,=
 REG_SZ, (PBYTE)list, size);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgT=
oEventLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
 &quot;could not set SearchList to registry (%lu)&quot;), err);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Reset the DNS search list to its origi=
nal value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Looks for a &quot;Initia=
lSearchList&quot; value as the one to reset to.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * If it doesn&#39;t exists, resets to empty, e=
ffectively disabling it.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  k=
ey  HKEY of the location in the registry to reset</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return BOOL to indicate if something was reset</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ResetDnsSearchDomains(HKEY key)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    LSTATUS err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    BOOL ret =3D FALSE;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    WCHAR list[4096];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    DWORD size =3D sizeof(list);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    err =3D RegGetValueW(key, NULL, L&quot;InitialSearchList=
&quot;, RRF_RT_REG_SZ, NULL, list, &amp;size);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (err !=3D ERROR_FILE_NOT_FOUND)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            MsgToEventLog(M_SYSERR, TEXT(&quot;ResetDnsS=
earchDomains: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                         &quot;could not get InitialSearch=
List from registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D (wcslen(list)=
 + 1) * sizeof(list[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    err =3D RegSetValueExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (P=
BYTE)list, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M=
_SYSERR, TEXT(&quot;ResetDnsSearchDomains: &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                     &quot;co=
uld not set SearchList in registry (%lu)&quot;), err);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    RegDeleteValueA(key, &quot;InitialSearchList&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ret =3D TRUE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Remove domain suffixes from an existing search list<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param  key      HKEY the list is =
stored at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
 domains  domain suffixes to remove as comma separated string</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+RemoveDnsSearchDomains(HKEY key, PCWSTR domains)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    WCHAR list[4096];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    DWORD size =3D sizeof(list);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    err =3D RegGetValueW(key, NULL, L&quot;SearchList=
&quot;, RRF_RT_REG_SZ, NULL, list, &amp;size);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;RemoveDnsSearchDomains: &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                      &quot;could not get SearchList from registry (%lu)&qu=
ot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    PWSTR dst =3D wcsstr(list, domains);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dst)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;Remo=
veDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                  &quot;could not find domains in se=
arch list&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Cut out domains from list */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t domlen =3D =
wcslen(domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 PCWSTR src =3D dst + domlen;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Also remove the leading comma, if there is one */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dst =3D dst &gt; list ? =
dst - 1 : dst;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
memmove(dst, src, domlen);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Now c=
heck if the shortened list equals the initial search list */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    WCHAR initial[4096];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D sizeof(initial);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegGetV=
alueW(key, NULL, L&quot;InitialSearchList&quot;, RRF_RT_REG_SZ, NULL, initi=
al, &amp;size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_S=
YSERR, TEXT(&quot;RemoveDnsSearchDomains: &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                     &quot;cou=
ld not get InitialSearchList from registry (%lu)&quot;), err);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* If the search list is back to its initial state reset it */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (wcsncmp(list, =
initial, wcslen(list)) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       ResetDnsSearchDomains(key);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        size =3D (wcslen=
(list) + 1) * sizeof(list[0]);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        err =3D RegSetValueExW(key, L&quot;SearchList&quot;, 0, =
REG_SZ, (PBYTE)list, size);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       MsgToEventLog(M_SYSERR, TEXT(&quot;RemoveDnsSearchDomains: &quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                   &quot;could not set SearchList in registry (%lu)&quot;),=
 err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Removes DNS =
domains from a search list they were previously added to</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param undo_data     pointer to dns_domains_undo_dat=
a_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+UndoDnsSearchDomains(dns_domains_undo_da=
ta_t *undo_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL gpol;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    HKEY dns_searchlist_ke=
y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    GetDnsSearchL=
istKey(undo_data-&gt;itf_name, &amp;gpol, &amp;dns_searchlist_key);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dns_searchlist_key =
!=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 RemoveDnsSearchDomains(dns_searchlist_key, undo_data-&gt;domains);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        RegCloseKey(dns_sea=
rchlist_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  ApplyDnsSettings(gpol);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(=
undo_data-&gt;domains);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        undo_data-&gt;domains =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Add or remove DNS search domains</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param  itf_name   alias name of the i=
nterface the domains are set for</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param  domains    a comma separated list of domain name su=
ffixes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  gp=
ol       PBOOL to indicate if group policy values were modified</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param  lists      pointer t=
o the undo lists</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR =
on success, an error status code otherwise</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * If a SearchList is present in the registry already, the domains ar=
e added</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to that l=
ist. Otherwise the domains are added to the VPN interface specific list.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A group policy sear=
ch list takes precedence over a system-wide list, and that one</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * itself takes precedence over =
interface specific ones.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This func=
tion will remove previously set domains if the domains parameter</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * is NULL or empty.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * The gpol value is only valid if the functio=
n returns no error. In the error</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * case nothing is changed.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Se=
tDnsSearchDomains(PCSTR itf_name, PCSTR domains, PBOOL gpol, undo_lists_t *=
lists)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    DWORD err =3D ERROR_OUTOFME=
MORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    HKEY list_key;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    BOOL have_list =3D GetDnsSearc=
hListKey(itf_name, gpol, &amp;list_key);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (list_key =3D=3D INVALID_HANDLE_VALUE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quo=
t;SetDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                     &quot;could not get search l=
ist registry key&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return ERROR_FILE_NOT_FOUND;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Rem=
ove previously installed search domains */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dns_domains_undo_data_t *undo_data =3D RemoveLis=
tItem(&amp;(*lists)[undo_domains], CmpAny, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (undo_data)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        RemoveDnsSearchDomains(list_key, undo_data-&gt;domai=
ns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(un=
do_data-&gt;domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        free(undo_data);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        undo_data =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If there ar=
e search domains, add them */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (domains &amp;&amp; *domains)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        wchar_t *wide_domains =3D utf8to16(domains); /* utf8 t=
o wide-char */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!wide_domains)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        undo_data =3D malloc(sizeof=
(*undo_data));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!undo_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 free(wide_domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            wide_domains =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            goto out;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        strncpy(undo_data-&gt;itf_name, itf_name, sizeof(undo_data-=
&gt;itf_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    undo_data-&gt;domains =3D wide_domains;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (AddDnsSearchDomains(list_key, have_list, wide_domains) =3D=
=3D FALSE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  || AddListItem(&amp;(*lists)[undo_domains], undo_data) !=3D NO_ERROR)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            RemoveDnsSearchDomain=
s(list_key, wide_domains);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            free(wide_domains);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            free(undo_data);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            undo_data =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            goto out;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    err =3D NO_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    RegCloseKey(list_key);</spa=
n><br><span>     return err;</span><br><span> }</span><br><span> </span><br=
><span>@@ -1315,11 +1853,13 @@</span><br><span> </span><br><span>     if (m=
sg-&gt;header.type =3D=3D msg_del_dns_cfg)</span><br><span>     {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        BOOL gpol =3D FALSE;<=
/span><br><span>         if (msg-&gt;domains[0])</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* settin=
g an empty domain removes any previous value */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            err =3D SetDNSDomain(wide_name, &quot=
;&quot;, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         /* setting an empty domain list removes any previous value */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            err =3D SetD=
nsSearchDomains(msg-&gt;iface.name, NULL, &amp;gpol, lists);</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 ApplyDnsSettings(gpol);</span><br><span>         goto out;  /* job done */=
</span><br><span>     }</span><br><span> </span><br><span>@@ -1357,10 +1897=
,12 @@</span><br><span>         }</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL gpol =3D FA=
LSE;</span><br><span>     if (msg-&gt;domains[0])</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D SetDNSDo=
main(wide_name, msg-&gt;domains, lists);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        err =3D SetDnsSearchDomains(msg-&gt;iface.name=
, msg-&gt;domains, &amp;gpol, lists);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ApplyDnsSettings(gpol);</span>=
<br><span> </span><br><span> out:</span><br><span>     free(wide_name);</sp=
an><br><span>@@ -1751,12 +2293,14 @@</span><br><span>                     D=
eleteDNS(AF_INET6, item-&gt;data);</span><br><span>                     bre=
ak;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                case undo_wins:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    netsh_wins_cmd(L&quot;delete&quot;, item-&gt;=
data, NULL);</span><br><span>                     break;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                case u=
ndo_domain:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          SetDNSDomain(item-&gt;data, &quot;&quot;, NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                case undo_domains:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    U=
ndoDnsSearchDomains(item-&gt;data);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    break;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                case undo_wins:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    netsh_wins_cmd(L&quot;delete&quot;, ite=
m-&gt;data, NULL);</span><br><span>                     break;</span><br><s=
pan> </span><br><span>                 case wfp_block:</span><br><span>@@ -=
2260,6 +2804,34 @@</span><br><span>     ServiceStartInteractive(dwArgc, lps=
zArgv);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Clean up remains of previous sessions in registry. These remain=
s can</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * happen with=
 unclean shutdowns or crashes and would interfere with</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * normal operation of the system with a=
nd without active tunnels.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CleanupRegistry()=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    HKEY key;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD changed =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Clean up leftover DNS search list fragments */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL gpol_list;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    GetDnsSearchListK=
ey(NULL, &amp;gpol_list, &amp;key);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (key !=3D INVALID_HANDLE_VALUE)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (ResetDnsSearchDomains(key))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            changed++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        RegCloseKey(key);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (changed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ApplyDnsSett=
ings(gpol_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
> </span><br><span> VOID WINAPI</span><br><span> ServiceStartInteractive(DW=
ORD dwArgc, LPTSTR *lpszArgv)</span><br><span>@@ -2283,6 +2855,9 @@</span><=
br><span>     status.dwWaitHint =3D 3000;</span><br><span>     ReportStatus=
ToSCMgr(service, &amp;status);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Clean up potentially left over registry=
 values */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Clean=
upRegistry();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     /* Read info from registry in key HKLM\SOFTWARE\OpenVPN */<=
/span><br><span>     error =3D GetOpenvpnSettings(&amp;settings);</span><br=
><span>     if (error !=3D ERROR_SUCCESS)</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=
=3Demail">change 824</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--rQI83nbIwcI=--

