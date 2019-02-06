References: <20180404121357.2126-1-davids@...515...>
 <CAKuzo_iYEY59K_SR4QRP3-X4bayF0BaCZdAxit6RQBmaDCsp0A@...278...>
 <a0ac1495-d40f-94f0-8770-bc4ed7669df7@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <04c8c393-8d9a-7d24-381a-7f243748cfdc@...1227...>
Date: Wed, 6 Feb 2019 14:08:16 +0100
MIME-Version: 1.0
In-Reply-To: <a0ac1495-d40f-94f0-8770-bc4ed7669df7@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0jdd51IfqCIprCPom4YdxdY5zXMntqnSf"
Subject: Re: [Openvpn-devel] [PATCH] man: Improve token based authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0jdd51IfqCIprCPom4YdxdY5zXMntqnSf
Content-Type: multipart/mixed; boundary="cP8pNMcK47lAnsengJ4GQtu2eMZc5ngoP";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: David Sommerseth <openvpn@...2080...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <04c8c393-8d9a-7d24-381a-7f243748cfdc@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] man: Improve token based authentication
References: <20180404121357.2126-1-davids@...515...>
 <CAKuzo_iYEY59K_SR4QRP3-X4bayF0BaCZdAxit6RQBmaDCsp0A@...278...>
 <a0ac1495-d40f-94f0-8770-bc4ed7669df7@...2080...>
In-Reply-To: <a0ac1495-d40f-94f0-8770-bc4ed7669df7@...2080...>

--cP8pNMcK47lAnsengJ4GQtu2eMZc5ngoP
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
> The intention to this patch is actually not directly tied to the fixes ne=
eded
> to the --auth-gen-token handling at all.  This is just to clarify the cur=
rent
> behaviour.
>=20
> In addition, it became clearer to me that the --auth-gen-token might be
> perceived as a "one-stop-fix" for authentication plug-ins/scripts not
> supporting auth-tokens.
>=20
> Further, the token expiry is an opt-in feature.  It is something the
> authentication script/plug-in need to handle, or explicitly enabled with
> --auth-gen-token by providing an expiry timeout.
>=20
> Arne and I have discussed his patch today, and agreed upon a path forward=
 of
> fixing these issues as well and ensure that both OpenVPN 2 in client mode=
 and
> OpenVPN 3 based clients all behave in a similar way.  This does also not =
rule
> out that we might need to fix OpenVPN 3 as well.  But consistent behaviour
> across versions with a reasonably good user experience is the core goal. =
 We
> just need to take this carefully, step by step.
>=20
>=20

I think with my current new auth-token patch set, it makes auth-token a
real feature instead of just a workaround. I will mark this one superseded.

Arne


--cP8pNMcK47lAnsengJ4GQtu2eMZc5ngoP--

--0jdd51IfqCIprCPom4YdxdY5zXMntqnSf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxa3SQACgkQFRhsZwKx
RFSn4A/8DrKEXPQ7RLkm02x4VhDkzFavWYCY/F0315dcDPsuezufz2JbPMD9R+qM
M13+OAqeExbN9KCsjvZHkk6/3ixMw14b0suP2kj5mnIA362GwO2WENtxbK/30Fo+
lQA6ChCc5j33X5KOfj3skoEvebBREteXxdkT3jBjRqFh0wjKeri2jZz8xueIM6CJ
It8670/XkNQy3i+O1RRQafa2CUdAUUjXt+y/Gh+Z6KhSzjDL0YNHCpcxLrlUe9Sf
50w4SrEAEPtoQmxlYtcsIY4c65Iow6KCCWnxNaIV6MwCxfmW4oNVBnaQsth0cc3d
/ptc8SRvJVlQqJmH01lXpXz12Jx80pd64ZGP/qr8aO03L5s0GAIe6mDW4Nf4Uzko
cygtTUeco4Mx0QJ17kR+0PTMbdRtAokc4AqLVLym0+GkeIIqMEdtX19xteKgCLMg
GxAgRMTDS0uAomZDaK/BgppAr9783LivhH+Z4RKlHF5PXmGc65RtxQTwwl3weCEf
zikK0V4EaBtsqg2dchALUaKah5tlumwlnguuylkCt2sNwfMPMt1JpO5Pvrameria
pRbOqzdMef6X7XSzOhANG/C+Ce02AH7rGLiOyqdZjIkPIJl3K90AKbImY3e7yXvj
txamlBYkssnhcds8DOT5CmKwUxrGDWUocZxFXqBKDIFFrVFSYYs=
=0AfT
-----END PGP SIGNATURE-----

--0jdd51IfqCIprCPom4YdxdY5zXMntqnSf--

