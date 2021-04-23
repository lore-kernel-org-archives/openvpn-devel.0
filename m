Date: Fri, 23 Apr 2021 13:52:28 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <0gN-ryK9HUp3WxtpmOsmh7f8Vux_cm3v6iH0IQ3Oufl-n-i2yHKfNaXbew25J2g4H5kKlY9maK_dvRQC14jDKdr8kexPBUcuxxBY9kPD-Fo=@protonmail.com>
In-Reply-To: <ca5bff69-078c-5707-70a6-0b65a60243a5@...2181...>
References: <ZIKZwAKGvWmbJ-kO_eJLJtMC987pVCbt6uMCrILdSuhQ6AcV0SVrQMn1r2xab_2K8ncLE47H_VO9gZqAcCSP6HkcFWXOKTuXXqhRXETdFwU=@protonmail.com>
 <77250543-ceda-b412-6ff5-8f5ef5f0b3a3@...2181...>
 <cs3V6YWogR5xlLJlMXU86uQJ9o2kLYY-Wk48M39jut0c_pdxHDdC_D7fBtq-jCG1GyifsKeLwi0T75zJAR0cz55TFC2vVKqXS-4L32EFpT0=@protonmail.com>
 <ca5bff69-078c-5707-70a6-0b65a60243a5@...2181...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_70yXlyB5103XtasJQ8hAYtBymFFNwqTnz51ucAqSacY"
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_70yXlyB5103XtasJQ8hAYtBymFFNwqTnz51ucAqSacY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, 23 April 2021 13:22, Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 23/04/2021 14:16, tincantech wrote:
>
> > Hi,
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> > On Friday, 23 April 2021 08:12, Antonio Quartulli a@...2181... wrote:
> >
> > > Hi,
> >
> > > On 22/04/2021 23:02, tincantech via Openvpn-devel wrote:
> >
> > > > hi,
> > > > I am requesting that $daemon_pid be added to the --tls-crypt-v2-ver=
ify environment.
> >
> > > The environment for --tls-crypt-v2-verify was designed to be extremely
> > > minimal.
> > > Anything concerning tls-crypt verification was designed to be as mini=
mal
> > > as possible.
> >
> > > Indeed, differently from other scripts, the env for tls-crypt-v2 is
> > > created empty and then only a very few variables are added.
> >
> > > Anything that was deemed not necessary for the metadata verification =
was
> > > not passed.
> >
> > I understand your reasoning, however, in the case of daemon_pid would y=
ou not
> > consider the process to be "more secure" if openvpn does provide the PI=
D in
> > the environment, rather than have the script read the PID from a file?
> > Having to configure openvpn to write the PID and then read the PID is t=
wo steps
> > which can introduce user bound misconfiguration errors.
>
> we can't control what the user does with the script - he could do
> anything wrong and ugly, but we can't just implement shortcuts for them, =
no?

No.

This is not a shortcut, this is OpenVPN providing a guaranteed working envi=
ronment.

I am not expecting openvpn to "control" what the user does with the script,=
 I am
asking that ALL scripts have access to daemon_pid as an obvious and benefic=
ial
security precaution.

All scripts ought to have access to daemon_pid for the simple reason of ens=
uring
the scripts run for the same server instance.  Providing daemon_pid to all =
scripts
is the *most secure* way to do this.

There are other reasons to use --writepid, such as for completely external =
processes.


>
> > > I can imagine you have a usecase for daemon_pid, but I am sure more
> > > people will have other arguments for other variables as well. Hence t=
he
> > > idea to design something extremely minimal and leave more complex log=
ics
> > > to following (post-auth) steps.
> >
> > I reviewed all the other variables for inclusion viability and, with the
> > exception of "untrusted_ip / untrusted_ip6", I came to the conclusion t=
hat
> > the only variable which does come with a genuine security bonus is daem=
on_pid.
> > (As outlined in my previous comment)
> > As for untrusted_ip*, it definitely could be useful to --tls-crypt-v2-v=
erify
> > but I'm not asking for that here. Perhaps on reading this other members=
 will
> > see how it can be of benefit to the scripts versatility..
> > (The same goes for untrusted_port but that seems less useful over all)

I notice how you conveniently skipped this entire section ..

> > I would also quote that old, old expression "Security through Obscurity"
> > https://en.wikipedia.org/wiki/Security_through_obscurity
>
> It's not security through obscurity here, but it's about keeping the
> code that leads to the tls-crypt-v2-verify call as minimal as possible.

.. and went straight to this comment.

In my opinion this is security through obscurity.

With holding daemon_pid from any script executed by openvpn is a bad decisi=
on
and in the case of --tls-crypt-v2-verify, with holding ALL other data from =
the
 script is clearly S.T.O.  I can understand the reason to make the env mini=
mal
but this is clearly a case of going too far.  Thus .. as above.


>
> This said, what is deamon-pid useful for in the tls-crypt-v2-verify
> script? Maybe a clear usecase with pro and cons could help understanding
> where this need is coming from.

You are forcing my hand: https://github.com/TinCanTech/easy-tls

I can see absolutely no security benefit to with holding daemon_pid from
--tls-crypt-v2-verify, for the simple reason of the extra hoops a user is f=
orced
to jump through and the security risks they are forced to take in doing so..


As a final comment here, on the one hand openvpn chooses to enforce
cipher-negotiation "because it is more secure and helps unwary users to
configure their vpn correctly".  On the other hand openvpn cannot see
the simple LOGIC of providing daemon_pid to ALL scripts launched by openvpn.


Thanks
R
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJggtEaACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ06IQgAwYd6fAuuT2Z2g1kyeVHF9uPzy73k+bRf2G3EIjSLhG1yb11X
32SPQGaAAXwDTSRN/Onl6pe+h/XWdiBbTo3GTCKJ3f60isMxpezmOsUMSUGo
WQQyKteQw/eWllXk1kxSEmdVW+xG3VxvCFX+HvJmTZgfLXfIk8s7WSYiEZKf
rG0ZgSX8uVUaSO1K+935yFVDzabZHO97mpy74tMtVFhTZKAz+EqaDkGmwsVD
p+M6ZSLxD0+ZD0OlnzHp3hhUvL1NgRcjHrtPyuhAy1Zu+woh1Dbu5YOja3sW
H+y5T0BO1UgqaGLylbc6nbujnokzEOXicNXSutVN2EQ6MqiRS5DkTQ=3D=3D
=3DhZwd
-----END PGP SIGNATURE-----

--b1_70yXlyB5103XtasJQ8hAYtBymFFNwqTnz51ucAqSacY
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

--b1_70yXlyB5103XtasJQ8hAYtBymFFNwqTnz51ucAqSacY
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkZpF8h5OSH7bcFfoplcGwUkWjsqNQmjwWTb2HUswuuxemS+J6FRjGiV6qU

--b1_70yXlyB5103XtasJQ8hAYtBymFFNwqTnz51ucAqSacY--


