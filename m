From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <9f75757c-6668-c521-af6f-b18e8db3fa72@...515...>
 <CAKuzo_gwpPebkt_+o9paaR_MFy7c_BJOFW=0CB7K5YT7LVD+bQ@...278...>
 <ed95a733-246d-e313-b3da-5004299137c7@...515...>
Message-ID: <d117a847-943e-27b4-a4f9-383ac3f0e119@...515...>
Date: Thu, 25 Apr 2019 10:41:14 +0300
MIME-Version: 1.0
In-Reply-To: <ed95a733-246d-e313-b3da-5004299137c7@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tE16e09CizitqILePxz1gGWzs6vS5BvUI"
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 Windows installers released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tE16e09CizitqILePxz1gGWzs6vS5BvUI
Content-Type: multipart/mixed; boundary="GK2XkKwkLEjnMFvyz4ehRmi0CAvrYtIQa";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <d117a847-943e-27b4-a4f9-383ac3f0e119@...515...>
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 Windows installers released
References: <9f75757c-6668-c521-af6f-b18e8db3fa72@...515...>
 <CAKuzo_gwpPebkt_+o9paaR_MFy7c_BJOFW=0CB7K5YT7LVD+bQ@...278...>
 <ed95a733-246d-e313-b3da-5004299137c7@...515...>
In-Reply-To: <ed95a733-246d-e313-b3da-5004299137c7@...515...>

--GK2XkKwkLEjnMFvyz4ehRmi0CAvrYtIQa
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Il 25/04/19 08:16, Samuli Sepp=C3=A4nen ha scritto:
> Il 24/04/19 15:46, Selva Nair ha scritto:
>> Hi,
>>
>> On Wed, Apr 24, 2019 at 6:50 AM Samuli Sepp=C3=A4nen <samuli@...515...> =
wrote:
>>>
>>> Hi,
>>>
>>> New OpenVPN Windows installers have been released. The release
>>> highlights are:
>>>
>>> - Latest openvpn-gui
>>> - Latest openvpnserv2 (OpenVPNService)
>>> - Latest tap-windows6 driver
>>>   - ARM64 support
>>>   - NDIS 6.30 support
>>>   - other enhancements
>>>   - fix to local privilege exploit vulnerability
>>>
>>> The installers come in two flavors. Windows 7/8/8.1/Server 2012r2:
>>>
>>> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-=
I606-Win7.exe>
>>>
>>> Windows 10 (any version):
>>>
>>> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-=
I606-Win10.exe>
>>>
>>> We're unable to release a version for Windows Server 2016 at this point,
>>>  so you need to use the old installer:
>>>
>>> <https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.7-=
I603.exe>
>>>
>>> We're working on getting tap-windows6 pass the HLK test suite on Windows
>>> Server 2016. This will allow us to get a signature from Microsoft and
>>> release an updated tap-windows6 on that platform as well. While waiting
>>> please avoid running OpenVPN on nodes where all users are not trusted.
>>>
>>> For further details see the download page:
>>>
>>> <https://openvpn.net/community-downloads/>
>>
>> I think we were supposed to continue using openvpnserv2 version
>> 1.3.0 until the MSI installer is ready. Version 1.4.0 included here
>> requires some logic in the installer to create the new config_dir locati=
on
>> if missing, and move contents from the old location.
>>
>> See also this PR:
>> https://github.com/OpenVPN/openvpn-build/pull/141/commits/9c2774ca384176=
3ada64986b18d1df7634c59a20
>>
>>
>> Selva
>>
>=20
> Hi,
>=20
> I completely forgot about this rather invasive change. I will produce
> new installers with openvpnserv2 1.3.0.0 in a couple of hours.
>=20

Hi,

Download page has been updated with new installers (I607) that bundle
openvpnserv 1.3.0.0 (=3Dthe old version).

<https://openvpn.net/community-downloads/>

Sorry for the confusion.

Samuli


--GK2XkKwkLEjnMFvyz4ehRmi0CAvrYtIQa--

--tE16e09CizitqILePxz1gGWzs6vS5BvUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzBZJoACgkQKVhNn0CG
RXj9agf/XdbpMmKo2JwesmM6tK2J3IHJ5it401Pa0WHcVDTCRdTrfGHljV8gYWwZ
N+fRkm1V9QdUSDUaszik+16CPItO9fIFDkk5Z0sfL0cFxnwZSII+0n9CJw7u0v5I
jjS46hqr75ojrygp5/g7lqQZEHckA250zZgTz6vhizc//r8Ux3tX/QqOvym0ykp+
SzfpEPUfR2hq8YGW2goZ/fXs/tQhqlun8Ns6rfyLu6dCJ7CQgTIAL46h4c8kkFfN
TUMHgWvbUI4IP1VV5EkgkwffC7LWhZEq+eAPwKktzP/53TEULLOkDrAQCYWsDKDe
KT497hv2L+f0ymF1aPUWFBioStgFEQ==
=MFzP
-----END PGP SIGNATURE-----

--tE16e09CizitqILePxz1gGWzs6vS5BvUI--

