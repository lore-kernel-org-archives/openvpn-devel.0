From: David Sommerseth <openvpn@...2080...>
References: <20181019155638.9498-1-davids@...515...>
 <20181019155638.9498-4-davids@...515...>
Reply-To: openvpn-devel@lists.sourceforge.net
Message-ID: <94153c52-e64c-50b0-6217-6ffa60735037@...2080...>
Date: Wed, 24 Oct 2018 12:24:29 +0200
MIME-Version: 1.0
In-Reply-To: <20181019155638.9498-4-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JcMDfn0y0yYaf8aGzW3Fa0NScn0iu3k5S"
Subject: Re: [Openvpn-devel] [PATCH 3/4] Add gc_arena to struct argv to save
 allocations
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
--JcMDfn0y0yYaf8aGzW3Fa0NScn0iu3k5S
Content-Type: multipart/mixed; boundary="15rZ7PAVD9Y9NqHdomZAbTYYm1Nl9XcRL";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <94153c52-e64c-50b0-6217-6ffa60735037@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Add gc_arena to struct argv to save
 allocations
References: <20181019155638.9498-1-davids@...515...>
 <20181019155638.9498-4-davids@...515...>
In-Reply-To: <20181019155638.9498-4-davids@...515...>

--15rZ7PAVD9Y9NqHdomZAbTYYm1Nl9XcRL
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/10/18 17:56, David Sommerseth wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> With the private gc_arena we do not have to allocate the strings
> found during parsing again, since we know the arena they are
> allocated in is valid as long as the argv vector is.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 44 ++++++++++++----------------
>  src/openvpn/argv.h                   |  1 +
>  tests/unit_tests/openvpn/test_argv.c | 23 +++++++++++++++
>  3 files changed, 43 insertions(+), 25 deletions(-)

This is a simple rebase of [0, 1] on top of the previous two patches.  Noth=
ing
more exciting to say about this.  My last review didn't have any further
remarks than "will test it"; which I've done :)

[0] <https://patchwork.openvpn.net/patch/74/>
[1]
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15837.=
html>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--15rZ7PAVD9Y9NqHdomZAbTYYm1Nl9XcRL--

--JcMDfn0y0yYaf8aGzW3Fa0NScn0iu3k5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJb0EheAAoJEIbPlEyWcf3ysTgP+wRuu3V2wiY2VxthY2g9we+C
FO0jDMGx3DcG5ba+ss4to3cET3odihKQK84uJL0rZBSk3ddlzq7fY/HNdIy14Hpp
JooPBj1v17mQTw0Y27X7tz0ohi4hA9DXrHeu+/d3RJRqciUxIS+WTKVusro+XFUG
j4VvoFt0+dU161hLteSL0i5WG+voLvg+m9up0axkMi+NXlGm+n7ZlwW2sD9aUfG2
h7fA1+/0oROOGvXzlO/tAdUv9ennYd3S1PV8INSv1ahSC975oRLtZ0nPzQnwAK4n
6Y2SDUZSjeeVg0WpdD3pOBV1KfH0bdROHPk55HmfLYva81jOEcpPArnN0OVnzLiF
HMNePyBOlRP4hL7mhBnXUrXbyYhzcRSjirEGacMyCsgt6dUEsd7evccOMej42fBb
UbuimqSuB5W/UcCZyInVkarrmaiV6LzvNVcKU5z/dMItnmRYaLA7fm0D/E6GSvme
GcxwwumAJ+nVrrDeByF/JlRQzz0Iv1qTaRakCceW2oqOk2GtKPry6f7SUR24vBpH
29oktlGx+IKJAEXJRxnRgg878qI+0aZktWl8rXsa7WzCBidob+/Qh384PAFDDeFp
dPjZ+dQZiS+L5EBKpEWL2JCr0jfPmfEgMOYEsoe735Cd5VSOzDDapCHdaNmuFjPL
nwzeFhDUEGgW7mwd/JIv
=NIhC
-----END PGP SIGNATURE-----

--JcMDfn0y0yYaf8aGzW3Fa0NScn0iu3k5S--

