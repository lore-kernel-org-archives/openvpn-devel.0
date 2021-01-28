References: <CAKuzo_jUJ58K5VirzjgvP=dJZ_qy+H0gGzNJ4hkiAyjSKQdMUQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <705d349f-2f0c-016c-914a-6d52e512fc20@...2080...>
Date: Thu, 28 Jan 2021 11:43:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jUJ58K5VirzjgvP=dJZ_qy+H0gGzNJ4hkiAyjSKQdMUQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jFpSCK4mmYFmyUXEf5j3yyl2zhRDZVrh4"
Subject: Re: [Openvpn-devel] rfc: mingw and the interactive service code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jFpSCK4mmYFmyUXEf5j3yyl2zhRDZVrh4
Content-Type: multipart/mixed; boundary="Tm8KUjJ0hNft8hrComw0ajvumUHHGXCBU";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <705d349f-2f0c-016c-914a-6d52e512fc20@...2080...>
Subject: Re: [Openvpn-devel] rfc: mingw and the interactive service code
References: <CAKuzo_jUJ58K5VirzjgvP=dJZ_qy+H0gGzNJ4hkiAyjSKQdMUQ@...278...>
In-Reply-To: <CAKuzo_jUJ58K5VirzjgvP=dJZ_qy+H0gGzNJ4hkiAyjSKQdMUQ@...278...>

--Tm8KUjJ0hNft8hrComw0ajvumUHHGXCBU
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 28/01/2021 04:04, Selva Nair wrote:
> Hi,
>=20
> Starting version 8, mingw has started automatically setting=20
> __USE_MINGW_ANSI_STDIO =3D 1 under some feature-set conditions: for=20
> example, when _GNU_SOURCE is defined or -std=3DC99, both of which are tru=
e=20
> in our case.
>=20
> See: release notes at http://mingw-w64.org/doku.php=20
> <http://mingw-w64.org/doku.php>
>=20
> This causes several stdio functions to use internal ISO-C compliant=20
> implementations (instead of those in msvcrt), and to break some of our=20
> swprintf family calls.
>=20
> I see two options:
> (i) force __USE_MINGW_ANSI_STDIO =3D 0 in configure.
> (ii) Change all stdio function calls to be compatible building with and=20
> without this macro defined. AFICT, the only change required would be to=20
> replace %s and %S by %ls and %hs in some places -- mostly in interactive=
=20
> service, one instance=C2=A0in tun.c
>=20
> Any thoughts? I'm leaning towards option (ii).

Agreed!  Option (ii) sounds most reasonable to me too.

IIRC, we've had some special wrappers with additional %-operators for=20
string processing in the past we've kicked out as well (the struct argv=20
patches comes to mind), and I believe there's been several other=20
challenges with cross-platform support where we've tried to standardize=20
to be as close to the native and most common ground available.

That mingw is moving towards similar goals replacing msvcrt with ISO-C=20
standards is just great for us in the long run.
--=20
kind regards,

David Sommerseth
OpenVPN Inc



--Tm8KUjJ0hNft8hrComw0ajvumUHHGXCBU--

--jFpSCK4mmYFmyUXEf5j3yyl2zhRDZVrh4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmASlWUACgkQhs+UTJZx
/fK12hAAh3VymegZh3WlKL+CK77AVPv8NnkYF6rcZqt49evMJu6qfgfy2JCsrNV3
vkqhofY6EpvfY0C8qxs6gX6Lb1U5K410dX7T4/ctZ4k0WMdoxEV5n9fGeAdeD/nJ
RC9Ej05PJMlra20Cs+p1FESWBY6aOCkHucXmA7UpqBwwb8C9Tpzg1fYvkrqaWXmc
SK88qg/95pjn5sQr9LIwMM/iUd/CMJMGtwaYU5nRWjAupWUXFaZR3rfiqJ7cuuGy
GPbDy78Eilr6sks1LUOjzI8mSAiZS8fxvH+f2cHErdUolYbHqZbV33juJyScoQ21
jXaDYCxIUXe8x3rqbC8OFFlkCk5rv+MKcoQQIDh6tfOxOlHx1gGFHol+VorbvwFe
8d6ohZyl4W+KooEkcEEv85Q5mKPCvkuVyQEbdGAqefc11PMCsEbuWYzrv1Nitk7Y
ls63StUp4bUzjbATJ0VBSjIu9w7StmqYf3MXeVzGo8Hup5asm6pQ7ODtDnWWNRUh
Bl7yLwGIkjuCAWH9q2HZ4xlDrdMy8ra6E96NFOFcPNG6bLMKGJoF0cCW2JpBYsIc
R+UsNjXrM8LkqTwB9SKYv9l/WQkmdsPagoxxLwjwyfL5PJWuzbNRY77IMdfP4n1i
7qeMrSxx7BymT7XvU/UutwWqfcuFKY2rwSLGAbzfriE1YL5T5OU=
=8YN2
-----END PGP SIGNATURE-----

--jFpSCK4mmYFmyUXEf5j3yyl2zhRDZVrh4--

