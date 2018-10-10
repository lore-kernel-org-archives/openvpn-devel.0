MIME-Version: 1.0
References: <20181008175242.GS962@...1296...>
 <1539022378-24485-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1539022378-24485-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Oct 2018 13:25:59 -0400
Message-ID: <CAKuzo_hzNj6t3wCQhdmq1-pKi2VbuEEC1gjesrnfZ0HW8CeOAg@...278...>
Content-Type: multipart/alternative; boundary="000000000000e716130577e32697"
Subject: Re: [Openvpn-devel] [PATCH v2] interactive.c: fix usage of
 potentially uninitialized variable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e716130577e32697
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry I missed this patch cleaning up my mistake..

Gert has already reviewed and asked for this v2 so this may be redundant,
but fwiw:

On Mon, Oct 8, 2018 at 2:15 PM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> In function netsh_dns_cmd() it is possible to jump on a label and
> call free() on uninitialized pointer. Move pointer initialization
> above jump.
>
> To fix a few warnings which are treated as errors with SDL enabled,
> initialize pointers with NULL.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> v2:
>  - remove NULL check before free() call
>  - remove unneeded NULL initializations in function body
>
>  src/openvpnserv/interactive.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 8f92c24..4a571f5 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -1015,6 +1015,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t
> *proto, const wchar_t *if_nam
>      DWORD err = 0;
>      int timeout = 30000; /* in msec */
>      wchar_t argv0[MAX_PATH];
> +    wchar_t *cmdline = NULL;
>

Indeed this has to move up or the early jump to label out should be
replaced by "return err".

Is there a way to get gcc warn (or error) when jumping over unitialized
variables
that get referenced after the jump --  -Wjump-misses-init is noisy and
does not catch all.


>      if (!addr)
>      {
> @@ -1039,7 +1040,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t
> *proto, const wchar_t *if_nam
>
>      /* max cmdline length in wchars -- include room for worst case and
> some */
>      size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 +
> 1;
> -    wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
> +    cmdline = malloc(ncmdline*sizeof(wchar_t));
>      if (!cmdline)
>      {
>          err = ERROR_OUTOFMEMORY;
> @@ -1350,7 +1351,7 @@ RunOpenvpn(LPVOID p)
>  {
>      HANDLE pipe = p;
>      HANDLE ovpn_pipe, svc_pipe;
> -    PTOKEN_USER svc_user, ovpn_user;
> +    PTOKEN_USER svc_user = NULL, ovpn_user = NULL;
>

Good catch -- these could get passed to free on errors.


>      HANDLE svc_token = NULL, imp_token = NULL, pri_token = NULL;
>      HANDLE stdin_read = NULL, stdin_write = NULL;
>      HANDLE stdout_write = NULL;
> @@ -1403,7 +1404,6 @@ RunOpenvpn(LPVOID p)
>          goto out;
>      }
>      len = 0;
> -    svc_user = NULL;
>      while (!GetTokenInformation(svc_token, TokenUser, svc_user, len,
> &len))
>      {
>          if (GetLastError() != ERROR_INSUFFICIENT_BUFFER)
> @@ -1436,7 +1436,6 @@ RunOpenvpn(LPVOID p)
>          goto out;
>      }
>      len = 0;
> -    ovpn_user = NULL;
>      while (!GetTokenInformation(imp_token, TokenUser, ovpn_user, len,
> &len))
>      {
>          if (GetLastError() != ERROR_INSUFFICIENT_BUFFER)
>

Thanks for the cleanup.

Acked-by: selva.nair@...277...

--000000000000e716130577e32697
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>Sorry I missed this patch clean=
ing up my mistake..<br><br>Gert has already reviewed and asked for this v2 =
so this may be redundant,<br></div>but fwiw:<br><br><div><div class=3D"gmai=
l_quote"><div dir=3D"ltr">On Mon, Oct 8, 2018 at 2:15 PM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Lev Stipakov =
&lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&gt=
;<br>
<br>
In function netsh_dns_cmd() it is possible to jump on a label and<br>
call free() on uninitialized pointer. Move pointer initialization<br>
above jump.<br>
<br>
To fix a few warnings which are treated as errors with SDL enabled,<br>
initialize pointers with NULL.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
v2:<br>
=C2=A0- remove NULL check before free() call<br>
=C2=A0- remove unneeded NULL initializations in function body<br>
<br>
=C2=A0src/openvpnserv/interactive.c | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c<=
br>
index 8f92c24..4a571f5 100644<br>
--- a/src/openvpnserv/interactive.c<br>
+++ b/src/openvpnserv/interactive.c<br>
@@ -1015,6 +1015,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *p=
roto, const wchar_t *if_nam<br>
=C2=A0 =C2=A0 =C2=A0DWORD err =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int timeout =3D 30000; /* in msec */<br>
=C2=A0 =C2=A0 =C2=A0wchar_t argv0[MAX_PATH];<br>
+=C2=A0 =C2=A0 wchar_t *cmdline =3D NULL;<br></blockquote><div><br></div><d=
iv>Indeed this has to move up or the early jump to label out should be <br>=
replaced by &quot;return err&quot;.<br><br>Is there a way to get gcc warn (=
or error) when jumping over unitialized variables<br></div><div>that get re=
ferenced after the jump --=C2=A0 -Wjump-misses-init is noisy and <br></div>=
<div>does not catch all.<br></div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
=C2=A0 =C2=A0 =C2=A0if (!addr)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -1039,7 +1040,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *p=
roto, const wchar_t *if_nam<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* max cmdline length in wchars -- include room for wor=
st case and some */<br>
=C2=A0 =C2=A0 =C2=A0size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcs=
len(addr) + 32 + 1;<br>
-=C2=A0 =C2=A0 wchar_t *cmdline =3D malloc(ncmdline*sizeof(wchar_t));<br>
+=C2=A0 =C2=A0 cmdline =3D malloc(ncmdline*sizeof(wchar_t));<br>
=C2=A0 =C2=A0 =C2=A0if (!cmdline)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D ERROR_OUTOFMEMORY;<br>
@@ -1350,7 +1351,7 @@ RunOpenvpn(LPVOID p)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0HANDLE pipe =3D p;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE ovpn_pipe, svc_pipe;<br>
-=C2=A0 =C2=A0 PTOKEN_USER svc_user, ovpn_user;<br>
+=C2=A0 =C2=A0 PTOKEN_USER svc_user =3D NULL, ovpn_user =3D NULL;<br></bloc=
kquote><div><br></div><div>Good catch -- these could get passed to free on =
errors.<br>=C2=A0=C2=A0 <br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0HANDLE svc_token =3D NULL, imp_token =3D NULL, pri_toke=
n =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE stdin_read =3D NULL, stdin_write =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE stdout_write =3D NULL;<br>
@@ -1403,7 +1404,6 @@ RunOpenvpn(LPVOID p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0len =3D 0;<br>
-=C2=A0 =C2=A0 svc_user =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0while (!GetTokenInformation(svc_token, TokenUser, svc_u=
ser, len, &amp;len))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (GetLastError() !=3D ERROR_INSUFFICIEN=
T_BUFFER)<br>
@@ -1436,7 +1436,6 @@ RunOpenvpn(LPVOID p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0len =3D 0;<br>
-=C2=A0 =C2=A0 ovpn_user =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0while (!GetTokenInformation(imp_token, TokenUser, ovpn_=
user, len, &amp;len))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (GetLastError() !=3D ERROR_INSUFFICIEN=
T_BUFFER)<br></blockquote><div><br></div><div>Thanks for the cleanup.<br><b=
r></div><div>Acked-by: <a href=3D"mailto:selva.nair@...277..." target=3D"_b=
lank">selva.nair@...277...</a></div></div></div></div>

--000000000000e716130577e32697--

