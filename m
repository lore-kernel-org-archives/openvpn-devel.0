Message-ID: <b187a379-2bc1-6a7b-9bb6-a53fb1358c4f@...2712...>
Date: Thu, 9 Feb 2023 19:40:06 +0200
MIME-Version: 1.0
References: <20230209153658.24001-1-ynezz@...2710...>
Content-Language: en-US
From: Mykhailo Mishchenko <mdmisch@...2712...>
In-Reply-To: <20230209153658.24001-1-ynezz@...2710...>
Subject: Re: [Openvpn-devel] [PATCH] get_addr_generic: fix server crash in
 freeaddrinfo on musl libc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On 09.02.23 17:36, Petr Štetiar wrote:
> Server can crash on systems using musl libc when client with comma in
> commonName tries to connect:
>
>   ifconfig_pool_read(), in='VPN Client, abc,192.168.1.2,'
>   RESOLVE: Cannot parse IP address:  abc: (Name does not resolve)

I also would like to empathize what exactly leads to the crash. It 
clearly tried to parse a part of client certificate's Common Name as an 
IP address. As I understand it, this IP address was supposed to be used 
to restore client's previous IP address. This is another bug, different 
from trying to "free" NULL pointer.

Mykhailo


