MIME-Version: 1.0
In-Reply-To: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
References: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
Date: Tue, 8 May 2012 09:54:17 +0300
Message-ID: <CAOazyz0z7vHrkL+mgciDJ6+rDd8cYg6HDMhZGbsJfrnQM+cF-A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Tom Kent <lists@...1718...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, May 8, 2012 at 4:03 AM, Tom Kent <lists@...1718...> wrote:
> I had an idea I wanted to run by people and see if its feasible....here
> goes.
>
> I've been hearing a lot about "virtualized" networking for VMs and that got
> me thinking. It seems like OpenVPN would be a good tool that could join a
> group of VMs into their own private LAN, basically segregating them from the
> internet even though they're just machines hosted by amazon, rackspace, or
> in my own server room. This could all be done now by setting all the VMs up
> with the openvpn client and getting them to connect, etc. The down side is
> that this is a lot of configuration, and the machines would still be exposed
> to the larger network.
>
> The idea I had, and wanted to run by, was if it would be possible to
> integrate an openvpn client into the hypervisor's virtual network card. This
> would make it so that from the moment the VM boots up, it is only connected
> to the private LAN served by the OpenVPN server. The VM would see just
> another NIC, but instead of routing the data directly to the Hypervisor's
> NIC (tap) or NATing it or whatever, it would go to an OpenVPN client library
> (that wouldn't need a tun/tap device on the hypervisor) which sends the data
> to the server over the udp connection.
>
> Is this something that would be technically feasible? Practically feasible?
> I've only used the binaries before, is the client in a state (is there a
> libopenvpn) where it could be plugged into another program like QEMU/KVM?
>
> Thanks for any input,
> Tom

Hello Tom,

This is interesting of course.
But... I don't think that OpenVPN is the right approach as it is not
peer-to-peer solution.
So I would not consider this a solution for the common users' requirement.

Anyway, I think it is quite simple to setup this without any
additional development.

I use Gentoo, in my networking script all I need is to declare what I want.

At this example I create vpn0, vm0, vm1 at same network (br0), similar
configuration can create vpn1, vm2, vm3 at different network.
All that is left to do is to run openvpn with vpn0 interface as a
bridge, and optionally another daemon at vpn1 etc...

---
# This is the vpn0 interface
rc_need_vpn0="firewall"
rc_provide_vpn0="!net"
tuntap_vpn0="tap"
iproute2_vpn0="group openvpn"
config_vpn0="null"
txqueuelen_vpn0="100"
metric_vpn0="1"

# this is vm0 interface
tuntap_vm0="tap"
iproute2_vm0="group kvm"
config_vm0="null"

# this is vm1 interface
tuntap_vm1="tap"
iproute2_vm1="group kvm"
config_vm1="null"

# bridge the all
rc_provide_br0="!net"
rc_need_br0="firewall net.vpn0 net.vm0 net.vm1"
bridge_br0="vpn0 vm0 vm1"
config_br0="null"
brctl_br0="setfd 0
sethello 0
stp off"
---

What do you think?

Alon.

