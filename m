From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 1 Mar 2012 11:19:48 +0100
Message-ID: <7462163.ufeuZ1iJur@...1526...>
In-Reply-To: <1787326494.20120229201800@...449...>
References: <4F4CE4FE.3010009@...515...>
	<1957833067.20120229194040@...449...>
	<1787326494.20120229201800@...449...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
To: openvpn-devel@lists.sourceforge.net, Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>

On Wednesday 29 February 2012 19:18:00 Carsten Kr=FCger wrote:
> > If openvpn.exe startet in users context the user can manipulate it in
> > ram arbitrarily.
>=20
> Example:
> http://blog.didierstevens.com/2009/06/25/bpmtk-injecting-vbscript/
> (great blog about process manipulation :-) )

Took a look, neat tool. In the same blog the author mentions that integrity=
=20
levels, introduced in Vista, can be used to circumvent DLL injection. If th=
at=20
works out, all that is needed is the service increasing the tokens integrit=
y=20
level before starting openvpn and the user will have limited access to the=
=20
running openvpn process.

http://blog.didierstevens.com/2010/09/07/integrity-levels-and-dll-injection/

Of course this makes only sense if the ongoing discussion about whether=20
setting routes via --route config option comes to the conclusion "no". I'll=
=20
follow up to Fabian about that.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


