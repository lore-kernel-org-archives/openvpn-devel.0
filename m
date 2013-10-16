Message-ID: <525EA680.50308@...515...>
Date: Wed, 16 Oct 2013 17:45:20 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <kvb1ud$dbt$1@...1062...>
In-Reply-To: <kvb1ud$dbt$1@...1062...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn-build dep cache support
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
To: Josh Cepek <josh.cepek@...1085...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> The attached patch allows the openvpn-build system to create and use
> cache tarballs for dependencies, preventing them from being built every
> time (even when they haven't changed.) My VM build time went from ~12 to
> under 2 minutes with this feature.
>
>
Hi Josh,

First of all sorry for the long delay.

I tested your patch today and encountered a build failure when using the
dependency cache. The following command seems properly to generate
dependency cache packages to openvpn-build/generic/depcache:

SAVE_DEP_CACHE=3D1 ./build-complete --sign --sign-pkcs12=3D<pkcs12-file>
--sign-pkcs12-pass=3D<pkcs12-pass> --sign-timestamp=3D"<timestamp-server>"

However, when I try to use the dependency cache I get a build failure:

USE_DEP_CACHE=3D1 ./build-complete --sign --sign-pkcs12=3D<pkcs12-file>
--sign-pkcs12-pass=3D<pkcs12-pass> --sign-timestamp=3D"<timestamp-server>"
--- snip ---
libtool: link: i686-w64-mingw32-gcc
-I/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/include
-I/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/include
-I/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/include
-I/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/include
-I/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/include
-municode -UUNICODE -o .libs/openvpn.exe base64.o buffer.o clinat.o
crypto.o crypto_openssl.o crypto_polarssl.o dhcp.o error.o event.o
fdmisc.o forward.o fragment.o gremlin.o helper.o httpdigest.o lladdr.o
init.o interval.o list.o lzo.o manage.o mbuf.o misc.o platform.o
console.o mroute.o mss.o mstats.o mtcp.o mtu.o mudp.o multi.o ntlm.o
occ.o pkcs11.o pkcs11_openssl.o pkcs11_polarssl.o openvpn.o options.o
otime.o packet_id.o perf.o pf.o ping.o plugin.o pool.o proto.o proxy.o
ps.o push.o reliable.o route.o schedule.o session_id.o shaper.o sig.o
socket.o socks.o ssl.o ssl_openssl.o ssl_polarssl.o ssl_verify.o
ssl_verify_openssl.o ssl_verify_polarssl.o status.o tun.o win32.o
cryptoapi.o openvpn_win32_resources.o=20
../../src/compat/.libs/libcompat.a
-L/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/lib
/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/lib/liblzo2.=
dll.a
/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/lib/libpkcs1=
1-helper.dll.a
-L/home/samuli/openvpn-build/windows-nsis/tmp/image-x86_64/openvpn/lib
-lssl -lcrypto -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
-L/home/samuli/openvpn-build/windows-nsis/tmp/image-i686/openvpn/lib
crypto_openssl.o:crypto_openssl.c:(.text+0x160): undefined reference to
`_EVP_CipherInit'
crypto_openssl.o:crypto_openssl.c:(.text+0x18f): undefined reference to
`_EVP_CipherUpdate'
crypto_openssl.o:crypto_openssl.c:(.text+0x1dc): undefined reference to
`_ERR_clear_error'
crypto_openssl.o:crypto_openssl.c:(.text+0x219): undefined reference to
`_OBJ_nid2sn'
crypto_openssl.o:crypto_openssl.c:(.text+0x221): undefined reference to
`_EVP_get_cipherbyname'
crypto_openssl.o:crypto_openssl.c:(.text+0x239): undefined reference to
`_OBJ_nid2sn'
crypto_openssl.o:crypto_openssl.c:(.text+0x250): undefined reference to
`_EVP_CIPHER_flags'
crypto_openssl.o:crypto_openssl.c:(.text+0x269): undefined reference to
`_EVP_CIPHER_flags'
crypto_openssl.o:crypto_openssl.c:(.text+0x287): undefined reference to
`_EVP_CIPHER_key_length'
--- snip ---

If I don't use the dependency cache the build completes succesfully. Am
I using the cache functionality the way it's supposed to?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


