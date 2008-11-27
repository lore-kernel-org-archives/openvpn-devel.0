Message-ID: <492EABB8.6050908@...1114...>
Date: Thu, 27 Nov 2008 15:16:24 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <492DBF02.1070305@...213...>
In-Reply-To: <492DBF02.1070305@...213...>
Subject: Re: [Openvpn-devel] Tunnel Speed Tunning with many clients connected
Reply-To: dazo@...384...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James MacLean <macleajb@...213...>
Cc: openvpn-devel@lists.sourceforge.net



James MacLean wrote:
> Hi Folks,
> 
> I have parsed around a bit but have not come up with a solid suggestion 
> to increase performance in the following environment :
> 
> . +150 clients always on, always via COAX modem 15Mb/s down 1.5Mb/s up.
> . OpenVPN-2.0.9 and 2.1rc13 tested, setup as single server
> . Server Kernel 2.6.25.4
> . Server 64bit
> . Server CPU % rarely goes above 30
> . Server is fed over a 10G link
> 
> Currently we get what appears to be only between 5 and 6 MB/s average 
> using this setup.
> 
> If only activity is over a single tunnel we can get the expected max 
> (about 14Mb/s to the remote site) for the COAX sites. Once traffic 
> builds during the day, that number drops.
> 
> We know if we hit it locally we can get 160Mb/s. We know if we do hit it 
> locally and are getting the 160Mb/s that the COAX tunnels do suffer. 
> Starting by almost 1/2 of their normal throughput tunnel speed of almost 
> 14Mb/s.
> 
> So in my small mind, I am thinking we are seeing around 48Mb/s (6MB/s*8) 
> used, but that we should be able to get over 150Mb/s. CPU isn't hurting. 
> Almost feels like there is a governor slowing down the traffic :).
> 
> Important settings from latest config :
> 
> verb 1
> dev tap
> tun-mtu 1500
> tun-mtu-extra 32
> mssfix 1468
> proto udp
> ca SSCert.pem
> cert servercert.pem
> key serverkey.pem
> dh dh1024.pem
> tls-auth ./tlspass
> keepalive 30 63
> ping-timer-rem
> persist-tun 1
> persist-key 1
> cipher none
> tcp-queue-limit 4096
> sndbuf 131072
> rcvbuf 131072
> 
> 
> Anyone have any words of wisdom :) ?
> 

Have you tried different ciphers and/or cipher key sizes?  I know you say 
the server do not suffer with too high load, but it could be inefficiency 
in the cipher algorithm.  If that's the case it might be as well an OpenSSL 
issue too.  It's a shot in the dark, but would be good to wipe this one 
out.  The default is blowfish, so I really do not expect an improvement.

Do you know if threads are enabled in your OpenVPN setup? 
(compile/configure setting).  I believe the default is not to use threads.

Does the performance drop if you have 150+ clients connected while being 
passive (not sending any traffic over the tunnel) and only having 1 client 
sending traffic?


kind regards,

David Sommerseth

