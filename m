Subject: Re: [Openvpn-devel] TCP server bug
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1069362326.73931@...41...>
In-Reply-To: <3FBD1AA3.6050305@...138...>
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
Date: Thu Nov 20 13:06:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Ian D. Bjorhovde" <ianbjor@...138...>, openvpn-devel@lists.sourceforge.net

"Ian D. Bjorhovde" <ianbjor@...138...> said:

> Hi,
> 
> I am using 1.5-beta14, connecting from a Windows client to a Linux
> server.
> 
> I am using the TCP server/client support, and I have come across
> what I think is a bug.
> 
> I have set the --user nobody --group nobody options for my connection.
> On the linux server, I have --proto tcp-server.
> 
> When I first start openvpn (as root), I can make one connection from
> my client successfully.  However, if I disconnect the client, and
> attempt to reconnect, I get a failure.  Here is an excerpt from my
> syslog (sorry for the wrapped messages):
> 
> 
> Nov 18 20:38:09 sidi openvpn[22546]: OpenVPN 1.5_beta14 
> i386-redhat-linux-gnu [SSL] [LZO] [PTHREAD] built on Nov 13 2003
> Nov 18 20:38:09 sidi openvpn[22546]: Static Encrypt: Cipher 'BF-CBC' 
> initialized with 128 bit key
> Nov 18 20:38:09 sidi openvpn[22546]: Static Encrypt: Using 160 bit 
> message hash 'SHA1' for HMAC authentication
> Nov 18 20:38:09 sidi openvpn[22546]: Static Decrypt: Cipher 'BF-CBC' 
> initialized with 128 bit key
> Nov 18 20:38:09 sidi openvpn[22546]: Static Decrypt: Using 160 bit 
> message hash 'SHA1' for HMAC authentication
> Nov 18 20:38:09 sidi openvpn[22546]: LZO compression initialized
> Nov 18 20:38:09 sidi openvpn[22546]: TUN/TAP device tap0 opened
> Nov 18 20:38:09 sidi openvpn[22546]: /sbin/ifconfig tap0 10.3.1.1 
> netmask 255.255.255.0 mtu 1500 broadcast 10.3.1.255
> Nov 18 20:38:09 sidi openvpn[22546]: Data Channel MTU parms [ L:1579 
> D:1579 EF:47 EB:19 ET:32 ]
> Nov 18 20:38:09 sidi openvpn[22546]: Local Options hash (VER=V3): 'ecc62251'
> Nov 18 20:38:09 sidi openvpn[22546]: Expected Remote Options hash 
> (VER=V3): '65fc6f3f'
> Nov 18 20:38:09 sidi openvpn:  succeeded
> Nov 18 20:38:09 sidi openvpn[22551]: GID set to nobody
> Nov 18 20:38:09 sidi openvpn[22551]: UID set to nobody
> Nov 18 20:38:09 sidi openvpn[22551]: PTHREAD support initialized
> Nov 18 20:38:09 sidi openvpn[22551]: Listening for incoming TCP 
> connection on 10.3.2.4:5000
> Nov 18 20:38:09 sidi openvpn[22551]: TCP connection established with 
> 1.1.1.1:3961
> Nov 18 20:38:09 sidi openvpn[22551]: TCPv4_SERVER link local (bound): 
> 10.23.8.4:5000
> Nov 18 20:38:09 sidi openvpn[22551]: TCPv4_SERVER link remote: 1.1.1.1:3961
> Nov 18 20:38:09 sidi openvpn[22551]: Peer Connection Initiated with 
> 1.1.1.1:3961
> Nov 18 20:38:09 sidi /etc/hotplug/net.agent: invoke ifup tap0
> Nov 18 20:38:52 sidi openvpn[22551]: Connection reset, restarting [-1]
> Nov 18 20:38:52 sidi openvpn[22551]: Closing TCP/UDP socket
> Nov 18 20:38:52 sidi openvpn[22551]: Closing TUN/TAP device
> Nov 18 20:38:52 sidi openvpn[22551]: Restart pause, 1 second(s)
> Nov 18 20:38:53 sidi /etc/hotplug/net.agent: NET unregister event not 
> supported
> Nov 18 20:38:53 sidi openvpn[22551]: Cannot open file key file 
> 'speedplay.key': Permission denied (errno=13)
> Nov 18 20:38:53 sidi openvpn[22551]: Exiting
> 
> 
> 
> Notice the 'Permission denied' error on the second-to-last line.  This
> is directly related to the --user and --group options.  If I remove 
> these options I can reconnect with no problem.
> 
> I do not run into this issue if I use the UDP client.
> 
> If I change the permissions of the key file (i.e. mode 666), I don't
> get an error (rather a warning about open permissions on the key file),
> but then I get the same permission denied error when trying to open the
> TUN device (/dev/net/tun, mode 0600 owner: root).
> 
> I suspect I can get around this problem with the --persist-key and 
> --persist-tun options, but I don't understand what's different between 
> the TCP and UDP clients when it comes to dropping priviliges.

If you want to drop root privileges with --user and/or --group, restarts won't
work unless you plan for them.  In this case a restart is defined as a SIGHUP,
SIGUSR1, TCP connection reset, etc.  Because UDP is connectionless, there is
no restart if a peer goes away, unless you are also using --ping/--ping-restart.

Use one of the --persist options if you are having trouble with restarts not
working because of insufficient privilege to reaccess certain resources.

Also keep in mind that this sort of posting belongs more on the openvpn-users
list.  The -devel list is really for development issues such as patches,
porting, etc.

> Thanks for a great piece of software!

You're welcome!

James


