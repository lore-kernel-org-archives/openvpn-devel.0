MIME-Version: 1.0
References: <20240619134451.222-1-lev@...515...>
 <20240619144629.1718-2-lev@...515...>
In-Reply-To: <20240619144629.1718-2-lev@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Jun 2024 10:59:16 -0400
Message-ID: <CAKuzo_hDtFpFT0mUwrqsOZUL9sOMHgoxrV4a+7MLqSXNHMrPCQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000002cb263061b3f7212"
Subject: Re: [Openvpn-devel] [PATCH v3] interactive.c: Improve access
 control for gui<->service pipe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--0000000000002cb263061b3f7212
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 10:48=E2=80=AFAM Lev Stipakov <lstipakov@...277...>=
 wrote:

> At the moment everyone but anonymous are permitted
> to create a pipe with the same name as interactive service creates,
> which makes it possible for malicious process with SeImpersonatePrivilege
> impersonate as local user.
>
> This hardens the security of the pipe, making it possible only for
> processes running as SYSTEM (such as interactive service) create the
> pipe with the same name.
>
> While on it, replace EXPLICIT_ACCESS structures with SDDL string.
>
> CVE: 2024-4877
>
> Change-Id: I35e783b79a332d247606e05a39e41b4d35d39b5d
> Reported by: Zeze with TeamT5 <zeze7w@...277...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v3:
>   - rebase on top of master (replace openvpn_snprintf with snprintf)
>

It's swprintf :)


>  v2:
>   - ensure that sd is freed even if pipe creation failed
>   - added Reported-By
>
>  src/openvpnserv/interactive.c | 81 +++++++++++++----------------------
>  1 file changed, 29 insertions(+), 52 deletions(-)
>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 294db00a..f06802de 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -2140,73 +2140,50 @@ ServiceCtrlInteractive(DWORD ctrl_code, DWORD
> event, LPVOID data, LPVOID ctx)
>  static HANDLE
>  CreateClientPipeInstance(VOID)
>  {
> -    TCHAR pipe_name[256]; /* The entire pipe name string can be up to 256
> characters long according to MSDN. */
> -    HANDLE pipe =3D NULL;
> -    PACL old_dacl, new_dacl;
> -    PSECURITY_DESCRIPTOR sd;
> -    static EXPLICIT_ACCESS ea[2];
> -    static BOOL initialized =3D FALSE;
> -    DWORD flags =3D PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OVERLAPPE=
D;
> +    /*
> +     * allow all access for local system
> +     * deny FILE_CREATE_PIPE_INSTANCE for everyone
> +     * allow read/write for authenticated users
> +     * deny all access to anonymous
> +     */
> +    const TCHAR *sddlString =3D
> TEXT("D:(A;OICI;GA;;;S-1-5-18)(D;OICI;0x4;;;S-1-1-0)(A;OICI;GRGW;;;S-1-5-=
11)(D;;GA;;;S-1-5-7)");
>
> -    if (!initialized)
> +    PSECURITY_DESCRIPTOR sd =3D NULL;
> +    if (!ConvertStringSecurityDescriptorToSecurityDescriptor(sddlString,
> SDDL_REVISION_1, &sd, NULL))
>      {
> -        PSID everyone, anonymous;
> -
> -        ConvertStringSidToSid(TEXT("S-1-1-0"), &everyone);
> -        ConvertStringSidToSid(TEXT("S-1-5-7"), &anonymous);
> +        MsgToEventLog(M_SYSERR,
> TEXT("ConvertStringSecurityDescriptorToSecurityDescriptor failed."));
> +        return INVALID_HANDLE_VALUE;
> +    }
>
> -        ea[0].grfAccessPermissions =3D FILE_GENERIC_WRITE;
> -        ea[0].grfAccessMode =3D GRANT_ACCESS;
> -        ea[0].grfInheritance =3D NO_INHERITANCE;
> -        ea[0].Trustee.pMultipleTrustee =3D NULL;
> -        ea[0].Trustee.MultipleTrusteeOperation =3D NO_MULTIPLE_TRUSTEE;
> -        ea[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> -        ea[0].Trustee.TrusteeType =3D TRUSTEE_IS_UNKNOWN;
> -        ea[0].Trustee.ptstrName =3D (LPTSTR) everyone;
> +    /* Set up SECURITY_ATTRIBUTES */
> +    SECURITY_ATTRIBUTES sa =3D {0};
> +    sa.nLength =3D sizeof(SECURITY_ATTRIBUTES);
> +    sa.lpSecurityDescriptor =3D sd;
> +    sa.bInheritHandle =3D FALSE;
>
> -        ea[1].grfAccessPermissions =3D 0;
> -        ea[1].grfAccessMode =3D REVOKE_ACCESS;
> -        ea[1].grfInheritance =3D NO_INHERITANCE;
> -        ea[1].Trustee.pMultipleTrustee =3D NULL;
> -        ea[1].Trustee.MultipleTrusteeOperation =3D NO_MULTIPLE_TRUSTEE;
> -        ea[1].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> -        ea[1].Trustee.TrusteeType =3D TRUSTEE_IS_UNKNOWN;
> -        ea[1].Trustee.ptstrName =3D (LPTSTR) anonymous;
> +    DWORD flags =3D PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OVERLAPPE=
D;
>
> +    static BOOL first =3D TRUE;
> +    if (first)
> +    {
>          flags |=3D FILE_FLAG_FIRST_PIPE_INSTANCE;
> -        initialized =3D TRUE;
> +        first =3D FALSE;
>      }
>
> +    TCHAR pipe_name[256]; /* The entire pipe name string can be up to 256
> characters long according to MSDN. */
>      swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE
> "%ls\\service"), service_instance);
> -    pipe =3D CreateNamedPipe(pipe_name, flags,
> -                           PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE |
> PIPE_REJECT_REMOTE_CLIENTS,
> -                           PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL=
);
> +    HANDLE pipe =3D CreateNamedPipe(pipe_name, flags,
> +                                  PIPE_TYPE_MESSAGE |
> PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
> +                                  PIPE_UNLIMITED_INSTANCES, 1024, 1024,
> 0, &sa);
> +
> +    LocalFree(sd);
> +
>      if (pipe =3D=3D INVALID_HANDLE_VALUE)
>      {
>          MsgToEventLog(M_SYSERR, TEXT("Could not create named pipe"));
>          return INVALID_HANDLE_VALUE;
>      }
>
> -    if (GetSecurityInfo(pipe, SE_KERNEL_OBJECT, DACL_SECURITY_INFORMATIO=
N,
> -                        NULL, NULL, &old_dacl, NULL, &sd) !=3D
> ERROR_SUCCESS)
> -    {
> -        MsgToEventLog(M_SYSERR, TEXT("Could not get pipe security info")=
);
> -        return CloseHandleEx(&pipe);
> -    }
> -
> -    if (SetEntriesInAcl(2, ea, old_dacl, &new_dacl) !=3D ERROR_SUCCESS)
> -    {
> -        MsgToEventLog(M_SYSERR, TEXT("Could not set entries in new acl")=
);
> -        return CloseHandleEx(&pipe);
> -    }
> -
> -    if (SetSecurityInfo(pipe, SE_KERNEL_OBJECT, DACL_SECURITY_INFORMATIO=
N,
> -                        NULL, NULL, new_dacl, NULL) !=3D ERROR_SUCCESS)
> -    {
> -        MsgToEventLog(M_SYSERR, TEXT("Could not set pipe security info")=
);
> -        return CloseHandleEx(&pipe);
> -    }
> -
>      return pipe;
>  }
>
> --
> 2.42.0.windows.2
>

The only change from the 2.6 version is openvpn_swprintf -> swprintf.
I did not retest the build or executable, but looks good to me based on 2.6
tests.

Acked-by: Selva Nair <selva.nair@...277...>

--0000000000002cb263061b3f7212
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Jun 19, 2024 at 10:48=E2=80=AFAM Lev Stipa=
kov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@=
...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">At the moment everyone but anonymous are permitted<br>
to create a pipe with the same name as interactive service creates,<br>
which makes it possible for malicious process with SeImpersonatePrivilege<b=
r>
impersonate as local user.<br>
<br>
This hardens the security of the pipe, making it possible only for<br>
processes running as SYSTEM (such as interactive service) create the<br>
pipe with the same name.<br>
<br>
While on it, replace EXPLICIT_ACCESS structures with SDDL string.<br>
<br>
CVE: 2024-4877<br>
<br>
Change-Id: I35e783b79a332d247606e05a39e41b4d35d39b5d<br>
Reported by: Zeze with TeamT5 &lt;<a href=3D"mailto:zeze7w@...277..." targe=
t=3D"_blank">zeze7w@...277...</a>&gt;<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0v3:<br>
=C2=A0 - rebase on top of master (replace openvpn_snprintf with snprintf)<b=
r></blockquote><div><br></div><div>It&#39;s swprintf :)=C2=A0</div><div><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0v2:<br>
=C2=A0 - ensure that sd is freed even if pipe creation failed<br>
=C2=A0 - added Reported-By<br>
<br>
=C2=A0src/openvpnserv/interactive.c | 81 +++++++++++++---------------------=
-<br>
=C2=A01 file changed, 29 insertions(+), 52 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c<=
br>
index 294db00a..f06802de 100644<br>
--- a/src/openvpnserv/interactive.c<br>
+++ b/src/openvpnserv/interactive.c<br>
@@ -2140,73 +2140,50 @@ ServiceCtrlInteractive(DWORD ctrl_code, DWORD event=
, LPVOID data, LPVOID ctx)<br>
=C2=A0static HANDLE<br>
=C2=A0CreateClientPipeInstance(VOID)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 TCHAR pipe_name[256]; /* The entire pipe name string can be =
up to 256 characters long according to MSDN. */<br>
-=C2=A0 =C2=A0 HANDLE pipe =3D NULL;<br>
-=C2=A0 =C2=A0 PACL old_dacl, new_dacl;<br>
-=C2=A0 =C2=A0 PSECURITY_DESCRIPTOR sd;<br>
-=C2=A0 =C2=A0 static EXPLICIT_ACCESS ea[2];<br>
-=C2=A0 =C2=A0 static BOOL initialized =3D FALSE;<br>
-=C2=A0 =C2=A0 DWORD flags =3D PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_O=
VERLAPPED;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* allow all access for local system<br>
+=C2=A0 =C2=A0 =C2=A0* deny FILE_CREATE_PIPE_INSTANCE for everyone<br>
+=C2=A0 =C2=A0 =C2=A0* allow read/write for authenticated users<br>
+=C2=A0 =C2=A0 =C2=A0* deny all access to anonymous<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 const TCHAR *sddlString =3D TEXT(&quot;D:(A;OICI;GA;;;S-1-5-=
18)(D;OICI;0x4;;;S-1-1-0)(A;OICI;GRGW;;;S-1-5-11)(D;;GA;;;S-1-5-7)&quot;);<=
br>
<br>
-=C2=A0 =C2=A0 if (!initialized)<br>
+=C2=A0 =C2=A0 PSECURITY_DESCRIPTOR sd =3D NULL;<br>
+=C2=A0 =C2=A0 if (!ConvertStringSecurityDescriptorToSecurityDescriptor(sdd=
lString, SDDL_REVISION_1, &amp;sd, NULL))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 PSID everyone, anonymous;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ConvertStringSidToSid(TEXT(&quot;S-1-1-0&quot;=
), &amp;everyone);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ConvertStringSidToSid(TEXT(&quot;S-1-5-7&quot;=
), &amp;anonymous);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MsgToEventLog(M_SYSERR, TEXT(&quot;ConvertStri=
ngSecurityDescriptorToSecurityDescriptor failed.&quot;));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return INVALID_HANDLE_VALUE;<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[0].grfAccessPermissions =3D FILE_GENERIC_WR=
ITE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[0].grfAccessMode =3D GRANT_ACCESS;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[0].grfInheritance =3D NO_INHERITANCE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[0].Trustee.pMultipleTrustee =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[0].Trustee.MultipleTrusteeOperation =3D NO_=
MULTIPLE_TRUSTEE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[0].Trustee.TrusteeType =3D TRUSTEE_IS_UNKNO=
WN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[0].Trustee.ptstrName =3D (LPTSTR) everyone;=
<br>
+=C2=A0 =C2=A0 /* Set up SECURITY_ATTRIBUTES */<br>
+=C2=A0 =C2=A0 SECURITY_ATTRIBUTES sa =3D {0};<br>
+=C2=A0 =C2=A0 sa.nLength =3D sizeof(SECURITY_ATTRIBUTES);<br>
+=C2=A0 =C2=A0 sa.lpSecurityDescriptor =3D sd;<br>
+=C2=A0 =C2=A0 sa.bInheritHandle =3D FALSE;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[1].grfAccessPermissions =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[1].grfAccessMode =3D REVOKE_ACCESS;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[1].grfInheritance =3D NO_INHERITANCE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[1].Trustee.pMultipleTrustee =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[1].Trustee.MultipleTrusteeOperation =3D NO_=
MULTIPLE_TRUSTEE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[1].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[1].Trustee.TrusteeType =3D TRUSTEE_IS_UNKNO=
WN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea[1].Trustee.ptstrName =3D (LPTSTR) anonymous=
;<br>
+=C2=A0 =C2=A0 DWORD flags =3D PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_O=
VERLAPPED;<br>
<br>
+=C2=A0 =C2=A0 static BOOL first =3D TRUE;<br>
+=C2=A0 =C2=A0 if (first)<br>
+=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D FILE_FLAG_FIRST_PIPE_INSTANCE;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 initialized =3D TRUE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 first =3D FALSE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 TCHAR pipe_name[256]; /* The entire pipe name string can be =
up to 256 characters long according to MSDN. */<br>
=C2=A0 =C2=A0 =C2=A0swprintf(pipe_name, _countof(pipe_name), TEXT(&quot;\\\=
\.\\pipe\\&quot; PACKAGE &quot;%ls\\service&quot;), service_instance);<br>
-=C2=A0 =C2=A0 pipe =3D CreateNamedPipe(pipe_name, flags,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_RE=
JECT_REMOTE_CLIENTS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);<br>
+=C2=A0 =C2=A0 HANDLE pipe =3D CreateNamedPipe(pipe_name, flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PIPE_TYPE_MESSAGE | PIPE_READ=
MODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PIPE_UNLIMITED_INSTANCES, 102=
4, 1024, 0, &amp;sa);<br>
+<br>
+=C2=A0 =C2=A0 LocalFree(sd);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (pipe =3D=3D INVALID_HANDLE_VALUE)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MsgToEventLog(M_SYSERR, TEXT(&quot;Could =
not create named pipe&quot;));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return INVALID_HANDLE_VALUE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (GetSecurityInfo(pipe, SE_KERNEL_OBJECT, DACL_SECURITY_IN=
FORMATION,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NULL, NULL, &amp;old_dacl, NULL, &amp;sd) !=3D ERROR_SUCCESS)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MsgToEventLog(M_SYSERR, TEXT(&quot;Could not g=
et pipe security info&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return CloseHandleEx(&amp;pipe);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (SetEntriesInAcl(2, ea, old_dacl, &amp;new_dacl) !=3D ERR=
OR_SUCCESS)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MsgToEventLog(M_SYSERR, TEXT(&quot;Could not s=
et entries in new acl&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return CloseHandleEx(&amp;pipe);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (SetSecurityInfo(pipe, SE_KERNEL_OBJECT, DACL_SECURITY_IN=
FORMATION,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NULL, NULL, new_dacl, NULL) !=3D ERROR_SUCCESS)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MsgToEventLog(M_SYSERR, TEXT(&quot;Could not s=
et pipe security info&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return CloseHandleEx(&amp;pipe);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return pipe;<br>
=C2=A0}<br>
<br>
-- <br>
2.42.0.windows.2<br></blockquote><div><br></div><div>The only change from t=
he 2.6 version is openvpn_swprintf -&gt; swprintf.</div><div>I did not rete=
st the build or executable, but looks good to me based on 2.6 tests.</div><=
div>=C2=A0</div><div>Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@=
...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</div></div></div>

--0000000000002cb263061b3f7212--

