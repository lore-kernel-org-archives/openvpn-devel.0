MIME-Version: 1.0
Date: Mon, 22 Jun 2009 13:45:26 +0200
Message-ID: <ea8e5e7f0906220445w56921256pa5f27aa1068691fc@...278...>
From: =?UTF-8?Q?Artur_Fija=C5=82kowski?= <wiki.warx@...277...>
Subject: [Openvpn-devel] question about route directive
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi everyone!

I have question about route directive.

When I have something like below in my openvpn.conf:

...
#persist-tun
route 10.10.0.0 255.255.0.0 10.137.137.2 1
keepalive 1 30

when tunnel crashes openvpn demon tries to destroy this route before
destroying tun device[1] (which is unnecessary, because kernel
destroys automatically all routes using device when it's destroyed).

But when I uncomment persist-tun, openvpn doesn't try to remove
routes[2], tun device is not destroyed so I get hang tunnel with dead
routes thru it.

Is this bug or feature?

I use gentoo on linux 2.6.28-gentoo-r3.

Thanks in advance for help.

AJF/WarX

[1]
Jun 22 13:37:45 aux openvpn[27051]: Inactivity timeout
(--ping-restart), restarting
Jun 22 13:37:45 aux openvpn[27051]: TCP/UDP: Closing socket
Jun 22 13:37:45 aux openvpn[27051]: /sbin/ip route del 10.10.0.0/16 metric 1
Jun 22 13:37:45 aux openvpn[27051]: ERROR: Linux route delete command
failed: external program exited with error status: 2
Jun 22 13:37:45 aux openvpn[27051]: Closing TUN/TAP interface
Jun 22 13:37:45 aux openvpn[27051]: /sbin/ip addr del dev tun0 local
10.137.137.1 peer 10.137.137.2
Jun 22 13:37:45 aux openvpn[27051]: Linux ip addr del failed: external
program exited with error status: 2
Jun 22 13:37:45 aux openvpn[27051]: SIGUSR1[soft,ping-restart]
received, process restarting

[2]
Jun 22 13:42:36 aux openvpn[27147]: Inactivity timeout
(--ping-restart), restarting
Jun 22 13:42:36 aux openvpn[27147]: TCP/UDP: Closing socket
Jun 22 13:42:36 aux openvpn[27147]: SIGUSR1[soft,ping-restart]
received, process restarting
Jun 22 13:42:36 aux openvpn[27147]: Restart pause, 2 second(s)

