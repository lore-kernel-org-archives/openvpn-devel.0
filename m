References: <564AFAF5.4030004@...515...>
	<SN1PR08MB1391C054994551CB11B84DADB91D0@...2065...>
	<CAKuzo_gAHMwvboZnHoJ7+m9ebdkxjxJQufHMjF=fxqsRimyB8Q@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <564EDA4B.9010708@...515...>
Date: Fri, 20 Nov 2015 10:31:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gAHMwvboZnHoJ7+m9ebdkxjxJQufHMjF=fxqsRimyB8Q@...278...>
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
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Cross compiling on linux is possible. Actually its the only way I've
> build the gui. Its well documented when done as a part of the full
> distribution build using openvpn-build (as Samuli pointed out), but
> could be built alone as well. Here is a very basic description of what I =
do:
>
> The only complication is you need openssl built for the target (windows)
> -- I have this cross-compiled from source and installed in
> $HOME/windows/ There are some tutorials out there on how to
> cross-compile openssl.
>
> Alternatively if change-password feature is not required, you don't need
> openssl at all to build the gui (see below)
>
> I work on Debian Jessie, have autoconf, automake etc and
> mingw-w64-x86-64-dev and mingw-w64-i686-dev installed
>
> Steps -- building for 64 bit windows
>
> Starting from a clone of this gui repo from github, do
>
> $ autoreconf -i -v
>
> run configure as
> $ OPENSSL_CRYPTO_CFLAGS=3D"-I /home/selva/windows/include/
> OPENSSL_CRYPTO_LIBS=3D"-L/home/selva/windows/lib/ -lcrypto" ./configure
> --prefix=3D/ --libdir=3D//lib --host=3Dx86_64-w64-mingw32 --target=3D
> --build=3Dx86_64-pc-linux-gnu --program-prefix=3D'' --sbindir=3D/bin
>
> (replace, /home/selva/windows by the location of openssl include and libs)
>
> If disable-change-password is ok, run configure as
>
> $ ./configure --prefix=3D/ --libdir=3D//lib --host=3Dx86_64-w64-mingw32
> --target=3D --build=3Dx86_64-pc-linux-gnu --program-prefix=3D''
> --sbindir=3D/bin  CFLAGS=3D-DDISABLE_CHANGE_PASSWORD OPENSSL_CRYPTO_LIBS=
=3D"-L./"
>
> $ make  (optionally with -j n)
>
> That will build openvpn-gui.exe
> The exec can be easily installed manually but you can also make the
> installer as
>
> $ make installer   (needs makensis in path)

I added these instructions + David's notes here:

<https://community.openvpn.net/openvpn/wiki/BuildingOpenVPN-GUI>

What we had there previously was fairly outdated and/or confusing.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

