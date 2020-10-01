References: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
 <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
 <c319712b9f596989d66570d9624d8357.squirrel@...2260...>
 <de392f2b-a11f-f747-0fe5-636b4a0e5a12@...2080...>
 <2fd674eb36cdc08f2d5115adc9673b84.squirrel@...2260...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4513c8d0-2c1f-fb67-95b0-bf79924a775a@...2080...>
Date: Thu, 1 Oct 2020 19:13:39 +0200
MIME-Version: 1.0
In-Reply-To: <2fd674eb36cdc08f2d5115adc9673b84.squirrel@...2260...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Kzdy5bCNg5Iwok6XJYoD9LwchrXqvuyWC"
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
To: Simon Matter <simon.matter@...2249...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kzdy5bCNg5Iwok6XJYoD9LwchrXqvuyWC
Content-Type: multipart/mixed; boundary="tgvX5yHBZg9ie5swTv5p97necNdTscYpj";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Simon Matter <simon.matter@...2249...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <4513c8d0-2c1f-fb67-95b0-bf79924a775a@...2080...>
Subject: Re: [Openvpn-devel] Add --up-pre with the same functionality as
 --down-pre
References: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
 <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
 <c319712b9f596989d66570d9624d8357.squirrel@...2260...>
 <de392f2b-a11f-f747-0fe5-636b4a0e5a12@...2080...>
 <2fd674eb36cdc08f2d5115adc9673b84.squirrel@...2260...>
In-Reply-To: <2fd674eb36cdc08f2d5115adc9673b84.squirrel@...2260...>

--tgvX5yHBZg9ie5swTv5p97necNdTscYpj
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 01/10/2020 18:36, Simon Matter wrote:
>> From what I recall from the last review years ago, the behavior was also
>> not
>> well defined in restart scenarios (--up-restart) - where the script might
>> be
>> run with different privileges, the --chroot might also change things.
>> Which
>> makes this patch very fragile for users.
>>
>> All of these issues are avoided with the --management and
>> --management-hold.
>
> How do all these issues affect --up-pre but not the existing --down-pre?
> Why was --down-pre never removed over all the years if it makes things so
> fragile for users?

Several reasons.  We don't want to break backwards compatibility.  So remov=
ing
an option which has existed since 2004 is not acceptable unless it is really
security sensitive (see the discussion on this list regarding another patch
where I suggested, to remove --udp-mtu - which was also rejected).

Secondly, --down-pre has a deterministic behavior.  If you use --chroot and=
/or
--user/--group, the --down script is run under the same conditions whether =
you
use --up-restart or not.

And, since we still have not heard any convincing arguments why --management
with --management-hold cannot work for your use case, nothing has changed
since the Trac discussions years ago.  We don't want to easily add a feature
only 3 people have requested during a time span of 7 years, where one of th=
em
already confirmed the management approach worked [1].

<https://community.openvpn.net/openvpn/ticket/284#comment:17>

Adding new options and features means we need to commit to support them for
quite a long time; regardless of the patch complexity.  So a new feature or
option really needs to have a reasonable amount of users and solves a probl=
em
which cannot be solved through other reasonable ways.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--tgvX5yHBZg9ie5swTv5p97necNdTscYpj--

--Kzdy5bCNg5Iwok6XJYoD9LwchrXqvuyWC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfdg5DAAoJEIbPlEyWcf3yTgIQAKa0uwH/fglVZ1GEiuX6LDV4
CjvxakxabQ7+nw551pdbzFhfGox3QC3NnrL6P1D8chlPNyQnCFGlIpkpQn+ACLR+
mWunYtntjnP5Z4YA2CrQKjBQcPvLcl2YcPP6F+F81fMoCSEmCT2Nhc3AGTjWtlJY
3tM/jXBwupCsM7gaHWKQBu8ym+fTGn+c2IKnUQvVU2gQMOgKSICyWIazKWK6man1
gu1OqzMbACZC5TZ26rRHGUgHB8BdFNsBdUQH3MVCF9Jfd90Gd0XC4kmn2ygauK7U
NZvwrUtp3qbKPzTyS9SLCKt/PGrPvDkL2Lx8sQ+9uOD/wG4aKdud5snBrFksmeoF
UJFYdiSP+PP0hdrZvzWQvv2vRGln38Q6ruUFZW3Ia03BKz4deagXs9/W63LrRWmi
qzUZRnxGSGU/iuzqZAbzljN2DC+WLFULm/DxK5e9yCZCpfLq+X+E0/xtVGep0flQ
CfkizHVkFjs5QU8GqLnWBw2uYTu5qu7zVgO22kI35JHArOc3bEq4Fr/2+GQnKaNl
VszQjoRd6PKhIYKg9v9q94jET/yY2nlm+AyDXshMDzFG7tbUwu8HKDyaeFK9VZqV
EM6tfgcuCKB+7RAGF4bFNdhOEpOGXQAb2R1UokQmJo2FSMLyCWDvQ+IBvuPCL8r7
DcbtrGyxua2qaV/q4ko2
=P23D
-----END PGP SIGNATURE-----

--Kzdy5bCNg5Iwok6XJYoD9LwchrXqvuyWC--

