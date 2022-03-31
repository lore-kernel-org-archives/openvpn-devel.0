Date: Thu, 31 Mar 2022 15:26:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkWr8RGuB9NfLicu@...1296...>
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <78f5a523-8d24-2d36-5414-11bc746f9b70@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oleNo3sauThCYRKs"
Content-Disposition: inline
In-Reply-To: <78f5a523-8d24-2d36-5414-11bc746f9b70@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

--oleNo3sauThCYRKs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 31, 2022 at 03:20:59PM +0200, David Sommerseth wrote:
> I've also run a few tests using an --up script which modified=20
> /etc/resolv.conf, which also worked as expected with capabilities enabled.

This is actually an interesting corner case.  As far as I understand,
--up runs before setuid, so that should always succeed - but if you do
that, cleaning up resolv.conf in --down won't succeed.

(But this is a totally independent problem of "network things without
root" that this patch addresses)

[..]
> SELinux on Fedora and RHEL (which Rocky Linux inherits) denies the=20
> OpenVPN process when run via systemd to use the SET_PCAP capability.  In=
=20
> addition, the SELinux reference policy also denies all interactions with=
=20
> the Generic Netlink interfaces used by ovpn-dco.  I will follow up this=20
> with the upstream SELinux reference policy maintainers.

This is a good find.  Thanks :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--oleNo3sauThCYRKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiRavxAAoJEB2Cnv7KVigSd78L/04WV7kc2UbbS14bsoyWeZgM
GeKDQGNgtO8Fq8AvaRJdHhmLngOfRM/i4DxBpkNJAAtlBu6O4G0becRTA/BPRxfX
uzrCLWXKn/7CBxQiWwhDPpA+G1Sjlyda4Aqwj5ejLBXYovL4rzokxmNWm47jpALk
r4tn/8Ph+GuE1tXixmjgDtknF2jRquFgek95iNmezP/FPZdm6fAmEhlQffOF7W74
L2Z7K5E7qBpxVrlPfo6ckCGtoG028wMObRclm1GuzWMfADeyDBuoKN2SFpdJvNSx
idPevPF3kNRRp126+tlfJ8Mi8C5ATNdzqubwAdo8O/q76xPVejBzwpfl68qm+UEZ
KH7KqnS2l4VVJj0mAquV830C4vM0KW7Q6zs/J9dNtq5EWIzCuftauVfRiy1twTzY
OKueY6ftwRv+DfQ/vXDdyFYmiCh/DUt+DpI04JDylM4jhBb5UUzXBJzX7AocLE1R
11LH0m2If/uFmcaQjug4OjK4amgH0rikLZ3K2LRYGQ==
=fBFV
-----END PGP SIGNATURE-----

--oleNo3sauThCYRKs--

