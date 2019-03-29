Date: Fri, 29 Mar 2019 20:38:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190329193805.GQ31008@...1296...>
References: <20190328122701.7396-1-cschenk@...2502...>
 <1363f761-21e4-f5e6-8c49-234e1339bc3d@...1227...>
 <CAKuzo_gmJSuz0vYx+YugB4qcz3M8MRWNEVw3FuHXsL2KKRSH2Q@...278...>
 <2c639a7a-0cf6-4648-44d2-d6b876959eb7@...2502...>
 <CAKuzo_jNH0NpFC5kJxLpt7e9q39_Qm5rYXHhFmdE9N5U5=r91Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jNH0NpFC5kJxLpt7e9q39_Qm5rYXHhFmdE9N5U5=r91Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Setting adapter mtu on windows systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Christopher Schenk <cschenk@...2502...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+nBD6E3TurpgldQp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 29, 2019 at 03:33:24PM -0400, Selva Nair wrote:
> > +    else if (family =3D=3D AF_INET6)
> > +    {
> > +        if (ack.error_number !=3D NO_ERROR)
> > +        {
> > +            msg(M_NONFATAL, "TUN: setting IPv6 mtu using service
> > failed: %s [status=3D%u if_index=3D%d]",
> > +                strerror_win32(ack.error_number, &gc),
> > ack.error_number, mtu_msg.iface.index);
> > +        }
>=20
> Though this repetition is fine with me and may be we do
> the same in other similar contexts, cant we combine these
> two cases into one by defining a string "IPv4" or "IPv6"
> based on the value of family?
>=20
> The same applies to windows_set_mtu() as well.

Yes please,  Newer code already tries to do this (like most of the
service-related stuff calling a common function for ipv4-or-ipv6 stuff).

(We don't do this for the existing ifconfig orgy because it would not
really help readibility... but hopefully that one will get cleaned
up more thoroughly eventually)

gert=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcnnQdAAoJEB2Cnv7KVigSxgYMAK4dsVU+HcHNP2BVAv7MNqta
bZm0bfIq+K8ai4SyNkCFEw4PtV8rtK0e9u0esE5FCwBCiVmV1IQvNbQWkpjbdeqJ
1U/0CFWzMZ/Zt2ILXFe6UnIX4+bU/bacrA87kkGruhWzceavclrQnTUKl/OWW6jk
fytauFb4rlnEfTpmCKcSK1NGh2vUpifys6IF1f4KwkUfyeuAa1PsDbLNGUbDx6lO
i1iWg2WN6zMDmDqnHg9hcIKmha6jDuI2+H07B4d3apqP7QANbbbjFMJ0tHncYJV5
B8NaFhcfPQpevdt+nh3+oA98DkWCWk+9eDjPh3X8Ae2sKU0LKV18Uqt5AeAC6anr
3Qciel79cjtWbeQsX6jXF0/5Uxy3yWTq+XQ1iDPM/Mq5qCcbFZ6cmKa4Bsd81ETS
PM2d4ylqBoJTdiXdg3PXZ2CKnGiXU+Qg+ycdiOXn1pXD5sSwmabGgc1Jwgf/E5yY
epv3SjS1H1cX+QkH1aK47s9zvLfvh1ikbz8sNfEttA==
=HYOG
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--

