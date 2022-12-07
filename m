Date: Wed, 7 Dec 2022 09:07:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5BJ1FnuyvdkGaau@...1296...>
References: <20221201110128.271064-1-arne@...1227...>
 <Y5BHFHtyZCCDYPtx@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="r/Sy1hTOPceXQWRh"
Content-Disposition: inline
In-Reply-To: <Y5BHFHtyZCCDYPtx@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN crash with latest "fix p2p reconnect"
 patch
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

--r/Sy1hTOPceXQWRh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 07, 2022 at 08:56:04AM +0100, Gert Doering wrote:
> the client side tests tested p2p udp (8) before p2p udp TLS (11), so
> never noticed that after running (11), (8) would not work any longer...

More specifically, because I never tested p2p tun (8) on the DCO-enabled
servers ("why would I test this, it just slows down things, --secret won't
do DCO anyway").

But it seems, "p2p --secret" is broken hard in current code - it enables
DCO, and fails when the first client connects...

2022-12-07 09:01:32 us=3D920037 net_iface_new: add tun3 type ovpn-dco
2022-12-07 09:01:32 us=3D921045 DCO device tun3 opened
...
2022-12-07 09:02:02 us=3D527605 Attempting to send data packet while data c=
hannel offload is in use. Dropping packet
...

start client, send packet:

2022-12-07 09:02:38 us=3D285472 Peer Connection Initiated with [AF_INET6]::=
ffff:194.97.140.5:18999

Program received signal SIGSEGV, Segmentation fault.
0x000055555556beaf in addr_set_dco_installed (c=3D<optimized out>) at dco.c=
:447
447                 ks->remote_addr.dco_installed =3D true;

(gdb) print ks
$1 =3D (struct key_state *) 0x5f8

... so whatever "ks" is in here, it's not a valid pointer...


Starting the p2p --secret instance with --disable-dco makes it behave
normally.

Since, I think, the claim is "DCO needs TLS", we just need a patch that
disables DCO for p2p --secret mode...

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--r/Sy1hTOPceXQWRh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjkEnUAAoJEB2Cnv7KVigSQa8MAJOrjY+4fh5UCVYreKG6H7sP
wSkOaGhjZjv4UhSKUiII9j70lo+OXNxVj9k11xfiTZxL13ioSuwJkeRrefs8aWbh
C8Q2tDH6YXEz8/QeoG7T4UWuz0nq6fI1Yf2Tsm7sqP7TEDG9owt5qTjHrQwmI40B
hpXS7uf4DnmRWHm5zjowe1S+0PyKK2j2ZHYhmkcqYJNZ15DB4/Ad7dSvg/Tt/Cx1
vBpuduq1gPvlvcBDG6fF1aQ5lhEDjHtdLFSe5HUKgggij0F7Vc2JGcrZax8lTJCm
I4L8045f9gRfoxkb0G86tbRRgbpIWaruWVT19E87WJ1Yi/oTeeyHKFaONEtu7yJa
yHRu0yXSX0+rrAC31PSSzKPpy3rXnhfH6v1GxTCe+aROsOd51ZbieXXj7SZSElxw
8oEkyIwL8F8v96tXkuUl6fTkEaljweGAXvzgTtrvL9bKnNiDMR26NwEfrMSM3GXa
VYe7kvxFT+3bsHNkQ2gaCrOneHlW+0drb5X7GHeH8g==
=2rB/
-----END PGP SIGNATURE-----

--r/Sy1hTOPceXQWRh--

