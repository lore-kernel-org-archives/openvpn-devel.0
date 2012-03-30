MIME-Version: 1.0
In-Reply-To: <4F75D7D6.5030107@...515...>
References: <4F75D7D6.5030107@...515...>
Date: Fri, 30 Mar 2012 19:48:35 +0300
Message-ID: <CAOazyz3GpGMB0cYQK2EpbRLV42_c1tzOMBfNFjfOs-vZB2xgCw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Buildbot build flags
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

Safest is to go with all combinations...
Or at least:
--disable-lzo --enable-lzo
--enable-pkcs11 --disable-pkcs11
--enable-selinux --disable-selinux
--enable-iproute2 --disable-iproute2
--disable-server
--enable-small
--disable-plugins
--disable-management

--disable-crypto --disable-ssl
--with-crypto-library=3Dopenssl  --enable-crypo --enable-ssl
--with-crypto-library=3Dopenssl  --enable-crypo --disable-ssl
--with-crypto-library=3Dpolarssl  --enable-crypo --enable-ssl
--with-crypto-library=3Dpolarssl  --enable-crypo --disable-ssl


And... for windows, you can use the build-complete script to produce a
complete installer on Linux, if that's work you are good.

Anyway... I want to question [again] these options... I think openvpn
provides more flexibility than it should... there is no point to
disable plugins nor management, cryptoless operation is also somewhat
always required... It can make the code much simpler!

2012/3/30 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi all,
>
> Before Alon's buildsystem overhaul our buildbot farm tested building
> with all unique combinations of the following build flags:
>
> --disable-lzo --disable-ssl, --disable-crypto, --disable-management
>
> In addition, each commit triggerer a build which used no build flags
> (i.e. just ran "./configure").
>
> What build flags should we test now?
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
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

