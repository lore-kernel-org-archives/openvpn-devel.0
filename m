MIME-Version: 1.0
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1538576212-2363-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 3 Oct 2018 11:08:03 -0400
Message-ID: <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
Content-Type: multipart/alternative; boundary="000000000000d39edc05775468f7"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
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

--000000000000d39edc05775468f7
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Oct 3, 2018 at 10:20 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Functions openvpn_vsntprintf and openvpn_sntprintf return
> values of type int, but in reality it is always 0 or 1, which is
> essentially bool.
>

openvpn_sntprintf could return -1 if size = 0, but this looks like the
right approach and matches openvpn_snprintf in the core.
The code looks good too.

Just a thought about bool below:


>
> To make code more clear, change return type to bool. Also
> use stdbool.h header instead of bool definition macros.
>

We do use BOOL all over the service code (unavoidable with
Windows API), and bool is used in only one or two places. So would it
be better to just change this to BOOL/TRUE/FALSE and not include
stdbool.h?

Wishlist: openvpn_swprintf() with nul termination guarantee. I try to avoid
the TCHAR variety be explicit about wide and narrow characters.


> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpnserv/automatic.c |  5 -----
>  src/openvpnserv/common.c    | 13 +++++++------
>  src/openvpnserv/service.h   |  5 +++--
>  3 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> index 1f98283..c2982c1 100644
> --- a/src/openvpnserv/automatic.c
> +++ b/src/openvpnserv/automatic.c
> @@ -38,11 +38,6 @@
>  #include <stdarg.h>
>  #include <process.h>
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
> index dc47666..69dd44b 100644
> --- a/src/openvpnserv/common.c
> +++ b/src/openvpnserv/common.c
> @@ -31,7 +31,7 @@ LPCTSTR service_instance = TEXT("");
>   * These are necessary due to certain buggy implementations of
> (v)snprintf,
>   * that don't guarantee null termination for size > 0.
>   */
> -int
> +bool
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
> +bool
>  openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
>  {
>      va_list arglist;
> -    int len = -1;
> +    bool res = false;
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
> index 4d03b88..eaa479a 100644
> --- a/src/openvpnserv/service.h
> +++ b/src/openvpnserv/service.h
> @@ -32,6 +32,7 @@
>
>  #include <winsock2.h>
>  #include <windows.h>
> +#include <stdbool.h>
>  #include <stdlib.h>
>  #include <tchar.h>
>
> @@ -82,9 +83,9 @@ VOID WINAPI ServiceStartAutomatic(DWORD argc, LPTSTR
> *argv);
>  VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);
>  VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);
>
> -int openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list
> arglist);
> +bool openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list
> arglist);
>
> -int openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
> +bool openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
>
>  DWORD GetOpenvpnSettings(settings_t *s);
>
> --
> 2.7.4
>

Thanks,

Selva

--000000000000d39edc05775468f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On =
Wed, Oct 3, 2018 at 10:20 AM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...220...=
..277...">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D=
"_blank">lev@...515...</a>&gt;<br>
<br>
Functions openvpn_vsntprintf and openvpn_sntprintf return<br>
values of type int, but in reality it is always 0 or 1, which is<br>
essentially bool.<br></blockquote><div><br></div><div>openvpn_sntprintf cou=
ld return -1 if size =3D 0, but this looks like the<br>right approach and m=
atches openvpn_snprintf in the core.<br>The code looks good too. </div><div=
><br></div><div>Just a thought about bool below:<br></div><div>=C2=A0<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<br>
To make code more clear, change return type to bool. Also<br>
use stdbool.h header instead of bool definition macros.<br></blockquote><di=
v><br></div><div>We do use BOOL all over the service code (unavoidable with=
<br>Windows API), and bool is used in only one or two places. So would it<b=
r>be better to just change this to BOOL/TRUE/FALSE and not include<br>stdbo=
ol.h?<br><br></div><div>Wishlist: openvpn_swprintf() with nul termination g=
uarantee. I try to avoid<br>the TCHAR variety be explicit about wide and na=
rrow characters.<br></div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpnserv/automatic.c |=C2=A0 5 -----<br>
=C2=A0src/openvpnserv/common.c=C2=A0 =C2=A0 | 13 +++++++------<br>
=C2=A0src/openvpnserv/service.h=C2=A0 =C2=A0|=C2=A0 5 +++--<br>
=C2=A03 files changed, 10 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c<br>
index 1f98283..c2982c1 100644<br>
--- a/src/openvpnserv/automatic.c<br>
+++ b/src/openvpnserv/automatic.c<br>
@@ -38,11 +38,6 @@<br>
=C2=A0#include &lt;stdarg.h&gt;<br>
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
index dc47666..69dd44b 100644<br>
--- a/src/openvpnserv/common.c<br>
+++ b/src/openvpnserv/common.c<br>
@@ -31,7 +31,7 @@ LPCTSTR service_instance =3D TEXT(&quot;&quot;);<br>
=C2=A0 * These are necessary due to certain buggy implementations of (v)snp=
rintf,<br>
=C2=A0 * that don&#39;t guarantee null termination for size &gt; 0.<br>
=C2=A0 */<br>
-int<br>
+bool<br>
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
+bool<br>
=C2=A0openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0va_list arglist;<br>
-=C2=A0 =C2=A0 int len =3D -1;<br>
+=C2=A0 =C2=A0 bool res =3D false;<br>
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
index 4d03b88..eaa479a 100644<br>
--- a/src/openvpnserv/service.h<br>
+++ b/src/openvpnserv/service.h<br>
@@ -32,6 +32,7 @@<br>
<br>
=C2=A0#include &lt;winsock2.h&gt;<br>
=C2=A0#include &lt;windows.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;tchar.h&gt;<br>
<br>
@@ -82,9 +83,9 @@ VOID WINAPI ServiceStartAutomatic(DWORD argc, LPTSTR *arg=
v);<br>
=C2=A0VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);<br>
=C2=A0VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);<br>
<br>
-int openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list ar=
glist);<br>
+bool openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list a=
rglist);<br>
<br>
-int openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);<br>
+bool openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);<br>
<br>
=C2=A0DWORD GetOpenvpnSettings(settings_t *s);<br>
<br>
-- <br>
2.7.4<br></blockquote><div><br></div><div>Thanks,<br><br></div><div>Selva <=
br></div></div></div>

--000000000000d39edc05775468f7--

