References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-2-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <7affc0a9-2f51-145f-ad2b-6f004bbd27ec@...2181...>
Date: Thu, 9 Nov 2017 11:15:44 +0800
MIME-Version: 1.0
In-Reply-To: <20171101220342.14648-2-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xa9hs1LIK3DwP4LDqSx7Vh8rOWAQ9EPK9"
Subject: Re: [Openvpn-devel] [PATCH 1/4 v3] pf: clean up temporary files if
 plugin init fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xa9hs1LIK3DwP4LDqSx7Vh8rOWAQ9EPK9
Content-Type: multipart/mixed; boundary="Fpqoxi4t1HSr9XlPDIBQgoVt4IbopmhQX";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <7affc0a9-2f51-145f-ad2b-6f004bbd27ec@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/4 v3] pf: clean up temporary files if
 plugin init fails
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-2-steffan@...1856...>
In-Reply-To: <20171101220342.14648-2-steffan@...1856...>

--Fpqoxi4t1HSr9XlPDIBQgoVt4IbopmhQX
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 02/11/17 06:03, Steffan Karger wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> close_instance() tries to remove the file in c2.pf.filename, but that only
> works if we actually set that if we fail.  So, set that filename as soon
> as we know we've created the file.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Acked-by: Antonio Quartulli <a@...2181...>



--=20
Antonio Quartulli


--Fpqoxi4t1HSr9XlPDIBQgoVt4IbopmhQX--

--xa9hs1LIK3DwP4LDqSx7Vh8rOWAQ9EPK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloDyGYACgkQB6U8WA7y
zXTYfRAAokMtis4ukhPru8LU+wwEt/eviQq9IcmWJDQYWzOhmcTlcJWn5fMCD7pS
OzbO0AXndEHFfukPzVRIzCcVsVQVKWrzJ4nX81VO/qYe678SVhj+StB49z0nMK6j
PhHAYUxJVIGFBQdDCkeYrAwj8yFlBPVobq3re2cFtJ3EhyrBxjdtSrlPs+R0ENJY
UOqnUu1hZLBHZiE1QOZGr0l3GoNsKKK0qCHgoB8k/gghLsvB3Cg1qrm6/i8W9SLS
X1El1AbHUVNZRrGBox1z4ckj1G+g4p/E9ObAKmvuTmXGT/8J53MLgcjVbkXpKP/A
Ms8VVOsxcsNJf5/jpygTbn0LRFqjd/z25gADi49ASEwsrnEut986WnaoXhTdZydB
qAinuf1s5+dinA9roKV+aiV4pbhcPOBk3XU15S6IqLVSy/5ctqvPa9DycTfZ2GLD
+oiMKtQkgq1lJFnAf6HfBgrq0IxtBSiDeDRlO+U9f3rYHbqRFEM8XfCm//zSQqDd
DaXvQ0+VMXMMxswfLUdWaXIlVsFMZ7W5EM8Y1PPHLjpM0JYKDPYzuTdBuWZmlPY+
i8I0+igd4iNOquVtDduqJQwqAIyvOiwqujL7R2KXEwewwIqIL9+c5lJlPOqwvc9g
Fj0TkFvxs7Q3vAZeaqOoLFNaesFBjjr4uqT/Df1JAmzyMZX8KD0=
=pPQb
-----END PGP SIGNATURE-----

--xa9hs1LIK3DwP4LDqSx7Vh8rOWAQ9EPK9--

