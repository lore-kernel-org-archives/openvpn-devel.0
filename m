References: <1539153883-15789-1-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <7bd87523-5725-cf42-395c-8416bb35fbdb@...1227...>
Date: Thu, 11 Oct 2018 15:35:42 +0200
MIME-Version: 1.0
In-Reply-To: <1539153883-15789-1-git-send-email-steffan.karger@...1435...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Fix mbedtls unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

Am 10.10.18 um 08:44 schrieb Steffan Karger:
> Commit 674b166 ("Fix build warnings related to get_random()") broke the
> unit tests for mbedtls, because <mbedtls/cipher.h> was now included via
> platform.c -> crypto.h -> crypto_backend.h, but the crypto cflags were
> not included for that unit tests.
> 
> Since we got rid of --disable-crypto, we can now fix this by simply always
> including the CRYPTO_CFLAGS in the TEST_CFLAGS (and the CRYPTO_LIBS in the
> TEST_LDFLAGS). This should not only fix this occurrence, but also prevent
> similar problems in the future.
> 
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> 
> # Conflicts:
> #	tests/unit_tests/openvpn/Makefile.am

This should not be in the commit message.


Otherwise this looks good. It also passes the travis build for me.

Acked-By: Arne Schwabe <arne@...1227...>

