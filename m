MIME-Version: 1.0
In-Reply-To: <20171012080720.7764-1-simon@...2293...>
References: <20171012080720.7764-1-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Thu, 12 Oct 2017 22:33:14 -0400
Message-ID: <CAKuzo_jnKUHsZdYYW=Uk7AU6Q2VVvcyRnONEDto_WtmUnWUtMA@...278...>
Content-Type: multipart/alternative; boundary="001a11406242bfeaba055b647b5a"
Subject: Re: [Openvpn-devel] [PATCH] Simplify iphlpapi.dll API calls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11406242bfeaba055b647b5a
Content-Type: text/plain; charset="UTF-8"

Hi,

Note to self: this is v2 of [PATCH 05/13]
https://www.mail-archive.com/openvpn-devel@...282...
.net/msg15589.html

On Thu, Oct 12, 2017 at 4:07 AM, Simon Rozman <simon@...2293...> wrote:

> Dynamically locating API function addresses at run-time using
> GetProcAddress() was a leftover from the early days of the interactive
> service development. It was required before `NTDDI_VERSION` was raised
> from Windows XP to Windows Vista.
>
> After NTDDI_VERSION API level was raised to NTDDI_VISTA, the direct
> calling of Vista introduced API functions is possible and much
> simpler.
>
> This patch simplifies the code while in the same time it removes
> controversial function type definitions that caused interactive service
> not to compile on MSVC.
> ---
>  src/openvpnserv/interactive.c | 123 +-----------------------------
> ------------
>  1 file changed, 1 insertion(+), 122 deletions(-)
>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index a060a06..bb8c5f6 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -549,23 +549,6 @@ InterfaceLuid(const char *iface_name, PNET_LUID luid)
>      LPWSTR wide_name;
>      int n;
>
> -    typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidFn)
> (LPCWSTR, PNET_LUID);
> -    static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasToLuid =
> NULL;
> -    if (!ConvertInterfaceAliasToLuid)
> -    {
> -        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
> -        if (iphlpapi == NULL)
> -        {
> -            return GetLastError();
> -        }
> -
> -        ConvertInterfaceAliasToLuid = (ConvertInterfaceAliasToLuidFn)
> GetProcAddress(iphlpapi, "ConvertInterfaceAliasToLuid");
> -        if (!ConvertInterfaceAliasToLuid)
> -        {
> -            return GetLastError();
> -        }
> -    }
> -
>      n = MultiByteToWideChar(CP_UTF8, 0, iface_name, -1, NULL, 0);
>      wide_name = malloc(n * sizeof(WCHAR));

     MultiByteToWideChar(CP_UTF8, 0, iface_name, -1, wide_name, n);
>

Not a fault of this patch, but malloc's return value not checked... Let's
address that in a separate patch.


> @@ -584,24 +567,6 @@ CmpAddress(LPVOID item, LPVOID address)
>  static DWORD
>  DeleteAddress(PMIB_UNICASTIPADDRESS_ROW addr_row)
>  {
> -    typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryFn) (const
> PMIB_UNICASTIPADDRESS_ROW);
> -    static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressEntry =
> NULL;
> -
> -    if (!DeleteUnicastIpAddressEntry)
> -    {
> -        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
> -        if (iphlpapi == NULL)
> -        {
> -            return GetLastError();
> -        }
> -
> -        DeleteUnicastIpAddressEntry = (DeleteUnicastIpAddressEntryFn)
> GetProcAddress(iphlpapi, "DeleteUnicastIpAddressEntry");
> -        if (!DeleteUnicastIpAddressEntry)
> -        {
> -            return GetLastError();
> -        }
> -    }
> -
>      return DeleteUnicastIpAddressEntry(addr_row);
>  }
>
> @@ -612,32 +577,6 @@ HandleAddressMessage(address_message_t *msg,
> undo_lists_t *lists)
>      PMIB_UNICASTIPADDRESS_ROW addr_row;
>      BOOL add = msg->header.type == msg_add_address;
>
> -    typedef NETIOAPI_API (*CreateUnicastIpAddressEntryFn) (const
> PMIB_UNICASTIPADDRESS_ROW);
> -    typedef NETIOAPI_API (*InitializeUnicastIpAddressEntryFn)
> (PMIB_UNICASTIPADDRESS_ROW);
> -    static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressEntry =
> NULL;
> -    static InitializeUnicastIpAddressEntryFn
> InitializeUnicastIpAddressEntry = NULL;
> -
> -    if (!CreateUnicastIpAddressEntry || !InitializeUnicastIpAddressEntry)
> -    {
> -        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
> -        if (iphlpapi == NULL)
> -        {
> -            return GetLastError();
> -        }
> -
> -        CreateUnicastIpAddressEntry = (CreateUnicastIpAddressEntryFn)
> GetProcAddress(iphlpapi, "CreateUnicastIpAddressEntry");
> -        if (!CreateUnicastIpAddressEntry)
> -        {
> -            return GetLastError();
> -        }
> -
> -        InitializeUnicastIpAddressEntry = (InitializeUnicastIpAddressEntryFn)
> GetProcAddress(iphlpapi, "InitializeUnicastIpAddressEntry");
> -        if (!InitializeUnicastIpAddressEntry)
> -        {
> -            return GetLastError();
> -        }
> -    }
> -
>      addr_row = malloc(sizeof(*addr_row));
>      if (addr_row == NULL)
>      {
> @@ -706,24 +645,6 @@ CmpRoute(LPVOID item, LPVOID route)
>  static DWORD
>  DeleteRoute(PMIB_IPFORWARD_ROW2 fwd_row)
>  {
> -    typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
> -    static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 = NULL;
> -
> -    if (!DeleteIpForwardEntry2)
> -    {
> -        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
> -        if (iphlpapi == NULL)
> -        {
> -            return GetLastError();
> -        }
> -
> -        DeleteIpForwardEntry2 = (DeleteIpForwardEntry2Fn)
> GetProcAddress(iphlpapi, "DeleteIpForwardEntry2");
> -        if (!DeleteIpForwardEntry2)
> -        {
> -            return GetLastError();
> -        }
> -    }
> -
>      return DeleteIpForwardEntry2(fwd_row);
>  }
>
> @@ -734,24 +655,6 @@ HandleRouteMessage(route_message_t *msg,
> undo_lists_t *lists)
>      PMIB_IPFORWARD_ROW2 fwd_row;
>      BOOL add = msg->header.type == msg_add_route;
>
> -    typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
> -    static CreateIpForwardEntry2Fn CreateIpForwardEntry2 = NULL;
> -
> -    if (!CreateIpForwardEntry2)
> -    {
> -        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
> -        if (iphlpapi == NULL)
> -        {
> -            return GetLastError();
> -        }
> -
> -        CreateIpForwardEntry2 = (CreateIpForwardEntry2Fn)
> GetProcAddress(iphlpapi, "CreateIpForwardEntry2");
> -        if (!CreateIpForwardEntry2)
> -        {
> -            return GetLastError();
> -        }
> -    }
> -
>      fwd_row = malloc(sizeof(*fwd_row));
>      if (fwd_row == NULL)
>      {
> @@ -820,36 +723,12 @@ out:
>  static DWORD
>  HandleFlushNeighborsMessage(flush_neighbors_message_t *msg)
>  {
> -    typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY,
> NET_IFINDEX);
> -    static FlushIpNetTable2Fn flush_fn = NULL;
> -
>      if (msg->family == AF_INET)
>      {
>          return FlushIpNetTable(msg->iface.index);
>      }
>
> -    if (!flush_fn)
> -    {
> -        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
> -        if (iphlpapi == NULL)
> -        {
> -            return GetLastError();
> -        }
> -
> -        flush_fn = (FlushIpNetTable2Fn) GetProcAddress(iphlpapi,
> "FlushIpNetTable2");
> -        if (!flush_fn)
> -        {
> -            if (GetLastError() == ERROR_PROC_NOT_FOUND)
> -            {
> -                return WSAEPFNOSUPPORT;
> -            }
> -            else
> -            {
> -                return GetLastError();
> -            }
> -        }
> -    }
> -    return flush_fn(msg->family, msg->iface.index);
> +    return FlushIpNetTable2(msg->family, msg->iface.index);
>  }
>

Looks good and cross-compiles without issues.

ACK

Selva

--001a11406242bfeaba055b647b5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Note to self: this is v2 of [PATCH =
05/13]</div><div><div class=3D"gmail_extra"><a href=3D"https://www.mail-arc=
hive.com/openvpn-devel@lists.sourceforge.net/msg15589.html" target=3D"_blan=
k">https://www.mail-archive.com/o<wbr>penvpn-devel@...282...<wbr>.net/msg15=
589.html</a></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Thu, Oct 12, 2017 at 4:07 AM, Simon Rozman <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Dynamicall=
y locating API function addresses at run-time using<br>
GetProcAddress() was a leftover from the early days of the interactive<br>
service development. It was required before `NTDDI_VERSION` was raised<br>
from Windows XP to Windows Vista.<br>
<br>
After NTDDI_VERSION API level was raised to NTDDI_VISTA, the direct<br>
calling of Vista introduced API functions is possible and much<br>
simpler.<br>
<br>
This patch simplifies the code while in the same time it removes<br>
controversial function type definitions that caused interactive service not=
 to compile on MSVC.<br>
---<br>
=C2=A0src/openvpnserv/interactive.c | 123 +-----------------------------<wb=
r>------------<br>
=C2=A01 file changed, 1 insertion(+), 122 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpnserv/interacti=
ve.<wbr>c<br>
index a060a06..bb8c5f6 100644<br>
--- a/src/openvpnserv/interactive.<wbr>c<br>
+++ b/src/openvpnserv/interactive.<wbr>c<br>
@@ -549,23 +549,6 @@ InterfaceLuid(const char *iface_name, PNET_LUID luid)<=
br>
=C2=A0 =C2=A0 =C2=A0LPWSTR wide_name;<br>
=C2=A0 =C2=A0 =C2=A0int n;<br>
<br>
-=C2=A0 =C2=A0 typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidF<w=
br>n) (LPCWSTR, PNET_LUID);<br>
-=C2=A0 =C2=A0 static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasTo=
Luid =3D NULL;<br>
-=C2=A0 =C2=A0 if (!ConvertInterfaceAliasToLuid)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 HMODULE iphlpapi =3D GetModuleHandle(TEXT(&quo=
t;iphlpapi<wbr>.dll&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iphlpapi =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ConvertInterfaceAliasToLuid =3D (ConvertInterf=
aceAliasToLuidFn<wbr>) GetProcAddress(iphlpapi, &quot;ConvertInterfaceAlias=
ToLuid&quot;)<wbr>;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ConvertInterfaceAliasToLuid)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0n =3D MultiByteToWideChar(CP_UTF8, 0, iface_name, -1, N=
ULL, 0);<br>
=C2=A0 =C2=A0 =C2=A0wide_name =3D malloc(n * sizeof(WCHAR));</blockquote><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0MultiByteToWideChar(CP_UTF8, 0, iface_name, -1, wide_na=
me, n);<br></blockquote><div><br></div><div>Not a fault of this patch, but =
malloc&#39;s return value not checked... Let&#39;s</div><div>address that i=
n a separate patch.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">@@ -584,24 +567,6 @@ CmpAddress(LPVOID item, LPVOID =
address)<br>
=C2=A0static DWORD<br>
=C2=A0DeleteAddress(PMIB_UNICASTIPA<wbr>DDRESS_ROW addr_row)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryF<wbr>n) (=
const PMIB_UNICASTIPADDRESS_ROW);<br>
-=C2=A0 =C2=A0 static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressE=
ntry =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 if (!DeleteUnicastIpAddressEntry)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 HMODULE iphlpapi =3D GetModuleHandle(TEXT(&quo=
t;iphlpapi<wbr>.dll&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iphlpapi =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeleteUnicastIpAddressEntry =3D (DeleteUnicast=
IpAddressEntryFn<wbr>) GetProcAddress(iphlpapi, &quot;DeleteUnicastIpAddres=
sEntry&quot;)<wbr>;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeleteUnicastIpAddressEntry)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return DeleteUnicastIpAddressEntry(ad<wbr>dr_row);<br>
=C2=A0}<br>
<br>
@@ -612,32 +577,6 @@ HandleAddressMessage(address_m<wbr>essage_t *msg, undo=
_lists_t *lists)<br>
=C2=A0 =C2=A0 =C2=A0PMIB_UNICASTIPADDRESS_ROW addr_row;<br>
=C2=A0 =C2=A0 =C2=A0BOOL add =3D msg-&gt;header.type =3D=3D msg_add_address=
;<br>
<br>
-=C2=A0 =C2=A0 typedef NETIOAPI_API (*CreateUnicastIpAddressEntryF<wbr>n) (=
const PMIB_UNICASTIPADDRESS_ROW);<br>
-=C2=A0 =C2=A0 typedef NETIOAPI_API (*InitializeUnicastIpAddressEn<wbr>tryF=
n) (PMIB_UNICASTIPADDRESS_ROW);<br>
-=C2=A0 =C2=A0 static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressE=
ntry =3D NULL;<br>
-=C2=A0 =C2=A0 static InitializeUnicastIpAddressEntr<wbr>yFn InitializeUnic=
astIpAddressEntr<wbr>y =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 if (!CreateUnicastIpAddressEntry || !InitializeUnicastIpAddr=
essEnt<wbr>ry)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 HMODULE iphlpapi =3D GetModuleHandle(TEXT(&quo=
t;iphlpapi<wbr>.dll&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iphlpapi =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 CreateUnicastIpAddressEntry =3D (CreateUnicast=
IpAddressEntryFn<wbr>) GetProcAddress(iphlpapi, &quot;CreateUnicastIpAddres=
sEntry&quot;)<wbr>;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!CreateUnicastIpAddressEntry)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 InitializeUnicastIpAddressEntr<wbr>y =3D (Init=
ializeUnicastIpAddressEnt<wbr>ryFn) GetProcAddress(iphlpapi, &quot;Initiali=
zeUnicastIpAddressEnt<wbr>ry&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!InitializeUnicastIpAddressEn<wbr>try)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0addr_row =3D malloc(sizeof(*addr_row));<br>
=C2=A0 =C2=A0 =C2=A0if (addr_row =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -706,24 +645,6 @@ CmpRoute(LPVOID item, LPVOID route)<br>
=C2=A0static DWORD<br>
=C2=A0DeleteRoute(PMIB_IPFORWARD_RO<wbr>W2 fwd_row)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORW=
ARD_ROW2);<br>
-=C2=A0 =C2=A0 static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 =3D NUL=
L;<br>
-<br>
-=C2=A0 =C2=A0 if (!DeleteIpForwardEntry2)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 HMODULE iphlpapi =3D GetModuleHandle(TEXT(&quo=
t;iphlpapi<wbr>.dll&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iphlpapi =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeleteIpForwardEntry2 =3D (DeleteIpForwardEntr=
y2Fn) GetProcAddress(iphlpapi, &quot;DeleteIpForwardEntry2&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeleteIpForwardEntry2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return DeleteIpForwardEntry2(fwd_row)<wbr>;<br>
=C2=A0}<br>
<br>
@@ -734,24 +655,6 @@ HandleRouteMessage(route_messa<wbr>ge_t *msg, undo_lis=
ts_t *lists)<br>
=C2=A0 =C2=A0 =C2=A0PMIB_IPFORWARD_ROW2 fwd_row;<br>
=C2=A0 =C2=A0 =C2=A0BOOL add =3D msg-&gt;header.type =3D=3D msg_add_route;<=
br>
<br>
-=C2=A0 =C2=A0 typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORW=
ARD_ROW2);<br>
-=C2=A0 =C2=A0 static CreateIpForwardEntry2Fn CreateIpForwardEntry2 =3D NUL=
L;<br>
-<br>
-=C2=A0 =C2=A0 if (!CreateIpForwardEntry2)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 HMODULE iphlpapi =3D GetModuleHandle(TEXT(&quo=
t;iphlpapi<wbr>.dll&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iphlpapi =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 CreateIpForwardEntry2 =3D (CreateIpForwardEntr=
y2Fn) GetProcAddress(iphlpapi, &quot;CreateIpForwardEntry2&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!CreateIpForwardEntry2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0fwd_row =3D malloc(sizeof(*fwd_row));<br>
=C2=A0 =C2=A0 =C2=A0if (fwd_row =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -820,36 +723,12 @@ out:<br>
=C2=A0static DWORD<br>
=C2=A0HandleFlushNeighborsMessage(f<wbr>lush_neighbors_message_t *msg)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY, =
NET_IFINDEX);<br>
-=C2=A0 =C2=A0 static FlushIpNetTable2Fn flush_fn =3D NULL;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (msg-&gt;family =3D=3D AF_INET)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FlushIpNetTable(msg-&gt;iface.ind<=
wbr>ex);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!flush_fn)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 HMODULE iphlpapi =3D GetModuleHandle(TEXT(&quo=
t;iphlpapi<wbr>.dll&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iphlpapi =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_fn =3D (FlushIpNetTable2Fn) GetProcAddre=
ss(iphlpapi, &quot;FlushIpNetTable2&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!flush_fn)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetLastError() =3D=3D ERROR_=
PROC_NOT_FOUND)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return WSAEPFNOSUP=
PORT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastErro=
r();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return flush_fn(msg-&gt;family, msg-&gt;iface.index);<br>
+=C2=A0 =C2=A0 return FlushIpNetTable2(msg-&gt;family, msg-&gt;iface.index)=
;<br>
=C2=A0}<br></blockquote><div><br></div><div>Looks good and cross-compiles w=
ithout issues.</div><div><br></div><div>ACK</div><div><br></div><div>Selva<=
/div></div></div></div></div>

--001a11406242bfeaba055b647b5a--

