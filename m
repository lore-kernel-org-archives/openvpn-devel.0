Date: Thu, 29 Apr 2021 11:00:55 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <xchu0q42Qj4torVxkqthqrJbaijP7iEaieW7VX6hK19_ZXtiysyWyS16_nC2NhrRRsc_xt7yUa0l0T0c-9UzTwPlNc7hcCXRX71dVWK-G4E=@protonmail.com>
In-Reply-To: <xwRKAXnZLS_XIcEqfoQnQMrXF_i5bo3xMuj0Bld0wsYiCjL0G18ZpN1AVzDRZLB4_7__Ftm6vmtj4035phk-vrFS_v7S2KGiRWPUB5YcPfc=@protonmail.com>
References: <faqABVK6MPd-XEqegwOnFrNPTR3Fts0q4aM_qBeygqdHuxVevbtQdjKUlX6VzMp5CxoOpeT_a2pqS4c7oEts2M_6TpGh1vcb7z7sc6BktlM=@protonmail.com>
 <EoiWIHf2Ww_u8MOvuJrlm1i0J7TmzYUtTUxUdEmfBAgiI5YgS8LwIsDXf48EX1Q3Lt-zREdDaBHxDZRQVZPhjDhaMnpWQSqhF_MxjLcfQzs=@protonmail.com>
 <xwRKAXnZLS_XIcEqfoQnQMrXF_i5bo3xMuj0Bld0wsYiCjL0G18ZpN1AVzDRZLB4_7__Ftm6vmtj4035phk-vrFS_v7S2KGiRWPUB5YcPfc=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_LuqDknYc4Pe7eUQm9POPSEIICErLPxpp5NLKU4WaBY"
Subject: Re: [Openvpn-devel] [PATCH] Add daemon_pid to --tls-crypt-v2-verify
 script environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_LuqDknYc4Pe7eUQm9POPSEIICErLPxpp5NLKU4WaBY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Not a single comment ?


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, 28 April 2021 19:03, tincantech <tincantech@...2282...> wrote:

> Looking closer, I can see that it was damaged in transit ..
>
> Please let me know if you would be willing to accept my proposed patch an=
d then I will persist to find a way.
>
> If you will not accept the addition then please let me know.
>
> Thanks
> R
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Wednesday, 28 April 2021 18:48, tincantech via Openvpn-devel openvpn-d=
evel@lists.sourceforge.net wrote:
>
> > Yeah, I forgot to apply and commit -- sorry.
> > I guess I'll send again if this is an acceptable patch and my MTA didn'=
t screw it up ?
> > Please let me know .. thanks
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> > On Wednesday, 28 April 2021 18:44, tincantech tincantech@...2282... wro=
te:
> >
> > > Openvpn process ID (daemon_pid) provides the most secure way for
> > > scripts to verify which process they were called by.
> > > This patch adds daemon_poid to --tls-crypt-v2-verify environment.
> > > Tested on Linux and Windows.
> > > diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
> > > index 7b5016d3..23d93a6c 100644
> > > --- a/src/openvpn/tls_crypt.c
> > > +++ b/src/openvpn/tls_crypt.c
> > > @@ -537,6 +537,7 @@ tls_crypt_v2_verify_metadata(const struct tls_wra=
p_ctx *ctx,
> > > setenv_str(es, "script_type", "tls-crypt-v2-verify");
> > > setenv_str(es, "metadata_type", metadata_type_str);
> > > setenv_str(es, "metadata_file", tmp_file);
> > >
> > > -   setenv_int(es, "daemon_pid", platform_getpid());
> > >     struct argv argv =3D argv_new();
> > >     argv_parse_cmd(&argv, opt->tls_crypt_v2_verify_script);
> > >
> > >
> > > --
> > > git version 2.25.1
> > > I hope my MTA has not mangled this patch but I don't currently have a=
ccess
> > > to an SMTP server port. If it is borken then please ignore this and I=
'll find
> > > another way. Feel free to send other feedback. eg: NAK + Reason.
> > > Thanks
> > > R
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgipHgACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ064ggAifsuMtavQAW7fBTiMjr/587lEwrO7CMFJOEhIexbeJN2tl1G
tbDG5NSIRxM9Vle2rvpybaStga3Fst9Q6Gi7EDIwVFBfSNWjSeogwA30N35f
T0KRWCbveSjiKRsyTS7p9zEv1Dvms0iRX0G+NClsbIJr7Fn7gUtSS2ztvj60
KfXeH1dkv1Q7EJPLC0H7zKcoEagFrYb0bNtG3g7uca5Yb7sEyetA3rKX02Z/
JpqeZN3nZe4Fvx19YOnrc+dZPtKpshws7swg7KQOz07GEEXMXe5BBjgWqQlz
RTcHefU8fLaMklprpLsuOvMnOgVwQ0fwbV22IBAT4g7d5++CxCvBSQ=3D=3D
=3DReR6
-----END PGP SIGNATURE-----

--b1_LuqDknYc4Pe7eUQm9POPSEIICErLPxpp5NLKU4WaBY
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

--b1_LuqDknYc4Pe7eUQm9POPSEIICErLPxpp5NLKU4WaBY
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOk1xuDFvvYl0QcGAo8L8x/u1Nbbm7lG4I3Y0j8P3IfpjY9vstJ/XTK7qHRAjCQVmQUa

--b1_LuqDknYc4Pe7eUQm9POPSEIICErLPxpp5NLKU4WaBY--


