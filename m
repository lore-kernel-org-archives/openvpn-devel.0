References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-11-arne@...1227...>
 <CAKuzo_ikOZgK1oJ_-p9Y46MQ__6u2SD4ctJp-CotW3fEfufz-g@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cafcb35e-0595-8d48-43eb-9515832dabdb@...1227...>
Date: Sun, 31 Oct 2021 12:00:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ikOZgK1oJ_-p9Y46MQ__6u2SD4ctJp-CotW3fEfufz-g@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 10/21] [OSSL 3.0] Replace
 EVP_get_cipherbyname with EVP_CIPHER_fetch
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 30.10.21 um 21:28 schrieb Selva Nair:
> This has an ACK, but will leak memory in OpenSSL 3.0
> 
> On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...
> <mailto:arne@...1227...>> wrote:
> 
>     In OpenSSL 3.0 EVP_get_cipherbyname return a non NULL algorithm
>     even if the algorithm is not avaialble with the currently available
>     provider. Luckily EVP_get_cipherbyname can be used here as drop
>     in replacement and returns only non NULL if the algorithm is actually
>     currently supported.
> 
>     Signed-off-by: Arne Schwabe <arne@...1227... <mailto:arne@...1227...>>
>     ---
>      src/openvpn/crypto_openssl.c |  6 +++---
>      src/openvpn/openssl_compat.h | 17 +++++++++++++++++
>      2 files changed, 20 insertions(+), 3 deletions(-)
> 
>     diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>     index 93c85a836..b10bd7cd5 100644
>     --- a/src/openvpn/crypto_openssl.c
>     +++ b/src/openvpn/crypto_openssl.c
>     @@ -572,7 +572,7 @@ cipher_kt_get(const char *ciphername)
>          ASSERT(ciphername);
> 
>          ciphername = translate_cipher_name_from_openvpn(ciphername);
>     -    cipher = EVP_get_cipherbyname(ciphername);
>     +    cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
> 
> 
> In OpenSSL 3.0, this 'cipher' must be freed. But the compat function is
> written using get_cipherbyname() which returns a const variable that
> should not be freed. Also, here we want to return a const cipher to the
> caller.
> 
> One option is to continue using get_cipherbyname() but add a helper call
> for OpenSSL 3.0 to check algorithm availability. Say,
> EVP_CIPHER_available() that fetches, checks the result and frees --- 
> to be used on top of the existing code.

That is an option but will break as soon as we have the first cipher
that is no longer defined with EVP_ORIG_GLOBAL compatibility definition.
I need to check how much work it is to teach OpenVPN to free the cipher
and md.

Arne

