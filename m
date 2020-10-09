References: <20201009134603.36263-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <dd8d6abb-2d5e-2ea7-e100-84fd2ee3e019@...2181...>
Date: Fri, 9 Oct 2020 16:34:14 +0200
MIME-Version: 1.0
In-Reply-To: <20201009134603.36263-1-steffan@...1856...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] networking_iproute2: fix memory leak in
 net_iface_mtu_set()
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Hi,

On 09/10/2020 15:46, Steffan Karger wrote:
> ASAN yelled at me that someone forgot to call argv_free(). Fix that.
> 
> Signed-off-by: Steffan Karger <steffan@...1856...>

I bet I know that someone!

Thanks a lot for fixing this.

Acked-by: Antonio Quartulli <a@...2181...>

(this is for 2.5)

-- 
Antonio Quartulli

