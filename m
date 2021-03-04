References: <20210226134829.3589-1-arne@...1227...>
 <20210304114052.8577-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <25b94595-5e20-a444-2221-5a4e19ec2787@...2080...>
Date: Thu, 4 Mar 2021 15:56:55 +0100
MIME-Version: 1.0
In-Reply-To: <20210304114052.8577-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DoB6zQdPVK3wxyiQvWF0y1cbhbDtHf5uH"
Subject: Re: [Openvpn-devel] [PATCH v4] Implement deferred auth for scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DoB6zQdPVK3wxyiQvWF0y1cbhbDtHf5uH
Content-Type: multipart/mixed; boundary="w1QeGVpL6mK5c1ZuaNGjdDljhJNUbWkp2";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <25b94595-5e20-a444-2221-5a4e19ec2787@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v4] Implement deferred auth for scripts
References: <20210226134829.3589-1-arne@...1227...>
 <20210304114052.8577-1-arne@...1227...>
In-Reply-To: <20210304114052.8577-1-arne@...1227...>

--w1QeGVpL6mK5c1ZuaNGjdDljhJNUbWkp2
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 04/03/2021 12:40, Arne Schwabe wrote:
> This patch also refactors the if condition that checks the result of
> the authentication since that has become quite unreadable. It renames
> s1/s2 and extracts some parts of the condition into individual variables
> to make the condition better understandle
>=20
> Patch v2: add refactoring of the if condition
> Patch v4: fix documentation not mentioning method as 2nd line
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                         | 12 +++++
>   doc/man-sections/script-options.rst | 14 ++++-
>   src/openvpn/ssl.c                   |  2 -
>   src/openvpn/ssl_verify.c            | 84 +++++++++++++++++++++--------
>   4 files changed, 87 insertions(+), 25 deletions(-)
>=20
> diff --git a/Changes.rst b/Changes.rst
> index 62008e8d..74728d2a 100644

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--w1QeGVpL6mK5c1ZuaNGjdDljhJNUbWkp2--

--DoB6zQdPVK3wxyiQvWF0y1cbhbDtHf5uH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBA9TcACgkQhs+UTJZx
/fKtbg/9HgmlhIwZZh4FPxobp01se1xVTvWEcjbVvwfSWOdWcqhALlpwFDX4YB8I
XVyflKgp49YeqkHZMsxkCRC3572RMuhfKVt2mIpnSawWq0YnXRs6p/1v8Odaa4kr
RPsRQRTnlVrDLG6ORaK4tC/H6A4y8nc7C2nwEvWRK1j3GoI4GQOW0weSx5k+YaBb
frPJtRSlAWAsMvTVujT3mzZGuqcSBWFzrqhS7io7ZsFIr4scyoBd4dhSGzQV+M1u
g6NIhYgKxRTlXfJjPYSZdhTUSY7yYwbZFO8MCfvRLrOVo2fXwyWvxdtdW27yM0fp
v6ENecF9tWge0+D5zoiWav4sBcGvKIRR+vjJj4IloncjnOQjpGHjOOCb14VBV4YH
AgRaDYGxBSkYrqlTlcdE3FgYGtT7XwhUhTu5M9NEj9wyr+6lHyfS78+G0ue9xhTt
Su/8TLTB5+DlX7l1qitZxKVjiLu6yH/sPucpufqIWnKDj3SuEHwSsiuwHiTUVmpD
ScGhgvoySD/xLj4m/exvvLBN5p5rK6WGZpouvCdXvRc8jmBTigvuWcZtZLfNPjoa
t7ns5NnYk7hZD12FQCkFyrhIeym6oAJRkYy+cNI3Dqp1nok5jnrISCnyu7BuIhws
g79qW4Ajb+JO+E2TkovWvxAZ+jOSV80Uz+TbQyMFAf+G02ToNkg=
=8XoP
-----END PGP SIGNATURE-----

--DoB6zQdPVK3wxyiQvWF0y1cbhbDtHf5uH--

