Message-ID: <592c0d83-31ec-57b6-f08f-c303bf95a464@...1227...>
Date: Mon, 30 Jan 2023 18:01:45 +0100
MIME-Version: 1.0
References: <20230130144112.109560-1-gert@...1296...>
 <20230130161730.110021-1-gert@...1296...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230130161730.110021-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Get rid of unused 'bool
 tuntap_buffer' arguments.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 30.01.23 um 17:17 schrieb Gert Doering:
> overlapped_io_init() has a "bool tuntap_buffer" argument which is only
> passed onwards to alloc_buf_sock_tun(), which does nothing with it.
> 
> Remove from both functions.
> 
> While at it, move alloc_buf_sock_tun() from mtu.c to win32.c and make
> static.  It's only ever called from win32.c / overlapped_io_init().
> 
> v2:
>    move alloc_buf_sock_tun() to win32.c
> 
Acked-By: Arne Schwabe <arne@...1227...>

