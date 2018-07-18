References: <99D61A626FDA8A4B90A270669121BE10896FAF04@...2294...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c5fdad43-51e4-44d4-d038-e59192a8ef5c@...515...>
Date: Wed, 18 Jul 2018 12:40:01 +0300
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10896FAF04@...2294...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] TAP driver on Windows 2016 Server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>, "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

Il 14/07/2018 20:22, Simon Rozman ha scritto:
> Hi!
>=20
> Does anybody have some specific Windows 2016 Server release and build
> numbers from which on they require HLK certified driver? Or, do all Windo=
ws
> 2016 Server versions require HLK certified drivers from initial release o=
n?
>=20
> I am adding a detection logic to pack multiple TAP drivers in a single MSI
> and install only one conditionally - and would not like to reinvent the
> wheel.
>=20
> Best regards,
> Simon
>=20
>=20

Hi,

Greetings from my vacation!

In general Windows Server 2016 versions require HLK certified drivers.
Our old tap-windows6 driver works only because it fits Microsoft's
exceptions.

It would love to have automatic OS detection in the MSI. For official
releases we'd have two separate drivers (for now):

- For Windows Server 2016
  - Comes with MS signature based on HLK test results
- For Windows 7/8/10, Windows Server 2008r2 and 2012r2
  - Comes with dual signatures
    - Cross-signed for everything except recent Windows 10
    - Attestation signed for recent Windows 10

Getting a single driver that works across the board would prohibitively
expensive time- and money-vise. This is because we'd have to pass WLK,
HCR and HLK tests on pretty much every supported Windows version known
to man in every bitness.

So we need either auto-detection (=3Dbest) or separate installers. I will
do the latter for starters so that my vacation is not ruined. But soon
after we should switch to the MSI-based installer with OS- auto-detection.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

