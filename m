Message-ID: <973bf6f5-1fb7-2c05-b840-8d7d85129ce6@...1227...>
Date: Tue, 7 Feb 2023 18:00:12 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230130161730.110021-1-gert@...1296...>
 <20230201141518.119157-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230201141518.119157-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Get rid of unused 'bool
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

Am 01.02.23 um 15:15 schrieb Gert Doering:
> overlapped_io_init() has a "bool tuntap_buffer" argument which is only
> passed onwards to alloc_buf_sock_tun(), which does nothing with it.
> 
> Remove from both functions.
> 
> v2:
>    move alloc_buf_sock_tun() to win32.c
> 
> v3:
>    leave alloc_buf_sock_tun() where it is, and fix non-WIN32 call from socket.c

Acked-By: Arne Schwabe <arne@...1227...>

