Message-ID: <30459709-4f14-5f76-072d-24cbc75ac0eb@...2181...>
Date: Sat, 22 Oct 2022 15:38:18 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <8f4f2e11-6418-58ac-0fd5-f9a19450102a@...2181...>
 <20221022083842.4093941-1-git@...2701...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221022083842.4093941-1-git@...2701...>
Subject: Re: [Openvpn-devel] [PATCH v2] ovpn-dco: fix kernel 6.1 compile
 issue in ovpn_peer_create
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
To: John Thomson <git@...2701...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/10/2022 10:38, John Thomson wrote:
> Linux 5.19 replaces netif_tx_napi_add, but maintains a definition to the
> new function in: 58caed3dacb4 ("netdev: reshuffle netif_napi_add() APIs
> to allow dropping weigh") [0]
> 
> Linux 6.1 removes netif_tx_napi_add in c3f760ef1287 ("net: remove
> netif_tx_napi_add()") [1]
> 
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58caed3dacb4354a25a1aa8d2febc3e9648ba1f4
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3f760ef128789252e7c4f10d3c1721422dceba9
> 
> Signed-off-by: John Thomson <git@...2701...>

Thanks a lot for this!
Your patch has been applied to the master branch with a few minor style 
fixes.

> ---
> v2: Do not throw ifdefs into the middle of the code
> 
> compile tested only: openwrt toolchain aarch64: kernel v6.1rc1, kernel 5.10

Out of curiosity: are you using the openvpn-dev feed for openwqrt? 
(https://github.com/OpenVPN/openvpn-dev-openwrt)

Cheers,

-- 
Antonio Quartulli

