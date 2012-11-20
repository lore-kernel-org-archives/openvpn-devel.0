Message-ID: <50AB5B0F.5060209@...1114...>
Date: Tue, 20 Nov 2012 11:27:27 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
	<50AB4AFB.9030908@...1114...>
	<1CED409804E2164C8104F9E623B08B901323AF01D4@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901323AF01D4@...1436...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDD9FE0892E52D9FAAE3CC5B0"
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD9FE0892E52D9FAAE3CC5B0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 20/11/12 11:10, Joachim Schipper wrote:
> Yes, that seems to be correct. Sorry!

Perfect!  I'll update your commit message to point at the correct commit
then and apply it :)


--=20
kind regards,

David Sommerseth

> -----Original Message-----
> From: David Sommerseth [mailto:openvpn.list@...1114...]=20
> Sent: dinsdag 20 november 2012 10:19
> To: Joachim Schipper
> Cc: openvpn-devel@lists.sourceforge.net; Adriaan de Jong
> Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
>=20
> On 14/11/12 10:03, Adriaan de Jong wrote:
>> [PATCH] Fix --show-pkcs11-ids (Bug #239)
>>
>> Broken by 75b49e406430299b187964744f82e50a9035a0d3.
>>
>> Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
>> ---
>>  src/openvpn/pkcs11.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Hi Joachim,
>=20
> Thanks a lot for you fix!  Just a little question.  You mention this comm=
it as being the offending commit:
>=20
> commit 75b49e406430299b187964744f82e50a9035a0d3
> Author: Alon Bar-Lev <alon.barlev@...277...>
> Date:   Sun Apr 1 16:46:28 2012 +0300
>=20
>     cleanup: gc usage
>=20
>     Cleanup of "Use the garbage collector when retrieving x509 fields"
>     patch series.
>=20
>     Discussed at [1].
>=20
>     There should be an effort to produce common function prologue
>     and epilogue, so that cleanups will be done at single point.
>=20
>     [1] http://comments.gmane.org/gmane.network.openvpn.devel/5401
>=20
>     Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>     Acked-by: Adriaan de Jong <dejong@...1435...>
>     Signed-off-by: David Sommerseth <davids@...1347...>
>=20
>=20
> I'm just wondering how this could be related to you fix.  As I see it, th=
e syntax of the if() statement you change didn't change, neither the behavi=
our of pkcs11_certificate_dn().
>=20
> I see that commit 00b973f8af85c3ea8fa3cef80eec55e8dc139b27 changes the be=
haviour of pkcs11_certificate_dn() in both the OpenSSL and PolarSSL impleme=
ntation.  So I'm suspecting you referenced the wrong commit.  Right?
>=20
>=20
> --
> kind regards,
>=20
> David Sommerseth
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Monitor your physical, virtual and cloud infrastructure from a single
> web console. Get in-depth insight into apps, servers, databases, vmware,
> SAP, cloud infrastructure, etc. Download 30-day Free Trial.
> Pricing starts from $795 for 25 servers or applications!
> http://p.sf.net/sfu/zoho_dev2dev_nov
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--------------enigDD9FE0892E52D9FAAE3CC5B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCrWw8ACgkQDC186MBRfroMegCdFOCwNbryBGe4okA6IV3J2q/x
PjsAnRxFK9Y0m+cGWuglTNSE+FBjj+f9
=fxNo
-----END PGP SIGNATURE-----

--------------enigDD9FE0892E52D9FAAE3CC5B0--

