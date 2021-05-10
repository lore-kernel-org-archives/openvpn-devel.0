Date: Mon, 10 May 2021 22:22:25 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <j-ckr-drFYOevHn6wMzs5ghtq1I-y9Pwronhl_v_GPzrJsQLRGNpJNR0aqWCNPKuNlaXUpEe7lt-V8zMjrJ3TIaNv1JZPKMs78QAhxPPXfw=@protonmail.com>
In-Reply-To: <CAKuzo_g59fe97KOzuAfzuGKGR0_eLCyrULupw-u-irBebS2L1Q@...278...>
References: <20210429171504.1081888-1-tincantech@...2282...>
 <0a188829-5a2c-362c-eb6f-61ffe657042d@...1227...>
 <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
 <635b6cff-1742-e69d-fe91-fc33a5495a7f@...1227...>
 <tu-jUfrw68jHsNHY4mkYfTk6lbF5HjbdUUgJihX0J0-32Lq2yks9rUPrsX7v4fEA5TTb4-fj6mfZXe_ERsXLiLBBiwBQpkA0_ozsihQxIKc=@protonmail.com>
 <20210510172920.GP976@...1296...>
 <y2lmaEJRnB6BjT22cIwFGYiqA1Qq1Ipbqkl4m9N4EaxQvx75mCaX8p53HPHFkoNMmDBX7s4szU1E2pGbIFwgJrbolUA6Yh5SYv4E2e-mGs0=@protonmail.com>
 <CAKuzo_g59fe97KOzuAfzuGKGR0_eLCyrULupw-u-irBebS2L1Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_MzBbI4yZNjyfK3D4ZJUrIUvMMPVpEPBBgXcbCXX08Y"
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
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_MzBbI4yZNjyfK3D4ZJUrIUvMMPVpEPBBgXcbCXX08Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, 10 May 2021 23:10, Selva Nair <selva.nair@...277...> wrote:

> On Mon, May 10, 2021 at 4:24 PM tincantech via Openvpn-devel
> openvpn-devel@lists.sourceforge.net wrote:
>
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> > Hi,
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> > On Monday, 10 May 2021 18:29, Gert Doering gert@...1296... wrote:
> >
> > > Hi,
> > > On Wed, May 05, 2021 at 10:00:37PM +0000, tincantech via Openvpn-deve=
l wrote:
> > >
> > > > thanks for the feedback, I can resubmit with an improved commit mes=
sage
> > > > and corrected email if required.
> > >
> > > This is how I understand Arne - he's happy with the code change, just
> > > wants the commit message to explain a bit better why this is relevant.
> > > So, there is an ACK-and-merge pending :-)
> >
> > well, personally.. it's complicated..
>
> I think it's a good thing to pass daemon_pid to all scripts uniformly.
> Can't think of any downside. And, on Windows it's a pain to get the
> parent pid from a batch file. Personally, I do not have a use case
> though.
>
> Selva

Trac in question: https://community.openvpn.net/openvpn/ticket/1310
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgmbIfACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ2QrQgAoH7L8LCDvs8Tp9mj/VVR/aolKox2hHQJqfEcZXsEfKySmFUC
8oDFY9bnlOiGg1LhEaLIITXkYlW2aTB11Sm1DE/hYy1MK/IxByzwRa1AJyCk
6TJtmoiMl7Inwxz6z/IOCpSDCdOR+/i+BXaXx8pJujn7omr9Vprgkku78I6s
2unDfIycBWwMD78pCULJvqnOPzCM5TkA82x6WdcpJykLaeOOX+do7CrkNmxC
s9Hfl7duiqGgSCLAZOZv71CwvyoJYorHpO6yhB+UxikhszFANXRCEU4AXoqR
jRL8yH7ouz92mR9vospC39lwAMJGthBQ85l8Sj5ngaiVrvBj3qfh6g=3D=3D
=3DWQSw
-----END PGP SIGNATURE-----

--b1_MzBbI4yZNjyfK3D4ZJUrIUvMMPVpEPBBgXcbCXX08Y
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

--b1_MzBbI4yZNjyfK3D4ZJUrIUvMMPVpEPBBgXcbCXX08Y
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOk4mZ7mJ8T9HrkCcj/OaGqhF7yrW92ELb+FahdGsyY97TlORVKe+BUlHlVVacmOABLG
OgiUvnB5Wg==

--b1_MzBbI4yZNjyfK3D4ZJUrIUvMMPVpEPBBgXcbCXX08Y--


