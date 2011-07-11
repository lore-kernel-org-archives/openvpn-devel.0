Date: Mon, 11 Jul 2011 16:16:27 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20110711131627.GX32373@...1281...>
References: <4BC5B0CF.4030607@...515...> <4BC8753B.8020405@...515...>
	<20100816084041.GZ2804@...1281...>
	<201008171343.58947.hhund@...194...>
MIME-Version: 1.0
In-Reply-To: <201008171343.58947.hhund@...194...>
Subject: Re: [Openvpn-devel] Finnish translation of OpenVPN-GUI for review
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
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Aug 17, 2010 at 01:43:33PM +0200, Heiko Hund wrote:
> On Monday 16 August 2010 10:40:41 Pasi K=E4rkk=E4inen wrote:
> > Does this snapshot fix any problems/bugs?
>=20
> Just the ones I come by. Try the latest version from=20
> http://sf.net/projects/openvpn-gui/files/ to see if it works better for y=
ou.
>=20

I could try this..

> > I'm often seeing problems with the gui icon on Windows 7 (64bit)..
> > sometimes (usually after suspend+resume of the laptop) the gui icon
> > stops responding, and I cannot stop the openvpn connection anymore..
>=20
> So the icon is still there, but a right-click does not pop up the menu=20
> anymore? Does the color of the icon reflect the current connection state?
>=20

Sorry for a really late reply..=20
I'm not sure if I remembered to reply to this email earlier.

Yeah, the icon is there, the icon color shows the connection state,
but it's "stuck" somehow.. nothing happens when you right-click on it.

It just happened again today, using openvpn 2.2.0.

To reproduce on win7 x64:
	- Start openvpn connection.
	- The icon goes green.
	- Suspend the laptop without disconnecting openvpn.
	- Wake up the laptop.
	- Openvpn-connection re-establishes,=20
	  but now the icon is unresponsive/deadlocked and you can't stop the conne=
ction from it.

To fix it:
	- Suspend/resume the laptop again, it *might* work then.
	- or reboot.


-- Pasi


