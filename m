Message-ID: <4F63314F.20905@...515...>
Date: Fri, 16 Mar 2012 14:25:51 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
	<1330547854-18889-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547854-18889-2-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [tap-windows 04/11] debug: add DbgPrint support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

The vDbgPrintEx[1] sends a message to the Windows kernel debugger, if
"DBG_PRINT" is defined. The va_start and va_end macros[2] fetch
function's optional arguments. They only move the list pointer around,
so va_start after va_end is safe.

I don't see a problem with this and it sounds useful, so it's an ACK.

[1]
<http://msdn.microsoft.com/en-us/library/windows/hardware/ff556075%28v=3Dvs=
.85%29.aspx>
[2] <http://msdn.microsoft.com/en-us/library/kb57fad8%28v=3Dvs.71%29.aspx>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/error.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/src/error.c b/src/error.c
> index 5b25f48..0541bc3 100755
> --- a/src/error.c
> +++ b/src/error.c
> @@ -81,6 +81,11 @@ MyDebugPrint (const unsigned char* format, ...)
>  	      NTSTATUS status;
>  	      char *end;
>=20=20
> +#ifdef DBG_PRINT
> +	      va_start (args, format);
> +	      vDbgPrintEx (DPFLTR_IHVNETWORK_ID, DPFLTR_INFO_LEVEL, format, arg=
s);
> +	      va_end (args);
> +#endif
>  	      va_start (args, format);
>  	      status =3D RtlStringCchVPrintfExA (g_Debug.text + g_Debug.out,
>  					       remaining,


