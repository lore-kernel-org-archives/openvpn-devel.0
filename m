MIME-Version: 1.0
References: <99D61A626FDA8A4B90A270669121BE109921F37A@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE109921F37A@...2294...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Oct 2018 11:55:24 -0400
Message-ID: <CAKuzo_gYbs-13OiAk3_+1qHsCR3x67XKd7t-AAiNDfTKx=KX3Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000000290950577e1e3cc"
Subject: Re: [Openvpn-devel] MinGW to build DLL not EXE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000290950577e1e3cc
Content-Type: text/plain; charset="UTF-8"

HI,

>
> I have almost finished integrating tapctl.exe and openvpnmsica.dll
> utilities
> for MSI packaging into the OpenVPN/openvpn repo. However, I am totally new
> with MinGW and would need some help.
>
> How do you tell the OpenVPN's build process to create a DLL file, not an
> EXE?
>

As with gcc mingw takes -shared option to create dll. But I guess you want
to use autotools. If so:

In configure.ac add "LT_INIT([win32-dll])" and a barebones Makefile.am
would be

lib_LTLIBRARIES = libtest.la
libtest_la_LDFLAGS = -no-undefined -avoid-version
libtest_la_SOURCES = test.c
libtest_la_CFLAGS = --std=c99

Run autoreconf -iv; ./configure; make and will produce libtest.dll in
./.libs/

I believe all symbols are exported by default. Adding "-export-symbols
symbol-file"
may be an easy way to customize it.

Selva

--0000000000000290950577e1e3cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">HI,<br>=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
I have almost finished integrating tapctl.exe and openvpnmsica.dll utilitie=
s<br>
for MSI packaging into the OpenVPN/openvpn repo. However, I am totally new<=
br>
with MinGW and would need some help.<br>
<br>
How do you tell the OpenVPN&#39;s build process to create a DLL file, not a=
n<br>
EXE?<br></blockquote><div><br></div><div>As with gcc mingw takes -shared op=
tion to create dll. But I guess you want to use autotools. If so:<br><br></=
div><div>In <a href=3D"http://configure.ac" target=3D"_blank">configure.ac<=
/a> add &quot;LT_INIT([win32-dll])&quot; and a barebones Makefile.am would =
be<br><br>lib_LTLIBRARIES =3D <a href=3D"http://libtest.la" target=3D"_blan=
k">libtest.la</a><br>libtest_la_LDFLAGS =3D -no-undefined -avoid-version<br=
>libtest_la_SOURCES =3D test.c <br>libtest_la_CFLAGS =3D --std=3Dc99<br><br=
></div><div>Run autoreconf -iv; ./configure; make and will produce libtest.=
dll in ./.libs/<br><br></div><div>I believe all symbols are exported by def=
ault. Adding &quot;-export-symbols symbol-file&quot;<br></div><div>may be a=
n easy way to customize it. <br><br></div><div>Selva<br></div><br></div></d=
iv></div></div></div>

--0000000000000290950577e1e3cc--

