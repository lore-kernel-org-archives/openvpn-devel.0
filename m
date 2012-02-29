From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 29 Feb 2012 11:16:27 +0100
Message-ID: <1671265.SLJ8CLno3T@...1526...>
In-Reply-To: <CAOazyz1Wcj8ap9niXMs5pPW=3TvfG75NW7L_eHV_9aGQNcWP6g@...278...>
References: <4F4CE4FE.3010009@...515...> <4F4D1C29.5060606@...1114...>
	<CAOazyz1Wcj8ap9niXMs5pPW=3TvfG75NW7L_eHV_9aGQNcWP6g@...278...>
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
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>, Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>

On Tuesday 28 February 2012 18:38:57 Alon Bar-Lev wrote:
> > Even though, the new communication pipe between the "helper service" and
> > openvpn.exe  might gain more features with time, which might cover much
> > of what the management interface provides today too.  But we're _not_
> > trying to kill the management interface.
>=20
> There is no need for the helper service.
> Nobody care if the openvpn daemon is running in privilege mode.
> The problem is the user interaction.
> So I would have avoided to invest resources at the daemon side and invest
> resources at proper UI.

The idea to have the service do the privileged operations instead of just=20
starting openvpn as "Local System" (or whatever) came from the fear of=20
privilege escalation in the scripts that are run by openvpn. So, at least I=
=20
care that it's not running in privilege mode. Your point is invalid. =3DP

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


