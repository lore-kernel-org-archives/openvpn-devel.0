References: <9f75757c-6668-c521-af6f-b18e8db3fa72@...515...>
 <CAKuzo_gwpPebkt_+o9paaR_MFy7c_BJOFW=0CB7K5YT7LVD+bQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <ed95a733-246d-e313-b3da-5004299137c7@...515...>
Date: Thu, 25 Apr 2019 08:16:34 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gwpPebkt_+o9paaR_MFy7c_BJOFW=0CB7K5YT7LVD+bQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="066jMYabLq4KofzDPG7gFmoTupGnPJo70"
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 Windows installers released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--066jMYabLq4KofzDPG7gFmoTupGnPJo70
Content-Type: multipart/mixed; boundary="sVAYr9gWHxIOQeYhu7qbfwpVM3VL34H1O";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <ed95a733-246d-e313-b3da-5004299137c7@...515...>
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 Windows installers released
References: <9f75757c-6668-c521-af6f-b18e8db3fa72@...515...>
 <CAKuzo_gwpPebkt_+o9paaR_MFy7c_BJOFW=0CB7K5YT7LVD+bQ@...278...>
In-Reply-To: <CAKuzo_gwpPebkt_+o9paaR_MFy7c_BJOFW=0CB7K5YT7LVD+bQ@...278...>

--sVAYr9gWHxIOQeYhu7qbfwpVM3VL34H1O
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Il 24/04/19 15:46, Selva Nair ha scritto:
> Hi,
>=20
> On Wed, Apr 24, 2019 at 6:50 AM Samuli Sepp=C3=A4nen <samuli@...515...> w=
rote:
>>
>> Hi,
>>
>> New OpenVPN Windows installers have been released. The release
>> highlights are:
>>
>> - Latest openvpn-gui
>> - Latest openvpnserv2 (OpenVPNService)
>> - Latest tap-windows6 driver
>>   - ARM64 support
>>   - NDIS 6.30 support
>>   - other enhancements
>>   - fix to local privilege exploit vulnerability
>>
>> The installers come in two flavors. Windows 7/8/8.1/Server 2012r2:
>>
>> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I=
606-Win7.exe>
>>
>> Windows 10 (any version):
>>
>> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I=
606-Win10.exe>
>>
>> We're unable to release a version for Windows Server 2016 at this point,
>>  so you need to use the old installer:
>>
>> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-I=
603.exe>
>>
>> We're working on getting tap-windows6 pass the HLK test suite on Windows
>> Server 2016. This will allow us to get a signature from Microsoft and
>> release an updated tap-windows6 on that platform as well. While waiting
>> please avoid running OpenVPN on nodes where all users are not trusted.
>>
>> For further details see the download page:
>>
>> <https://openvpn.net/community-downloads/>
>=20
> I think we were supposed to continue using openvpnserv2 version
> 1.3.0 until the MSI installer is ready. Version 1.4.0 included here
> requires some logic in the installer to create the new config_dir location
> if missing, and move contents from the old location.
>=20
> See also this PR:
> https://github.com/OpenVPN/openvpn-build/pull/141/commits/9c2774ca3841763=
ada64986b18d1df7634c59a20
>=20
>=20
> Selva
>=20

Hi,

I completely forgot about this rather invasive change. I will produce
new installers with openvpnserv2 1.3.0.0 in a couple of hours.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--sVAYr9gWHxIOQeYhu7qbfwpVM3VL34H1O--

--066jMYabLq4KofzDPG7gFmoTupGnPJo70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzBQrIACgkQKVhNn0CG
RXhN0Qf+PDkCS/FCFXmW5Oi03vcCwVdvpoaqIu2PXGW17JUxtnH6lLRL4VRHodjo
whM1btJ+l+xh7bvY9wx/IFTwuLuhueEukdaktWwIoJ82INmpKzbnSJxLXorRup/H
3weBHV6JuiQeRvY2KLHMXrSkmfDgGMSV38UvNv5r9OMBiD4ABHM0ceKXBj8KhzCk
xinp4MiD7ev6rnHEr9xJkZZWIR9JOSC2+yt9c8K/Vmr9ytT2kScUrem6gv4i1wZW
PuanBQuF6bli2UoimXOyyUA7T6ROsH7cKMhibwvRuzLZUb47cKDn770SaMLiHFNe
kcA7RBXQUmJ6hU7nrH6ywg+nWcJhhQ==
=8ZZ5
-----END PGP SIGNATURE-----

--066jMYabLq4KofzDPG7gFmoTupGnPJo70--

