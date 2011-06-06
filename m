Message-ID: <4DEC8E60.1000900@...515...>
Date: Mon, 06 Jun 2011 11:22:56 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <552C1CE8297C9A408B3F0EEE515F3F2C013D109D0442@...1464...>
In-Reply-To: <552C1CE8297C9A408B3F0EEE515F3F2C013D109D0442@...1464...>
Subject: Re: [Openvpn-devel] OemWin2k.inf specify network adapter name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Flaviano Maricotti <Flaviano.Maricotti@...1463...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
> Is it possibile to have the name of network adapter as "OpenVPN" instead =
of default "Local area network" ?
> I would like to automatize the installation without rename the "Local are=
a network".
> I can modify OemWin2k.inf or the winddk source of the driver.
>
> Thanks
>
> Software Department
> software@...1463...
>=20=20=20
Hi Flaviano,

I would take a look at the "tap-win32" directory and change the source
code or the OemWin2k.inf.in file. Building the modified TAP-driver is
probably easiest using the new Python-based buildsystem:

<https://community.openvpn.net/openvpn/wiki/BuildingOnWindows>

You will also need to sign the driver with signtool.exe or it will fail
to load on Windows Vista/7 64-bit.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


