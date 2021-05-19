Date: Wed, 19 May 2021 15:53:21 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <Ci9PhRXBSEAUEcAbEfCQVbMs-Vb1SwgYBKDnQYUTd-j_Wx2upM7IEQD9mF7EIGmQMqh50IqkVKpv08japhQh1Z-eo7cLFG-XB8X2e-Lwi4A=@protonmail.com>
In-Reply-To: <30a502f8-99c0-a8d2-a955-ef56ee325bdb@...515...>
References: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
 <30a502f8-99c0-a8d2-a955-ef56ee325bdb@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_BaqbzhNp2nDQESmwzqTazIRbNse3Rgm7SNEfQCB81k"
Subject: Re: [Openvpn-devel] Summary of the community meeting (19th May 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_BaqbzhNp2nDQESmwzqTazIRbNse3Rgm7SNEfQCB81k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, 19 May 2021 14:31, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> Hi,
>
> Here's the summary of the IRC meeting.
>
> --------------------------------------------
>
> COMMUNITY MEETING
>
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wed 19th May 2021
> Time: 14:00 CET (12:00 UTC)
>
> Planned meeting topics for this meeting were here:
>
> https://community.openvpn.net/openvpn/wiki/Topics-2021-05-19
>
> Your local meeting time is easy to check from services such as
>
> http://www.timeanddate.com/worldclock
>
> SUMMARY
>
> cron2, dazo, d12fk, lev, mattock, ordex, plaisthos and syzzer
> participated in this meeting.
>

>
> -------------------------------------------------------------------------=
---------------------------
>
> Talked about removing --no-replay option. Noted that it was to be
> removed in 2.5, but we backpedaled on that decision and forgot to change
> our documentation. It was also noted that that option changes the wire
> format.
>
> Noted that --cipher none --auth none and --no-replay are quite
> intertwined. Getting rid of these options would be good from security
> perspective, but it was also noted that plain-text OpenVPN tunnels do
> have some advantages over the alternatives like GRE tunnels.
>
> Summarizing the discussion:
>
> 1.  OpenVPN 2.6: reject configs where --no-replay is used without --auth
>     none.
>
> 2.  OpenVPN 2.7: remove --no-replay
> 3.  Add clear warnings to 2.5 and 2.6 about 1) and 2)
>
> Noted that mattock buildbot setup is shaping up nicely. There are a ton
> of workers and code and data are quite well separated. Mattock is now
> working on limiting concurrent builds on the docker host, then moving on
> to t_client tests.
>

WRT --no-replay

There is also --mute-replay-warnings, which you all seem to have over-looke=
d.

Perhaps this message could be changed (crypto.c:338):
            msg(D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s -=
- "
                "see the man page entry for --no-replay and --replay-window=
 for "
                "more info or silence this warning with --mute-replay-warni=
ngs",
                error_prefix, packet_id_net_print(pin, true, gc));

Remove the reference to --no-replay soon.

Just a thought.
R

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgpTRkACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ30bAgAk6bSZLaE73TDgkhlkhX5dTkLe6Lx4zAal1ADnS3tluqXJIlg
IP16FNKbh+ZGahCBh4ICzEJvPwbI12F+hba0QwQpQOUiN0k00yvNxGuPpc8H
q1YmasQvst4cFKJGqESR4gVe2hZx/JQT7ZLisWVPO3Je1roACOx/PNtRWG3F
36/zWFTwY7qqpbHrbfOgYV3/6hdvAArn//ki/Mu1DTPVOLu9v6n947nkcA7n
/WBGY+IUp4heUQoNmNxkbT/SokVmx6bwgvMwpAF04PKWiLwGFcKxKsRHO6yw
/AdxLouR77cRW3Jfu/WjiipXyU+H8LZAfa4UyRA2kQHf+99acRw4/Q=3D=3D
=3D+xci
-----END PGP SIGNATURE-----

--b1_BaqbzhNp2nDQESmwzqTazIRbNse3Rgm7SNEfQCB81k
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

--b1_BaqbzhNp2nDQESmwzqTazIRbNse3Rgm7SNEfQCB81k
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

s4dOkDgryUUOkvGhwl/wdqfXcsXlsUbAVtPx4b4EHhJKVG2ig5kTIeuGLhkPMEAc6Ov87GHKpJLd
e8qsLzZWwtoleA==

--b1_BaqbzhNp2nDQESmwzqTazIRbNse3Rgm7SNEfQCB81k--


