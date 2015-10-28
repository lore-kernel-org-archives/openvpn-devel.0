References: <562EB0A1.8010403@...2070...> <56307DAA.30700@...2070...>
From: ValdikSS <iam@...2070...>
Message-ID: <563083B1.2020908@...2070...>
Date: Wed, 28 Oct 2015 11:13:37 +0300
MIME-Version: 1.0
In-Reply-To: <56307DAA.30700@...2070...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9vXbPb1wpaWJELnLFuqCliBJTlG3xIe8p"
Subject: Re: [Openvpn-devel] [PATCH v2] Add Windows DNS Leak fix using WFP
 ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9vXbPb1wpaWJELnLFuqCliBJTlG3xIe8p
Content-Type: multipart/mixed; boundary="------------050300040604070205000109"

This is a multi-part message in MIME format.
--------------050300040604070205000109
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It seems that Thunderbird scrabbled the patch. Here is the attachment.

On 28.10.2015 10:47, ValdikSS wrote:
> This option is silently ignored on non-Windows platforms and works on Vis=
ta+.
> External DNS is blocked even if no DNS server configured (user may config=
ure it in the tap interface itself).
> This option could be ignored from server push using route-nopull.
>
> v2:
> * Add missing libs to MSVC project file.
> * Add ifndef for FWPM_SESSION_FLAG_DYNAMIC to silence warning in MSVC.
> * Use const WCHAR for firewall name.
> * Block all traffic to TCP/UDP port 53 except for OpenVPN itself. Blockin=
g only svchost.exe is not reliable as user could disable dnscache service m=
aking all applications resolve DNS from their processes.
> ---
>  doc/openvpn.8               |  11 ++-
>  src/openvpn/Makefile.am     |   2 +-
>  src/openvpn/init.c          |  24 +++++++
>  src/openvpn/openvpn.vcxproj |   4 +-
>  src/openvpn/options.c       |  14 ++++
>  src/openvpn/options.h       |   1 +
>  src/openvpn/win32.c         | 172 ++++++++++++++++++++++++++++++++++++++=
++++++
>  src/openvpn/win32.h         |  64 +++++++++++++++++
>  8 files changed, 287 insertions(+), 5 deletions(-)
>  mode change 100755 =3D> 100644 src/openvpn/openvpn.vcxproj
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index b6d5aed..136473e 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -1129,8 +1129,8 @@ When used with
>  .B \-\-client
>  or
>  .B \-\-pull,
> -accept options pushed by server EXCEPT for routes and dhcp options
> -like DNS servers.
> +accept options pushed by server EXCEPT for routes, block-outside-dns and=
 dhcp
> +options like DNS servers.
>   When used on the client, this option effectively bars the
>  server from adding routes to the client's routing table,
> @@ -5517,6 +5517,13 @@ adapter list to the syslog or log file after the T=
UN/TAP adapter
>  has been brought up and any routes have been added.
>  .\"*********************************************************
>  .TP
> +.B \-\-block\-outside\-dns
> +Block external DNS servers on other network adapters to prevent
> +DNS leaks. This option prevents any application from accessing
> +TCP or UDP port 53 except one inside the tunnel. It uses WFP and
> +works on Windows Vista and later.
> +.\"*********************************************************
> +.TP
>  .B \-\-dhcp\-renew
>  Ask Windows to renew the TAP adapter lease on startup.
>  This option is normally unnecessary, as Windows automatically
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index c840f16..c55a520 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -127,5 +127,5 @@ openvpn_LDADD =3D \
>  	$(OPTIONAL_DL_LIBS)
>  if WIN32
>  openvpn_SOURCES +=3D openvpn_win32_resources.rc
> -openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm
> +openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm -lfwpuclnt -lrpcrt4
>  endif
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index c5c0ab6..b1c23fd 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1468,6 +1468,22 @@ do_open_tun (struct context *c)
>  		   "up",
>  		   c->c2.es);
>  +#if _WIN32_WINNT >=3D 0x0600
> +      if (c->options.block_outside_dns)
> +      {
> +          if (!win_wfp_init())
> +            msg (M_NONFATAL, "Initialising WFP failed!");
> +            else
> +            {
> +                dmsg (D_LOW, "Blocking outside DNS");
> +                if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
> +                    msg (M_NONFATAL, "Blocking DNS failed!");
> +            }
> +      }
> +      else
> +           msg (M_NONFATAL, "Can't block outside DNS without configured =
DNS server");
> +#endif
> +
>        /* possibly add routes */
>        if ((route_order() =3D=3D ROUTE_AFTER_TUN) && (!c->options.route_d=
elay_defined))
>  	do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
> @@ -1596,6 +1612,14 @@ do_close_tun (struct context *c, bool force)
>  		       "down",
>  		       c->c2.es);
>  +#if _WIN32_WINNT >=3D 0x0600
> +            if (c->options.block_outside_dns)
> +            {
> +                if (!win_wfp_uninit())
> +                    msg (M_NONFATAL, "Uninitialising WFP failed!");
> +            }
> +#endif
> +
>  	  /* actually close tun/tap device based on --down-pre flag */
>  	  if (c->options.down_pre)
>  	    do_close_tun_simple (c);
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> old mode 100755
> new mode 100644
> index b117b0b..821c46c
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -64,7 +64,7 @@
>        <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
>      </ResourceCompile>
>      <Link>
> -      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
> +      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDepend=
encies>
>        <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;=
$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirec=
tories>
>        <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> @@ -89,7 +89,7 @@
>        <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
>      </ResourceCompile>
>      <Link>
> -      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
> +      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDepend=
encies>
>        <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;=
$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirec=
tories>
>        <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2f8915d..a7f50cc 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -696,6 +696,9 @@ static const char usage_message[] =3D
>    "                       optional parameter controls the initial state =
of ex.\n"
>    "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and n=
et adapter list\n"
>    "                  after TAP adapter is up and routes have been added.=
\n"
> +#if _WIN32_WINNT >=3D 0x0600
> +  "--block-outside-dns   : Block DNS on other network adapters to preven=
t DNS leaks\n"
> +#endif
>    "Windows Standalone Options:\n"
>    "\n"
>    "--show-adapters : Show all TAP-Windows adapters.\n"
> @@ -797,6 +800,7 @@ init_options (struct options *o, const bool init_gc)
>    o->tuntap_options.dhcp_lease_time =3D 31536000; /* one year */
>    o->tuntap_options.dhcp_masq_offset =3D 0;       /* use network address=
 as internal DHCP server address */
>    o->route_method =3D ROUTE_METHOD_ADAPTIVE;
> +  o->block_outside_dns =3D false;
>  #endif
>  #if P2MP_SERVER
>    o->real_hash_size =3D 256;
> @@ -1651,6 +1655,9 @@ show_settings (const struct options *o)
>  #ifdef WIN32
>    SHOW_BOOL (show_net_up);
>    SHOW_INT (route_method);
> +#if _WIN32_WINNT >=3D 0x0600
> +  SHOW_BOOL (block_outside_dns);
> +#endif
>    show_tuntap_options (&o->tuntap_options);
>  #endif
>  #endif
> @@ -6222,6 +6229,13 @@ add_option (struct options *options,
>        VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
>      }
>  #endif
> +  else if (streq (p[0], "block-outside-dns") && !p[1])
> +    {
> +      VERIFY_PERMISSION (OPT_P_IPWIN32);
> +#if _WIN32_WINNT >=3D 0x0600
> +      options->block_outside_dns =3D true;
> +#endif
> +    }
>  #if PASSTOS_CAPABILITY
>    else if (streq (p[0], "passtos") && !p[1])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index c642aa0..873c159 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -587,6 +587,7 @@ struct options
>    bool exit_event_initial_state;
>    bool show_net_up;
>    int route_method;
> +  bool block_outside_dns;
>  #endif
>     bool use_peer_id;
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 7c89a5a..4c44901 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -37,6 +37,10 @@
>   #ifdef WIN32
>  +#include <fwpmu.h>
> +#include <fwpmtypes.h>
> +#include <iphlpapi.h>
> +
>  #include "buffer.h"
>  #include "error.h"
>  #include "mtu.h"
> @@ -57,6 +61,17 @@ static struct WSAData wsa_state; /* GLOBAL */
>  static bool pause_exit_enabled =3D false; /* GLOBAL */
>   /*
> + * WFP firewall name.
> + */
> +const WCHAR * FIREWALL_NAME =3D L"OpenVPN"; /* GLOBAL */
> +
> +/*
> + * WFP handle and GUID.
> + */
> +static HANDLE m_hEngineHandle =3D NULL; /* GLOBAL */
> +static GUID m_subLayerGUID; /* GLOBAL */
> +
> +/*
>   * win32_signal is used to get input from the keyboard
>   * if we are running in a console, or get input from an
>   * event object if we are running as a service.
> @@ -1019,4 +1034,161 @@ win_get_tempdir()
>    WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof (tmpdir),=
 NULL, NULL);
>    return tmpdir;
>  }
> +
> +#if _WIN32_WINNT >=3D 0x0600
> +bool
> +win_wfp_init()
> +{
> +    ZeroMemory(&m_subLayerGUID, sizeof(GUID));
> +    DWORD dwFwAPiRetCode =3D ERROR_BAD_COMMAND;
> +    FWPM_SESSION0 session =3D {0};
> +    RPC_STATUS rpcStatus =3D {0};
> +    FWPM_SUBLAYER0 SubLayer =3D {0};
> +
> +    /* Add temporary filters which don't survive reboots or crashes. */
> +    session.flags =3D FWPM_SESSION_FLAG_DYNAMIC;
> +
> +    dmsg (D_LOW, "Opening WFP engine");
> +    dwFwAPiRetCode =3D FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &s=
ession, &m_hEngineHandle);
> +
> +    if (dwFwAPiRetCode !=3D ERROR_SUCCESS)
> +    {
> +        msg (M_NONFATAL, "Can't open WFP engine");
> +        return false;
> +    }
> +
> +    rpcStatus =3D UuidCreate(&SubLayer.subLayerKey);
> +    if (rpcStatus !=3D NO_ERROR)
> +        return false;
> +    CopyMemory(&m_subLayerGUID, &SubLayer.subLayerKey, sizeof(SubLayer.s=
ubLayerKey));
> +
> +    /* Populate packet filter layer information. */
> +    SubLayer.displayData.name =3D FIREWALL_NAME;
> +    SubLayer.displayData.description =3D FIREWALL_NAME;
> +    SubLayer.flags =3D 0;
> +    SubLayer.weight =3D 0x100;
> +
> +    /* Add packet filter to our interface. */
> +    dmsg (D_LOW, "Adding WFP sublayer");
> +    dwFwAPiRetCode =3D FwpmSubLayerAdd0(m_hEngineHandle, &SubLayer, NULL=
);
> +    if (dwFwAPiRetCode !=3D ERROR_SUCCESS)
> +    {
> +        msg (M_NONFATAL, "Can't add WFP sublayer");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +bool
> +win_wfp_uninit()
> +{
> +    dmsg (D_LOW, "Uninitializing WFP");
> +    DWORD dwFwAPiRetCode =3D ERROR_BAD_COMMAND;
> +    if (m_hEngineHandle) {
> +        FwpmSubLayerDeleteByKey0(m_hEngineHandle, &m_subLayerGUID);
> +        ZeroMemory(&m_subLayerGUID, sizeof(GUID));
> +        FwpmEngineClose0(m_hEngineHandle);
> +        m_hEngineHandle =3D NULL;
> +    }
> +    return true;
> +}
> +
> +bool
> +win_wfp_add_filter (HANDLE engineHandle,
> +                    const FWPM_FILTER0 *filter,
> +                    PSECURITY_DESCRIPTOR sd,
> +                    UINT64 *id)
> +{
> +    if (FwpmFilterAdd0(engineHandle, filter, sd, id) !=3D ERROR_SUCCESS)
> +    {
> +        msg (M_NONFATAL, "Can't add WFP filter");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +bool
> +win_wfp_block_dns (const NET_IFINDEX index)
> +{
> +    dmsg (D_LOW, "Blocking DNS using WFP");
> +    NET_LUID tapluid;
> +    NETIO_STATUS ret;
> +    DWORD dwFwAPiRetCode =3D ERROR_BAD_COMMAND;
> +    UINT64 filterid;
> +    WCHAR openvpnpath[MAX_PATH];
> +    FWP_BYTE_BLOB *openvpnblob =3D NULL;
> +
> +    FWPM_FILTER0 Filter =3D {0};
> +    FWPM_FILTER_CONDITION0 Condition[2] =3D {0};
> +
> +    ret =3D ConvertInterfaceIndexToLuid(index, &tapluid);
> +    if (ret =3D=3D NO_ERROR)
> +        dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
> +
> +    /* Get OpenVPN path. */
> +    GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
> +
> +    if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) !=3D ERROR_=
SUCCESS)
> +        return false;
> +
> +    /* Prepare filter. */
> +    Filter.subLayerKey =3D m_subLayerGUID;
> +    Filter.displayData.name =3D FIREWALL_NAME;
> +    Filter.weight.type =3D FWP_EMPTY;
> +    Filter.filterCondition =3D Condition;
> +    Filter.numFilterConditions =3D 2;
> +
> +    /* First filter. Block IPv4 DNS queries except from OpenVPN itself. =
*/
> +    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
> +    Filter.action.type =3D FWP_ACTION_BLOCK;
> +
> +    Condition[0].fieldKey =3D FWPM_CONDITION_IP_REMOTE_PORT;
> +    Condition[0].matchType =3D FWP_MATCH_EQUAL;
> +    Condition[0].conditionValue.type =3D FWP_UINT16;
> +    Condition[0].conditionValue.uint16 =3D 53;
> +
> +    Condition[1].fieldKey =3D FWPM_CONDITION_ALE_APP_ID;
> +    Condition[1].matchType =3D FWP_MATCH_NOT_EQUAL;
> +    Condition[1].conditionValue.type =3D FWP_BYTE_BLOB_TYPE;
> +    Condition[1].conditionValue.byteBlob =3D openvpnblob;
> +
> +    /* Add filter condition to our interface. */
> +    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
> +        return false;
> +    dmsg (D_LOW, "Filter (Block IPv4 DNS) added with ID=3D%I64d", filter=
id);
> +
> +    /* Second filter. Block IPv6 DNS queries except from OpenVPN itself.=
 */
> +    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
> +
> +    /* Add filter condition to our interface. */
> +    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
> +        return false;
> +    dmsg (D_LOW, "Filter (Block IPv6 DNS) added with ID=3D%I64d", filter=
id);
> +
> +    /* Third filter. Permit IPv4 DNS queries from TAP. */
> +    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
> +    Filter.action.type =3D FWP_ACTION_PERMIT;
> +
> +    Condition[1].fieldKey =3D FWPM_CONDITION_IP_LOCAL_INTERFACE;
> +    Condition[1].matchType =3D FWP_MATCH_EQUAL;
> +    Condition[1].conditionValue.type =3D FWP_UINT64;
> +    Condition[1].conditionValue.uint64 =3D &tapluid.Value;
> +
> +    /* Add filter condition to our interface. */
> +    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
> +        return false;
> +    dmsg (D_LOW, "Filter (Permit IPv4 DNS queries from TAP) added with I=
D=3D%I64d", filterid);
> +
> +    /* Forth filter. Permit IPv6 DNS queries from TAP. */
> +    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
> +
> +    /* Add filter condition to our interface. */
> +    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
> +        return false;
> +    dmsg (D_LOW, "Filter (Permit IPv6 DNS queries from TAP) added with I=
D=3D%I64d", filterid);
> +
> +    return true;
> +}
> +
> +#endif
>  #endif
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index cc18f02..d26b247 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -27,6 +27,10 @@
>  #define OPENVPN_WIN32_H
>   #include "mtu.h"
> +#if _WIN32_WINNT >=3D 0x0600
> +#include <initguid.h>
> +#include <fwpmtypes.h>
> +#endif
>   /* location of executables */
>  #define SYS_PATH_ENV_VAR_NAME "SystemRoot"  /* environmental variable na=
me that normally contains the system path */
> @@ -271,5 +275,65 @@ const char *win_get_tempdir();
>  /* Convert a string from UTF-8 to UCS-2 */
>  WCHAR *wide_string (const char* utf8, struct gc_arena *gc);
>  +#if _WIN32_WINNT >=3D 0x0600
> +bool win_wfp_block_dns(const NET_IFINDEX index);
> +bool win_wfp_add_filter (HANDLE engineHandle,
> +                        const FWPM_FILTER0 *filter,
> +                        PSECURITY_DESCRIPTOR sd,
> +                        UINT64 *id);
> +bool win_wfp_uninit();
> +bool win_wfp_init();
> +
> +/* WFP-related define and GUIDs */
> +#ifndef FWPM_SESSION_FLAG_DYNAMIC
> +#define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
> +#endif
> +
> +// c38d57d1-05a7-4c33-904f-7fbceee60e82
> +DEFINE_GUID(
> +   FWPM_LAYER_ALE_AUTH_CONNECT_V4,
> +   0xc38d57d1,
> +   0x05a7,
> +   0x4c33,
> +   0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82
> +);
> +
> +// 4a72393b-319f-44bc-84c3-ba54dcb3b6b4
> +DEFINE_GUID(
> +   FWPM_LAYER_ALE_AUTH_CONNECT_V6,
> +   0x4a72393b,
> +   0x319f,
> +   0x44bc,
> +   0x84, 0xc3, 0xba, 0x54, 0xdc, 0xb3, 0xb6, 0xb4
> +);
> +
> +// d78e1e87-8644-4ea5-9437-d809ecefc971
> +DEFINE_GUID(
> +   FWPM_CONDITION_ALE_APP_ID,
> +   0xd78e1e87,
> +   0x8644,
> +   0x4ea5,
> +   0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71
> +);
> +
> +// c35a604d-d22b-4e1a-91b4-68f674ee674b
> +DEFINE_GUID(
> +   FWPM_CONDITION_IP_REMOTE_PORT,
> +   0xc35a604d,
> +   0xd22b,
> +   0x4e1a,
> +   0x91, 0xb4, 0x68, 0xf6, 0x74, 0xee, 0x67, 0x4b
> +);
> +
> +// 4cd62a49-59c3-4969-b7f3-bda5d32890a4
> +DEFINE_GUID(
> +   FWPM_CONDITION_IP_LOCAL_INTERFACE,
> +   0x4cd62a49,
> +   0x59c3,
> +   0x4969,
> +   0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
> +);
> +
> +#endif
>  #endif
>  #endif


--------------050300040604070205000109
Content-Type: text/x-patch;
	name="0001-Add-Windows-DNS-Leak-fix-using-WFP-block-outside-dns.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-Add-Windows-DNS-Leak-fix-using-WFP-block-outside-dns.pa";
	filename*1="tch"

=46rom 29891bb13c4a60743de2b002a474a51f3a8ad3b0 Mon Sep 17 00:00:00 2001
In-Reply-To: <562EB0A1.8010403@...2070...>
References: <562EB0A1.8010403@...2070...>
From: ValdikSS <iam@...2070...>
Date: Tue, 27 Oct 2015 20:20:29 +0300
Subject: [PATCH v2] Add Windows DNS Leak fix using WFP ('block-outside-dn=
s')

This option is silently ignored on non-Windows platforms and works on Vis=
ta+.
External DNS is blocked even if no DNS server configured (user may config=
ure it in the tap interface itself).
This option could be ignored from server push using route-nopull.

v2:
* Add missing libs to MSVC project file.
* Add ifndef for FWPM_SESSION_FLAG_DYNAMIC to silence warning in MSVC.
* Use const WCHAR for firewall name.
* Block all traffic to TCP/UDP port 53 except for OpenVPN itself. Blockin=
g only svchost.exe is not reliable as user could disable dnscache service=
 making all applications resolve DNS from their processes.
---
 doc/openvpn.8               |  11 ++-
 src/openvpn/Makefile.am     |   2 +-
 src/openvpn/init.c          |  24 +++++++
 src/openvpn/openvpn.vcxproj |   4 +-
 src/openvpn/options.c       |  14 ++++
 src/openvpn/options.h       |   1 +
 src/openvpn/win32.c         | 172 ++++++++++++++++++++++++++++++++++++++=
++++++
 src/openvpn/win32.h         |  64 +++++++++++++++++
 8 files changed, 287 insertions(+), 5 deletions(-)
 mode change 100755 =3D> 100644 src/openvpn/openvpn.vcxproj

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b6d5aed..136473e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1129,8 +1129,8 @@ When used with
 .B \-\-client
 or
 .B \-\-pull,
-accept options pushed by server EXCEPT for routes and dhcp options
-like DNS servers.
+accept options pushed by server EXCEPT for routes, block-outside-dns and=
 dhcp
+options like DNS servers.
=20
 When used on the client, this option effectively bars the
 server from adding routes to the client's routing table,
@@ -5517,6 +5517,13 @@ adapter list to the syslog or log file after the T=
UN/TAP adapter
 has been brought up and any routes have been added.
 .\"*********************************************************
 .TP
+.B \-\-block\-outside\-dns
+Block external DNS servers on other network adapters to prevent
+DNS leaks. This option prevents any application from accessing
+TCP or UDP port 53 except one inside the tunnel. It uses WFP and
+works on Windows Vista and later.
+.\"*********************************************************
+.TP
 .B \-\-dhcp\-renew
 Ask Windows to renew the TAP adapter lease on startup.
 This option is normally unnecessary, as Windows automatically
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index c840f16..c55a520 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -127,5 +127,5 @@ openvpn_LDADD =3D \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES +=3D openvpn_win32_resources.rc
-openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm
+openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm -lfwpuclnt -lrpcrt4
 endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c5c0ab6..b1c23fd 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1468,6 +1468,22 @@ do_open_tun (struct context *c)
 		   "up",
 		   c->c2.es);
=20
+#if _WIN32_WINNT >=3D 0x0600
+      if (c->options.block_outside_dns)
+      {
+          if (!win_wfp_init())
+            msg (M_NONFATAL, "Initialising WFP failed!");
+            else
+            {
+                dmsg (D_LOW, "Blocking outside DNS");
+                if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
+                    msg (M_NONFATAL, "Blocking DNS failed!");
+            }
+      }
+      else
+           msg (M_NONFATAL, "Can't block outside DNS without configured =
DNS server");
+#endif
+
       /* possibly add routes */
       if ((route_order() =3D=3D ROUTE_AFTER_TUN) && (!c->options.route_d=
elay_defined))
 	do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
@@ -1596,6 +1612,14 @@ do_close_tun (struct context *c, bool force)
 		       "down",
 		       c->c2.es);
=20
+#if _WIN32_WINNT >=3D 0x0600
+            if (c->options.block_outside_dns)
+            {
+                if (!win_wfp_uninit())
+                    msg (M_NONFATAL, "Uninitialising WFP failed!");
+            }
+#endif
+
 	  /* actually close tun/tap device based on --down-pre flag */
 	  if (c->options.down_pre)
 	    do_close_tun_simple (c);
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
old mode 100755
new mode 100644
index b117b0b..821c46c
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -64,7 +64,7 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;=
winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;=
winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDe=
pendencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;=
$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDir=
ectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
@@ -89,7 +89,7 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;=
winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;=
winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDe=
pendencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;=
$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDir=
ectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2f8915d..a7f50cc 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -696,6 +696,9 @@ static const char usage_message[] =3D
   "                       optional parameter controls the initial state =
of ex.\n"
   "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and n=
et adapter list\n"
   "                  after TAP adapter is up and routes have been added.=
\n"
+#if _WIN32_WINNT >=3D 0x0600
+  "--block-outside-dns   : Block DNS on other network adapters to preven=
t DNS leaks\n"
+#endif
   "Windows Standalone Options:\n"
   "\n"
   "--show-adapters : Show all TAP-Windows adapters.\n"
@@ -797,6 +800,7 @@ init_options (struct options *o, const bool init_gc)
   o->tuntap_options.dhcp_lease_time =3D 31536000; /* one year */
   o->tuntap_options.dhcp_masq_offset =3D 0;       /* use network address=
 as internal DHCP server address */
   o->route_method =3D ROUTE_METHOD_ADAPTIVE;
+  o->block_outside_dns =3D false;
 #endif
 #if P2MP_SERVER
   o->real_hash_size =3D 256;
@@ -1651,6 +1655,9 @@ show_settings (const struct options *o)
 #ifdef WIN32
   SHOW_BOOL (show_net_up);
   SHOW_INT (route_method);
+#if _WIN32_WINNT >=3D 0x0600
+  SHOW_BOOL (block_outside_dns);
+#endif
   show_tuntap_options (&o->tuntap_options);
 #endif
 #endif
@@ -6222,6 +6229,13 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
     }
 #endif
+  else if (streq (p[0], "block-outside-dns") && !p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_IPWIN32);
+#if _WIN32_WINNT >=3D 0x0600
+      options->block_outside_dns =3D true;
+#endif
+    }
 #if PASSTOS_CAPABILITY
   else if (streq (p[0], "passtos") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c642aa0..873c159 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -587,6 +587,7 @@ struct options
   bool exit_event_initial_state;
   bool show_net_up;
   int route_method;
+  bool block_outside_dns;
 #endif
=20
   bool use_peer_id;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 7c89a5a..4c44901 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -37,6 +37,10 @@
=20
 #ifdef WIN32
=20
+#include <fwpmu.h>
+#include <fwpmtypes.h>
+#include <iphlpapi.h>
+
 #include "buffer.h"
 #include "error.h"
 #include "mtu.h"
@@ -57,6 +61,17 @@ static struct WSAData wsa_state; /* GLOBAL */
 static bool pause_exit_enabled =3D false; /* GLOBAL */
=20
 /*
+ * WFP firewall name.
+ */
+const WCHAR * FIREWALL_NAME =3D L"OpenVPN"; /* GLOBAL */
+
+/*
+ * WFP handle and GUID.
+ */
+static HANDLE m_hEngineHandle =3D NULL; /* GLOBAL */
+static GUID m_subLayerGUID; /* GLOBAL */
+
+/*
  * win32_signal is used to get input from the keyboard
  * if we are running in a console, or get input from an
  * event object if we are running as a service.
@@ -1019,4 +1034,161 @@ win_get_tempdir()
   WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof (tmpdir),=
 NULL, NULL);
   return tmpdir;
 }
+
+#if _WIN32_WINNT >=3D 0x0600
+bool
+win_wfp_init()
+{
+    ZeroMemory(&m_subLayerGUID, sizeof(GUID));
+    DWORD dwFwAPiRetCode =3D ERROR_BAD_COMMAND;
+    FWPM_SESSION0 session =3D {0};
+    RPC_STATUS rpcStatus =3D {0};
+    FWPM_SUBLAYER0 SubLayer =3D {0};
+
+    /* Add temporary filters which don't survive reboots or crashes. */
+    session.flags =3D FWPM_SESSION_FLAG_DYNAMIC;
+
+    dmsg (D_LOW, "Opening WFP engine");
+    dwFwAPiRetCode =3D FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &s=
ession, &m_hEngineHandle);
+
+    if (dwFwAPiRetCode !=3D ERROR_SUCCESS)
+    {
+        msg (M_NONFATAL, "Can't open WFP engine");
+        return false;
+    }
+
+    rpcStatus =3D UuidCreate(&SubLayer.subLayerKey);
+    if (rpcStatus !=3D NO_ERROR)
+        return false;
+    CopyMemory(&m_subLayerGUID, &SubLayer.subLayerKey, sizeof(SubLayer.s=
ubLayerKey));
+
+    /* Populate packet filter layer information. */
+    SubLayer.displayData.name =3D FIREWALL_NAME;
+    SubLayer.displayData.description =3D FIREWALL_NAME;
+    SubLayer.flags =3D 0;
+    SubLayer.weight =3D 0x100;
+
+    /* Add packet filter to our interface. */
+    dmsg (D_LOW, "Adding WFP sublayer");
+    dwFwAPiRetCode =3D FwpmSubLayerAdd0(m_hEngineHandle, &SubLayer, NULL=
);
+    if (dwFwAPiRetCode !=3D ERROR_SUCCESS)
+    {
+        msg (M_NONFATAL, "Can't add WFP sublayer");
+        return false;
+    }
+    return true;
+}
+
+bool
+win_wfp_uninit()
+{
+    dmsg (D_LOW, "Uninitializing WFP");
+    DWORD dwFwAPiRetCode =3D ERROR_BAD_COMMAND;
+    if (m_hEngineHandle) {
+        FwpmSubLayerDeleteByKey0(m_hEngineHandle, &m_subLayerGUID);
+        ZeroMemory(&m_subLayerGUID, sizeof(GUID));
+        FwpmEngineClose0(m_hEngineHandle);
+        m_hEngineHandle =3D NULL;
+    }
+    return true;
+}
+
+bool
+win_wfp_add_filter (HANDLE engineHandle,
+                    const FWPM_FILTER0 *filter,
+                    PSECURITY_DESCRIPTOR sd,
+                    UINT64 *id)
+{
+    if (FwpmFilterAdd0(engineHandle, filter, sd, id) !=3D ERROR_SUCCESS)=

+    {
+        msg (M_NONFATAL, "Can't add WFP filter");
+        return false;
+    }
+    return true;
+}
+
+bool
+win_wfp_block_dns (const NET_IFINDEX index)
+{
+    dmsg (D_LOW, "Blocking DNS using WFP");
+    NET_LUID tapluid;
+    NETIO_STATUS ret;
+    DWORD dwFwAPiRetCode =3D ERROR_BAD_COMMAND;
+    UINT64 filterid;
+    WCHAR openvpnpath[MAX_PATH];
+    FWP_BYTE_BLOB *openvpnblob =3D NULL;
+
+    FWPM_FILTER0 Filter =3D {0};
+    FWPM_FILTER_CONDITION0 Condition[2] =3D {0};
+
+    ret =3D ConvertInterfaceIndexToLuid(index, &tapluid);
+    if (ret =3D=3D NO_ERROR)
+        dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
+
+    /* Get OpenVPN path. */
+    GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
+
+    if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) !=3D ERROR_=
SUCCESS)
+        return false;
+
+    /* Prepare filter. */
+    Filter.subLayerKey =3D m_subLayerGUID;
+    Filter.displayData.name =3D FIREWALL_NAME;
+    Filter.weight.type =3D FWP_EMPTY;
+    Filter.filterCondition =3D Condition;
+    Filter.numFilterConditions =3D 2;
+
+    /* First filter. Block IPv4 DNS queries except from OpenVPN itself. =
*/
+    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type =3D FWP_ACTION_BLOCK;
+
+    Condition[0].fieldKey =3D FWPM_CONDITION_IP_REMOTE_PORT;
+    Condition[0].matchType =3D FWP_MATCH_EQUAL;
+    Condition[0].conditionValue.type =3D FWP_UINT16;
+    Condition[0].conditionValue.uint16 =3D 53;
+
+    Condition[1].fieldKey =3D FWPM_CONDITION_ALE_APP_ID;
+    Condition[1].matchType =3D FWP_MATCH_NOT_EQUAL;
+    Condition[1].conditionValue.type =3D FWP_BYTE_BLOB_TYPE;
+    Condition[1].conditionValue.byteBlob =3D openvpnblob;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        return false;
+    dmsg (D_LOW, "Filter (Block IPv4 DNS) added with ID=3D%I64d", filter=
id);
+
+    /* Second filter. Block IPv6 DNS queries except from OpenVPN itself.=
 */
+    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        return false;
+    dmsg (D_LOW, "Filter (Block IPv6 DNS) added with ID=3D%I64d", filter=
id);
+
+    /* Third filter. Permit IPv4 DNS queries from TAP. */
+    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type =3D FWP_ACTION_PERMIT;
+
+    Condition[1].fieldKey =3D FWPM_CONDITION_IP_LOCAL_INTERFACE;
+    Condition[1].matchType =3D FWP_MATCH_EQUAL;
+    Condition[1].conditionValue.type =3D FWP_UINT64;
+    Condition[1].conditionValue.uint64 =3D &tapluid.Value;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        return false;
+    dmsg (D_LOW, "Filter (Permit IPv4 DNS queries from TAP) added with I=
D=3D%I64d", filterid);
+
+    /* Forth filter. Permit IPv6 DNS queries from TAP. */
+    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        return false;
+    dmsg (D_LOW, "Filter (Permit IPv6 DNS queries from TAP) added with I=
D=3D%I64d", filterid);
+
+    return true;
+}
+
+#endif
 #endif
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index cc18f02..d26b247 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -27,6 +27,10 @@
 #define OPENVPN_WIN32_H
=20
 #include "mtu.h"
+#if _WIN32_WINNT >=3D 0x0600
+#include <initguid.h>
+#include <fwpmtypes.h>
+#endif
=20
 /* location of executables */
 #define SYS_PATH_ENV_VAR_NAME "SystemRoot"  /* environmental variable na=
me that normally contains the system path */
@@ -271,5 +275,65 @@ const char *win_get_tempdir();
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string (const char* utf8, struct gc_arena *gc);
=20
+#if _WIN32_WINNT >=3D 0x0600
+bool win_wfp_block_dns(const NET_IFINDEX index);
+bool win_wfp_add_filter (HANDLE engineHandle,
+                        const FWPM_FILTER0 *filter,
+                        PSECURITY_DESCRIPTOR sd,
+                        UINT64 *id);
+bool win_wfp_uninit();
+bool win_wfp_init();
+
+/* WFP-related define and GUIDs */
+#ifndef FWPM_SESSION_FLAG_DYNAMIC
+#define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
+#endif
+
+// c38d57d1-05a7-4c33-904f-7fbceee60e82
+DEFINE_GUID(
+   FWPM_LAYER_ALE_AUTH_CONNECT_V4,
+   0xc38d57d1,
+   0x05a7,
+   0x4c33,
+   0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82
+);
+
+// 4a72393b-319f-44bc-84c3-ba54dcb3b6b4
+DEFINE_GUID(
+   FWPM_LAYER_ALE_AUTH_CONNECT_V6,
+   0x4a72393b,
+   0x319f,
+   0x44bc,
+   0x84, 0xc3, 0xba, 0x54, 0xdc, 0xb3, 0xb6, 0xb4
+);
+
+// d78e1e87-8644-4ea5-9437-d809ecefc971
+DEFINE_GUID(
+   FWPM_CONDITION_ALE_APP_ID,
+   0xd78e1e87,
+   0x8644,
+   0x4ea5,
+   0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71
+);
+
+// c35a604d-d22b-4e1a-91b4-68f674ee674b
+DEFINE_GUID(
+   FWPM_CONDITION_IP_REMOTE_PORT,
+   0xc35a604d,
+   0xd22b,
+   0x4e1a,
+   0x91, 0xb4, 0x68, 0xf6, 0x74, 0xee, 0x67, 0x4b
+);
+
+// 4cd62a49-59c3-4969-b7f3-bda5d32890a4
+DEFINE_GUID(
+   FWPM_CONDITION_IP_LOCAL_INTERFACE,
+   0x4cd62a49,
+   0x59c3,
+   0x4969,
+   0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
+);
+
+#endif
 #endif
 #endif
--=20
2.6.2


--------------050300040604070205000109--

--9vXbPb1wpaWJELnLFuqCliBJTlG3xIe8p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWMIOzAAoJEFzXIC7viPdy1ZQP/34urtHxW+9acXpgB1zCdMcK
f7atzxt1eWkTDpmJb1I12dAPtgL9KbSk1OfFmv5ph0QYNEWLtSupVi4os+U/NHCm
+oSU0EU+ixIjjdGCgm6ejK4SMFj1Wgfth2vCuXFFQ8i73rdWLxmLC7fkWg06mWX0
TM558ybICPptFUFwt30lvePdZn7wFG9dqiK0frH6EMZ6rX42y2bkuiJdcghW11Dp
kYGILTJtkvdlpK9yl6MvWRXSfnv65cAyCZ7ZBe6fpAO2f5lQP26sUJYWzBOHq/uI
iQlIRt3jE6oQGm9h/q8m5UsuZGdEr5YkKUtKVHYyksEolOZuKA95Gxh7nxhMwUDZ
ySeAtpLCMU4DzmU7OWx9lWxOeJpN55ErGjZuesfT9wz43Lk9LVbYcOCFSH+V/8xD
3Lbc/ijiSBsv4C8NcQX/x3Ubx0i3A7ixm+zA20Rn15Ku95Kmd8gxSjS0o1WlvKON
eHU8Oc60Kx9UsEHsL93ZuyMe7msak1fo44JZL1QYGvtiMAmL89liLlnFK1NzJASn
uAiuWxD0ONrAsP+2jf4gK2nZ6enBaj2Gth2HpK0+z4IK+1O91nHn2H/z7m0vPbSA
n6UDQqrK2dkcXeu4uPaeQWn6vWp49LNFysIw/xvhHsjIqRaK8prhhg19dGOsxWBP
NR3wdwZ0eCEzEix0QGpq
=J8C4
-----END PGP SIGNATURE-----

--9vXbPb1wpaWJELnLFuqCliBJTlG3xIe8p--

