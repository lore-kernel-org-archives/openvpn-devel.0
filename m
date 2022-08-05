Date: Fri, 5 Aug 2022 14:19:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yu0K75HMzOHLj2Jk@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pdW1/X6mxwRL/h1W"
Content-Disposition: inline
Subject: [Openvpn-devel] duplicate MAC addresses on TAP on FreeBSD 12+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--pdW1/X6mxwRL/h1W
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

our buildbots had quite some amount of "unexplained failures" on the
TAP adapter tests on FreeBSD 12 and FreeBSD 13 recently, which turned
out to be "duplicate MAC address" (so when I ran the tests individually,
everything worked, and when buildbot fired up all clients in parallel,
depending on timing, "tests 4 4a 4b" ran simultaneously -> duplicated MAC
-> confusion).

Between 11 and 12, FreeBSD reworked all their "virtual ethernet" drivers
(so "tap" now lives inside "dev tuntap"), and uses this nice function
now...

/*
 * Allocate an address from the FreeBSD Foundation OUI.  This uses a
 * cryptographic hash function on the containing jail's name, UUID and the
 * interface name to attempt to provide a unique but stable address.=20
 * Pseudo-interfaces which require a MAC address should use this function to
 * allocate non-locally-administered addresses.
 */
void
ether_gen_addr(struct ifnet *ifp, struct ether_addr *hwaddr)

... which generally is "The Right Thing To Do", but *if two machines'
UUID is the same*, the generated MAC address on "tap0" will be the
same, and OpenVPN falls apart.


In the OpenVPN log, all is good in this case, but in FreeBSD dmesg, you=20
see stuff like this:

tap0: Ethernet address: 58:9c:fc:00:55:75
tap0: link state changed to UP
nd6_na_input: duplicate IP6 address fd00:abcd:207:4::a:24
tap0: DAD detected duplicate IPv6 address fe80:4::5a9c:fcff:fe00:5575: NS i=
n/out/loopback=3D0/1/0, NA in=3D1
tap0: DAD complete for fe80:4::5a9c:fcff:fe00:5575 - duplicate found
tap0: manual intervention required
tap0: possible hardware address duplication detected, disable IPv6

(because, of course, fe80:: addresses are based on MAC...)


Since the start of this e-mail, I went digging deeper - the function
*does* take a host UUID into account, so it *should* create unique
MAC addresses.

>>>>> If you do not create your FreeBSD VMs by cloning them! <<<<<

On first boot, FreeBSD generates the UUID, stores them in kern.hostuuid
for kernel perusal, and in /etc/hostid for persistence on next boot
(querying "kenv -q smbios.system.uuid" for interesting things the
hardware vendor / VM provider might have provided, see /etc/rc.d/hostid*).

Since most of my FreeBSD buildbots started up as clone of something
similar, at least 3 of them had the same hostid -> same MAC addresses.


Short summary: if you hit the problem of OpenVPN running into duplicate
MAC addresses on TAP adapters on FreeBSD, use --laddr *or* check your
/etc/hostid values for duplication.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pdW1/X6mxwRL/h1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi7QrvAAoJEB2Cnv7KVigSZrYMAJFkMao1vrL9HT6uxkQuaaQp
eKKDyOL+JiXC2b5kgTn26lieaK6vjcOIgxbn2vfqH/Hy4N6EnjqZsgA/77fwYayI
YmfdxapheVuJd6MJ3swA/fQtKhCoVq4axC2tdaKZ6BLa+VhWLss1aK8mWsL5cui6
qd0sQFQQG6pGF3ofQSdXK25z9bXprGsfJKEqX3WAsQh8WC+OTUAzRKWMvedgfd84
+eLTduLpFJ9KOkCBFAo01fNd4B8Rct0tPuocSDO9yH+PcXaWaA6NhH3dUAIKa8tk
a27ZoxpWMgIIhWlSptTPk+rR5J6Y54YoeAxyOtONSr7+cCguRFnhR/g54MIvU0hG
u7IEBDbl+7a1MbtyiuZuzPbv2Z0TYKvVblB14JyhMuxmzIkBPO7sEPvVRySdebQh
n80M027lI0QU45dk4P4Y3vQpwOYIfhGLniwG88AtZsCMwOew/833ZEkVLN/r6T2s
xHkq26m070GPtIEFgeSqddDcQw4wIWOiRjcaUdoPtg==
=4D+U
-----END PGP SIGNATURE-----

--pdW1/X6mxwRL/h1W--

