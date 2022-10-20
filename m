Date: Thu, 20 Oct 2022 11:13:59 +0000
From: tincantech <tincantech@...2282...>
Message-ID: <hOhG8Yh9IXDeY0BXWdi5KuJXs7V7ztwMpGSOHL_XdTN6cb4igtiCNQaOrv61xopCO0mNn-kHRRSMdLmwwUbRJQNBZ82W1-ljYnXo6ocihK8=@protonmail.com>
In-Reply-To: <20221020100546.3023025-1-arne@...1227...>
References: <20220921104930.3452270-1-arne@...1227...>
 <20221020100546.3023025-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_bbMUMfAptUUd8S96C3bLUiu4WkcqGPDqYm7fLmouY"
Subject: Re: [Openvpn-devel] [PATCH v5 2/3] Allow setting control channel
 packet size with max-packet-size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_bbMUMfAptUUd8S96C3bLUiu4WkcqGPDqYm7fLmouY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

Plus one more typo.

Sent with Proton Mail secure email.

------- Original Message -------
On Thursday, October 20th, 2022 at 11:05, Arne Schwabe <arne@...1227...> wr=
ote:

<snip>

> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index b94680885..dce6fd01d 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -68,6 +68,19 @@ typedef unsigned long ptr_type;
> /
> #define TLS_CHANNEL_BUF_SIZE 2048
>=20
> +/ TLS control buffer minimum size. This size is not actually inherent to
> + * the OpenVPN protocol. But with our current sending window being 6 and=
 the
> + * receive window being 8 or 12 depending on the OpenVPN version, the bi=
ggest
> + * payload we can send is 6 * min_size. And we need to support to send p=
ayloads
> + * of TLS_CHANNEL_BUF_SIZE. Splitting this into more than
> + * 6 packets (with overhead) would complicate our sending logic a lot mo=
re.
> + * Diving TLS_CHANNEL_BUF_SIZE (2048) by 6 gets us ~342 byte. Allowing f=
or

Diving -> Dividing

> + * ~100 bytes of overhead (in OpenVPN headers + IP headers) and rounding
> + * up to the next "nice" number gives use 512.
> + *
> + * /

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJjUS1fACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ2mxAf/afXklJAMoPqLoelxi8mF7hq97b3Eky6iB+zqiGXhOxBjVOKC
F6BpNk2uxCUkNSU9FPaLDTMurKuGe6p5+YSdHQh13EzZkx/vehBce4/+OWZ5
nInvafaUbtAI0LqHZvcNhjB2LQcci2MUyw6duok1V43LRdYFZ0ohk4/o+HZ7
6vrij4xNLO1BHhc91CKS0Gm9ZierXPHS8vmAc6ssrhhhq8eFetVq58S7dhyQ
ISx8xg20MnqjynmDjpOVgbxKW00+OBTK5NWGLEXd5effQjgdz4qEv5MBoS4V
sNdvCBw4tU/GrZdYlBihcQf2h6tgGJ0DxEu4qiF0Tg1h81rrEHSahw=3D=3D
=3D8tPU
-----END PGP SIGNATURE-----

--b1_bbMUMfAptUUd8S96C3bLUiu4WkcqGPDqYm7fLmouY
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4c0JOQkZ2d1NjY0JDQURPbUhF
blFsTG1PakpSdEpMMmw1M01Md3dGVHk3WG5FcHMzYjFRMFV3V1lGQ3YKTDJvTnAwbnJkR2xLS0RK
cTUwWTA5U1IrVVJZQlFtS21ZM0VtenB5VUlLTS9yZ28xUnl1YkhwTVJIYkRwCjdKcDhMeGtmZkZC
VkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pPKwp6SGk2U1I3
eFR2R1hsYStNUXo2RUVwV25sYkx2ZzJvcnQ5S3NldVZqWXJxdlJNeGNkUDBvOWNaV0o1ZXAKSk5t
Z2VCNk03K09XMDhVMVNzWHRLcnBMUmNJNnlLbVYzOGpoelByMlpnUDlybXJsRXJSLzFpcVFRSFhZ
Cm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpBdExDamlCMGEwbVJW
QUJFQgpBQUhOTnlKMGFXNWpZVzUwWldOb1FIQnliM1J2Ym0xaGFXd3VZMjl0SWlBOGRHbHVZMkZ1
ZEdWamFFQncKY205MGIyNXRZV2xzTG1OdmJUN0N3SDhFRUFFSUFDa0ZBbHZ3U2NjR0N3a0hDQU1D
Q1JCUGw1ejJhNUM0Cm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtDUkJQbDV6MmE1QzRuUUJE
Qi85WlVvOUJPWEpSNjFObQowMm9aLzhhUlhPOU5uVVNGdDZHTE9XY0ROdkFzNElKV01EVkVRZllh
bmIrNDIxUU5kLzVkNkgxaVhGK2kKNExESzBNNmFnQytnc05GSm5qUEdJdHZQdGo3V3lqeW5aUng4
RDQwUFBYaWdmSFl1dzJvUnUwbHIrUDFwCjFxZVVlNE5iY3FJdjhJSXZMejJ6Q2xZWk9OZ0FzUVZj
TkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdAp0SGdZODF3UzFWN3Y4R0RUWmc4b2FQaFhHZmFD
NFRaRkd0WnIvYnliY3Fyc28zNWphUW1DNTR4TWJYcEYKQVVyYzN1R1ZPSCtPZEcvQlcyZ2NZcXB2
VUZCdWtYeENVQllIUDJOZlhoTmZ6R3Q5bkMxdWxOS1llUDE5ClRHbE9vckJNWUlBRUhvR3h2cGJV
WGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1UGkwbgpmeDhhTm9zM2JZcDI0Nk10
ZmFvS0JmVFFBcmQrR1pXK1duRnlKRWlTeUxkejByVXV0eUNBZGY1bGdWSCsKV3ZMdkltaUdyU3J6
VnBNVDJuQ1MwOUxxTDUwUWp6OEE3Z3A1SC9oUXp0WjhpTnlzR0Q5Tk80Nk9uSTc1CjkwZEhmQ3JY
alFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVPRkloQmU5ZUVacWJ4YzhSV2VRdApoYTdp
L0RySlRSTksxYU9BRFFGVnVWMS9BbTVUaEdQV0ZNL1lKVXlUWWhNVzB5ZVBoNDVPYld1UlFaa3MK
bCthT200TDBLR0REWWxtL0ZReC9FTUN1YnZsenkvenhEZEI2bnFGaWgycVpyZnltbmlTT0thakcw
am9UCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFCRUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pF
RStYblBacgprTGlkQWhzTUFBb0pFRStYblBacmtMaWRSZTBIL2o1Q0lGSUF1Y3VhaUVNa0xrTktF
QU81czd4NDdlTnkKR1BmWnNseVkrSGp6R1UwZDA3TWtrR21Wa1BUVnp3cVZ6Tlpibnk3WkF2MXps
VzBVeTB5SHAxQVBweVl0CjhidVVwcFRCcTdkNDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hR
bVBpejJFbGU0dHlpcGJUYXBjeQoremJ5ZnpBTUQxM2NJZFoxM2hUc05QMG9sZ0JoQXFVQVVVWXB4
UmxrQUhlSitEdDNOYnpIUzRLUUs1MzgKTkovbDdiWFNLc0dxb1lxSmVaOFZOQnh3V1dVYnVHNGpq
cmg0M01JUmdVWjVXc1BVWVY2SHgwNTZrTWpiCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxx
MFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZWXViMXBPOApxckN6Ulp4MG9OQT0KPS9EZWEKLS0tLS1F
TkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1_bbMUMfAptUUd8S96C3bLUiu4WkcqGPDqYm7fLmouY
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJjUS1fACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ33Bgf/bEzg
bITUpfnc14o5QYNPRvgP1aIDyIqI/6317sx/Zs3JDEI+PZsBlK9d6/TvrzumBhPWjIf3+2+d2qAu
14e320A/TsPiXKmMGXDye+YkiLB415iCMTLjh0Y6nLCIQqNEoyu6wE1xLy2FehhgeKfcfcFDRD69
SkgJ66cL9YjDKzS4Cb4yySVpqGxSyQVYcw9IFqNQcuW7Ilkc8FDQcJsMJLmvG5fgcgjRgQkpjy8d
/JZO5XBngekQJMSK4hgEbwWqi9c1CX8xDUYW2i6aBIEqHGsXLi66d+rt97c7DSX5Lm3vsJExWUSk
4d59B1F32ycp/vg7sJboOKj57wLDUuL/DA==

--b1_bbMUMfAptUUd8S96C3bLUiu4WkcqGPDqYm7fLmouY--


