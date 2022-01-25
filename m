Message-ID: <83748bfd-cfc3-8f5d-d953-d09569b66a97@...2181...>
Date: Tue, 25 Jan 2022 17:24:16 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220121201038.49684-1-openvpn@...2080...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220121201038.49684-1-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: Fix mbedtls builds
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
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

Hi,

On 21/01/2022 21:10, David Sommerseth wrote:
> From: David Sommerseth <davids@...515...>
> 
> With commit 544330fefedc87, the openssl_compat.h got included in
> crypto.c.  This caused issues when building against mbed TLS, which this
> compat layer is not targeting.
> 
> This issue is resolved by only including this header when the OpenSSL
> library is in use.  The OPENSSL_FIPS macro should never be set when
> compiling against the mbed TLS library.  But we check against the main
> ENABLE_CRYPTO_OPENSSL macro here, in case future updates adds more
> OpenSSL specific fragments.
> 
> Signed-off-by: David Sommerseth <davids@...515...>

I am personally NAK'ing this patch, however, after further discussion on 
IRC I can say that this was the consensus reached with David and Arne as 
well.

The idea is that having OpenSSL specific code in crypto.c is a no-go.

Like all other functionalities, we need to hide the FIPS check behind 
our SSL abstraction, so that each backend can decie what to do (mbedtls 
will probably just say "sure, go ahead").

So this patch should be dropped.


Best Regards,


-- 
Antonio Quartulli

