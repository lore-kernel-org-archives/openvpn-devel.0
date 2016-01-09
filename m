References: <1452354825-5096-1-git-send-email-iam@...2070...>
	<56913031.8070201@...1147...>
From: ValdikSS <iam@...2070...>
Message-ID: <56913099.4000908@...2070...>
Date: Sat, 9 Jan 2016 19:08:57 +0300
MIME-Version: 1.0
In-Reply-To: <56913031.8070201@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jrwaQcuj0bqmk56O21OFoNeF03BWCcRST"
Subject: Re: [Openvpn-devel] [PATCH] Clarify mssfix documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jrwaQcuj0bqmk56O21OFoNeF03BWCcRST
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

This is applicable to both --mssfix and --fragment options I believe.
Yes, it affects both tun and tap modes.

On 01/09/2016 07:07 PM, Jan Just Keijser wrote:
> Hi,
>
> On 09/01/16 16:53, ValdikSS wrote:
>
> this is a clarification for the --fragment option, right?   and is the 28=
/48 bytes also applicable in TAP mode?
>
> JJK
>



--jrwaQcuj0bqmk56O21OFoNeF03BWCcRST
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWkTCZAAoJEFzXIC7viPdyfbsQAM2c4ba5Xfvz/UsovElVR8K0
06mQKQrLGTlEgfmJfHlujNp0iuS/avLGI5+s4UIGWrxZPM6pumINBDU1cAkRJX2H
3wvv039tFYBqqVmbIohwt5r5S8TgUrSuZwb0jWnxeYedVMMJbU3Dnl/0+baEop0C
9BDHXbqc/hu+c+ed8298TGf4EIqV4Ei3FZg2sKCpD2SrLL80wB9dBmu8HGqNNcml
abwlvVShxR0jwu1DohoHCaBXokvwm2zw2UX/5NFVneUrY67vrsQ1qbj+6L7jJf4c
mRTIEvwf8JoBMp68lUVK9lQFEQAYAg05jojnvghcdCLvdwSHttf4N71oMKMT0cQL
0K8TL+t73IGydMhAA6w6D0kh1eN330rfc8thQWXlNinnIYZYFE2N616tMt4HqjGN
aANF3nOyJObNmQ+4bK8uMKlXKG14xAZOghG2bRbgYrjJc92+zjvoMOrjSe4KjT+D
yhqG2MF97kpP/2J88QvY22raCibuXHIurgq0eWFl33YDt0jgn7pFlu5S6XiuzKxg
58xGJ9Zya19YQUta5sZT5uV41haXRbebyEU4SWjDeAl4iJvtVrvvQBAnmYYruj6Y
YyvqGLFhZWwIKjJ95+OiFRsUq8bJ38K+UzxVVM8iULyo/OmmKqIE5345zx+4KjO0
RGwjR3omWvWtbp2bALwi
=eOY9
-----END PGP SIGNATURE-----

--jrwaQcuj0bqmk56O21OFoNeF03BWCcRST--

