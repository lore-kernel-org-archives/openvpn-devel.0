Date: Mon, 24 May 2021 14:07:55 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <r2Oc8HU_6LoYR_UE522CC5CcNVDyYxI_Hm8eiO-Fb-4aPwW5bsVWVIr8nTaZxFIbBT0duI74wOE_CObRLoLNgdkzwHN3ua1qMe9upZIuu98=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_pya6u33apfL1rqbW1Ob1OoQnAC7N3z8ujfugvu4fo"
Subject: [Openvpn-devel] --tls-verify runs twice for a single cert in
 Peer-fingerprint mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_pya6u33apfL1rqbW1Ob1OoQnAC7N3z8ujfugvu4fo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

Is this expected ?

Server log:

2021-05-24 14:58:03 us=3D534606 10.10.201.226:60276 TLS CRYPT V2 VERIFY SCR=
IPT OK
2021-05-24 14:58:03 us=3D558066 10.10.201.226:60276 VERIFY KU OK
2021-05-24 14:58:03 us=3D558105 10.10.201.226:60276 Validating certificate =
extended key usage
2021-05-24 14:58:03 us=3D558120 10.10.201.226:60276 ++ Certificate has EKU =
(str) TLS Web Client Authentication, expects TLS Web Client Authentication
2021-05-24 14:58:03 us=3D558130 10.10.201.226:60276 VERIFY EKU OK
<EXOK> * EasyTLS-verify =3D> CN: cli-arch-v21x connection allowed
2021-05-24 14:58:03 us=3D573751 10.10.201.226:60276 VERIFY SCRIPT OK: depth=
=3D0, CN=3Dcli-arch-v21x
2021-05-24 14:58:03 us=3D573782 10.10.201.226:60276 VERIFY OK: depth=3D0, C=
N=3Dcli-arch-v21x
2021-05-24 14:58:03 us=3D573911 10.10.201.226:60276 VERIFY KU OK
2021-05-24 14:58:03 us=3D573928 10.10.201.226:60276 Validating certificate =
extended key usage
2021-05-24 14:58:03 us=3D573939 10.10.201.226:60276 ++ Certificate has EKU =
(str) TLS Web Client Authentication, expects TLS Web Client Authentication
2021-05-24 14:58:03 us=3D573948 10.10.201.226:60276 VERIFY EKU OK
<EXOK> * EasyTLS-verify =3D> CN: cli-arch-v21x connection allowed
2021-05-24 14:58:03 us=3D588472 10.10.201.226:60276 VERIFY SCRIPT OK: depth=
=3D0, CN=3Dcli-arch-v21x
2021-05-24 14:58:03 us=3D588508 10.10.201.226:60276 VERIFY OK: depth=3D0, C=
N=3Dcli-arch-v21x
2021-05-24 14:58:03 us=3D590929 10.10.201.226:60276 peer info: IV_VER=3D2.6=
_git

Client log:

2021-05-24 15:06:44 us=3D111054 TLS: Initial packet from [AF_INET]10.10.101=
.101:17332, sid=3Dae12d90b 6b413bf6
2021-05-24 15:06:44 us=3D120475 VERIFY KU OK
2021-05-24 15:06:44 us=3D121197 Validating certificate extended key usage
2021-05-24 15:06:44 us=3D122354 ++ Certificate has EKU (str) TLS Web Server=
 Authentication, expects TLS Web Server Authentication
2021-05-24 15:06:44 us=3D122737 VERIFY EKU OK
* TLS Verify Script OK
2021-05-24 15:06:44 us=3D130217 VERIFY SCRIPT OK: depth=3D0, CN=3Dsrv-wisci=
i-v21x
2021-05-24 15:06:44 us=3D130598 VERIFY OK: depth=3D0, CN=3Dsrv-wiscii-v21x
2021-05-24 15:06:44 us=3D131581 VERIFY KU OK
2021-05-24 15:06:44 us=3D132268 Validating certificate extended key usage
2021-05-24 15:06:44 us=3D132828 ++ Certificate has EKU (str) TLS Web Server=
 Authentication, expects TLS Web Server Authentication
2021-05-24 15:06:44 us=3D133364 VERIFY EKU OK
* TLS Verify Script OK
2021-05-24 15:06:44 us=3D137990 VERIFY SCRIPT OK: depth=3D0, CN=3Dsrv-wisci=
i-v21x
2021-05-24 15:06:44 us=3D138614 VERIFY OK: depth=3D0, CN=3Dsrv-wiscii-v21x


Thanks
R
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgq7M5ACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1+vAgApEpHTOh5m9D706+WEOMvXq6PiKxfLnnjowOMLS1ut+ts0Kj6
8JHutbqJarT+0rhiezfDlKqqdXrDLaW/5bfF0M0f9J8+BgZNGIKXSM2Tp39f
lSqJIF0kMdD/RQKYxGu5TaO3eLaaWTBbEdkyAHa+t74E7fIiTtxEdvgqVkWm
423h3PSsdnHcOaCQkM7KOGilmpq+Wz/5KEtjVlzhKyfscqtw3RUvtFgKOXYj
p+axmfzY1aqkQNQTz98nC4w06Vao7XUSQtjWYfznVdDd8rP/hHmWDwLtYNyR
yQnN+iPHg5JsAdmrQ+6m99bX+C8btSHUPfN/0jAifkZjmEwP/I9ckA=3D=3D
=3Dcwb8
-----END PGP SIGNATURE-----

--b1_pya6u33apfL1rqbW1Ob1OoQnAC7N3z8ujfugvu4fo
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjgNCkNvbW1lbnQ6IGh0dHBzOi8vb3BlbnBncGpzLm9yZw0KDQp4c0JOQkZ2d1NjY0JD
QURPbUhFblFsTG1PakpSdEpMMmw1M01Md3dGVHk3WG5FcHMzYjFRMFV3V1lGQ3YNCkwyb05wMG5y
ZEdsS0tESnE1MFkwOVNSK1VSWUJRbUttWTNFbXpweVVJS00vcmdvMVJ5dWJIcE1SSGJEcA0KN0pw
OEx4a2ZmRkJWSmovdDVWTXBENmVNUjZhVWNpUWpnUkw4TlplNitUN3hmWFhYd1Y1aG9SZVozak8r
DQp6SGk2U1I3eFR2R1hsYStNUXo2RUVwV25sYkx2ZzJvcnQ5S3NldVZqWXJxdlJNeGNkUDBvOWNa
V0o1ZXANCkpObWdlQjZNNytPVzA4VTFTc1h0S3JwTFJjSTZ5S21WMzhqaHpQcjJaZ1A5cm1ybEVy
Ui8xaXFRUUhYWQ0KbzgvMERmUHlGMG1IOXluUUlpTEUvbCtGWXU0cnNHOFZpS2x4aFhjemVQekF0
TENqaUIwYTBtUlZBQkVCDQpBQUhOTnlKMGFXNWpZVzUwWldOb1FIQnliM1J2Ym0xaGFXd3VZMjl0
SWlBOGRHbHVZMkZ1ZEdWamFFQncNCmNtOTBiMjV0WVdsc0xtTnZiVDdDd0g4RUVBRUlBQ2tGQWx2
d1NjY0dDd2tIQ0FNQ0NSQlBsNXoyYTVDNA0KblFRVkNBb0NBeFlDQVFJWkFRSWJBd0llQVFBS0NS
QlBsNXoyYTVDNG5RQkRCLzlaVW85Qk9YSlI2MU5tDQowMm9aLzhhUlhPOU5uVVNGdDZHTE9XY0RO
dkFzNElKV01EVkVRZllhbmIrNDIxUU5kLzVkNkgxaVhGK2kNCjRMREswTTZhZ0MrZ3NORkpualBH
SXR2UHRqN1d5anluWlJ4OEQ0MFBQWGlnZkhZdXcyb1J1MGxyK1AxcA0KMXFlVWU0TmJjcUl2OElJ
dkx6MnpDbFlaT05nQXNRVmNOQUhpN1o0b3J0UTJpbzJCQVZqLzgxOUpQWU10DQp0SGdZODF3UzFW
N3Y4R0RUWmc4b2FQaFhHZmFDNFRaRkd0WnIvYnliY3Fyc28zNWphUW1DNTR4TWJYcEYNCkFVcmMz
dUdWT0grT2RHL0JXMmdjWXFwdlVGQnVrWHhDVUJZSFAyTmZYaE5mekd0OW5DMXVsTktZZVAxOQ0K
VEdsT29yQk1ZSUFFSG9HeHZwYlVYZmJhTldDVXpzQk5CRnZ3U2NjQkNBQzlLeVZaUlM1YU1hRzVQ
aTBuDQpmeDhhTm9zM2JZcDI0Nk10ZmFvS0JmVFFBcmQrR1pXK1duRnlKRWlTeUxkejByVXV0eUNB
ZGY1bGdWSCsNCld2THZJbWlHclNyelZwTVQybkNTMDlMcUw1MFFqejhBN2dwNUgvaFF6dFo4aU55
c0dEOU5PNDZPbkk3NQ0KOTBkSGZDclhqUVBTRnRGR3NUemdEeFFJaU11eno5RFI3QmVrS1BtdU9G
SWhCZTllRVpxYnhjOFJXZVF0DQpoYTdpL0RySlRSTksxYU9BRFFGVnVWMS9BbTVUaEdQV0ZNL1lK
VXlUWWhNVzB5ZVBoNDVPYld1UlFaa3MNCmwrYU9tNEwwS0dERFlsbS9GUXgvRU1DdWJ2bHp5L3p4
RGRCNm5xRmloMnFacmZ5bW5pU09LYWpHMGpvVA0KcFpvei9Feis0ZkF0ZzZ5MFBzcE5SNmlkQUJF
QkFBSEN3R2tFR0FFSUFCTUZBbHZ3U2NjSkVFK1huUFpyDQprTGlkQWhzTUFBb0pFRStYblBacmtM
aWRSZTBIL2o1Q0lGSUF1Y3VhaUVNa0xrTktFQU81czd4NDdlTnkNCkdQZlpzbHlZK0hqekdVMGQw
N01ra0dtVmtQVFZ6d3FWek5aYm55N1pBdjF6bFcwVXkweUhwMUFQcHlZdA0KOGJ1VXBwVEJxN2Q0
N29neEVSWXp0L0xjMkw1YS9WS0ZOUmJoTjEvWFFtUGl6MkVsZTR0eWlwYlRhcGN5DQoremJ5ZnpB
TUQxM2NJZFoxM2hUc05QMG9sZ0JoQXFVQVVVWXB4UmxrQUhlSitEdDNOYnpIUzRLUUs1MzgNCk5K
L2w3YlhTS3NHcW9ZcUplWjhWTkJ4d1dXVWJ1RzRqanJoNDNNSVJnVVo1V3NQVVlWNkh4MDU2a01q
Yg0KL2JZQmpJMFRFTXZIODE2MHVxekZYZUh2WXlVbHEwU2luRC9aOWlvSWU4UWRzSEdCRFVJUllZ
dWIxcE84DQpxckN6Ulp4MG9OQT0NCj0vRGVhDQotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9D
Sy0tLS0tDQo=

--b1_pya6u33apfL1rqbW1Ob1OoQnAC7N3z8ujfugvu4fo
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

s9OkDgryUUOkT9mPiot9PgBz0FU2iTdWymLtl14Y7bjJ46AvT9VzzQGCvovYKldNh5IcgThoTmgJ
QwFOWAE=

--b1_pya6u33apfL1rqbW1Ob1OoQnAC7N3z8ujfugvu4fo--


