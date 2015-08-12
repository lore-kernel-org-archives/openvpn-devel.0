Message-ID: <55CB0B2C.2090605@...2053...>
Date: Wed, 12 Aug 2015 11:00:28 +0200
From: Markus Grundmann <markus@...2053...>
MIME-Version: 1.0
References: <55CA09E0.3020503@...2052...>	<20150811191949.GJ382@...1296...>
	<55CB0817.4010503@...2052...>
In-Reply-To: <55CB0817.4010503@...2052...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8ROIonsbB5Ke6V8qqCtIrDVHu1WTdmesC"
Subject: Re: [Openvpn-devel] SRV record support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8ROIonsbB5Ke6V8qqCtIrDVHu1WTdmesC
Content-Type: multipart/mixed; boundary="------------090000050302000608030504"

This is a multi-part message in MIME format.
--------------090000050302000608030504
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm not a OpenVPN developer but the support of SRV records is a good
idea. A client configuration works without a predefined VPN server and
port and whenever you move your VPN server to another location or
network. Only a domain must defined that contain the right service
record. I think it sound's very good or?!

-Markus

On 12.08.2015 10:47, Gergely Czuczy wrote:
> On 2015-08-11 21:19, Gert Doering wrote:
>> Hi,
>>
>> On Tue, Aug 11, 2015 at 04:42:40PM +0200, Gergely Czuczy wrote:
>>> I would like to ask some help, I'm looking at the OpenVPN source tree
>>> from GitHub as I would like to see how much effort would it be me to add
>>> SRV record support, as it has increasing demand these days (and really
>>> makes sense, especially for enterprises).
>> Can you elaborate a bit more on why SRV makes sense?  To my naive thinki=
ng,
>> the amount of stuff you have to put into the client profile anyway is
>> so large (like CA cert etc) that the remaining gain is fairly small...
> Sure thing. With a buzzwordish approach, I would say it enables more=20
> enterprise-level configurations,
> regarding redundancy, connection optimization and such things.
> Technically speaking, with SRV records you are able to centrally manage=20
> a set of servers where your clients
> will be connecting to, including the order in which the clients should=20
>
>
> --=20
>
> Best regards,
> Markus
>
> PGP-Key: http://freebsduser.eu/allgemein/pgp-public-key/
> PGP-Fingerprint: 949F 0510 E0C3 3B95 27A8  2EA2 38D9 56DE 2BA3 A0BA

--------------090000050302000608030504
Content-Type: application/pgp-keys;
 name="0x2BA3A0BA.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x2BA3A0BA.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.22 (GNU/Linux)

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3D
=3DGmFi
-----END PGP PUBLIC KEY BLOCK-----

--------------090000050302000608030504--

--8ROIonsbB5Ke6V8qqCtIrDVHu1WTdmesC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVywswAAoJEDjZVt4ro6C6uKgP/1jg0HaCT7gLG8nOqAz90EQV
pAqYdr8l2nw6+kc46BW/r+/nzrD4lZ5oEcrjYjyefm/mWjuOvbdKy3Y79x3HJFvR
pTeTjtOGru5eVv/vwbJq59oox4EYQKYi/fWtcOmAEiLFgyAwAPSRfR72g7rpMond
bVdZPyK/2KES9Gpo0jSp+qDYy+VfI0bNJkAAEREiRVmRD687rBBkX6nMcQH770XR
OAGH3vZPyfrmfWguiszMESseEaI0LqmjBMVgiR5Ej/JLhnthwqMgX+V/a413nqcm
uEySaMWtGaKVsxgeu2HA8+sjnevrcdaU8qdsjEEqHMnpi3tU4rBQEz/448HQl3Ql
ywFDe27O17fmd7vmJMF7ZgkQQhK5EkIIwnR69WxLoGH/ZNi2iKyE7T91TzmXyTH3
UodUEfLe28AFNZZ8eOOxuNGQBGMkR7Em0oAgk+1+KC5xZIFslL2D8iVFU+TWbgIO
ZoeVRZcrlzv5vbeiyIlgT4/9SmhHnf5X1ew9qh8XPqNiisX0ASaoa2o2d3qujzoq
cf12hG8YwQ9YAmM8Z6jKO4XK/Lwkk96EClZUZQwz9dxLiQRujBKLRxSX4uTF9vsG
XkW4X6GB24M4j+tgf+opr90LFux/08jLLKulasw1Qab7eerovv3OhNaiNIYO3XUO
NUWPrZYnO2OnddjmgdNN
=Mf6b
-----END PGP SIGNATURE-----

--8ROIonsbB5Ke6V8qqCtIrDVHu1WTdmesC--

