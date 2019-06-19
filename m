From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <611691a5-e91c-c292-93f0-d70b40e35e03@...515...>
Date: Wed, 19 Jun 2019 13:50:02 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z4ft0KbUULFNvfA5zi4k8sWXAN9M2F07L"
Subject: [Openvpn-devel] Remaining tap-windows6 HLK test failures
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
--Z4ft0KbUULFNvfA5zi4k8sWXAN9M2F07L
Content-Type: multipart/mixed; boundary="CZau46H0eFwPlGtZtLnyftqlTdYxwjwEk";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <611691a5-e91c-c292-93f0-d70b40e35e03@...515...>
Subject: Remaining tap-windows6 HLK test failures

--CZau46H0eFwPlGtZtLnyftqlTdYxwjwEk
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi all,

Here's an update of the status of the tap-windows6 HLK tests, in the
hope that somebody can help figure out what is causing the remaining, so
far unknown[1], test failures. I'll look into these myself, but any
insights would be most welcome!

The HLK test environment is setup in the following way:

1) HLK controller
   - Virtualbox VM running Windows Server 2016 Evaluation
2) HLK client
   - Thinkcentre M710t (i7 with 4 physical processor cores)
   - Windows Server 2019 Evaluation (Desktop installation)
3) HLK support machine
   - Thinkpad T420
   - Windows Server 2019 Evaluation (Desktop installation)

HLK client and support machine are connected with OpenVPN using a very
simple p2p setup:

  dev tap
  mode p2p
  cipher AES-256-CBC
  secret hlk.key
  remote <remote>
  verb 3

In general the environment is working well, but the following tests are
failing consistently:

---

NDISTest 6.0 - 1 Machine - 1c_FaultHandling

  Test description:
<https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/821954e=
1-dfdf-405f-8ee2-aae655551aa9>

  Subtest: Run NDISTest Client -> StopDriver

  Error:        Unable to stop driver
  Error Type:   NT_STATUS
  Error Code:   0x5473
  Error Text:   Error 0x00005473


NDISTest 6.0 - 1 Machine - 1c_NdisRequestCov

  Test description:
<https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/d0aaac5=
c-7c4c-488c-8352-14c49bc2ac67>

  Subtest: Run NDISTest Client -> Restore protocol bindings

  Error:        Unable to restore device settings at the end of the test
  Error Type:   NT_STATUS
  Error Code:   0x15b38
  Error Text:   Error 0x00015b38


NDISTest 6.0 - 1 Machine - 1c_Registry

  Test description:
<https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/3070871=
9-0550-43d3-8a1e-797f758c61f3>

  Subtest: Run NDISTest Client -> Testing MTU

  Error:        Unable to stop driver.
  Error Type:   NT_STATUS
  Error Code:   0x15b38
  Error Text:   Error 0x00015b38


NDISTest 6.5 - 2 Machine - E2EPerf

  Test description:
<https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/d177b1d=
0-9ac2-4315-b493-74b14f318326>

  Subtest: Run NDISTest Server -> [Sends 128K TCP] Analyzing Traffic results

  Error: Traffic Stream 1 did not send long enough. Expected duration of
at least 40500ms. Actual duration 29766ms
  Error Type:   WIN32
  Error Code:   0x1
  Error Text:   Incorrect function.

  The above error repeats three times (streams 1, 3 and 4).


Static Tools Logo Test

  Test description:
<https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/6ab6df9=
3-423c-4af6-ad48-8ea1049155ae>

  Subtest: Run Test -> DevfundTests.DvlTest.DvlCheck

  Error: DVL test failed:
         Microsoft.StaticToolsLogo.ObjectModel.DvlException:
         C:\dvl: the folder does not exist.
         at Microsoft.StaticToolsLogo.ObjectModel.DvlChecker.CheckDvl()
         at DevfundTests.DvlTest.DvlCheck()
  Error Type:
  Error Code:   0x0
  Error Text:   Error 0x00000000


Operate in Server Core

  Fails because there is no Server Core HLK client yet


TDI filters and LSPs are not allowed

  Test description:
<https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/1597d1f=
d-055a-43c7-b4c7-5396ab1ad525>

  Subtest: HLK Config Library Tasks Per Test -> Copy TAEF Binaries

  2980 4496 2019:5:31 18:48:18:184 Error: 0x8205aaaf, Error 0x8205aaaf
   winsockerror code of 11001   File=3Dsdktools\wtt
   \jobs\wtttransportproviders\wttcommtcpip\src\wttcommtcpip.cpp
   Line=3D656    PersistManager:EA:JobCancel::token::69M710T->


More detailed logs are generally available if somebody wants to have a
look. Just by making the "Stop driver" not fail two more tests would
pass. Some of tests are optional apparently[1], so passing all of them
is not necessary.


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] <https://community.openvpn.net/openvpn/wiki/HLKTesting>


--CZau46H0eFwPlGtZtLnyftqlTdYxwjwEk--

--Z4ft0KbUULFNvfA5zi4k8sWXAN9M2F07L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl0KE1oACgkQKVhNn0CG
RXgDXAf/fxgCT8PsA7UR6+mRiiE2LTXvnKDk7xQKrBS95WMlJjeR9tgY/bq5UH88
cMghr3674YbZ8rmp9czsjpH/q+6s+LrXxdmtg5H5VRRVYFL4iNtmtdim4flgk+ua
k6/jjFdt+cXQu9Q9Rt3rr3mA7kJJkaRFeSo6g2qiyn7MG8zohBUZSs/DDqI0A0KE
L43kRCBpPoLqBJed4mVTbFmGStBkaByPN7Q1kfJBd1klEJr+Ghpy9yRiFPc/CMgE
/ZEvJPCJf3FnWFYjzF2gkipMEq4DD+oolKy0sNc++am98tTnAb7YUqahmaEv+T+T
2O4KM3xseMpE/wBtdkmgvbAbqLyHpg==
=ycX/
-----END PGP SIGNATURE-----

--Z4ft0KbUULFNvfA5zi4k8sWXAN9M2F07L--

