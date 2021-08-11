References: <20210810061644.20353-1-maximilian.fillinger@...2507...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ee85d278-ee43-8da2-2fc2-cebfcd01b88c@...2181...>
Date: Wed, 11 Aug 2021 14:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <20210810061644.20353-1-maximilian.fillinger@...2507...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Replace deprecated mbedtls DRBG update
 function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Hi,

On 10/08/2021 08:16, Max Fillinger wrote:
> The function mbedtls_ctr_drbg_update is deprecated as of mbedtls 2.16
> and is superseded by mbedtls_ctr_drbg_update_ret, which returns an error
> code. This commit replaces the call to the deprecated function with the
> new one and logs a warning in case of an error.
> 
> For older versions of mbedtls, we add a compatibility function that runs
> mbedtls_ctr_drbg_update and returns 0.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>

I also gave this patch a go and compiled it against:
* mbedTLS 2.26.0
* mbedTLS 2.20.0
* mbedTLS 2.10.0

all good.
Patch looks good to me too.

Acked-by: Antonio Quartulli <antonio@...515...>



-- 
Antonio Quartulli

