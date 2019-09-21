References: <20190818111811.8853-2-matthias.andree@...68...>
 <201909181201.x8IC10uD018533@...2054...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <78ae852a-527f-84fa-e4a6-6758bbf561e9@...68...>
Date: Sat, 21 Sep 2019 14:07:49 +0200
MIME-Version: 1.0
In-Reply-To: <201909181201.x8IC10uD018533@...2054...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix regression,
 reinstate LibreSSL support.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 18.09.19 um 14:01 schrieb Gert Doering:
> Your patch has been applied to the release/2.4 branch.
>
> Sorry for the delay.  Vacation, and too many distractions.
>
> Lightly tested on an OpenSSL 1.1, a mbedTLS build and an LibreSSL 2.7.2
> on OpenBSD 6.3 - with OpenSSL and mbedTLS, it builds and passes all
> tests.=20=20
>
> With LibreSSL 2.7.2, it fails due to
>
> ./../../openvpn.git/src/openvpn/ssl_openssl.c:1873: undefined reference t=
o `SSL_get1_supported_ciphers'
>
> which looks like this:
>
> #if (OPENSSL_VERSION_NUMBER < 0x1010000fL)
>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get_ciphers(ssl);
> #else
>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);=20=20=20
> #endif
>
> this is code which has been in release/2.4 for quite some time (part of
> the TLS 1.3 support, commit e8467c864, "--show-tls" enhancements) - so=20
> if it doesn't break for you, I assume that the call was added to more
> recent LibreSSL versions.

I was testing against LibreSSL 2.9.2, the oldest for FreeBSD, and this
particular call is listed in the OpenBSD 6.5 changelog here:
https://www.openbsd.org/plus65.html "Provided SSL_get_client_ciphers()
and SSL_get1_supported_ciphers() (part of the OpenSSL 1.1 API)." But I
haven't figured out when or where this was added to LibreSSL releases.

It really looks to me that there isn't a strategy for LibreSSL, but I'll
not backport things to old LibreSSL version, the answer should be
"upgrade or else leave it to your packager/distributor".



