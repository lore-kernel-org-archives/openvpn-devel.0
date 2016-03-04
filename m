References: <56D8A6C4.5080803@...2070...> <56D97EFA.9010207@...1147...>
From: ValdikSS <iam@...2070...>
Message-ID: <56D9A3C9.6040601@...2070...>
Date: Fri, 4 Mar 2016 18:03:37 +0300
MIME-Version: 1.0
In-Reply-To: <56D97EFA.9010207@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="04Rd0GRWXH9Idd5kq3rMvMvC7Gr0XWEwW"
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, ValdikSS <iam@...2070...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--04Rd0GRWXH9Idd5kq3rMvMvC7Gr0XWEwW
Content-Type: multipart/mixed; boundary="nTaUHm8ASB1bvm2FqUbMUFVHtPF0IBOlv"
From: ValdikSS <iam@...2070...>
To: Jan Just Keijser <janjust@...1147...>, ValdikSS <iam@...2070...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <56D9A3C9.6040601@...2070...>
Subject: Re: Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...> <56D97EFA.9010207@...1147...>
In-Reply-To: <56D97EFA.9010207@...1147...>

--nTaUHm8ASB1bvm2FqUbMUFVHtPF0IBOlv
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/04/2016 03:26 PM, Jan Just Keijser wrote:
> Hi,
>
> On 03/03/16 22:04, ValdikSS wrote:
> it's possible to send a stacked CA certificate (i.e. server certificate=20
> and intermediate CA cert) from server to the client. We use this in=20
> production, and it is done by simply stacking (cat'ing) the server cert=20
> and intermediary CA cert file into a single pem file. The intermediary=20
> CA is verified using the client-side ca.crt file and the server cert is=20
> signed by the intermediary CA.
> I'm not sure what would happen if you stick two CA certs into the file,=20
> however.
> If this does not work: when looking thru the openssl s_server code I see=
=20
> a -dcert option which does something similar - looks like it would be=20
> trivial to add to OpenVPN.

This option is for supplying additional server certificate with a key file =
(i.e. if you want to use RSA and ECDSA keys), not for chains. Actually, ope=
nssl's
s_server doesn't support pushing chains also.

>
> JM2CW,
>
> JJK
>
>
> -------------------------------------------------------------------------=
-----
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=3D272487151&iu=3D/4140



--nTaUHm8ASB1bvm2FqUbMUFVHtPF0IBOlv--

--04Rd0GRWXH9Idd5kq3rMvMvC7Gr0XWEwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJW2aPJAAoJEFzXIC7viPdy2KYP/38BObOxA0iiupIJRHpVkJTn
VS3JA1xXbXQgbctxE9ILnP7Ko2Byji2jx5PXvIKdeXX5X+OYE8BylX33s9ztg419
3zI7xdQiOD3h+kFOm5pji+YbwRqlttukWR/mAcLbZMl6VQlLUsffacBfZYmsoGfH
3ihybFAmXMY4abKTdDRWO4L0IfqS97qv4dvwhNXsRyWMt8kiNSAymRi4AcAaUGAc
Q480B6Xe8L1+UeE0m0SZMtF+akpSXCNm9vyjpsKlnfhqjb6yznrdDv688ePFZTZV
SpU5tLlOT3rwII4D9MWbXSY3QfsmXeq4yYMwe+OqbsCP0SQIw9OYJfxSN/IUtJz3
KImmKucbZedrAcXflPN5UqtSa/q9he89m99L7y/Ox3X8ZFiyAvbTjGJe+PNgAsm3
+UsQk9tN0KxRl3Yzdmr+iRQqFa/GSwxo2kMLUDOA9v/NL578ZZGyWgS6nFjPe+JW
wDAMT7JML45bVmyV5mO2MHUcHSiOtiQKPt7RJ94Favza6jhLV3m37MVQaKNyPR+I
NHrJ/UYI90TKYTjAMPUuf4H9rpvA0cZa67HPU71LSUDRDAg9i+PM0Sbm6VG3YPQ/
w4Sileo0zP5hZrBuJ7aOe4DTxSHJbB4PhLOrk+6y8uQ+4cbkfAEu0nWzFzePOS9x
wj/LpaMz1RwG6CjnvOfT
=MBSV
-----END PGP SIGNATURE-----

--04Rd0GRWXH9Idd5kq3rMvMvC7Gr0XWEwW--

