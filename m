Date: Fri, 23 Apr 2021 21:16:24 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <lWKeg7hMQJWx-9HJ5gxCC_45xPEstWOXF7bEyDgQnhS1E03ExZzYKnpLUGyVbc0k0knjJPCtF5A3OEKS9LIPs0BJogJBgAz--IJCPRd0kR4=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_BG1C6KJY9wCU7HPkghmcaPv2Tb7Qzfn1BYVtipo49A"
Subject: [Openvpn-devel] [openvpn-devel] Feature request - Include
 daemon_pid in --tls-crypt-v2-verify env - V2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_BG1C6KJY9wCU7HPkghmcaPv2Tb7Qzfn1BYVtipo49A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

I am requesting that daemon_pid be added to --tls-crypt-v2-verify env.
Version 2

Justification:

With the notable exception of --tls-crypt-v2-verify ..
daemon_pid provides a verified process ID to All scripts. This ensures
that scripts which are intended to pass data along to the following scripts
have an index to which they can link that data.

Example:

An example is presented in Easy-TLS:
https://github.com/TinCanTech/easy-tls

This script passes hardware address from --tls-crypt-v2 key metadata along
to --client-connect, where the pushed client variable IV_HWADDR can be
matched against the fixed hardware address encrypted in the TLS Crypt V2
key metadata.

Security:

There are no known security concerns with regard to including the openvpn
process ID (daemon_pid) in the --tls-crypt-v2-verify environment.

Complexity:

Ongoing support of the required code would be minimal to zero.

Code:

This patch is included for review purposes only.

<git-formatted-patch>
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 7b5016d3..23d93a6c 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -537,6 +537,7 @@ tls_crypt_v2_verify_metadata(const struct tls_wrap_ctx =
*ctx,
=C2=A0=C2=A0=C2=A0=C2=A0 setenv_str(es, "script_type", "tls-crypt-v2-verify=
");
=C2=A0=C2=A0=C2=A0=C2=A0 setenv_str(es, "metadata_type", metadata_type_str);
=C2=A0=C2=A0=C2=A0=C2=A0 setenv_str(es, "metadata_file", tmp_file);
+=C2=A0=C2=A0=C2=A0 setenv_int(es, "daemon_pid", platform_getpid());

=C2=A0=C2=A0=C2=A0=C2=A0 struct argv argv =3D argv_new();
=C2=A0=C2=A0=C2=A0=C2=A0 argv_parse_cmd(&argv, opt->tls_crypt_v2_verify_scr=
ipt);

</git-formatted-patch>

Conclusion:

Due to the OS in use and other environmental factors, the *nix built-in var=
iable PPID
may not always be available. Without including $daemon_pid in the --tls-cry=
pt-v2-verify
environment, openvpn is forcing the user to unnecessarily configure --write=
pid.=C2=A0

The purpose of --writepid is to advertise the openvpn process ID to externa=
l processes
which do not have access to the internals of openvpn. By including daemon_p=
id
in the --tls-crypt-v2-verify environment all processes launched by openvpn =
have access
to this very useful identifier.

Provided there are no genuine reasons to NAK this request, I will send a co=
rrectly
formatted patch.

Addendum:

I know this is something which helps me in the short term and I already hav=
e a working
alternative but I would like you to reconsider your previous decision. In m=
y opinion All
scripts launched by openvpn should have immediate access to daemon_pid.

Thank you for your time and consideration,
R
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJggzkmACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ0nVggAkf9tcCo7onTYoZ4WetX/6uePD2QzEYd8rHYbn1q6R8JvOqMi
JrDIRIYZw06v/r4pyzq8tYUvS+1VBY9cPIm+v3uudOhZ/WUlyGw180u2tA+w
eX+bx/AwA5FC4QGqgJlTEx9G5s0H5Ge2vSd1ChA52VjC5QZeorI/42nZpG2I
Gg7vC0JH9rr9LqAzVNH9YfWff7vNKvXAPdmL9/itf3Eq6uFytGsD77KjZaq7
RESDSO2cOnCyoVyktPhw64d77q6bCgFtl08CVQYJOTwg07cY+ZEWa3wRCEAb
bcDj6eDNDHy8e9iMzie3yrIgZsRDCbGiXCyaLk2abZtpFsqX7rP6jA=3D=3D
=3Dz4PC
-----END PGP SIGNATURE-----

--b1_BG1C6KJY9wCU7HPkghmcaPv2Tb7Qzfn1BYVtipo49A
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

--b1_BG1C6KJY9wCU7HPkghmcaPv2Tb7Qzfn1BYVtipo49A
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

s9OkDgryUUOkWZXp+n/shiJsEvhSBmzpGQDnNkOb6z/rGAWVgY8+SUF540smxdDWmg==

--b1_BG1C6KJY9wCU7HPkghmcaPv2Tb7Qzfn1BYVtipo49A--


