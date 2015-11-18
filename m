MIME-Version: 1.0
In-Reply-To: <SN1PR08MB1391C054994551CB11B84DADB91D0@...2065...>
References: <564AFAF5.4030004@...515...>
	<SN1PR08MB1391C054994551CB11B84DADB91D0@...2065...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 17 Nov 2015 22:55:48 -0500
Message-ID: <CAKuzo_gAHMwvboZnHoJ7+m9ebdkxjxJQufHMjF=fxqsRimyB8Q@...278...>
Content-Type: multipart/alternative; boundary=001a11478ae0420b5d0524c89ffc
Subject: Re: [Openvpn-devel] OpenVPN-GUI now on GitHub + other Windows team
	things
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11478ae0420b5d0524c89ffc
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Nov 17, 2015 at 8:44 AM, Morris, Russell <rmorris@...1315...>
wrote:

> Hi,
>
> I do see the notes about " Building OpenVPN GUI from source" - but is
> there a way to build this under Linux (may be easier for some)?
>

Cross compiling on linux is possible. Actually its the only way I've build
the gui. Its well documented when done as a part of the full distribution
build using openvpn-build (as Samuli pointed out), but could be built alone
as well. Here is a very basic description of what I do:

The only complication is you need openssl built for the target (windows) --
I have this cross-compiled from source and installed in $HOME/windows/
There are some tutorials out there on how to cross-compile openssl.

Alternatively if change-password feature is not required, you don't need
openssl at all to build the gui (see below)

I work on Debian Jessie, have autoconf, automake etc and
mingw-w64-x86-64-dev and mingw-w64-i686-dev installed

Steps -- building for 64 bit windows

Starting from a clone of this gui repo from github, do

$ autoreconf -i -v

run configure as
$  OPENSSL_CRYPTO_CFLAGS="-I /home/selva/windows/include/
OPENSSL_CRYPTO_LIBS="-L/home/selva/windows/lib/ -lcrypto" ./configure
--prefix=/ --libdir=//lib --host=x86_64-w64-mingw32 --target=
--build=x86_64-pc-linux-gnu --program-prefix='' --sbindir=/bin

(replace, /home/selva/windows by the location of openssl include and libs)

If disable-change-password is ok, run configure as

$ ./configure --prefix=/ --libdir=//lib --host=x86_64-w64-mingw32 --target=
--build=x86_64-pc-linux-gnu --program-prefix='' --sbindir=/bin
CFLAGS=-DDISABLE_CHANGE_PASSWORD OPENSSL_CRYPTO_LIBS="-L./"

$ make  (optionally with -j n)

That will build openvpn-gui.exe
The exec can be easily installed manually but you can also make the
installer as

$ make installer   (needs makensis in path)

Selva

--001a11478ae0420b5d0524c89ffc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Tue, Nov 17, 2015 at 8:44 AM, Mo=
rris, Russell <span dir=3D"ltr">&lt;<a href=3D"mailto:rmorris@...1315..." t=
arget=3D"_blank">rmorris@...1315...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div style=3D"overflow:hidden">Hi,<br>
<br>
I do see the notes about &quot; Building OpenVPN GUI from source&quot; - bu=
t is there a way to build this under Linux (may be easier for some)?<br>
</div></blockquote></div><br></div><div class=3D"gmail_extra">Cross compili=
ng on linux is possible. Actually its the only way I&#39;ve build the gui. =
Its well documented when done as a part of the full distribution build usin=
g openvpn-build (as Samuli pointed out), but could be built alone as well. =
Here is a very basic description of what I do:<br><br>The only complication=
 is you need openssl built for the target (windows) -- I have this cross-co=
mpiled from source and installed in $HOME/windows/ There are some tutorials=
 out there on how to cross-compile openssl.<br><br></div><div class=3D"gmai=
l_extra">Alternatively if change-password feature is not required, you don&=
#39;t need openssl at all to build the gui (see below)<br><br></div><div cl=
ass=3D"gmail_extra">I work on Debian Jessie, have autoconf, automake etc an=
d mingw-w64-x86-64-dev and mingw-w64-i686-dev installed<br><br></div><div c=
lass=3D"gmail_extra">Steps -- building for 64 bit windows<br><br></div><div=
 class=3D"gmail_extra">Starting from a clone of this gui repo from github, =
do<br><br></div><div class=3D"gmail_extra">$ autoreconf -i -v<br><br>run co=
nfigure as<br>$=C2=A0 OPENSSL_CRYPTO_CFLAGS=3D&quot;-I /home/selva/windows/=
include/ OPENSSL_CRYPTO_LIBS=3D&quot;-L/home/selva/windows/lib/ -lcrypto&qu=
ot; ./configure --prefix=3D/ --libdir=3D//lib --host=3Dx86_64-w64-mingw32 -=
-target=3D --build=3Dx86_64-pc-linux-gnu --program-prefix=3D&#39;&#39; --sb=
indir=3D/bin <br><br></div><div class=3D"gmail_extra">(replace, /home/selva=
/windows by the location of openssl include and libs)<br><br></div><div cla=
ss=3D"gmail_extra">If disable-change-password is ok, run configure as<br><b=
r>$ ./configure --prefix=3D/ --libdir=3D//lib --host=3Dx86_64-w64-mingw32=20
--target=3D --build=3Dx86_64-pc-linux-gnu --program-prefix=3D&#39;&#39; --s=
bindir=3D/bin=C2=A0 CFLAGS=3D-DDISABLE_CHANGE_PASSWORD OPENSSL_CRYPTO_LIBS=
=3D&quot;-L./&quot;<br><br></div><div class=3D"gmail_extra">$ make=C2=A0 (o=
ptionally with -j n)<br><br></div><div class=3D"gmail_extra">That will buil=
d openvpn-gui.exe<br>The exec can be easily installed manually but you can =
also make the installer as<br><br></div><div class=3D"gmail_extra">$ make i=
nstaller=C2=A0=C2=A0 (needs makensis in path)<br><br></div><div class=3D"gm=
ail_extra">Selva<br></div></div>

--001a11478ae0420b5d0524c89ffc--

