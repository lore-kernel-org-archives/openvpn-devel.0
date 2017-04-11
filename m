References: <20170410222828.23612-1-davids@...515...>
	<523fde112159f8583eb7963b16acd85e.squirrel@...2257...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1920dd1e-d818-0d39-7dce-70318a47d2c6@...2080...>
Date: Tue, 11 Apr 2017 10:55:32 +0200
MIME-Version: 1.0
In-Reply-To: <523fde112159f8583eb7963b16acd85e.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OUJBkDd8rpOQOOIgCW9BfEujvN2OjOQDA"
Subject: Re: [Openvpn-devel] [PATCH] Make --cipher/--auth none more explicit
 on the risks
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OUJBkDd8rpOQOOIgCW9BfEujvN2OjOQDA
Content-Type: multipart/mixed; boundary="BoAiXM4F8rR5BI9aCP6TPnQWA7O2Fct7B";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Cc: Simon Matter <simon.matter@...2249...>
Message-ID: <1920dd1e-d818-0d39-7dce-70318a47d2c6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Make --cipher/--auth none more explicit
	on the risks
References: <20170410222828.23612-1-davids@...515...>
	<523fde112159f8583eb7963b16acd85e.squirrel@...2257...>
In-Reply-To: <523fde112159f8583eb7963b16acd85e.squirrel@...2257...>

--BoAiXM4F8rR5BI9aCP6TPnQWA7O2Fct7B
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11/04/17 06:26, Simon Matter wrote:
>> The warning provided to --cipher and --auth using the 'none' setting may
>> not have been too clearly understandable to non-developers or people not
>> fully understanding encryption and cryptography.  This tries to improve
>> that.
>>
>> While at it, also break up the long source lines.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  src/openvpn/crypto.c | 11 +++++++++--
>>  src/openvpn/init.c   |  5 ++++-
>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index 909f725..8a5c723 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -784,7 +784,10 @@ init_key_type(struct key_type *kt, const char
>> *ciphername,
>>      {
>>          if (warn)
>>          {
>> -            msg(M_WARN, "******* WARNING *******: null cipher specified,
>> no encryption will be used");
>> +            msg(M_WARN, "******* WARNING *******: '--cipher none' was
>> specified. "
>> +                "This means NO encryption will be performed and tunnell=
ed
>> "
>> +                "data WILL be transmitted in clear text over the networ=
k!
>> "
>> +                "PLEASE DO RECONIDER THIS SETTING!");
>=20
> Hi
>=20
> Small typos, you may want to 's/RECONIDER/RECONSIDER/g' the patches.

Meh, yeah, sorry about that.  That need to be fixed, but also something
I can fix on-the-fly at commit time; that's an uncritical last minute
change.  Just need an ACK first ;-)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--BoAiXM4F8rR5BI9aCP6TPnQWA7O2Fct7B--

--OUJBkDd8rpOQOOIgCW9BfEujvN2OjOQDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY7JoKAAoJEIbPlEyWcf3yNvwP/3u9e//wpJNe932phIdf8vII
bj6LvyShFsWmnkxe7GlAPSq81+VgMdjRwobXjtO7uUTAzGDptrTgF/h1sIGjmmD7
39V7lUoIcKioZH6a27O6Oeq5+hcMeDlx0FYapMFKERfTyHPhmzuSbJ56IVfT3Hps
/EfHH44LHdxV1HeWR2yHyd2EU5KOuiIC/GEKj70mNUWa418BOVBflCDf1rHj+jM2
oK6O9KGfYFe3e4+xyM+vwHDxw79Q3vl8cYyZ6kCKYdpwDcx/tqa+Iqx/NYee8F88
b50A5qVKOsgE4qXm5tSjzD81g959FLR22z8s20O4nsOHKU3fqdxFfAN92hCo8vuI
vS+j7qkQte3STrU7uth2r4jewunE5DB+i4qEqeQAqt8mtKYzNOi78kmEHuVUtyzo
WbAGXANgzttaYFysB0zfBvVwcJqShxaHLohTiUDqaXPDiTS7s4YMuw8DfB5qRg/0
HB1srPzjz8NVonlRd9nKPtDXafxNBIB7OOIw59wlX5wAttPL25RoqklqixTc6hu6
HOnGLmUdwnh1ncRjahRBCazCsdGSevQrfD18YnOLGzIDb6eKz7wdbf6hBIF1WYCH
ihkWA+jOOgZypegnSUaddiK7l8+9dUWBeuliz7ZV/AsgUcvReiIUnsZK4EBIe6CR
yTyw8S2vd8hxnH1LqzAu
=ZzeC
-----END PGP SIGNATURE-----

--OUJBkDd8rpOQOOIgCW9BfEujvN2OjOQDA--

