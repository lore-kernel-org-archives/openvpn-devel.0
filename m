MIME-Version: 1.0
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-20-a@...2181...>
In-Reply-To: <20220624083809.23487-20-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 24 Jun 2022 14:53:59 -0400
Message-ID: <CAKuzo_hJcsXQ8UZzXDd_gSSch8wWHoQpp7xx7m99VLpgbDAMKA@...278...>
Content-Type: multipart/alternative; boundary="000000000000d68e7f05e2361846"
Subject: Re: [Openvpn-devel] [PATCH 19/25] dco-win: implement
 GetOverlappedResultEx for mingw32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000d68e7f05e2361846
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Jun 24, 2022 at 5:10 AM Antonio Quartulli <a@...2181...> wrote:

> GetOverlappedResultEx is not available on ming32 therefore we must
> provide some compat layer before being able to use this function.
>

I suppose "mingw32" here refers to I mingw-w64 for 32 bit (i686) target.

This symbol has been exported in kernel32.lib since version 7.0 release of
mingw-w64 (~ 2019). Current release is version 10. Do we need to support
older versions given that mingw build is now used only for development by a
few of us?

I use debian which probably is the slowest to get new versions -- bullseye
has version 8 (gcc version 10), on buster I use unstable which gives
version 8. Ubuntu 20.04 has version 7, 22.04 has version 8.

Even if we must support 6.0 and older, let's not unconditionally use the
compat layer proposed here.


>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/compat/Makefile.am                        |  3 +-
>  src/compat/compat-dco_get_overlapped_result.c | 46 +++++++++++++++++++
>  src/compat/compat.h                           |  8 ++++
>  src/compat/compat.vcxproj                     |  1 +
>  src/compat/compat.vcxproj.filters             |  3 ++
>  5 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 src/compat/compat-dco_get_overlapped_result.c
>
> diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
> index 6eb991dc..6dba08aa 100644
> --- a/src/compat/Makefile.am
> +++ b/src/compat/Makefile.am
> @@ -28,4 +28,5 @@ libcompat_la_SOURCES = \
>         compat-gettimeofday.c \
>         compat-daemon.c \
>         compat-strsep.c \
> -       compat-versionhelpers.h
> +       compat-versionhelpers.h \
> +       compat-dco_get_overlapped_result.c
> diff --git a/src/compat/compat-dco_get_overlapped_result.c
> b/src/compat/compat-dco_get_overlapped_result.c
> new file mode 100644
> index 00000000..e14ce976
> --- /dev/null
> +++ b/src/compat/compat-dco_get_overlapped_result.c
> @@ -0,0 +1,46 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2021-2022 Lev Stipakov <lev@...515...>
> + *  Copyright (C) 2021-2022 OpenVPN Inc <sales@...515...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +#include "compat.h"
> +
> +#if defined(__MINGW32__) && !defined(__MINGW64__)
> +BOOL
> +dco_get_overlapped_result(HANDLE handle, OVERLAPPED *ov, DWORD
> *transferred,
> +                          DWORD delay_millisec, BOOL unused)
> +{
> +    BOOL res = GetOverlappedResult(handle, ov, transferred, FALSE);
> +    if ((res == 0) && (GetLastError() == ERROR_IO_INCOMPLETE))
> +    {
> +        Sleep(delay_millisec);


While this may be ok assuming it's not inside any performance critical
loops, no need to force this on newer versions of mingw-w64.

Alternatively, we could use AC_CHECK_FUNC to make this conditional or find
the symbol GetOverlappedResultEx at runtime. But, imo, we do not need any
of this as supporting mingw-w64 version 7+ should be enough.

Regards,

Selva

--000000000000d68e7f05e2361846
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Jun 24, 2022 at 5:10 AM Antonio Quartulli =
&lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">GetOverla=
ppedResultEx is not available on ming32 therefore we must<br>
provide some compat layer before being able to use this function.<br></bloc=
kquote><div><br></div><div>I suppose &quot;mingw32&quot; here refers to=C2=
=A0I mingw-w64 for 32 bit (i686) target.</div><div><br></div><div>This symb=
ol has been exported in kernel32.lib since version 7.0 release of mingw-w64=
 (~ 2019). Current release is version 10. Do we need to support older versi=
ons given that mingw build is now used only for development by a few of us?=
</div><div><br></div><div>I use debian which probably is the slowest to=C2=
=A0get new versions -- bullseye has version 8 (gcc version 10), on buster I=
 use unstable which gives version=C2=A08. Ubuntu 20.04 has version 7, 22.04=
 has version 8.</div><div><br></div><div>Even if we must support 6.0 and ol=
der, let&#39;s not unconditionally use the compat layer proposed here.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181..." target=
=3D"_blank">a@...2181...</a>&gt;<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/compat/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0src/compat/compat-dco_get_overlapped_result.c | 46 ++++++++++++++++++=
+<br>
=C2=A0src/compat/compat.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++<br>
=C2=A0src/compat/compat.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0src/compat/compat.vcxproj.filters=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 3 ++<br>
=C2=A05 files changed, 60 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 src/compat/compat-dco_get_overlapped_result.c<br>
<br>
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am<br>
index 6eb991dc..6dba08aa 100644<br>
--- a/src/compat/Makefile.am<br>
+++ b/src/compat/Makefile.am<br>
@@ -28,4 +28,5 @@ libcompat_la_SOURCES =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 compat-gettimeofday.c \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 compat-daemon.c \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 compat-strsep.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0compat-versionhelpers.h<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0compat-versionhelpers.h \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0compat-dco_get_overlapped_result.c<br>
diff --git a/src/compat/compat-dco_get_overlapped_result.c b/src/compat/com=
pat-dco_get_overlapped_result.c<br>
new file mode 100644<br>
index 00000000..e14ce976<br>
--- /dev/null<br>
+++ b/src/compat/compat-dco_get_overlapped_result.c<br>
@@ -0,0 +1,46 @@<br>
+/*<br>
+ *=C2=A0 OpenVPN -- An application to securely tunnel IP networks<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0over a single UDP port, =
with support for SSL/TLS-based<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session authentication a=
nd key exchange,<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet encryption, packe=
t authentication, and<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet compression.<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2021-2022 Lev Stipakov &lt;<a href=3D"mailto:lev@...1186...=
.515..." target=3D"_blank">lev@...515...</a>&gt;<br>
+ *=C2=A0 Copyright (C) 2021-2022 OpenVPN Inc &lt;<a href=3D"mailto:sales@...220...=
..515..." target=3D"_blank">sales@...515...</a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software; you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License version 2<br>
+ *=C2=A0 as published by the Free Software Foundation.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program (see the file COPYING included with this<=
br>
+ *=C2=A0 distribution); if not, write to the Free Software Foundation, Inc=
.,<br>
+ *=C2=A0 59 Temple Place, Suite 330, Boston, MA=C2=A0 02111-1307=C2=A0 USA=
<br>
+ */<br>
+<br>
+#ifdef HAVE_CONFIG_H<br>
+#include &quot;config.h&quot;<br>
+#elif defined(_MSC_VER)<br>
+#include &quot;config-msvc.h&quot;<br>
+#endif<br>
+<br>
+#include &quot;compat.h&quot;<br>
+<br>
+#if defined(__MINGW32__) &amp;&amp; !defined(__MINGW64__)<br>
+BOOL<br>
+dco_get_overlapped_result(HANDLE handle, OVERLAPPED *ov, DWORD *transferre=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DWORD delay_millisec, BOOL unused)<br>
+{<br>
+=C2=A0 =C2=A0 BOOL res =3D GetOverlappedResult(handle, ov, transferred, FA=
LSE);<br>
+=C2=A0 =C2=A0 if ((res =3D=3D 0) &amp;&amp; (GetLastError() =3D=3D ERROR_I=
O_INCOMPLETE))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sleep(delay_millisec);</blockquote><div><br></=
div><div>While this may be ok assuming it&#39;s not inside any performance =
critical loops, no need to force this on newer versions of mingw-w64.=C2=A0=
</div><div><br></div><div>Alternatively, we could use AC_CHECK_FUNC to make=
 this conditional or find the symbol GetOverlappedResultEx at runtime. But,=
 imo, we do not=C2=A0need any of this as supporting mingw-w64 version 7+ sh=
ould be enough.</div><div><br></div><div>Regards,</div><div><br></div><div>=
Selva</div></div></div>

--000000000000d68e7f05e2361846--

