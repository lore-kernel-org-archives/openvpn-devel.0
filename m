Message-ID: <80cdf6b1-f3c7-4a02-b7d5-05989749145e@...1227...>
Date: Sun, 19 Jun 2022 11:38:17 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220607093619.23066-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220607093619.23066-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix error message about extended errors
 for IPv4-only sockets.
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


>   #if EXTENDED_SOCKET_ERROR_CAPABILITY
>       /* if the OS supports it, enable extended error passing on the socket */
> -    set_sock_extended_error_passing(sock->sd);
> +    set_sock_extended_error_passing(sock->sd, sock->info.af);
>   #endif
>   }
>   

I have to NACK this patch. sock->info.af is not the actual address 
familiy but the family we want to use and it might be 0 if there is no 
udp4/udp6 in the config file.

For a client you can look at sock->info.lsa->actual.dest if that is 
defined. For a server we seem to actually override/set that info.af 
value according to my debugger but with a client I get 0 in that value. 
It looks that set_mtu_discover_type in the same function has the same 
problem, so it is easy to this mistake.

Arne

