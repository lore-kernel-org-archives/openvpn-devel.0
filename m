Subject: Re: [Openvpn-devel] OpenVPN 1.6-beta6 on Windows XP - observations
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1077318468.22465@...41...>
In-Reply-To: <20040220222904.GB20552@...33...>
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
Date: Fri Feb 20 15:16:44 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> Hi,
> 
> I have some observations after a somewhat longish fight with getting
> OpenVPN to work on Winbloze XP, including troubles with
> --redirect-gateway.
> 
> Here's the plot:
> 
> Client: Winbloze XP Centrino WLAN (Sony Vaio) with OpenVPN 1.6-beta6
>         client IP assigned with DHCP, tunnel IP static
> 
> Server: SuSE Linux 8.2 w/ 3Com NIC and OpenVPN 1.5.0, OpenVPN and tunnel
>         IP addresses both static and in distinct networks, also runs
>         ISC DHCP server v3.
> 
> Tunnel: TUN-style (routed), 192.168.2.1 (server) and 192.168.2.2
>         (client) in 255.255.255.252  (30 bit prefix) subnet
> 
> OpenVPN IPs: client 192.168.1.X (X in [100 ; 250])
>              server 192.168.1.1
> 
> Observations:
> 
> 1. documentation - the separation between TUN (route) and TAP (bridge)
> should be sharpened. There should be two entirely distinct sections in
> the documentation, no intermix. I suggest naming the options, their
> advantages, and then configuration details first for tap, then for tun,
> but nothing mixed. I've seen an otherwise clueful communications
> engineer desperate about that documentation and end up with a mixed
> configuration (configured tun, but also bridged the two interfaces in
> XP).

There's a lengthy description of bridging vs. routing in both the win32 notes
and the FAQ -- perhaps it should be amplified.  Feel free to submit something.  

> 2. "ip-win32 ipapi" (which is the default) doesn't work reliably for me
> (it worked after the first install but stopped working after a reboot -
> but I also ran Windows Update in between)
> 
> I've seen logs about OpenVPN being unable to find the TAP interface.
> netsh is fine. Maybe netsh could be the default for WinXP and ipapi the
> default for Win2K?

Did you try "ip-win32 dynamic"?  If so, also make sure to use a --route-delay
of a few seconds.  I'm considering making this the default, but I'd like more
feedback first.

I'm not very happy about the idea of changing defaults based on the OS version
being used.

> 3. Either Windows or I is too blunt to get the default route right with
> "redirect gateway". With that option, TUN and WLAN stop working.
> As a workaround, I am using
> 
> route 0.0.0.0 0.0.0.0 vpn_gateway
> route-delay 15
> 
> This leaves the former default route in place with a metric of 30,
> whereas the tunnel has a metric of 1 and is thus preferred.
> 
> I have no clues as to what causes this and what should be the right
> setup, the routing table "route print" is suspiciously long, around a
> dozen entries that I cannot reflect here.
> 
> 
> Unfortunately, I don't have access to the computer right now but I hope
> to be able to look up any detailed queries next week when I'm on site
> again.
> 
> If anyone can shed light on #3 or ask some decent questions, that'll be
> appreciated. While I'm firm with BSD sockets, I know little of Windows
> IP and interface configuration and its quirks.

--redirect-gateway is experimental and unfortunately doesn't always produce
the correct result. This has been discussed before on openvpn-users.  It is
simply a helper function that generates 3 routes and undoes them on tunnel
shutdown.

James


