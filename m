Message-ID: <5187610D.5010701@...515...>
Date: Mon, 06 May 2013 10:51:41 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <517F0CE5.6050507@...95...>
In-Reply-To: <517F0CE5.6050507@...95...>
Subject: Re: [Openvpn-devel] openvpn-gui build error (cross-compile for
	Windows)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "spockyf@...95..." <spockyf@...95...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Felix,

I suggest patching the MinGW version that's bundled with Debian. These
links should contain all the information you need:

<https://community.openvpn.net/openvpn/wiki/SettingUpGenericBuildsystem>
<https://community.openvpn.net/openvpn/wiki/InstallingMingwW64>

The patches attached to the second page probably work on Debian, too.

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Hi all together,
>
> I stuck trying to build Openvpn for Windows under Debian wheezy. I use
> the openvpn-build git-repo and installed all packages and dependencies
> mentioned in the README files.
> The Problem always occurs when the build-script tries to build
> openvpn-gui. Here the essential output:
>
> #:~openvpn-build/generic{master}$ IMAGEROOT=3D`pwd`/image-win64
> CHOST=3Dx86_64-w64-mingw32 CBUILD=3Dx86_64-pc-linux-gnu ./build
> ...
> x86_64-w64-mingw32-gcc -std=3Dgnu99 -DHAVE_CONFIG_H -I.
> -I/home/felix/repositories/openvpn-build/generic/image-win64/openvpn/incl=
ude
> -D_UNICODE -DWIN32_LEAN_AND_MEAN -D_WIN32_WINNT=3DNTDDI_WINXP -municode
> -pedantic -Wall -Wextra -MT proxy.o -MD -MP -MF .deps/proxy.Tpo -c -o
> proxy.o proxy.c
> proxy.c: In function 'QueryWindowsProxySettings':
> proxy.c:417:23: error: 'WINHTTP_AUTO_DETECT_TYPE_DHCP' undeclared (first
> use in this function)
> proxy.c:417:23: note: each undeclared identifier is reported only once
> for each function it appears in
> proxy.c:417:55: error: 'WINHTTP_AUTO_DETECT_TYPE_DNS_A' undeclared
> (first use in this function)
> proxy.c:438:32: error: 'WINHTTP_AUTOPROXY_CONFIG_URL' undeclared (first
> use in this function)
> proxy.c:448:21: warning: passing argument 1 of 'GlobalFree' discards
> 'const' qualifier from pointer target type [enabled by default]
> /usr/lib/gcc/x86_64-w64-mingw32/4.6/../../../../x86_64-w64-mingw32/includ=
e/winbase.h:1132:29:
> note: expected 'HGLOBAL' but argument is of type 'LPCWSTR'
> proxy.c:449:27: warning: assignment discards 'const' qualifier from
> pointer target type [enabled by default]
> proxy.c: In function 'OnProxy':
> proxy.c:591:5: warning: ISO C does not support the '%S' ms_printf format
> [-Wformat]
> proxy.c:591:5: warning: ISO C does not support the '%S' ms_printf format
> [-Wformat]
> make[1]: *** [proxy.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> mv -f .deps/options.Tpo .deps/options.Po
> mv -f .deps/passphrase.Tpo .deps/passphrase.Po
> make[1]: Leaving directory
> `/home/felix/repositories/openvpn-build/generic/tmp/openvpn-gui-3'
> make: *** [install-strip] Error 2
> FATAL: make openvpn-gui
>
> In the first place I tried openvpn-gui-2, but there was the same error.
>
> I appreciate any help on that issue.
> If there is some output missing or something else I can provide, then
> just tell me. :-)
>
> Best regards,
> Felix
> ---
> University of Paderborn
>
> -------------------------------------------------------------------------=
-----
> Try New Relic Now & We'll Send You this Cool Shirt
> New Relic is the only SaaS-based application performance monitoring servi=
ce=20
> that delivers powerful full stack analytics. Optimize and monitor your
> browser, app, & servers with just a few lines of code. Try New Relic
> and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


