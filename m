Date: Mon, 24 May 2021 18:10:32 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <hygEYgyM5YzWlc1jNqaSj4Ubqzlf4AEvkNGT613wXXBbcjLPkZVen7yb0Uv6dxQPSYBV68VKNXAUc6JMmzIxVWH_u0U9DxaC6x42Zn4cG8A=@protonmail.com>
In-Reply-To: <CAKuzo_heOferug+BNyGaKc66_pD2AQO72PSAioGH+aTXux3jsQ@...278...>
References: <r2Oc8HU_6LoYR_UE522CC5CcNVDyYxI_Hm8eiO-Fb-4aPwW5bsVWVIr8nTaZxFIbBT0duI74wOE_CObRLoLNgdkzwHN3ua1qMe9upZIuu98=@protonmail.com>
 <CAKuzo_heOferug+BNyGaKc66_pD2AQO72PSAioGH+aTXux3jsQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_lhCXFlRVd025qffbHQlIO0AaSJILNTeYFhUsed8HI"
Subject: Re: [Openvpn-devel] --tls-verify runs twice for a single cert in
 Peer-fingerprint mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_lhCXFlRVd025qffbHQlIO0AaSJILNTeYFhUsed8HI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, 24 May 2021 18:39, Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> On Mon, May 24, 2021 at 10:09 AM tincantech via Openvpn-devel
> openvpn-devel@lists.sourceforge.net wrote:
>
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> > Hi,
> > Is this expected ?
> > Server log:
> > 2021-05-24 14:58:03 us=3D534606 10.10.201.226:60276 TLS CRYPT V2 VERIFY=
 SCRIPT OK
> > 2021-05-24 14:58:03 us=3D558066 10.10.201.226:60276 VERIFY KU OK
> > 2021-05-24 14:58:03 us=3D558105 10.10.201.226:60276 Validating certific=
ate extended key usage
> > 2021-05-24 14:58:03 us=3D558120 10.10.201.226:60276 ++ Certificate has =
EKU (str) TLS Web Client Authentication, expects TLS Web Client Authenticat=
ion
> > 2021-05-24 14:58:03 us=3D558130 10.10.201.226:60276 VERIFY EKU OK
> > <EXOK> * EasyTLS-verify =3D> CN: cli-arch-v21x connection allowed
> > 2021-05-24 14:58:03 us=3D573751 10.10.201.226:60276 VERIFY SCRIPT OK: d=
epth=3D0, CN=3Dcli-arch-v21x
> > 2021-05-24 14:58:03 us=3D573782 10.10.201.226:60276 VERIFY OK: depth=3D=
0, CN=3Dcli-arch-v21x
> > 2021-05-24 14:58:03 us=3D573911 10.10.201.226:60276 VERIFY KU OK
> > 2021-05-24 14:58:03 us=3D573928 10.10.201.226:60276 Validating certific=
ate extended key usage
> > 2021-05-24 14:58:03 us=3D573939 10.10.201.226:60276 ++ Certificate has =
EKU (str) TLS Web Client Authentication, expects TLS Web Client Authenticat=
ion
> > 2021-05-24 14:58:03 us=3D573948 10.10.201.226:60276 VERIFY EKU OK
> > <EXOK> * EasyTLS-verify =3D> CN: cli-arch-v21x connection allowed
> > 2021-05-24 14:58:03 us=3D588472 10.10.201.226:60276 VERIFY SCRIPT OK: d=
epth=3D0, CN=3Dcli-arch-v21x
> > 2021-05-24 14:58:03 us=3D588508 10.10.201.226:60276 VERIFY OK: depth=3D=
0, CN=3Dcli-arch-v21x
> > 2021-05-24 14:58:03 us=3D590929 10.10.201.226:60276 peer info: IV_VER=
=3D2.6_git
>
> This looks like an unintended consequence of how and when OpenSSL
> executes the verify callback. If there are no verification errors, the
> callback is called only once for each depth with preverify_ok =3D 1.
> When there are errors (as is the case when CA is missing), for each
> depth and each error we get a callback. (Ref: OpenSSL docs on
> SSL_CTX_set_verify).
>
> Even for self-signed certs one would get a call with an error saying
> certificate is self-signed and then possibly another call with
> signature verification success. For a cert issued by a CA, one would
> first get an "issuer missing" error followed by a "signature
> verification" error and no success calls unless there are intermediate
> certs.
>
> This was not an issue before fingerprint support. In that case we do
> not proceed further when OpenSSL reports a verify error.
>
> The easiest option for scripts may be to be prepared to be called
> mutiple times with the same cert and same depth. I think we should
> export the verification error-status to the env so that the script
> could make a more informed decision.


Note: In the logs above, the script is executed *before* Openvpn/Openssl
verification, so exporting error-status to env for script seems unlikely.



> Our internal callback is not meant to be executed multiple times with
> same depth, but the side effects appear to be benign -- like repeated
> VERIFY OK in the logs.
>
> Selva

Thanks
R

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgq+wRACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ3oqQf9ELeVXn5uhviySVqMzIRyCKQAY9zMrdvFSLgNcEOJbiBYcv6Y
WIzDoVfODy0jGIx44dsjODw2jM9hWP27FSj/uG8RuTCv7gmO/zDvJIKL6qEn
EcpnLxLBvyJcfu7zfW80kBNhYcHyys3DSSL2khtzbT+75OM3Kvo7pUNJUAhl
czUF07j7o8KmUGq2wB8E70Y7i+U07j2Dcs0+oDRhY3hBsnHHmWPSm32fBPLZ
uSbRPm4btNe4a/R83uMRkWTgL1U/2dTKKPb3PyVE7bGWfeB5BmkuUQsPx5q6
bofIkWaDYG+1pW6nyTxMZ2drihC2c9vA/OHmLG6HUYxBIaYPW/JZLQ=3D=3D
=3Ds/jt
-----END PGP SIGNATURE-----

--b1_lhCXFlRVd025qffbHQlIO0AaSJILNTeYFhUsed8HI
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

--b1_lhCXFlRVd025qffbHQlIO0AaSJILNTeYFhUsed8HI
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkCplEI/vfetCU8C4IQ4o6M/4MpjykXVMeeclPdCqz1+8GDqoqonuAqFISMLq9MUPOQ
CQ==

--b1_lhCXFlRVd025qffbHQlIO0AaSJILNTeYFhUsed8HI--


