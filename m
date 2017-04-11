References: <20170410222828.23612-1-davids@...515...>
	<523fde112159f8583eb7963b16acd85e.squirrel@...2257...>
	<1920dd1e-d818-0d39-7dce-70318a47d2c6@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <de3cf140-145b-0876-ec8d-464da1703a19@...1435...>
Date: Tue, 11 Apr 2017 13:30:38 +0200
MIME-Version: 1.0
In-Reply-To: <1920dd1e-d818-0d39-7dce-70318a47d2c6@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HvwHS2npX1GsesAo9kofhixXw9DfWiruL"
Subject: Re: [Openvpn-devel] [PATCH] Make --cipher/--auth none more explicit
 on the risks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--HvwHS2npX1GsesAo9kofhixXw9DfWiruL
Content-Type: multipart/mixed; boundary="PBe7kdLDREWO174hB4letCe2FanT9icDj";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <de3cf140-145b-0876-ec8d-464da1703a19@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Make --cipher/--auth none more explicit
	on the risks
References: <20170410222828.23612-1-davids@...515...>
	<523fde112159f8583eb7963b16acd85e.squirrel@...2257...>
	<1920dd1e-d818-0d39-7dce-70318a47d2c6@...2080...>
In-Reply-To: <1920dd1e-d818-0d39-7dce-70318a47d2c6@...2080...>

--PBe7kdLDREWO174hB4letCe2FanT9icDj
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11-04-17 10:55, David Sommerseth wrote:
> On 11/04/17 06:26, Simon Matter wrote:
>>> The warning provided to --cipher and --auth using the 'none' setting may
>>> not have been too clearly understandable to non-developers or people not
>>> fully understanding encryption and cryptography.  This tries to improve
>>> that.
>>>
>>> While at it, also break up the long source lines.
>>>
>>> Signed-off-by: David Sommerseth <davids@...515...>
>>> ---
>>>  src/openvpn/crypto.c | 11 +++++++++--
>>>  src/openvpn/init.c   |  5 ++++-
>>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>>> index 909f725..8a5c723 100644
>>> --- a/src/openvpn/crypto.c
>>> +++ b/src/openvpn/crypto.c
>>> @@ -784,7 +784,10 @@ init_key_type(struct key_type *kt, const char
>>> *ciphername,
>>>      {
>>>          if (warn)
>>>          {
>>> -            msg(M_WARN, "******* WARNING *******: null cipher specifie=
d,
>>> no encryption will be used");
>>> +            msg(M_WARN, "******* WARNING *******: '--cipher none' was
>>> specified. "
>>> +                "This means NO encryption will be performed and tunnel=
led
>>> "
>>> +                "data WILL be transmitted in clear text over the netwo=
rk!
>>> "
>>> +                "PLEASE DO RECONIDER THIS SETTING!");
>>
>> Hi
>>
>> Small typos, you may want to 's/RECONIDER/RECONSIDER/g' the patches.
>=20
> Meh, yeah, sorry about that.  That need to be fixed, but also something
> I can fix on-the-fly at commit time; that's an uncritical last minute
> change.  Just need an ACK first ;-)

ACK if you fix the typos :)

-Steffan



--PBe7kdLDREWO174hB4letCe2FanT9icDj--

--HvwHS2npX1GsesAo9kofhixXw9DfWiruL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY7L5eAAoJEEEwndWOY1w5pewH/iEYjXX2ulLnzMXco4lBsE7t
5JxNvPzYLCuNWfTmHuJ4eO2S42UEVKbbFTz5AfrNSnN8UxCaf0D2ri+xS/L9lGGk
kFG5Y8754swFLK1qkoUlaqM0hBgE+fJBOG97pz9DYw4FtCAxbwOPiiIAsfj+2S4c
EfzXzo6haAScUjS97ExxQZqavGT1Kx8IIGkK4LP/9flZWJF18ZgnBcwknb26wqNx
VDd32Ih325KyD8EQPXyGSUDqOuNAK7oqTW2St81GnSvzhe+/ebEc1rN0ZhPnetpb
hUU70q5+GKrcum1KZ/dp14zJFUjAMyVr2e3xGxJZtVLryrTPSugcuDOlGU9zaMg=
=ChjO
-----END PGP SIGNATURE-----

--HvwHS2npX1GsesAo9kofhixXw9DfWiruL--

