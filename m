Subject: Re: [Openvpn-devel] Re: Radius support (Authentification,
	Authorization and Accounting)
From: Torge Szczepanek <openvpn-devel@...239...>
In-Reply-To: <Pine.LNX.4.58.0505170713570.2777@...41...>
References: <200504291033.00667.ralfluebben@...68...>
	 <Pine.LNX.4.58.0504300118280.24107@...41...>
	 <Pine.LNX.4.58.0504301334040.25603@...41...>
	 <200505031348.25263.ralfluebben@...68...>
	 <Pine.LNX.4.58.0505031000150.1970@...41...> <d6ck1r$3b9$1@...165...>
	 <1116334849.14388.43.camel@...23...>
	 <Pine.LNX.4.58.0505170713570.2777@...41...>
Message-Id: <1116337185.14388.71.camel@...23...>
Mime-Version: 1.0
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
Date: Tue May 17 06:42:51 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am Dienstag, den 17.05.2005, 07:18 -0600 schrieb James Yonan:

> It's more like the opposite:  1.x supported a specific tunx interface and
> port for each client.  2.0 was rewritten to allow all clients to share a
> single tun/tap interface and TCP/UDP port.  The 2.0 approach tends to be
> preferred because it scales better and is easier to manage.

I know this. I am using OpenVPN quite some time now. (And I am quite
happy with it! ;-))

You are right. Using just one Port (and one OpenVPN process) for all
clients has many advantages over the 1.x behaviour.

The only disadvantage is that one cannot disentangle different users by
the device (only useful for tun (aka ptp devices)). The major advantage
of this approach is that one can apply queuing disciplines for a user to
a network device rather than to use tun0 and specify the users IP
address. The queing discipline automatically gets removed, when the user
disconnects and the device goes down.
Another advantage would be that one can use the device number in Radius
Authentication for having a unique NAS-Port.

Is there an easy way to have a single OpenVPN process, running on just
one port for multiple clients and assign each client a seperate
tun-Device? Or would that patch be very long? 




