MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
 <CAKuzo_jdwhEhy6f2N0uXcQOyjoCMQ41Ja3Pg0LwBww7UYmY2zA@...278...>
In-Reply-To: <CAKuzo_jdwhEhy6f2N0uXcQOyjoCMQ41Ja3Pg0LwBww7UYmY2zA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 18 Sep 2019 23:27:19 +0300
Message-ID: <CAGyAFMVr5=bbF3GA9i+i3=rNJtMMcUPgvG6r-PnW8xVmgvMUFg@...278...>
Content-Type: multipart/alternative; boundary="0000000000009ff37e0592d9aa75"
Subject: Re: [Openvpn-devel] [PATCH 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000009ff37e0592d9aa75
Content-Type: text/plain; charset="UTF-8"

Hi,

Turns out that our build script for windows-nsis/generic doesn't specify
any optimization flags.

I added -O2 and got 400Mbit/s with mingw, which is better than 340 but
worse than VS's 425.

Haven't yet checked which flags are used for openssl build.

Also adding "-O2" to CFLAGS breaks rc build:

libtool: compile:  i686-w64-mingw32-windres -DHAVE_CONFIG_H -I. -I../..
-I../../include -I../../include -I../../src/compat -DWIN32_LEAN_AND_MEAN
-DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA -O2 -i
openvpnmsica_resources.rc  -o .libs/openvpnmsica_resources.o
i686-w64-mingw32-windres: unknown format type `2'
i686-w64-mingw32-windres: supported formats: rc res coff
Makefile:827: recipe for target 'openvpnmsica_resources.lo' failed

This happens because windres treats "-O" as own option, so I removed .rc
files from Makefile(s).am for testing.

I'll play with optimizations flags and find a proper solution for rc build.
I think this has to be fixed also in the next 2.4 release.

-- 
-Lev

--0000000000009ff37e0592d9aa75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div class=3D"gmail_quote"><div>=
<br></div><div>Turns out that our build script for windows-nsis/generic doe=
sn&#39;t specify any optimization flags.=C2=A0</div><div><br></div><div>I a=
dded -O2 and got 400Mbit/s with mingw, which is better than 340 but worse t=
han VS&#39;s 425.</div><div><br></div><div>Haven&#39;t yet checked which fl=
ags are used for openssl build.</div><div><br></div><div>Also adding &quot;=
-O2&quot; to CFLAGS breaks rc build:</div><div><br></div><div>libtool: comp=
ile: =C2=A0i686-w64-mingw32-windres -DHAVE_CONFIG_H -I. -I../.. -I../../inc=
lude -I../../include -I../../src/compat -DWIN32_LEAN_AND_MEAN -DNTDDI_VERSI=
ON=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA -O2 -i openvpnmsica_re=
sources.rc =C2=A0-o .libs/openvpnmsica_resources.o<br>i686-w64-mingw32-wind=
res: unknown format type `2&#39;<br>i686-w64-mingw32-windres: supported for=
mats: rc res coff<br>Makefile:827: recipe for target &#39;openvpnmsica_reso=
urces.lo&#39; failed<br></div><div>=C2=A0</div></div><div>This happens beca=
use windres treats &quot;-O&quot; as own option, so I removed .rc files fro=
m Makefile(s).am for testing.</div><div><br></div><div>I&#39;ll play with o=
ptimizations flags and find a proper solution for rc build. I think this ha=
s to be fixed also in the next 2.4 release.</div><div><br></div>-- <br><div=
 dir=3D"ltr" class=3D"m_5701038357204096294gmail_signature">-Lev</div></div>

--0000000000009ff37e0592d9aa75--

