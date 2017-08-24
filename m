References: <20170824133305.25604-1-a@...2181...>
 <CAFHpkQEJefeuqwbfy638M0AYO4EvcN8tamQQAHfxH-uPDwm=+g@...278...>
 <CAFHpkQHi0==66QDo8zVkktdCS4evKhQBkpkTZLbnt0WPMpXzsQ@...278...>
 <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>
 <d31c59c4-a512-f335-41fc-e6389915a270@...2181...>
 <4555eb8e-62db-e24c-c297-d27a63c40942@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <275f5d58-bf11-783c-0a2a-efb78d404c9d@...2181...>
Date: Fri, 25 Aug 2017 02:52:27 +0800
MIME-Version: 1.0
In-Reply-To: <4555eb8e-62db-e24c-c297-d27a63c40942@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ag5Mu5Cq7DR4RifbHhabhQUgbCgRq9NUE"
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ag5Mu5Cq7DR4RifbHhabhQUgbCgRq9NUE
Content-Type: multipart/mixed; boundary="XC40Gq7E2q2AFFn3sGeI9444dhvCs4n4L";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net,
 David Sommerseth <openvpn@...2080...>,
 =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Message-ID: <275f5d58-bf11-783c-0a2a-efb78d404c9d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
References: <20170824133305.25604-1-a@...2181...>
 <CAFHpkQEJefeuqwbfy638M0AYO4EvcN8tamQQAHfxH-uPDwm=+g@...278...>
 <CAFHpkQHi0==66QDo8zVkktdCS4evKhQBkpkTZLbnt0WPMpXzsQ@...278...>
 <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>
 <d31c59c4-a512-f335-41fc-e6389915a270@...2181...>
 <4555eb8e-62db-e24c-c297-d27a63c40942@...2080...>
In-Reply-To: <4555eb8e-62db-e24c-c297-d27a63c40942@...2080...>

--XC40Gq7E2q2AFFn3sGeI9444dhvCs4n4L
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 25/08/17 02:06, David Sommerseth wrote:
> On 24/08/17 16:42, Antonio Quartulli wrote:
>> dev-tools/gen-release-tarballs.sh is only for devs, while
>> tests/t_cltsrv.sh is for running some tests, but I am not sure sure how
>> the latter would interact with non-linux systems.
>>
>> Maybe Gert knows(?)
>=20
> Tried running them through ksh or dash?  Those are the most feature
> restrictive shells I can think of right now.  Dash is supposed to be the
> most POSIX compliant shell, iirc.

A quick test with dash on ubuntu shown that the line:

    echo "   remote-name  -- valid remotes: $(git remote | tr \\\n ' ')"

is interpreted correctly.

Cheers,


--=20
Antonio Quartulli


--XC40Gq7E2q2AFFn3sGeI9444dhvCs4n4L--

--ag5Mu5Cq7DR4RifbHhabhQUgbCgRq9NUE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmfIGsACgkQ0+HICM1s
oFAOBRAAgwjBWI//UFojawuAPTfGLxTmkaTsulgyFZrkzR7XbxNRv43vcdqUmy4H
f8CCDIOcZCOUUTeO9nSZGIv8PFWMdF4kUzsqVQ15PK4dN7hRkn4g2XGrgn3QNdMj
IWrcIPgNvJtPMQJpRHoTsNZptmTlYnt8K8kH1rxPq5NepeYRIxEl3B4jCKAyBBAc
ChKf7N+zvO0PDypnMD+p0o18w1C3vDLdm5uKE8MMs8PeBoIYqlplp+XiXp8Y4hRK
HKf/0ssAJTICFlTZaz6nD1ZRzI1oY+VDhB2kUGGjSRLZ6x6mEOCV/Qk6/sPfDo1b
M6xQxNAavIAtGMpRs1nAIOi1q3QTa2Meys/nRHtQx6SnYBH6J8zPz4cPAxqzXl1m
Dt4FICjnIJt6ZgTcEj8HQ7wPfWTySexIklGU/h38KUlZyNBf35FuUOOrvk1esepJ
i/GXIk9tTt2xE94428KFeiUXOebUwiWllW9XB7ldw69y7aezOjOhCLv5hsWfwUSf
34Dm8sLMqtVbTks1YPmPZKG0C72BuYI3TQjnPv6bcqfCFGYgLyqE5DWQQKoWViap
6wLy6Cdqc3dClNyWlbmCDJ08qSmjbpIi4vw72Lrot9Fni+WOrpGuU+5JlJgu2O4C
97AI3IOqeV7srZxNf+UALsAx/fcRRnsAjSKhYTzjelrRBXf9XZo=
=a1E3
-----END PGP SIGNATURE-----

--ag5Mu5Cq7DR4RifbHhabhQUgbCgRq9NUE--

