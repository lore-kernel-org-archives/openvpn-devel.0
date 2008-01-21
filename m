From: Till Maas <opensource@...519...>
Date: Mon, 21 Jan 2008 19:05:44 +0100
References: <93661e2e0710270421s36c345b4o8b3b94a95b4ed0e6@...278...>
	<479474C2.5090308@...1028...>
In-Reply-To: <479474C2.5090308@...1028...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1396736.jWmKnzxcnm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200801211905.55482.opensource@...519...>
Subject: Re: [Openvpn-devel] multi-homed udp-based OpenVPN Server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart1396736.jWmKnzxcnm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiyas,

On Monday 21 January 2008 11:32:34 Peter Warasin wrote:

> Kate Kretz wrote:
> > > we tried to use OpenVPN Server on two-nic (both are internet-connecte=
d)
> > > server.
> > > udp packets always go out on default gateway, even if they came from
> > > another nic.
>
> I have the same problem.
> Was not able to go more in depth into this problem, but i will (need to)
> soon.
> In the meantime, i thought about using --float on the clients. This should
> work.

here it works with iptables connection marking and iproute2. iptables marks=
=20
incomming connections for each uplink and based on the mark it is decided=20
which device should be used to send the answer.
Here is some pseudo code:

# mark the connections for each interface (does also work with stateful=20
# filtering, but I omitted it here
iptables -t mangle -A PREROUTING -j CONNMARK --restore-mark
iptables -t mangle -A OUTPUT -j CONNMARK --restore-mark
iptables -t mangle -A PREROUTING -i eth0 -j MARK  --set-mark 1
iptables -t mangle -A PREROUTING -i eth0 -j CONNMARK --save-mark
iptables -t mangle -A PREROUTING -i eth1 -j MARK  --set-mark 2
iptables -t mangle -A PREROUTING -i eth1 -j CONNMARK --save-mark

# give names to the iproute tables 1, 2 and 3
echo -e "1 eth0.uplink\n2 eth1.uplink\n3 loopback.default"=20
>> /etc/iproute2/rt_tables

# packets with mark 1 should go out via eth0.uplink
ip rule add prio 40001 fwmark 1 lookup eth0.uplink
# mark2 -> eth1
ip rule add prio 40002 fwmark 2 lookup eth1.uplink

# In case only the routing table is queried but not package
# really send, this provides still a dummy route
ip rule add prio 60000 dev lo lookup loopback.default

# Information about the different gateways for the different uplinks
ip route add table eth0.uplink default via XXX.XXX.XXX.XXX
ip route add table eth1.uplink default via XXX.XXX.ZZZ.XXX
ip route table loopback.default to default via 127.0.0.1

OpenVPN runs on a separate dummy device and the traffic from all interfaces=
=20
where it should listen on is forwarded via a DNAT and also for every outgoi=
ng=20
device SNAT is done with iptables. Maybe this is useful for you, too.

Regards,
Till

--nextPart1396736.jWmKnzxcnm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iQIVAwUAR5Te+mo6ELMcEJUXAQJoyhAAiQ3Fg8Ne0wGnvurtDosXELnP8A8bkVr3
zKMf6a28UzrJn9Xx/H1B5xJo1EKpLAKTlzSoJDftGP5htGhQArw2LcZf+q1EhqRc
Q3czC7ptFNdIDt1o9rPjGrPyj2uErzauBafb/ifaMImRJy38cMAS4FdOmnDCIs3g
V/QIRfbiKAkgW0+YMdHoDaeWgVYPr0Ts23CoQ6lF4jKWpaprJ5GmZTP6e+xIFPSL
03bmkuTcsw6HA1AWDiY2RXxdrCbI6G4qO14Pvg/RjJquom2dRS+bXhDZzXLuMSyI
mlvmy+PkiJD/I99G6cXmL4vI7WyCxnWhL99txkODbCkngI/VhlxYAGzdh2DYWv67
hA9cOEamfTnfVtBUz865O1t7zrddxxDFMmq7tYnisxcQwdtL+X9tCA42TvEhY/ip
tPT2lAGcvTyaVTSpM0N+0jruRDTDyMA8o3L5Xn/iRA9TJx+FdRqpCf/U1mXBzKr6
90LD+EQyjxD6dfNZhvkYxk8tGLe5UXtbVEjMtKg79sfApueD8LLjBb24Yn6PjXi6
mrOgcjnuEWnh1+MLgv4kkvSUWjsQrmwgmC+tv71zI0e1wv1jpTS1FEdaSx906e++
zt/8UY7LyqjTmudkQctTjsbLdWbcp9NIUmis529mMBUhlIHhiRRTufg90M6Mh7q8
se6oBOM6OQc=
=YLqo
-----END PGP SIGNATURE-----

--nextPart1396736.jWmKnzxcnm--

