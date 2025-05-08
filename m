Message-ID: <21a29ebd-0eef-4084-9c79-a6274bd91ef2@...2181...>
Date: Thu, 8 May 2025 13:25:27 +0200
MIME-Version: 1.0
References: <20250430123250.8627-1-a@...2181...>
 <20250430123250.8627-2-a@...2181...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20250430123250.8627-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next 2/2] ovpn: drop useless
 reg_state check in keepalive worker
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

On 30/04/2025 14:32, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> The keepalive worker is cancelled before calling
> unregister_netdevice_queue(), therefore it will never
> hit a situation where the reg_state can be different
> than NETDEV_REGISTERED.
> 
> For this reason, checking reg_state is useless and the
> condition can be removed.
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>

Merged to main, commit id 9149a0a9a8f9

Thanks

-- 
Antonio Quartulli


