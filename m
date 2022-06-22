Message-ID: <47f1e614-6d45-0f58-6398-027a7c7d833b@...2181...>
Date: Wed, 22 Jun 2022 11:16:45 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220524091916.145-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220524091916.145-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Set o->use_peer_id flag for p2p mode
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 24/05/2022 11:19, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> There are two flags to indicate peer-id usage, one is
> in tls_multi struct and another one is in options.
> 
> For P2P mode we don't set this flag in options,
> which is used in MTU calculation. As a result,
> automatically calculated MSS value in P2P mode is wrong,
> 
> Fix by bring use_peer_id flag in options and tls_multi
> into sync for P2P.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>

Does what it says and creates no side effect.
(It's easy to check where o->use_peer_id is used)

Moreover, this patch is needed to ensure the p2p case in dco works as 
expected.

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

