References: <20190613144113.6418-1-arne@...1227...>
 <20190613144113.6418-3-arne@...1227...>
 <948b97f0-7f76-d8ee-418e-4bce369f40d4@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cfe07ce3-19c5-31eb-5247-4b4c244d0f0f@...1227...>
Date: Thu, 24 Oct 2019 11:54:01 +0200
MIME-Version: 1.0
In-Reply-To: <948b97f0-7f76-d8ee-418e-4bce369f40d4@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cZfNaYKhYcWfv6hYP6EYZe4HWnHPwYvh4"
Subject: Re: [Openvpn-devel] [PATCH 2/5] Implement forwarding client
 CR_RESPONSE messages to management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cZfNaYKhYcWfv6hYP6EYZe4HWnHPwYvh4
Content-Type: multipart/mixed; boundary="6LN2hWSmvWlvbgWi8uT7EbqWjva3zfXq2"

--6LN2hWSmvWlvbgWi8uT7EbqWjva3zfXq2
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
> I see one challenge with this approach, and it is that it locks us to one
> specific format for the CR_RESPONSE.  I think it would be appropriate to
> extend it with a "version" field before {CID}, so we have a chance to ext=
end
> the protocol without updating much of the core OpenVPN 2.x code base.  For
> now, it could be hard coded as version 1.
>=20
> So:  CLIENT:CR_RESPONSE,{VERSION},{CID},{KID},{response_base64}


But instead of the old method we are not limited to using a fixed
field/control command. So while CRV1 must have a version field,
CR_RESPONSE just does text responses and nothing more.

> I'm also wondering if this would be a reasonable approach to use to imple=
ment
> GSSAPI authentication support as well; where there is a back-and-forth
> handshake happening as well.

For anything that needs more than can be encoded with a base64 text, I
would rather add a new response type like GSAPPI_AUTH etc.

Arne


--6LN2hWSmvWlvbgWi8uT7EbqWjva3zfXq2--

--cZfNaYKhYcWfv6hYP6EYZe4HWnHPwYvh4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl2xdMMACgkQFRhsZwKx
RFSh5Q/9Ha8jsuDh53DH3Gd97HO5NMx5pM4CnPedLVNb/5i3gQDw4AFGH8OG1XEf
ibPNY2IsGvbJzim7jGJphQeaS/Oax0oqF5IXKhjQzcAHCHghwOXHaMG5J/Tv+GzX
LqV0kQq7bamBUJM3GCRKPYFIFk44LGdCOUNTpldlhOux4/Lr/iqrvyvp+kfhNoOi
r93bQn6RVb/YOtQnLs+0r1xv8ImC3SGTqf3iYLe7cLOj+X0VNFgpQ55Hl7OxOSt+
QDy3QL4rsL6DKvrGG+C6cuI+gnMpDSKUmxzDsjBuQKtLsRXlAOHdPk7y3QfmppoT
zLlyGirR8driiX0xit/BWuHIneVu4h7iOMm6WJ/A/sIUUvEI33j+ixupYJRdvhgd
8IaGYz/k9Npc3qQ6LcY2qse/DZBTUDmGxT0VLeGdtT+7pSOk7r98ZV/x/LxHQE8R
C9Zair5Gl+S4VSM3XZcuHmocr9JgRNj595c2+F5k1nbj5ln8wcZqbGWvmadIH/i1
acC42yMhN/TziEYtZfIGHQVyapd41q2QMcHakrmnoDL40MmRSEwremxFxdaih3xQ
lKbD1js+5uDtqrAK9LJZzmlDj0GOIUyOTAHWr5spdLYSewQQyM+Qv5Qx0nO7lGSI
6sK0GgZQ8wcMmwpqMF+Hv6ZN0pDK60P0Ma/QHf69QUU0GhWsOf8=
=aDtv
-----END PGP SIGNATURE-----

--cZfNaYKhYcWfv6hYP6EYZe4HWnHPwYvh4--

