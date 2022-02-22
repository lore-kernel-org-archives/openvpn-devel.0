Message-ID: <0c4d7374-b133-caed-e4a9-ade8325cccf5@...1227...>
Date: Tue, 22 Feb 2022 13:06:26 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220221173818.10693-1-gert@...1296...>
 <20220222113832.13383-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220222113832.13383-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix --mtu-disc maybe|yes on Linux.
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

Am 22.02.22 um 12:38 schrieb Gert Doering:
> --mtu-disc (on Linux) needs two components to work:
>     - setsockopt() with IP_MTU_DISCOVER or IPV6_MTU_DISCOVER
>     - "extended error reporting" (setsockopt(IP_RECVERR) and
>       then via mtu.c/format_extended_socket_error()) to react on
>       "packet too big" errors on sendto() / sendmsg()
> 
> Some configure.ac reorganization broke detection of <linux/errqueue.h>
> and "struct sock_extended_err".  Re-add <linux/errqueue.h> to configure.ac,
> remove all the other conditionals in syshead.h, and remove the
> "struct sock_extended_err" check completely (assumption: if errqueue.h
> exists, it contains what we need).
> 
> Thus, the "non-helpful" socket error message turns into:
> 
> 2022-02-22 12:31:42 write UDPv4 [EMSGSIZE Path-MTU=800]: Message too long (fd=3,code=90)
> 2022-02-22 12:31:42 Note adjusting 'mssfix 1400 mtu' to 'mssfix 800 mtu' according to path MTU discovery
> 2022-02-22 12:31:42 Note adjusting 'fragment 1400 mtu' to 'fragment 800 mtu' according to path MTU discovery
> 
> ... while at it, fix extra space in first part of these messages, and
> print o->ce.fragment for the "fragment" message...
> 
> v2: assume that "if it's linux, and has these two headers, everything
> else will be there as well" and get rid of most of the #ifdef checks
> 

Acked-By: Arne Schwabe <arne@...1227...>


