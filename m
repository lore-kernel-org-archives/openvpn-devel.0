References: <56B0ECA6.3000902@...515...>
	<CAKuzo_grryDNAqf1vSoMJUrGVYnZEg_S-GHuZARazjnP5YVsFg@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <56B32D16.9010005@...2070...>
Date: Thu, 4 Feb 2016 13:51:02 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_grryDNAqf1vSoMJUrGVYnZEg_S-GHuZARazjnP5YVsFg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0gjiq2euM0P5Rmnws7qvekiTQ1sKniJar"
Subject: Re: [Openvpn-devel] Test installers with the Interactive service /
 Vista-compatible block-outside-dns
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: ValdikSS ValdikSS <iam@...2070...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0gjiq2euM0P5Rmnws7qvekiTQ1sKniJar
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

It's not for DNS resolution (although it should work if "DNS Client" servic=
e is disabled), it's not to break OpenVPN servers on TCP/UDP port 53.

On 02/04/2016 06:05 AM, Selva Nair wrote:
> Hi,
>
>
> I tested this on Windows 10. While it works same as before as far as bloc=
king dns is concerned, the filter that allows openvpn.exe to do name resolu=
tion
> through all interfaces does not appear to work.
>
> When a openvpn connection is running with block-outside-dns and no DNS se=
rver is defined on the TAP adapter, all dns queries fail as expected. But s=
tarting a
> second openvpn.exe also fails at name resolution although the apparent pu=
rpose of the permit filter is to allow that traffic through the LAN or any =
other
> interface
> Valdikss: Is this filter useful at all? When openvpn does name resolution=
, I suppose its the dns client service that would open the port 53 connecti=
on.
>
> Selva
>
>



--0gjiq2euM0P5Rmnws7qvekiTQ1sKniJar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWsy0WAAoJEFzXIC7viPdy0aAP/iIYKJKf6VVBjtkoubTado9U
28Ehs7xmdVaOprpG54QGxGfS96LCvgjoNZ1IYaQ59uBtDzWTiOhZ9rObrWXf2Q58
J5rqec6PpOgCHNNBmFYCs6z9273cyBG3nzysXbb2fHBlYzWZnVUhMc89jK+v4nHJ
n5hL+cZ5yI4Cs749gRNsX9POjbE2GR/frTc2JxTkYL6pVPiEfj+1Tx5Ugj+sEawY
3Jp3Xh6nFLHZLclUKy2tF8jugcI3Frxx7V5oV9YuO21Tv9c0Qvc3obE9VZDKpzgu
y+itUd4+c6auP8u2+HtIumTljg17uTwkRioC39/XSRQHY+OLTU+UtQsLH5SUmUWf
0R04ab6GpHQ+X1WeMLONA+hCA1XeN/ds13wA1tQwcy8urkt1qX4YrFok7ryD5HNW
EjOpLIiV1ux9MyHfxBCQ5QIL4uYh5TtSBX/0UOXtSs8bvjxMPurVMOhaF20TyPt6
I1ECsjUeGDE8H/WzyqO8fVRyhJkUnl6pBaUSsKWOdzKanZrqhFJVDq1WIurp0MRB
k3oFHwmXkbBEU7WlDTsSirX0UGJbnndOr2TfAVvaMUiyT9dgT4haWbLmBeMMiVVV
Z5ZTN4D0fFFOjfXDUIqEwXUQNaURxmTV18fAC5wdsCphDUzHLy6P767hMdqnGhHF
ppsHIAGPlujmYGOHh7c9
=MqTK
-----END PGP SIGNATURE-----

--0gjiq2euM0P5Rmnws7qvekiTQ1sKniJar--

