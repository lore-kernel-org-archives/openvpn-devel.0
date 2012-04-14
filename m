MIME-Version: 1.0
In-Reply-To: <4F882970.4080302@...515...>
References: <4F882970.4080302@...515...>
Date: Sat, 14 Apr 2012 19:44:40 +0300
Message-ID: <CAOazyz2G_6FugO43_Vsc5GLW4oZpEkGDRkujsOAbw9Qdd3ftfQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Build tests using "generic" buildsystem and Git
	"master"!
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

2012/4/13 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi all,
>
> I also ran some build tests with the "generic" buildsystem[1], OpenVPN
> Git "master"[2] and an Ubuntu 11.10 amd64 workstation. As the Git
> "master" does not yet seem to include the "generic" buildsystem,

I don't understand what you mean... please explain what is "include"...?

> I downloaded it separately[3] and pointed it to a tarball[4] assembled
> from latest Git "master" code. Building the obsolete OpenVPN-GUI 1.0.3
> for Windows seemed to fail, so I disabled it by editing the build script
> (generic/build). Anyways, here are the results of the tests...

I updated the openvpn-gui to meet the build system... patch is pending.

>
> Building a native binary worked:
>
> $ IMAGEROOT=3D`pwd`/image-native ./build)
>
> Building a Windows 32bit binary on Linux 64bit worked:
>
> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> \ CBUILD=3Dx86_64-pc-linux-gnu ./build
>
> Building a Windows 64bit binary on Linux 64bit worked:
>
> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> \ CBUILD=3Dx86_64-pc-linux-gnu ./build
>
> I could not test building for Arm, as the my workstation was missing the
> required tools.
>
> Samuli
>
> [1]
> <https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsyst=
em#Genericbuildmethod>
> [2] <git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn.git>
> [3] <https://github.com/alonbl/openvpn-build.git>
> [4] <http://build.openvpn.net/downloads/snapshots/openvpn-2.3_alpha1.tar.=
gz>
>
> -------------------------------------------------------------------------=
-----
> For Developers, A Lot Can Happen In A Second.
> Boundary is the first to Know...and Tell You.
> Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
> http://p.sf.net/sfu/Boundary-d2dvs2
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

