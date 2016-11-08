Date: Tue, 8 Nov 2016 22:02:13 +0100
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20161108210213.qntt5o6uiikkk4eg@...30...>
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<88fab532-d93c-e65b-a604-eacfb888da74@...277...>
	<196da459-e0aa-6ee9-b14e-786398ebd928@...2080...>
MIME-Version: 1.0
In-Reply-To: <196da459-e0aa-6ee9-b14e-786398ebd928@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
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
To: openvpn-devel@lists.sourceforge.net

On Tue, Nov 08, 2016 at 09:27:20PM +0100, David Sommerseth wrote:
> On 08/11/16 16:40, debbie10t wrote:
> > Hi,
> >=20
> > I now have these unit files working on all my test VMS.
> >=20
> > The only problem before was that on debian 8 these services failed to
> > start after reboot. (systemctl enable openvpn-{client/server}@config
> > was enabled) The error message was:
> > main process exited, code=3Dexited, status=3D233/RUNTIME_DIRECTORY
>=20
> It sounds like there's a conflict with a pre-existing directory.
>=20
> Do you have a chance to check if the stock openvpn version you had
> installed ships with a pre-created /var/run/openvpn directory?  (or
> /run/openvpn, or whatever Debian uses as the runtime directory)
>=20
> Otherwise, great testing!
>=20

The Debian package creates /run/openvpn/.
/var/run is a symlink to /run in Debian.


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

