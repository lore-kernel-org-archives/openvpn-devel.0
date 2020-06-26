Resent-To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <0a63549e-3091-980b-e3c3-241184117dea@...2080...>
References: <20200625210149.2864-1-tincanteksup@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a1ee9715-858d-f4da-46b8-ea1f63b8698f@...2080...>
Date: Fri, 26 Jun 2020 11:09:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200625210149.2864-1-tincanteksup@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gvSqs7z0yMF9n9jeRdOQVZbG7pQYi5y5L"
Subject: Re: [Openvpn-devel] [PATCH] New man page - Simple corrections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Richard Bonhomme <tincanteksup@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gvSqs7z0yMF9n9jeRdOQVZbG7pQYi5y5L
Content-Type: multipart/mixed; boundary="aZItrgsSv0pkTLbCTqgp2Qh6SbpCIwk6H";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Richard Bonhomme <tincanteksup@...277...>
Message-ID: <a1ee9715-858d-f4da-46b8-ea1f63b8698f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] New man page - Simple corrections
References: <20200625210149.2864-1-tincanteksup@...277...>
In-Reply-To: <20200625210149.2864-1-tincanteksup@...277...>

--aZItrgsSv0pkTLbCTqgp2Qh6SbpCIwk6H
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 25/06/2020 23:01, Richard Bonhomme wrote:
> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
> ---
>  doc/man-sections/connection-profiles.rst | 2 +-
>  doc/man-sections/examples.rst            | 2 +-
>  doc/man-sections/pkcs11-options.rst      | 2 +-
>  doc/man-sections/plugin-options.rst      | 4 ++--
>  doc/man-sections/signals.rst             | 2 +-
>  doc/man-sections/unsupported-options.rst | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
>=20

Thanks a lot!  I've applied the patch and pushed it out.  Just did a minor
adjustment to the commit subject, to align it with the other commits in this
branch.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--aZItrgsSv0pkTLbCTqgp2Qh6SbpCIwk6H--

--gvSqs7z0yMF9n9jeRdOQVZbG7pQYi5y5L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe9btLAAoJEIbPlEyWcf3ye8AP/RqxTuG8iAR2wkWBh4F2ePrj
e9xf92u7NpqT7YR5Up6b3TSRlKIVDYozh0m+ZPGhStXNTaqCqrTJAZV+jbFo605d
y0PV5mh08cK07Jei1Aqx7DL1vyAVtdLCb+nCKDe0MuqdorQ0c+Wc5w0h8D2JLs/N
9NyEfnyETf7E0EiHaLOxe7jBUyhFjwP7dfO2mfq3Ud0rWj/dhkuu8eA3O4jn1mYO
4XJ7DO9XNysuCIJbxzLbmOv8CuvKPw/HirNx32VQ/MAHvIlAxRAJkrCTtBJs6Duw
fHNAtcH1yUtg8QPoVW7O6XPtXIrmFL9llB+OZ3sHiwPzejLJT5yxlSMi5DCZaUiZ
rjWwqK9De/E5Trresscc4GzpXGL3a1hapJcvXsfvfJ0M5d8jgugeKYRH1Pd9oQfb
UIuq47nzlgIi1nSYuQrZ9JVFg8kGFddKHHPnfkaTF3PJbBHPGHcdMtaeNN62IorA
4JizGu9JmsnYK7W/QOwq9k/+VE5AMtOII3ZfZhQbcWUwXgh588kx934ngvLlieyS
xdHADmovYr1ZwsnMeA4H4OVFcupWdQrFsmbd3213j0iHiJ6H45+ueYpzH2eOuWeO
4iXmRWwFN845ez7KxGuVOZkb/04duQDbhjT5B8qkyKuIdxk+/rrzxEqtRO+3jmv9
AKUSM1542hOpeCI8qeHJ
=52sY
-----END PGP SIGNATURE-----

--gvSqs7z0yMF9n9jeRdOQVZbG7pQYi5y5L--

