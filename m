Message-ID: <a8b58f8e-1372-ba30-f8e6-cd811c17041c@...2181...>
Date: Wed, 23 Feb 2022 09:00:20 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220223075847.11704-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220223075847.11704-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] networking: use OPENVPN_ETH_ALEN
 instead of ETH_ALEN
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 23/02/2022 08:58, Antonio Quartulli wrote:
> With the introduction of SITNL two occurrences of ETH_ALEN
> were introduced in the code. This define exists on Linux in
> the linux/if_ether.h header, however the latter is included
> in linux/if_tun.h which may or may not exist (depending on
> how old your system is).
> 
> If the system lacks if_tun.h then the compilation fails because
> ETH_ALEN cannot be found.
> 
> For this reason, swap ETH_ALEN with OPENVPN_ETH_ALEN which is
> already used in other places of the code.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>

self-NAK. This is missing some include for using OPENVPN_ETH_ALEN.

Sorry for the noise.

-- 
Antonio Quartulli

