MIME-Version: 1.0
In-Reply-To: <4FAD3230.70603@...515...>
References: <4FAD3230.70603@...515...>
Date: Fri, 11 May 2012 18:56:27 +0300
Message-ID: <CAOazyz0yHxcSU_c82nYWNBfOj-a=DzSrAfTkfLOhkHZR5T-4=A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Some openvpn-build issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, May 11, 2012 at 6:37 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Hi (Alon),
>
> Just a quick overview of the build issues I ran into while building with
>
> $ cd openvpn-build/windows-nsis
> $ ./build-snapshot <signing options>
>
> First, the build_openvpn_gui() fails with
>
> i686-w64-mingw32-gcc -std=3Dgnu99 -municode -pedantic -Wall -Wextra
> -mwindows -o openvpn-gui.exe main.o openvpn.o localization.o tray.o
> viewlog.o service.o options.o passphrase.o proxy.o registry.o scripts.o
> manage.o openvpn_config.o res/openvpn-gui-res.o
> -L/home/samuli/opt/openvpn-build/windows-nsis/tmp/image-i686/openvpn/lib
> -lcrypto -lws2_32 -lcomctl32
> /usr/lib/gcc/i686-w64-mingw32/4.6.1/../../../../i686-w64-mingw32/lib/../l=
ib/libmingwex.a(lib32_libmingwex_a-_wctime32.o):
> In function `_wctime32':
> /build/buildd/mingw-w64-1.0+20110523/mingw-w64-crt/misc/_wctime32.c:15:
> undefined reference to `__imp__wctime'
> collect2: ld returned 1
> make[1]: *** [openvpn-gui.exe] Error 1
> make[1]: leaving directory
> "/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/openvpn-gui-1=
.0.3"
> make: *** [install-strip] Error 2
> FATAL: make openvpn-gui
> FATAL: build i686 >&2
>
> I circumvented this by commenting out openvpn-gui building in
> openvpn-build/generic/build main() method:

This is due to old mingw runtime libs.
Known issue with mingw.

>
> build_openvpn
> #[ -n "${BUILD_FOR_WINDOWS}" ] && build_openvpn_gui
> copy_docs
>
> I also had to fix openvpn.nsi or it failed, not finding openvpn-gui.exe

Please upgrade mingw.... :)

> Next "openvpn-build/windows-nsis/build" failed:
>
> unix2dos: converting file tmp/installer/easy-rsa/Windows/init-config.bat
> to DOS format ...
> unix2dos: converting file tmp/installer/easy-rsa/Windows/revoke-full.bat
> to DOS format ...
> unix2dos: converting file tmp/installer/easy-rsa/Windows/serial.start to
> DOS format ...
> unix2dos: converting file tmp/installer/easy-rsa/Windows/vars.bat.sample
> to DOS format ...
> ./build: 5: Bad substitution
> FATAL: pack i686 >&2
>
> This was a Dash shell issue, which you apparently fixed. I just didn't
> have time yet to test your fix. Switching to /bin/bash helped get around
> this.

Yes, fixed that already.

> I also noticed that there's a dependency to osslsigncode 1.4+ due to
> missing pkcs12 options in older versions. While it would fairly easy to
> adapt the codesign() method to support 1.3 and earlier, I think the 1.4
> dependency is fine: not that many people build Windows installers.

It is fine... I rewrote its build system and added the PKCS#12 support :)

> I added some comments to the scripts as I went through them. I'll send
> in patches next week that clarify how they work, i.e. make them seem
> less "magical" :D.

OK.

>
> Alon: thanks for work well done! This is way better than what we had
> earlier!

I am happy to get rid of the old python none standard build... :)
Now people may actually produce their own installers....

Alon.

