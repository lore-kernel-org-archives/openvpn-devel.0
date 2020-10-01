References: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
 <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cf4ad6e8-b18f-1259-b074-f6d8dfd57132@...2080...>
Date: Thu, 1 Oct 2020 17:11:57 +0200
MIME-Version: 1.0
In-Reply-To: <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="YMb0143Vh01BHB3gfY62VrxtYtwdPiElN"
Subject: Re: [Openvpn-devel] Add --up-pre with the same functionality as
 --down-pre
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YMb0143Vh01BHB3gfY62VrxtYtwdPiElN
Content-Type: multipart/mixed; boundary="CQRmLpkQwLyAOFxMywte35JqEXAhsw4MS";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...1227...>, Simon Matter <simon.matter@...2249...>
Message-ID: <cf4ad6e8-b18f-1259-b074-f6d8dfd57132@...2080...>
Subject: Re: [Openvpn-devel] Add --up-pre with the same functionality as
 --down-pre
References: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
 <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
In-Reply-To: <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>

--CQRmLpkQwLyAOFxMywte35JqEXAhsw4MS
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 01/10/2020 14:10, Arne Schwabe wrote:
> Am 22.11.17 um 17:58 schrieb Simon Matter:
>> Hi,
>>
>> In our situation we have the requirement to run scripts before tun/tap is
>> opened, not after. While this could be hacked into the init script, the
>> proper way seems to add it to openvpn as --up-pre option. That's
>> independent from any init scripts / systemd service file and works the
>> same way as --down-pre, only for the up status.
>>
>> My initial feature wish, posted 5 years ago, was turned down as won't fi=
x:
>> https://community.openvpn.net/openvpn/ticket/284
>>
>> But there are people who wish it and they have good reasons to wish it.
>> Just yesterday someone asked again:
>> https://community.openvpn.net/openvpn/ticket/284#comment:10
>>
>> Without going into much details
>=20
> This patch currently misses a commit message anyway but a good commit
> should explain why this change is a good one.
>=20
>> just one thing why --up + --up-pre is
>> better than hacking around outside of openvpn: the command called with
>> --up also gets additional run time information from openvpn by parameters
>> and environmental variables. You don't get all those information when
>> calling anything from outside of openvpn before openvpn actually starts.
>>
>> If you feel there are good reasons to still refuse this patch, please let
>> me know.
>=20
> I am just looking at this patch since it is still in the review queue.
>=20
> - Missing documentation.
> - pre-up flag is wrong in terms of scripts. If we add this, it needs to
> be a different script because otherwise you will break use cases that
> also need the --up script.
>=20
> Also having down and down-pre but then only not also up/up-pre but a up
> with flag breaks the symmetry and is confusing.
This patch has been lingering here on the list since 2017.  And I still
haven't changed my opinion about it, as I lack to see a proper use-case (or
"user story", which is the appropriate term for the 2020s).

My stance is pretty well covered in the ticket [1], and the only potential =
use
case which was provided does have, in my opinion, a better alternative by
using --management and --management-hold.

<https://community.openvpn.net/openvpn/ticket/284#comment:15>

So consider this a NAK from my side.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--CQRmLpkQwLyAOFxMywte35JqEXAhsw4MS--

--YMb0143Vh01BHB3gfY62VrxtYtwdPiElN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfdfG+AAoJEIbPlEyWcf3yPREP/320hCvpTvYJ91CkpCAysba5
MA4yXa2jRDPxRPkCGzezE4wsyaUHY37KyiS2GIFrKKX5zTD0Mf9dQdZDwteVixra
09x7Yt6d3jNQcm+8norSq2m2evVqdvU5NkUeI0Jm7UEMHTjmcf50U9jYqZ9J5o7g
t2GmC+PyQWGUNhZkfPIErHmoNU6N2NktdxLOOCmX4MlW+Vl3/iTJDLD0T9eE6iFt
cr6ZkrKdqH1CSKS6oPqrJJjkSj2mDdFu+A5cgwg7nSlP1XVzG+3GFOWUJESUoZn8
UJAMjesjJ+jFT9PFrj/V2lp/5euPNFtRbwAWOSovAEV0a+hyQFn+RuwUtmSlZmx0
ZC3dtyhUYq16VTEOkcH73joj/H+yeawkfsQ6+XrQTqUZgdJRwvwonNnzF7vSJ3IZ
9m+PgLPYiR8Oz4rrpBw6daNXOcjeRRMle5T+8Gabta3S9BeUZ7G+hi7oeclwLiST
jawwv71G4x14VIqUEtzO9HKzEr3GbKIYEgukcXJyDUshbht6FMecjjnjy7it2Nxb
0xwWriVnu5/ULMZIuyuXS/ST7Dfk24dyXCWZDYFVCcAv5dxXgrusGoSDDIhvdZMl
83081/0IydC1hlXNANUhb1U3O4oNa+41vGtALlO9uFwKPRGHoPrtCvaQXT/s+dq5
0YaeCbHuvpTQ7/7rMxDW
=rFFt
-----END PGP SIGNATURE-----

--YMb0143Vh01BHB3gfY62VrxtYtwdPiElN--

