Subject: Re: [Openvpn-devel] 2.0: public linux <- nat -> private win2k
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1084300129.5764@...41...>
In-Reply-To: <40A102C0.6020101@...61...>
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
Date: Tue May 11 11:29:03 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Julien TOUCHE <julien.touche@...61...>, openvpn-devel@lists.sourceforge.net

Julien TOUCHE <julien.touche@...61...> said:

> 
> i've test 2.0 beta 1 (both box) in the following setup
> 
> linux (2.4)/debian, public IP
>       |
> Router/nat
>       |
> win2k, private IP
> 
> it works well (connexion initiated like 1.6) but in a reliable way
> (ftp/http transfert ok, which was not the case with 1.x) but i have
> strange things in my log
> 
> Tue May 11 15:56:58 2004 Listening for incoming TCP connection on
> [undef]:16891
> Tue May 11 15:57:02 2004 TCP connection established with XXX:2841
> Tue May 11 15:57:02 2004 Socket Buffers: R=[87380->131070] S=[16384->131070]
> Tue May 11 15:57:02 2004 TCPv4_SERVER link local (bound): [undef]:16891
> Tue May 11 15:57:02 2004 TCPv4_SERVER link remote: XXX:2841
> WRTue May 11 15:57:02 2004 Peer Connection Initiated with XXX:2841
>
WRRRWRWrWRwrWRwrWRwRwrWRwrWRwrWRwrWRwRwrWrWRwrWrWRwrWRwrWrWrWRwRwrWrWrWRwRwrWrWrWrWrWrWRwRwrWrWRwRwRwRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWrWRwRwRwRwRwrWrWrWrWrWRwRwRwrWRwrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWRwRwRwRwRwrWrWrWrWrWRwRwRwRwRwrWrWrWrWrWrWRwRwRwRwrWrWrWrWRwRwrWrWRwRwRRwrWRwrWRWRWRRWRWRRWRWRRWRWRRWRWRRWRWRWRRWRRWRWRRWRWRWRRWRWRRWRRWRWRWRRWRWRRWRWRRWRWRRWRWRWRRWRWRRWRRwrWRwRwrWrWRwrWrWRwrWRwrWrWrWRwRwrWrWrWRwRwRwrWrWrWrWrWrWRwrWrWRwRwRwRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWrWrWrWRwRwRwRwRwrWrWrWrWrWrWrWrWRwRwRwRwRwrWrWrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWrWrWrWRwRwRwRwRwrWrWrWrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWRwRwRwrWr
>
WrWRwrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWRwRwRwrWrWrWRwRwrWrWRwRwrWrWrWRwRwrWrWRwRwRwRwRwrWrWrWRwRwRwrWrWrWrWRwRwRwrWrWRwRwRwrWRwrWRWRRWRWRWRRWRWRRWRWRRWRWRRWRWRRWRWRWRRWRWRRWRWRRWRWRRWRWRRWRWRRWRWRWRRWRWRRWRWRRWRWRRWRWRRWRWRwrWRwRwrWrWrWRwrWrWRwrWRwrWrWrWRwRwrWrWrWRwRwrWrWrWrWrWrWRwRwrWrWRwRwRwRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWrWrWrWRwRwrWrWrWrWrWRwRwRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWrWrWrWRwRwRwrWrWRwRwrWrWrWRwRwrWrWRwRwrWrWRwRwrWRwRwrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWRwRwRwrWrWRwRwrWrWrWRwRwrWrWRwRwrWrWrWRwRwrWrWRwRwrWrWRwRwrWRwRwrWRwrWrWrWRwRwRwrWrWRwRwRwrWRwrWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWRwrWRwRwrWrWRwrWrWRwrWRwrWrWrWRwRwrWrWrWRwRwrWrWrWrWrWrWRwRwrWrWRwRwRwRwRwrWrWRwRwrWrWRwRwrWr
>
WRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWrWrWrWRwRwRwrWrWrWrWrWRwRwrWrWRwRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWrWRwRwRwRwRwrWrWrWrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWRwRwrWrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWRwRwRwrWrWrWRwRwrWrWRwRwrWrWrWRwRwrWrWRwRwrWrWRwRwrWRwRwrWrWrWRwrWRwRwRwrWrWRwRwRwrWRwrWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWRwrWRwRwrWrWRwrWrWRwrWRwrWrWrWRwRwrWrWrWRwrWrWRwrWrWRwRwRwrWrWRwrWrWRwRwRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWrWrWrWRwRwrWrWrWrWrWRwRwRwrWrWRwRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWrWrWrWRwRwrWrWRwRwRwrWrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwrWrWrWRwRwrWrWRwRwRwRwRwrWrWrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWRwRwRwrWrWrWRwRwrWrWRwRwrWr
>
WrWRwRwrWrWRwRwrWrWRwRwrWRwRwRwrWrWrWrWRwRwRwrWrWRwRwRwrWRwrWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWRwrWRwRwrWrWRwrWrWRwrWrWRwrWrWrWRwrWrWRwrWrWRwRwRwRwRwrWrWrWRwrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWrWRwRwRwrWrWrWrWrWRwRwrWrWRwRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWrWrWrWRwRwRwrWrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWRwRwRwrWrWRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwrWRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWRwRwRwrWRwRwRwrWrWrWrWrWRwRwrWrWRwRwrWrWrWRwRwRwrWrWRwRwRwrWrWrWRwRwRwrWrWrWrWRwRwRwRwrWrWRwrWrWRwRwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWRwrWRwRwrWrWRwrWrWRwrWRwrWrWrWRwRwRwrWrWrWrWrWRwRwrWrWrWrWRwRwRwrWrWRwRwRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWrWrWrWrWRwRwRwrWrWRwRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWrWrWrWRwRwRwrWrWRwRwrWrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwRwrWrWRw
>
RwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWRwRwrWrWRwRwrWrWRwRwrWrWRwrWrWRwrWRwRwRwRwRwrWrWrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwRwRwrWrWrWrWRwRwrWrWrWrWRwRwRwRwrWrWrWrWrWrWrWRwRwRwRwRwrWrWrWrWrWRwRwRwRwrWrWrWrWrWRwRwRwrWrWRwrWrWRwRwRwRwrWrWRwrWrWrWRwRwRwrWrWRwRwRwrWRwrWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWTue
> May 11 17:07:12 2004 Connection reset, restarting [-1]
> Tue May 11 17:07:13 2004 TCP/UDP: Closing socket
> Tue May 11 17:07:13 2004 Closing TUN/TAP interface
> Tue May 11 17:07:13 2004 SIGUSR1[soft,connection-reset] received,
> process restarting
> Tue May 11 17:07:13 2004 Current Parameter Settings:
> Tue May 11 17:07:13 2004   config = 'vpn-maz2.conf'
> Tue May 11 17:07:13 2004   mode = 0
> Tue May 11 17:07:13 2004 131 variation(s) on previous 3 message(s)
> suppressed by --mute
> Tue May 11 17:07:13 2004 OpenVPN 2.0_beta1 i586-pc-linux-gnu [SSL] [LZO]
> built on May 10 2004
> Tue May 11 17:07:13 2004 Restart pause, 1 second(s)
> Tue May 11 17:07:14 2004 Static Encrypt: Cipher 'BF-CBC' initialized
> with 128 bit key
> Tue May 11 17:07:14 2004 Static Encrypt: Using 160 bit message hash
> 'SHA1' for HMAC authentication
> Tue May 11 17:07:14 2004 Static Decrypt: Cipher 'BF-CBC' initialized
> with 128 bit key
> Tue May 11 17:07:14 2004 1 variation(s) on previous 3 message(s)
> suppressed by --mute
> Tue May 11 17:07:14 2004 LZO compression initialized
> Tue May 11 17:07:14 2004 TUN/TAP device tun11 opened
> Tue May 11 17:07:14 2004 Note: Cannot set tx queue length on tun11:
> Operation not permitted (errno=1)
> Tue May 11 17:07:14 2004 /sbin/ifconfig tun11 10.0.2.17 pointopoint
> 10.0.2.18 mtu 1500
> Tue May 11 17:07:15 2004 Data Channel MTU parms [ L:1547 D:1450 EF:47
> EB:19 ET:0 EL:0 ]
> Tue May 11 17:07:15 2004 Local Options String: 'V3,dev-type tun,link-mtu
> 1547,tun-mtu 1500,proto TCPv4_SERVER,ifconfig 10.0.2.18
> 10.0.2.17,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,secret'
> Tue May 11 17:07:15 2004 Expected Remote Options String: 'V3,dev-type
> tun,link-mtu 1547,tun-mtu 1500,proto TCPv4_CLIENT,ifconfig 10.0.2.17
> 10.0.2.18,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,secret'
> Tue May 11 17:07:15 2004 Local Options hash (VER=V3): '9ea00d5d'
> Tue May 11 17:07:15 2004 Expected Remote Options hash (VER=V3): '331351ef'
> Tue May 11 17:07:15 2004 Listening for incoming TCP connection on
> [undef]:16891
> 
> the "WRRRWRWrWRwrWRwr" seems to be related to transfert and traffic
> size. is there is any debug code on this ? or a bug ?

That's just the --verb 5 debugging mode that shows packet flows through
OpenVPN.  Try using --verb 4 or lower to suppress that output.

> the pull options seems also to not work or is it only for "mode server"
> as i'm using "proto tcp-server" (in this setup, udp returns udp port X
> unreachable) and shared secret for now ?

Right now --push/--pull is primarily oriented towards --mode server usage,
though it should also work in OpenVPN's traditional peer-to-peer mode if TLS
is used.

James


