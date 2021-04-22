Date: Thu, 22 Apr 2021 10:27:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YIEzcUAY95j2h9aa@...1296...>
References: <20210421134348.1950392-3-arne@...1227...>
 <202104220635.13M6ZkAh076717@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GPyAdn/u/Jqh5QK2"
Content-Disposition: inline
In-Reply-To: <202104220635.13M6ZkAh076717@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove always enabled
 USE_64_BIT_COUNTERS define
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--GPyAdn/u/Jqh5QK2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 22, 2021 at 08:35:46AM +0200, Gert Doering wrote:
> Your patch has been applied to the release/2.4 branch.

Uh, that was not what I intended to do.  But that's what you get for
"try to get things done early in the morning" before coffee works.  *sigh*

I have force-pushed 2.4 without that commit (no tags set, so no harm done)
and applied it to master, where it was intended to go

commit 3a16a8678ded8df8e41c495bccc4e24ef0ce82f4 (master)
Author: Arne Schwabe <arne@...1227...>
Date:   Wed Apr 21 15:43:44 2021 +0200

    Remove always enabled USE_64_BIT_COUNTERS define


sorry

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GPyAdn/u/Jqh5QK2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJggTKtAAoJEB2Cnv7KVigS/G0MAJZX28j1tLNx8mx5DZ3VV4wl
Xj7X8RrargLbKaT0dBKEItOxAmtbSGGpzbURjo80aT5SF4Z9jHUIlv5B9x13lVzv
jk2D+hzYkAB0vDHzspQZtaUbqQ6D1wVEStUevCO/6oYP1hAjtOxOF8AbEO0PXkfN
bZBcdBzHIFtcCcKcs1PVJgA+rN5NqWynlCKJESa4iZgVZSLlYmK6AkNCdBe0M9pa
YdrJjUdknpJXdkQpsnkpniL0AHjLu0lYSnjt1IR22WJyuPL1fj25rCLyGaCskvIy
iNsYnxOBBO8GvepaUGeL+LaEQs1Z/qQ9EwJdgVlyXCUcs9zyqEW5mBIgzB4HY5w4
YcCKjLCQL7cJGaNvuxFS3LLdpIHPk0XDEEMAkJhjDqW7gakM4oL4Pt7pfmSo5h/h
l8zGO+UqmVlU3EvMDoiNGphBeK9yeHVsgrVCiEEKl5EsiXTD+ElEtZW2mnRTAfRW
vaxrxfAaTusgPv9adofHkO0foYvX8OBuY8awSB0p1g==
=oAta
-----END PGP SIGNATURE-----

--GPyAdn/u/Jqh5QK2--

