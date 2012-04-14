MIME-Version: 1.0
In-Reply-To: <4F883775.6020809@...515...>
References: <4F883775.6020809@...515...>
Date: Sat, 14 Apr 2012 19:52:28 +0300
Message-ID: <CAOazyz282i5iosXdnFoX65C-HGPMKEeNEouxn7T0KUzb1QxnPg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Build failure on "master" when using PolarSSL
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

Something was changed in recent polarssl patches.
There is havege_random but not havege_rand, and with different prototype.

2012/4/13 Samuli Sepp=C3=A4nen <samuli@...515...>:
> HI,
>
> I tested building OpenVPN with PolarSSL support on our buildslaves
>
> - Debian 6 i386 (PolarSSL 1.1.1)
> - CentOS 6 amd64 (PolarSSL 1.1.1)
> - Ubuntu 10.04 amd64 (PolarSSL 1.1.0)
>
> All used the following build flags:
>
> --with-crypto-library=3Dpolarssl --enable-crypto --enable-ssl
>
> All gave the same error:
>
> gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include -I../../src/compat =C2=A0=
 =C2=A0 =C2=A0 -g -O2 -MT ssl_polarssl.o -MD -MP -MF .deps/ssl_polarssl.Tpo=
 -c -o ssl_polarssl.o ssl_polarssl.c
> ssl_polarssl.c: In function 'key_state_ssl_init':
> ssl_polarssl.c:520: error: 'havege_rand' undeclared (first use in this fu=
nction)
> ssl_polarssl.c:520: error: (Each undeclared identifier is reported only o=
nce
> ssl_polarssl.c:520: error: for each function it appears in.)
>
> Any clues? There were no traces of earlier PolarSSL installations on any
> of the buildslaves.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
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

