Date: Tue, 18 May 2021 13:17:58 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <1-wqUyUqGk6eQK1zA0CPhTgqdQpxjGQTqI3voh4B-EMiVQjb4c59OGOOnebIAL68BJRWsivPwKHvudUHdpnwSv-85e9nnZ2Wk8UzNcwYqx8=@protonmail.com>
In-Reply-To: <6a826481-8afd-e164-e915-489d6a57040f@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-10-arne@...1227...>
 <n3em3mH7u7_P9kORtR7dx27nCUaNZq2XLdynQIYd83pPkPDqkp6FiZp4MNIYDy4fBNPbLX44Izq3gGNI9yz_sV8aofHdD0TjDdV00RQERHU=@protonmail.com>
 <6a826481-8afd-e164-e915-489d6a57040f@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_JoCpjVX2FkHEF4ybpDFZVhOhzy2rke6akGaNgbE1epo"
Subject: Re: [Openvpn-devel] [PATCH 9/9] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_JoCpjVX2FkHEF4ybpDFZVhOhzy2rke6akGaNgbE1epo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, 18 May 2021 13:21, Arne Schwabe <arne@...1227...> wrote:

> Am 17.05.21 um 19:16 schrieb tincantech:
>
> > Hi,
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> > On Wednesday, 12 May 2021 14:15, Arne Schwabe arne@...1227... wrote:
> >
> > > This is meant to give new users a quickstart for a useable OpenVPN
> > > setup. Our own documentation is lacking in this regard and many often
> > > tutorials that can be found online are often questionable in some
> > > aspects.
> >
> > I believe Openvpn in standard mode (Full PKI) would reject an expired
> > client certificate.
> > Note: There is absolutely nothing in the manual to confirm this !
> > https://build.openvpn.net/man/openvpn-2.5/openvpn.8.html
> > On that page there are eight uses of the word 'expire' and they all
> > relate to an expired auth-token, this could also probably be improved.
> > However, Openvpn in peer-fingerprint mode allows an expired client
> > certificate to connect.
> > The client log does have a 'WARNING: Your certificate has expired!'
> > The server log has nothing about an expired client certificate.
> > And, as we all know, who reads their log files anyway ?
> > The issue here is that the server allows an expired client certificate
> > to connect and there is no mention of this change in behaviour.
>
> Yes. We just trust the fingerprint of the certificate. The behaviour to
> ignore expiry is a side effect of that. It is kinda designed to be this w=
ay.
>
> Arne

The change itself is ok, I just thought it worth mentioning is this guide.

Thanks
R

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgo76EACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1pAAf+M7BWGoMLjSdhrcfokV0mu9M8eND0XF7AvEI3d+DQEGqJ2S9I
l6aVCCXsIKi1m/fJbYSYROhD7zvKj3i1KQebXxUTTonmlhEIMLhXnzHmdAPH
Owh3Ixpf284NMTcjZgcQAhGcLdlMeVpykJrIIx4lpR75u0+FV6STUmtIgG2Q
gWOi4OduA5gNJanu4BlF/7JCHNXSQvHQ5yrSGBrRdT2kIIGnrHSYfmUz1Jq4
v0AHQP8aTFD6sUaYw2j0nRGKj43rAmV+yyx2oLU1/6jbiBl5wq25fgNi3cCa
22HuxRP1SsbSf5PoWbUyZmXagpnHKRmgj42DkMn3pMTLjGnDD6NmVA=3D=3D
=3DFotu
-----END PGP SIGNATURE-----

--b1_JoCpjVX2FkHEF4ybpDFZVhOhzy2rke6akGaNgbE1epo
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

--b1_JoCpjVX2FkHEF4ybpDFZVhOhzy2rke6akGaNgbE1epo
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOk+PNJbh6Nn/rfY06+qqHTUF1MH50ulLZb8OqYv89HWRXQoXcWbF2RLB0SXaIZ5uhac
9tIgCR4=

--b1_JoCpjVX2FkHEF4ybpDFZVhOhzy2rke6akGaNgbE1epo--


