Date: Wed, 18 Sep 2019 14:01:00 +0200 (CEST)
Message-Id: <201909181201.x8IC10uD018533@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190818111811.8853-2-matthias.andree@...68...>
References: <20190818111811.8853-2-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix regression,
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
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the release/2.4 branch.

Sorry for the delay.  Vacation, and too many distractions.

Lightly tested on an OpenSSL 1.1, a mbedTLS build and an LibreSSL 2.7.2
on OpenBSD 6.3 - with OpenSSL and mbedTLS, it builds and passes all
tests.  

With LibreSSL 2.7.2, it fails due to

./../../openvpn.git/src/openvpn/ssl_openssl.c:1873: undefined reference to `SSL_get1_supported_ciphers'

which looks like this:

#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)
    STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
#else
    STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);   
#endif

this is code which has been in release/2.4 for quite some time (part of
the TLS 1.3 support, commit e8467c864, "--show-tls" enhancements) - so 
if it doesn't break for you, I assume that the call was added to more
recent LibreSSL versions.


commit c8823f7b09c3a6a2101b54763ac2ef146d372328 (release/2.4)
Author: Matthias Andree
Date:   Sun Aug 18 13:18:11 2019 +0200

     Fix regression, reinstate LibreSSL support.

     Signed-off-by: Matthias Andree <matthias.andree@...68...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20190818111811.8853-2-matthias.andree@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18790.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


