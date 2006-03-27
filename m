From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000301c651fc$bd8dc0b0$1601a8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <44287972.9070802@...41...>
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
Date: Mon Mar 27 16:16:05 2006
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: James Yonan [mailto:jim@...41...]
> Sent: Monday, March 27, 2006 4:57 PM
> To: Dave
> Subject: Re: [Openvpn-devel] OpenVPN for PocketPC

(...)

> >=20=20=20
> Are you using OpenVPN 2.0 or 2.1 (better to use 2.1 in this regard).
>=20
> Basically if you see repeating cycle of TAP getting
> BOOTREQUEST/DHCPDISCOVER messages from the DHCP client=20
> service and then=20
> replying with BOOTREPLY/DHCPOFFER, it means that the DHCP=20
> client service=20
> is not happy with the DHCPOFFER message which was returned by the TAP=20
> driver (or perhaps it didn't receive the message).
>=20
> As far as the OpenVPN configuration is concerned, see the static key
> howto http://openvpn.net/static.html which includes a very barebones=20
> configuration which should be suitable for testing purposes.
>=20
> If you want to test the automatic DHCP negotiation, try using OpenVPN
> 2.1 and use "topology subnet".
>=20
> Setting the IP/subnet (and other optional attributes) on the
> TAP adapter=20
> is problematic on Windows due to the lack of a direct API=20
> call.  So the=20
> --ip-win32 option allows multiple methods to be tried.=20=20
> --ip-win32 ipapi=20
> might work, but it's not clear to me why it used .51 in your=20
> case.  It=20
> would help to see your config files.
>=20
> Also, keep in mind that the IP helper API doesn't have the
> function we=20
> really need which is "Assign IP address, netmask, and other DHCP=20
> properties to network adapter".  Instead it has a function=20
> which "adds"=20
> an IP/netmask to an already-configured network adapter.  That=20
> means that=20
> you often end up with the primary IP address being the=20
> "autoconfiguration" address, with the one you really wanted=20
> assigned as=20
> a secondary IP/netmask.  Less than optimal, and breaks some apps.=20=20
> That's why --ip-win32 dynamic is the default (which basically=20
> tells the=20
> TAP adapter to implement its own internal DHCP server).
>=20
> James
>=20


Thanks for taking a look at the debug output.  Ultimately I certain my test
environment is configured incorrectly.  Unfortunately as I am a newbie to
OpenVPN I don't really know what I am doing.  I did originally try static
keys, however I got a complaint that you can't do that with bridging which
is why I made all the certificate stuff.  I'll revisit that.

At present I can ping the 10.8.0.51 address (the client endpoint) but not
the 10.8.0.4 (the server endpoint).  Hmm.  Am I maybe missing a gateway in
my routing list?  I'm getting this behaviour both on the client NT
installation (that I am using as a sanity check) and the PocketPC build.

My server is a linux box and I just noticed that there was no br or tap
devices listed when I did an ipconfig, so I ran bridge-start and they
appeared.  Still, I notice that that the tap device does not have an IP
address, even when openvpn is running.  Shouldn't I expect to see a 10.8.0.4
assigned to it?  I probably just don't understand.

Re:  2.1 vs 2.0, I thought 2.1 wasn't done yet?  That 2.0.5 was the last
released build?  Then again maybe I'm just using that because it was the rpm
I had available for the server side....

Configuration files.  First, here's briefly the network topology:

*  internal network 192.168.1.0 / 14
*  server:  spunky 192.168.1.10
*  router:  192.168.1.1

Tap endpoint to be 10.8.0.4 for server and clients get .50-100

During this initial testing I'm actually coming in through the internal
network (which I know will ultimately cause problems but I think I should at
least be able to ping both the 10. endpoints initially before worrying about
that).  PocketPC client will have address of 192.168.1.129, and NT client
will have 192.168.1.22.

OK, server, a Suse linux box is thus:


#server config begin=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
port 1194
proto udp
dev tap0
ca /etc/openvpn/easy-rsa/2.0/keys/ca.crt
cert /etc/openvpn/easy-rsa/2.0/keys/server.crt
key /etc/openvpn/easy-rsa/2.0/keys/server.key  # This file should be kept
secret dh /etc/openvpn/easy-rsa/2.0/keys/dh1024.pem
ifconfig-pool-persist ipp.txt
server-bridge 10.8.0.4 255.255.255.0 10.8.0.50 10.8.0.100 keepalive 10 120
comp-lzo persist-key persist-tun status openvpn-status.log log
/var/log/openvpn verb 3 #server config end=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


My Pocket PC config is thus:


#client config begin=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
client
dev tap
dev-node TAP1:
proto udp
remote 192.168.1.10 1194
local 192.168.1.129
;ifconfig 10.8.0.40 255.255.255.0
ip-win32 ipapi=20
;nobind
ca "\\ca.crt"
cert "\\ipaq4150.crt"
key "\\ipaq4150.key"
comp-lzo
verb 3
#client config end=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D


Any input is hugely appreciated.

-Dave


