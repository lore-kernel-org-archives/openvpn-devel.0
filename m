From: Alberto Gonzalez Iniesta <agi@...64...>
Subject: Re: [Openvpn-devel] Re: Fwd: openvpn config parsing
Message-ID: <20041222122700.GF1926@...30...>
References: <20041222100009.GE1926@...30...> <pan.2004.12.22.10.21.55.867168@...294...> <Pine.LNX.4.58.0412220435340.7923@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0412220435340.7923@...41...>
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
Date: Wed Dec 22 04:27:01 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, Dec 22, 2004 at 05:11:51AM -0700, James Yonan wrote:
> On Wed, 22 Dec 2004, Charles Duffy wrote:
>=20
> > On Wed, 22 Dec 2004 11:00:09 +0100, Alberto Gonzalez Iniesta wrote:
> > > Recent updates of openvpn appear to have changed the handling of
> > > whitespace in tls certificate names.
> >   ...
> > > Now it needs '_' not '.' for spaces:
> >=20
> > My guess is that this is a consequence of some string-handling changes
> > that were going on around 2.0-beta12 to 2.0-beta15.
>=20
> Yes, this is something that needs to be better documented.  Prior to
> 2.0-beta12, the string remapping code was a bit ad-hoc.  Since then I've
> tried to unify all string remapping towards a consistent model which
> remaps illegal chars to '_'.  The choice of underbar is arbitrary -- any
> inert character will do.

Thanks Charles & James, I'll document this in the Debian package README
file.


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.org

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

