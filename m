Date: Thu, 20 May 2021 21:12:30 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <GS6Gxk2plMyW-jt2XyAduO6tjoh4Xn3f3UIHuoEG2ZIM-ufwdPWmJDHe6b5Quj1rEPIcTPlbNp7SRU55HW4zLHjAImAghOIkkRwJ5I8YJ78=@protonmail.com>
In-Reply-To: <624a3ba5-aa78-144b-ff48-17ccd522588c@...1147...>
References: <20210520150932.2565217-1-arne@...1227...>
 <20210520150932.2565217-2-arne@...1227...>
 <CNUI9sxE2HOdFvol4LftF6DPWGfmpSUabfpLXMOJQXcFcL_bM-zvF9u3oX68guJWALVYyC13DWKt4-9cVq3c8KjneyoFY32pgNpNYCQmTIM=@protonmail.com>
 <46a3a2a9-83a4-2fbe-2fd4-684a51c001f9@...1227...>
 <nehG6AKTksx4AeryA432f6vVe5OGFQSmkbS2TYGGS6MumnC0d8xRfGsZxR_uXmDN2b8Yfvt6zQX0fwG83sqvWlyuLsdneHWr-3Wz8vDc9Qw=@protonmail.com>
 <624a3ba5-aa78-144b-ff48-17ccd522588c@...1147...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_REIuiFuoH5OZfuvp7Bza8Q8k3Msy5LFvSZ9PvfI"
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_REIuiFuoH5OZfuvp7Bza8Q8k3Msy5LFvSZ9PvfI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256




Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, 20 May 2021 22:05, Jan Just Keijser <janjust@...1147...> wrote:

> Hi,
>
> On 20/05/21 21:49, tincantech via Openvpn-devel wrote:
>
> > > > Hi,
> > > > again, I do not understand why openvpn choose to switch to .pem
> > > > for this tutorial.=C2=A0 PEM -> Private Email, which this is not.
> > > > You have a certificate and a key and every other openvpn tutorial
> > > > on openvpn and probably the entire planet uses .crt and .key.
> > > > This seems to be a poor decision in my opinion.
> > > > pem as extension for keys is pretty common and specifies more the
> > > > encoding than the type. E.g. there is also the der encoding.
> > >
> > > Arne
> > > I accept the principle but openvpn only uses PEM-enc, that I know of.
> >
> > So, why switch to .pem when it has never been used before by openvpn?
> > If you are all happy to let it go that way then so-be-it,
>
> Hopefully this clarifies things:
>
> -   the default output format of OpenSSL is PEM-encoded ; openssl uses the
>     default extension .pem
>
> -   the OpenVPN .crt and .key files are ALSO PEM-encoded by default, but
>     they've just been named differently by the easy-rsa tools to ensure t=
hat
>     the files can be easily loaded on Windows
>
> -   FTR: nearly all webservers I have ever seen are configured to use a
>     hostcert.pem and hostkey.pem and my guess is that there are (still)
>     more=C2=A0 Linux-based webservers out there than OpenVPN clients and =
servers.
>
>     Having said that, I do agree that after using .crt/.key files left and
>     right (to accomodate Windows users) for over 15 years, it does seem
>     confusing to start using files named .pem for peer-fingerprinting all
>     of=C2=A0 sudden. On the other hand, with peer-fingerprinting you don'=
t=C2=A0
>     HAVE a .crt file (at least, you don't need one, technically) but only
>     a .key file. So choosing a different extension for peer-fingerprinting
>     does have its merits.

FTR: Openvpn still exchanges the full certificates in peer-fingerprint mode.


>
>     HTH,
>
>     JJK
>


-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgptC5ACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ2t0ggAxDZnJr8UhxV79fyAjnScANMeWbN3XZ/QqQuTsgaJp85Fibbz
weT1TfvihZ5l1rS6vh1nIDyTtoNRpqLHMxlaNWnmgN9tR4IRlQZuVR8svZl1
UYmrAm1H5g83yHef60nnIiOxGe8tnLdy/fmjqoRFsHaBwSM87zTQ8uG+UJnq
GIGhHbdLYWaH4C9SrJ+p64pZYdm3jaQpwMMMMZHdeg3rPdvHAgUixX13KWBU
J2UYseRDBLcvNfz6gAgQDtTJtdT9edH3h6m4Tyu0AsIw016hfREeNe20uzrX
uyQ6jGGovT2ki9alVN9P5v1k9uYVC0/1mYnFBLR8PI8effQd/zfLiA=3D=3D
=3DKICZ
-----END PGP SIGNATURE-----

--b1_REIuiFuoH5OZfuvp7Bza8Q8k3Msy5LFvSZ9PvfI
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

--b1_REIuiFuoH5OZfuvp7Bza8Q8k3Msy5LFvSZ9PvfI
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkmdP3CT12B/ETbyyIV2GkOspi8A8j1IyqmzP3YOQupW6B9ztAiRO46e1o95Yk=

--b1_REIuiFuoH5OZfuvp7Bza8Q8k3Msy5LFvSZ9PvfI--


