References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-2-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <4b4ce142-6bd1-4763-634d-d561f7adce86@...1856...>
Date: Tue, 8 Aug 2017 21:44:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170807132301.22759-2-chipitsine@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/3] travis-ci: update openssl to 1.0.2l,
 update mbedtls to 2.5.1
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07-08-17 15:23, Ilya Shipitsin wrote:
> ---
>  .travis.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index fc98a4d0..0b531529 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -15,10 +15,10 @@ env:
>      - TAP_WINDOWS_VERSION=9.21.2
>      - LZO_VERSION=2.10
>      - PKCS11_HELPER_VERSION=1.22
> -    - MBEDTLS_VERSION="2.4.0"
> +    - MBEDTLS_VERSION="2.5.1"
>      - MBEDTLS_CFLAGS="-I${PREFIX}/include"
>      - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
> -    - OPENSSL_VERSION="1.0.2k"
> +    - OPENSSL_VERSION="1.0.2l"
>      - OPENSSL_CFLAGS="-I${PREFIX}/include"
>      - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
>  
> 

Bumping these versions every now and then makes sense.  ACK.

-Steffan

