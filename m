Message-ID: <002b01c1e56e$fa58ee60$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <3CBBD7A8.2000707@...8...>
Subject: Re: [Openvpn-devel] Multi-user openvpn
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Tue Apr 16 10:48:08 2002
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
To: Jean-Eric Cuendet <jean-eric.cuendet@...8...>, openvpn-devel@lists.sourceforge.net, Sebastien.Egger@...8...

Jean-Eric,

> Hi,
> We found openvpn last week and tried it for our needs.
> We have a mix of Windows+Linux clients, some of which wants to connect
> to the main site through VPN.
> The windows users use CheckPoint securemote and we want that Linux users
> use openvpn.
> We made some tests and want to congratulate you fr your great job. It's
> working well and is simple!

Thanks!

> Now, our questions.
> We want to be able to let multiple users that have an SSH connection on
> one VPN server, opens a VPN with openvpn. It must have dynamic
> addresses, should be opened as users, not root, should not run if there
> is no more traffic.
> We want to make a server script that:
> - create a tun device as a user
> - assign the client an address
> - create a symmetric key for openvpn
>
> We are able to:
> - opening a tun device as a simple user
> - run openvpn as a user
> - Providing dynamic address is not simple, but possible with the script.
>
> What lacks is the ability to let openvpn stop automatically when there
> is no traffic after a lap of time

We're thinking of adding this feature in the future -- an inactivity
disconnect.  A related feature that's also on the To Do list is a "ping"
that sends packets at least every n seconds to keep stateful firewall rules
alive.

These features are not difficult to add, given the current structure of
openvpn -- a main event loop in openvpn.c blocks on a select call with an
optional timeout.

> Another problem is that for 1 client to open a VPN, 2 addresses are
> needed, one for client and one for the server tun device.
> Does TAP device resolve this? Is it possible to use only 1 address for 1
> client with TAP device? And is it possible to use TAP device with openvpn?

Yes, openvpn supports tap devices.  And you are correct that tap devices
only require a local endpoint.  For example:

./openvpn --dev tap --up ./mktap ...

[root@...9... openvpn]# cat mktap
#!/bin/bash
ifconfig $1 10.5.0.1 netmask 255.255.255.0 mtu $2

This will set up a tap dev with endpoint 10.5.0.1.  On the other peer just
use 10.5.0.2 or something else in the subnet.

One caveat of this approach is that it uses ARP broadcasts over the ethernet
tunnel to resolve addresses.  Not only is this more inefficient, but these
periodic broadcasts may defeat any kind of inactivity timeout you devise.

> Thanks.
> -jec
>
> PS: Would you be interested in our script in the openvpn distribution?

Certainly... We plan to set up a contributions directory.

When you are finished, just post your script as an attachment to one of our
mailing lists.  Try to document it as much as possible, including a short
abstract of what it does.

Thanks,
James



