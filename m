From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <611691a5-e91c-c292-93f0-d70b40e35e03@...515...>
 <9267e746-0d9c-ae86-0ed5-2b262acfa2ad@...277...>
 <0e1913c5-9335-f818-02f7-49babffefcdc@...515...>
 <4038deab-cc27-73a4-c8a9-618a4636d918@...515...>
Message-ID: <a076bb1f-145c-5c2f-0c31-091acca862b1@...515...>
Date: Thu, 20 Jun 2019 18:31:57 +0300
MIME-Version: 1.0
In-Reply-To: <4038deab-cc27-73a4-c8a9-618a4636d918@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uaT6T78rzmJTY3gQoWnpd5OQHKnbegtRd"
Subject: Re: [Openvpn-devel] Remaining tap-windows6 HLK test failures
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
--uaT6T78rzmJTY3gQoWnpd5OQHKnbegtRd
Content-Type: multipart/mixed; boundary="B7fSJwoktIQSTx9M2wjIs1RaCG0swN04g";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <a076bb1f-145c-5c2f-0c31-091acca862b1@...515...>
Subject: Re: Remaining tap-windows6 HLK test failures
References: <611691a5-e91c-c292-93f0-d70b40e35e03@...515...>
 <9267e746-0d9c-ae86-0ed5-2b262acfa2ad@...277...>
 <0e1913c5-9335-f818-02f7-49babffefcdc@...515...>
 <4038deab-cc27-73a4-c8a9-618a4636d918@...515...>
In-Reply-To: <4038deab-cc27-73a4-c8a9-618a4636d918@...515...>

--B7fSJwoktIQSTx9M2wjIs1RaCG0swN04g
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for spamming so much, but this is actually the last update for
now. After some debugging I managed to make the following tests pass:

1c_FaultHandling
1c_NdisRequestCov
1c_Registry

The problem with them was a disfunctional WLAN adapter / driver on the
HLK client which messed up a some device/interface data collection logic
in the test script.

So we're now left with just two tests:

  Operate in Server Core: new HLK client needed
  Static Tools Logo Test: Simon provided a recipe for this one

Unfortunately I need to rerun the whole test suite as I had originally
forgotten to set the "Product type" correctly. But this also gives us
the possibility to select what exact variation of the driver we want to
release without "losing" any extra time.

We can discuss this in today's meeting.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



Il 20/06/19 16:27, Samuli Sepp=E4nen ha scritto:
> Hi,
>=20
> Brief update below.
>=20
> Il 20/06/19 09:51, Samuli Sepp=E4nen ha scritto:
>> Hi,
>>
>> First thanks to Simon for providing the recipe for the Static Tools Logo
>> test. It would have taken me lots of time to figure that out myself.
>>
>> Some more updates from my end...
>>
>> Il 19/06/19 15:05, Samuli Sepp=E4nen ha scritto:
>>> Hi,
>>>
>>> Some updates.
>>>
>>> Il 19/06/19 13:50, Samuli Sepp=E4nen ha scritto:
>>>> Hi all,
>>>>
>>>> Here's an update of the status of the tap-windows6 HLK tests, in the
>>>> hope that somebody can help figure out what is causing the remaining, =
so
>>>> far unknown[1], test failures. I'll look into these myself, but any
>>>> insights would be most welcome!
>>>>
>>>> The HLK test environment is setup in the following way:
>>>>
>>>> 1) HLK controller
>>>>    - Virtualbox VM running Windows Server 2016 Evaluation
>>>> 2) HLK client
>>>>    - Thinkcentre M710t (i7 with 4 physical processor cores)
>>>>    - Windows Server 2019 Evaluation (Desktop installation)
>>>> 3) HLK support machine
>>>>    - Thinkpad T420
>>>>    - Windows Server 2019 Evaluation (Desktop installation)
>>>>
>>>> HLK client and support machine are connected with OpenVPN using a very
>>>> simple p2p setup:
>>>>
>>>>   dev tap
>>>>   mode p2p
>>>>   cipher AES-256-CBC
>>>>   secret hlk.key
>>>>   remote <remote>
>>>>   verb 3
>>>>
>>>> In general the environment is working well, but the following tests are
>>>> failing consistently:
>>>>
>>>> ---
>>>>
>>>> NDISTest 6.0 - 1 Machine - 1c_FaultHandling
>>>>
>>>>   Test description:
>>>> <https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/82=
1954e1-dfdf-405f-8ee2-aae655551aa9>
>>>>
>>>>   Subtest: Run NDISTest Client -> StopDriver
>>>>
>>>>   Error:        Unable to stop driver
>>>>   Error Type:   NT_STATUS
>>>>   Error Code:   0x5473
>>>>   Error Text:   Error 0x00005473
>>>
>>> This seems to fail at "Copy downlevel NDISTest binaries", where the HLK
>>> client tries to grab some files from a Samba share on the HLK
>>> controller. It is probably that the UNC path it uses is not working as
>>> expected. I've also noticed that the HLK shares that are supposed to be
>>> readable to anyone may start asking for credentials for no particular
>>> reason. Anyways, I'll continue debugging this tomorrow as solving this
>>> would make two tests pass probably.
>>
>> This, and the "1c_Registry" test, are failing because test files the
>> tests need are truly missing from the HLK controller's SMB shares:
>>
>> <https://community.openvpn.net/openvpn/wiki/HLKTesting#NDISTest6.0-1mach=
ine-1c_FaultHandling>
>>
>> It seems that HLK controller software has been update recently, so I'll
>> try the new one. Hopefully the old test project does not get nuked in
>> the process...
>=20
> Updating the HLK controller and client software did not make the
> problems go way. Plus the old version was the correct one, according to
>=20
> https://docs.microsoft.com/en-us/windows-hardware/test/hlk/
>=20
> I would have opened a support case with Microsoft, but HLK support goes
> through usual MS support contracts, i.e. is a paid-for service. Which is
> silly given that this is possible that this is a bug in HLK itself.
>=20
> I'll ask if OpenVPN Inc. is some sort of Microsoft partner which would
> entitle me to filing a support request / bug report against HLK...
>=20
>>>> NDISTest 6.0 - 1 Machine - 1c_NdisRequestCov
>>>>
>>>>   Test description:
>>>> <https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/d0=
aaac5c-7c4c-488c-8352-14c49bc2ac67>
>>>>
>>>>   Subtest: Run NDISTest Client -> Restore protocol bindings
>>>>
>>>>   Error:        Unable to restore device settings at the end of the te=
st
>>>>   Error Type:   NT_STATUS
>>>>   Error Code:   0x15b38
>>>>   Error Text:   Error 0x00015b38
>>>>
>>>>
>>>> NDISTest 6.0 - 1 Machine - 1c_Registry
>>>>
>>>>   Test description:
>>>> <https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/30=
708719-0550-43d3-8a1e-797f758c61f3>
>>>>
>>>>   Subtest: Run NDISTest Client -> Testing MTU
>>>>
>>>>   Error:        Unable to stop driver.
>>>>   Error Type:   NT_STATUS
>>>>   Error Code:   0x15b38
>>>>   Error Text:   Error 0x00015b38
>>>>
>>>
>>> Same as above.
>>>
>>>> NDISTest 6.5 - 2 Machine - E2EPerf
>>>>
>>>>   Test description:
>>>> <https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/d1=
77b1d0-9ac2-4315-b493-74b14f318326>
>>>>
>>>>   Subtest: Run NDISTest Server -> [Sends 128K TCP] Analyzing Traffic r=
esults
>>>>
>>>>   Error: Traffic Stream 1 did not send long enough. Expected duration =
of
>>>> at least 40500ms. Actual duration 29766ms
>>>>   Error Type:   WIN32
>>>>   Error Code:   0x1
>>>>   Error Text:   Incorrect function.
>>>>
>>>>   The above error repeats three times (streams 1, 3 and 4).
>>>>
>>>>
>>>> Static Tools Logo Test
>>>>
>>>>   Test description:
>>>> <https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/6a=
b6df93-423c-4af6-ad48-8ea1049155ae>
>>>>
>>>>   Subtest: Run Test -> DevfundTests.DvlTest.DvlCheck
>>>>
>>>>   Error: DVL test failed:
>>>>          Microsoft.StaticToolsLogo.ObjectModel.DvlException:
>>>>          C:\dvl: the folder does not exist.
>>>>          at Microsoft.StaticToolsLogo.ObjectModel.DvlChecker.CheckDvl()
>>>>          at DevfundTests.DvlTest.DvlCheck()
>>>>   Error Type:
>>>>   Error Code:   0x0
>>>>   Error Text:   Error 0x00000000
>>>
>>> This seems resolveable based on documentation. Hopefully running the
>>> code analysis tool does not require setting up a Visual Studio project
>>> for tap-windows6...
>>>
>>>>
>>>>
>>>> Operate in Server Core
>>>>
>>>>   Fails because there is no Server Core HLK client yet
>>>>
>>>>
>>>> TDI filters and LSPs are not allowed
>>>>
>>>>   Test description:
>>>> <https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/15=
97d1fd-055a-43c7-b4c7-5396ab1ad525>
>>>>
>>>>   Subtest: HLK Config Library Tasks Per Test -> Copy TAEF Binaries
>>>>
>>>>   2980 4496 2019:5:31 18:48:18:184 Error: 0x8205aaaf, Error 0x8205aaaf
>>>>    winsockerror code of 11001   File=3Dsdktools\wtt
>>>>    \jobs\wtttransportproviders\wttcommtcpip\src\wttcommtcpip.cpp
>>>>    Line=3D656    PersistManager:EA:JobCancel::token::69M710T->
>>>>
>>>>
>>>> More detailed logs are generally available if somebody wants to have a
>>>> look. Just by making the "Stop driver" not fail two more tests would
>>>> pass. Some of tests are optional apparently[1], so passing all of them
>>>> is not necessary.
>>>
>>> This was caused by a glitch in network drive mappings and has been reso=
lved:
>>>
>>> <https://community.openvpn.net/openvpn/wiki/HLKTesting#TDIfiltersandLSP=
sarenotallowed>
>>>
>>
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>=20
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20



--B7fSJwoktIQSTx9M2wjIs1RaCG0swN04g--

--uaT6T78rzmJTY3gQoWnpd5OQHKnbegtRd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl0Lpu0ACgkQKVhNn0CG
RXixdAf/SNx6ieL+trHuhIuhJP5kdtLvXQaDMoKhA4k8TrH9BV4rHEHHJ5hOxpSY
DXCQRnTvSWbO6lTJRU9QQ2DcH0Wscgg6kcZMkpaATvztJOk6uCbxNik6u9FuMvRi
qzEtJWgLTaffIvXkgglkdtIpEdh3j9lxu9WPdAiybN8bnWCoXBEkOeVSFy5e3bMQ
MepqKpMYQ0wY+hdTU6Tv51Cp5HWNxe7OSSYPTeNex3PpgdNeVcoIrJvorwrXEuYv
oioO5M0UdN2WlU7bAfvOB1/SZNK8mBOZpV4JWDTUgcJhwU46fzEVnLh+/uwXWoAI
lFMWb+BzA0J5zOmHAevlrFLjgufIHw==
=3nOB
-----END PGP SIGNATURE-----

--uaT6T78rzmJTY3gQoWnpd5OQHKnbegtRd--

