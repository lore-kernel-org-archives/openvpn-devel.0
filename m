From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] [PATCH] UDPv6 support  (UDP/IPv6)
In-Reply-To: <20040924023235.M12953@...283...>
Message-ID: <Pine.LNX.4.58.0409241345300.26514@...269...>
References: <20040924023235.M12953@...283...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Sep 24 12:51:12 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: JuanJo Ciarlante <jjo-ipsec@...283...>
Cc: openvpn-devel@lists.sourceforge.net

Juanjo,

Great work on the IPv6 support!  I see there are still a few TODO items,
and of course the OpenVPN project itself is in the transition zone between
the end of the 2.0 beta series and the start of 2.0 release candidates, so
I think it would make sense to hold off on merging your contribution until
after 2.0 final is released.

James 

On Fri, 24 Sep 2004, JuanJo Ciarlante wrote:

> Hi ppl ...
> As part of my master thesis _and_ community giveback y added UPDv6 support to
> openvpn-2.0_beta11, its working AFAITested, see attached README.IPv6 for
> details.
> 
> Output from my uoooooHAaaaAAA!! session:
> """
>   root@...284... openvpn-2.0_beta11-jjo # ./openvpn  --dev tun --proto udp6 \
> 		--remote fe80::240:5ff:feae:c851 --port 5010 --secret ../openvpn.key \
> 		--ifconfig 1.1.1.253 1.1.1.1
>   Tue Sep 21 17:30:39 2004 OpenVPN 2.0_beta11 i686-pc-linux [SSL] [LZO] [EPOLL] built on Sep 21 2004
>   Tue Sep 21 17:30:39 2004 TUN/TAP device tun0 opened
>   Tue Sep 21 17:30:39 2004 /sbin/ifconfig tun0 1.1.1.253 pointopoint 1.1.1.1
>   mtu 1500
>   Tue Sep 21 17:30:39 2004 UDPv6 link local (bound): [AF_INET6]:::5010
>   Tue Sep 21 17:30:39 2004 UDPv6 link remote: [AF_INET6]fe80::240:5ff:feae:c851:5010
>   Tue Sep 21 17:30:49 2004 Peer Connection Initiated with [AF_INET6]fe80::240:5ff:feae:c851%wlan0wds0:5000
>   Tue Sep 21 17:30:51 2004 Initialization Sequence Completed
> 
>   :
> 
>   jjo@...284... jjo $ ping -c 2 1.1.1.1
>   PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
>   64 bytes from 1.1.1.1: icmp_seq=1 ttl=64 time=16.5 ms
>   64 bytes from 1.1.1.1: icmp_seq=2 ttl=64 time=5.92 ms
> 
>   --- 1.1.1.1 ping statistics ---
>   2 packets transmitted, 2 received, 0% packet loss, time 1001ms
>   rtt min/avg/max/mdev = 5.928/11.258/16.588/5.330 ms
> """
> 
> BTW ... I've broke some basic indentation rules in order to avoid enlarging
> diff size.
> 
> Patch attached, also available (GPL) under
>    http://www.irrigacion.gov.ar/juanjo/ipsec/
> 
> Best regards...
> 
> --
> --Juanjo
> 
> PS: Sorry for not signing this message, I've broken my mutt setup recently,
>      you'll find signed MD5SUM @URL above..
>      
> #  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
> #  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
> #   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #
> 

