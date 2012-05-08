MIME-Version: 1.0
From: Tom Kent <lists@...1718...>
Date: Mon, 7 May 2012 21:03:17 -0400
Message-ID: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
Content-Type: multipart/alternative; boundary=00151748e0eceea10104bf7bf43c
Subject: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--00151748e0eceea10104bf7bf43c
Content-Type: text/plain; charset=ISO-8859-1

I had an idea I wanted to run by people and see if its feasible....here
goes.

I've been hearing a lot about "virtualized" networking for VMs and that got
me thinking. It seems like OpenVPN would be a good tool that could join a
group of VMs into their own private LAN, basically segregating them from
the internet even though they're just machines hosted by amazon, rackspace,
or in my own server room. This could all be done now by setting all the VMs
up with the openvpn client and getting them to connect, etc. The down side
is that this is a lot of configuration, and the machines would still be
exposed to the larger network.

The idea I had, and wanted to run by, was if it would be possible to
integrate an openvpn client into the hypervisor's virtual network card.
This would make it so that from the moment the VM boots up, it is only
connected to the private LAN served by the OpenVPN server. The VM would see
just another NIC, but instead of routing the data directly to the
Hypervisor's NIC (tap) or NATing it or whatever, it would go to an OpenVPN
client library (that wouldn't need a tun/tap device on the hypervisor)
which sends the data to the server over the udp connection.

Is this something that would be technically feasible? Practically feasible?
I've only used the binaries before, is the client in a state (is there a
libopenvpn) where it could be plugged into another program like QEMU/KVM?

Thanks for any input,
Tom

--00151748e0eceea10104bf7bf43c
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I had an idea I wanted to run by people and see if its feasible....here goe=
s.<br><br>I&#39;ve been hearing a lot about &quot;virtualized&quot; network=
ing for VMs and that got me thinking.  It seems like OpenVPN would be a goo=
d tool that could join a group of VMs into their own private LAN, basically=
 segregating them from the internet even though they&#39;re just machines h=
osted by amazon, rackspace, or in my own server room. This could all be don=
e now by setting all the VMs up with the openvpn client and getting them to=
 connect, etc.  The down side is that this is a lot of configuration, and t=
he machines would still be exposed to the larger network. <br>

<br>The idea I had, and wanted to run by, was if it would be possible to in=
tegrate an openvpn client into the hypervisor&#39;s virtual network card.  =
This would make it so that from the moment the VM boots up, it is only conn=
ected to the private LAN served by the OpenVPN server.  The VM would see ju=
st another NIC, but instead of routing the data directly to the Hypervisor&=
#39;s NIC (tap) or NATing it or whatever, it would go to an OpenVPN client =
library (that wouldn&#39;t need a tun/tap device on the hypervisor) which s=
ends the data to the server over the udp connection.  <br>

<br>Is this something that would be technically feasible? Practically feasi=
ble? I&#39;ve only used the binaries before, is the client in a state (is t=
here a libopenvpn) where it could be plugged into another program like QEMU=
/KVM?=A0<div>

<br></div><div>Thanks for any input,</div><div>Tom</div><div><br></div>

--00151748e0eceea10104bf7bf43c--

