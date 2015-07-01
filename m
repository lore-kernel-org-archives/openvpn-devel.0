Message-ID: <55942AFD.5010407@...1114...>
Date: Wed, 01 Jul 2015 20:01:33 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <99A30EB899EB448B846248EC2E9A353A@...1853...>
	<5593EBF6.4060203@...1114...>
	<1896EA4F53C84141B287C36403D7DE21@...1853...>
In-Reply-To: <1896EA4F53C84141B287C36403D7DE21@...1853...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="njkIAm97B58slXKvhddBoKkUTQRNwMC5I"
Subject: Re: [Openvpn-devel] OpenVPN 2.3.7-I602-x86_64.exe download 404 Error
Reply-To: openvpn-users@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t@...277...
Cc: openvpn-devel@lists.sourceforge.net, =?windows-1252?Q?Samuli_Sepp=E4?=

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--njkIAm97B58slXKvhddBoKkUTQRNwMC5I
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 01/07/15 16:05, debbie10t@...277... wrote:
>=20
> ----- Original Message ----- From: "David Sommerseth"
> <openvpn.list@...1114...>
> To: <debbie10t@...277...>; <openvpn-devel@lists.sourceforge.net>
> Cc: "Gert Doering" <gert@...1296...>
> Sent: Wednesday, July 01, 2015 2:32 PM
> Subject: Re: OpenVPN 2.3.7-I602-x86_64.exe download 404 Error
>=20
>>
>> I have no issues ... try this service and see:
>> <http://downforeveryoneorjustme.com/swupdate.openvpn.org>;
>> <http://downforeveryoneorjustme.com/forums.openvpn.net>;
>>
>>
>> --=20
>> kind regards,
>>
>> David Sommerseth
>=20
> downforeveryoneorjustme.com is not sufficiently fine grained for testing
> as ..
> it does not test HTTPS:// and
> The *only* link which appears to be broken is
>=20
>   - OpenVPN 2.3.7-I602-x86_64.exe
>=20=20
> https://swupdate.openvpn.org/community/releases/openvpn-install-2.3.7-I60=
2-x86_64.exe
>=20
>=20
> Tried from various PC at various sites:

I've done quite some testing ... and there are definitely issues on
here.  But I also noticed you use the wrong URL!  Try using


<https://swupdate.openvpn.net/community/releases/openvpn-install-2.3.7-I602=
-x86_64.exe>

That is .NET instead of .ORG.

Having that said, there are issues with the SSL setup on some kind of
CDN for the openvpn.net domain.  For openvpn.org it is even worse.
Samuli:  You need to check up what kind of crap your CDN does on th
SSL/TLS setup.


--=20
kind regards,

David Sommerseth


--njkIAm97B58slXKvhddBoKkUTQRNwMC5I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWUKv0ACgkQDC186MBRfrp+fwCeJ1khonJaGBTHyQ1RkLMnqwLX
U30AoIC2vm6OKG5QkbAPIJihtNlxU9sT
=L3St
-----END PGP SIGNATURE-----

--njkIAm97B58slXKvhddBoKkUTQRNwMC5I--

