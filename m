Message-ID: <4FABB33C.3020604@...515...>
Date: Thu, 10 May 2012 15:23:24 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4FABB063.8090704@...515...>
In-Reply-To: <4FABB063.8090704@...515...>
Subject: Re: [Openvpn-devel] Some issues with openvpn-build/windows-nsis
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 10.05.2012 15:11, Samuli Sepp=E4nen ha scritto:
> Hi,
>
> I tried to generate a Windows installer on Ubuntu 11.10 amd64, but ran
> into some issues:
>
> $ cd openvpn-build/windows-nsis
> $ ./build-snapshot
> --- snip ---
>
> make[3]: Leaving directory
> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-helper=
-1.10'
> make[2]: Leaving directory
> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-helper=
-1.10'
> make[1]: Leaving directory
> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-helper=
-1.10'
> tap-windows
> Fixup libtool files
> Restore libtool files
> ls: cannot access tmp/image-i686/openvpn-i686-*-bin.*: No such file or
> directory
>
> The error message seems clear enough, but I'm wondering why the binaries
> are not where it looks for them:
>
> $ ls tmp/image-i686
> openvpn
> $ ls tmp/image-i686/openvpn
> bin  etc  include  lib  share

Oh, forgot to ask... is there a clean way to resume the build near the
failure point? Rebuilding everything every time is very time-consuming.

Samuli

