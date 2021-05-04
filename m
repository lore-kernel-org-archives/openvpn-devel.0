Date: Tue, 04 May 2021 19:02:28 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <bQOH-0cnboEmpBYrhY8ZinjYni78M4fWH3z1_kKRQNVOA-LQOIomBj2wYz4yO1UfbHgSo5X__CZ_bC8sLGOs1USG_s0yXzJRgFbvVHfkTGs=@protonmail.com>
In-Reply-To: <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
References: <20210429171504.1081888-1-tincantech@...2282...>
 <0a188829-5a2c-362c-eb6f-61ffe657042d@...1227...>
 <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_O8kJyJA427LBXYFs5DeApK5dTrRFDsJ1OmnfMpFfKCE"
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
To: tincantech <tincantech@...2282...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_O8kJyJA427LBXYFs5DeApK5dTrRFDsJ1OmnfMpFfKCE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, 4 May 2021 13:43, tincantech via Openvpn-devel <openvpn-devel@...465...=
ists.sourceforge.net> wrote:

> Hi,
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Tuesday, 4 May 2021 11:50, Arne Schwabe arne@...1227... wrote:
>
> > Am 29.04.21 um 19:15 schrieb Richard T Bonhomme:
> >
> > > From: string vest stringvest88@...277...
> > > Under Windows, programmatically retrieving the parent process ID of
> > > the openvpn instance which called a script is practically impossible.
> > > The only sensible way, currently available, is to write a PID file.
> > > This patch adds a single integer variable, named daemon_pid, to the
> > > script environment. The value of which is set to the openvpn process
> > > ID that called the script.
> > > Providing this variable via the running openvpn process is more secur=
e,
> > > faster and far less prone to user-error than using a PID file.
> >
> > Could you explain why you need the process ID of the daemon? I am trying
> > to figure out why that is needed. I also don't understand the secure in
> > this context. What are you protecting yourself against? You are not
> > protecting your script being called from a malicious program as that
> > could lookup the PID of openvpn and just set the daemon_id variable.
>
> The reason I am using the process ID is as follows:
>
> When --tls-crypt-v2-verify is executed, it saves a file named:
> $(certificate_serial_number}.${daemon_pid}
> with data from the TLS-Crypt-V2 key metadata field, which can then
> be read by the following scripts: --tls-verify and --client-connect.
>
> The --tls-verify and --client-connect script have:
> $(certificate_serial_number} -> ${tls_serial_hex_0} and ${daemon_pid},
> in their environment and can guarantee to pick-up the correct data file.
>
> This is OK for one running server but when there are more than one server
> instance running, using a PID file becomes messy and cumbersome.
>
> The "secure" in this sense is that, having openvpn provide the PID is much
> more reliable than relying on multiple PID files.
>
> Also, while it is "trivial" for *nix to retrieve the Parent PID, under
> Windows, programmatically doing this is not "trivial" at all:
>
> PID:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/findin=
g-the-process-id
> PPID:
> https://stackoverflow.com/questions/7486717/finding-parent-process-id-on-=
windows
>
> Therefore, barring any known security reasons for not providing the openv=
pn PID
> to all scripts which it executes, it makes more sense to have openvpn pro=
vide
> daemon_pid. The only script currently missing this data is --tls-crypt-v2=
-verify
> (And probably --learn-address but I have not tested that).
>

Due to the inordinate resistance this patch has received, consider this my =
official
withdrawal.  I hereby NACK.

Thanks
R

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgkZoxACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1HTQf7BSnvVR9LHZTcPyn+1oHv71TOxIMuFqckmxmQk/PZDSU+yq0h
OdjDWjSLLW/ZbQwS3Zcs09h50GEWBtUM5xoghAsBtUpGLCDMtvbU37JI/mMu
IfSI04+afMqi3xSsu1N4NMlAhVJTg2u0wfB6i46/Ltf/gLr9a0w3IAR7z1l4
Ykaxl5pBkNTZjuT6AtSVuVv8VUmr5+xQGWaUAxfPLIHeNeZGfCR7iJWd2L6L
zcnM8j3lLfzz1Tx2Ry3asVU40G6kp826F2LvuBH2mSZQeFENR/74HtAG0yY9
GcZg17oMkgBUmOZJzYupgrRwU1LFRGUIgk9ygS3Ew96M13C4lV90Sw=3D=3D
=3D9B+C
-----END PGP SIGNATURE-----

--b1_O8kJyJA427LBXYFs5DeApK5dTrRFDsJ1OmnfMpFfKCE
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

--b1_O8kJyJA427LBXYFs5DeApK5dTrRFDsJ1OmnfMpFfKCE
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

s1OkDgryUUOkE1CtX2ZJa4lgvRSKtRyVAxl4o+X7AtW1dIJRXFln2Q==

--b1_O8kJyJA427LBXYFs5DeApK5dTrRFDsJ1OmnfMpFfKCE--


