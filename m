References: <20190617124110.30907-1-a@...2181...>
 <20190617174653.GM1097@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e91322a0-168c-e815-33f7-e72e7c8a0954@...2181...>
Date: Mon, 17 Jun 2019 20:01:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190617174653.GM1097@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lP5r0dLTtGbxYhe1BnC9ONlF1XAYGcKtt"
Subject: Re: [Openvpn-devel] [PATCH 1/2] t_net.sh: fixes for the networking
 test script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lP5r0dLTtGbxYhe1BnC9ONlF1XAYGcKtt
Content-Type: multipart/mixed; boundary="FdFmFdKSwQazhbMcCtYdnY6fTZGJCli3K";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net,
 Antonio Quartulli <antonio@...515...>
Message-ID: <e91322a0-168c-e815-33f7-e72e7c8a0954@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] t_net.sh: fixes for the networking
 test script
References: <20190617124110.30907-1-a@...2181...>
 <20190617174653.GM1097@...1296...>
In-Reply-To: <20190617174653.GM1097@...1296...>

--FdFmFdKSwQazhbMcCtYdnY6fTZGJCli3K
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 17/06/2019 19:46, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jun 17, 2019 at 02:41:09PM +0200, Antonio Quartulli wrote:
>> +UNIT_TEST=3D"LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:../vendor/dist/lib/ ./u=
nit_tests/openvpn/networking_testdriver"
>=20
> While this *looks* promising, it fails the=20
>=20
> if [ ! -x "$UNIT_TEST" ]; then
>     echo "no test_networking driver available. SKIPPING TEST." >&2
>     exit 77
> fi
>=20
> test later on.  Well, it quiets the buildbot failures, but a test that is
> always skipped cannot be the goal - so, NAK on this, sorry.
>=20

Absolutely right. In the jungle of tests I must have missed that.
Will send v2 of this.

Regards,

> gert
>=20

--=20
Antonio Quartulli


--FdFmFdKSwQazhbMcCtYdnY6fTZGJCli3K--

--lP5r0dLTtGbxYhe1BnC9ONlF1XAYGcKtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAl0H1YgACgkQ9FVsWUWD
Dm0otBAAtw6jmSST5u+822sukTUbC1SDLbSk6Mtw5gGkzk0tEBs/sXjUuj7y8bwG
Ez3Pe3nDrw0D55ew0o2vRBmeHX8c8WL4En5jvWEgauDM3pUZCEDSiYWhgr2q0Mai
JQnNxqzJRyKqUeSGgG/tJP/g01UUz7AGtUfkd6RxhHAGZrR9tlzVdJgKKyvlR8Pl
5qDx5q03ndTbwILNWTLTFUNlmzGdh1i85ZMELU0ei7oNJvG1fbAzImQebmDPV2uq
i5L2yimg2aGFE5613RlBGvYCukgrbXVBuu8a162DPjWspSVQZsyFuJcFszY4Hwjq
daHYzGPj37iD5OG9yXoDjyRkB648k6wHPVA2zQAyXgrFa07laXFKprQD2YL04lH/
v8+ZCi57sZP2CKQ6k6z6FQQS5oppL7BtpvEbVLM2bqsCo98hYg8Iz/cLLfHOzLQa
+NMNa0R3OcJeTHNU6JeruHiZM5kMSrgL2HNQ3aapzrzR0ROV/aKRUynNne124wbG
YQzdo9cPyiZKpk6hCAWBrNuwbOOE/HUEsvmdg/P+JysoOSGDW7/bsyhAAmjcHCKW
6otromW8h1Ru4HkdMb0fBWDU5ShqwbzY55AmuQt2WOz1cUYjOlZ9AYxGa+C4yCd1
24zb1yuqORyh8eyFC9B4dwcZ4THFp1054WadgD0WjUkp9LOThCg=
=1BtB
-----END PGP SIGNATURE-----

--lP5r0dLTtGbxYhe1BnC9ONlF1XAYGcKtt--

