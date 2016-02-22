MIME-Version: 1.0
In-Reply-To: <1456159047-37064-1-git-send-email-fish.thss@...277...>
References: <1456159047-37064-1-git-send-email-fish.thss@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Feb 2016 12:00:10 -0500
Message-ID: <CAKuzo_hOQutE6G0a9oHqb7Zef7km1ohiZ=Ed9dwcR6XcVqGX0A@...278...>
Content-Type: multipart/alternative; boundary=001a114771f02e465d052c5ec50e
Subject: Re: [Openvpn-devel] [PATCH] Make openvpnserv compilable under
	Visual Studio.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114771f02e465d052c5ec50e
Content-Type: text/plain; charset=UTF-8

Hi,

I think we can just delete all those function typedefs and run-time lookups
as this is targeted towards Vista+ only.

Selva

On Mon, Feb 22, 2016 at 11:37 AM, <fish.thss@...277...> wrote:

> From: Fish <fish.thss@...277...>
>
> Compiled under VS 2010/2013 and Windows 10.
>
> The following major changes are made:
> - Use the correct typedef construct to define function types.
> - Make sure local header inclusion uses double-quotes instead of angle
>   brackets.
> - Update openvpnserv.vcxproj to include new source files and headers, as
>   well as additional lib files.
> ---
>  src/openvpnserv/common.c                    |  2 +-
>  src/openvpnserv/interactive.c               | 16 ++++++++--------
>  src/openvpnserv/openvpnserv.vcxproj         | 12 ++++++++----
>  src/openvpnserv/openvpnserv.vcxproj.filters | 10 ++++++++--
>  4 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
> index a293796..9a58e39 100644
> --- a/src/openvpnserv/common.c
> +++ b/src/openvpnserv/common.c
> @@ -22,7 +22,7 @@
>   *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>
> -#include <service.h>
> +#include "service.h"
>
>  /*
>   * These are necessary due to certain buggy implementations of
> (v)snprintf,
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 0f3d1d4..96a15f6 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -390,7 +390,7 @@ InterfaceLuid (const char *iface_name, PNET_LUID luid)
>    LPWSTR wide_name;
>    int n;
>
> -  typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidFn) (LPCWSTR,
> PNET_LUID);
> +  typedef NETIO_STATUS (WINAPI *ConvertInterfaceAliasToLuidFn) (LPCWSTR,
> PNET_LUID);
>    static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasToLuid = NULL;
>    if (!ConvertInterfaceAliasToLuid)
>      {
> @@ -421,7 +421,7 @@ CmpAddress (LPVOID item, LPVOID address)
>  static DWORD
>  DeleteAddress (PMIB_UNICASTIPADDRESS_ROW addr_row)
>  {
> -  typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryFn) (const
> PMIB_UNICASTIPADDRESS_ROW);
> +  typedef NETIO_STATUS (NETIOAPI_API_ *DeleteUnicastIpAddressEntryFn)
> (const PMIB_UNICASTIPADDRESS_ROW);
>    static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressEntry = NULL;
>
>    if (!DeleteUnicastIpAddressEntry)
> @@ -445,8 +445,8 @@ HandleAddressMessage (address_message_t *msg,
> undo_lists_t *lists)
>    PMIB_UNICASTIPADDRESS_ROW addr_row;
>    BOOL add = msg->header.type == msg_add_address;
>
> -  typedef NETIOAPI_API (*CreateUnicastIpAddressEntryFn) (const
> PMIB_UNICASTIPADDRESS_ROW);
> -  typedef NETIOAPI_API (*InitializeUnicastIpAddressEntryFn)
> (PMIB_UNICASTIPADDRESS_ROW);
> +  typedef NETIO_STATUS (NETIOAPI_API_ *CreateUnicastIpAddressEntryFn)
> (const PMIB_UNICASTIPADDRESS_ROW);
> +  typedef NETIO_STATUS (NETIOAPI_API_ *InitializeUnicastIpAddressEntryFn)
> (PMIB_UNICASTIPADDRESS_ROW);
>    static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressEntry = NULL;
>    static InitializeUnicastIpAddressEntryFn
> InitializeUnicastIpAddressEntry = NULL;
>
> @@ -522,7 +522,7 @@ CmpRoute (LPVOID item, LPVOID route)
>  static DWORD
>  DeleteRoute (PMIB_IPFORWARD_ROW2 fwd_row)
>  {
> -  typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
> +  typedef NETIO_STATUS (NETIOAPI_API_ *DeleteIpForwardEntry2Fn)
> (PMIB_IPFORWARD_ROW2);
>    static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 = NULL;
>
>    if (!DeleteIpForwardEntry2)
> @@ -546,7 +546,7 @@ HandleRouteMessage (route_message_t *msg, undo_lists_t
> *lists)
>    PMIB_IPFORWARD_ROW2 fwd_row;
>    BOOL add = msg->header.type == msg_add_route;
>
> -  typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
> +  typedef NETIO_STATUS (NETIOAPI_API_ *CreateIpForwardEntry2Fn)
> (PMIB_IPFORWARD_ROW2);
>    static CreateIpForwardEntry2Fn CreateIpForwardEntry2 = NULL;
>
>    if (!CreateIpForwardEntry2)
> @@ -616,7 +616,7 @@ out:
>  static DWORD
>  HandleFlushNeighborsMessage (flush_neighbors_message_t *msg)
>  {
> -  typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY,
> NET_IFINDEX);
> +  typedef NETIO_STATUS (NETIOAPI_API_ *FlushIpNetTable2Fn)
> (ADDRESS_FAMILY, NET_IFINDEX);
>    static FlushIpNetTable2Fn flush_fn = NULL;
>
>    if (msg->family == AF_INET)
> @@ -1154,6 +1154,7 @@ FreeWaitHandles (LPHANDLE h)
>    free (h);
>  }
>
> +BOOL CmpHandle(LPVOID item, LPVOID hnd) { return item == hnd; }
>
>  VOID WINAPI
>  ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
> @@ -1254,7 +1255,6 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR
> *lpszArgv)
>              }
>
>            /* Worker thread ended */
> -          BOOL CmpHandle (LPVOID item, LPVOID hnd) { return item == hnd; }
>            HANDLE thread = RemoveListItem (&threads, CmpHandle,
> handles[error]);
>            UpdateWaitHandles (&handles, &handle_count, io_event,
> exit_event, threads);
>            CloseHandleEx (&thread);
> diff --git a/src/openvpnserv/openvpnserv.vcxproj
> b/src/openvpnserv/openvpnserv.vcxproj
> index c6760da..545a846 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj
> +++ b/src/openvpnserv/openvpnserv.vcxproj
> @@ -49,7 +49,7 @@
>    <ItemDefinitionGroup
> Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
>      <ClCompile>
>        <Optimization>Disabled</Optimization>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
> +
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
>
>  <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
>        <MinimalRebuild>true</MinimalRebuild>
>        <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> @@ -66,13 +66,14 @@
>        <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
>        <TargetMachine>MachineX86</TargetMachine>
> +
> <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
>      <ClCompile>
>        <Optimization>MaxSpeed</Optimization>
>        <IntrinsicFunctions>true</IntrinsicFunctions>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
> +
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
>
>  <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
>        <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
>        <FunctionLevelLinking>true</FunctionLevelLinking>
> @@ -90,10 +91,13 @@
>        <OptimizeReferences>true</OptimizeReferences>
>        <EnableCOMDATFolding>true</EnableCOMDATFolding>
>        <TargetMachine>MachineX86</TargetMachine>
> +
> <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemGroup>
> -    <ClCompile Include="openvpnserv.c" />
> +    <ClCompile Include="automatic.c" />
> +    <ClCompile Include="common.c" />
> +    <ClCompile Include="interactive.c" />
>      <ClCompile Include="service.c" />
>    </ItemGroup>
>    <ItemGroup>
> @@ -111,4 +115,4 @@
>    <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
>    <ImportGroup Label="ExtensionTargets">
>    </ImportGroup>
> -</Project>
> +</Project>
> \ No newline at end of file
> diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters
> b/src/openvpnserv/openvpnserv.vcxproj.filters
> index 0c89b4f..a016c52 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj.filters
> +++ b/src/openvpnserv/openvpnserv.vcxproj.filters
> @@ -15,10 +15,16 @@
>      </Filter>
>    </ItemGroup>
>    <ItemGroup>
> -    <ClCompile Include="openvpnserv.c">
> +    <ClCompile Include="service.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
> -    <ClCompile Include="service.c">
> +    <ClCompile Include="automatic.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include="common.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include="interactive.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
>    </ItemGroup>
> --
> 2.6.4
>
>
>
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114771f02e465d052c5ec50e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I think we can just delete all thos=
e function typedefs and run-time lookups as this is targeted towards Vista+=
 only.</div><div><br></div><div>Selva</div></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Mon, Feb 22, 2016 at 11:37 AM,  <span di=
r=3D"ltr">&lt;<a href=3D"mailto:fish.thss@...277..." target=3D"_blank">fish=
.thss@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Fro=
m: Fish &lt;<a href=3D"mailto:fish.thss@...277...">fish.thss@...277...</a>&=
gt;<br>
<br>
Compiled under VS 2010/2013 and Windows 10.<br>
<br>
The following major changes are made:<br>
- Use the correct typedef construct to define function types.<br>
- Make sure local header inclusion uses double-quotes instead of angle<br>
=C2=A0 brackets.<br>
- Update openvpnserv.vcxproj to include new source files and headers, as<br>
=C2=A0 well as additional lib files.<br>
---<br>
=C2=A0src/openvpnserv/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0src/openvpnserv/interactive.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 16 ++++++++--------<br>
=C2=A0src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 12 ++++++++----<br>
=C2=A0src/openvpnserv/openvpnserv.vcxproj.filters | 10 ++++++++--<br>
=C2=A04 files changed, 25 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c<br>
index a293796..9a58e39 100644<br>
--- a/src/openvpnserv/common.c<br>
+++ b/src/openvpnserv/common.c<br>
@@ -22,7 +22,7 @@<br>
=C2=A0 *=C2=A0 59 Temple Place, Suite 330, Boston, MA=C2=A0 02111-1307=C2=
=A0 USA<br>
=C2=A0 */<br>
<br>
-#include &lt;service.h&gt;<br>
+#include &quot;service.h&quot;<br>
<br>
=C2=A0/*<br>
=C2=A0 * These are necessary due to certain buggy implementations of (v)snp=
rintf,<br>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c<=
br>
index 0f3d1d4..96a15f6 100644<br>
--- a/src/openvpnserv/interactive.c<br>
+++ b/src/openvpnserv/interactive.c<br>
@@ -390,7 +390,7 @@ InterfaceLuid (const char *iface_name, PNET_LUID luid)<=
br>
=C2=A0 =C2=A0LPWSTR wide_name;<br>
=C2=A0 =C2=A0int n;<br>
<br>
-=C2=A0 typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidFn) (LPCWS=
TR, PNET_LUID);<br>
+=C2=A0 typedef NETIO_STATUS (WINAPI *ConvertInterfaceAliasToLuidFn) (LPCWS=
TR, PNET_LUID);<br>
=C2=A0 =C2=A0static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasToLu=
id =3D NULL;<br>
=C2=A0 =C2=A0if (!ConvertInterfaceAliasToLuid)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -421,7 +421,7 @@ CmpAddress (LPVOID item, LPVOID address)<br>
=C2=A0static DWORD<br>
=C2=A0DeleteAddress (PMIB_UNICASTIPADDRESS_ROW addr_row)<br>
=C2=A0{<br>
-=C2=A0 typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryFn) (const PMIB_U=
NICASTIPADDRESS_ROW);<br>
+=C2=A0 typedef NETIO_STATUS (NETIOAPI_API_ *DeleteUnicastIpAddressEntryFn)=
 (const PMIB_UNICASTIPADDRESS_ROW);<br>
=C2=A0 =C2=A0static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressEnt=
ry =3D NULL;<br>
<br>
=C2=A0 =C2=A0if (!DeleteUnicastIpAddressEntry)<br>
@@ -445,8 +445,8 @@ HandleAddressMessage (address_message_t *msg, undo_list=
s_t *lists)<br>
=C2=A0 =C2=A0PMIB_UNICASTIPADDRESS_ROW addr_row;<br>
=C2=A0 =C2=A0BOOL add =3D msg-&gt;header.type =3D=3D msg_add_address;<br>
<br>
-=C2=A0 typedef NETIOAPI_API (*CreateUnicastIpAddressEntryFn) (const PMIB_U=
NICASTIPADDRESS_ROW);<br>
-=C2=A0 typedef NETIOAPI_API (*InitializeUnicastIpAddressEntryFn) (PMIB_UNI=
CASTIPADDRESS_ROW);<br>
+=C2=A0 typedef NETIO_STATUS (NETIOAPI_API_ *CreateUnicastIpAddressEntryFn)=
 (const PMIB_UNICASTIPADDRESS_ROW);<br>
+=C2=A0 typedef NETIO_STATUS (NETIOAPI_API_ *InitializeUnicastIpAddressEntr=
yFn) (PMIB_UNICASTIPADDRESS_ROW);<br>
=C2=A0 =C2=A0static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressEnt=
ry =3D NULL;<br>
=C2=A0 =C2=A0static InitializeUnicastIpAddressEntryFn InitializeUnicastIpAd=
dressEntry =3D NULL;<br>
<br>
@@ -522,7 +522,7 @@ CmpRoute (LPVOID item, LPVOID route)<br>
=C2=A0static DWORD<br>
=C2=A0DeleteRoute (PMIB_IPFORWARD_ROW2 fwd_row)<br>
=C2=A0{<br>
-=C2=A0 typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW=
2);<br>
+=C2=A0 typedef NETIO_STATUS (NETIOAPI_API_ *DeleteIpForwardEntry2Fn) (PMIB=
_IPFORWARD_ROW2);<br>
=C2=A0 =C2=A0static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 =3D NULL;=
<br>
<br>
=C2=A0 =C2=A0if (!DeleteIpForwardEntry2)<br>
@@ -546,7 +546,7 @@ HandleRouteMessage (route_message_t *msg, undo_lists_t =
*lists)<br>
=C2=A0 =C2=A0PMIB_IPFORWARD_ROW2 fwd_row;<br>
=C2=A0 =C2=A0BOOL add =3D msg-&gt;header.type =3D=3D msg_add_route;<br>
<br>
-=C2=A0 typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW=
2);<br>
+=C2=A0 typedef NETIO_STATUS (NETIOAPI_API_ *CreateIpForwardEntry2Fn) (PMIB=
_IPFORWARD_ROW2);<br>
=C2=A0 =C2=A0static CreateIpForwardEntry2Fn CreateIpForwardEntry2 =3D NULL;=
<br>
<br>
=C2=A0 =C2=A0if (!CreateIpForwardEntry2)<br>
@@ -616,7 +616,7 @@ out:<br>
=C2=A0static DWORD<br>
=C2=A0HandleFlushNeighborsMessage (flush_neighbors_message_t *msg)<br>
=C2=A0{<br>
-=C2=A0 typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY, NET_IFI=
NDEX);<br>
+=C2=A0 typedef NETIO_STATUS (NETIOAPI_API_ *FlushIpNetTable2Fn) (ADDRESS_F=
AMILY, NET_IFINDEX);<br>
=C2=A0 =C2=A0static FlushIpNetTable2Fn flush_fn =3D NULL;<br>
<br>
=C2=A0 =C2=A0if (msg-&gt;family =3D=3D AF_INET)<br>
@@ -1154,6 +1154,7 @@ FreeWaitHandles (LPHANDLE h)<br>
=C2=A0 =C2=A0free (h);<br>
=C2=A0}<br>
<br>
+BOOL CmpHandle(LPVOID item, LPVOID hnd) { return item =3D=3D hnd; }<br>
<br>
=C2=A0VOID WINAPI<br>
=C2=A0ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)<br>
@@ -1254,7 +1255,6 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszAr=
gv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Worker thread ended */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BOOL CmpHandle (LPVOID item, LPVOID hnd=
) { return item =3D=3D hnd; }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HANDLE thread =3D RemoveListItem (=
&amp;threads, CmpHandle, handles[error]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UpdateWaitHandles (&amp;handles, &=
amp;handle_count, io_event, exit_event, threads);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CloseHandleEx (&amp;thread);<br>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpns=
erv.vcxproj<br>
index c6760da..545a846 100644<br>
--- a/src/openvpnserv/openvpnserv.vcxproj<br>
+++ b/src/openvpnserv/openvpnserv.vcxproj<br>
@@ -49,7 +49,7 @@<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Optimization&gt;Disabled&lt;/Optimization&gt=
;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDir=
ectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;PreprocessorDefinitions&gt;WIN32;_DEBUG;_CON=
SOLE;$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;MinimalRebuild&gt;true&lt;/MinimalRebuild&gt=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/B=
asicRuntimeChecks&gt;<br>
@@ -66,13 +66,14 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;GenerateDebugInformation&gt;true&lt;/Generat=
eDebugInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;TargetMachine&gt;MachineX86&lt;/TargetMachin=
e&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Userenv.lib;Iphlpapi.li=
b;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Optimization&gt;MaxSpeed&lt;/Optimization&gt=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunc=
tions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDir=
ectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;PreprocessorDefinitions&gt;WIN32;NDEBUG;_CON=
SOLE;$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/Runti=
meLibrary&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;FunctionLevelLinking&gt;true&lt;/FunctionLev=
elLinking&gt;<br>
@@ -90,10 +91,13 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;OptimizeReferences&gt;true&lt;/OptimizeRefer=
ences&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;EnableCOMDATFolding&gt;true&lt;/EnableCOMDAT=
Folding&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;TargetMachine&gt;MachineX86&lt;/TargetMachin=
e&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Userenv.lib;Iphlpapi.li=
b;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
-=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;openvpnserv.c&quot; /&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;automatic.c&quot; /&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;common.c&quot; /&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;interactive.c&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;service.c&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
@@ -111,4 +115,4 @@<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
-&lt;/Project&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/=
openvpnserv.vcxproj.filters<br>
index 0c89b4f..a016c52 100644<br>
--- a/src/openvpnserv/openvpnserv.vcxproj.filters<br>
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters<br>
@@ -15,10 +15,16 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Filter&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
-=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;openvpnserv.c&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;service.c&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;service.c&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;automatic.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;common.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;interactive.c&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
--<br>
2.6.4<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Site24x7 APM Insight: Get Deep Visibility into Application Performance<br>
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month<br>
Monitor end-to-end web transactions and take corrective actions now<br>
Troubleshoot faster and improve end-user experience. Signup Now!<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D272487151&amp;iu=
=3D/4140" rel=3D"noreferrer" target=3D"_blank">http://pubads.g.doubleclick.=
net/gampad/clk?id=3D272487151&amp;iu=3D/4140</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br></div>

--001a114771f02e465d052c5ec50e--

