References: <745143357771014FBD32EE04E1307B435E901E6F@...2271...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6544ef6d-adee-030f-a252-7e3db161eae0@...2080...>
Date: Sat, 20 May 2017 00:56:10 +0200
MIME-Version: 1.0
In-Reply-To: <745143357771014FBD32EE04E1307B435E901E6F@...2271...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="keVoIAC54PoEjemkfEM1vRG2OIqDHa5bF"
Subject: Re: [Openvpn-devel] Question about easy-rsa
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Mahawar, Sunil" <sunil.mahawar@...753...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--keVoIAC54PoEjemkfEM1vRG2OIqDHa5bF
Content-Type: multipart/mixed; boundary="0hgUNEfnMvROI5I94Qp84jXw7rdfxpoGV";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "Mahawar, Sunil" <sunil.mahawar@...753...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <6544ef6d-adee-030f-a252-7e3db161eae0@...2080...>
Subject: Re: [Openvpn-devel] Question about easy-rsa
References: <745143357771014FBD32EE04E1307B435E901E6F@...2271...>
In-Reply-To: <745143357771014FBD32EE04E1307B435E901E6F@...2271...>

--0hgUNEfnMvROI5I94Qp84jXw7rdfxpoGV
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 20/05/17 00:45, Mahawar, Sunil wrote:
> Hi,
>=20
>      I loved easy-rsa tool and its user friendly interface. I am using
> this tool for one of my project for OpenHPC (http://openhpc.community ).
> However one my colleague pointed out that easy-rsa project is not an
> active project, its last release was 2 year back, last commit was June
> 2016, and there are multiple open issues on git hub (40), which are not
> yet addressed. So there was concern that any security related
> vulnerability (if found) will not be fixed in timely manner. Because of
> that I was asked to reevaluate easy-rsa utility for my use.
>=20
> As per the documentation, easy-rsa development co-exists with OpenVPN, I
> am assuming that openvpn community will take care of any vulnerability
> in easy-rsa (if found). I will appreciate if someone on community
> confirm my assumption that openvpn community will also be maintain
> easy-rsa any vulnerability in this utility?
>=20

It might not look so active, but there are people who are engaged and
who I am quite sure will step up if it is truly needed to act upon any
security issues.

The upstream project is hosted here:
<https://github.com/OpenVPN/easy-rsa>

That said, there are not too much security issues easy-rsa itself may
introduce.  It is basically just a shell script providing a more easy
user interface to the openssl command line.  So as long as your OpenSSL
installation is safe and good, there is not too much this tool can do to
reduce that.

The primary thing in easy-rsa influencing the security is the OpenSSL
configuration file (openssl-1.0.cnf), and the secondary is how the
various openssl command line calls is handled.  Except of that, it is a
fairly simple program logic and lots of somewhat more helpful text.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--0hgUNEfnMvROI5I94Qp84jXw7rdfxpoGV--

--keVoIAC54PoEjemkfEM1vRG2OIqDHa5bF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZH3gKAAoJEIbPlEyWcf3ynhUP/1y6eUtpzKtRItfR7rNnWkDE
9iTrHFsi7kpkaEIKeEpV3XUC2iRae4JEjGTF0snK2uSzeqd5p6ewdlvx1yRpZTv2
zLNm34Pruaoimv0gxu5VCJusDmg1/BCFG31ZUsIEp9IqZYPGCz7I3+G6e8cyEQZ3
UiVCv6lGVgtoph4+Kckp+8+6sKaJKU31j9f+5jt0FLjIaeNXyIkUM32oiCEhCUME
e8xNfhLgsTDWOzXzT7thFR06LfuBPkPhb/7HlXnbWl4eDzi3opQRmdjbMgCXh4x5
/1Ok7S6qSjIHMreEtOLX1pclFEcQCHA8qvggd27blRiM6pVJr0h+m1Doxro8NY1w
aNiBCTDXgVZhIi3MTqq5M4BQHViFdHEi8QhNjpSQCtE9zMXdu3nW3r0gZXrHHzx3
1dnMCMjpsqt0RPXrU/EWKfgiN++LQuBoHhFwrJEFIHQnmlnFphg/6T6M6Ls4/BiA
ZPfvPk+4ZGegJBgap2ouEEJmpqf5my70E12Qct0tSJdMPwKTTw44SL/ZB3mc26KC
t2wVXtYGIAZAedlbePv8Dsb4EMmbA6hI4844HGTvsk2V3gMujTirM2Uke5Q87nMs
gmPDPjUSc+srPFwyZ7M7H31rrvWbUS+S6j5IrpavQYOU2zLWznRrJoGER5yNP7l0
9ajqONC1U5pXYFwCKpI3
=a4yV
-----END PGP SIGNATURE-----

--keVoIAC54PoEjemkfEM1vRG2OIqDHa5bF--

