MIME-Version: 1.0
References: <20230208001819.244694-3-arne@...1227...>
 <20230208005925.393200-1-selva.nair@...277...>
 <Y+azhVMqdJb/6gAN@...1296...>
 <CAKuzo_imMOa+UC2FngyyyCvGpERdoyrRNpYnyqEs9+6s4q8_8Q@...278...>
 <Y+ffJEsJI1SvOupe@...1296...>
In-Reply-To: <Y+ffJEsJI1SvOupe@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 11 Feb 2023 13:44:04 -0500
Message-ID: <CAKuzo_hX3utoo8wew951AR9NZdt6hcjgq832tJDvYc6RmJvcNw@...278...>
Content-Type: multipart/alternative; boundary="00000000000081dc0505f471009f"
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Build unit tests in mingw
 Windows build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000081dc0505f471009f
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, Feb 11, 2023 at 1:32 PM Gert Doering <gert@...1296...> wrote:

>
>
> /bin/bash ../../../libtool  --tag=CC   --mode=link i686-w64-mingw32-gcc


This is a 32 bit build which I never tried. Maybe cmocka is not built for
32 bit?


> -I/home/gert/mingw/opt/include  -I/home/gert/mingw/opt/include
> -I../../../include -I/home/gert/mingw/opt/include -Wall
> -Wno-stringop-truncation -I/home/gert/mingw/opt/include -std=c99
> -L/home/gert/mingw/lib -L/home/gert/mingw/opt/lib64 -lssl -lcrypto
> -L/home/gert/mingw/opt/lib -llzo2 -L/home/gert/mingw/opt/lib -lcmocka
> -L/home/gert/mingw/opt/lib -o example_testdriver.exe
> example_testdriver-test.o
> libtool: link: i686-w64-mingw32-gcc -I/home/gert/mingw/opt/include
> -I/home/gert/mingw/opt/include -I../../../include
> -I/home/gert/mingw/opt/include -Wall -Wno-stringop-truncation
> -I/home/gert/mingw/opt/include -std=c99 -o .libs/example_testdriver.exe
> example_testdriver-test.o  -L/home/gert/mingw/lib
> -L/home/gert/mingw/opt/lib64 -lssl -lcrypto -L/home/gert/mingw/opt/lib
> /home/gert/mingw/opt/lib/liblzo2.a -lwinmm -lcmocka
> /usr/bin/i686-w64-mingw32-ld:
> example_testdriver-test.o:test.c:(.text+0x89): undefined reference to
> `_assert_int_equal'
> /usr/bin/i686-w64-mingw32-ld:
> example_testdriver-test.o:test.c:(.text+0xc6): undefined reference to
> `_assert_int_equal'
> /usr/bin/i686-w64-mingw32-ld:
> example_testdriver-test.o:test.c:(.text+0x153): undefined reference to
> `_cmocka_run_group_tests'
>

I had seen something similar with  the master branch -- the def had some
functions missing. But 1.1.5 worked out of the box.

Selva

--00000000000081dc0505f471009f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Sat, Feb 11, 2023 at 1:32 PM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
/bin/bash ../../../libtool=C2=A0 --tag=3DCC=C2=A0 =C2=A0--mode=3Dlink i686-=
w64-mingw32-gcc </blockquote><div><br></div><div>This is a 32 bit build whi=
ch I never tried. Maybe cmocka is not built for 32 bit?</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">-I/home/gert/mingw/opt=
/include=C2=A0 -I/home/gert/mingw/opt/include -I../../../include -I/home/ge=
rt/mingw/opt/include -Wall -Wno-stringop-truncation -I/home/gert/mingw/opt/=
include -std=3Dc99 -L/home/gert/mingw/lib -L/home/gert/mingw/opt/lib64 -lss=
l -lcrypto=C2=A0 -L/home/gert/mingw/opt/lib -llzo2 -L/home/gert/mingw/opt/l=
ib -lcmocka -L/home/gert/mingw/opt/lib -o example_testdriver.exe example_te=
stdriver-test.o=C2=A0 <br>
libtool: link: i686-w64-mingw32-gcc -I/home/gert/mingw/opt/include -I/home/=
gert/mingw/opt/include -I../../../include -I/home/gert/mingw/opt/include -W=
all -Wno-stringop-truncation -I/home/gert/mingw/opt/include -std=3Dc99 -o .=
libs/example_testdriver.exe example_testdriver-test.o=C2=A0 -L/home/gert/mi=
ngw/lib -L/home/gert/mingw/opt/lib64 -lssl -lcrypto -L/home/gert/mingw/opt/=
lib /home/gert/mingw/opt/lib/liblzo2.a -lwinmm -lcmocka<br>
/usr/bin/i686-w64-mingw32-ld: example_testdriver-test.o:test.c:(.text+0x89)=
: undefined reference to `_assert_int_equal&#39;<br>
/usr/bin/i686-w64-mingw32-ld: example_testdriver-test.o:test.c:(.text+0xc6)=
: undefined reference to `_assert_int_equal&#39;<br>
/usr/bin/i686-w64-mingw32-ld: example_testdriver-test.o:test.c:(.text+0x153=
): undefined reference to `_cmocka_run_group_tests&#39;<br></blockquote><di=
v><br></div><div>I had seen something similar with=C2=A0 the master branch=
=C2=A0-- the def had some functions missing. But 1.1.5 worked out of the bo=
x.</div><div><br></div><div>Selva</div></div></div>

--00000000000081dc0505f471009f--

