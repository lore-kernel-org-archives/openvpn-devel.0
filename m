From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] ARM port
In-Reply-To: <42BBC0A3.9030501@...425...>
Message-ID: <Pine.LNX.4.58.0506241158490.10675@...41...>
References: <42BBC0A3.9030501@...425...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Jun 24 11:23:23 2005
Content-Type: TEXT/PLAIN; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?=D8yvind_Repvik?= <oyvind@...425...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 24 Jun 2005, [ISO-8859-1] =D8yvind Repvik wrote:

>=20
>  >This is the first report I've ever seen of an assertion in this=20
>  >function.
>  >Try making the function non-inline and see if that changes anything.
>  >
>  >Which compiler/version are you using?
>  >
>  >James
>=20
> I can confirm this, on the same ARM platform (Intel IXP420), and openvpn=
=20
> tarball downloaded yesterday (2.0):
>=20
> Fri Jun 24 07:52:49 2005 TESTING ENCRYPT/DECRYPT of packet length=3D96
> Fri Jun 24 07:52:49 2005 TESTING ENCRYPT/DECRYPT of packet length=3D97
> Fri Jun 24 07:52:49 2005 Assertion failed at integer.h:94
> Fri Jun 24 07:52:49 2005 Exiting

I need more information on this one:

* What are the values of x, y, and mod when the assertion is hit?

* A call stack trace would be nice, i.e. which function was calling
modulo_add when the assertion was hit?

* Does the assertion always hit in the test above immediately after packet=
=20
length=3D97?

* What is the config file or command line which was used to generate the
test?

* Does the assertion occur if compiler optimization is turned off?  (edit=20
Makefile and remove -O2 from gcc commands)

* Does the assertion occur if inline functions are turned off?  (edit=20
Makefile and add -fno-inline to gcc commands)

> I've compiled openvpn using native gcc:
> Reading specs from /usr/lib/gcc/armeb-linux/3.4.4/specs
> Configured with:=20
> /home/repvik/slug-svn/build/tmp/work/gcc-3.4.4-r0/gcc-3.4.4/configure=20
> --build=3Di686-linux --host=3Darmeb-linux --target=3Darmeb-linux --prefix=
=3D/usr=20
> --exec_prefix=3D/usr --bindir=3D/usr/bin --sbindir=3D/usr/sbin=20
> --libexecdir=3D/usr/libexec --datadir=3D/usr/share --sysconfdir=3D/etc=20
> --sharedstatedir=3D/usr/com --localstatedir=3D/var --libdir=3D/usr/lib=20
> --includedir=3D/usr/include --oldincludedir=3D/usr/include=20
> --infodir=3D/usr/share/info --mandir=3D/usr/share/man=20
> --enable-clocale=3Dgeneric --with-gnu-ld --enable-shared=20
> --enable-target-optspace --enable-languages=3Dc,c++,f77=20
> --enable-threads=3Dposix --enable-multilib --enable-c99 --enable-long-lon=
g=20
> --enable-symvers=3Dgnu --enable-libstdcxx-pch=20
> --program-prefix=3Darmeb-linux- --with-local-prefix=3D/usr/local=20
> --with-gxx-include-dir=3D/usr/include/c++/3.4.4 --with-float=3Dsoft=20
> --disable-nls
> Thread model: posix
> gcc version 3.4.4

James

