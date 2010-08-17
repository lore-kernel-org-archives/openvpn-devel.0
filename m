Date: Tue, 17 Aug 2010 18:12:32 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20100817151232.GJ2804@...1281...>
References: <4C6869BA.3010309@...41...> <20100816132917.GM2804@...1281...>
	<20100816133454.GN2804@...1281...>
	<20100817145115.GI2804@...1281...>
MIME-Version: 1.0
In-Reply-To: <20100817145115.GI2804@...1281...>
Subject: Re: [Openvpn-devel] OpenVPN version 2.1.2 released /	tapinstall.exe
	fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 05:51:15PM +0300, Pasi K=E4rkk=E4inen wrote:
> On Mon, Aug 16, 2010 at 04:34:54PM +0300, Pasi K=E4rkk=E4inen wrote:
> > On Mon, Aug 16, 2010 at 04:29:17PM +0300, Pasi K=E4rkk=E4inen wrote:
> > >=20
> > > Hello,
> > >=20
> > > When running the openvpn 2.1.2 installer on Windows 7 (x64) I noticed=
 this error:
> > > http://pasik.reaktio.net/openvpn212-setup-error-opening-file-for-writ=
ing.jpg
> > >=20
> > > ie. the installer cannot overwrite the existing files from openvpn 2.=
1.1 installation.
> > > I get that error for the following files:
> > >=20
> > > C:\Program Files (x86)\OpenVPN\bin\openvpn-gui-1.0.3.exe
> > > C:\Program Files (x86)\OpenVPN\bin\libeay32.dll
> > >=20
> > > And after finishing the installation windows "Program Combatibility A=
ssistant" pops up,
> > > and asks if the program installed correctly, or if I wanted to "Reins=
tall using recommended settings".
> > >=20
> > > http://pasik.reaktio.net/openvpn212-setup-might-not-have-installed-co=
rrectly.jpg
> > >=20
> > > I chose it installed OK and then rebooted the machine.
> > >=20
> > > After reboot I noticed the TAP network device is missing from Windows,
> > > and thus openvpn connections cannot be started..
> > >=20
> > > Running the "Add a new TAP virtual ethernet adapter" doesn't seem to =
work either..
> > >=20
> >=20
> > And here's a screenshot of the failing tapinstall.exe:
> > http://pasik.reaktio.net/openvpn212-tapinstall-failed.jpg
> >=20
>=20
> Any tips how to troubleshoot this?=20
>

I just verified: openvpn 2.1.1 installs and works without problems on this =
win7 (x64) laptop.

no matter what I try openvpn 2.1.2 doesn't create the tap device..

I tried running the addtap.bat in various compatibility modes
but it just doesn't add the tap interface to windows..

executing addtap.bat with "run as administrator" makes it say it installs o=
k,
but in reality the tap interface is NOT added to windows.

-- Pasi


