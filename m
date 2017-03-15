References: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
	<20170315152840.GR93896@...1296...>
	<CAFHpkQGKV3pAeTjabYbyP4LwwDqUa7Atuuqh0qyQ95DTdL39dA@...278...>
	<CAKuzo_g-6RXk910xT-g7jjdBnzYm2O0edLPbUO+4srt_nGM1gw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b51294e5-dfb9-20fc-b314-649ce596a8f3@...2080...>
Date: Wed, 15 Mar 2017 22:53:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_g-6RXk910xT-g7jjdBnzYm2O0edLPbUO+4srt_nGM1gw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="30bSldTgbJrVlkbBKOnowJgxsIuHd58Rm"
Subject: Re: [Openvpn-devel] why "ifconfig" is required during build ?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--30bSldTgbJrVlkbBKOnowJgxsIuHd58Rm
Content-Type: multipart/mixed; boundary="9JmDkmrhgDHH4sTKnxVtsJuhW33ARV9oV";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?=
	=?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <b51294e5-dfb9-20fc-b314-649ce596a8f3@...2080...>
Subject: Re: [Openvpn-devel] why "ifconfig" is required during build ?
References: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
	<20170315152840.GR93896@...1296...>
	<CAFHpkQGKV3pAeTjabYbyP4LwwDqUa7Atuuqh0qyQ95DTdL39dA@...278...>
	<CAKuzo_g-6RXk910xT-g7jjdBnzYm2O0edLPbUO+4srt_nGM1gw@...278...>
In-Reply-To: <CAKuzo_g-6RXk910xT-g7jjdBnzYm2O0edLPbUO+4srt_nGM1gw@...278...>

--9JmDkmrhgDHH4sTKnxVtsJuhW33ARV9oV
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/03/17 16:46, Selva Nair wrote:
>=20
> You can set custom path during configure like this:
>=20
> $ IFCONFIG=3D/opt/hacks/bin/ifconfig ./configure

This will work ... but generally this is a bit better:

   $ ./configure IFCONFIG=3D/opt/hacks/bin/ifconfig

The reason is that 'make' might some times decide to re-run autoreconf,
which with the former approach will lead to "forgetting" this
configuration setting.  The latter approach ensures ./configure will
preserve all these settings when it calls itself again.

You can easily spot if autoreconf have been re-run by looking at
config.log ... you'll see '--no-create --no-recursion' in the command
line "copy".


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--9JmDkmrhgDHH4sTKnxVtsJuhW33ARV9oV--

--30bSldTgbJrVlkbBKOnowJgxsIuHd58Rm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYybfiAAoJEIbPlEyWcf3ylq8P/1/CyT2OsLFQrJMWYcBd466w
2vN8OUonnTxNkGrLxOUbah7GDwquoXaeck/wsK/19UxQhuTELzJ4RAMWSYRddEsN
9UGZg/KA0YBTcCvruS7w5aGtEU2efke6D+1oO9S9Q7EzQNnovz4iGbcHyYnjbHTb
Quv1f6UQYI7N2I5CoeReRu6GKPus4R5SuYhZKTsVEcDfwn/adsgS3EY6XCvUArW8
HsdbiruyfQpAYjU47LsImJCsxamUXTa+j04gsySez+gK0x5Sa2GYIvfqYZpHXxkY
rWA/pf0tN5lC3OMuvMYevnNBht4jkd2tjlalSjim4rBYEkveckbFOv+/4rYfIaei
gVVDkt0IQ4eIENyqibN6dx1g5LE+efYka+d4Vhsvuj6JixV8xMfW7arfBrLFWpue
pn/Pg08lctnZahOftmqCaTK0dw4/l4GEbabS3kQFxHE4F37tjD2Fc6adjoGxOyGt
s3IMt9i0yqKMyETh2gDe5UKBM1Y8aYFR6Ke4n31WbW62SgwUEHULfzE7pBUpbh8p
e/Q5joIWpJPAJD/c44CUJGz9ntKHMBF13nnc14koiJwTOhXGIn6bnB2ZK+cRKdAD
FP6WkZnJm3AdJrEDgTIgv8+hJVleT/uWYyQfalpLY/Tbum48KoC9VnmN68scuAiB
kGEXpSLkv4M7gXXlz1f6
=3H2i
-----END PGP SIGNATURE-----

--30bSldTgbJrVlkbBKOnowJgxsIuHd58Rm--

