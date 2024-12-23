From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 23 Dec 2024 16:28:29 +0000
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <f12682020087ce23e31c173c4db3154e2ad9ed28-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X2jy8jma24E="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X2jy8jma24E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail

to look at the new patch set (#6).


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
M src/openvpn/options.c
M src/openvpn/tun.c
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/Makefile.am
M src/openvpnserv/interactive.c
5 files changed, 719 insertions(+), 111 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/824/6

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b2a3a8b..cc723ca 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8231,7 +8231,7 @@
                 msg(msglevel, "--dhcp-option %s: maximum of %d search entr=
ies can be specified",
                     p[1], N_SEARCH_LIST_LEN);
             }
-            o->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
+            o->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "DISABLE-NBT") && !p[2])
         {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 1e67d37..644d50c 100644
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
+        strncpy(dns.domains + dstlen, o->domain_search_list[i], srclen + 1=
);
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
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 154e17c..ccde43a 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -27,7 +27,8 @@
     -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
     )
 target_link_libraries(openvpnserv
-    advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib shlwapi.=
lib netapi32.lib ws2_32.lib ntdll.lib)
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
 	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
-openvpnserv_LDADD =3D -ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 =
-lshlwapi -lnetapi32 -lws2_32 -lntdll
+openvpnserv_LDADD =3D \
+	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
+	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32
 endif

 openvpnserv_SOURCES =3D \
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 67f5bbc..0657fab 100644
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
@@ -1221,50 +1162,656 @@
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
+    SC_HANDLE scm =3D NULL;
+    SC_HANDLE dnssvc =3D NULL;
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
+        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
+                                  "failed to convert itf alias '%s'"), itf=
_name);
+        goto out;
+    }
+    err =3D ConvertInterfaceLuidToGuid(&luid, &guid);
+    if (err)
+    {
+        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
+                                  "Failed to convert itf '%s' LUID"), itf_=
name);
+        goto out;
     }

-    wchar_t *wdomain =3D utf8to16(domain); /* utf8 to wide-char */
-    if (!wdomain)
+    if (StringFromIID(&guid, &iid_str) !=3D S_OK)
     {
-        return ERROR_OUTOFMEMORY;
+        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
+                                  "Failed to convert itf '%s' IID"), itf_n=
ame);
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
+    WCHAR list[2048] =3D {0};
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
+    WCHAR list[2048];
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
+    WCHAR list[2048];
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
+    size_t list_len =3D wcslen(list);
+    if (list_len)
+    {
+        /* Now check if the shortened list equals the initial search list =
*/
+        WCHAR initial[2048];
+        size =3D sizeof(initial);
+        err =3D RegGetValueW(key, NULL, L"InitialSearchList", RRF_RT_REG_S=
Z, NULL, initial, &size);
+        if (err)
+        {
+            MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
+                                         "could not get InitialSearchList =
from registry (%lu)"), err);
+            return;
+        }
+
+        /* If the search list is back to its initial state reset it */
+        if (wcsncmp(list, initial, wcslen(list)) =3D=3D 0)
+        {
+            ResetDnsSearchDomains(key);
+            return;
+        }
+    }
+
+    size =3D (list_len + 1) * sizeof(list[0]);
+    err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
+                                     "could not set SearchList in registry=
 (%lu)"), err);
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

@@ -1315,11 +1862,13 @@

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

@@ -1357,10 +1906,12 @@
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
@@ -1751,12 +2302,12 @@
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
@@ -2260,6 +2811,34 @@
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
@@ -2283,6 +2862,9 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--X2jy8jma24E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #6</strong> to this change.</p><p><a hr=
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
 Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpn/options.c<br>M src/o=
penvpn/tun.c<br>M src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/Makef=
ile.am<br>M src/openvpnserv/interactive.c<br>5 files changed, 719 insertion=
s(+), 111 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/24/824/6</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/sr=
c/openvpn/options.c</span><br><span>index b2a3a8b..cc723ca 100644</span><br=
><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/option=
s.c</span><br><span>@@ -8231,7 +8231,7 @@</span><br><span>                 =
msg(msglevel, &quot;--dhcp-option %s: maximum of %d search entries can be s=
pecified&quot;,</span><br><span>                     p[1], N_SEARCH_LIST_LE=
N);</span><br><span>             }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;=
dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span>         }</s=
pan><br><span>         else if (streq(p[1], &quot;DISABLE-NBT&quot;) &amp;&=
amp; !p[2])</span><br><span>         {</span><br><span>diff --git a/src/ope=
nvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 1e67d37..644d50c 10064=
4</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn=
/tun.c</span><br><span>@@ -183,9 +183,10 @@</span><br><span> {</span><br><s=
pan>     ack_message_t ack;</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE pipe=
 =3D tt-&gt;options.msg_channel;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const struct tuntap_options *o =3D &amp;tt-&gt;options;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!tt-&gt;options.domain) /* no  domain to add or delete */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* no domains to add or delete =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;do=
main &amp;&amp; !o-&gt;domain_search_list[0])</span><br><span>     {</span>=
<br><span>         goto out;</span><br><span>     }</span><br><span>@@ -203=
,28 +204,50 @@</span><br><span>         .addr_len =3D 0       /* add/delete=
 only the domain, not DNS servers */</span><br><span>     };</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* interface=
 name is required */</span><br><span>     strncpynt(dns.iface.name, tt-&gt;=
actual_name, sizeof(dns.iface.name));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    strncpynt(dns.domains, tt-&gt;options.domain, sizeof(dn=
s.domains));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tr=
uncation of domain name is not checked as it can&#39;t happen</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     * with 512 bytes room in dns.d=
omains.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    dns.iface.name[sizeof(=
dns.iface.name) - 1] =3D &#39;\0&#39;;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;%s dns domain on &#=
39;%s&#39; (if_index =3D %d) using service&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* only use domain when there are no sear=
ch domains */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (o-&gt;domain &amp;&amp; !o-&gt;domain_search_list[0])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        strncpynt(dns.domains, o-&gt;domain, sizeof(d=
ns.domains));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Create a comma separated list of=
 search domains */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (int i =3D 0; i &lt; N_SEARCH_LIST_LEN &amp;&amp; o-&gt;domain_searc=
h_list[i]; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t dst=
len =3D strlen(dns.domains);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        size_t srclen =3D strlen(o-&gt;domain_search_list[i]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t extra =
=3D dstlen ? 2 : 1; /* space for comma and NUL */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (dstlen + srclen + extra &gt; size=
of(dns.domains))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_WARN, &quot;DNS search domains sent to service truncated to %d&quot;, =
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            brea=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dstlen)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            dns.domains[dstlen++] =3D=
 &#39;,&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strncpy(=
dns.domains + dstlen, o-&gt;domain_search_list[i], srclen + 1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(D_LOW, &quot;%s DNS domains on &#39;%s&#39; (if_index =
=3D %d) using service&quot;,</span><br><span>         (add ? &quot;Setting&=
quot; : &quot;Deleting&quot;), dns.iface.name, dns.iface.index);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!send_msg_iservice(pipe,=
 &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&quot;))</span><br><span style=
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
ee(&amp;gc);</span><br><span>diff --git a/src/openvpnserv/CMakeLists.txt b/=
src/openvpnserv/CMakeLists.txt</span><br><span>index 154e17c..ccde43a 10064=
4</span><br><span>--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++ =
b/src/openvpnserv/CMakeLists.txt</span><br><span>@@ -27,7 +27,8 @@</span><b=
r><span>     -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span>     )</sp=
an><br><span> target_link_libraries(openvpnserv</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    advapi32.lib userenv.lib iphlpapi.lib fwpucln=
t.lib rpcrt4.lib shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    advapi32.lib userenv.lib ip=
hlpapi.lib fwpuclnt.lib rpcrt4.lib</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib)=
</span><br><span> if (MINGW)</span><br><span>     target_compile_options(op=
envpnserv PRIVATE -municode)</span><br><span>     target_link_options(openv=
pnserv PRIVATE -municode)</span><br><span>diff --git a/src/openvpnserv/Make=
file.am b/src/openvpnserv/Makefile.am</span><br><span>index 621ce73..f053f4=
0 100644</span><br><span>--- a/src/openvpnserv/Makefile.am</span><br><span>=
+++ b/src/openvpnserv/Makefile.am</span><br><span>@@ -25,7 +25,9 @@</span><=
br><span> 	-municode -D_UNICODE \</span><br><span> 	-UNTDDI_VERSION -U_WIN3=
2_WINNT \</span><br><span> 	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-openvpnserv_LDADD =3D -ladvapi32 =
-luserenv -liphlpapi -lfwpuclnt -lrpcrt4 -lshlwapi -lnetapi32 -lws2_32 -lnt=
dll</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpnserv_LDAD=
D =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-ladvapi32 =
-luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32</span=
><br><span> endif</span><br><span> </span><br><span> openvpnserv_SOURCES =
=3D \</span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/open=
vpnserv/interactive.c</span><br><span>index 67f5bbc..0657fab 100644</span><=
br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/open=
vpnserv/interactive.c</span><br><span>@@ -88,7 +88,7 @@</span><br><span>   =
  wfp_block,</span><br><span>     undo_dns4,</span><br><span>     undo_dns6=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    undo_domain,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    undo_domains,</span=
><br><span>     undo_ring_buffer,</span><br><span>     undo_wins,</span><br=
><span>     _undo_type_max</span><br><span>@@ -103,6 +103,11 @@</span><br><=
span> } wfp_block_data_t;</span><br><span> </span><br><span> typedef struct=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char itf_name=
[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR dom=
ains;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} dns_domains_=
undo_data_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct {</span><br=
><span>     struct tun_ring *send_ring;</span><br><span>     struct tun_rin=
g *receive_ring;</span><br><span> } ring_buffer_maps_t;</span><br><span>@@ =
-565,24 +570,6 @@</span><br><span>     return status;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ConvertInterfac=
eNameToIndex(const wchar_t *ifname, NET_IFINDEX *index)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    NET_LUID luid;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    DWORD err;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D Conve=
rtInterfaceAliasToLuid(ifname, &amp;luid);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (err =3D=3D ERROR_SUCCESS)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        err =3D ConvertInterfaceLuidToIndex(&amp;luid, ind=
ex);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (err !=3D ERROR_SUCCESS)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quot;Fai=
led to find interface index for &lt;%ls&gt;&quot;, ifname);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return err;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> static BOOL</span><br><span> CmpAddress(LPVOID item, LPVOID a=
ddress)</span><br><span> {</span><br><span>@@ -1152,52 +1139,6 @@</span><br=
><span>     return err;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Run command: wmic nicconfig (InterfaceIndex=3D$if_i=
ndex) call $action ($data)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @param  if_index    &quot;index of interface&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @param  action      e.g., &quot;Set=
DNSDomain&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @pa=
ram  data        data if required for action</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *                     - a single word for SetDNSDom=
ain, empty or NULL to delete</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *                     - comma separated values for a list</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDE=
X if_index,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
         const wchar_t *data)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD er=
r =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t a=
rgv0[MAX_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wc=
har_t *cmdline =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int timeout =3D 10000; /* in msec */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    swprintf(argv0, _countof(argv0), L&quot;%ls\\%ls&quot;, get_win_sys_pa=
th(), L&quot;wbem\\wmic.exe&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st wchar_t *fmt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* comma separated list must be enclosed in parenthesis */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (data &amp;&amp; wcschr(data, L&=
#39;,&#39;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        fmt =3D L&quot;wm=
ic nicconfig where (InterfaceIndex=3D%ld) call %ls (%ls)&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     fmt =3D L&quot;wmic nicconfig where (InterfaceIndex=3D%ld) call %ls \&=
quot;%ls\&quot;&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) =
+ 20 + wcslen(action) /* max 20 for ifindex */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                      + (data ? wcslen(data) + 1 :=
 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmdline =3D m=
alloc(ncmdline*sizeof(wchar_t));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!cmdline)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    swprintf(cmdline, ncmdline, fm=
t, if_index, action,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
            data ? data : L&quot;&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    err =3D ExecCommand(argv0, cmdline, timeout);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    free(cmdline);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return err;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> /* Delete all IPv4 or IPv6 dns servers for an interface */<=
/span><br><span> static DWORD</span><br><span> DeleteDNS(short family, wcha=
r_t *if_name)</span><br><span>@@ -1221,50 +1162,656 @@</span><br><span> }</=
span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Set interface specific DNS domain suffix</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @param  if_name    name of the int=
erface</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  doma=
in     a single domain name</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param  lists      pointer to the undo lists. If NULL</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *                    undo lists a=
re not altered.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Wil=
l delete the currently set value if domain is empty.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Signal the DNS resolver (and others po=
tentially) to reload the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * group policy (DNS) settings on 32 bit Windows systems</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return BOOL to indicate if the reload was init=
iated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ApplyGpolSettings32()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    typedef NTSTATUS (__stdcall *publish_fn_t)(</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD StateNameLo,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD State=
NameHi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWOR=
D TypeId,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DW=
ORD Buffer,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
DWORD Length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  DWORD ExplicitScope);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    publish_fn_t RtlPublishWnfStateData;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0=
D891E2A;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const D=
WORD WNF_GPOL_SYSTEM_CHANGES_LO =3D 0xA3BC0875;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    HMODULE ntdll =3D LoadLibraryA(&quot;ntdll.dll&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ntdll =3D=3D NULL)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    RtlPublishWnfStateData =3D (publish_fn_t) GetProcAddress(ntdl=
l, &quot;RtlPublishWnfStateData&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (RtlPublishWnfStateData =3D=3D NULL)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM=
_CHANGES_HI, 0, 0, 0, 0) !=3D ERROR_SUCCESS)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Signal the DNS resolver (and others potentially) to reload the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * group policy (DNS) settings=
 on 64 bit Windows systems</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 BOOL to indicate if the reload was initiated</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ApplyGpolSettings64()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    typedef NT=
STATUS (*publish_fn_t)(</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        INT64 StateName,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        INT64 TypeId,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        INT64 Buffer,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        unsigned int Length,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        INT64 ExplicitScope);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    publish_fn_t RtlPublishWnfStateData;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const INT64 WNF_=
GPOL_SYSTEM_CHANGES =3D 0x0D891E2AA3BC0875;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    HMODULE ntdll =3D LoadLibraryA(&quot;ntdll.dll&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (ntdll =3D=3D NULL)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    RtlPublishWnfStateData =3D (publish_fn_t) GetProcAddress(ntdll, &=
quot;RtlPublishWnfStateData&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (RtlPublishWnfStateData =3D=3D NULL)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) !=3D ERROR_S=
UCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Signal the DNS resolver (and others=
 potentially) to reload the group policy (DNS) settings</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return BOOL to indicate if the reload was initiated<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ApplyGpolSettings()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SYSTEM_INFO si;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    GetSystemInfo(&amp;si);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const BOOL win_32bit =3D si.wProcessorArchitecture=
 =3D=3D PROCESSOR_ARCHITECTURE_INTEL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return win_32bit ? ApplyGpolSettings32() : ApplyGpolS=
ettings64();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Signal the DNS resolver to reload its settings</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param apply_gpol    BOOL reload setting fro=
m group policy hives as well</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn BOOL to indicate if the reload was initiated</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ApplyDnsSettings(BOOL apply_gpol)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    BOOL res =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SC_HANDLE scm =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SC_HANDLE dnssvc =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (apply_gpol &amp;&amp; ApplyGpolSettings() =3D=3D FALSE)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;A=
pplyDnsSettings: sending GPOL notification failed&quot;));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    scm =3D OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (scm =3D=3D NULL)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&q=
uot;ApplyDnsSettings: &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                  &quot;OpenSCManager call failed =
(%lu)&quot;), GetLastError());</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    dnssvc =3D OpenServi=
ceA(scm, &quot;Dnscache&quot;, SERVICE_PAUSE_CONTINUE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (dnssvc =3D=3D NULL)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;Apply=
DnsSettings: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                  &quot;OpenService call failed (%lu)&quot;=
), GetLastError());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    SERVICE_STATUS status;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ControlService(dnssv=
c, SERVICE_CONTROL_PARAMCHANGE, &amp;status) =3D=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSettin=
gs: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                         &quot;ControlService call failed (%lu)&quot;), Get=
LastError());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    res =3D TRUE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (dnssvc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CloseServi=
ceHandle(dnssvc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (scm)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        CloseServiceHandle(scm);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return res;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Get the string i=
nterface UUID (with braces) for an interface alias name</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param  itf_name   the interface alias name</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  str        pointer=
 to the buffer the wide UUID is returned in</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param  len        size of the str buffer in cha=
racters</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR on succes=
s, or the Windows error code for the failure</span><br><span>  */</span><br=
><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-S=
etDNSDomain(const wchar_t *if_name, const char *domain, undo_lists_t *lists=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+InterfaceIdString(=
PCSTR itf_name, PWSTR str, size_t len)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    NET_IFINDEX if_index;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    DWORD err;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    GUID guid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    NET_LUID luid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    PWSTR iid_str =3D NULL;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD err  =
=3D ConvertInterfaceNameToIndex(if_name, &amp;if_index);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (err !=3D ERROR_SUCCESS)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D InterfaceLuid(it=
f_name, &amp;luid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        return err;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;InterfaceIdString: &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                   &quot;failed to convert itf alias &#39;%s&#39;&quot;), i=
tf_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        go=
to out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertInterfa=
ceLuidToGuid(&amp;luid, &amp;guid);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   MsgToEventLog(M_ERR, TEXT(&quot;InterfaceIdString: &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
&quot;Failed to convert itf &#39;%s&#39; LUID&quot;), itf_name);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    wchar_t *wdomain =3D utf8to16(domain); /* utf8 to wide-char */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!wdomain)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (StringFromIID(&am=
p;guid, &amp;iid_str) !=3D S_OK)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return ERROR_OUTOFMEMORY;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR=
, TEXT(&quot;InterfaceIdString: &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                  &quot;Failed to conver=
t itf &#39;%s&#39; IID&quot;), itf_name);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        err =3D ERROR_OUTOFMEMORY;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (wcslen(iid_str) + 1 &gt; len)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        err =3D ERROR_INVALID_PARAMETER;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* free undo list if previously set */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (lists)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    wcsncpy(str, iid_str, len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (iid_str)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        free(RemoveListItem(&amp;(*lists)[undo_domain],=
 CmpWString, (void *)if_name));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        CoTaskMemFree(iid_str);</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return err;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    err =3D wmic_nicconfig_cmd(L&q=
uot;SetDNSDomain&quot;, if_index, wdomain);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* Add to undo list if domain is non-empty */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (err =3D=3D 0 &amp;&amp; wdomain[0] &am=
p;&amp; lists)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check for a valid =
search list in a certain key of the registry</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Valid means that a string value &quot;SearchList&quot; exists an=
d that it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * contain=
s one or more domains. We only check if the string contains</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * a &#39;.&#39; character, but the=
 main point is to prevent letting pass</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * whitespace-only lists, so that check is good enough f=
or that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * purpose.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param  key  HKEY in which to chec=
k for a valid search list</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
BOOL to indicate if a valid search list has been found</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+HasValidSearchList(HKEY key)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char data[64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    DWORD size =3D sizeof(data);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    LSTATUS err =3D RegGetValueA(key, NULL, &quot;SearchList&=
quot;, RRF_RT_REG_SZ, NULL, (PBYTE)data, &amp;size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!err || err =3D=3D ERROR_MORE_DAT=
A)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        wchar_t *tmp_name =3D _wcsdup(if_name);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!tmp_name || AddListItem(&amp;(=
*lists)[undo_domain], tmp_name))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        data[sizeof(data) - 1] =3D &#39;\0&#39;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (strchr(data, &#39;.&#=
39;) !=3D NULL)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            free(tmp_name);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            err =3D ERROR_OUTOFMEMORY;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return TRUE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return FALSE;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Find the registry key for=
 storing the DNS domains for the VPN interface</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param  itf_name PCSTR that contains the alias name of the int=
erface the domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*                  are related to. If this is NULL the interface probing is=
 skipped.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
 gpol     PBOOL to indicate if the key returned is the group policy hive</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  key      PH=
KEY in which the found registry key is returned in</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return BOOL to indicate if a search list is already prese=
nt at the location.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *         If the key returned is INVALID_HANDLE_VALUE, this indicates an</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         unrecovera=
ble error.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * The correct location to=
 add them is where a non-empty &quot;SearchList&quot; value exists,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * or in the interface conf=
iguration itself. However, the system-wide and then the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * group policy search lists overrule t=
he previous one respectively, so we need to</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * probe to find the effective list.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+GetDnsSearchListKey(PCSTR itf_name, PBOOL gpol, PHKEY key)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    *gpol =3D FALSE;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Try the group policy search list */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        &quo=
t;SOFTWARE\\Policies\\Microsoft\\Windows NT\\DNSClient&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        0, KEY_AL=
L_ACCESS, key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (HasValidSear=
chList(*key))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *gpo=
l =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        RegCl=
oseKey(*key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Try the system-wide search list =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegOp=
enKeyExA(HKEY_LOCAL_MACHINE,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        &quot;System\\CurrentControlSet\\Services\=
\TCPIP\\Parameters&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        0, KEY_ALL_ACCESS, key);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!err)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (HasValidSearchList(*key))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return TRUE;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        RegCloseKey(*key);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(itf_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Always retur=
n the VPN interface key (if it exists) */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        WCHAR iid[64];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        DWORD iid_err =3D InterfaceIdString(itf_na=
me, iid, _countof(iid));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!iid_err)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         HKEY itfs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                &quot;Sys=
tem\\CurrentControlSet\\Services\\TCPIP\\Parameters\\Interfaces&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
        0, KEY_ALL_ACCESS, &amp;itfs);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (!err)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                err =3D RegOpenKeyExW(itfs, iid, 0, KEY_ALL_=
ACCESS, key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          RegCloseKey(itfs);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                if (!err)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    return FALSE; /* No need to preserve the V=
PN itf search list */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span>         }</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(wdomai=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *key =3D INV=
ALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Check if a initial list had already been created</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param  key      HKEY of the registry =
subkey to search in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL t=
o indicate if the initial list is already present under key</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+InitialSearchListExists(HKEY key)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    LSTATUS err;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =
=3D RegGetValueA(key, NULL, &quot;InitialSearchList&quot;, RRF_RT_REG_SZ, N=
ULL, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (err =3D=3D =
ERROR_FILE_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgT=
oEventLog(M_ERR, TEXT(&quot;InitialSearchListExists: &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                  &=
quot;failed to get InitialSearchList (%lu)&quot;), err);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Prepare DNS domain &quot;SearchList&quot; registr=
y value, so additional</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * VPN domains can be added and its original state can be restored</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in case the system can=
not clean up regularly.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  ke=
y      registry subkey to store the list in</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param  list     string of comma separated domai=
ns to use as the list</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return bool=
ean to indicate whether the list was stored successfully</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+StoreInitialDnsSearchList(HKEY key, PCWSTR list)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!list || wcslen(list) =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;Store=
InitialDnsSearchList: empty search list&quot;));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (InitialSearchListExists(key))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Initial list had already been stored */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return TRUE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    DWORD size =3D (wcslen(list) + 1) * sizeof(*list);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err =3D RegSetValueExW(key=
, L&quot;InitialSearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;StoreInitia=
lDnsSearchList: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                  &quot;failed to set InitialSearchList =
value (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * App=
end domain suffixes to an existing search list</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param  key          HKEY the list is stored at</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param  have_list    BOOL to in=
dicate if a search list already exists</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param  domains      domain suffixes as comma separat=
ed string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate=
 success or failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+AddDnsSearchDomains(HKEY=
 key, BOOL have_list, PCWSTR domains)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    LSTATUS err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 WCHAR list[2048] =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    DWORD size =3D sizeof(list);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (have_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =
=3D RegGetValueW(key, NULL, L&quot;SearchList&quot;, RRF_RT_REG_SZ, NULL, l=
ist, &amp;size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            MsgT=
oEventLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
     &quot;could not get SearchList from registry (%lu)&quot;), err);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return FALSE;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!StoreInitialDnsSearchList(key, list=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return FALSE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        size_t listlen =3D (size / sizeof(list[0])=
) - 1; /* returned size is in bytes */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        size_t domlen =3D wcslen(domains);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (listlen + domlen + 2 =
&gt; _countof(list))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
            &quot;not enough space in list for search domains (len=3D%lu)&q=
uot;),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
             domlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return FALSE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Append to =
end of the search list */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        PWSTR pos =3D list + listlen;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        *pos =3D &#39;,&#39;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        wcsncpy(pos + 1, domains, domlen =
+ 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        wcsncpy(list, domains, wcslen(domains) + 1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    size =3D (wcslen(list) + 1) * sizeof(list[0]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegSetValu=
eExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsS=
earchDomains: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                     &quot;could not set SearchList to reg=
istry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Res=
et the DNS search list to its original value</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Looks for a &quot;InitialSearchList&quot; value as the one to re=
set to.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If it doe=
sn&#39;t exists, resets to empty, effectively disabling it.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param  key  HKEY of the location in the registry=
 to reset</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate=
 if something was reset</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ResetDnsSearchDomain=
s(HKEY key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =3D FALSE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR list[2048];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD size =3D size=
of(list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegGetValueW(key,=
 NULL, L&quot;InitialSearchList&quot;, RRF_RT_REG_SZ, NULL, list, &amp;size=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (err !=3D ERROR_FILE_NOT_FO=
UND)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            MsgToEventLog=
(M_SYSERR, TEXT(&quot;ResetDnsSearchDomains: &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
&quot;could not get InitialSearchList from registry (%lu)&quot;), err);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    size =3D (wcslen(list) + 1) * sizeof(list[0]);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    err =3D RegSetValueExW(key, L&quo=
t;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;ResetDnsSearchDomains:=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                         &quot;could not set SearchList in registry (%lu)&q=
uot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    RegDeleteValueA(key, &quot;InitialSea=
rchList&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ret =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove domain suffi=
xes from an existing search list</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param  key      HKEY the list is stored at</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param  domains  domain suffixes to remove as com=
ma separated string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+RemoveDnsSearchDomains(H=
KEY key, PCWSTR domains)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS e=
rr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR list[2=
048];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD size=
 =3D sizeof(list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D RegGetVa=
lueW(key, NULL, L&quot;SearchList&quot;, RRF_RT_REG_SZ, NULL, list, &amp;si=
ze);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT=
(&quot;RemoveDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                     &quot;could not get =
SearchList from registry (%lu)&quot;), err);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR ds=
t =3D wcsstr(list, domains);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!dst)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Msg=
ToEventLog(M_ERR, TEXT(&quot;RemoveDnsSearchDomains: &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                  &=
quot;could not find domains in search list&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Cut out domains from list */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t domlen =3D wcslen(domains);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    PCWSTR src =3D dst + domlen;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Also remove the leadi=
ng comma, if there is one */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    dst =3D dst &gt; list ? dst - 1 : dst;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    wmemmove(dst, src, domlen);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size_t list_len =3D wcslen(list);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (list_len)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* Now check if the shortened list equ=
als the initial search list */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        WCHAR initial[2048];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        size =3D sizeof(initial);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        err =3D RegGetValueW(key, NULL, L=
&quot;InitialSearchList&quot;, RRF_RT_REG_SZ, NULL, initial, &amp;size);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (err)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            MsgToEventLog(M_SYSERR,=
 TEXT(&quot;RemoveDnsSearchDomains: &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                         &quot;could=
 not get InitialSearchList from registry (%lu)&quot;), err);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* If the search list is back to its initial state rese=
t it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
wcsncmp(list, initial, wcslen(list)) =3D=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            ResetDnsSearchDomains(key);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    si=
ze =3D (list_len + 1) * sizeof(list[0]);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    err =3D RegSetValueExW(key, L&quot;SearchList&quot=
;, 0, REG_SZ, (PBYTE)list, size);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 MsgToEventLog(M_SYSERR, TEXT(&quot;RemoveDnsSearchDomains: &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
         &quot;could not set SearchList in registry (%lu)&quot;), err);</sp=
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
><span>@@ -1315,11 +1862,13 @@</span><br><span> </span><br><span>     if (m=
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
</span><br><span>     }</span><br><span> </span><br><span>@@ -1357,10 +1906=
,12 @@</span><br><span>         }</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL gpol =3D FA=
LSE;</span><br><span>     if (msg-&gt;domains[0])</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D SetDNSDo=
main(wide_name, msg-&gt;domains, lists);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        err =3D SetDnsSearchDomains(msg-&gt;iface.name=
, msg-&gt;domains, &amp;gpol, lists);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ApplyDnsSettings(gpol);</span>=
<br><span> </span><br><span> out:</span><br><span>     free(wide_name);</sp=
an><br><span>@@ -1751,12 +2302,12 @@</span><br><span>                     D=
eleteDNS(AF_INET6, item-&gt;data);</span><br><span>                     bre=
ak;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                case undo_wins:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    netsh_wins_cmd(L&quot;delete&quot;, item-&gt;=
data, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         case undo_domains:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    UndoDnsSearchDomains(item-&gt;data);</span><br>=
<span>                     break;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                case undo_domain:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    SetDNSDomai=
n(item-&gt;data, &quot;&quot;, NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                case undo_wins:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    netsh_wins_cmd(L&quot;del=
ete&quot;, item-&gt;data, NULL);</span><br><span>                     break=
;</span><br><span> </span><br><span>                 case wfp_block:</span>=
<br><span>@@ -2260,6 +2811,34 @@</span><br><span>     ServiceStartInteracti=
ve(dwArgc, lpszArgv);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Clean up remains of previous sessions in registry=
. These remains can</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * happen with unclean shutdowns or crashes and would interfere with</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * normal operation of the=
 system with and without active tunnels.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Cle=
anupRegistry()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    HKEY key;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD changed =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Clean up leftover DNS search list =
fragments */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOO=
L gpol_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Get=
DnsSearchListKey(NULL, &amp;gpol_list, &amp;key);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (key !=3D INVALID_HANDLE_VALUE)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (ResetDnsSearchDomains(key))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            changed++;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        RegCloseKey(key);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (changed)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  ApplyDnsSettings(gpol_list);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span> </span><br><span> VOID WINAPI</span><br><span> ServiceStart=
Interactive(DWORD dwArgc, LPTSTR *lpszArgv)</span><br><span>@@ -2283,6 +286=
2,9 @@</span><br><span>     status.dwWaitHint =3D 3000;</span><br><span>   =
  ReportStatusToSCMgr(service, &amp;status);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Clean up potentially left=
 over registry values */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CleanupRegistry();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     /* Read info from registry in key HKLM\SOFTWA=
RE\OpenVPN */</span><br><span>     error =3D GetOpenvpnSettings(&amp;settin=
gs);</span><br><span>     if (error !=3D ERROR_SUCCESS)</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/824?usp=3Demail">change 824</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--X2jy8jma24E=--

