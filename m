Date: Thu, 20 May 2021 23:40:36 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <Q_FILSTaHZUnV1NCqY1vVCDXAPDs1eUkxMbV6SkYXJbQzrQFsTO7UO7MIaxX9GIfouj2lmtXlSCUzq8QT5eI5exS5wXcrqkgwTVel-1DsuQ=@protonmail.com>
In-Reply-To: <svlvLQ3T3oSNr1rFqlk5Qdkx--Ua5k0JYIam1W5RHMC9oArtFtmEqmCgiWtifKt3-7bG5fHC_i-lCm6paJFLJk6ZoIpcRPbOh92oZS1Nbw0=@protonmail.com>
References: <20210520150932.2565217-1-arne@...1227...>
 <20210520150932.2565217-2-arne@...1227...>
 <CNUI9sxE2HOdFvol4LftF6DPWGfmpSUabfpLXMOJQXcFcL_bM-zvF9u3oX68guJWALVYyC13DWKt4-9cVq3c8KjneyoFY32pgNpNYCQmTIM=@protonmail.com>
 <46a3a2a9-83a4-2fbe-2fd4-684a51c001f9@...1227...>
 <nehG6AKTksx4AeryA432f6vVe5OGFQSmkbS2TYGGS6MumnC0d8xRfGsZxR_uXmDN2b8Yfvt6zQX0fwG83sqvWlyuLsdneHWr-3Wz8vDc9Qw=@protonmail.com>
 <624a3ba5-aa78-144b-ff48-17ccd522588c@...1147...>
 <GS6Gxk2plMyW-jt2XyAduO6tjoh4Xn3f3UIHuoEG2ZIM-ufwdPWmJDHe6b5Quj1rEPIcTPlbNp7SRU55HW4zLHjAImAghOIkkRwJ5I8YJ78=@protonmail.com>
 <3c666c26-8949-076b-09ec-49d87f028941@...1147...>
 <svlvLQ3T3oSNr1rFqlk5Qdkx--Ua5k0JYIam1W5RHMC9oArtFtmEqmCgiWtifKt3-7bG5fHC_i-lCm6paJFLJk6ZoIpcRPbOh92oZS1Nbw0=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_N71S6mhNgSGlQNAJhTw2f4dRLeSVFsTcwNQ20gED4mg"
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
To: tincantech <tincantech@...2282...>
Cc: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_N71S6mhNgSGlQNAJhTw2f4dRLeSVFsTcwNQ20gED4mg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

-=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Message =
=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, 20 May 2021 22:35, tincantech via Openvpn-devel <openvpn-devel=
@lists.sourceforge.net> wrote:

> Hi,
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Thursday, 20 May 2021 22:22, Jan Just Keijser janjust@...1147... wrote:
>
> > On 20/05/21 23:12, tincantech wrote:
> >
> > > [...]
> > >
> > > > > So, why switch to .pem when it has never been used before by open=
vpn?
> > > > > If you are all happy to let it go that way then so-be-it,
> > > > > Hopefully this clarifies things:
> > > >
> > > > -   the default output format of OpenSSL is PEM-encoded ; openssl u=
ses the
> > > >     default extension .pem
> > > >
> > > > -   the OpenVPN .crt and .key files are ALSO PEM-encoded by default=
, but
> > > >     they've just been named differently by the easy-rsa tools to en=
sure that
> > > >     the files can be easily loaded on Windows
> > > >
> > > > -   FTR: nearly all webservers I have ever seen are configured to u=
se a
> > > >     hostcert.pem and hostkey.pem and my guess is that there are (st=
ill)
> > > >     more=C2=A0 Linux-based webservers out there than OpenVPN client=
s and servers.
> > > >     Having said that, I do agree that after using .crt/.key files l=
eft and
> > > >     right (to accomodate Windows users) for over 15 years, it does =
seem
> > > >     confusing to start using files named .pem for peer-fingerprinti=
ng all
> > > >     of=C2=A0 sudden. On the other hand, with peer-fingerprinting yo=
u don't
> > > >     HAVE a .crt file (at least, you don't need one, technically) bu=
t only
> > > >     a .key file. So choosing a different extension for peer-fingerp=
rinting
> > > >     does have its merits.
> > > >
>
> > >     FTR: Openvpn still exchanges the full certificates in peer-finger=
print mode.
> > >
>
> > meh ... I guess it was easier to implement it that way at the TLS level=
...
>
> I cannot comment on the code but there is the case of older clients which=
 require
> self-signed server".crt" (Easy-RSA) in place of the CA cert.
>
> > IMO that does add a "+1" to using .crt/.key=C2=A0 extensions - otherwis=
e it
> > might confuse the heck out of end users (like overwriting the private
> > key with the public cert etc ... )
>
> That is another good point.
>
> > How do the examples distinguish between the cert and the private key in
> > this case then?
>
> Generally, the distinction between what is private and what is public
> has not been very well covered. Other than the notable exception of
> "Protect your Private CA key at all costs!"
>
> I have included this Private v Public information in the easy-pfp output.
> Seems like the only way to get things done sometimes is do-it-yourself ;-)
>
> Anyway, all other points aside, the point is that: Changing to .pem (not =
PEM)
> feels like an unnecessary complication.
>

I would like to hammer one final nail into this discussion.

Openvpn option names and inline tags ALL use <cert>ificate .crt and <key> .=
key.

They do not use .pem or PEM and none of the Official online documentation,
to date, references use of a {name}.pem file, other than far-flung cases.

The files generated in this tutorial will all be PEM encoded regardless.

This is why I asked the question of why Openvpn suddenly chooses to change
to a .pem extension and add this unnecessary complication.

Real users may see this as another hurdle which they just don't want to jum=
p.
Do you want to drive them away .. ?

As I am also banned from #openvpn-meeting, so I leave this for you to discu=
ss.

--
Richard
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgpvNyACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1U5wgAza4n5mxniWpvVrkSxRCN3TEc0MEafFb+Eza0uL/l9i5tVDDQ
A4ZwjBuRGgteJzNhbe3Q+YJzZZ1hjf9k9FjPwGtnUK49IZZt8OOe60bfiQt7
aSmhKMRyZzzjRgSv6QNdPWsZEB3JceZ572+EIi5zfQmz6V1q8USsPQPaUZoa
k65YA9Z+pU6xsm1+lKMLGbi8rzIvIhNYCEIZ4pGl5OzckQP7o7JKUanhOoHH
7KrD5Nu5ad4CtgMv72RYWCbmW5vsqIcOrYJIG7mASodCTGkL2JH5F2i8fVUJ
rg5OrvVViLewxTYyGCVc+PZ7ukB6l/bEYd8efA1G4carr6+hRDTfSA=3D=3D
=3DT6wH
-----END PGP SIGNATURE-----

--b1_N71S6mhNgSGlQNAJhTw2f4dRLeSVFsTcwNQ20gED4mg
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

--b1_N71S6mhNgSGlQNAJhTw2f4dRLeSVFsTcwNQ20gED4mg
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

srOkDgryUUOkiTfR4wUmrwgxj/MnXXDnhdBFPU9LeuGxTNXgwUmQzIsHQ23RWxZz3UwxvEY88qf+
ZB4=

--b1_N71S6mhNgSGlQNAJhTw2f4dRLeSVFsTcwNQ20gED4mg--


