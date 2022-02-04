Message-ID: <1a63847f-f6a8-6087-4a44-f19ce14ec02a@...2080...>
Date: Fri, 4 Feb 2022 11:32:39 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220203193655.28791-1-a@...2181...>
 <20220203193655.28791-2-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20220203193655.28791-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] crypto: move OpenSSL specific
 FIPS check to its backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

On 03/02/2022 20:36, Antonio Quartulli wrote:
> Our crypto API already provides a function performing a validity check
> on the specified ciphername. The OpenSSL counterpart also checks for the
> cipher being FIPS-enabled.
> 
> This API is cipher_valid(). Extend it so that it can provide a reason
> whenever the cipher is not valid and use it in crypto.c.
> 
> This way we move any OpenSSL specific bit to its own
> backend and directly use the new cipher_valid_reason() API in the
> generic code.
> 
> This patch fixes compilations with mbedTLS when some OpenSSL is also
> installed. The issue was introduced with:
> 544330fe ("crypto: Fix OPENSSL_FIPS enabled builds")
> 
> Cc: David Sommerseth <davids@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Changes from v1:
> * rebased
> * don't return cipher, but true in cipher_valid_reason()
> 
>   src/openvpn/crypto.c         | 11 +++--------
>   src/openvpn/crypto_backend.h | 21 ++++++++++++++++++++-
>   src/openvpn/crypto_mbedtls.c | 13 +++++++++----
>   src/openvpn/crypto_openssl.c |  6 +++++-
>   4 files changed, 37 insertions(+), 14 deletions(-)
> 

I've done test builds on RHEL-8 with both openssl-1.1.1k and
mbedtls-2.16.12-1 without any issues.  Just done some lightweight 
testing on top of reviewing code.  This looks good to me.

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc


