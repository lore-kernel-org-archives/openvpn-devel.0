Subject: Re: [Openvpn-devel] TINC and OpenVPN tunnel performance on a Windows client
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1068150954.68148@...41...>
In-Reply-To: <1068125943.20994.135.camel@...125...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Nov  6 12:37:07 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Teemu Kiviniemi <teemuki@...124...>, tinc-devel@...127...
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Teemu Kiviniemi <teemuki@...124...> said:

> Hi,
> 
> I had some performance problems with TINC running on Windows XP. I had a
> VPN tunnel running over a wireless network to a Linux VPN server. Web
> browsing through the tunnel was a pain. Big web pages with lots of
> pictures loaded very slow compared to a plain network connection. 
> 
> When the VPN client was running on a Linux computer, and a Windows
> computer was browsing the web through the VPN tunnel, everything worked
> just fine. The performance of web browsing through the tunnel was about
> the same as with a plain unencrypted network connection.
> 
> I recently tested the setup with OpenVPN on Windows too, but the
> performance of web browsing didn't get better.

Were you using --dev tun or --dev tap?  I have found that --dev tun has a
speed advantage, especially between linux and windows.

> The speed of a single file transfer through the tunnel was quite good.
> Browsing a complex web page creates a lot of simultaneous transfers from
> the web server to the browser. I thought that the problem must have
> something to do with simultaneous transfers.
> 
> I did some tests of OpenVPN and TINC performance on a Windows client.
> Specifically, I was looking at the performance of multiple simultaneous
> transfers and PING latency/packet loss during the transfer.

Performance here will really be a function of the TCP implementation's
algorithms for rate and congestion control.

> Test method:
> - three simultaneous FTP downloads are started on the Windows computer
> (file size 7612995 bytes)
> - at the same time, the Linux computer pings the Windows computer to see
> the latency and packet loss of the tunnel during the transfer.
> - record the transfer times, packet loss and latency
> - repeat three times, calculate the average
> 
> ****
> 
> Test setup:
> 
> Network: 10Mbps switched Ethernet, only test computers connected
> 
> VPN client:
> - Windows Server 2003
> - TINC 1.0.1 (Windows installer version)
> - OpenVPN 1.5 beta12 (Windows installer version)
> - Windows command line FTP client
> 
> VPN server:
> - Debian Woody
> - 2.4.20 kernel
> - TINC 1.0pre8
> - OpenVPN 1.5 beta12
> - OpenBSD FTP server
> 
> VPN client settings:
> 
> - Generic OpenVPN settings:
> cipher bf-cbc
> dev tap
> tun-mtu 1500
> tun-mtu-extra 32
> - OpenVPN-TCP settings:
> proto tcp-client
> - OpenVPN-UDP settings:
> proto udp
> - OpenVPN-UDP-LZO settings:
> proto udp
> comp-lzo
> 
> - Generic TINC settings:
> Mode = switch
> PriorityInheritance = no
> Cipher = blowfish
> Compression = 0
> MACLength = 4
> - TINC-TCP settings:
> TCPonly = yes
> - TINC-UDP settings:
> TCPonly = no
> 
> ****
> 
> Test results:
> 
> PING: packet loss:
> - plain network:	0%
> - OpenVPN-TCP:		0%
> - OpenVPN-UDP:		27,3%
> - OpenVPN-UDP-LZO:	25%
> - TINC-TCP:		19,3%
> - TINC-UDP:		52%
>
> OpenVPN-TCP works as well as the plain network connection during the
> transfers. The other tunnels drop too much packets to be usable.
> 
> PING: latency, min/avg/max (ms):
> - plain network:	1,2/9,1/50,7
> - OpenVPN-TCP:		4,5/121,1/352,6
> - OpenVPN-UDP:		3,7/25,7/88,9
> - OpenVPN-UDP-LZO:	3,5/25,4/79,0
> - TINC-TCP:		7,3/34,4/88,9
> - TINC-UDP:		4,1/14,5/75,9
> 
> The maximum latency of TINC-TCP doesn't get as big as the latency of
> OpenVPN-TCP, but that might have something to do with the large packet
> loss TINC-TCP is having.
> 
> FTP: transfer times FTP1/FTP2/FTP3/total (s):
> - plain network:	24,0/24,6/24,9/73,5
> - OpenVPN-TCP:		52,2/52,3/52,3/156,9
> - OpenVPN-UDP:		57,5/56,8/68,9/183,1
> - OpenVPN-UDP-LZO:	62,8/64,5/70,4/197,7
> - TINC-TCP:		160,1/148,1/137,7/445,9
> - TINC-UDP:		57,6/85,9/63,9/207,3
> 
> OpenVPN-TCP is clearly the fastest tunnel. TINC-TCP is way too slow, and
> UDP tunnels are somewhat slower than OpenVPN-TCP.
> 
> FTP: difference of the simultaneous transfer times:
> (slowest transfer time/fastest transfer time*100-100)
> - plain network:	3,9%
> - OpenVPN-TCP:		0,4%
> - OpenVPN-UDP:		35,0%
> - OpenVPN-UDP-LZO:	37,9%
> - TINC-TCP:		17,4%
> - TINC-UDP:		75,9%
> 
> OpenVPN-TCP wins again. It provides the most consistent transfer times
> for the simultaneous transfers.
> 
> Subjective analysis:
> 
> I had the hash printing of the FTP clients enabled, so I could see the
> transfer progress. All the UDP tunnels and TINC-TCP provided very
> inconsistent transfer speeds. One FTP client could transfer very fast,
> while two were transferring slower, if transferring anything at all. The
> transfers over a plain network connection and OpenVPN-TCP ran without
> delays, and the speed of all the transfers looked the same.

It's interesting that you got better TCP performance.  In my experience, on
"clean" networks with negligable packet loss, TCP does slightly worse than UDP.

My guess is that you are seeing OpenVPN in TCP mode working correctly, but
there may be some kind of network or configuration problem causing the poor
UDP results.

> ****
> 
> I have had these performance problems only with a Windows client. A
> TINC-UDP VPN tunnel between two Linux computers runs perfectly.
> 
> Has anyone else had problems like this? Can anyone verify my results
> with another setup? I haven't got access to other computers at the
> moment. What could cause the problems on Windows?

The only performance problem I've noticed is with the linux tap driver (the
tun driver is fine).  On a Windows <-> Linux FTP, locally connected to a
100mbps ethernet hub, the bandwidth is much more consistent if I use tun
rather than tap.

James


