From: Alberto Gonzalez Iniesta <agi@...64...>
Subject: Re: [Openvpn-devel] When the link used for openvpn goes down, the daemon hangs
Message-ID: <20041103200619.GA6275@...30...>
References: <20041102173519.GD1542@...30...> <Pine.LNX.4.58.0411031221430.17216@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0411031221430.17216@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Nov  3 12:12:28 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, Nov 03, 2004 at 12:24:15PM -0700, James Yonan wrote:
> On Tue, 2 Nov 2004, Alberto Gonzalez Iniesta wrote:
>=20
> > Hi again,
> >=20
> > Another bug report received in the Debian BTS [1]. Quoting:
> > |when the link which was used for openvpn transport goes down, it hangs
> > |in a D state
> > |
> > |root      2037  0.0  0.2  3376 1620 pts/1    D    10:45   0:04 openvpn
> > |
> > |and there is no way to kill it, I have to reboot. Other programs (eg.
> > |wavemon) can handle this situation more sanely.
>=20
> Any idea how to reproduce it?
>=20
> OpenVPN normally has no problem with intermittent links.

No idea, James. I wasn't able to reproduce it. I can unplug the ethernet
cable, ifconfig ethX down, but OpenVPN will not hang and it will recover
once the cable is back or the interface is up.

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.org

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

