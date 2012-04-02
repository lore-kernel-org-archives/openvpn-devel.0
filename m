Message-ID: <4F79554D.20708@...515...>
Date: Mon, 02 Apr 2012 10:29:17 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4F75D7D6.5030107@...515...>
	<CAOazyz3GpGMB0cYQK2EpbRLV42_c1tzOMBfNFjfOs-vZB2xgCw@...278...>
In-Reply-To: <CAOazyz3GpGMB0cYQK2EpbRLV42_c1tzOMBfNFjfOs-vZB2xgCw@...278...>
Subject: Re: [Openvpn-devel] Buildbot build flags
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Alon,
> Safest is to go with all combinations...
Testing all combinations would be best, but there are a _lot_ of them...
then you need to multiply that with the number of buildslaves (atm ~10) :).
> Or at least:
> --disable-lzo --enable-lzo
> --enable-pkcs11 --disable-pkcs11
> --enable-selinux --disable-selinux
> --enable-iproute2 --disable-iproute2
> --disable-server
> --enable-small
> --disable-plugins
> --disable-management
>
> --disable-crypto --disable-ssl
> --with-crypto-library=openssl  --enable-crypo --enable-ssl
> --with-crypto-library=openssl  --enable-crypo --disable-ssl
> --with-crypto-library=polarssl  --enable-crypo --enable-ssl
> --with-crypto-library=polarssl  --enable-crypo --disable-ssl
Sounds good to me. Any additions / opinions from somebody else?

> And... for windows, you can use the build-complete script to produce a
> complete installer on Linux, if that's work you are good.
Buildbot 0.8.5 (current version) supports Windows buildslaves, so that's
on my TODO... might take a while, though. With cross-compiling on *NIX
for Windows working properly, I could perhaps repurpose the Windows
build computer as a buildslave.

Samuli


