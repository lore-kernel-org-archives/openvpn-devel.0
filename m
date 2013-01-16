Message-ID: <50F73264.2070608@...1114...>
Date: Thu, 17 Jan 2013 00:06:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
	<50F7257C.9010404@...1800...>
In-Reply-To: <50F7257C.9010404@...1800...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC10F8F1F8513E28654C3CF4"
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
To: Mike Tancsa <mike@...1800...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC10F8F1F8513E28654C3CF4
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 16/01/13 23:11, Mike Tancsa wrote:
> Hi,
> 	I have been following the steps to build OpenVPN from the sources and
> was scratching my head as to why the prebuilt binary would work, but my
> build from the sources would bork on --show-pkcs11-ids ?!?!   Searching
> through the mailling list archives shows the patch below, which fixes my
> problem.  It seems that this patch is not in the generic sources?
>=20
> I was following the directions at
> https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsyste=
m#Checkingoutopenvpn-buildrepository
>=20
> My question is, why would I not get the correct sources with the fix
> below using the generic build ?  Is there a different / better way to do
> it that whats outlined in the above url ?
>=20
> Thanks!

The patch you point at should be in the git repo (applied Nov 22).  It's
commit 5fd3e56430678bee3e6e3a3cf8dfd6db7e105676 in master and commit
fd02ae905df21e1119fb63521e7ff773d6f812dc in beta/2.3.

<http://thread.gmane.org/gmane.network.openvpn.devel/7129/focus=3D7136>

   $ git tag --contains fd02ae905df21e1119fb63521e7ff773d6f812dc
   v2.3.0
   v2.3_rc2


However, it seems that the generic build tool needs some more tweaking
to grab the packages correctly from github - they changed the download
URLs.  Might be more issues there as well.

Samuli, can you check this?

How I compile OpenVPN is basically directly from the git tree, with
these steps:

  $ autoreconf -vi
  ....
  $ ./configure
  ...
  $ make

And the binary is available in src/openvpn/.  You need pkcs11-helper,
lzo2 and OpenSSL or PolarSSL libraries and development headers
pre-installed though.

But this is probably mostly handy unless you need to do Windows
cross-builds.


--
kind regards,

David Sommerseth



> 	---Mike
>=20
> On 11/14/2012 4:03 AM, Adriaan de Jong wrote:
>> [PATCH] Fix --show-pkcs11-ids (Bug #239)
>>
>> Broken by 75b49e406430299b187964744f82e50a9035a0d3.
>>
>> Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
>> ---
>>  src/openvpn/pkcs11.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c index 645f1f4..=
3a15ef6 100644
>> --- a/src/openvpn/pkcs11.c
>> +++ b/src/openvpn/pkcs11.c
>> @@ -887,7 +887,7 @@ show_pkcs11_ids (
>>  		      (dn =3D pkcs11_certificate_dn (
>>  				certificate,
>>  				&gc
>> -		      ))
>> +		      )) =3D=3D NULL
>>  		) {
>>  			goto cleanup1;
>>  		}
>> --
>> 1.7.9.5
>>
>>


--------------enigDC10F8F1F8513E28654C3CF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlD3MmkACgkQDC186MBRfrqvDwCfVmQqBA4L8eiqWZ9Kl7CjEOnk
hdgAni0v2rx87ytXSkTlTEqZWSAS4Q58
=S5mt
-----END PGP SIGNATURE-----

--------------enigDC10F8F1F8513E28654C3CF4--

