References: <20151125082651.GT24952@...1296...>
	<1448477731-21421-1-git-send-email-iam@...2070...>
From: ValdikSS <iam@...2070...>
Message-ID: <56560509.1070205@...2070...>
Date: Wed, 25 Nov 2015 21:59:21 +0300
MIME-Version: 1.0
In-Reply-To: <1448477731-21421-1-git-send-email-iam@...2070...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M8tGtJmnr240V3S30DQKxL046FFu4Rd2S"
Subject: Re: [Openvpn-devel] [PATCH v5-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, gert@...1296...

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M8tGtJmnr240V3S30DQKxL046FFu4Rd2S
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Sorry for double post. This patch comes with removed wfp_init, moved define=
s to win32.c from win32.h, whitespace fix in documentation.



--M8tGtJmnr240V3S30DQKxL046FFu4Rd2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWVgUJAAoJEFzXIC7viPdyXMwP/RnvguVwJeWWqHlK8OYCOH8z
IvtE6mtKBG99YyDXvwVGIgjtEa9aEi0R+yTTR3e4vo+JbwINev3CZrJlN70/Fa1O
TbvFWcB/PoSurJZbcU50RYrorfM6mCjxgGJODDKK0lYZ3xSnC1ZLTqnE9zEpTgqW
ZvtuLr6UHuufVgL4FkWiL2gzz/4iA0dyEiph1D7irmZmaNFTN+Yr/1E0Q/wzL/x3
ED/rXUBIc4hlTaLBmcRB1PV50mctsxEYQ3bu3thIwtfs5hDEKMZUxecdzDH1Af8f
O1zO1l0yNwOtYm7El1KDGYy9D03oatIDEFgxjAPpCxzVzymtgZICgYlD4m18RzqV
uSSifySLmUVE30GLbvW7/gif7/eznEUL/jMlN5U+BZi66T4OUMJy4sDONnFuIjLb
4voJos1x8rS46YECmjWViHvttFFhrEkL5OGSN0TOVHttr+UdmuqliQL49WW9LJKZ
IUet0huUWc7KLofbA8JYNvzRQx4KRdig4UD8ZqBetqp9UDedAN2kK0qn7w5zAiL1
4XZoVKlqs7L/kq6p5tdq9idQXyg1hMvVpMI81ohWgQ3CN8A77nOxtwgxuzj2j/We
67rrsziIeS4mzAPC5ohLqlWUgnrTBDnbZ4uABthEBg96jQX96jnq2hPUKXed3H+o
wth5VB46qPGbQ8PdpUpr
=cbkk
-----END PGP SIGNATURE-----

--M8tGtJmnr240V3S30DQKxL046FFu4Rd2S--

