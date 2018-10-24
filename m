From: David Sommerseth <openvpn@...2080...>
References: <20181019155638.9498-1-davids@...515...>
 <20181019155638.9498-3-davids@...515...>
Reply-To: openvpn-devel@lists.sourceforge.net
Message-ID: <3a89eb8d-78c6-14b2-2e88-4bc3114fe497@...2080...>
Date: Wed, 24 Oct 2018 12:19:55 +0200
MIME-Version: 1.0
In-Reply-To: <20181019155638.9498-3-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="g1hTlksL6ldnMTAii8O0AWWXVcYK2uyuN"
Subject: Re: [Openvpn-devel] [PATCH 2/4] argv: do fewer memory re-allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g1hTlksL6ldnMTAii8O0AWWXVcYK2uyuN
Content-Type: multipart/mixed; boundary="vZEfKsA5k4ZcW4ha1BUzHGLGiCFFSYdx8";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <3a89eb8d-78c6-14b2-2e88-4bc3114fe497@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] argv: do fewer memory re-allocations
References: <20181019155638.9498-1-davids@...515...>
 <20181019155638.9498-3-davids@...515...>
In-Reply-To: <20181019155638.9498-3-davids@...515...>

--vZEfKsA5k4ZcW4ha1BUzHGLGiCFFSYdx8
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/10/18 17:56, David Sommerseth wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> Prevent the re-allocations of memory when the internal argv grows
> beyond 2 and 4 arguments by initially allocating argv to hold up to
> 7 (+ trailing NULL) pointers.
>=20
> While at it rename argv_reset to argv_free to actually express
> what's going on. Redo the argv_reset functionality so that it can
> be used to actually reset the argv without re-allocation.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 81 ++++++++++++++--------------
>  src/openvpn/argv.h                   |  2 +-
>  src/openvpn/console_systemd.c        |  2 +-
>  src/openvpn/init.c                   | 15 ++----
>  src/openvpn/lladdr.c                 |  2 +-
>  src/openvpn/multi.c                  | 10 ++--
>  src/openvpn/options.c                |  2 +-
>  src/openvpn/plugin.c                 |  2 +-
>  src/openvpn/route.c                  |  8 +--
>  src/openvpn/socket.c                 |  4 +-
>  src/openvpn/ssl_verify.c             |  6 +--
>  src/openvpn/tun.c                    | 38 ++++++-------
>  tests/unit_tests/openvpn/test_argv.c | 41 +++++++++-----
>  13 files changed, 110 insertions(+), 103 deletions(-)

This is a pure rebase of [0, 1].  In my initial review, I questioned the ne=
ed
to keep argv_str().  I decided to keep the argv_str() as it makes the usage=
 of
struct argv based processing simpler; no need for the caller to know inner
details of struct argv.

[0] <https://patchwork.openvpn.net/patch/72/>
[1] <http://mid.mail-archive.com/20171112082736.15578-1-heiko.hund@...2464...=
..>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--vZEfKsA5k4ZcW4ha1BUzHGLGiCFFSYdx8--

--g1hTlksL6ldnMTAii8O0AWWXVcYK2uyuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJb0EdLAAoJEIbPlEyWcf3yd8oP/2MW6CHPo62Mllwr34+rIbTU
g5NCoeneXyRlp5sF6rmiPHbzAPaciS4urXODd7FKymxHO4jJ5djaeJBxmAao1FWK
L565bUysgCQWSU0zCIUGZXbEq0KnrPmRwoaUncfOimG9f4cJlv/FCRCAKZ/GZn2H
WjsXYBMdwl03I4xKguasm/kpSjvwAvfXSq5HKavO3TPNsmhYv6cMOiCfIOWZtyYb
q68cgCwZJnKI1INU70CrXQ2nsYkcUz5h/4HZ7thZ3wh9Tc0luWjCs5Zca7CbvWV/
KpFm5ONkjdBzZH49aToi6kZlDlduqqwZllgSS86dWKVW9q2oxKN2D3Pq6lsmFlXf
2kBrhKAZjSPF+fhkX4lVui2cFLcEXdCn1Wo4RyrPodOJrbgnyk0xD8hPPExzEvy7
wMC1/taRjomO86+87wIoWYAkkFyzlPPvDuZhLw0smzO12FqwafoQ7/p7RbLL7ITz
Keh5/3sHwfjnDE0rp34DOlUwT7Po2bRIpPNtetBDuiyA9cORAEoQoyUjkOUj73jb
vzxvXnhSdAznMlnYyjDmG6gKkFf3Qn1Xj3hsLPxLEcMYh27UKKXsPOriLPP9ZWIe
yiyvoQajcbubejqzEWoVZcd/91T937dm/bIrQrynmtoDPwW7S6pBfGd4GYJOTF6c
bopKbZNlMh1dcnA8L2Q3
=DAW1
-----END PGP SIGNATURE-----

--g1hTlksL6ldnMTAii8O0AWWXVcYK2uyuN--

