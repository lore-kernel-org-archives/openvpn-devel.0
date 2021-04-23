Date: Fri, 23 Apr 2021 12:16:24 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <cs3V6YWogR5xlLJlMXU86uQJ9o2kLYY-Wk48M39jut0c_pdxHDdC_D7fBtq-jCG1GyifsKeLwi0T75zJAR0cz55TFC2vVKqXS-4L32EFpT0=@protonmail.com>
In-Reply-To: <77250543-ceda-b412-6ff5-8f5ef5f0b3a3@...2181...>
References: <ZIKZwAKGvWmbJ-kO_eJLJtMC987pVCbt6uMCrILdSuhQ6AcV0SVrQMn1r2xab_2K8ncLE47H_VO9gZqAcCSP6HkcFWXOKTuXXqhRXETdFwU=@protonmail.com>
 <77250543-ceda-b412-6ff5-8f5ef5f0b3a3@...2181...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_rnDFTi2vBKWmTbesUO1Pmm5x3QGJibjdaxSRYk0QU"
Subject: Re: [Openvpn-devel] --tls-crypt-v2-verify env $daemon_pid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: tincantech <tincantech@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_rnDFTi2vBKWmTbesUO1Pmm5x3QGJibjdaxSRYk0QU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, 23 April 2021 08:12, Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 22/04/2021 23:02, tincantech via Openvpn-devel wrote:
>
> > hi,
> > I am requesting that $daemon_pid be added to the --tls-crypt-v2-verify =
environment.
>
> The environment for --tls-crypt-v2-verify was designed to be extremely
> minimal.
> Anything concerning tls-crypt verification was designed to be as minimal
> as possible.
>
> Indeed, differently from other scripts, the env for tls-crypt-v2 is
> created empty and then only a very few variables are added.
>
> Anything that was deemed not necessary for the metadata verification was
> not passed.

I understand your reasoning, however, in the case of daemon_pid would you n=
ot
consider the process to be "more secure" if openvpn *does* provide the PID =
in
the environment, rather than have the script read the PID from a file?

Having to configure openvpn to write the PID and then read the PID is two s=
teps
which can introduce user bound misconfiguration errors.


>
> I can imagine you have a usecase for daemon_pid, but I am sure more
> people will have other arguments for other variables as well. Hence the
> idea to design something extremely minimal and leave more complex logics
> to following (post-auth) steps.

I reviewed all the other variables for inclusion viability and, with the
exception of "untrusted_ip / untrusted_ip6", I came to the conclusion that
the *only* variable which does come with a genuine security bonus is daemon=
_pid.
(As outlined in my previous comment)

As for untrusted_ip*, it definitely could be useful to --tls-crypt-v2-verify
but I'm not asking for that here.  Perhaps on reading this other members wi=
ll
see how it can be of benefit to the scripts versatility..
(The same goes for untrusted_port but that seems less useful over all)

I would also quote that old, old expression "Security through Obscurity"
https://en.wikipedia.org/wiki/Security_through_obscurity

>
> > FTR: $daemon_pid is currently undocumented in all three manuals.
>
> It'd be nice to have such documentation added :-)

I hope that your not suggesting that I provide documentation for something
which you then refuse to allow me to use ? ;-)

Not only but also, "you give a little, you get a little" :D

In conclusion, I request that OpenVPN review their earlier decision to be so
*cruelly frugal* to --tls-crypt-v2-verify, on this one occasion.

Thanks for your informed and collective consideration,
R
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJggrqWACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1ZWwgAkgKYkbfa04CCrqu2pVYxYnt4bcRCvMV7qI8RM37PliG8b2Bx
6qDPMUAZ1DwIL59WKYahtKOIVcp5gLXLoAlrfJy+FMRfJodnGT3iPz3no+Ew
HWTsiwTXjUozGnD3fIviVfzbcXIb082WRzKP1/IpAtTztnBv6Aq6i5vLb/mJ
Ghh/YJIDsaV012dz8qLX9oVbmd8SycfyhKa8E1IwlpkbHsJlqUYo/rxOeXTY
1q4J07aNk1bwPAQU0bWbxf04ItLqeAnoWESnaTc6gWz4fXaRM3XiMuUDFzFl
6FFRQeGkrJAdY2N/ZdAwcNSY3PDkFmu5MPBoaw6lmeBMMoFxG4S/kg=3D=3D
=3DZBp4
-----END PGP SIGNATURE-----

--b1_rnDFTi2vBKWmTbesUO1Pmm5x3QGJibjdaxSRYk0QU
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

--b1_rnDFTi2vBKWmTbesUO1Pmm5x3QGJibjdaxSRYk0QU
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkwDQCOiNWYEPvviBEtM96t9fU3LDud2Wd0FaTj9TBtKi++HFGD7TES

--b1_rnDFTi2vBKWmTbesUO1Pmm5x3QGJibjdaxSRYk0QU--


