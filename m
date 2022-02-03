Date: Thu, 3 Feb 2022 14:30:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YfvY/nkJOQ5qS8hG@...1296...>
References: <20220101162532.2251835-1-arne@...1227...>
 <20220101162532.2251835-10-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ejMhUWHWZqP7awN3"
Content-Disposition: inline
In-Reply-To: <20220101162532.2251835-10-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 09/14] Add mtu paramter to --fragment
 and change fragment calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--ejMhUWHWZqP7awN3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 01, 2022 at 05:25:27PM +0100, Arne Schwabe wrote:
> Instead relying on the link_mtu_dynamic field and its calculation
> in the frame struct, add a new field max_fragment_size and add
> a calculation of it similar to mssfix.
>=20
> Also whenever mssfix value is calculated, we also want to calculate
> the values for fragment as both options need to be calculated from
> the real overhead.
>=20
> Patch v2: Fix syntax in rst man page

NAK, as this breaks about everything :-o - I tried applying this on top
of "master as of today" (3780ce0e1).  It goes in with a little bit of
help in options.h and compiles fine, but almost all t_client "--client"=20
tests break with

run IPv4 ping tests (want_ok), 64 byte packets...
run IPv4 ping tests (want_ok), 1440 byte packets...
run IPv4 ping tests (want_ok), 3000 byte packets...

FAIL: IPv4 ping test (3000 bytes) failed, but should succeed.
run IPv6 ping tests (want_ok), 64 byte packets...
run IPv6 ping tests (want_ok), 1440 byte packets...
run IPv6 ping tests (want_ok), 3000 byte packets...

FAIL: IPv6 ping test (3000 bytes) failed, but should succeed.

Test sets succeeded: 8 8a 9 9a 9b 9x.
Test sets failed: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 2f 3 4 4a 4b 5 6.

(8+9 are p2p tests, with or without --client, which makes this
a bit more puzzling)


Looking more closely, I see this in the log now:

2022-02-03 14:24:04 /sbin/ifconfig tun0 10.194.2.54 10.194.2.53 mtu 1572 ne=
tmask 255.255.255.255 up

"mtu 1572" while 3780ce0e16c configures

2022-02-03 14:28:24 /sbin/ifconfig tun0 10.194.2.54 10.194.2.53 mtu 1500 ne=
tmask 255.255.255.255 up


- so, the ping fails are explained (client OS fragments to 1572 MTU,
which the client OS on the receiving end rejects).  I couldn't easily
see why this happens, though...


Client config is:

src/openvpn/openvpn --client --ca ... --cert ... --key ... --comp-lzo --ver=
b 3 --dev tun --proto udp4 --remote conn-test-server.openvpn.org --port 511=
94

and server pushes this:

2022-02-03 14:28:24 PUSH: Received control message: 'PUSH_REPLY,route 10.19=
4.0.0 255.255.0.0,route-ipv6 fd00:abcd:194::/48,tun-ipv6,route 10.194.2.1,t=
opology net30,ping 10,ping-restart 30,compress lz4,ifconfig-ipv6 fd00:abcd:=
194:2::100c/64 fd00:abcd:194:2::1,ifconfig 10.194.2.54 10.194.2.53,peer-id =
0,cipher AES-256-GCM,key-derivation tls-ekm'

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ejMhUWHWZqP7awN3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh+9j+AAoJEB2Cnv7KVigS0XsL/A82Lm72Qv/LuMU6/88go6DF
kxh20FkrA8XzkzP/lWGi5wVyIvm0M8yuQYd4qG4bG/nz/YaTloAyZlPLba6rSGqJ
03I8/iWEChVWvwFghNSVKFBO3bttG9EyxcqWJeBjK+z2uIhpd2k7qGZyRs0e2lHT
Dd7WBlBo7Pe6Jp0bZbTkovxt7Lc7vNnTTkb8LZ6fDz71dSn16Qn4R/RdvVm2aPE5
GrMacsvk4E4T6JFTs5/BQjQGctuLGIWz17+Rm6AlvdfsOIhJBxmCyQHLberDSr+J
0IfXcPN1UDwY1NutFgUww9noQ6gxyhhv2/+UoSPjQfQCa5qFkaqaTvDC6DzJzM8A
D1hiIYtCDnpOcH/N/Zh8epBT8+4/ZjSvxlkWv5QQ18ohOBHTLUVoSV9r2ZlGr78F
tDs7dWLXNP11m3gnUHsx8Y9Dp+/XTI735YZvC3iVjGijAvg9e4HlMefufzfKOzTS
QC5cYtfCGWnRMHxcO3c6DDNetTiZA8cI4CgiXAc3jg==
=fEB9
-----END PGP SIGNATURE-----

--ejMhUWHWZqP7awN3--

