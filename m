References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3f0208be-60e9-118d-b148-fe05e3da031b@...2080...>
Date: Wed, 10 Apr 2019 23:46:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0IyEfwqcbSrPwkPBUgflWlVYJZ14a2vY7"
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Francois Gelis <francois.gelis@...277...>, antiac@...277...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0IyEfwqcbSrPwkPBUgflWlVYJZ14a2vY7
Content-Type: multipart/mixed; boundary="REjKg9HGE6hnRN6ySjmLxTsu8bdX9hTtP";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Selva Nair <selva.nair@...277...>,
 Francois Gelis <francois.gelis@...277...>, antiac@...277...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <3f0208be-60e9-118d-b148-fe05e3da031b@...2080...>
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
In-Reply-To: <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>

--REjKg9HGE6hnRN6ySjmLxTsu8bdX9hTtP
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 10/04/2019 17:58, Selva Nair wrote:
>=20
> As I replied to the openssl-users list[*], pkcs11-helper only supports PK=
CS1
> signatures, not raw signature needed in this case.
>=20
> We have to either patch pkcs11-helper or switch to something else.

It would be wonderful to switch it for something else.  Unfortunately, it d=
oes
a lot of gluing between the lower-level operations (similarly available via
p11-kit) and the interfaces implemented in OpenVPN is fairly high-level.  So
this "glue code" which pkcs11-helper is, is not that trivial and last time I
checked the alternatives were scarce :(

Is this a Windows only issue?  Or is it present on other platforms as well?
If it's Windows only, I think we can get around it by patching it and ensur=
ing
upstream is aware of this.  But if it is more platforms, patching
pkcs11-helper gets nasty quickly.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--REjKg9HGE6hnRN6ySjmLxTsu8bdX9hTtP--

--0IyEfwqcbSrPwkPBUgflWlVYJZ14a2vY7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcrmQYAAoJEIbPlEyWcf3yZEYP/iIaa31SqKqJmuVI+9QMfTCY
/ZGkRxLGaxkX/vOdGt9IGr4IN9AVR6uLg/rE/gRrSkJbUdPP7OF32XoZX9epQcl4
KFF50TLF3DtgES9uDmEaH8oYrBT4Xr/Qs4MtDzB5mNb8hi2rB14md2UjGkoOI+oF
9ZNwCIL4DFTx7Ul1fOsfIkEjGDTBKe0eYp6ZFj/xliFP5r5edQZKCFaaLKEkOVDm
IHnNuE12mRc+T+L+48WlHSAfvi2uDENeStWcfVOiFSPMRtGSI7bbIXQuUrlxf3IH
VRJ0u0TFqD+29PrrFytJE8B6eah+d5czxBjZ2GwZdQTi5pMkhNdwv9fMwmnnSYfe
Gd6CznXAM13ZFOoJB1xtupR19WnODHh5mxPmqlI6Cy237+I0dHJr0LOkbJoN3vVl
l/uRhmnAw8sETOnTfLftRnZFvDv0GpEvtWAb3I7ZRL87Vg2uZKX9OR9Ywgw/fITF
Fo8WMfgfEKYImt7cg3CV5JJvek1j1rBFdBVE+8KWAVqZLphly0mYZ3pukeVcBmd/
EQdpkNaEoHiyMu+Pzq8WTpfG34Faec91kB9yhGYmGQghXvKnL5C3CnXgsfdxMglH
M6kJNdQ4pQzHMOHqJYOlAYW7AFoLHzMbxMRRdyr7kACKuyqBUHBvroYJRxpoKEj5
IssRCeZRrMlLCHG8vcBZ
=74rW
-----END PGP SIGNATURE-----

--0IyEfwqcbSrPwkPBUgflWlVYJZ14a2vY7--

