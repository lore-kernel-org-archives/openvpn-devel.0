From: Simon Rozman <simon@...2293...>
Date: Mon, 6 Jul 2020 08:41:44 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10D0DDA98F@...2294...>
References: <20200703192029.306-1-lstipakov@...277...>
In-Reply-To: <20200703192029.306-1-lstipakov@...277...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] tap.c: fix adapter renaming
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

Hi,

> +// stripped version of ExecCommand in interactive.c static DWORD

C++ style comment.

> +    // rename adapter via netsh call

C++ style comment.

> +    const TCHAR* szFmt =3D _T("netsh interface set interface name=3D\"%s=
\"
> newname=3D\"%s\"");
> +    size_t ncmdline =3D _tcslen(szFmt) + _tcslen(szOldName) +
> _tcslen(szName) + 1;
> +    WCHAR* szCmdLine =3D malloc(ncmdline * sizeof(TCHAR));
> +    _stprintf_s(szCmdLine, ncmdline, szFmt, szOldName, szName);

For the record:
1. `netsh interface set interface` does not accept adapter index. Therefore=
, the interface to rename must be selected by name. I'd prefer more explici=
t selection like adapter GUID or interface index, but selecting by name see=
ms the only way here. Interface indexes are a thing of the TCP/IP, so it ki=
nd of makes sense lower layers are not operating with them. Ack.

2. I've tested `netsh interface set interface` to ignore case when selectin=
g adapter. Ack.

3. I've tested `netsh interface set interface` to work when renaming adapte=
r back to the original name. Ack.

Reviewed the code, compiled, debugged, tested.

Acked-by: Simon Rozman <simon@...2293...>

Regards,
Simon

