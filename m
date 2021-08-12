References: <YRQA6duboZXtB9do@...1296...>
 <20210812075757.31759-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <691d046b-c916-f21a-ebfe-47a6e35f3d1b@...2181...>
Date: Thu, 12 Aug 2021 10:20:23 +0200
MIME-Version: 1.0
In-Reply-To: <20210812075757.31759-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: do not define
 mbedtls_ctr_drbg_update_ret for mbedtls <2.15 and >=2.14.1
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

On 12/08/2021 09:57, Antonio Quartulli wrote:
> The mbedtls_ctr_drbg_update_ret() function was backported to the 2.14
> branch of mbedtls since 2.14.1. For this reason, we must exclude the
> definition of our compat function for mbedtls >=2.14.1 but <2.15
> 
> Cc: Max Fillinger <maximilian.fillinger@...2507...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Successfully compiled tested on mbedTLS:
> * 2.10.0
> * 2.14.1
> * 2.20.0
> * 2.26.0

compilation fails against 2.7.18 as this function was also backported in
2.7.8.

Since we still want to support the 2.7 branch, as some distros are
shipping this, we need to further extend the ifdef.

v2 is coming.

Cheers,


-- 
Antonio Quartulli

