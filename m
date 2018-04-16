References: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
From: fragmentux <fragmentux@...277...>
Message-ID: <3ed13a6a-07fd-3f0c-100c-148099bc8971@...277...>
Date: Mon, 16 Apr 2018 14:56:17 +0100
MIME-Version: 1.0
In-Reply-To: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
Content-Language: en-GB
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
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

I have successfully installed and am currently using this driver
on Windows 10 fully upto date.

Aside from the usual windblows crap (new layers of BS between *Programs=20
and Features and Network Connections .. you know what I mean) the
installation went smoothly.

However, some issues encountered:

* On first running my normal (unchanged) server config, openvpn bombed
out with "Cannot retrieve password" .. on second run the error was gone.
Tried uninstall/reinstall TAP driver and the same error did NOT occur.

* During install Windows asked "If i wanted to trust openvpn inc .."
to which I replied NO.  On the second install Windows did NOT ask "if
I wanted to trust openvpn inc." .. I don't know what that means ..
Perhaps, the install cert was installed anyway ?

HTH




On 16/04/18 08:20, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> We're bundling a tap-windows6 driver (9.21.3) with OpenVPN 2.4.6 that is
> due later this week:
>=20
> https://build.openvpn.net/downloads/temp/tap-windows-9.21.3-I601.exe
>=20
> The main difference to the old driver (9.21.2) is that the driver and
> installer have only a SHA2 Authenticode signature[*]. This means that
> Windows Vista should refuse to install the driver. Some outdated Windows
> 7 installations might behave the same. This is intentional on our part,
> as Vista is EOL and we don't want to support Windows 7 installations
> that are horribly outdated.
>=20
> I've tested installing this driver on Windows 7 Pro (64-bit) and Windows
> 2012r2 (64-bit) and I did not encounter any installation issues.
> However, I do not have access to Windows 8 or Windows 10, nor to 32-bit
> platforms.
>=20
> I would appreciate somebody could do additional driver installation
> tests. This would help build confidence in the driver before we push it
> out. Verifying that the driver installs fine is enough.
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

