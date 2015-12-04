References: <565A3985.3030800@...1227...>
	<1448835033-24287-1-git-send-email-iam@...2070...>
	<CAKuzo_iVJWYj9v3UtdYscBG1BvfwYj33TMrr0b48tk5n_yXxCQ@...278...>
	<5660EA2A.1020903@...515...>
From: ValdikSS <iam@...2070...>
Message-ID: <5661214C.8040905@...2070...>
Date: Fri, 4 Dec 2015 08:14:52 +0300
MIME-Version: 1.0
In-Reply-To: <5660EA2A.1020903@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="US2BpDFQRRaqgsfqf0iKSUtUGei6UqPki"
Subject: Re: [Openvpn-devel] [PATCH v7-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--US2BpDFQRRaqgsfqf0iKSUtUGei6UqPki
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

These issues should be fixed. Please check PATCH v7.

On 04.12.2015 04:19, James Yonan wrote:
> These may have been fixed by now, but noticed some issues in the original=
 patch that was discussed in the OpenVPN-devel IRC meeting several weeks ag=
o.
>
> * win_adapter_index_to_luid is declared to return a
>   NET_LUID but not all code paths return a value.
>
> * wcscat(svchostpath, L"\\svchost.exe") isn't checking
>   for buffer overflow.
>
> * FwpmGetAppIdFromFileName0 must be paired with a
>   corresponding FwpmFreeMemory0
>
> James



--US2BpDFQRRaqgsfqf0iKSUtUGei6UqPki
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWYSFOAAoJEFzXIC7viPdy5uAQAId3ipSWfEr5Q/hfDNo3qiWM
0DulE+Ub0zaH7epE8IGwsMLKI0Lckh4vFaB9ydJw3L1q10MPtNhztCDGP7nprPtp
hi1Wmc8W89XtCxGdUmyzWIP8kPxWip6/juHIpRAAnUiFYgyjt0juxnq5T4ozg6Y/
ZRe1GbFRgUZeWUv6rpC2Xzl4mc2kjEg63+oGthKe6fTn/nHHGSxhjmIN5ca7+SA4
r80G1wRN72ImflvgdsclmlSvc+gaPuQSPwawYCMmnW/ff0Ea23OhMcMWs+f/8gvm
h/oj2D+6UhQE7JpiNI+ZlEYnKwcEBroS0I+xmck7wwP+sjQbNmlnmg/N8eoBbUf+
4xrXWqf0LKUFU8TIfTvWTfOj3wiz3y3MnD+G2Tv1s8zrkrOM91tCgiOsDVFkZ0C4
Ss98g5iqW7qEUOs3u1PEW7QcZzh9MDT16lrBVxoOyZ3V1zhSH5E2IxPffDcAF6dK
+k5IrfJa0WuzpPO9FaoGOo2sl6dHzFNWcLdS43kiXJhnGhxvJPnozqrdrVhC4mw9
RjARbdbkncZx0tW+Px7Mzh6r5QlmUmjneNN3+HOxtM0T/3LzEukdvFFIuFLoYPKW
TriDT1zHcNIfWBe92mQjSm7LVj3xDqOAVl4mqCLDIIALjF9kQb7cXxDigcaCtIz0
HZe8NQlKIO47YYAkKx3T
=3RRR
-----END PGP SIGNATURE-----

--US2BpDFQRRaqgsfqf0iKSUtUGei6UqPki--

