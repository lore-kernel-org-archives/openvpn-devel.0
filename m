MIME-Version: 1.0
In-Reply-To: <1330128297432870500@...1315...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<1330128297432870500@...1315...>
Date: Sat, 25 Feb 2012 02:11:27 +0200
Message-ID: <CAOazyz3e2ofYxXHiEfxc86nvht87w5_rMqZso8uhKp0i9Y=BhQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [build] Windows build test
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
To: Russell Morris <openembedded@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

How exactly did you try to build?
Please send command-line.

The mingw32 suffix is historic, it is kept for compatibility as old
autotools(config.guess) packages expects for mingw32 as a platform, in
the old days there was no (forced) standard for specifying the arch.

On Sat, Feb 25, 2012 at 2:04 AM, Russell Morris
<openembedded@...1315...> wrote:
> Hi,
>
> First of all - thanks for this! It's very much appreciated!
>
> I tried this on my Linux box, and it worked fine - for the win32 image.
> However, the win64 image fails, with the following error ...
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw32/bi=
n/ld:
> cannot find -llzo2
> /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw32/bi=
n/ld:
> cannot find -lpkcs11-helper
> collect2: ld returned 1 exit status
> make[3]: *** [openvpn.exe] Error 1
> make[3]: Leaving directory
> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvpn-2.=
3-alpha1/src/openvpn'
> make[2]: *** [install-recursive] Error 1
> make[2]: Leaving directory
> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvpn-2.=
3-alpha1/src'
> make[1]: *** [install-recursive] Error 1
> make[1]: Leaving directory
> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvpn-2.=
3-alpha1'
> make: *** [install-strip] Error 2
> FATAL: make openvpn
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Has anyone else seen this? Any thoughts how to correct it?
>
> Also, if you don't mind me asking - can anyone explain the naming convent=
ion
> for i686-w64-mingw32 vs. x86_64-w64-mingw32? They both seem to be "mingw3=
2",
> so a bit confused how one is really 64 bit.
>
> Thanks again,
> ... Russell
>
>
>
>
> On Tue, 02/21/2012 06:12 PM, Alon=C2=A0Bar-Lev=C2=A0<alon.barlev@...1663...=
.> wrote:
>
> Hello people who actually use Windows!
>
> I will appreciate if you test my new windows build environment for OpenVP=
N.
>
> You have many options, I guess all are needed.
>
> While you at it, please try to explain me why we need Visual Studio build=
...
> :)
> .
> Build is here[1]
>
> BEST METHOD - Compile on Linux
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
>
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
>
> Visual Studio IDE
>
> After you have the dependencies of Complete Batch or your own.
> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> location of the dependencies.
>
>> msvc-dev
>
> MSBuild
>
> After you have the dependencies of Complete Batch or your own.
> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> location of the dependencies.
>
>> msvc-build
>
> Good luck,
> Alon.
>
> [1] https://github.com/alonbl/openvpn-build
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

