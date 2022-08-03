Date: Wed, 3 Aug 2022 20:14:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yuq7IlEHpACoPOzZ@...1296...>
References: <20220719080715.1445-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TlyXFU4TeQEwccau"
Content-Disposition: inline
In-Reply-To: <20220719080715.1445-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 12/25] dco: check that pulled options
 are compatible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--TlyXFU4TeQEwccau
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 19, 2022 at 10:07:15AM +0200, Antonio Quartulli wrote:
> A server may push options that are not compatible with DCO.
> In this case we should log a message and bail out.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>

I tried to test this (by forcing the error with --pull-filter ignore peer-i=
d)
and do not like the result - it does the pull, it does the OPTIONS IMPORT

2022-08-03 20:06:50 Pushed option removed by filter: 'peer-id 1'
2022-08-03 20:06:50 OPTIONS IMPORT: timers and/or timeouts modified
2022-08-03 20:06:50 OPTIONS IMPORT: compression parms modified
2022-08-03 20:06:50 OPTIONS IMPORT: --ifconfig/up options modified
2022-08-03 20:06:50 OPTIONS IMPORT: route options modified
2022-08-03 20:06:50 OPTIONS IMPORT: data channel crypto options modified

... then it does all the routing and ifconfig and stuff...

2022-08-03 20:06:50 net_route_v4_best_gw query: dst 0.0.0.0
2022-08-03 20:06:50 net_route_v4_best_gw result: via 195.30.8.94 dev ens160
2022-08-03 20:06:50 ROUTE_GATEWAY 195.30.8.94/255.255.255.224 IFACE=3Dens16=
0 HWADDR=3D00:50:56:9d:04:1e
2022-08-03 20:06:50 GDG6: remote_host_ipv6=3Dn/a
2022-08-03 20:06:50 net_route_v6_best_gw query: dst ::
2022-08-03 20:06:50 net_route_v6_best_gw result: via 2001:608:1:995a::ffff =
dev ens160
2022-08-03 20:06:50 ROUTE6_GATEWAY 2001:608:1:995a::ffff IFACE=3Dens160
2022-08-03 20:06:50 net_iface_new: add tun0 type ovpn-dco
2022-08-03 20:06:50 sitnl_send: rtnl: generic error (-17): File exists
2022-08-03 20:06:50 net_iface_new: add tun1 type ovpn-dco
...
2022-08-03 20:06:50 net_iface_up: set tun7 up
2022-08-03 20:06:50 net_addr_ptp_v4_add: 10.194.2.186 peer 10.194.2.185 dev=
 tun7
2022-08-03 20:06:50 net_iface_mtu_set: mtu 1500 for tun7
2022-08-03 20:06:50 net_iface_up: set tun7 up
2022-08-03 20:06:50 net_addr_v6_add: fd00:abcd:194:2::102d/64 dev tun7
2022-08-03 20:06:50 net_route_v4_add: 10.194.0.0/16 via 10.194.2.185 dev [N=
ULL] table 0 metric 200
2022-08-03 20:06:50 net_route_v4_add: 10.194.2.1/32 via 10.194.2.185 dev [N=
ULL] table 0 metric 200
...

and *then* it hits the new check

2022-08-03 20:06:52 OPTIONS IMPORT: Server did not request DATA_V2 packet f=
ormat required for data channel offload
2022-08-03 20:06:52 OPTIONS ERROR: pushed options are incompatible with dat=
a channel offload. Use --disable-dco to connectto this server
2022-08-03 20:06:52 Failed to open tun/tap interface

... leading to a bogus error message (the tun/tap interface opened
just fine).


So I'd say the check is working fine, but it is happening at the
wrong place - if I move it to the other OPTIONS IMPORT stuff
at the end of "part1" (do_deferred_options()) I get a much nicer
report...

2022-08-03 20:13:29 Pushed option removed by filter: 'peer-id 1'
2022-08-03 20:13:29 OPTIONS IMPORT: timers and/or timeouts modified
2022-08-03 20:13:29 OPTIONS IMPORT: compression parms modified
2022-08-03 20:13:29 OPTIONS IMPORT: --ifconfig/up options modified
2022-08-03 20:13:29 OPTIONS IMPORT: route options modified
2022-08-03 20:13:29 OPTIONS IMPORT: data channel crypto options modified
2022-08-03 20:13:29 OPTIONS IMPORT: Server did not request DATA_V2 packet f=
ormat required for data channel offload
2022-08-03 20:13:29 OPTIONS ERROR: pushed options are incompatible with dat=
a channel offload. Use --disable-dco to connectto this server
2022-08-03 20:13:46 ERROR: Failed to apply push options

(it still says "failed to open tun/tap interface", but at least it
says "ERROR: failed to apply push options" before)


So - can I have a v4 please?

PS: that missing blank "to connectto this server" is part of the v3
patch and could be fixed in v4 as well :-)
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TlyXFU4TeQEwccau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi6rsiAAoJEB2Cnv7KVigSM/AMAKQFk5V/wL+Ta59B1udRZZoz
lX3dIZ5p3nSUPn1HZETn8fxCLB2nEShMmrX+vuim4iv08nwfHx/IsyT09DOHYmbS
19RUR/oJ9ZpTDDi+15dpuMVfJCzHAwmBT6nwUB9Y89hVKqh5mVgvpZFU4wYNOCOE
MO064xep9Br+MzWdRm6K8gcd3MMsObVZNgJvDIZOd0MmBJrQBsexJ66NB6FMJoDx
ZqSlmjogw4SO1X8zvgEYPq/kUv8g0av5i7q/u1qGAW+DKGboSyrAwoaHwDWF67ca
SiGnTHNnBUdU1SnCk1OkOImDo4dpfh4kPbsKN7NvUQJivfAcGFFmeTgRfj7drVyR
MoXx+H2MINoue/4qSbyiwnCuCvFtFPqhOYZLbOdOQb2u4GzhDU0DkHggotGADDyQ
+OJHJvVttcXQ1ao4VyxR34M9k3nBSHFVuxVOnkNC7MWctWN1baosNS/AE59NF8U3
SCubQvkUcB1TwJKUEKc+x1UYldQUJixzyx1KVw7kPQ==
=mHId
-----END PGP SIGNATURE-----

--TlyXFU4TeQEwccau--

