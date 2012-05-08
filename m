Message-ID: <4FA8F1E2.6080604@...1114...>
Date: Tue, 08 May 2012 12:13:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
In-Reply-To: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
Subject: Re: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Tom Kent <lists@...1718...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/05/12 03:03, Tom Kent wrote:
> I had an idea I wanted to run by people and see if its
> feasible....here goes.
> 
> I've been hearing a lot about "virtualized" networking for VMs and
> that got me thinking. It seems like OpenVPN would be a good tool
> that could join a group of VMs into their own private LAN,
> basically segregating them from the internet even though they're
> just machines hosted by amazon, rackspace, or in my own server
> room. This could all be done now by setting all the VMs up with the
> openvpn client and getting them to connect, etc. The down side is
> that this is a lot of configuration, and the machines would still
> be exposed to the larger network.
> 
> The idea I had, and wanted to run by, was if it would be possible
> to integrate an openvpn client into the hypervisor's virtual
> network card. This would make it so that from the moment the VM
> boots up, it is only connected to the private LAN served by the
> OpenVPN server. The VM would see just another NIC, but instead of
> routing the data directly to the Hypervisor's NIC (tap) or NATing
> it or whatever, it would go to an OpenVPN client library (that
> wouldn't need a tun/tap device on the hypervisor) which sends the
> data to the server over the udp connection.
> 
> Is this something that would be technically feasible? Practically 
> feasible? I've only used the binaries before, is the client in a
> state (is there a libopenvpn) where it could be plugged into
> another program like QEMU/KVM?
> 

See Gert's comment first, as I'm spinning a bit further on some of his
ideas.

The *nix platform has always tried to build a lot of small modules
which does a restricted set of operations and make those modules do
their job well.  And then you combine these modules to do larger and
more complex tasks.

QEMU/KVM is two such modules (user-space qemu-kvm and the kvm kernel
module).  And OpenVPN is another such module which provides SSL VPN
over a UDP or TCP socket.

So in my perspective, it doesn't make sense to integrate OpenVPN
codewise into QEMU/KVM.  But if, say the libvirt daemon which takes
care of managing the QEMU/KVM instances could be extended to kick off
a OpenVPN process with the appropriate configuration options I think
you'll see a more flexible and simpler integration all-in-all.

libvirt can manage bridges for VMs.  So you can setup many VMs, on one
or more bridges.  Then adding separate OpenVPN tap devices to each of
these bridges will then give provide direct access to that "cluster"
of VMs.

So if libvirt could tackle kicking off OpenVPN with a specific and
suitable config for each of the bridge networks it starts (where VPN
is enabled, of course) ... then you should probably be able to get
much closer.

The reason for the bridging is to avoid complications for the VM if
openvpn dies and pulls down the tap device.  And using a bridge you
can create a more elastic cluster with VMs.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+o8eIACgkQDC186MBRfrrEAgCfa46sQ2I2YhYqouRnZMmYkt2N
VvkAoJifmiPVJR3YuyqWNgWjnJndBSAg
=/T75
-----END PGP SIGNATURE-----

