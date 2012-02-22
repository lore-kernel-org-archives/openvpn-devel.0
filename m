Message-ID: <4F44A1A3.8050007@...515...>
Date: Wed, 22 Feb 2012 10:04:51 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
In-Reply-To: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
Subject: Re: [Openvpn-devel] [build] Windows build test
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi Alon,
> Hello people who actually use Windows!
>
> I will appreciate if you test my new windows build environment for OpenVP=
N.
I'll test this today.

> You have many options, I guess all are needed.
>
> While you at it, please try to explain me why we need Visual Studio build=
... :)
I guess for building the TAP-driver. Besides that, I've never had a
clear idea :).

> .
> Build is here[1]
>
> BEST METHOD - Compile on Linux

Agreed :).
>
> This is a generic method, it can cross compile OpenVPN using any
> toolchain to any environment.
> For Windows, make sure you have mingw-w64 toolchain.
> We are using nsis so we can also package files at Linux.
>
> $ cd generic
> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> CBUILD=3Dx86_64-pc-linux-gnu ./build
> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> CBUILD=3Dx86_64-pc-linux-gnu ./build
> SLOWER METHOD - Compile on cygwin
>
> Read README for required packages.
>
> $ cd generic
> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> CBUILD=3Di686-pc-cygwin ./build
> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> CBUILD=3Di686-pc-cygwin ./build
>
> Visual Studio Complete Batch
>
> install perl
>
>> cd msvc
>> build
> Visual Studio IDE
>
> After you have the dependencies of Complete Batch or your own.
> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> location of the dependencies.
>
>> msvc-dev
> MSBuild
>
> After you have the dependencies of Complete Batch or your own.
> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> location of the dependencies.
>
>> msvc-build
> Good luck,
> Alon.
>
> [1] https://github.com/alonbl/openvpn-build
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing=20
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


