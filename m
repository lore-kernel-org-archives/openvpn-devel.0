Date: Thu, 6 Oct 2022 17:39:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yz72rrCsJCjBgE4T@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
 <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7cd1RuEizxlnNrNi"
Content-Disposition: inline
In-Reply-To: <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--7cd1RuEizxlnNrNi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

FreeBSD DCO has the open issue of "iroute with the same netmask as
route, so we want metric/weight/... to differenciate"

On Mon, Aug 22, 2022 at 02:55:09PM +0200, Kristof Provost wrote:
> But:
>=20
> 	$ sudo route add 172.16.2.0/24 10.0.2.1
> 	add net 172.16.2.0: gateway 10.0.2.1
> 	$ sudo route add 172.16.2.0/24 -weight 2 10.0.2.254
> 	add net 172.16.2.0: gateway 10.0.2.254

I tried patching networking_freebsd.c the way you suggested, and it
seems to work "halfway".  That is...

2022-10-06 17:26:35 us=3D684854 freebsd-74-amd64/2001:608:0:814::f000:3 /sb=
in/route add -net 10.114.201.0/24 10.114.2.2 -fib 0 -weight 16777115
add net 10.114.201.0: gateway 10.114.2.2 fib 0: route already in table

2022-10-06 17:26:35 us=3D695547 freebsd-74-amd64/2001:608:0:814::f000:3 /sb=
in/route -6 add -net fd00:abcd:114:201::/64 fd00:abcd:114:2::1000 -fib 0 -w=
eight 16777115
add net fd00:abcd:114:201::/64: gateway fd00:abcd:114:2::1000 fib 0: route =
already in table

... it takes the command, but still refuses to create the routes.

$ netstat -rn --libxo json | jq

tells me...

              {
                "destination": "10.114.201.0/24",
                "gateway": "10.114.2.2",
                "flags": "UGS",
                "flags_pretty": [
                  "up",
                  "gateway",
                  "static"
                ],
                "weight": 1,
                "interface-name": "tun1"
              },
              {
                "destination": "fd00:abcd:114:201::/64",
                "gateway": "link#5",
                "flags": "US",
                "flags_pretty": [
                  "up",
                  "static"
                ],
                "weight": 1,
                "interface-name": "tun1"
              },


For IPv6, we definitely have "different weight, different gateway", so
I'd expect this to work.

For IPv4, this is a bit of a nuisance - the client in question happens
to be the *first* client in ipp.txt (=3D .2), and that's what OpenVPN picks
for the "route" gateway too... so, "different weight, same gateway".


Now, bumping the "first client" via ipp.txt to the .4 address gives
me a whole new sleigh of interesting problems...

2022-10-06 17:36:05 us=3D447754 freebsd-74-amd64/2001:608:0:814::f000:3 /sb=
in/route add -net 10.114.200.74/32 10.114.2.4 -fib 0 -weight 16777115
route: writing to routing socket: Network is unreachable
add net 10.114.200.74: gateway 10.114.2.4 fib 0: Network is unreachable

... which, I think, is because the interface is flagged as "pointtopoint",
and .4 is off-net...

$ ifconfig tun1
tun1: flags=3D8051<UP,POINTOPOINT,RUNNING,MULTICAST> metric 0 mtu 1500
        options=3D80000<LINKSTATE>
        inet 10.114.2.1 --> 10.114.2.2 netmask 0xffffff00
        inet6 fd00:abcd:114:2::1 prefixlen 64
        inet6 fe80::250:56ff:fe9c:41b%tun1 prefixlen 64 scopeid 0x5
        groups: openvpn


So, started out with one solution, now I have two new problems...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7cd1RuEizxlnNrNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjPvauAAoJEB2Cnv7KVigSyE8L/1fDGOS0gZpxZ08r3AFgO+DM
kpp03P74Od5Uq95W8/s+0yEBlYnZK/WaePkgI6L3xTNWk98Q5RnOGaPP77NI4GXV
Lu+yMb8nt3W8tOqcdo3gEYgBr0AJ0qcOgzpesi+33NyO2Q3YkiFEz59tDbg9TcfI
k4EwmyVBGN8g8Lz0XWlnN/DCPijGfV7s2TxLBxy5Dgw1wf1d8gH3MFBPLYOTanwx
rcjWtuWmBXfZgs2Syxj3EZA/Z2OAyDuMrH6lGjCNqd0cWf9RgHpuqY116yHFQiiS
BpV/zx/hvhsyizgzoA800SV6XrD+1CSWIj29PQEi06RxB9Cm0pam36Hj/Ki+1UIB
Jqf04ef75+zeo4MoX+ecntw26M4DIZuEXEdCo8+Z415OL0/FaoZ7NrjNTG58QDNN
djw9Mqe6W1vBN/MlFDMJt4qrcwpqGARw7IrdbVzruov9Pk8GXhLmMIdvdyf9UYHl
+8p0nZBcBZC9AhCVZf2UGoas9vVNsW6zW3uHKrZKWw==
=F4yO
-----END PGP SIGNATURE-----

--7cd1RuEizxlnNrNi--

