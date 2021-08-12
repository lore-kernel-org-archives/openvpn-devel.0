References: <20210812075757.31759-1-a@...2181...>
 <20210812085300.4738-1-a@...2181...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <b0039260-1230-d280-e8f4-48b109be0a4a@...2507...>
Date: Thu, 12 Aug 2021 12:22:45 +0200
MIME-Version: 1.0
In-Reply-To: <20210812085300.4738-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] mbedtls: do not define
 mbedtls_ctr_drbg_update_ret when not needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

On 12/08/2021 10:53, Antonio Quartulli wrote:
> The mbedtls_ctr_drbg_update_ret() function was backported to various
> older branches, including 2.14 and 2.7.
> To aqvoid making the if guard too complex, let's detect if this function
> exist at configure time.
> All versions not having this function, will use our compat code.
> 
> Cc: Max Fillinger <maximilian.fillinger@...2507...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

Thanks again for cleaning up my mess!

Compile-tested with mbedtls versions
2.27.0
2.26.0
2.25.0
2.16.11
2.15.1
2.14.1
2.14.0
2.12.0
2.7.19
2.7.0

All good!

(Typo: "aqvoid" in the commit message, but that can be fixed when 
committing it, right?)

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

