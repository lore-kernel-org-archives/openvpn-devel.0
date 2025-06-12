Message-ID: <6fa91ee6-a865-49c1-9b49-872903515d84@...2181...>
Date: Thu, 12 Jun 2025 16:02:16 +0200
MIME-Version: 1.0
References: <20250604131158.1417342-1-ralf@...2726...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20250604131158.1417342-1-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: propagate socket
 mark to skb in UDP
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
To: Ralf Lici <ralf@...2726...>, openvpn-devel@lists.sourceforge.net

On 04/06/2025 15:11, Ralf Lici wrote:
> openvpn implements the `--mark` option, which utilizes the `SO_MARK`
> Linux socket option. However, in the UDP code path, the socket's
> `sk_mark` value is not currently propagated to `skb` objects that pass
> through our socket.
> 
> This commit ensures proper inheritance of the field by assigning
> `sk_mark` to `skb->mark` before handing the `skb` to the network stack
> for transmission.
> 
> Signed-off-by: Ralf Lici <ralf@...2726...>

Well done!
This patch has been merged to the development branch.

Thanks

-- 
Antonio Quartulli


