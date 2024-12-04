From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 4 Dec 2024 12:43:45 +0000
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7a8fea021d6b4c1cea79d7fc28ab2233b08a64af-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yq2B9u8fXNo="; charset=UTF-8
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

--Yq2B9u8fXNo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail

to review the following change.


Change subject: dns: support multiple domains without DHCP
......................................................................

dns: support multiple domains without DHCP

Instead of using wmic on Windows to set one (the first) DNS domain,
modify the registry directly and let the resolver know that something
changed.

This fixes that more than one search domain suffix could only be applied
when DHCP and the tap driver was used. Now this works as well in netsh
mode with the interactive service.

Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/tun.c
M src/openvpnserv/interactive.c
2 files changed, 708 insertions(+), 110 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/824/1

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
=20
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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Yq2B9u8fXNo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dns: support multiple domains without DHCP<br><br>Instead of =
using wmic on Windows to set one (the first) DNS domain,<br>modify the regi=
stry directly and let the resolver know that something<br>changed.<br><br>T=
his fixes that more than one search domain suffix could only be applied<br>=
when DHCP and the tap driver was used. Now this works as well in netsh<br>m=
ode with the interactive service.<br><br>Change-Id: Icaffbfa6b2e8efa2bd24a0=
5537cb74b15f4fed96<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br=
>---<br>M src/openvpn/tun.c<br>M src/openvpnserv/interactive.c<br>2 files c=
hanged, 708 insertions(+), 110 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/24/824/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 1e67d37..53f3ebc 100=
644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openv=
pn/tun.c</span><br><span>@@ -183,9 +183,10 @@</span><br><span> {</span><br>=
<span>     ack_message_t ack;</span><br><span>     struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE pi=
pe =3D tt-&gt;options.msg_channel;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct tuntap_options *o =3D &amp;tt-&gt;options;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!tt-&gt;options.domain) /* no  domain to add or delete */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* no domains to add or delet=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;=
domain &amp;&amp; !o-&gt;domain_search_list[0])</span><br><span>     {</spa=
n><br><span>         goto out;</span><br><span>     }</span><br><span>@@ -2=
03,28 +204,50 @@</span><br><span>         .addr_len =3D 0       /* add/dele=
te only the domain, not DNS servers */</span><br><span>     };</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* interfa=
ce name is required */</span><br><span>     strncpynt(dns.iface.name, tt-&g=
t;actual_name, sizeof(dns.iface.name));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    strncpynt(dns.domains, tt-&gt;options.domain, sizeof(=
dns.domains));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
truncation of domain name is not checked as it can&#39;t happen</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * with 512 bytes room in dns=
.domains.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    dns.iface.name[sizeo=
f(dns.iface.name) - 1] =3D &#39;\0&#39;;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;%s dns domain on =
&#39;%s&#39; (if_index =3D %d) using service&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* only use domain when there are no =
search domains */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (o-&gt;domain &amp;&amp; !o-&gt;domain_search_list[0])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        strncpynt(dns.domains, o-&gt;domain, size=
of(dns.domains));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Create a comma separated lis=
t of search domains */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int i =3D 0; i &lt; N_SEARCH_LIST_LEN &amp;&amp; o-&gt;domain_s=
earch_list[i]; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t=
 dstlen =3D strlen(dns.domains);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        size_t srclen =3D strlen(o-&gt;domain_search_list[i]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t extr=
a =3D dstlen ? 2 : 1; /* space for comma and NUL */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (dstlen + srclen + extra &gt; =
sizeof(dns.domains))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_WARN, &quot;DNS search domains sent to service truncated to %d&quo=
t;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dstlen)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            dns.domains[dstlen++]=
 =3D &#39;,&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strn=
cpynt(dns.domains + dstlen, o-&gt;domain_search_list[i], srclen);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_LOW, &quot;%s DNS domains on &#39;%s&#39; (if_inde=
x =3D %d) using service&quot;,</span><br><span>         (add ? &quot;Settin=
g&quot; : &quot;Deleting&quot;), dns.iface.name, dns.iface.index);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!send_msg_iservice(pip=
e, &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!send_msg_iservice(o-&gt;msg_chan=
nel, &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&quot;))</span><br><span>   =
  {</span><br><span>         goto out;</span><br><span>     }</span><br><sp=
an> </span><br><span>     if (ack.error_number !=3D NO_ERROR)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_WARN, &quot;TUN: %s dns domain failed using service: %s [status=3D%u if_n=
ame=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_WARN, &quot;TUN: %s DNS domains failed using service: %s [status=
=3D%u if_name=3D%s]&quot;,</span><br><span>             (add ? &quot;adding=
&quot; : &quot;deleting&quot;), strerror_win32(ack.error_number, &amp;gc),<=
/span><br><span>             ack.error_number, dns.iface.name);</span><br><=
span>         goto out;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_INFO, &quot;DNS domain=
 %s using service&quot;, (add ? &quot;set&quot; : &quot;deleted&quot;));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;=
DNS domains %s using service&quot;, (add ? &quot;set&quot; : &quot;deleted&=
quot;));</span><br><span> </span><br><span> out:</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span>@@ -1719,7 +1742,7 @@</span><br><span>     arg=
v_free(&amp;argv);</span><br><span>     gc_free(&amp;gc);</span><br><span> =
#endif /* if defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-       /* Empty for _WIN32 and all other unixoid platforms =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Empty for =
_WIN32 and all other unixoid platforms */</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span>@@ -1745,7 +1768,7 @@</spa=
n><br><span>     argv_free(&amp;argv);</span><br><span>     gc_free(&amp;gc=
);</span><br><span> #endif /* if defined(TARGET_LINUX) */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-       /* Empty for _WIN32 and all othe=
r unixoid platforms */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Empty for _WIN32 and all other unixoid platforms */</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span>diff --git a/=
src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><sp=
an>index 67f5bbc..cad8b02 100644</span><br><span>--- a/src/openvpnserv/inte=
ractive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><sp=
an>@@ -88,7 +88,7 @@</span><br><span>     wfp_block,</span><br><span>     u=
ndo_dns4,</span><br><span>     undo_dns6,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    undo_domain,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    undo_domains,</span><br><span>     undo_ring_buffer,</=
span><br><span>     undo_wins,</span><br><span>     _undo_type_max</span><b=
r><span>@@ -103,6 +103,11 @@</span><br><span> } wfp_block_data_t;</span><br=
><span> </span><br><span> typedef struct {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char itf_name[256];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    PWSTR domains;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+} dns_domains_undo_data_t;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+typedef struct {</span><br><span>     struct tun_ring *send_=
ring;</span><br><span>     struct tun_ring *receive_ring;</span><br><span> =
} ring_buffer_maps_t;</span><br><span>@@ -565,24 +570,6 @@</span><br><span>=
     return status;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-ConvertInterfaceNameToIndex(const wchar_t *ifname=
, NET_IFINDEX *index)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NET_LUID luid;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD err;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    err =3D ConvertInterfaceAliasToLuid(ifname, &am=
p;luid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (err =
=3D=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D =
ConvertInterfaceLuidToIndex(&amp;luid, index);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (err !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        MsgToEventLog(M_ERR, L&quot;Failed to find interface index for &=
lt;%ls&gt;&quot;, ifname);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static BOOL</span><=
br><span> CmpAddress(LPVOID item, LPVOID address)</span><br><span> {</span>=
<br><span>@@ -1152,52 +1139,6 @@</span><br><span>     return err;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Run comma=
nd: wmic nicconfig (InterfaceIndex=3D$if_index) call $action ($data)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  if_index    &quot=
;index of interface&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param  action      e.g., &quot;SetDNSDomain&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * @param  data        data if required=
 for action</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        =
             - a single word for SetDNSDomain, empty or NULL to delete</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *                     - c=
omma separated values for a list</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wmic_nicconfig_c=
md(const wchar_t *action, const NET_IFINDEX if_index,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   const wchar_t *data)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    DWORD err =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    wchar_t argv0[MAX_PATH];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *cmdline =3D NULL;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int timeout =3D 10000; =
/* in msec */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(argv0, _countof(=
argv0), L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;wbem\\wmic.exe&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const wchar_t *fmt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* comma separated list must be=
 enclosed in parenthesis */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (data &amp;&amp; wcschr(data, L&#39;,&#39;))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        fmt =3D L&quot;wmic nicconfig where (InterfaceI=
ndex=3D%ld) call %ls (%ls)&quot;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        fmt =3D L&quot;wmic nicco=
nfig where (InterfaceIndex=3D%ld) call %ls \&quot;%ls\&quot;&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + 20 + wcslen(action) /* max=
 20 for ifindex */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                   + (data ? wcslen(data) + 1 : 1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    cmdline =3D malloc(ncmdline*sizeof(wcha=
r_t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!cmdlin=
e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return ERROR_OUTOFMEMORY;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    swprintf(cmdline, ncmdline, fmt, if_index, action,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-             data ? data : =
L&quot;&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    er=
r =3D ExecCommand(argv0, cmdline, timeout);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    free(cmdline);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Delete =
all IPv4 or IPv6 dns servers for an interface */</span><br><span> static DW=
ORD</span><br><span> DeleteDNS(short family, wchar_t *if_name)</span><br><s=
pan>@@ -1221,50 +1162,647 @@</span><br><span> }</span><br><span> </span><br=
><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Set int=
erface specific DNS domain suffix</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * @param  if_name    name of the interface</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param  domain     a single domain nam=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  lists    =
  pointer to the undo lists. If NULL</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *                    undo lists are not altered.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Will delete the currently set=
 value if domain is empty.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Signal the DNS resolver (and others potentially) to reload the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * group policy (DNS) =
settings on 32 bit Windows systems</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return BOOL to indicate if the reload was initiated</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ApplyGpolSettings32()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ty=
pedef NTSTATUS (__stdcall *publish_fn_t)(</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        DWORD StateNameLo,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        DWORD StateNameHi,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        DWORD TypeId,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        DWORD Buffer,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        DWORD Length,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        DWORD ExplicitScope);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    publish_fn_t RtlPub=
lishWnfStateData;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0D891E2A;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const DWORD WNF_GPOL_SYSTEM_CHANGE=
S_LO =3D 0xA3BC0875;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HMODULE ntdll =
=3D LoadLibraryA(&quot;ntdll.dll&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (ntdll =3D=3D NULL)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    RtlPublishWnf=
StateData =3D (publish_fn_t) GetProcAddress(ntdll, &quot;RtlPublishWnfState=
Data&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(RtlPublishWnfStateData =3D=3D NULL)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (RtlPublishWnfStateDa=
ta(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM_CHANGES_HI, 0, 0, 0, 0) !=3D=
 ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return FAL=
SE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return TRUE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Signal the DNS resolver (an=
d others potentially) to reload the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * group policy (DNS) settings on 64 bit Windows systems</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate if the relo=
ad was initiated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ApplyGpolSettings64()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    typedef NTSTATUS (*publish_fn_t)(</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        INT64 StateName=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        INT64 Type=
Id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        INT64 Bu=
ffer,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsign=
ed int Length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   INT64 ExplicitScope);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    publish_fn_t RtlPublishWnfStateData;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const INT64 WNF_GPOL_SYSTEM_CHANGES =3D 0x0D8=
91E2AA3BC0875;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    HMODULE ntdll =3D Lo=
adLibraryA(&quot;ntdll.dll&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (ntdll =3D=3D NULL)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    RtlPublishWnfStateD=
ata =3D (publish_fn_t) GetProcAddress(ntdll, &quot;RtlPublishWnfStateData&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (RtlPu=
blishWnfStateData =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (RtlPublishWnfStateData(WNF=
_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) !=3D ERROR_SUCCESS)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Signal the DNS resolver (and others potentially) to reload the g=
roup policy (DNS) settings</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 BOOL to indicate if the reload was initiated</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ApplyGpolSettings()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SYSTEM_INFO =
si;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    GetSystemInf=
o(&amp;si);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t BOOL win_32bit =3D si.wProcessorArchitecture =3D=3D PROCESSOR_ARCHITECTUR=
E_INTEL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
win_32bit ? ApplyGpolSettings32() : ApplyGpolSettings64();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Signal the =
DNS resolver to reload its settings</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param apply_gpol    BOOL reload setting from group policy hives as well<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate if the re=
load was initiated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ApplyDnsSettings(BOOL app=
ly_gpol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL res =3D FALSE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    SC_HANDLE scm =3D INV=
ALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SC_HANDLE dnssvc =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (apply_gpol &amp;&amp; ApplyGpolSettings() =3D=3D FALSE)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quo=
t;ApplyDnsSettings: sending GPOL notification failed&quot;));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    scm =3D OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (scm =3D=3D NULL)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT=
(&quot;ApplyDnsSettings: &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                  &quot;OpenSCManager call fail=
ed (%lu)&quot;), GetLastError());</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dnssvc =3D OpenSe=
rviceA(scm, &quot;Dnscache&quot;, SERVICE_PAUSE_CONTINUE);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (dnssvc =3D=3D NULL)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;A=
pplyDnsSettings: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                  &quot;OpenService call failed (%lu)&q=
uot;), GetLastError());</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SERVICE_STATUS status;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ControlService(d=
nssvc, SERVICE_CONTROL_PARAMCHANGE, &amp;status) =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSe=
ttings: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                             &quot;ControlService call failed (%lu)&quot;),=
 GetLastError());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    res =3D TRUE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CloseServiceHandle(dnssvc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    CloseServiceHandle(scm);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return res;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Get the string interface UUID (=
with braces) for an interface alias name</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param  itf_name   the interface alias name</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param  str        pointer to the buffer =
the wide UUID is returned in</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param  len        size of the str buffer in characters</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR on success, or the Windo=
ws error code for the failure</span><br><span>  */</span><br><span> static =
DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SetDNSDomain(con=
st wchar_t *if_name, const char *domain, undo_lists_t *lists)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+InterfaceIdString(PCSTR itf_name,=
 PWSTR str, size_t len)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    NET_IFINDEX if_index;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    DWORD err;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    GUID guid;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    NET_LUID luid;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    PWSTR iid_str =3D NULL;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    DWORD err  =3D ConvertInterface=
NameToIndex(if_name, &amp;if_index);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (err !=3D ERROR_SUCCESS)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    err =3D InterfaceLuid(itf_name, &amp;luid);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MsgToEventLog(M_ERR, L&quot;InterfaceIdString: &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                      &quot;failed to c=
onvert itf alias &#39;%s&#39;&quot;, itf_name);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    err =3D ConvertInterfaceLuidToGuid(&amp;luid, &amp;guid);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;Inter=
faceIdString: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                      &quot;Failed to convert itf &#39;%s&#39; LUID&quot;,=
 itf_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto out;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    wchar_t *wdomain =3D utf8to16(domain); /* =
utf8 to wide-char */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!wdomain)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (StringFromIID(&amp;guid, &amp;iid_str) !=3D S_OK)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return ERRO=
R_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   MsgToEventLog(M_ERR, L&quot;InterfaceIdString: &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                      &quot;Failed to =
convert itf &#39;%s&#39; IID&quot;, itf_name);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        err =3D ERROR_OUTOFMEMORY;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (wcslen(iid_str) + 1 &gt; len)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        err =3D ERROR_INVALID_PARAMETER;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* free undo list if previously set */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (lists)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    wcsncpy(str, iid_str, len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (iid_str)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        free(RemoveListItem(&amp;(*lists)[undo_dom=
ain], CmpWString, (void *)if_name));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        CoTaskMemFree(iid_str);</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D wmic_nicconfig_cm=
d(L&quot;SetDNSDomain&quot;, if_index, wdomain);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* Add to undo list if domain is non-empty */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (err =3D=3D 0 &amp;&amp; wdomain[0=
] &amp;&amp; lists)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check for a v=
alid search list in a certain key of the registry</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Valid means that a string value &quot;SearchList&quot; exis=
ts and that it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * co=
ntains one or more domains. We only check if the string contains</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * a &#39;.&#39; character, bu=
t the main point is to prevent letting pass</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * whitespace-only lists, so that check is good eno=
ugh for that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * purp=
ose.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param  key  HKEY in which to=
 check for a valid search list</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn BOOL to indicate if a valid search list has been found</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+HasValidSearchList(HKEY key)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char data[64];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    DWORD size =3D sizeof(data);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    LSTATUS err =3D RegGetValueA(key, NULL, &quot;Search=
List&quot;, RRF_RT_REG_SZ, NULL, (PBYTE)data, &amp;size);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!err || err =3D=3D ERROR_MORE=
_DATA)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        wchar_t *tmp_name =3D _wcsdup(if_name);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (!tmp_name || AddListItem(&amp=
;(*lists)[undo_domain], tmp_name))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        data[sizeof(data) - 1] =3D &#39;\0&#39;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (strchr(data, &#39;.=
&#39;) !=3D NULL)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            free(tmp_name);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            err =3D ERROR_OUTOFMEMORY;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return TRUE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return FALSE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Find the registry key f=
or storing the DNS domains for the VPN interface</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param  itf_name PCSTR that contains the alias name of the i=
nterface the domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *                  are related to. If this is NULL the interface probing =
is skipped.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m  gpol     PBOOL to indicate if the key returned is the group policy hive<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  key      =
PHKEY in which the found registry key is returned in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return BOOL to indicate if a search list is already pr=
esent at the location.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *         If the key returned is INVALID_HANDLE_VALUE, this indicates a=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         unrecov=
erable error.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The correct location=
 to add them is where a non-empty &quot;SearchList&quot; value exists,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * or in the interface c=
onfiguration itself. However, the system-wide and then the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * group policy search lists overrul=
e the previous one respectively, so we need to</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * probe to find the effective list.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+GetDnsSearchListKey(PCSTR itf_name, PBOOL gpol, PHKEY k=
ey)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    *gpol =3D FALSE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Try the group policy search list */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        &=
quot;SOFTWARE\\Policies\\Microsoft\\Windows NT\\DNSClient&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        0, KEY=
_ALL_ACCESS, key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (HasValidS=
earchList(*key))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *=
gpol =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Re=
gCloseKey(*key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Try the system-wide search li=
st */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D Re=
gOpenKeyExA(HKEY_LOCAL_MACHINE,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        &quot;System\\CurrentControlSet\\Servic=
es\\TCPIP\\Parameters&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        0, KEY_ALL_ACCESS, key);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!err)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (HasValidSearchList(*key))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return TRUE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        RegCloseKey(*key);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (itf_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Always =
return the VPN interface key (if it exists) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        WCHAR iid[64];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        DWORD iid_err =3D InterfaceIdString(i=
tf_name, iid, _countof(iid));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (!iid_err)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            HKEY itfs;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                &quo=
t;System\\CurrentControlSet\\Services\\TCPIP\\Parameters\\Interfaces&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
             0, KEY_ALL_ACCESS, &amp;itfs);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (!err)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                err =3D RegOpenKeyExW(itfs, iid, 0, KEY=
_ALL_ACCESS, key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               RegCloseKey(itfs);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                if (!err)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    return FALSE; /* No need to preserve =
the VPN itf search list */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span>         }</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(w=
domain);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *key =
=3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Check if a initial list had already been creat=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param  key      HKEY of the re=
gistry subkey to search in</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 BOOL to indicate if the initial list is already present under key</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+InitialSearchListExists(HKEY key)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    LSTATUS err;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 err =3D RegGetValueA(key, NULL, &quot;InitialSearchList&quot;, RRF_RT_REG_=
SZ, NULL, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (err =
=3D=3D ERROR_FILE_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   MsgToEventLog(M_ERR, TEXT(&quot;InitialSearchListExists: &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
      &quot;failed to get InitialSearchList (%lu)&quot;), err);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Prepare DNS domain &quot;SearchList&quot; =
registry value, so additional</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * VPN domains can be added and its original state can be restore=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in case the sys=
tem cannot clean up regularly.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram  key      registry subkey to store the list in</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param  list     string of comma separate=
d domains to use as the list</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn boolean to indicate whether the list was stored successfully</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+StoreInitialDnsSearchList(HKEY key, PCWSTR list)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!list || wcslen(list) =3D=3D 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quo=
t;StoreInitialDnsSearchList: empty search list&quot;));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (InitialSearchListExists(key))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* Initial list had already been stored */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return TRUE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    DWORD size =3D (wcslen(list) + 1) * sizeof(*list);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err =3D RegSetValueE=
xW(key, L&quot;InitialSearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;Store=
InitialDnsSearchList: &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                  &quot;failed to set InitialSearc=
hList value (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Append domain suffixes to an existing search list</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param  key          HKEY the list is stored at</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  have_list    BOO=
L to indicate if a search list already exists</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param  domains      domain suffixes as comma =
separated string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to i=
ndicate success or failure</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BO=
OL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AddDnsSearchDomai=
ns(HKEY key, BOOL have_list, PCWSTR domains)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    LSTATUS err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    WCHAR list[4096];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    DWORD size =3D sizeof(list);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (have_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D=
 RegGetValueW(key, NULL, L&quot;SearchList&quot;, RRF_RT_REG_SZ, NULL, list=
, &amp;size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            MsgToEv=
entLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
  &quot;could not get SearchList from registry (%lu)&quot;), err);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return FALSE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!StoreInitialDnsSearchList(key, list))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return FALSE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        size_t listlen =3D (size / sizeof(list[0])) -=
 1; /* returned size is in bytes */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        size_t domlen =3D wcslen(domains);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (listlen + domlen + 2 &gt=
; _countof(list))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
         &quot;not enough space in list for search domains (len=3D%lu)&quot=
;),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          domlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Append to end=
 of the search list */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        PWSTR pos =3D list + listlen;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        *pos =3D &#39;,&#39;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        wcsncpy(pos + 1, domains, domlen + 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        wcsncpy(list, domains, wcslen(domains) + 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    size =3D (wcslen(list) + 1) * sizeof(list[0]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegSetValueE=
xW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsSea=
rchDomains: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                    &quot;could not set SearchList to regis=
try (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reset=
 the DNS search list to its original value</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Looks for a &quot;InitialSearchList&quot; value as the one to rese=
t to.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If it doesn=
&#39;t exists, resets to empty, effectively disabling it.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param  key  HKEY of the location in the registry t=
o reset</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate i=
f something was reset</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ResetDnsSearchDomains(=
HKEY key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =3D FALSE;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR list[4096];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD size =3D sizeof=
(list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegGetValueW(key, N=
ULL, L&quot;InitialSearchList&quot;, RRF_RT_REG_SZ, NULL, list, &amp;size);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (err !=3D ERROR_FILE_NOT_FOUN=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            MsgToEventLog(M=
_SYSERR, TEXT(&quot;ResetDnsSearchDomains: &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                         &quo=
t;could not get InitialSearchList from registry (%lu)&quot;), err);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size =3D (wcslen(list) + 1) * sizeof(list[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    err =3D RegSetValueExW(key, L&quot;Se=
archList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;ResetDnsSearchDomains: &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                     &quot;could not set SearchList in registry (%lu)&quot;=
), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        got=
o out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    RegDeleteValueA(key, &quot;InitialSearchLi=
st&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove domain suffixes =
from an existing search list</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m  key      HKEY the list is stored at</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param  domains  domain suffixes to remove as comma s=
eparated string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+RemoveDnsSearchDomains(HKEY =
key, PCWSTR domains)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR list[4096]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD size =3D=
 sizeof(list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegGetValueW=
(key, NULL, L&quot;SearchList&quot;, RRF_RT_REG_SZ, NULL, list, &amp;size);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&qu=
ot;RemoveDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                     &quot;could not get Sear=
chList from registry (%lu)&quot;), err);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR dst =
=3D wcsstr(list, domains);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!dst)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgTo=
EventLog(M_ERR, TEXT(&quot;RemoveDnsSearchDomains: &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                  &qu=
ot;could not find domains in search list&quot;));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Cut out domains from list */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    size_t domlen =3D wcslen(domains);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    PCWSTR src =3D dst + domlen;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Also remove the leading com=
ma, if there is one */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    dst =3D dst &gt; list ? dst - 1 : dst;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    wmemmove(dst, src, domlen);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Now check if the shortened list equals the initia=
l search list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 WCHAR initial[4096];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size =3D sizeof(initial);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    err =3D RegGetValueW(key, NULL, L&quot;InitialSearchList&qu=
ot;, RRF_RT_REG_SZ, NULL, initial, &amp;size);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;RemoveDnsSearchDomains: &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                      &quot;could not get InitialSearchList from registry (=
%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* If the search list is back to i=
ts initial state reset it */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (wcsncmp(list, initial, wcslen(list)) =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ResetDnsSearchDomains(key);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        size =3D (wcslen(list) + 1) * sizeof(list[0]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        err =3D RegSetValueExW(=
key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (err)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            MsgToEventLog(M_SYSERR, TEXT(&quot;=
RemoveDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                         &quot;could not set Sea=
rchList in registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Removes DNS domains from a search list they were previ=
ously added to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param undo_data   =
  pointer to dns_domains_undo_data_t</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+UndoDns=
SearchDomains(dns_domains_undo_data_t *undo_data)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    BOOL gpol;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    HKEY dns_searchlist_key;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    GetDnsSearchListKey(undo_data-&gt;itf_name, &amp;gpol, =
&amp;dns_searchlist_key);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (dns_searchlist_key !=3D INVALID_HANDLE_VALUE)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        RemoveDnsSearchDomains(dns_searchlist_key=
, undo_data-&gt;domains);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        RegCloseKey(dns_searchlist_key);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        ApplyDnsSettings(gpol);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        free(undo_data-&gt;domains);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        undo_data-&gt;domains =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Add or =
remove DNS search domains</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  =
itf_name   alias name of the interface the domains are set for</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param  domains    a comma se=
parated list of domain name suffixes</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param  gpol       PBOOL to indicate if group policy va=
lues were modified</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param  lists      pointer to the undo lists</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return NO_ERROR on success, an error status code otherwise</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * If a SearchList is present in the re=
gistry already, the domains are added</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * to that list. Otherwise the domains are added to the V=
PN interface specific list.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * A group policy search list takes precedence over a system-wide l=
ist, and that one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 itself takes precedence over interface specific ones.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * This function will remove previously set domains if th=
e domains parameter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * is NULL or empty.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The gpol valu=
e is only valid if the function returns no error. In the error</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * case nothing is changed.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+SetDnsSearchDomains(PCSTR itf_name, PCSTR domai=
ns, PBOOL gpol, undo_lists_t *lists)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   DWORD err =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 HKEY list_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
BOOL have_list =3D GetDnsSearchListKey(itf_name, gpol, &amp;list_key);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (list_key =3D=3D =
INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgT=
oEventLog(M_SYSERR, TEXT(&quot;SetDnsSearchDomains: &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
 &quot;could not get search list registry key&quot;));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return ERROR_FILE_NOT_FOUND;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Remove previously installed search domains */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    dns_domains_undo_da=
ta_t *undo_data =3D RemoveListItem(&amp;(*lists)[undo_domains], CmpAny, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (undo_dat=
a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        RemoveDnsSearchDomains(=
list_key, undo_data-&gt;domains);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        free(undo_data-&gt;domains);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        free(undo_data);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        undo_data =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* If there are search domains, add them */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (domains &amp;&amp; *domains)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        wchar_t *wide_domains =3D=
 utf8to16(domains); /* utf8 to wide-char */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!wide_domains)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            goto out;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  undo_data =3D malloc(sizeof(*undo_data));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!undo_data)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            free(wide_domains);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            wide_domains =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            goto out;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        strncpy(undo_data-&gt;itf_name=
, itf_name, sizeof(undo_data-&gt;itf_name));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        undo_data-&gt;domains =3D wide_domains;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (AddDnsSearchDomains(list_key,=
 have_list, wide_domains) =3D=3D FALSE</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            || AddListItem(&amp;(*lists)[undo_domains], =
undo_data) !=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        RemoveDnsSearchDomains(list_key, wide_domains);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            free(wide_domains);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            free(undo_data)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            undo_d=
ata =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    err =3D NO_ERROR;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
RegCloseKey(list_key);</span><br><span>     return err;</span><br><span> }<=
/span><br><span> </span><br><span>@@ -1315,11 +1853,13 @@</span><br><span> =
</span><br><span>     if (msg-&gt;header.type =3D=3D msg_del_dns_cfg)</span=
><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      BOOL gpol =3D FALSE;</span><br><span>         if (msg-&gt;domains[0])=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            /* setting an empty domain removes any previous value */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            err =3D Se=
tDNSDomain(wide_name, &quot;&quot;, lists);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* setting an empty domain list removes=
 any previous value */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            err =3D SetDnsSearchDomains(msg-&gt;iface.name, NULL, &amp;g=
pol, lists);</span><br><span>         }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ApplyDnsSettings(gpol);</span><br><span>       =
  goto out;  /* job done */</span><br><span>     }</span><br><span> </span>=
<br><span>@@ -1357,10 +1897,12 @@</span><br><span>         }</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    BOOL gpol =3D FALSE;</span><br><span>     if (msg-&gt;domains[0]=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        err =3D SetDNSDomain(wide_name, msg-&gt;domains, lists);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D SetDnsSearc=
hDomains(msg-&gt;iface.name, msg-&gt;domains, &amp;gpol, lists);</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    App=
lyDnsSettings(gpol);</span><br><span> </span><br><span> out:</span><br><spa=
n>     free(wide_name);</span><br><span>@@ -1751,12 +2293,14 @@</span><br><=
span>                     DeleteDNS(AF_INET6, item-&gt;data);</span><br><sp=
an>                     break;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                case undo_wins:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    netsh_wins_cmd(L&q=
uot;delete&quot;, item-&gt;data, NULL);</span><br><span>                   =
  break;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                case undo_domain:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    SetDNSDomain(item-&gt;data, &quot;&quo=
t;, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       case undo_domains:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    UndoDnsSearchDomains(item-&gt;data);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                case undo_wins:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    netsh_wins_c=
md(L&quot;delete&quot;, item-&gt;data, NULL);</span><br><span>             =
        break;</span><br><span> </span><br><span>                 case wfp_=
block:</span><br><span>@@ -2260,6 +2804,34 @@</span><br><span>     ServiceS=
tartInteractive(dwArgc, lpszArgv);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Clean up remains of previous session=
s in registry. These remains can</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * happen with unclean shutdowns or crashes and would interfer=
e with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * normal ope=
ration of the system with and without active tunnels.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CleanupRegistry()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HKEY k=
ey;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD change=
d =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Clean up leftover DNS s=
earch list fragments */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    BOOL gpol_list;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    GetDnsSearchListKey(NULL, &amp;gpol_list, &amp;key);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (key !=3D INVALID_HANDLE_VA=
LUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (ResetDnsSearchDom=
ains(key))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            changed=
++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        RegCloseKey(key);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (changed)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ApplyDnsSettings(gpol_list);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span> </span><br><span> VOID WINAPI</span><br><span> S=
erviceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)</span><br><span>@@ -=
2283,6 +2855,9 @@</span><br><span>     status.dwWaitHint =3D 3000;</span><b=
r><span>     ReportStatusToSCMgr(service, &amp;status);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Clean up poten=
tially left over registry values */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    CleanupRegistry();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     /* Read info from registry in key =
HKLM\SOFTWARE\OpenVPN */</span><br><span>     error =3D GetOpenvpnSettings(=
&amp;settings);</span><br><span>     if (error !=3D ERROR_SUCCESS)</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/824?usp=3Demail">change 824</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
824?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Yq2B9u8fXNo=--

