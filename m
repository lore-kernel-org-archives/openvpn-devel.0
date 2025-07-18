Message-ID: <eb1f7bea-988f-4b21-84c1-3dd2c4df81ee@...2181...>
Date: Fri, 18 Jul 2025 16:07:08 +0200
MIME-Version: 1.0
References: <aee74fd22d63489ee9c3256bb3391edc337673bd.1752501854.git.sd@...2891...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <aee74fd22d63489ee9c3256bb3391edc337673bd.1752501854.git.sd@...2891...>
Subject: Re: [Openvpn-devel] [PATCH ovpn] net: ovpn: use correct array size
 to parse nested attributes in ovpn_nl_key_swap_doit
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
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net

On 14/07/2025 16:20, Sabrina Dubroca wrote:
> In ovpn_nl_key_swap_doit, the attributes array used to parse the
> OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
> OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
> currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.
> 
> Fixes: 203e2bf55990 ("ovpn: implement key add/get/del/swap via netlink")
> Signed-off-by: Sabrina Dubroca <sd@...2891...>

Nice catch, thanks a lot!
As you suggested I fixed the reverse christmas-tree while applying this 
patch.

It's now queued for sending to net-next.

Regards,

-- 
Antonio Quartulli


