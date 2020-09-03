From: Simon Rozman <simon@...2293...>
Date: Thu, 3 Sep 2020 13:21:06 +0000
Message-ID: <2df48d32ccb64b56a079410cf8782b71@...2293...>
References: <CAGyAFMX4nscyEfT0GGX8dNYVV8j_uLcO=k0XxZf8D1hqowD1wA@...278...>
 <20200902213643.401-1-lstipakov@...277...>
In-Reply-To: <20200902213643.401-1-lstipakov@...277...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnmsica: make adapter renaming
 non-fatal
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

> -----Original Message-----
> From: Lev Stipakov <lstipakov@...277...>
> Sent: Wednesday, September 2, 2020 11:37 PM
> To: openvpn-devel@lists.sourceforge.net
> Cc: Lev Stipakov <lev@...515...>
> Subject: [Openvpn-devel] [PATCH v2] openvpnmsica: make adapter renaming
> non-fatal
>=20
> From: Lev Stipakov <lev@...515...>
>=20
> For some users renaming adapter
>=20
>     Local Area Connection > OpenVPN TAP-Windows6
>=20
> mysteriously fails, see https://github.com/OpenVPN/openvpn-
> build/issues/187
>=20
> Since renaming is just a "nice to have", make it non-fatal
> and, in case of error, only log message and don't display messagebox.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>=20
>  v2: only log error, don't display messagebox
>=20
>  src/openvpnmsica/dllmain.c      |  2 +-
>  src/openvpnmsica/openvpnmsica.c |  9 +++------
>  src/tapctl/main.c               |  2 +-
>  src/tapctl/tap.c                | 11 +++++++----
>  src/tapctl/tap.h                |  6 +++++-
>  5 files changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
> index 201fd9af..34946ed8 100644
> --- a/src/openvpnmsica/dllmain.c
> +++ b/src/openvpnmsica/dllmain.c
> @@ -193,6 +193,6 @@ x_msg_va(const unsigned int flags, const char
> *format, va_list arglist)
>          }
>      }
>=20
> -    MsiProcessMessage(s->hInstall, INSTALLMESSAGE_ERROR, hRecordProg);
> +    MsiProcessMessage(s->hInstall, (flags & M_WARN) ?
> INSTALLMESSAGE_INFO : INSTALLMESSAGE_ERROR, hRecordProg);
>      MsiCloseHandle(hRecordProg);
>  }
> diff --git a/src/openvpnmsica/openvpnmsica.c
> b/src/openvpnmsica/openvpnmsica.c
> index 31e90bd2..f203f736 100644
> --- a/src/openvpnmsica/openvpnmsica.c
> +++ b/src/openvpnmsica/openvpnmsica.c
> @@ -1096,12 +1096,9 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
>              dwResult =3D tap_create_adapter(NULL, NULL, szHardwareId,
> &bRebootRequired, &guidAdapter);
>              if (dwResult =3D=3D ERROR_SUCCESS)
>              {
> -                /* Set adapter name. */
> -                dwResult =3D tap_set_adapter_name(&guidAdapter, szName);
> -                if (dwResult !=3D ERROR_SUCCESS)
> -                {
> -                    tap_delete_adapter(NULL, &guidAdapter,
> &bRebootRequired);
> -                }
> +                /* Set adapter name. May fail on some machines, but
> that is not critical - use silent
> +                   flag to mute messagebox and print error only to log
> */
> +                tap_set_adapter_name(&guidAdapter, szName, TRUE);
>              }
>          }
>          else if (wcsncmp(szArg[i], L"deleteN=3D", 8) =3D=3D 0)
> diff --git a/src/tapctl/main.c b/src/tapctl/main.c
> index 31bb2ec7..d5bc7290 100644
> --- a/src/tapctl/main.c
> +++ b/src/tapctl/main.c
> @@ -237,7 +237,7 @@ _tmain(int argc, LPCTSTR argv[])
>              }
>=20
>              /* Rename the adapter. */
> -            dwResult =3D tap_set_adapter_name(&guidAdapter, szName);
> +            dwResult =3D tap_set_adapter_name(&guidAdapter, szName,
> FALSE);
>              if (dwResult !=3D ERROR_SUCCESS)
>              {
>                  StringFromIID((REFIID)&guidAdapter, &szAdapterId);
> diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
> index 7cb3dedc..0dfe239f 100644
> --- a/src/tapctl/tap.c
> +++ b/src/tapctl/tap.c
> @@ -1140,9 +1140,12 @@ ExecCommand(const WCHAR* cmdline)
>  DWORD
>  tap_set_adapter_name(
>      _In_ LPCGUID pguidAdapter,
> -    _In_ LPCTSTR szName)
> +    _In_ LPCTSTR szName,
> +    _In_ BOOL bSilent)
>  {
>      DWORD dwResult;
> +    int msg_flag =3D bSilent ? M_WARN : M_NONFATAL;
> +    msg_flag |=3D M_ERRNO;
>=20
>      if (pguidAdapter =3D=3D NULL || szName =3D=3D NULL)
>      {
> @@ -1176,7 +1179,7 @@ tap_set_adapter_name(
>      if (dwResult !=3D ERROR_SUCCESS)
>      {
>          SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx()
> to set GetLastError(). But we do have an error code. Set last error
> manually. */
> -        msg(M_NONFATAL | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%"
> PRIsLPTSTR "\") failed", __FUNCTION__, szRegKey);
> +        msg(msg_flag, "%s: RegOpenKeyEx(HKLM, \"%" PRIsLPTSTR "\")
> failed", __FUNCTION__, szRegKey);
>          goto cleanup_szAdapterId;
>      }
>=20
> @@ -1185,7 +1188,7 @@ tap_set_adapter_name(
>      if (dwResult !=3D ERROR_SUCCESS)
>      {
>          SetLastError(dwResult);
> -        msg(M_NONFATAL | M_ERRNO, "%s: Error reading adapter name",
> __FUNCTION__);
> +        msg(msg_flag, "%s: Error reading adapter name", __FUNCTION__);
>          goto cleanup_hKey;
>      }
>=20
> @@ -1203,7 +1206,7 @@ tap_set_adapter_name(
>      if (dwResult !=3D ERROR_SUCCESS)
>      {
>          SetLastError(dwResult);
> -        msg(M_NONFATAL | M_ERRNO, "%s: Error renaming adapter",
> __FUNCTION__);
> +        msg(msg_flag, "%s: Error renaming adapter", __FUNCTION__);
>          goto cleanup_hKey;
>      }
>=20
> diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
> index 102de32d..1f531cf2 100644
> --- a/src/tapctl/tap.h
> +++ b/src/tapctl/tap.h
> @@ -117,13 +117,17 @@ tap_enable_adapter(
>   * @param pguidAdapter  A pointer to GUID that contains network adapter
> ID.
>   *
>   * @param szName        New adapter name - must be unique
> + *
> + * @param bSilent       If true, MSI installer won't display message
> box and
> + *                      only print error to log.
>   *
>   * @return ERROR_SUCCESS on success; Win32 error code otherwise
>   **/
>  DWORD
>  tap_set_adapter_name(
>      _In_ LPCGUID pguidAdapter,
> -    _In_ LPCTSTR szName);
> +    _In_ LPCTSTR szName,
> +    _In_ BOOL bSilent);
>=20
>=20
>  /**
> --
> 2.17.1
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

I have reviewed the code, compiled it, built MSI, tested it.

Although I could not create a phantom TUN adapter to reproduce the issue. R=
enaming "Ethernet" adapter to "OpenVPN TAP-Windows6" and trying to install =
MSI next displayed an error in evaluation phase that a foreign adapter with=
 the same name already exists - which is expected.

This patch is about solving the situation when:
1. There are no apparent TAP-Windows6 or Wintun adapters present =3D> insta=
llation decides to create one.
2. Once adapter is created, the renaming to the desired name fails (as if t=
he name is already taken).

I agree with everybody that having a consistently named adapter after initi=
al setup is nice, but not that essential to make the installation fail. So.=
..

Acked-by: Simon Rozman <simon@...2293...>

Regards,
Simon


