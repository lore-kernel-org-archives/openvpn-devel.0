From: Arne Schwabe <arne@...1227...>
References: <1540375925-6111-1-git-send-email-steffan.karger@...1435...>
Message-ID: <6422c0b0-a52f-c6ef-8cdb-b5d84cd8f94f@...1227...>
Date: Mon, 26 Nov 2018 17:34:50 +0100
MIME-Version: 1.0
In-Reply-To: <1540375925-6111-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7Rf6AWmrSMPf99nlvVOpLTm27pjtOghvt"
Subject: [Openvpn-devel] [PATCH] Remove deprecated --compat-x509-names and
 --no-name-remapping
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Rf6AWmrSMPf99nlvVOpLTm27pjtOghvt
Content-Type: multipart/mixed; boundary="abGYtqhU4ytzisg1elp7YvYC8Le0Lflhl";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Steffan Karger <steffan.karger@...1435...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <6422c0b0-a52f-c6ef-8cdb-b5d84cd8f94f@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove deprecated --compat-x509-names and
 --no-name-remapping
References: <1540375925-6111-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1540375925-6111-1-git-send-email-steffan.karger@...1435...>

--abGYtqhU4ytzisg1elp7YvYC8Le0Lflhl
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 24.10.18 um 12:12 schrieb Steffan Karger:
> As promised, remove these options for OpenVPN 2.5.
>=20
> If a user still uses these, print an error that the user should update it=
's
> configuration. Just printing a warning would cause much more confusing
> errors, somewhere in middle of a failed connection attempt because the
> (non-compat) names no longer match the expected names.

ACK-By: Arne Schwabe <arne@...1227...>

The patch does what it says.

Arne




--abGYtqhU4ytzisg1elp7YvYC8Le0Lflhl--

--7Rf6AWmrSMPf99nlvVOpLTm27pjtOghvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlv8IKoACgkQFRhsZwKx
RFRVJA//VJx1AP8NzjIAgKiErVXTa8ftkrxkxzoj2m3HCaOCeMzHSEy0BT/nhJxe
ySZJDsgU8FlU0w3I6gk5idXM5dkTAtki7FNMFvhvffZAfbYy6bjjZVzgy9hnnb1o
w3Qvm9fEp5qvYbhB0NKIyxPBwoBw3cKiaPgrBtBi3XLx5HUsOwEIVo3MsBfcCsE0
VfJOXA8xf2lafphr64zGHUotl6g4sexabwIL8s/zxoEpdygzkLnPi8cHr32aW6pv
m9Ys0CCWpedabMSklaySqde7iLYzS9wh/JG4dx65FbMzcb2ge50Zxv2T/ad/L9wf
kc4w9ji5kVUb4seSeIXhicDc+EG0FKbj1PfwiBe/cNtmZ0Ox9OalbbZudsibr4qA
sTuFN4L6jkzNP1d3eUrK7FUNhBzrnbQaKdCha80koC1XcgiMAgPXcSRgySUo1qqD
GI/T2TkGTnyuQfmASK/rnOtUyzOvDj6Q8avKmBWYwHHy0ktuQcRuH9Zwn9Q3jH18
RvVott4dSL9dtediwsm+8rD4ylOQRPz5/QcTwuWaZy6LBrW9PUvvP4DLX/4EPACa
NdvvK9EJyCuQTxVEgmOWXb+KpAg8jc9JwvGgraE3+t4SuJBxtqu6tFgtAMa7XPRp
vxKz46TednH3gbhtglgVHKXgZMZFZPX7794mWS0Zx+ND6rvDRCY=
=Ak8y
-----END PGP SIGNATURE-----

--7Rf6AWmrSMPf99nlvVOpLTm27pjtOghvt--

