Date: Thu, 29 Apr 2021 15:30:02 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <99YBapCXJmmHmv2-QASLJLHdHKs0z9Z_6lFqkYECQLOHtcD5haoAHMICbOF_ool1UFxDjQm39QRFXvVDtfekNHEF0XQf3dukBKeitu_88gA=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_dtx6TzDx5bZnGrycatl1FIDxPNRP9o8TWJG65upjPaU"
Subject: [Openvpn-devel] [PATCH] Add daemon_pid to --tls-crypt-v2-verify
 environment
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

--b1_dtx6TzDx5bZnGrycatl1FIDxPNRP9o8TWJG65upjPaU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Under Windows, programmatically retrieving the parent process ID of
the openvpn instance which called a script is practically impossible.
The only sensible way, currently available, is to write a PID file.

This patch adds a single integer variable, named daemon_pid, to the
script environment. The value of which is set to the openvpn process
ID that called the script.

Providing this variable via the running openvpn process is more secure,
faster and far less prone to user-error than using a PID file.

Signed-off-by: Richard T Bonhomme tincantech@...2282...

src/openvpn/tls_crypt.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 7b5016d3..23d93a6c 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -537,6 +537,7 @@ tls_crypt_v2_verify_metadata(const struct tls_wrap_ctx =
*ctx,
    setenv_str(es, "script_type", "tls-crypt-v2-verify");
    setenv_str(es, "metadata_type", metadata_type_str);
    setenv_str(es, "metadata_file", tmp_file);

-   setenv_int(es, "daemon_pid", platform_getpid());

    struct argv argv =3D argv_new();
    argv_parse_cmd(&argv, opt->tls_crypt_v2_verify_script);


--
2.25.1
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgitDzACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ3tigf9GP21RvAuybG60NgMaC5t9LIyjlBjaNOcWjLgbCUh7KhFSPMu
6r48YAsdy2PB7vd753GhjoQbQuM8+JhS0+fXBIgtToOxMOSGJoSJLu0RoYL3
ScRLXgx2M0p5wbQdHD9tx3ZsVXKyLPTwRWg3w3V7viIJ2A9tmiAUuX4YflJ+
hyfhp1sT648Hb2PW3eIBvEMZNOGG9Et/jS833/Yk5WRn8Wee/nPASOYYbHGf
amX51gbevtmJy67Dti0ibUNomf9uYFd95ojG9qdqJDDQaff76nbda/bRX38g
SUu50B2mNpS/sHeirUAKCpuzmMxqpLl9NOxS4m3SFLk+sfeDgSJRSA=3D=3D
=3D6a1K
-----END PGP SIGNATURE-----

--b1_dtx6TzDx5bZnGrycatl1FIDxPNRP9o8TWJG65upjPaU
Content-Type: text/x-patch; name=0001-Add-daemon_pid-to-tls-crypt-v2-verify-environment.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-Add-daemon_pid-to-tls-crypt-v2-verify-environment.patch

RnJvbSA5MWJhZjkzZTYyZGIyZWQwNjNhOGM0Y2ZkZjViNmZmNzUwYWM2MTAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNoYXJkIFQgQm9uaG9tbWUgPHRpbmNhbnRlY2hAcHJvdG9u
bWFpbC5jb20+CkRhdGU6IFRodSwgMjkgQXByIDIwMjEgMTY6MTc6MDYgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBBZGQgZGFlbW9uX3BpZCB0byAtLXRscy1jcnlwdC12Mi12ZXJpZnkgZW52aXJvbm1l
bnQKClVuZGVyIFdpbmRvd3MsIHByb2dyYW1tYXRpY2FsbHkgcmV0cmlldmluZyB0aGUgcGFyZW50
IHByb2Nlc3MgSUQgb2YKdGhlIG9wZW52cG4gaW5zdGFuY2Ugd2hpY2ggY2FsbGVkIGEgc2NyaXB0
IGlzIHByYWN0aWNhbGx5IGltcG9zc2libGUuClRoZSBvbmx5IHNlbnNpYmxlIHdheSwgY3VycmVu
dGx5IGF2YWlsYWJsZSwgaXMgdG8gd3JpdGUgYSBQSUQgZmlsZS4KClRoaXMgcGF0Y2ggYWRkcyBh
IHNpbmdsZSBpbnRlZ2VyIHZhcmlhYmxlLCBuYW1lZCBkYWVtb25fcGlkLCB0byB0aGUKc2NyaXB0
IGVudmlyb25tZW50LiBUaGUgdmFsdWUgb2Ygd2hpY2ggaXMgc2V0IHRvIHRoZSBvcGVudnBuIHBy
b2Nlc3MKSUQgdGhhdCBjYWxsZWQgdGhlIHNjcmlwdC4KClByb3ZpZGluZyB0aGlzIHZhcmlhYmxl
IHZpYSB0aGUgcnVubmluZyBvcGVudnBuIHByb2Nlc3MgaXMgbW9yZSBzZWN1cmUsCmZhc3RlciBh
bmQgZmFyIGxlc3MgcHJvbmUgdG8gdXNlci1lcnJvciB0aGFuIHVzaW5nIGEgUElEIGZpbGUuCgpT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFQgQm9uaG9tbWUgPHRpbmNhbnRlY2hAcHJvdG9ubWFpbC5j
b20+Ci0tLQogc3JjL29wZW52cG4vdGxzX2NyeXB0LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3Rsc19jcnlwdC5jIGIvc3Jj
L29wZW52cG4vdGxzX2NyeXB0LmMKaW5kZXggN2I1MDE2ZDMuLjIzZDkzYTZjIDEwMDY0NAotLS0g
YS9zcmMvb3BlbnZwbi90bHNfY3J5cHQuYworKysgYi9zcmMvb3BlbnZwbi90bHNfY3J5cHQuYwpA
QCAtNTM3LDYgKzUzNyw3IEBAIHRsc19jcnlwdF92Ml92ZXJpZnlfbWV0YWRhdGEoY29uc3Qgc3Ry
dWN0IHRsc193cmFwX2N0eCAqY3R4LAogICAgIHNldGVudl9zdHIoZXMsICJzY3JpcHRfdHlwZSIs
ICJ0bHMtY3J5cHQtdjItdmVyaWZ5Iik7CiAgICAgc2V0ZW52X3N0cihlcywgIm1ldGFkYXRhX3R5
cGUiLCBtZXRhZGF0YV90eXBlX3N0cik7CiAgICAgc2V0ZW52X3N0cihlcywgIm1ldGFkYXRhX2Zp
bGUiLCB0bXBfZmlsZSk7CisgICAgc2V0ZW52X2ludChlcywgImRhZW1vbl9waWQiLCBwbGF0Zm9y
bV9nZXRwaWQoKSk7CiAKICAgICBzdHJ1Y3QgYXJndiBhcmd2ID0gYXJndl9uZXcoKTsKICAgICBh
cmd2X3BhcnNlX2NtZCgmYXJndiwgb3B0LT50bHNfY3J5cHRfdjJfdmVyaWZ5X3NjcmlwdCk7Ci0t
IAoyLjI1LjEKCg==

--b1_dtx6TzDx5bZnGrycatl1FIDxPNRP9o8TWJG65upjPaU
Content-Type: application/pgp-signature; name=0001-Add-daemon_pid-to-tls-crypt-v2-verify-environment.patch.sig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-Add-daemon_pid-to-tls-crypt-v2-verify-environment.patch.sig

sOkDgryUUOkdofu77LH6PPHmtoV/Ny0QJaoZ/JaUUcXA+XoE5M4eh3Eb7CocU6LjxBmmX5/8

--b1_dtx6TzDx5bZnGrycatl1FIDxPNRP9o8TWJG65upjPaU
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

--b1_dtx6TzDx5bZnGrycatl1FIDxPNRP9o8TWJG65upjPaU
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkmdD79yAS3Ml9SWTy0PA98bcOl+hx1Qj9p7Zc5t2Mg5ihQ41bugtb3fEe7OXxWECQA

--b1_dtx6TzDx5bZnGrycatl1FIDxPNRP9o8TWJG65upjPaU--


