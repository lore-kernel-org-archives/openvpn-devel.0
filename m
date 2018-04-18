References: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
 <3ed13a6a-07fd-3f0c-100c-148099bc8971@...277...>
 <CAKuzo_haG86HMg8+Wet0=m6O9tzU_c92TQSBgJy7NncPv+3=GQ@...278...>
 <20180418065816.GY69387@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <715d2c30-3dae-4094-e7fd-33c6f5a524cf@...515...>
Date: Wed, 18 Apr 2018 10:20:46 +0300
MIME-Version: 1.0
In-Reply-To: <20180418065816.GY69387@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PU8sGRu4e0u7dTXpxnw7daDxKKeHyQwEy"
Subject: Re: [Openvpn-devel] New tap-windows6 driver (9.21.3) available for
 testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PU8sGRu4e0u7dTXpxnw7daDxKKeHyQwEy
Content-Type: multipart/mixed; boundary="0onsHY9cOjNeQaRhsr9okzekk88YBZsEW";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <715d2c30-3dae-4094-e7fd-33c6f5a524cf@...515...>
Subject: Re: [Openvpn-devel] New tap-windows6 driver (9.21.3) available for
 testing
References: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
 <3ed13a6a-07fd-3f0c-100c-148099bc8971@...277...>
 <CAKuzo_haG86HMg8+Wet0=m6O9tzU_c92TQSBgJy7NncPv+3=GQ@...278...>
 <20180418065816.GY69387@...1296...>
In-Reply-To: <20180418065816.GY69387@...1296...>

--0onsHY9cOjNeQaRhsr9okzekk88YBZsEW
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Il 18/04/2018 09:58, Gert Doering ha scritto:
> Hi,
>=20
> On Tue, Apr 17, 2018 at 09:45:24PM -0400, Selva Nair wrote:
>> (ii) The driver version shows up as 9.0.0.21 -- this is apparently taken
>> from the inf file. Why is it not 9.21.3? The file version is 9.21.3 9/21=
 as
>> expected.

I think the confusing versioning is just historic baggage which we have
never bothered to fix.

> I have no idea how the various values in version.m4 should work.  There
> are many numbers...
>=20
> What I have (after bumping all "21" to "22", and ".2/.3" to ".1") is:
>=20
> define([PRODUCT_NAME], [TAP-Windows])
> define([PRODUCT_PUBLISHER], [OpenVPN Technologies, Inc.])
> define([PRODUCT_VERSION], [9.22.1])
> define([PRODUCT_VERSION_RESOURCE], [9,0,0,22])
> define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
> define([PRODUCT_TAP_WIN_MAJOR], [9])
> define([PRODUCT_TAP_WIN_MINOR], [22])
> define([PRODUCT_TAP_WIN_REVISION], [1])
> define([PRODUCT_TAP_WIN_BUILD], [601])
>=20
> So, no idea what PRODUCT_VERSION_RESOURCE does and why it is not "9,22,1,=
0"
> (or the like).
>=20
> It would certainly make things easier if that would output the same
> number in all places.

Agreed. I would love to bump 9,0,0,21 into 9,22,1,601. I _think_ Windows
should be fine with that. We can discuss this in today's meeting.

>=20
>=20
>> (iii) On Win7, the interface gets metric 20 --- implying a speed < 200 M=
bps
>> as per the Windows automatic metric assignment table. Isn't this supposed
>> to get detected as a 1Gbps adapter now? The link speed patch is in master
>> and this one is one point ahead of it (9.21.3), so expected to see it he=
re.
>=20
> The test driver is based on master before the link speed patch, with an
> independent version bump.  Sorry for that confusion.
>=20
> gert
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--0onsHY9cOjNeQaRhsr9okzekk88YBZsEW--

--PU8sGRu4e0u7dTXpxnw7daDxKKeHyQwEy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlrW8c8ACgkQKVhNn0CG
RXiVWAgArRlpcjbyPsUFF/QtMXgI1BN7eba6/NZh+4ChVBcCshSn/fC21gPNbaII
acYjliTRTZfShV/XIMVYnOKa5U+w9IzQvgCUOZptrrt37k+boJOufdAv1KdhqsTr
VFR27l1KzXjXt3X3GvppTwUh4pntfKDmZPkPdii2fY+Xq9nwQpVkmuTl2YyoHId6
V/dfWPQrm3dVQx5USSxmWECE/jM1tK/luNzLrrHA0PPTUNfF4moagawvmimCSuXY
a+CPQloJ51nn/MzWumDhe4L1ZUx55li6Rw0IJby9Of8oCEnD/Jqok3X/onDNV1x0
Hh01+41BQBx7kEoSvnklniqQhUOtfA==
=7GqP
-----END PGP SIGNATURE-----

--PU8sGRu4e0u7dTXpxnw7daDxKKeHyQwEy--

