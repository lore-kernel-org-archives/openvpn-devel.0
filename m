References: <20170102141723.mtgdfznx5rcsdurs@...30...>
	<20170102142646.GL78624@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <1fe64726-57a5-0496-5e40-67b80d8e9b3b@...1435...>
Date: Mon, 2 Jan 2017 15:37:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170102142646.GL78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oChSfjOUC7KLB1fkm3iXQG1b8PJj2mQus"
Subject: Re: [Openvpn-devel] 2.4 sees all client certificates as expired
 when using crl-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--oChSfjOUC7KLB1fkm3iXQG1b8PJj2mQus
Content-Type: multipart/mixed; boundary="opPx8UMKbOauWo53oFii5bstsAqgbABs6";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <1fe64726-57a5-0496-5e40-67b80d8e9b3b@...1435...>
Subject: Re: [Openvpn-devel] 2.4 sees all client certificates as expired when
	using crl-verify
References: <20170102141723.mtgdfznx5rcsdurs@...30...>
	<20170102142646.GL78624@...1296...>
In-Reply-To: <20170102142646.GL78624@...1296...>

--opPx8UMKbOauWo53oFii5bstsAqgbABs6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 02-01-17 15:26, Gert Doering wrote:
> On Mon, Jan 02, 2017 at 03:17:23PM +0100, Alberto Gonzalez Iniesta wrote:
>> I just got this [1] bug report on OpenVPN 2.4 threating all certs as
>> expired when upgrading from 2.3. I find this quite weird, but until I ha=
ve
>> some time to test it I thought asking here would be faster.
>=20
> From the bug report:
>=20
> Mon Jan  2 07:37:10 2017 us=3D466023 1.2.3.4:36241 VERIFY ERROR: depth=3D=
0, error=3DCRL has expired: C=3DXX, ST=3DXX, L=3DXXX, O=3DNone, CN=3Dmycn, =
emailAddress=3Dmy@...2228...
>=20
> "what the log says" :-)
>=20
> 2.4 checks CRLs much more rigidly than 2.3 (precisely: 2.3 had some
> built-in checking which only looked at revocations, while 2.4 leaves this=
=20
> to the crypto library, and they check all fields more rigidly).
>=20
> Specifically, CRLs with an expired "next update" field are flagged as
> "expired" by OpenSSL, while the built-in check in 2.3 did not.

This.  I replied something similar on the debian bug tracker, but I have
no clue what will happen with that mail.

> Since this bit a few people already, I wonder how we could communicate
> this better.

I wonder about that too.  Maybe some more verbose text on a wiki page?
We could even detect this specific error and add a link to that page in
the warning.

-Steffan


--opPx8UMKbOauWo53oFii5bstsAqgbABs6--

--oChSfjOUC7KLB1fkm3iXQG1b8PJj2mQus
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYamWZAAoJEEEwndWOY1w5OKwH/iC/lLl7W2JtZgtn/vSQ+ND3
is9e2Uq7b0Sd0663gyzSjfYXv1P3HWoUI8bO40pjq/hyUry0ZNJOlPJ9+LoQLboK
Hx6dv8/0wsKyEpttCy0obS2euGFn/sF7D0zNXK0c/OkWnBsMSBnkdih/QGxndfUV
dEuFbgDy2KFiUO58zkkoejmKY3V506XMTDYI6wtsEtVqfj8ft3REdkgsSLY6ybNs
U+cSTuWrUK7Yju+GO/FbG8Mwd5uRFpKfj3bgC3tHKXq1Sc3mS6zOp9LRGVYdLHO8
aDafQex7WFAhhhkUpMPailhD9ZhGh8RwVPB7YsE8jLCndh01siex2eQyNuyeBpg=
=VCfG
-----END PGP SIGNATURE-----

--oChSfjOUC7KLB1fkm3iXQG1b8PJj2mQus--

