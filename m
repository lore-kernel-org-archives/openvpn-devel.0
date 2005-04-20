From: Alberto Gonzalez Iniesta <agi@...64...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
Message-ID: <20050420081401.GB2181@...30...>
References: <Pine.LNX.4.58.0504172223570.14131@...41...> <20050419173728.GA2126@...30...> <Pine.LNX.4.58.0504191224250.14131@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0504191224250.14131@...41...>
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
Date: Wed Apr 20 01:13:18 2005
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, Apr 19, 2005 at 12:32:20PM -0600, James Yonan wrote:
>=20
> On Tue, 19 Apr 2005, Alberto Gonzalez Iniesta wrote:
> >=20
> > And the second issue I don't know how to handle is this:
> > - Start openvpn multiple times for a certain configuration.
> > - After the first one is started, the rest will 'claim' to fail
> >   (due to port being in use), but they will leave a process running
> >   (one each).
> > - Even killing the first (successful) instance, the rest of the
> >   processes will remain aroundi (doing nothing, I guess.
>=20
> I can't reproduce this.

Sorry, James, my report was a little bogus. This was happening with one
of my configs. I have found the option that triggers this behavior:

openvpn --dev tap --port 9999 --daemon --plugin /usr/lib/openvpn/openvpn-au=
th-pam.so su

Regards,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

