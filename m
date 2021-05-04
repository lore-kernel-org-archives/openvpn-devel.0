Date: Tue, 04 May 2021 20:36:33 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <LhNv_-egdxJ-t4-p7n4xkG3OKUEmkAUqYmmHdFRuz_5s2Yav0qxsZMHCqPyGf97iYJNZSEZzRV3JsP27fQebPPw_mGxwE1jV1L-9B6tAH4c=@protonmail.com>
In-Reply-To: <CAKuzo_jOFAP2j9rEz=7ZoZvk38a_qWCJHZnwVe=431xQJ3Th-A@...278...>
References: <20210429171504.1081888-1-tincantech@...2282...>
 <0a188829-5a2c-362c-eb6f-61ffe657042d@...1227...>
 <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
 <bQOH-0cnboEmpBYrhY8ZinjYni78M4fWH3z1_kKRQNVOA-LQOIomBj2wYz4yO1UfbHgSo5X__CZ_bC8sLGOs1USG_s0yXzJRgFbvVHfkTGs=@protonmail.com>
 <CAKuzo_jOFAP2j9rEz=7ZoZvk38a_qWCJHZnwVe=431xQJ3Th-A@...278...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_3Z9IVfoijnQSd8a4tL8RyM1NgmjSL09ifL6AW0YpvA"
Subject: Re: [Openvpn-devel] [PATCH] Add daemon_pid to --tls-crypt-v2-verify
 environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_3Z9IVfoijnQSd8a4tL8RyM1NgmjSL09ifL6AW0YpvA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, 4 May 2021 20:41, Selva Nair <selva.nair@...277...> wrote:

> On Tue, May 4, 2021 at 3:04 PM tincantech via Openvpn-devel
> openvpn-devel@lists.sourceforge.net wrote:
>

<snip>

> > Due to the inordinate resistance this patch has received, consider this=
 my official
> > withdrawal. I hereby NACK.
>
> Resistance is a good thing -- it means people are considering your
> patch seriously and are asking questions in earnest.
>
> I've had patches that languished for years and finally merged,
> without batting an eye.. Except for an occasional gentle nudge (say
> once a year), and some patience.

Selva, thanks for your guidance.

On this occasion I have been pushed to find a better way.
Thanks to Gert for reminding me about PPID and pushing my code a little fur=
ther,
I now realise that I don't need daemon_pid from openvpn directly.

Withdrawing this patch seems the most appropriate way to minimize the time =
wasted.

Sometimes it's difficult to see your own mistakes but realisation is satisf=
ying
if and when you do "break on through" ;-)

R


-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgkbBPACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ0MYwgAuFchojIT/cnf0yppB9o/WxJRZHdFaEn9jyRO+PgMYNrAJeet
QUqaCbUPZ0N5UdXnwuf5DTMYcStQpDyKnQyeB/dw0r23fmlSV69U1Vdx64+x
kjfbxl3h3miJ5yRu62YnmSCtqtiC/ErrJ1bz68RglI/aeGD4g6nPkpoHhZ/O
ix1zPxOpV+fnjEZtZfRCzNah+wa1vWyxF/UFpbIUe/pME6Y1pCGf4ZWGPFG8
qVdxSU/GwMMIaQn+Kz+iwoZDzhbkkprHGwS/yvJkEBIXOf8SspnlOOH0gJ6J
yFvxCBmaLeFUDoHhOy9JdL5toUN6hCtwu1wKPnUC3xN0IypeGdHtrQ=3D=3D
=3Da9Jn
-----END PGP SIGNATURE-----

--b1_3Z9IVfoijnQSd8a4tL8RyM1NgmjSL09ifL6AW0YpvA
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

--b1_3Z9IVfoijnQSd8a4tL8RyM1NgmjSL09ifL6AW0YpvA
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOOkDgryUUOkzOoONK0XB7eEdmA/A7i/Z/waMHRqSN2azBKkihZxDTKD+NKRi7FNjh/dgT20I/hI
yOqY

--b1_3Z9IVfoijnQSd8a4tL8RyM1NgmjSL09ifL6AW0YpvA--


