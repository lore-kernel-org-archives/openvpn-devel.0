From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <cc7faf4a-5c6e-fe03-01c3-8446faddf4a9@...2318...>
Date: Fri, 6 Aug 2021 10:38:36 +0200
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] IPv6 client IP pool configuration issues (2.4/2.5)
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

Experimenting with OpenVPN 2.5 servers I noticed that issued IPv6 
addresses to clients (pool) start at ::2 now instead of at ::1000 as was 
the case for OpenVPN 2.4.

As far as I can find, this is nowhere documented, neither that client 
IPs issued would start at ::1000 in OpenVPN 2.4, nor that it changed to 
::2 in OpenVPN 2.5.

In order to not have the issued IP addresses change when using OpenVPN 
2.5 I was looking in how to fix this and (for now) always use ::1000 no 
matter the version of OpenVPN on the server.

It doesn't seem to be as simple as adding the --ifconfig-ipv6-pool 
option to specify the pool when you are already using --server-ipv6.

This doesn't work:

--server-ipv6 fd42::/112
--ifconfig-ipv6-pool fd42::1000/112

However the OpenVPN manpage explains:

"Convenience-function to enable a number of IPv6 related options at 
once, namely --ifconfig-ipv6, --ifconfig-ipv6-pool and --push tun-ipv6."

However, it does not explain how it exactly would rewrite --server-ipv6 
fd42::/112 to those three statements.

--ifconfig-ipv6 fd42::1/112 <????>
--ifconfig-ipv6-pool fd42::1000/112
--push "tun-ipv6"

What would the second parameter to --ifconfig-ipv6 be in this case? 
Looking through the server logging I see this (when using --server-ipv6):

2021-08-06 10:21:30 us=717290   bind_ipv6_only = DISABLED
2021-08-06 10:21:30 us=717881   ifconfig_ipv6_local = 'fd42::1'
2021-08-06 10:21:30 us=717994   ifconfig_ipv6_netbits = 112
2021-08-06 10:21:30 us=718149   ifconfig_ipv6_remote = 'fd42::2'
2021-08-06 10:21:30 us=720482   server_network_ipv6 = fd42::
2021-08-06 10:21:30 us=720620   server_netbits_ipv6 = 112
2021-08-06 10:21:30 us=720841   push_entry = 'redirect-gateway def1 ipv6'
2021-08-06 10:21:30 us=721002   push_entry = 'tun-ipv6'
2021-08-06 10:21:30 us=721195   ifconfig_ipv6_pool_defined = ENABLED
2021-08-06 10:21:30 us=721265   ifconfig_ipv6_pool_base = fd42::2
2021-08-06 10:21:30 us=721337   ifconfig_ipv6_pool_netbits = 112
2021-08-06 10:21:30 us=721573   push_ifconfig_ipv6_defined = DISABLED
2021-08-06 10:21:30 us=721658   push_ifconfig_ipv6_local = ::/0
2021-08-06 10:21:30 us=721737   push_ifconfig_ipv6_remote = ::
2021-08-06 10:21:30 us=729301 do_ifconfig, ipv4=1, ipv6=1

The following line has something interesting:

2021-08-06 10:21:30 us=718149   ifconfig_ipv6_remote = 'fd42::2'

Would this mean the --server-ivp6 fd42::/112 expands to this?

OpenVPN 2.4:

--ifconfig-ipv6 fd42::1/112 fd42::2
--ifconfig-ipv6-pool fd42::1000/112
--push "tun-ipv6"

OpenVPN 2.5:

--ifconfig-ipv6 fd42::1/112 fd42::2
--ifconfig-ipv6-pool fd42::2/112
--push "tun-ipv6"

it does not seem to work (no traffic over VPN), and the output of the log:

2021-08-06 10:30:13 us=355589   bind_ipv6_only = DISABLED
2021-08-06 10:30:13 us=359889   ifconfig_ipv6_local = 'fd42::1'
2021-08-06 10:30:13 us=360355   ifconfig_ipv6_netbits = 112
2021-08-06 10:30:13 us=360500   ifconfig_ipv6_remote = 'fd42::2'
2021-08-06 10:30:13 us=367238   server_network_ipv6 = ::
2021-08-06 10:30:13 us=367761   server_netbits_ipv6 = 0
2021-08-06 10:30:13 us=368027   push_entry = 'tun-ipv6'
2021-08-06 10:30:13 us=368365   push_entry = 'redirect-gateway def1 ipv6'
2021-08-06 10:30:13 us=368876   ifconfig_ipv6_pool_defined = ENABLED
2021-08-06 10:30:13 us=369622   ifconfig_ipv6_pool_base = fd42::1000
2021-08-06 10:30:13 us=369767   ifconfig_ipv6_pool_netbits = 112
2021-08-06 10:30:13 us=370016   push_ifconfig_ipv6_defined = DISABLED
2021-08-06 10:30:13 us=370086   push_ifconfig_ipv6_local = ::/0
2021-08-06 10:30:13 us=370375   push_ifconfig_ipv6_remote = ::
2021-08-06 10:30:13 us=379916 do_ifconfig, ipv4=1, ipv6=1

Also in the config it seems to miss server_network_ipv6 and 
server_netbits_ipv6. How to specify those?

I feel I am missing something. Anyone knows what is going on here?

Thanks!

Regards,
François

