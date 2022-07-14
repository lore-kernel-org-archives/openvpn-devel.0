Date: Thu, 14 Jul 2022 16:11:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YtAkBED+YTrTnvCx@...1296...>
References: <20220711135530.27418-1-a@...2181...>
 <20220712214642.13533-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+UpEQLDH/m0uNce4"
Content-Disposition: inline
In-Reply-To: <20220712214642.13533-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v9 05/25] dco: let open_tun_generic
 handle the DCO case
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

--+UpEQLDH/m0uNce4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 12, 2022 at 11:46:42PM +0200, Antonio Quartulli wrote:
> open_tun_generic already contains the logic required to find a device
> name when not specified b the user. For this reason the DCO case can
> easily leverage on function and avoid code duplication.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>

NAK... I'm not sure what is happening, but if I apply this on top
of current master, and build without(!) DCO, it will kill linux/sitnl
operation hard for the "--dev tun30" case.

Running "openvpn --client ... --dev tun30" leads to

2022-07-14 15:59:43 Incoming Data Channel: Cipher 'AES-256-GCM' initialized=
 with 256 bit key
2022-07-14 15:59:43 net_route_v4_best_gw query: dst 0.0.0.0
2022-07-14 15:59:43 net_route_v4_best_gw result: via 194.97.140.30 dev eno3=
3554952
2022-07-14 15:59:43 GDG6: remote_host_ipv6=3D2607:fc50:1001:5200::4
2022-07-14 15:59:43 net_route_v6_best_gw query: dst 2607:fc50:1001:5200::4
2022-07-14 15:59:43 net_route_v6_best_gw result: via 2001:608:0:814::ffff d=
ev eno33554952
2022-07-14 15:59:43 DCO device tun30 opened
2022-07-14 15:59:43 net_iface_mtu_set: rtnl: cannot get ifindex for tun30: =
No such device (errno=3D19)
2022-07-14 15:59:43 Linux can't set mtu (1500) on tun30
2022-07-14 15:59:43 Exiting due to fatal error


Building with --enable-dco breaks all operations on linux (because it=20
gets confused between DCO and non DCO operation modes)...

2022-07-14 16:04:05 Assertion failed at dco_linux.c:453 (tt->type =3D=3D DE=
V_TYPE_TUN)

and sometimes

2022-07-14 16:06:26 sitnl_send: rtnl: generic error (-95): Operation not su=
pported
2022-07-14 16:06:26 net_iface_new: add tun255 type ovpn-dco
2022-07-14 16:06:26 sitnl_send: rtnl: generic error (-95): Operation not su=
pported
2022-07-14 16:06:26 Cannot allocate TUN/TAP dev dynamically

(isn't "-95" an indication of "no DCO module available" and we should not
try to iterate up to tun255 in this case, but give up with a clear
error indication instead?)

thus

Test sets succeeded: none.
Test sets failed: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 2f 3 4 4a 4b 5 6 8 8a 9=
 9a 9b 9x 11 11a.

... but since this is not default, I do not consider this a "this patch
breaks things" problem.  It compiles.

There is no --disable-dco option yet, so hard to test "would it work in
that case?" - so I consider this part not really interesting yet.


But the "not built with DCO, --dev tun30" part should really not fail.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+UpEQLDH/m0uNce4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi0CQEAAoJEB2Cnv7KVigS05QL/iyh85QKo1W1L4R0YjPKRtHN
kATsH1gJpjEmh8oqejsKTlWA2517MrSuEIPl5bt0xQPFfPBOs9zOLZzxfc9NmoFv
Tuf1sjLDCvwOdQcuQbuggTsmTu1xB3/TidmFqmvYexH5I8E9IVjQlhCFGg7Lnu8D
G+fwPYRs1XD8sKWclfWldP1cQHpVrmnLnul2bFzgJtwaLYKezHjQRyL6ripHN9Q9
7cNjaeeaGVGJaWOw9xYAeK+ZnFMShfOObpPKjfwrWYJzcehqJaow8sit4Vlv1rKN
lpb8N7BVvA/Y7C6Y4fsn6OLxQRU2GlDx+0FLbG9cGsbIy+0VNAO0E9ZvIu0bdkCr
zJb+E8wxpgVobxKjZJs3el8oPjdz+rmDXR5XClGzCE3e/HLwL+8CTyKOHeOswJqb
/x8UqKyNMZkfwcvA3PQoMywbGYdPHeFrYQVPZUM7lyIWhkXxpIYyuYEitk2suTAP
VdFm+0I+rY+WaxFxVQpzMpQF9hs2KdlFlh6FNUVLLg==
=jaYZ
-----END PGP SIGNATURE-----

--+UpEQLDH/m0uNce4--

