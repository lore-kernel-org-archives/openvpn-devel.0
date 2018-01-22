Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
 <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <91ffd543-3f5a-e08d-ac89-379770b46b96@...2080...>
Date: Mon, 22 Jan 2018 15:55:10 +0100
MIME-Version: 1.0
In-Reply-To: <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4r7xAANeW3lZbFdCkqmOTJ4oqgXqt9wvJ"
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4r7xAANeW3lZbFdCkqmOTJ4oqgXqt9wvJ
Content-Type: multipart/mixed; boundary="973c5dZX9VJJykOQ44MBTfaCKFckFFQjZ";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net
Message-ID: <91ffd543-3f5a-e08d-ac89-379770b46b96@...2080...>
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
 <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>
In-Reply-To: <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>

--973c5dZX9VJJykOQ44MBTfaCKFckFFQjZ
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/01/18 15:12, Simon Matter wrote:
>> On 20/01/18 18:22, Selva Nair wrote:
>>> Hi,
>>>
>>> Does openvpn-vagrant include any VM provisioning with openssl-0.9.8?
>>> Until recently I had access to a few old debian boxes but now all
>>> updated and 0.9.8 testing is getting harder.
>>
>> Let me rather twist this question around ... Do we want to support OpenS=
SL
>> 0.9.8?  Are there any Linux distributions or other OSes out there in the
>> wild
>> which is still supported which are also based on openssl-0.9.8?
>=20
> If it's possible without too many headaches, I'd appreciate if
> openssl-0.9.8 support would be kept in during the 2.4 series.

Can you elaborate more on your use case?  Keeping something just to keep
something is kind of a poor argument.  But of course, it goes the other way
around too, we shouldn't kick it out just to kick it out either.

Currently, I'm mostly concerned that keeping the support span from 0.9.8 to
1.1.x can lead to maintenance challenges in the longer run - especially if =
the
use cases are poor.

To me it then gets crucial that users needing openssl-0.9.8 have access to a
maintained distribution of that particular OpenSSL version.  Otherwise, we'=
re
deluding OpenVPN users it is safe to use openssl-0.9.8.

So if we don't have really strong arguments keeping support for this old
version, we should carefully consider our options.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--973c5dZX9VJJykOQ44MBTfaCKFckFFQjZ--

--4r7xAANeW3lZbFdCkqmOTJ4oqgXqt9wvJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaZftOAAoJEIbPlEyWcf3yTaQQAKSTpAW+LJ/cJqV/Tp/xgK2R
mRetpC+wD2Cv+vKClVs0d5z8JgRKqO59cwbPbWtkkWe2mwhGv5vuBVaiesxC4BPJ
0HosoGiUayIMXujBOOjiDRPDjEr2b1/xWLtrwMwnJBfvakVaVcIVG/87+vgyrG5x
LLA79k+Z9VoVJgBLtAEF/5go4QrH9gGU+UcJ5sOAdzbSvWIUBw9ygDVHjX6fr/aC
wqSAtsDmXWokM2XcIHyneQDcvjKEkxukxOH9P+nLMWree/5Le7s5VL+1wtaOgeGd
ClRCbhvPpxO5YLLP6S6Zk3rTulemu64BlaYLFwMTw8jMvdWJUEdWZi1vrmPx9xg1
ud+yks/81KdhpEi2XFpZbn0W9MtDlixPQFq0OPqAI96XGKrl8XWU2wzzeR1DQDxd
Rn8wY3rFi2J00g39RUruWJ+OvFipgwY+ssEXJuv/t7QcqMMP1GYaMF/tVARmht/s
s7865r1Cr2Zrb1miyxzC7dCRDcmpP1ypuZhgAB/ANc06V1edOkcrW07wqNphXDZw
dtPj+CGpSGVZZKoIluBnsqxiWSB4WlN33amtZsJtvpvfEDajdHKM8Gx3r17kvM2W
U4r57xPxr3vas2X4o7YVrzE3ExQAcPY3ACOQx1K6nVLaC4zpc/B/oAW54gwU+5ri
H0WNS2ukNf9ebdrMoFij
=+ICT
-----END PGP SIGNATURE-----

--4r7xAANeW3lZbFdCkqmOTJ4oqgXqt9wvJ--

