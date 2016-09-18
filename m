MIME-Version: 1.0
In-Reply-To: <20160918065956.GY78279@...1296...>
References: <20160917132024.12570-1-gert@...1296...>
	<CAKuzo_jqgMNCqcbCHBLO7hHoa9aLDTj3Ed7UmJ446b2J++8BCw@...278...>
	<20160918065956.GY78279@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 18 Sep 2016 10:20:16 -0400
Message-ID: <CAKuzo_gNnXg+XZh+UCzyvHjN+_L5a6N+dQkO_dQxOdvoYQsKcg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06afa0318f69053cc8e6e9
Subject: Re: [Openvpn-devel] [PATCH] Fix win32 building with C99 mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c06afa0318f69053cc8e6e9
Content-Type: text/plain; charset=UTF-8

On Sun, Sep 18, 2016 at 2:59 AM, Gert Doering <gert@...1296...> wrote:

> Ah.  Here we go... trying to redefine WIN32 at the end of syshead.h
> shows what is happening:
>
> In file included from /usr/share/mingw-w64/include/windef.h:8:0,
>                  from /usr/share/mingw-w64/include/windows.h:69,
>                  from /usr/share/mingw-w64/include/winsock2.h:23,
>                  from ../../src/compat/compat.h:29,
>                  from syshead.h:28,
>
> so compat.h is pulling it via
>
> #ifdef HAVE_WINSOCK2_H
> #include <winsock2.h>
> #endif
>
> whee...
>


Yeah, to me that only confirms my feeling that #ifdef WIN32 is not
reliable. Much better to use _WIN32 which appears to be defined by all (?)
C compilers that support windows and doesn't require any particular header
to be included.
http://nadeausoftware.com/articles/2012/01/c_c_tip_how_
use_compiler_predefined_macros_detect_operating_system#
WindowsCygwinnonPOSIXandMinGW

Anyway, right now the priority being un-break building on windows, your v2
looks good. I'll test it and report back.

Thanks,

Selva

--94eb2c06afa0318f69053cc8e6e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Sep 18, 2016 at 2:59 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><div>Ah.=C2=
=A0 Here we go... trying to redefine WIN32 at the end of syshead.h<br>
shows what is happening:<br>
<br>
In file included from /usr/share/mingw-w64/include/w<wbr>indef.h:8:0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/sha=
re/mingw-w64/include/w<wbr>indows.h:69,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/sha=
re/mingw-w64/include/w<wbr>insock2.h:23,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../../sr=
c/compat/compat.h:29,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from syshead.=
h:28,<br>
<br>
so compat.h is pulling it via<br>
<br>
#ifdef HAVE_WINSOCK2_H<br>
#include &lt;winsock2.h&gt;<br>
#endif<br>
<br>
whee...</div></blockquote></div><br><br></div><div class=3D"gmail_extra">Ye=
ah, to me that only confirms my feeling that #ifdef WIN32 is not reliable. =
Much better to use _WIN32 which appears to be defined by all (?) C compiler=
s that support windows and doesn&#39;t require any particular header to be =
included. <br><a href=3D"http://nadeausoftware.com/articles/2012/01/c_c_tip=
_how_use_compiler_predefined_macros_detect_operating_system#WindowsCygwinno=
nPOSIXandMinGW" target=3D"_blank">http://nadeausoftware.com/<wbr>articles/2=
012/01/c_c_tip_how_<wbr>use_compiler_predefined_<wbr>macros_detect_operatin=
g_<wbr>system#<wbr>WindowsCygwinnonPOSIXandMinGW</a><br><br></div><div clas=
s=3D"gmail_extra">Anyway, right now the priority being un-break building on=
 windows, your v2 looks good. I&#39;ll test it and report back.<br><br></di=
v><div class=3D"gmail_extra">Thanks,<br><br></div><div class=3D"gmail_extra=
">Selva<br></div></div>

--94eb2c06afa0318f69053cc8e6e9--

