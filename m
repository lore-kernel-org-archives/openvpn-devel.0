MIME-Version: 1.0
References: <CAGyAFMWb0+kpevvu2-UqOvU32HbPK5A=y10WHhThYde74nbKAA@...278...>
 <1538587281-3209-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1538587281-3209-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 3 Oct 2018 16:13:31 -0400
Message-ID: <CAKuzo_gm37aFm0fLSfH+6O9yGwBeCfnPEkHNsLupxHyMtET_CA@...278...>
Content-Type: multipart/alternative; boundary="00000000000035d33f057758ad81"
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnserv: clarify return values
 type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000035d33f057758ad81
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Oct 3, 2018 at 1:24 PM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Functions openvpn_vsntprintf and openvpn_sntprintf return
> values of type int, but in reality it is always 0 or 1 (and -1 for
> snrptinf), which can be represented as boolean.
>
> To make code clearer, change return type to BOOL. Also
> use stdbool.h header instead of bool definition macros in automatic.c
>

> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> v2: replace bool with BOOL as discussed
>
>  src/openvpnserv/automatic.c |  6 +-----
>  src/openvpnserv/common.c    | 13 +++++++------
>  src/openvpnserv/service.h   |  4 ++--
>  3 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> index 1f98283..73d3003 100644
> --- a/src/openvpnserv/automatic.c
> +++ b/src/openvpnserv/automatic.c
> @@ -36,13 +36,9 @@
>
>  #include <stdio.h>
>  #include <stdarg.h>
> +#include <stdbool.h>
>
 #include <process.h>
>
> -/* bool definitions */
> -#define bool int
> -#define true 1
> -#define false 0
> -
>  static SERVICE_STATUS_HANDLE service;
>  static SERVICE_STATUS status = { .dwServiceType =
> SERVICE_WIN32_SHARE_PROCESS };
>
> diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
> index dc47666..6b3a859 100644
> --- a/src/openvpnserv/common.c
> +++ b/src/openvpnserv/common.c
> @@ -31,7 +31,7 @@ LPCTSTR service_instance = TEXT("");
>   * These are necessary due to certain buggy implementations of
> (v)snprintf,
>   * that don't guarantee null termination for size > 0.
>   */
> -int
> +BOOL
>  openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list
> arglist)
>  {
>      int len = -1;
> @@ -42,18 +42,19 @@ openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR
> format, va_list arglist)
>      }
>      return (len >= 0 && len < size);
>  }
> -int
> +
> +BOOL
>  openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
>  {
>      va_list arglist;
> -    int len = -1;
> +    BOOL res = FALSE;
>      if (size > 0)
>      {
>          va_start(arglist, format);
> -        len = openvpn_vsntprintf(str, size, format, arglist);
> +        res = openvpn_vsntprintf(str, size, format, arglist);
>          va_end(arglist);
>      }
> -    return len;
> +    return res;
>  }
>
>  static DWORD
> @@ -65,7 +66,7 @@ GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD
> size, LPCTSTR default_v
>      if (status == ERROR_FILE_NOT_FOUND && default_value)
>      {
>          size_t len = size/sizeof(data[0]);
> -        if (openvpn_sntprintf(data, len, default_value) > 0)
> +        if (openvpn_sntprintf(data, len, default_value))
>          {
>              status = ERROR_SUCCESS;
>          }
> diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
> index 4d03b88..b90033a 100644
> --- a/src/openvpnserv/service.h
> +++ b/src/openvpnserv/service.h
> @@ -82,9 +82,9 @@ VOID WINAPI ServiceStartAutomatic(DWORD argc, LPTSTR
> *argv);
>  VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);
>  VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);
>
> -int openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list
> arglist);
> +BOOL openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list
> arglist);
>
> -int openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
> +BOOL openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
>
>  DWORD GetOpenvpnSettings(settings_t *s);
>
>
The originals had confusing return values with a success/fail code hidden
in what
looked like a length. The code is cleaner and clearer this way.
And, builds/runs fine (mingw cross-build + Windows 7 run time).

Acked-by: selva.nair@...277...

--00000000000035d33f057758ad81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On =
Wed, Oct 3, 2018 at 1:24 PM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1186...=
.277..." target=3D"_blank">lstipakov@...277...</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...493...=
515..." target=3D"_blank">lev@...515...</a>&gt;<br>
<br>
Functions openvpn_vsntprintf and openvpn_sntprintf return<br>
values of type int, but in reality it is always 0 or 1 (and -1 for<br>
snrptinf), which can be represented as boolean.<br>
<br>
To make code clearer, change return type to BOOL. Also<br>
use stdbool.h header instead of bool definition macros in automatic.c<br></=
blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
v2: replace bool with BOOL as discussed<br>
<br>
=C2=A0src/openvpnserv/automatic.c |=C2=A0 6 +-----<br>
=C2=A0src/openvpnserv/common.c=C2=A0 =C2=A0 | 13 +++++++------<br>
=C2=A0src/openvpnserv/service.h=C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A03 files changed, 10 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c<br>
index 1f98283..73d3003 100644<br>
--- a/src/openvpnserv/automatic.c<br>
+++ b/src/openvpnserv/automatic.c<br>
@@ -36,13 +36,9 @@<br>
<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdarg.h&gt;<br>
+#include &lt;stdbool.h&gt; <br></blockquote><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0#include &lt;process.h&gt;<br>
<br>
-/* bool definitions */<br>
-#define bool int<br>
-#define true 1<br>
-#define false 0<br>
-<br>
=C2=A0static SERVICE_STATUS_HANDLE service;<br>
=C2=A0static SERVICE_STATUS status =3D { .dwServiceType =3D SERVICE_WIN32_S=
HARE_PROCESS };<br>
<br>
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c<br>
index dc47666..6b3a859 100644<br>
--- a/src/openvpnserv/common.c<br>
+++ b/src/openvpnserv/common.c<br>
@@ -31,7 +31,7 @@ LPCTSTR service_instance =3D TEXT(&quot;&quot;);<br>
=C2=A0 * These are necessary due to certain buggy implementations of (v)snp=
rintf,<br>
=C2=A0 * that don&#39;t guarantee null termination for size &gt; 0.<br>
=C2=A0 */<br>
-int<br>
+BOOL<br>
=C2=A0openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list a=
rglist)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int len =3D -1;<br>
@@ -42,18 +42,19 @@ openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR for=
mat, va_list arglist)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return (len &gt;=3D 0 &amp;&amp; len &lt; size);<br>
=C2=A0}<br>
-int<br>
+<br>
+BOOL<br>
=C2=A0openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0va_list arglist;<br>
-=C2=A0 =C2=A0 int len =3D -1;<br>
+=C2=A0 =C2=A0 BOOL res =3D FALSE;<br>
=C2=A0 =C2=A0 =C2=A0if (size &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0va_start(arglist, format);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D openvpn_vsntprintf(str, size, format, =
arglist);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D openvpn_vsntprintf(str, size, format, =
arglist);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0va_end(arglist);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 return len;<br>
+=C2=A0 =C2=A0 return res;<br>
=C2=A0}<br>
<br>
=C2=A0static DWORD<br>
@@ -65,7 +66,7 @@ GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD =
size, LPCTSTR default_v<br>
=C2=A0 =C2=A0 =C2=A0if (status =3D=3D ERROR_FILE_NOT_FOUND &amp;&amp; defau=
lt_value)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len =3D size/sizeof(data[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (openvpn_sntprintf(data, len, default_value=
) &gt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (openvpn_sntprintf(data, len, default_value=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D ERROR_SUCCESS;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h<br>
index 4d03b88..b90033a 100644<br>
--- a/src/openvpnserv/service.h<br>
+++ b/src/openvpnserv/service.h<br>
@@ -82,9 +82,9 @@ VOID WINAPI ServiceStartAutomatic(DWORD argc, LPTSTR *arg=
v);<br>
=C2=A0VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);<br>
=C2=A0VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);<br>
<br>
-int openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list ar=
glist);<br>
+BOOL openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list a=
rglist);<br>
<br>
-int openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);<br>
+BOOL openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);<br>
<br>
=C2=A0DWORD GetOpenvpnSettings(settings_t *s);<br>
<br></blockquote><div><br></div><div>The originals had confusing return val=
ues with a success/fail code hidden in what<br>looked like a length. The co=
de is cleaner and clearer this way.<br>And, builds/runs fine (mingw cross-b=
uild + Windows 7 run time).</div><div>=C2=A0<br></div><div>Acked-by: <a hre=
f=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a=
><br></div></div></div>

--00000000000035d33f057758ad81--

