References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
 <20200713061023.GK1431@...1296...> <20200713063303.GM1431@...1296...>
 <20200713065828.GN1431@...1296...>
 <9b4e2c49-8ef4-efb6-0b04-c273b077dc70@...1227...>
 <6B6A4240-A4F4-4388-BD1D-ABF049535351@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0a4643f0-2594-b6c8-0a31-2d525b2290dc@...1227...>
Date: Mon, 13 Jul 2020 16:36:52 +0200
MIME-Version: 1.0
In-Reply-To: <6B6A4240-A4F4-4388-BD1D-ABF049535351@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DQzzribDA7SOv50pWfaCMu8AHKVN3mly6"
Subject: Re: [Openvpn-devel] git master crashes on connect of 2.3 client
 with --enable-small
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin Adeff <volleynbike@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DQzzribDA7SOv50pWfaCMu8AHKVN3mly6
Content-Type: multipart/mixed; boundary="RP0peZvPAG1z8pytoXUwljUkP0vDPj0H6"

--RP0peZvPAG1z8pytoXUwljUkP0vDPj0H6
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 13.07.20 um 16:23 schrieb Marvin Adeff:
> I=E2=80=99m wondering if the opposite of this scenario has been tested, w=
here the server is running 2.3.18 (on Linux) and a client running 2.5 (on W=
indows) tries to connect?
>=20
> I know, I know, we should upgrade.  Unfortunately in this case OpenVPN se=
rver is running on an appliance that cannot be upgraded past Linux 2.6, and=
 I don=E2=80=99t think 2.4.x can run on Linux 2.6.=20

It should still work. We just test these combination less often since
2.3 is very old. However, if you still BF-CBC, this will probably stop
working in OpenVPN 2.6.

Arne


--RP0peZvPAG1z8pytoXUwljUkP0vDPj0H6--

--DQzzribDA7SOv50pWfaCMu8AHKVN3mly6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8McYQACgkQFRhsZwKx
RFSPrBAAmR3QpPTgh4xKemKu9H4CGtPx+j031RkRdRH/ZtaC9kqeXsXNOgDnOzSJ
PjsGkptKcB0rwgpt12RDddkbQ9WnXHvy3FjlS4VFrXNjpcQSbfhyV0s13OtKmbCn
h86QO2Z+OAwm/RrPKJtkHuwTKJUF1yQP5fNx8ZOUwVrmZFmmC0ieo9ME0ABDGn/6
ZxKLup7eoIolXAHsIEgRHTo8TbMqkdi3P3Nal5AF9HQdshJ8tuNsyis54XLb32T8
pbULNvFgBxxlZNzy3kcv6/TbeOsYkOabMBKK/DfvVM+aronGnVyWP2r6R5FnCH3s
zTJlzksUdy0Q+AWxMg+iFfbUNzEqvqaOCmLadY4TEyQoGz+eDzXG0BdggLcH0GqC
FnCV3ZtfQ20HMfR32FTiVY9V5+7n8EQkLzmJf1YiYPRz7xIJb+DbV0otKQQY2zKb
/qKcOEqywKHw8QGvPu4TuHbMn1adwvL0rAXBxDtUrJhAGar8JwRdaAmDokG+KMad
rdQw1xhD4fUAGtj7uq72a/VVUxKjrVt994owwPs3YaIrQu2vSp1LJfVNzDTHmDJr
xfXrEJCvlQ43hRZdYYj7R5xao0FkhgKvQQvRquewJmF+l0OSfhxf4taVqUgrHFEY
6v/HXgLJ8Be3UgIqdElPAgC7Z7AoubWwHcdOYhOrrNJwnFhsgJ8=
=g+PL
-----END PGP SIGNATURE-----

--DQzzribDA7SOv50pWfaCMu8AHKVN3mly6--

