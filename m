Message-ID: <500FB3EB.3060507@...515...>
Date: Wed, 25 Jul 2012 11:52:59 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAO5YuCXYLusXiOcqFXF0Ni77b73Z+XTKsE_JpBrN45bTiMfdHQ@...278...>
In-Reply-To: <CAO5YuCXYLusXiOcqFXF0Ni77b73Z+XTKsE_JpBrN45bTiMfdHQ@...278...>
Subject: Re: [Openvpn-devel] Windows building error
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
To: jay alco <jproxy22@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Jay,
> I'm trying to build openvpn on windows with mingw but having trouble.
> I tried building both openvpn 2.1.4 and 2.2.2 from source without
> changing configuration, just executing domake-win and it builds the
> exe perfectly. But when i change configurations in makeopenvpn file i
> cause me the error.
>
> I use the following configuration to guild without crypto and ssl. just l=
zo.
>
> 	    --enable-strict \
> 	    --prefix=3D$H/windest \
> 	    MAN2HTML=3Dtrue \
> 	    --disable-crypto \
> 	    --disable-ssl \
> 	    --enable-password-save \
> 	    --with-lzo-headers=3D$H/$LZO_DIR/include \
> 	    --with-lzo-lib=3D$H/$LZO_DIR \
> 	    --with-pkcs11-helper-headers=3D$H/$PKCS11_HELPER_DIR/usr/local/inclu=
de \
> 	    --with-pkcs11-helper-lib=3D$H/$PKCS11_HELPER_DIR/usr/local/lib
>
> but it produce the following error both 2.1.4 and 2.2.2.
Trust me, trying to build 2.1.4 for Windows is (as Gert said) a way to
insanity. If you really have to use a s.c. "stable" version of OpenVPN,
I suggest 2.2.2 which at least has a more or less complete Python-based
buildsystem which is documented here:

<https://community.openvpn.net/openvpn/wiki/BuildingOnWindows>

However, I'd recommend taking the just released openvpn-2.3-alpha3 and
using the new "openvpn-build" buildsystem to build it:

<https://github.com/OpenVPN/openvpn-build>
<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem>

If you want to try building on a Windows using Microsoft Visual Studio
2010 or later, "openvpn-build" has a separate "msvc" buildsystem for
that purpose. The "generic" buildsystem, which is a cross-compile
buildsystem for *NIX environments, is more well tested, and works very
nicely. Ubuntu 12.04 64-bit is a good build platform, provided you
install backported mingw-w64 packages:

<https://community.openvpn.net/openvpn/wiki/InstallingMingwW64>

Hope this helps,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


