From: Arne Schwabe <arne@...1227...>
References: <20200725235143.22736-1-arne@...1227...>
Message-ID: <180221b1-0fe7-1b8b-36a5-3b4071197e1a@...1227...>
Date: Sun, 26 Jul 2020 18:44:55 +0200
MIME-Version: 1.0
In-Reply-To: <20200725235143.22736-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9BmO51ZrXq0DZ0IBbKNhUbYWo3CHxqO2u"
Subject: Re: [Openvpn-devel] [PATCH] Refuse PUSH_REQUEST as client/refactor
 process_incoming_push_request
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
--9BmO51ZrXq0DZ0IBbKNhUbYWo3CHxqO2u
Content-Type: multipart/mixed; boundary="Cdvh3PVPGLMSoV1W8Z8jy5U4lPGgwa9wF"

--Cdvh3PVPGLMSoV1W8Z8jy5U4lPGgwa9wF
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 26.07.20 um 01:51 schrieb Arne Schwabe:
> When a server sends a client a push request, the client will reply
> with a push reply. The reply is bogus and almost empty since almost
> all the options that are normally set (remote ip etc) are unset.
>=20
> I checked 2.4 and master and this does not have any security implications
> or other bugs but it is still better to refuse this.
>=20
> This code also refactors the method to get rid of the ret variable to
> make the code flow easier to understand.

On further discussion on IRC, retract this patch. The
tls-server/tls-client pair as a p2p pair with one side (does not even
need to be the one with tls-server) can have multiple "push xy" in the
config.

Arne


--Cdvh3PVPGLMSoV1W8Z8jy5U4lPGgwa9wF--

--9BmO51ZrXq0DZ0IBbKNhUbYWo3CHxqO2u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8dswcACgkQFRhsZwKx
RFR+Mw/9F9ktCheb4tWc2DtH8yCG/IC7+X0svM/WpT/8bSec3GbLyiss9stH/BJk
HmlCLMxIZG9RrOQxzeG/fZI0G9O9RdQ+ozVMWbMX05UyOttQM64yZzIWe07NCzRZ
X8mmXjTF94aPROD1s9JZo5qwa0gUqXqn4xQWiknw1Tejqf6cGsMljP7H94WUyfxQ
tnhW35KGE86yX+WctpxqH2p051brGMOzeQf6rxaZTFinI3SF22b+UED2+FkNZM4O
H8iJDOCP4g2Cs4+pQ0PS/cmEw3vMgzC5DME6fCDz0iyBHA5bbpUBrMCDPsHkgZzu
PjyUSvHDGMlW7EOky2jywFFpoh0eKbFYh+Yx9bkMixjKLueDZEd/RKpmzn6Ur/z7
0ajcwXsBfZynx7OSpm67rvXb+JqSIUTgetDVK4OgmetSYBBTaUZQ+nDwydEa0Pgs
tBHno0Zc7cuH5r3NxOaYKF2NDH974PP4K3GRu15BW2Afvw+ulUWnGNjBCBEXBZjG
tI7hjF1GEICfYb5ii9nbjzXKNqL5qCyEauX3Is5IhndQf4GKXTq8QcZTl0nFFx1o
0GNFaaSlA6frfm93TqJWldEJvCmOMktLsZqV+z95drW0b9ItiP3/KbLfcBhbIYPn
hIAlult3hXEXYpj+pPxhaeG0VWwk9AJxfi2/O2Fkw+MHZsluFWU=
=ipdT
-----END PGP SIGNATURE-----

--9BmO51ZrXq0DZ0IBbKNhUbYWo3CHxqO2u--

