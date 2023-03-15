Date: Wed, 15 Mar 2023 09:30:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBGCLjjaSwodDPce@...1296...>
References: <20230315013516.1256700-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="emfu8so/QlvHx08w"
Content-Disposition: inline
In-Reply-To: <20230315013516.1256700-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 0/4] Add some tests for cryptoapi.c
 functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--emfu8so/QlvHx08w
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 14, 2023 at 09:35:12PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
>   Import some sample certificates into Windows store for testing
>     - 4 test certificates&keys imported to user store
>       and removed at the end.
[..]

This is extremely valuable.  Thanks.

If I apply these 4 patches on top of "master", will the test then succeed,
or will it show failure due to the not-yet-merged padding patch?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--emfu8so/QlvHx08w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkEYItAAoJEB2Cnv7KVigSnnMMAI1zK/u4pQGahQA3kNuIzAB6
0PPr1+q0y7OvGhlGrSIWdjziYxjgw/SO63iGIDRUBLHIisN2/quDcia5F45kqPJK
V9zfDrxlT8UTCHKnQMbqyL2chVuiGTMVbwCOOYH7oP+vYVRjsxhO/vKfDSLFT2W9
ZUuOHvMpMrWlBHTyRW/g8fzmQJdhPOwkQfCXjMzWS13v6HSC+FLrV8bbUzrgzJgZ
pvBQjuSQfPzjxqGF9Mqkf1VxL/RUJUDc0jC/+2kTWDS+2Lde3rhAEFvss5pBn+zb
REwG47dYqvQLgA0MJBL2I+ooBAiUMqzpTBWRrybF0fz/97dgFobUr0TUbKxSnAUL
mAqOmxEK03jpZpiydoIRi7apBAHZzbDGzogl4j/NwsJx8i459SLC/hK3RMr9H5U+
IW+AZSOG3R4BazToSPBZTqaWIyMP4CuRpCOYacNY7BDYkjLFN9hT8ajdkunnlv86
/OpxPocD4M01hUyeGQuueh+m0hUJ2FpS4zWK1sg5Gg==
=pRKQ
-----END PGP SIGNATURE-----

--emfu8so/QlvHx08w--

